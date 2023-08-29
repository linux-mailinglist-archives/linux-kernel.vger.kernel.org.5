Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3D578C9CA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbjH2QlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbjH2QlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:41:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C8D198;
        Tue, 29 Aug 2023 09:40:57 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RZtNh3fGbz67ZCK;
        Wed, 30 Aug 2023 00:36:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 17:40:54 +0100
Date:   Tue, 29 Aug 2023 17:40:53 +0100
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
Subject: Re: [PATCH RFC v2 12/18] cxl/region: Notify regions of DC changes
Message-ID: <20230829174053.000008a1@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-12-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-12-f740c47e7916@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 22:21:03 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> In order for a user to use dynamic capacity effectively they need to
> know when dynamic capacity is available.  Thus when Dynamic Capacity
> (DC) extents are added or removed by a DC device the regions affected
> need to be notified.  Ultimately the DAX region uses the memory
> associated with DC extents.  However, remember that CXL DAX regions
> maintain any interleave details between devices.
> 
> When a DCD event occurs, iterate all CXL endpoint decoders and notify
> regions which contain the endpoints affected by the event.  In turn
> notify the DAX regions of the changes to the DAX region extents.
> 
> For now interleave is handled by creating simple 1:1 mappings between
> the CXL DAX region and DAX region layers.  Future implementations will
> need to resolve when to actually surface a DAX region extent and pass
> the notification along.
> 
> Remember that adding capacity is safe because there is no chance of the
> memory being in use.  Also remember at this point releasing capacity is
> straight forward because DAX devices do not yet have references to the
> extents.  Future patches will handle that complication.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

A few trivial comments on this.  Lot here so I'll take a closer look
at some point after doing a light pass over the rest of the series.





> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 80cffa40e91a..d3c4c9c87392 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -104,6 +104,55 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>  			 cxl_debugfs_poison_clear, "%llx\n");
>  
> +static int match_ep_decoder_by_range(struct device *dev, void *data)
> +{
> +	struct cxl_dc_extent_data *extent = data;
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;

blank line

> +	cxled = to_cxl_endpoint_decoder(dev);
> +	return cxl_dc_extent_in_ed(cxled, extent);
> +}
> +
> +static struct cxl_endpoint_decoder *cxl_find_ed(struct cxl_memdev_state *mds,
> +						struct cxl_dc_extent_data *extent)
> +{
> +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct device *dev;
> +
> +	dev = device_find_child(&endpoint->dev, extent,
> +				match_ep_decoder_by_range);
> +	if (!dev) {
> +		dev_dbg(mds->cxlds.dev, "Extent DPA:%llx LEN:%llx not mapped\n",
> +			extent->dpa_start, extent->length);
> +		return NULL;
> +	}
> +
> +	return to_cxl_endpoint_decoder(dev);
> +}
> +
> +static int cxl_mem_notify(struct device *dev, struct cxl_drv_nd *nd)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_dc_extent_data *extent;
> +	int rc = 0;
> +
> +	extent = nd->extent;
> +	dev_dbg(dev, "notify DC action %d DPA:%llx LEN:%llx\n",
> +		nd->event, extent->dpa_start, extent->length);
> +
> +	cxled = cxl_find_ed(mds, extent);
> +	if (!cxled)
> +		return 0;
Blank line.

