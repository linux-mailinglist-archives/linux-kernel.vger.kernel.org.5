Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FFA78E042
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343945AbjH3T0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244044AbjH3MUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:20:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE489CC5;
        Wed, 30 Aug 2023 05:20:40 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbNdg5rsbz6HJdJ;
        Wed, 30 Aug 2023 20:19:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 13:20:38 +0100
Date:   Wed, 30 Aug 2023 13:20:37 +0100
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
Subject: Re: [PATCH RFC v2 17/18] tools/testing/cxl: Add DC Regions to mock
 mem data
Message-ID: <20230830132037.00005348@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-17-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-17-f740c47e7916@intel.com>
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

On Mon, 28 Aug 2023 22:21:08 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> To test DC regions the mock memory devices will need to store
> information about the regions and manage fake extent data.
> 
> Define mock_dc_region information within the mock memory data.  Add
> sysfs entries on the mock device to inject and delete extents.
> 
> The inject format is <start>:<length>:<tag>
> The delete format is <start>
> 
> Add DC mailbox commands to the CEL and implement those commands.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks fine to me.  Totally trivial comment inline.

FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> +
>  static int mock_gsl(struct cxl_mbox_cmd *cmd)
>  {
>  	if (cmd->size_out < sizeof(mock_gsl_payload))
> @@ -1315,6 +1429,148 @@ static int mock_activate_fw(struct cxl_mockmem_data *mdata,
>  	return -EINVAL;
>  }
>  

Bit inconsistent on whether there are one or two blank lines between functions.

> +static int mock_get_dc_config(struct device *dev,
> +			      struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_get_dc_config *dc_config = cmd->payload_in;
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	u8 region_requested, region_start_idx, region_ret_cnt;
> +	struct cxl_mbox_dynamic_capacity *resp;
> +
> +	region_requested = dc_config->region_count;
> +	if (NUM_MOCK_DC_REGIONS < region_requested)
> +		region_requested = NUM_MOCK_DC_REGIONS;
> +
> +	if (cmd->size_out < struct_size(resp, region, region_requested))
> +		return -EINVAL;
> +
> +	memset(cmd->payload_out, 0, cmd->size_out);
> +	resp = cmd->payload_out;
> +
> +	region_start_idx = dc_config->start_region_index;
> +	region_ret_cnt = 0;
> +	for (int i = 0; i < NUM_MOCK_DC_REGIONS; i++) {
> +		if (i >= region_start_idx) {
> +			memcpy(&resp->region[region_ret_cnt],
> +				&mdata->dc_regions[i],
> +				sizeof(resp->region[region_ret_cnt]));
> +			region_ret_cnt++;
> +		}
> +	}
> +	resp->avail_region_count = region_ret_cnt;
> +
> +	dev_dbg(dev, "Returning %d dc regions\n", region_ret_cnt);
> +	return 0;
> +}


