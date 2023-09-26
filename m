Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F607AEFD7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjIZPlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjIZPlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:41:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3BEEB;
        Tue, 26 Sep 2023 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695742852; x=1727278852;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cNGZStsRocJ7SIIvlLVzWYLUnRkdrSb+UUNvl78zl/U=;
  b=nK30+CmLlNsz3u3V7sLJg/PaPzXPRSsrRkAUPs9vKpWLSIJoaSLl1A4w
   v/A7rDlAmLTmp/jAo1kvt1G30LQblsLbZ3G4Zglvl3JZHHsWyjffirwOg
   PBN0QV4fJZi4c33QUcXGNQB4W32cKUxqWxsJN/6/S87peEu1PMHxs0tdL
   kGsM0xrHQqYA9C0RiFsNMF8iZZlasGk4IbPkFJpAFynE2kinHvbkcSERn
   AWO8i1CJgzkMKI4Cq3TGvdyGeNG3TnGLV+G4kDVKOm6zrtNnuLVL7e8vo
   e6ATuuWGPS6H71tMeaaGKOnP0egmNfuV+hb1AMEtWHIpT5bPEoMnTd+Fy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="360974584"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="360974584"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:40:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="778170666"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="778170666"
Received: from hhalmen-mobl.ger.corp.intel.com ([10.251.219.207])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:40:50 -0700
Date:   Tue, 26 Sep 2023 18:40:48 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH 04/11] platform/x86/intel/pmt: telemetry: Export API to
 read telemetry
In-Reply-To: <20230922213032.1770590-5-david.e.box@linux.intel.com>
Message-ID: <8fd2ab40-975f-768-57d7-f14fda99860@linux.intel.com>
References: <20230922213032.1770590-1-david.e.box@linux.intel.com> <20230922213032.1770590-5-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023, David E. Box wrote:

> Export symbols to allow access to Intel PMT Telemetry data on available
> devices. Provides APIs to search, register, and read telemetry using a
> kref managed pointer that serves as a handle to a telemetry endpoint.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmt/class.c     |  21 ++-
>  drivers/platform/x86/intel/pmt/class.h     |  14 ++
>  drivers/platform/x86/intel/pmt/telemetry.c | 198 ++++++++++++++++++++-
>  drivers/platform/x86/intel/pmt/telemetry.h | 129 ++++++++++++++
>  4 files changed, 354 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/pmt/telemetry.h
> 
> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
> index 142a24e3727d..4b53940a64e2 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -17,7 +17,7 @@
>  #include "../vsec.h"
>  #include "class.h"
>  
> -#define PMT_XA_START		0
> +#define PMT_XA_START		1

How is that related to what the changelog states, that is, exporting some 
API???

