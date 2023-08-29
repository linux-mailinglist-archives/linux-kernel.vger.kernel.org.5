Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A827C78C7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjH2Oty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjH2Otw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:49:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8A3194;
        Tue, 29 Aug 2023 07:49:49 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RZqvx5ySzz6K63w;
        Tue, 29 Aug 2023 22:45:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 15:49:46 +0100
Date:   Tue, 29 Aug 2023 15:49:45 +0100
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
Subject: Re: [PATCH RFC v2 05/18] cxl/port: Add Dynamic Capacity mode
 support to endpoint decoders
Message-ID: <20230829154945.00002870@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-5-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-5-f740c47e7916@intel.com>
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

On Mon, 28 Aug 2023 22:20:56 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Endpoint decoders used to map Dynamic Capacity must be configured to
> point to the correct Dynamic Capacity (DC) Region.  The decoder mode
> currently represents the partition the decoder points to such as ram or
> pmem.
> 
> Expand the mode to include DC Regions.
> 
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

I'm reading this in a linear fashion for now (and ideally that should
always make sense) so I don't currently see the reason for the loops
in here. If they are needed for a future patch, add something to the
description to indicate that.

> 
> ---
> Changes for v2:
> [iweiny: split from region creation patch]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 19 ++++++++++---------
>  drivers/cxl/core/hdm.c                  | 24 ++++++++++++++++++++++++
>  drivers/cxl/core/port.c                 | 16 ++++++++++++++++
>  3 files changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 6350dd82b9a9..2268ffcdb604 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -257,22 +257,23 @@ Description:
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/mode
>  Date:		May, 2022
> -KernelVersion:	v6.0
> +KernelVersion:	v6.0, v6.6 (dcY)
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
>  		translates from a host physical address range, to a device local
>  		address range. Device-local address ranges are further split
> -		into a 'ram' (volatile memory) range and 'pmem' (persistent
> -		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
> -		'mixed', or 'none'. The 'mixed' indication is for error cases
> -		when a decoder straddles the volatile/persistent partition
> -		boundary, and 'none' indicates the decoder is not actively
> -		decoding, or no DPA allocation policy has been set.
> +		into a 'ram' (volatile memory) range, 'pmem' (persistent
> +		memory) range, or Dynamic Capacity (DC) range. The 'mode'
> +		attribute emits one of 'ram', 'pmem', 'dcY', 'mixed', or
> +		'none'. The 'mixed' indication is for error cases when a
> +		decoder straddles the volatile/persistent partition boundary,
> +		and 'none' indicates the decoder is not actively decoding, or
> +		no DPA allocation policy has been set.
>  
>  		'mode' can be written, when the decoder is in the 'disabled'
> -		state, with either 'ram' or 'pmem' to set the boundaries for the
> -		next allocation.
> +		state, with 'ram', 'pmem', or 'dcY' to set the boundaries for
> +		the next allocation.
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index a254f79dd4e8..3f4af1f5fac8 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -267,6 +267,19 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	__cxl_dpa_release(cxled);
>  }
>  
> +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> +{
> +	int index = 0;
> +
> +	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
As you are relying on them being in order and adjacent for the loop, why is

	if (mode < CXL_DECODER_DC0 || mode > CXL_DECODER_DC7)
		return -EINVAL;

	return mode - CXL_DECODER_DC0;

Not sufficient?

> +		if (mode == i)
> +			return index;
> +		index++;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			     resource_size_t base, resource_size_t len,
>  			     resource_size_t skipped)
> @@ -429,6 +442,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
>  	case CXL_DECODER_PMEM:
> +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
>  		break;
>  	default:
>  		dev_dbg(dev, "unsupported mode: %d\n", mode);
> @@ -456,6 +470,16 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  		goto out;
>  	}
>  
> +	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
> +		int index = dc_mode_to_region_index(i);
> +
> +		if (mode == i && !resource_size(&cxlds->dc_res[index])) {

Not obvious why we have the loop in this patch - perhaps it makes sense later.
If this is to enable later changes, then good to say that in the patch description.
otherwise, something like.

	int index;
	
	rc = dc_mode_to_region_index(i);
	if (rc < 0)
		goto out;

	index = rc;
	if (!resource_size(&cxlds->dc_res[index]) {
	....
		
	
	 	

> +			dev_dbg(dev, "no available dynamic capacity\n");
> +			rc = -ENXIO;
> +			goto out;
> +		}
> +	}
> +
>  	cxled->mode = mode;
>  	rc = 0;
>  out:
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f58cf01f8d2c..ce4a66865db3 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -197,6 +197,22 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>  		mode = CXL_DECODER_PMEM;
>  	else if (sysfs_streq(buf, "ram"))
>  		mode = CXL_DECODER_RAM;
> +	else if (sysfs_streq(buf, "dc0"))
> +		mode = CXL_DECODER_DC0;
> +	else if (sysfs_streq(buf, "dc1"))
> +		mode = CXL_DECODER_DC1;
> +	else if (sysfs_streq(buf, "dc2"))
> +		mode = CXL_DECODER_DC2;
> +	else if (sysfs_streq(buf, "dc3"))
> +		mode = CXL_DECODER_DC3;
> +	else if (sysfs_streq(buf, "dc4"))
> +		mode = CXL_DECODER_DC4;
> +	else if (sysfs_streq(buf, "dc5"))
> +		mode = CXL_DECODER_DC5;
> +	else if (sysfs_streq(buf, "dc6"))
> +		mode = CXL_DECODER_DC6;
> +	else if (sysfs_streq(buf, "dc7"))
> +		mode = CXL_DECODER_DC7;
>  	else
>  		return -EINVAL;
>  
> 

