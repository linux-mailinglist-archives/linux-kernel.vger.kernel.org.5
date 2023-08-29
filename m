Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635C278C988
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbjH2QVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbjH2QUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:20:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEC0C9;
        Tue, 29 Aug 2023 09:20:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RZt1K0Mbsz67VcY;
        Wed, 30 Aug 2023 00:19:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 17:20:49 +0100
Date:   Tue, 29 Aug 2023 17:20:48 +0100
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
Subject: Re: [PATCH RFC v2 11/18] cxl/region: Expose DC extents on region
 driver load
Message-ID: <20230829172048.000006fb@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-11-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-11-f740c47e7916@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Mon, 28 Aug 2023 22:21:02 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Ultimately user space must associate Dynamic Capacity (DC) extents with
> DAX devices.  Remember also that DCD extents may have been accepted
> previous to regions being created and must have references held until
> all higher level regions and DAX devices are done with the memory.
> 
> On CXL region driver load scan existing device extents and create CXL
> DAX region extents as needed.
> 
> Create abstractions for the extents to be used in DAX region.  This
> includes a generic interface to take proper references on the lower
> level CXL region extents.
> 
> Also maintain separate objects for the DAX region extent device vs the
> DAX region extent.  The DAX region extent device has a shorter life span
> which corresponds to the removal of an extent while a DAX device is
> still using it.  In this case an extent continues to exist whilst the
> ability to create new DAX devices on that extent is prevented.
> 
> NOTE: Without interleaving; the device, CXL region, and DAX region
> extents have a 1:1:1 relationship.  Future support for interleaving will
> maintain a 1:N relationship between CXL region extents and the hardware
> extents.
> 
> While the ability to create DAX devices on an extent exists; expose the
> necessary details of DAX region extents by creating a device with the
> following sysfs entries.
> 
> /sys/bus/cxl/devices/dax_regionX/extentY
> /sys/bus/cxl/devices/dax_regionX/extentY/length
> /sys/bus/cxl/devices/dax_regionX/extentY/label
> 
> Label is a rough analogy to the DC extent tag.  As such the DC extent
> tag is used to initially populate the label.  However, the label is made
> writeable so that it can be adjusted in the future when forming a DAX
> device.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

Trivial stuff inline.



> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index 27cf2daaaa79..4dab52496c3f 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -5,6 +5,7 @@
>  #ifndef __DAX_PRIVATE_H__
>  #define __DAX_PRIVATE_H__
>  
> +#include <linux/pgtable.h>
>  #include <linux/device.h>
>  #include <linux/cdev.h>
>  #include <linux/idr.h>
> @@ -40,6 +41,58 @@ struct dax_region {
>  	struct device *youngest;
>  };
>  
> +/*
/**

as it's valid kernel doc so no disadvantage really.

> + * struct dax_region_extent - extent data defined by the low level region
> + * driver.
> + * @private_data: lower level region driver data
> + * @ref: track number of dax devices which are using this extent
> + * @get: get reference to low level data
> + * @put: put reference to low level data

I'd like to understand when these are optional - perhaps comment on that?

> + */
> +struct dax_region_extent {
> +	void *private_data;
> +	struct kref ref;
> +	void (*get)(struct dax_region_extent *dr_extent);
> +	void (*put)(struct dax_region_extent *dr_extent);
> +};
> +
> +static inline void dr_extent_get(struct dax_region_extent *dr_extent)
> +{
> +	if (dr_extent->get)
> +		dr_extent->get(dr_extent);
> +}
> +
> +static inline void dr_extent_put(struct dax_region_extent *dr_extent)
> +{
> +	if (dr_extent->put)
> +		dr_extent->put(dr_extent);
> +}
> +
> +#define DAX_EXTENT_LABEL_LEN 64

blank line here.

> +/**
> + * struct dax_reg_ext_dev - Device object to expose extent information
> + * @dev: device representing this extent
> + * @dr_extent: reference back to private extent data
> + * @offset: offset of this extent
> + * @length: size of this extent
> + * @label: identifier to group extents
> + */
> +struct dax_reg_ext_dev {
> +	struct device dev;
> +	struct dax_region_extent *dr_extent;
> +	resource_size_t offset;
> +	resource_size_t length;
> +	char label[DAX_EXTENT_LABEL_LEN];
> +};

