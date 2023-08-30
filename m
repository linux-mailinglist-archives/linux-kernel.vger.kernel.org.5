Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB378DED9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242731AbjH3TMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243904AbjH3MMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:12:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2F31B0;
        Wed, 30 Aug 2023 05:12:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbNMs5Hhtz6J7YY;
        Wed, 30 Aug 2023 20:07:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 13:11:48 +0100
Date:   Wed, 30 Aug 2023 13:11:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 16/18] tools/testing/cxl: Make event logs dynamic
Message-ID: <20230830131147.000034bc@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-16-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-16-f740c47e7916@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 22:21:07 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> The test event logs were created as static arrays as an easy way to mock
> events.  Dynamic Capacity Device (DCD) test support requires events be
> created dynamically when extents are created/destroyed.
> 
> Modify the event log storage to be dynamically allocated.  Thus they can
> accommodate the dynamic events required by DCD.  Reuse the static event
> data to create the dynamic events in the new logs without inventing
> complex event injection through the test sysfs.  Simplify the processing
> of the logs by using the event log array index as the handle.  Add a
> lock to manage concurrency to come with DCD extent testing.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Diff did a horrible job on readability of this patch.

Ah well. Comments superficial only.

Jonathan

> ---
>  tools/testing/cxl/test/mem.c | 276 ++++++++++++++++++++++++++-----------------
>  1 file changed, 170 insertions(+), 106 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 51be202fabd0..6a036c8d215d 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -118,18 +118,27 @@ static struct {
>  
>  #define PASS_TRY_LIMIT 3
>  
> -#define CXL_TEST_EVENT_CNT_MAX 15
> +#define CXL_TEST_EVENT_CNT_MAX 17
>  
>  /* Set a number of events to return at a time for simulation.  */
>  #define CXL_TEST_EVENT_CNT 3
>  
> +/*
> + * @next_handle: next handle (index) to be stored to
> + * @cur_handle: current handle (index) to be returned to the user on get_event
> + * @nr_events: total events in this log
> + * @nr_overflow: number of events added past the log size
> + * @lock: protect these state variables
> + * @events: array of pending events to be returned.
> + */
>  struct mock_event_log {
> -	u16 clear_idx;
> -	u16 cur_idx;
> +	u16 next_handle;
> +	u16 cur_handle;
>  	u16 nr_events;
>  	u16 nr_overflow;
> -	u16 overflow_reset;
> -	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
> +	rwlock_t lock;
> +	/* 1 extra slot to accommodate that handles can't be 0 */
> +	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX+1];

Spaces around +

>  };
>  

...


>  
> -static void cxl_mock_add_event_logs(struct mock_event_store *mes)
> +/* Create a dynamically allocated event out of a statically defined event. */
> +static void add_event_from_static(struct mock_event_store *mes,
> +				  enum cxl_event_log_type log_type,
> +				  struct cxl_event_record_raw *raw)
> +{
> +	struct device *dev = mes->mds->cxlds.dev;
> +	struct cxl_event_record_raw *rec;
> +
> +	rec = devm_kzalloc(dev, sizeof(*rec), GFP_KERNEL);
> +	if (!rec) {
> +		dev_err(dev, "Failed to alloc event for log\n");
> +		return;
> +	}
> +
> +	memcpy(rec, raw, sizeof(*rec));

devm_kmemdup()?


> +	mes_add_event(mes, log_type, rec);
> +}
> +
> +static void cxl_mock_add_event_logs(struct cxl_mockmem_data *mdata)
>  {
> +	struct mock_event_store *mes = &mdata->mes;
> +	struct device *dev = mes->mds->cxlds.dev;
> +
>  	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
>  			   &gen_media.validity_flags);
>  
> @@ -438,43 +475,60 @@ static void cxl_mock_add_event_logs(struct mock_event_store *mes)
>  			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN,
>  			   &dram.validity_flags);
>  
> -	mes_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
> -	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
> +	dev_dbg(dev, "Generating fake event logs %d\n",
> +		CXL_EVENT_TYPE_INFO);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_INFO,
>  		      (struct cxl_event_record_raw *)&gen_media);
> -	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
> +	add_event_from_static(mes, CXL_EVENT_TYPE_INFO,
>  		      (struct cxl_event_record_raw *)&mem_module);
>  	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
>  
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &maint_needed);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +	dev_dbg(dev, "Generating fake event logs %d\n",
> +		CXL_EVENT_TYPE_FAIL);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &maint_needed);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL,
> +		      (struct cxl_event_record_raw *)&mem_module);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL,
>  		      (struct cxl_event_record_raw *)&dram);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL,
>  		      (struct cxl_event_record_raw *)&gen_media);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL,
>  		      (struct cxl_event_record_raw *)&mem_module);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL,
>  		      (struct cxl_event_record_raw *)&dram);
>  	/* Overflow this log */
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
>  	mes->ev_status |= CXLDEV_EVENT_STATUS_FAIL;
>  
> -	mes_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FATAL,
> +	dev_dbg(dev, "Generating fake event logs %d\n",
> +		CXL_EVENT_TYPE_FATAL);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> +	add_event_from_static(mes, CXL_EVENT_TYPE_FATAL,
>  		      (struct cxl_event_record_raw *)&dram);
>  	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
>  }
>  
> +static void cxl_mock_event_trigger(struct device *dev)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	struct mock_event_store *mes = &mdata->mes;
> +
> +	cxl_mock_add_event_logs(mdata);
> +	cxl_mem_get_event_records(mes->mds, mes->ev_status);
> +}