> +	rc = cxl_ed_notify_extent(cxled, nd);
> +	put_device(&cxled->cxld.dev);
> +	return rc;
> +}
> +
>  static int cxl_mem_probe(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> @@ -247,6 +296,7 @@ __ATTRIBUTE_GROUPS(cxl_mem);
>  static struct cxl_driver cxl_mem_driver = {
>  	.name = "cxl_mem",
>  	.probe = cxl_mem_probe,
> +	.notify = cxl_mem_notify,
>  	.id = CXL_DEVICE_MEMORY_EXPANDER,
>  	.drv = {
>  		.dev_groups = cxl_mem_groups,
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 057b00b1d914..44cbd28668f1 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -59,6 +59,29 @@ static int cxl_dax_region_create_extent(struct dax_region *dax_region,
>  	return 0;
>  }
>  
> +static int cxl_dax_region_add_extent(struct cxl_dax_region *cxlr_dax,
> +				     struct cxl_dr_extent *cxl_dr_ext)
> +{

Why not have this helper in the earlier patch that introduced the code
this is factoring out?  Will reduce churn in the set whilst not much hurting
readability of that patch.

> +	/*
> +	 * get not zero is important because this is racing with the
> +	 * region driver which is racing with the memory device which
> +	 * could be removing the extent at the same time.
> +	 */
> +	if (cxl_dr_extent_get_not_zero(cxl_dr_ext)) {
> +		struct dax_region *dax_region;
> +		int rc;
> +
> +		dax_region = dev_get_drvdata(&cxlr_dax->dev);
> +		dev_dbg(&cxlr_dax->dev, "Creating HPA:%llx LEN:%llx\n",
> +			cxl_dr_ext->hpa_offset, cxl_dr_ext->hpa_length);
> +		rc = cxl_dax_region_create_extent(dax_region, cxl_dr_ext);
> +		cxl_dr_extent_put(cxl_dr_ext);
> +		if (rc)
> +			return rc;
> +	}
> +	return 0;
Perhaps flip logic
	if (!cxl_dr_extent_get_not_zero())
		return 0;

etc to reduce the code indent.
> +}
> +
>  static int cxl_dax_region_create_extents(struct cxl_dax_region *cxlr_dax)
>  {
>  	struct cxl_dr_extent *cxl_dr_ext;
> @@ -66,27 +89,68 @@ static int cxl_dax_region_create_extents(struct cxl_dax_region *cxlr_dax)
>  
>  	dev_dbg(&cxlr_dax->dev, "Adding extents\n");
>  	xa_for_each(&cxlr_dax->extents, index, cxl_dr_ext) {
> -		/*
> -		 * get not zero is important because this is racing with the
> -		 * region driver which is racing with the memory device which
> -		 * could be removing the extent at the same time.
> -		 */
> -		if (cxl_dr_extent_get_not_zero(cxl_dr_ext)) {
> -			struct dax_region *dax_region;
> -			int rc;
> -
> -			dax_region = dev_get_drvdata(&cxlr_dax->dev);
> -			dev_dbg(&cxlr_dax->dev, "Found OFF:%llx LEN:%llx\n",
> -				cxl_dr_ext->hpa_offset, cxl_dr_ext->hpa_length);
> -			rc = cxl_dax_region_create_extent(dax_region, cxl_dr_ext);
> -			cxl_dr_extent_put(cxl_dr_ext);
> -			if (rc)
> -				return rc;
> -		}
> +		int rc;
> +
> +		rc = cxl_dax_region_add_extent(cxlr_dax, cxl_dr_ext);
> +		if (rc)
> +			return rc;
>  	}
>  	return 0;
>  }
>  
> +static int match_cxl_dr_extent(struct device *dev, void *data)
> +{
> +	struct dax_reg_ext_dev *dr_reg_ext_dev;
> +	struct dax_region_extent *dr_extent;
> +
> +	if (!is_dr_ext_dev(dev))
> +		return 0;
> +
> +	dr_reg_ext_dev = to_dr_ext_dev(dev);
> +	dr_extent = dr_reg_ext_dev->dr_extent;
> +	return data == dr_extent->private_data;
> +}
> +
> +static int cxl_dax_region_rm_extent(struct cxl_dax_region *cxlr_dax,
> +				    struct cxl_dr_extent *cxl_dr_ext)
> +{
> +	struct dax_reg_ext_dev *dr_reg_ext_dev;
> +	struct dax_region *dax_region;
> +	struct device *dev;
> +
> +	dev = device_find_child(&cxlr_dax->dev, cxl_dr_ext,
> +				match_cxl_dr_extent);
> +	if (!dev)
> +		return -EINVAL;

blank line.

> +	dr_reg_ext_dev = to_dr_ext_dev(dev);
> +	put_device(dev);
> +	dax_region = dev_get_drvdata(&cxlr_dax->dev);
> +	dax_region_ext_del_dev(dax_region, dr_reg_ext_dev);
blank line

> +	return 0;
> +}
> +
> +static int cxl_dax_region_notify(struct device *dev,
> +				 struct cxl_drv_nd *nd)
> +{
> +	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
> +	struct cxl_dr_extent *cxl_dr_ext = nd->cxl_dr_ext;
> +	int rc = 0;
> +
> +	switch (nd->event) {
> +	case DCD_ADD_CAPACITY:
> +		rc = cxl_dax_region_add_extent(cxlr_dax, cxl_dr_ext);
> +		break;

Early returns in here will perhaps make this more readable and definitely
make it more compact.

> +	case DCD_RELEASE_CAPACITY:
> +	case DCD_FORCED_CAPACITY_RELEASE:
> +		rc = cxl_dax_region_rm_extent(cxlr_dax, cxl_dr_ext);
> +		break;
> +	default:
> +		dev_err(&cxlr_dax->dev, "Unknown DC event %d\n", nd->event);
> +		break;
> +	}
> +	return rc;
> +}
> +
>  static int cxl_dax_region_probe(struct device *dev)
>  {
>  	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
> @@ -134,6 +198,7 @@ static int cxl_dax_region_probe(struct device *dev)
>  static struct cxl_driver cxl_dax_region_driver = {
>  	.name = "cxl_dax_region",
>  	.probe = cxl_dax_region_probe,
> +	.notify = cxl_dax_region_notify,
>  	.id = CXL_DEVICE_DAX_REGION,
>  	.drv = {
>  		.suppress_bind_attrs = true,
