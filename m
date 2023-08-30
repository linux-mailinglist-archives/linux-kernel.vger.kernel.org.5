Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803FE78DB86
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbjH3Sji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243680AbjH3L1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:27:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD3C1B0;
        Wed, 30 Aug 2023 04:27:45 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbMNG5m90z6K6J8;
        Wed, 30 Aug 2023 19:22:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 12:27:42 +0100
Date:   Wed, 30 Aug 2023 12:27:41 +0100
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
Subject: Re: [PATCH RFC v2 13/18] dax/bus: Factor out dev dax resize logic
Message-ID: <20230830122741.00007628@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-13-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-13-f740c47e7916@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Mon, 28 Aug 2023 22:21:04 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Dynamic Capacity regions must limit dev dax resources to those areas
> which have extents backing real memory.  Four alternatives were
> considered to manage the intersection of region space and extents:
> 
> 1) Create a single region resource child on region creation which
>    reserves the entire region.  Then as extents are added punch holes in
>    this reservation.  This requires new resource manipulation to punch
>    the holes and still requires an additional iteration over the extent
>    areas which may already have existing dev dax resources used.
> 
> 2) Maintain an ordered xarray of extents which can be queried while
>    processing the resize logic.  The issue is that existing region->res
>    children may artificially limit the allocation size sent to
>    alloc_dev_dax_range().  IE the resource children can't be directly
>    used in the resize logic to find where space in the region is.
> 
> 3) Maintain a separate resource tree with extents.  This option is the
>    same as 2) but with a different data structure.  Most ideally we have
>    some unified representation of the resource tree.
> 
> 4) Create region resource children for each extent.  Manage the dax dev
>    resize logic in the same way as before but use a region child
>    (extent) resource as the parents to find space within each extent.
> 
> Option 4 can leverage the existing resize algorithm to find space within
> the extents.
> 
> In preparation for this change, factor out the dev_dax_resize logic.
> For static regions use dax_region->res as the parent to find space for
> the dax ranges.  Future patches will use the same algorithm with
> individual extent resources as the parent.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Hi Ira,

Some trivial comments on comments, but in general this indeed seems to be doing what you
say and factoring out the static allocation part.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/dax/bus.c | 128 +++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 79 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index b76e49813a39..ea7ae82b4687 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -817,11 +817,10 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
>  	return 0;
>  }
>  

> -static ssize_t dev_dax_resize(struct dax_region *dax_region,
> -		struct dev_dax *dev_dax, resource_size_t size)
> +/*

/**

Suitable builds will then check this doc matches the function etc
even if this is never included into any of the docs build.

> + * dev_dax_resize_static - Expand the device into the unused portion of the
> + * region. This may involve adjusting the end of an existing resource, or
> + * allocating a new resource.
> + *
> + * @parent: parent resource to allocate this range in.
> + * @dev_dax: DAX device we are creating this range for

Trivial: Doesn't seem to be consistent on . or not

> + * @to_alloc: amount of space to alloc; must be <= space available in @parent
> + *
> + * Return the amount of space allocated or -ERRNO on failure
> + */
> +static ssize_t dev_dax_resize_static(struct resource *parent,
> +				     struct dev_dax *dev_dax,
> +				     resource_size_t to_alloc)