>  #define PMT_XA_MAX		INT_MAX
>  #define PMT_XA_LIMIT		XA_LIMIT(PMT_XA_START, PMT_XA_MAX)
>  #define GUID_SPR_PUNIT		0x9956f43f
> @@ -247,6 +247,7 @@ static int intel_pmt_dev_register(struct intel_pmt_entry *entry,
>  				  struct intel_pmt_namespace *ns,
>  				  struct device *parent)
>  {
> +	struct intel_vsec_device *ivdev = dev_to_ivdev(parent);
>  	struct resource res = {0};
>  	struct device *dev;
>  	int ret;
> @@ -270,7 +271,7 @@ static int intel_pmt_dev_register(struct intel_pmt_entry *entry,
>  	if (ns->attr_grp) {
>  		ret = sysfs_create_group(entry->kobj, ns->attr_grp);
>  		if (ret)
> -			goto fail_sysfs;
> +			goto fail_sysfs_create_group;
>  	}
>  
>  	/* if size is 0 assume no data buffer, so no file needed */
> @@ -295,13 +296,23 @@ static int intel_pmt_dev_register(struct intel_pmt_entry *entry,
>  	entry->pmt_bin_attr.size = entry->size;
>  
>  	ret = sysfs_create_bin_file(&dev->kobj, &entry->pmt_bin_attr);
> -	if (!ret)
> -		return 0;
> +	if (ret)
> +		goto fail_ioremap;
>  
> +	if (ns->pmt_add_endpoint) {
> +		ret = ns->pmt_add_endpoint(entry, ivdev->pcidev);
> +		if (ret)
> +			goto fail_add_endpoint;
> +	}
> +
> +	return 0;
> +
> +fail_add_endpoint:
> +	sysfs_remove_bin_file(entry->kobj, &entry->pmt_bin_attr);
>  fail_ioremap:
>  	if (ns->attr_grp)
>  		sysfs_remove_group(entry->kobj, ns->attr_grp);
> -fail_sysfs:
> +fail_sysfs_create_group:
>  	device_unregister(dev);
>  fail_dev_create:
>  	xa_erase(ns->xa, entry->devid);
> diff --git a/drivers/platform/x86/intel/pmt/class.h b/drivers/platform/x86/intel/pmt/class.h
> index e477a19f6700..d23c63b73ab7 100644
> --- a/drivers/platform/x86/intel/pmt/class.h
> +++ b/drivers/platform/x86/intel/pmt/class.h
> @@ -9,6 +9,7 @@
>  #include <linux/io.h>
>  
>  #include "../vsec.h"
> +#include "telemetry.h"
>  
>  /* PMT access types */
>  #define ACCESS_BARID		2
> @@ -18,6 +19,16 @@
>  #define GET_BIR(v)		((v) & GENMASK(2, 0))
>  #define GET_ADDRESS(v)		((v) & GENMASK(31, 3))
>  
> +struct pci_dev;
> +
> +struct telem_endpoint {
> +	struct pci_dev		*pcidev;
> +	struct telem_header	header;
> +	void __iomem		*base;
> +	bool			present;
> +	struct kref		kref;
> +};
> +
>  struct intel_pmt_header {
>  	u32	base_offset;
>  	u32	size;
> @@ -26,6 +37,7 @@ struct intel_pmt_header {
>  };
>  
>  struct intel_pmt_entry {
> +	struct telem_endpoint	*ep;
>  	struct intel_pmt_header	header;
>  	struct bin_attribute	pmt_bin_attr;
>  	struct kobject		*kobj;
> @@ -43,6 +55,8 @@ struct intel_pmt_namespace {
>  	const struct attribute_group *attr_grp;
>  	int (*pmt_header_decode)(struct intel_pmt_entry *entry,
>  				 struct device *dev);
> +	int (*pmt_add_endpoint)(struct intel_pmt_entry *entry,
> +				struct pci_dev *pdev);
>  };
>  
>  bool intel_pmt_is_early_client_hw(struct device *dev);
> diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
> index f86080e8bebd..8b099580cc2c 100644
> --- a/drivers/platform/x86/intel/pmt/telemetry.c
> +++ b/drivers/platform/x86/intel/pmt/telemetry.c
> @@ -30,6 +30,14 @@
>  /* Used by client hardware to identify a fixed telemetry entry*/
>  #define TELEM_CLIENT_FIXED_BLOCK_GUID	0x10000000
>  
> +#define NUM_BYTES_QWORD(v)	((v) << 3)
> +#define SAMPLE_ID_OFFSET(v)	((v) << 3)
> +
> +#define NUM_BYTES_DWORD(v)	((v) << 2)
> +#define SAMPLE_ID_OFFSET32(v)	((v) << 2)
> +
> +static DEFINE_MUTEX(ep_lock);
> +
>  enum telem_type {
>  	TELEM_TYPE_PUNIT = 0,
>  	TELEM_TYPE_CRASHLOG,
> @@ -84,21 +92,203 @@ static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
>  	return 0;
>  }
>  
> +static int pmt_telem_add_endpoint(struct intel_pmt_entry *entry,
> +				  struct pci_dev *pdev)
> +{
> +	struct telem_endpoint *ep;
> +
> +	/*
> +	 * Endpoint lifetimes are managed by kref, not devres.
> +	 */
> +	entry->ep = kzalloc(sizeof(*(entry->ep)), GFP_KERNEL);
> +	if (!entry->ep)
> +		return -ENOMEM;
> +
> +	ep = entry->ep;
> +	ep->pcidev = pdev;
> +	ep->header.access_type = entry->header.access_type;
> +	ep->header.guid = entry->header.guid;
> +	ep->header.base_offset = entry->header.base_offset;
> +	ep->header.size = entry->header.size;
> +	ep->base = entry->base;
> +	ep->present = true;
> +
> +	kref_init(&ep->kref);
> +
> +	return 0;
> +}
> +
>  static DEFINE_XARRAY_ALLOC(telem_array);
>  static struct intel_pmt_namespace pmt_telem_ns = {
>  	.name = "telem",
>  	.xa = &telem_array,
>  	.pmt_header_decode = pmt_telem_header_decode,
> +	.pmt_add_endpoint = pmt_telem_add_endpoint,
>  };
>  
> +/* Called when all users unregister and the device is removed */
> +static void pmt_telem_ep_release(struct kref *kref)
> +{
> +	struct telem_endpoint *ep;
> +
> +	ep = container_of(kref, struct telem_endpoint, kref);
> +	kfree(ep);
> +}
> +
> +/*
> + * driver api
> + */
> +int pmt_telem_get_next_endpoint(int start)
> +{
> +	struct intel_pmt_entry *entry;
> +	unsigned long found_idx;
> +
> +	mutex_lock(&ep_lock);
> +	xa_for_each_start(&telem_array, found_idx, entry, start) {
> +		/*
> +		 * Return first found index after start.
> +		 * 0 is not valid id.
> +		 */

I guess this has to do with the 0->1 change I flagged above. But if that's 
the case, it absolutely must be mentioned in the changelog with 
explanation!

> +		if (found_idx > start)
> +			break;
> +	}
> +	mutex_unlock(&ep_lock);
> +
> +	return found_idx == start ? 0 : found_idx;

Why you need signed values in/out? Should this function just be using 
unsigned int (or long) for start and return value?

> +}
> +EXPORT_SYMBOL_NS_GPL(pmt_telem_get_next_endpoint, INTEL_PMT_TELEMETRY);
> +
> +struct telem_endpoint *pmt_telem_register_endpoint(int devid)
> +{
> +	struct intel_pmt_entry *entry;
> +	unsigned long index = devid;
> +
> +	mutex_lock(&ep_lock);
> +	entry = xa_find(&telem_array, &index, index, XA_PRESENT);
> +	if (!entry) {
> +		mutex_unlock(&ep_lock);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	kref_get(&entry->ep->kref);
> +	mutex_unlock(&ep_lock);
> +
> +	return entry->ep;
> +}
> +EXPORT_SYMBOL_NS_GPL(pmt_telem_register_endpoint, INTEL_PMT_TELEMETRY);
> +
> +void pmt_telem_unregister_endpoint(struct telem_endpoint *ep)
> +{
> +	kref_put(&ep->kref, pmt_telem_ep_release);
> +}
> +EXPORT_SYMBOL_NS_GPL(pmt_telem_unregister_endpoint, INTEL_PMT_TELEMETRY);
> +
> +int pmt_telem_get_endpoint_info(int devid,
> +				struct telem_endpoint_info *info)
> +{
> +	struct intel_pmt_entry *entry;
> +	unsigned long index = devid;
> +	int err = 0;
> +
> +	if (!info)
> +		return -EINVAL;
> +
> +	mutex_lock(&ep_lock);
> +	entry = xa_find(&telem_array, &index, index, XA_PRESENT);
> +	if (!entry) {
> +		err = -ENXIO;
> +		goto unlock;
> +	}
> +
> +	info->pdev = entry->ep->pcidev;
> +	info->header = entry->ep->header;
> +
> +unlock:
> +	mutex_unlock(&ep_lock);
> +	return err;
> +
> +}
> +EXPORT_SYMBOL_NS_GPL(pmt_telem_get_endpoint_info, INTEL_PMT_TELEMETRY);
> +
> +int
> +pmt_telem_read(struct telem_endpoint *ep, u32 id, u64 *data, u32 count)
> +{
> +	u32 offset, size;
> +
> +	if (!ep->present)
> +		return -ENODEV;
> +
> +	offset = SAMPLE_ID_OFFSET(id);
> +	size = ep->header.size;
> +
> +	if ((offset + NUM_BYTES_QWORD(count)) > size)

Extra parenthesis.


-- 
 i.

> +		return -EINVAL;
> +
> +	memcpy_fromio(data, ep->base + offset, NUM_BYTES_QWORD(count));
> +
> +	return ep->present ? 0 : -EPIPE;
> +}
> +EXPORT_SYMBOL_NS_GPL(pmt_telem_read, INTEL_PMT_TELEMETRY);
> +
> +int
> +pmt_telem_read32(struct telem_endpoint *ep, u32 id, u32 *data, u32 count)
> +{
> +	u32 offset, size;
> +
> +	if (!ep->present)
> +		return -ENODEV;
> +
> +	offset = SAMPLE_ID_OFFSET32(id);
> +	size = ep->header.size;
> +
> +	if ((offset + NUM_BYTES_DWORD(count)) > size)
> +		return -EINVAL;
> +
> +	memcpy_fromio(data, ep->base + offset, NUM_BYTES_DWORD(count));
> +
> +	return ep->present ? 0 : -EPIPE;
> +}
> +EXPORT_SYMBOL_NS_GPL(pmt_telem_read32, INTEL_PMT_TELEMETRY);
> +
> +struct telem_endpoint *
> +pmt_telem_find_and_register_endpoint(struct pci_dev *pcidev, u32 guid, u16 pos)
> +{
> +	int devid = 0;
> +	int inst = 0;
> +	int err = 0;
> +
> +	while ((devid = pmt_telem_get_next_endpoint(devid))) {
> +		struct telem_endpoint_info ep_info;
> +
> +		err = pmt_telem_get_endpoint_info(devid, &ep_info);
> +		if (err)
> +			return ERR_PTR(err);
> +
> +		if (ep_info.header.guid == guid && ep_info.pdev == pcidev) {
> +			if (inst == pos)
> +				return pmt_telem_register_endpoint(devid);
> +			++inst;
> +		}
> +	}
> +
> +	return ERR_PTR(-ENXIO);
> +}
> +EXPORT_SYMBOL_NS_GPL(pmt_telem_find_and_register_endpoint, INTEL_PMT_TELEMETRY);
> +
>  static void pmt_telem_remove(struct auxiliary_device *auxdev)
>  {
>  	struct pmt_telem_priv *priv = auxiliary_get_drvdata(auxdev);
>  	int i;
>  
> -	for (i = 0; i < priv->num_entries; i++)
> -		intel_pmt_dev_destroy(&priv->entry[i], &pmt_telem_ns);
> -}
> +	mutex_lock(&ep_lock);
> +	for (i = 0; i < priv->num_entries; i++) {
> +		struct intel_pmt_entry *entry = &priv->entry[i];
> +
> +		kref_put(&entry->ep->kref, pmt_telem_ep_release);
> +		intel_pmt_dev_destroy(entry, &pmt_telem_ns);
> +	}
> +	mutex_unlock(&ep_lock);
> +};
>  
>  static int pmt_telem_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
>  {
> @@ -117,7 +307,9 @@ static int pmt_telem_probe(struct auxiliary_device *auxdev, const struct auxilia
>  	for (i = 0; i < intel_vsec_dev->num_resources; i++) {
>  		struct intel_pmt_entry *entry = &priv->entry[priv->num_entries];
>  
> +		mutex_lock(&ep_lock);
>  		ret = intel_pmt_dev_create(entry, &pmt_telem_ns, intel_vsec_dev, i);
> +		mutex_unlock(&ep_lock);
>  		if (ret < 0)
>  			goto abort_probe;
>  		if (ret)
> diff --git a/drivers/platform/x86/intel/pmt/telemetry.h b/drivers/platform/x86/intel/pmt/telemetry.h
> new file mode 100644
> index 000000000000..a8cd64330438
> --- /dev/null
> +++ b/drivers/platform/x86/intel/pmt/telemetry.h
> @@ -0,0 +1,129 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TELEMETRY_H
> +#define _TELEMETRY_H
> +
> +/* Telemetry types */
> +#define PMT_TELEM_TELEMETRY	0
> +#define PMT_TELEM_CRASHLOG	1
> +
> +struct telem_endpoint;
> +struct pci_dev;
> +
> +struct telem_header {
> +	u8	access_type;
> +	u16	size;
> +	u32	guid;
> +	u32	base_offset;
> +};
> +
> +struct telem_endpoint_info {
> +	struct pci_dev		*pdev;
> +	struct telem_header	header;
> +};
> +
> +/**
> + * pmt_telem_get_next_endpoint() - Get next device id for a telemetry endpoint
> + * @start:  starting devid to look from
> + *
> + * This functions can be used in a while loop predicate to retrieve the devid
> + * of all available telemetry endpoints. Functions pmt_telem_get_next_endpoint()
> + * and pmt_telem_register_endpoint() can be used inside of the loop to examine
> + * endpoint info and register to receive a pointer to the endpoint. The pointer
> + * is then usable in the telemetry read calls to access the telemetry data.
> + *
> + * Return:
> + * * devid       - devid of the next present endpoint from start
> + * * 0           - when no more endpoints are present after start
> + */
> +int pmt_telem_get_next_endpoint(int start);
> +
> +/**
> + * pmt_telem_register_endpoint() - Register a telemetry endpoint
> + * @devid: device id/handle of the telemetry endpoint
> + *
> + * Increments the kref usage counter for the endpoint.
> + *
> + * Return:
> + * * endpoint    - On success returns pointer to the telemetry endpoint
> + * * -ENXIO      - telemetry endpoint not found
> + */
> +struct telem_endpoint *pmt_telem_register_endpoint(int devid);
> +
> +/**
> + * pmt_telem_unregister_endpoint() - Unregister a telemetry endpoint
> + * @ep:   ep structure to populate.
> + *
> + * Decrements the kref usage counter for the endpoint.
> + */
> +void pmt_telem_unregister_endpoint(struct telem_endpoint *ep);
> +
> +/**
> + * pmt_telem_get_endpoint_info() - Get info for an endpoint from its devid
> + * @devid:  device id/handle of the telemetry endpoint
> + * @info:   Endpoint info structure to be populated
> + *
> + * Return:
> + * * 0           - Success
> + * * -ENXIO      - telemetry endpoint not found for the devid
> + * * -EINVAL     - @info is NULL
> + */
> +int pmt_telem_get_endpoint_info(int devid,
> +				struct telem_endpoint_info *info);
> +
> +/**
> + * pmt_telem_find_and_register_endpoint() - Get a telemetry endpoint from
> + * pci_dev device, guid and pos
> + * @pdev:   PCI device inside the Intel vsec
> + * @guid:   GUID of the telemetry space
> + * @pos:    Instance of the guid
> + *
> + * Return:
> + * * endpoint    - On success returns pointer to the telemetry endpoint
> + * * -ENXIO      - telemetry endpoint not found
> + */
> +struct telem_endpoint *pmt_telem_find_and_register_endpoint(struct pci_dev *pcidev,
> +				u32 guid, u16 pos);
> +
> +/**
> + * pmt_telem_read() - Read qwords from counter sram using sample id
> + * @ep:     Telemetry endpoint to be read
> + * @id:     The beginning sample id of the metric(s) to be read
> + * @data:   Allocated qword buffer
> + * @count:  Number of qwords requested
> + *
> + * Callers must ensure reads are aligned. When the call returns -ENODEV,
> + * the device has been removed and callers should unregister the telemetry
> + * endpoint.
> + *
> + * Return:
> + * * 0           - Success
> + * * -ENODEV	 - The device is not present.
> + * * -EINVAL     - The offset is out bounds
> + * * -EPIPE	 - The device was removed during the read. Data written
> + *		   but should be considered invalid.
> + */
> +int pmt_telem_read(struct telem_endpoint *ep, u32 id, u64 *data,
> +		   u32 count);
> +
> +/**
> + * pmt_telem_read32() - Read qwords from counter sram using sample id
> + * @ep:     Telemetry endpoint to be read
> + * @id:     The beginning sample id of the metric(s) to be read
> + * @data:   Allocated dword buffer
> + * @count:  Number of dwords requested
> + *
> + * Callers must ensure reads are aligned. When the call returns -ENODEV,
> + * the device has been removed and callers should unregister the telemetry
> + * endpoint.
> + *
> + * Return:
> + * * 0           - Success
> + * * -ENODEV	 - The device is not present.
> + * * -EINVAL     - The offset is out bounds
> + * * -EPIPE	 - The device was removed during the read. Data written
> + *		   but should be considered invalid.
> + */
> +int pmt_telem_read32(struct telem_endpoint *ep, u32 id, u32 *data,
> +		   u32 count);
> +
> +#endif
> 
