Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3104B78DD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243805AbjH3Stt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243828AbjH3Luc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:50:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983E71B0;
        Wed, 30 Aug 2023 04:50:28 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbMyq6GGTz6HJcW;
        Wed, 30 Aug 2023 19:49:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 12:50:26 +0100
Date:   Wed, 30 Aug 2023 12:50:25 +0100
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
Subject: Re: [PATCH RFC v2 14/18] dax/region: Support DAX device creation on
 dynamic DAX regions
Message-ID: <20230830125025.00000fea@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-14-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-14-f740c47e7916@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Mon, 28 Aug 2023 22:21:05 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Dynamic Capacity (DC) DAX regions have a list of extents which define
> the memory of the region which is available.
> 
> Now that DAX region extents are fully realized support DAX device
> creation on dynamic regions by adjusting the allocation algorithms
> to account for the extents.  Remember also references must be held on
> the extents until the DAX devices are done with the memory.
> 
> Redefine the region available size to include only extent space.  Reuse
> the size allocation algorithm by defining sub-resources for each extent
> and limiting range allocation to those extents which have space.  Do not
> support direct mapping of DAX devices on dynamic devices.
> 
> Enhance DAX device range objects to hold references on the extents until
> the DAX device is destroyed.
> 
> NOTE: At this time all extents within a region are created equally.
> However, labels are associated with extents which can be used with
> future DAX device labels to group which extents are used.

This sound like a bad place to start to me as we are enabling something
that is probably 'wrong' in the long term as opposed to just not enabling it
until we have appropriate support.
I'd argue better to just reject any extents with different labels for now.

As this is an RFC meh ;)

Whilst this looks fine to me, I'm rather out of my depth wrt to the DAX
side of things so take that with a pinch of salt.

Jonathan


> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/dax/bus.c         | 157 +++++++++++++++++++++++++++++++++++++++-------
>  drivers/dax/cxl.c         |  44 +++++++++++++
>  drivers/dax/dax-private.h |   5 ++
>  3 files changed, 182 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index ea7ae82b4687..a9ea6a706702 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c

...


> @@ -1183,7 +1290,7 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
>  	to_alloc = range_len(&r);
>  	if (alloc_is_aligned(dev_dax, to_alloc))
>  		rc = alloc_dev_dax_range(&dax_region->res, dev_dax, r.start,
> -					 to_alloc);
> +					 to_alloc, NULL);
>  	device_unlock(dev);
>  	device_unlock(dax_region->dev);
>  
> @@ -1400,8 +1507,10 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
>  	device_initialize(dev);
>  	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
>  
> +	dev_WARN_ONCE(parent, is_dynamic(dax_region) && data->size,
> +		      "Dynamic DAX devices are created initially with 0 size");

dev_info() maybe more appropriate?   Is this common enough that we need the
_ONCE?


>  	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
> -				 data->size);
> +				 data->size, NULL);
>  	if (rc)
>  		goto err_range;
>  
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 44cbd28668f1..6394a3531e25 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
...


>  static int cxl_dax_region_create_extent(struct dax_region *dax_region,
>  					struct cxl_dr_extent *cxl_dr_ext)
>  {
> @@ -45,11 +80,20 @@ static int cxl_dax_region_create_extent(struct dax_region *dax_region,
>  	/* device manages the dr_extent on success */
>  	kref_init(&dr_extent->ref);
>  
> +	rc = dax_region_add_resource(dax_region, dr_extent,
> +				     cxl_dr_ext->hpa_offset,
> +				     cxl_dr_ext->hpa_length);
> +	if (rc) {
> +		kfree(dr_extent);

goto for these and single unwinding block?

> +		return rc;
> +	}
> +
>  	rc = dax_region_ext_create_dev(dax_region, dr_extent,
>  				       cxl_dr_ext->hpa_offset,
>  				       cxl_dr_ext->hpa_length,
>  				       cxl_dr_ext->label);
>  	if (rc) {
> +		dax_region_rm_resource(dr_extent);
>  		kfree(dr_extent);
as above.

>  		return rc;
>  	}
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index 250babd6e470..ad73b53aa802 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -44,12 +44,16 @@ struct dax_region {
>  /*
>   * struct dax_region_extent - extent data defined by the low level region
>   * driver.
> + * @region: cache of dax_region
> + * @res: cache of resource tree for this extent
>   * @private_data: lower level region driver data

Not sure 'lower level' is well defined here. Is "region driver data"
not enough?

>   * @ref: track number of dax devices which are using this extent
>   * @get: get reference to low level data
>   * @put: put reference to low level data
>   */
>  struct dax_region_extent {
> +	struct dax_region *region;
> +	struct resource *res;
>  	void *private_data;
>  	struct kref ref;
>  	void (*get)(struct dax_region_extent *dr_extent);
> @@ -131,6 +135,7 @@ struct dev_dax {
>  		unsigned long pgoff;
>  		struct range range;
>  		struct dax_mapping *mapping;
> +		struct dax_region_extent *dr_extent;

Huh. Seems that ranges is in the kernel doc but not the
bits that make that up.  Maybe good to add the docs
whilst here?

>  	} *ranges;
>  };
>  
> 

