Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6AC78C84D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjH2PJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237152AbjH2PJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:09:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A481BD;
        Tue, 29 Aug 2023 08:09:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RZrM245X0z67qpK;
        Tue, 29 Aug 2023 23:05:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 16:09:20 +0100
Date:   Tue, 29 Aug 2023 16:09:19 +0100
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
Subject: Re: [PATCH RFC v2 06/18] cxl/port: Add Dynamic Capacity size
 support to endpoint decoders
Message-ID: <20230829160919.00007f69@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-6-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-6-f740c47e7916@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Mon, 28 Aug 2023 22:20:57 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> To support Dynamic Capacity Devices (DCD) endpoint decoders will need to
> map DC Regions (partitions).  Part of this is assigning the size of the
> DC Region DPA to the decoder in addition to any skip value from the
> previous decoder which exists.  This must be done within a continuous
> DPA space.  Two complications arise with Dynamic Capacity regions which
> did not exist with Ram and PMEM partitions.  First, gaps in the DPA
> space can exist between and around the DC Regions.  Second, the Linux
> resource tree does not allow a resource to be marked across existing
> nodes within a tree.
> 
> For clarity, below is an example of an 60GB device with 10GB of RAM,
> 10GB of PMEM and 10GB for each of 2 DC Regions.  The desired CXL mapping
> is 5GB of RAM, 5GB of PMEM, and all 10GB of DC1.
> 
>      DPA RANGE
>      (dpa_res)
> 0GB        10GB       20GB       30GB       40GB       50GB       60GB
> |----------|----------|----------|----------|----------|----------|
> 
> RAM         PMEM                  DC0                   DC1
>  (ram_res)  (pmem_res)            (dc_res[0])           (dc_res[1])
> |----------|----------|   <gap>  |----------|   <gap>  |----------|
> 
>  RAM        PMEM                                        DC1
> |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXXXXXXX|
> 0GB   5GB  10GB  15GB 20GB       30GB       40GB       50GB       60GB
> 
> The previous skip resource between RAM and PMEM was always a child of
> the RAM resource and fit nicely (see X below).  Because of this
> simplicity this skip resource reference was not stored in any CXL state.
> On release the skip range could be calculated based on the endpoint
> decoders stored values.
> 
> Now when DC1 is being mapped 4 skip resources must be created as
> children.  One of the PMEM resource (A), two of the parent DPA resource
> (B,D), and one more child of the DC0 resource (C).
> 
> 0GB        10GB       20GB       30GB       40GB       50GB       60GB
> |----------|----------|----------|----------|----------|----------|
>                            |                     |
> |----------|----------|    |     |----------|    |     |----------|
>         |          |       |          |          |
>        (X)        (A)     (B)        (C)        (D)
> 	v          v       v          v          v
> |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXXXXXXX|
>        skip       skip  skip        skip      skip
> 
> Expand the calculation of DPA freespace and enhance the logic to support
> mapping/unmapping DC DPA space.  To track the potential of multiple skip
> resources an xarray is attached to the endpoint decoder.  The existing
> algorithm is consolidated with the new one to store a single skip
> resource in the same way as multiple skip resources.
> 
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Various minor things noticed inline.

Jonathan

> 
> ---
> An alternative of using reserve_region_with_split() was considered.
> The advantage of that would be keeping all the resource information
> stored solely in the resource tree rather than having separate
> references to them.  However, it would best be implemented with a call
> such as release_split_region() [name TBD?] which could find all the leaf
> resources in the range and release them.  Furthermore, it is not clear
> if reserve_region_with_split() is really intended for anything outside
> of init code.  In the end this algorithm seems straight forward enough.
> 
> Changes for v2:
> [iweiny: write commit message]
> [iweiny: remove unneeded changes]
> [iweiny: split from region creation patch]
> [iweiny: Alter skip algorithm to use 'anonymous regions']
> [iweiny: enhance debug messages]
> [iweiny: consolidate skip resource creation]
> [iweiny: ensure xa_destroy() is called]
> [iweiny: consolidate region requests further]
> [iweiny: ensure resource is released on xa_insert]
> ---
>  drivers/cxl/core/hdm.c  | 188 +++++++++++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/core/port.c |   2 +
>  drivers/cxl/cxl.h       |   2 +
>  3 files changed, 176 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 3f4af1f5fac8..3cd048677816 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c


