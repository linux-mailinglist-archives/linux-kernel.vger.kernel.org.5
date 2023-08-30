Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEBC78DCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241844AbjH3Sq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244048AbjH3MXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:23:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0D5CC5;
        Wed, 30 Aug 2023 05:23:40 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbNj61Wk1z6HJcm;
        Wed, 30 Aug 2023 20:22:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 13:23:36 +0100
Date:   Wed, 30 Aug 2023 13:23:35 +0100
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
Subject: Re: [PATCH RFC v2 18/18] tools/testing/cxl: Add Dynamic Capacity
 events
Message-ID: <20230830132335.0000162e@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-18-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-18-f740c47e7916@intel.com>
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

On Mon, 28 Aug 2023 22:21:09 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> OS software needs to be alerted when new extents arrive on a Dynamic
> Capacity Device (DCD).  On test DCDs extents are added through sysfs.
> 
> Add events on DCD extent injection.  Directly call the event irq
> callback to simulate irqs to process the test extents.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Trivial comments inline.

Reviewed-by: Jonathan.Cameron@huawei.com>

> ---
>  tools/testing/cxl/test/mem.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index d6041a2145c5..20364fee9df9 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -2008,6 +2008,41 @@ static bool new_extent_valid(struct device *dev, size_t new_start,
>  	return false;
>  }
>  
> +struct dcd_event_dyn_cap dcd_event_rec_template = {
> +	.hdr = {
> +		.id = UUID_INIT(0xca95afa7, 0xf183, 0x4018,
> +				0x8c, 0x2f, 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> +		.length = sizeof(struct dcd_event_dyn_cap),
> +	},
> +};
> +
> +static int send_dc_event(struct mock_event_store *mes, enum dc_event type,
> +			 u64 start, u64 length, const char *tag_str)

Arguably it's not sending the event, but rather adding it to the event log and
flicking the irq. So maybe naming needs some thought?

> +{
> +	struct device *dev = mes->mds->cxlds.dev;
> +	struct dcd_event_dyn_cap *dcd_event_rec;
> +
> +	dcd_event_rec = devm_kzalloc(dev, sizeof(*dcd_event_rec), GFP_KERNEL);
> +	if (!dcd_event_rec)
> +		return -ENOMEM;
> +
> +	memcpy(dcd_event_rec, &dcd_event_rec_template, sizeof(*dcd_event_rec));

devm_kmemdup?

> +	dcd_event_rec->data.event_type = type;
> +	dcd_event_rec->data.extent.start_dpa = cpu_to_le64(start);
> +	dcd_event_rec->data.extent.length = cpu_to_le64(length);
> +	memcpy(dcd_event_rec->data.extent.tag, tag_str,
> +	       min(sizeof(dcd_event_rec->data.extent.tag),
> +		   strlen(tag_str)));
> +
> +	mes_add_event(mes, CXL_EVENT_TYPE_DCD,
> +		      (struct cxl_event_record_raw *)dcd_event_rec);
> +
> +	/* Fake the irq */
> +	cxl_mem_get_event_records(mes->mds, CXLDEV_EVENT_STATUS_DCD);
> +
> +	return 0;
> +}
> +