> +
> +static int cxl_reserve_dpa_skip(struct cxl_endpoint_decoder *cxled,
> +				resource_size_t base, resource_size_t skipped)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	resource_size_t skip_base = base - skipped;
> +	resource_size_t size, skip_len = 0;
> +	struct device *dev = &port->dev;
> +	int rc, index;
> +
> +	size = resource_size(&cxlds->ram_res);
> +	if (size && skip_base <= cxlds->ram_res.end) {

This size only used in this if statement I'd just put it inline.
 
> +		skip_len = cxlds->ram_res.end - skip_base + 1;
> +		rc = cxl_request_skip(cxled, skip_base, skip_len);
> +		if (rc)
> +			return rc;
> +		skip_base += skip_len;
> +	}
> +
> +	if (skip_base == base) {
> +		dev_dbg(dev, "skip done!\n");

Not sure that dbg is much help as other places below where skip also done...

> +		return 0;
> +	}
> +
> +	size = resource_size(&cxlds->pmem_res);
> +	if (size && skip_base <= cxlds->pmem_res.end) {

size only used in this if statement. I'd just put
the resource_size() bit inline.

> +		skip_len = cxlds->pmem_res.end - skip_base + 1;
> +		rc = cxl_request_skip(cxled, skip_base, skip_len);
> +		if (rc)
> +			return rc;
> +		skip_base += skip_len;
> +	}
> +
> +	index = dc_mode_to_region_index(cxled->mode);
> +	for (int i = 0; i <= index; i++) {
> +		struct resource *dcr = &cxlds->dc_res[i];
> +
> +		if (skip_base < dcr->start) {
> +			skip_len = dcr->start - skip_base;
> +			rc = cxl_request_skip(cxled, skip_base, skip_len);
> +			if (rc)
> +				return rc;
> +			skip_base += skip_len;
> +		}
> +
> +		if (skip_base == base) {
> +			dev_dbg(dev, "skip done!\n");

As above - perhaps some more info?

> +			break;
> +		}
> +
> +		if (resource_size(dcr) && skip_base <= dcr->end) {
> +			if (skip_base > base)
> +				dev_err(dev, "Skip error\n");

Not return ?  If there is a reason to carry on, I'd like a comment to say what it is.

> +
> +			skip_len = dcr->end - skip_base + 1;
> +			rc = cxl_request_skip(cxled, skip_base, skip_len);
> +			if (rc)
> +				return rc;
> +			skip_base += skip_len;
> +		}
> +	}
> +
> +	return 0;
> +}
> +


> @@ -492,11 +607,13 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
>  					 resource_size_t *start_out,
>  					 resource_size_t *skip_out)
>  {
> +	resource_size_t free_ram_start, free_pmem_start, free_dc_start;
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	resource_size_t free_ram_start, free_pmem_start;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct device *dev = &cxled->cxld.dev;

There is one existing (I think) call to dev_dbg(cxled_dev(cxled) ...
in this function.  So both should use that here, and should convert that one
case to using dev.

>  	resource_size_t start, avail, skip;
>  	struct resource *p, *last;
> +	int index;
>  
>  	lockdep_assert_held(&cxl_dpa_rwsem);
>  
> @@ -514,6 +631,20 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
>  	else
>  		free_pmem_start = cxlds->pmem_res.start;
>  
> +	/*
> +	 * Limit each decoder to a single DC region to map memory with
> +	 * different DSMAS entry.
> +	 */
> +	index = dc_mode_to_region_index(cxled->mode);
> +	if (index >= 0) {
> +		if (cxlds->dc_res[index].child) {
> +			dev_err(dev, "Cannot allocate DPA from DC Region: %d\n",
> +				index);
> +			return -EINVAL;
> +		}
> +		free_dc_start = cxlds->dc_res[index].start;
> +	}
> +
>  	if (cxled->mode == CXL_DECODER_RAM) {
>  		start = free_ram_start;
>  		avail = cxlds->ram_res.end - start + 1;
> @@ -535,6 +666,29 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
>  		else
>  			skip_end = start - 1;
>  		skip = skip_end - skip_start + 1;
> +	} else if (cxl_decoder_mode_is_dc(cxled->mode)) {
> +		resource_size_t skip_start, skip_end;
> +
> +		start = free_dc_start;
> +		avail = cxlds->dc_res[index].end - start + 1;
> +		if ((resource_size(&cxlds->pmem_res) == 0) || !cxlds->pmem_res.child)

Previous patch used !resource_size()
I prefer compare with 0 like you have here, but which ever is chosen, things should
be consistent.

...

