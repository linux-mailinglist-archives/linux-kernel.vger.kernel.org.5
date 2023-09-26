Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82B37AEEC0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjIZOTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjIZOTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:19:17 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 07:19:06 PDT
Received: from mgamail.intel.com (unknown [198.175.65.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04E210E;
        Tue, 26 Sep 2023 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695737947; x=1727273947;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tZezWUyWI/E+sECmaBnngNun38NOGr4Q7H/3fQV86jU=;
  b=j08Ib+05w23lMOFcP9t9Uj1v+4pcNFNhD0vG3cyyGkOVWtCLoYGcOQFD
   I42adpN1zRkjxWBXS+qqvajolMqGnV5FRX1WEBrG7fMJN50aQ6eqtTA+/
   aaj39BJgIA0t5Ee9uHN2hbZ0A6L1idhPQdw3pfxaefdSm02O1AKo82I2V
   cn1KipPUAswGbPebdIN3Re276NHCuacT+uGa1ShonRC7IQlO5/5dX+MaH
   G3f5Zb2sMh0wxZFDREPTD9f5qGZJUc9zCBGZ1bdfqAKeLmJeu/bcZx3Zr
   lzs7gxeEAEY+kToTGFnxZJ1+bXcDhT3DLgJHmoTJwgOa1Fzl9hQWUEcB9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="216959"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="216959"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 07:18:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="814493035"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="814493035"
Received: from hhalmen-mobl.ger.corp.intel.com ([10.251.219.207])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 07:18:02 -0700
Date:   Tue, 26 Sep 2023 17:17:59 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH 01/11] platform/x86/intel/vsec: Add intel_vsec_register
In-Reply-To: <20230922213032.1770590-2-david.e.box@linux.intel.com>
Message-ID: <1ed7ddc8-18a-cfbc-a4cd-baaa5751493e@linux.intel.com>
References: <20230922213032.1770590-1-david.e.box@linux.intel.com> <20230922213032.1770590-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023, David E. Box wrote:

> From: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> 
> Add and export intel_vsec_register() to allow the registration of Intel
> extended capabilities from other drivers. Add check to look for memory
> conflicts before registering a new capability.
> 
> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmt/class.c |  2 +-
>  drivers/platform/x86/intel/vsec.c      | 58 ++++++++++----------------
>  drivers/platform/x86/intel/vsec.h      | 42 ++++++++++++++++++-
>  3 files changed, 63 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
> index f32a233470de..2ad91d2fd954 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -31,7 +31,7 @@ bool intel_pmt_is_early_client_hw(struct device *dev)
>  	 * differences from the server platforms (which use the Out Of Band
>  	 * Management Services Module OOBMSM).
>  	 */
> -	return !!(ivdev->info->quirks & VSEC_QUIRK_EARLY_HW);
> +	return !!(ivdev->quirks & VSEC_QUIRK_EARLY_HW);
>  }
>  EXPORT_SYMBOL_NS_GPL(intel_pmt_is_early_client_hw, INTEL_PMT);
>  
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index c1f9e4471b28..c5d0202068cf 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -24,13 +24,6 @@
>  
>  #include "vsec.h"
>  
> -/* Intel DVSEC offsets */
> -#define INTEL_DVSEC_ENTRIES		0xA
> -#define INTEL_DVSEC_SIZE		0xB
> -#define INTEL_DVSEC_TABLE		0xC
> -#define INTEL_DVSEC_TABLE_BAR(x)	((x) & GENMASK(2, 0))
> -#define INTEL_DVSEC_TABLE_OFFSET(x)	((x) & GENMASK(31, 3))
> -#define TABLE_OFFSET_SHIFT		3
>  #define PMT_XA_START			0
>  #define PMT_XA_MAX			INT_MAX
>  #define PMT_XA_LIMIT			XA_LIMIT(PMT_XA_START, PMT_XA_MAX)
> @@ -39,34 +32,6 @@ static DEFINE_IDA(intel_vsec_ida);
>  static DEFINE_IDA(intel_vsec_sdsi_ida);
>  static DEFINE_XARRAY_ALLOC(auxdev_array);
>  
> -/**
> - * struct intel_vsec_header - Common fields of Intel VSEC and DVSEC registers.
> - * @rev:         Revision ID of the VSEC/DVSEC register space
> - * @length:      Length of the VSEC/DVSEC register space
> - * @id:          ID of the feature
> - * @num_entries: Number of instances of the feature
> - * @entry_size:  Size of the discovery table for each feature
> - * @tbir:        BAR containing the discovery tables
> - * @offset:      BAR offset of start of the first discovery table
> - */
> -struct intel_vsec_header {
> -	u8	rev;
> -	u16	length;
> -	u16	id;
> -	u8	num_entries;
> -	u8	entry_size;
> -	u8	tbir;
> -	u32	offset;
> -};
> -
> -enum intel_vsec_id {
> -	VSEC_ID_TELEMETRY	= 2,
> -	VSEC_ID_WATCHER		= 3,
> -	VSEC_ID_CRASHLOG	= 4,
> -	VSEC_ID_SDSI		= 65,
> -	VSEC_ID_TPMI		= 66,
> -};
> -
>  static const char *intel_vsec_name(enum intel_vsec_id id)
>  {
>  	switch (id) {
> @@ -223,19 +188,28 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
>  			     header->offset + i * (header->entry_size * sizeof(u32));
>  		tmp->end = tmp->start + (header->entry_size * sizeof(u32)) - 1;
>  		tmp->flags = IORESOURCE_MEM;
> +
> +		/* Check resource is not in use */
> +		if (!request_mem_region(tmp->start, resource_size(tmp), "")) {
> +			kfree(res);
> +			kfree(intel_vsec_dev);
> +			return -EBUSY;
> +		}
> +
> +		release_mem_region(tmp->start, resource_size(tmp));
>  	}
>  
>  	intel_vsec_dev->pcidev = pdev;
>  	intel_vsec_dev->resource = res;
>  	intel_vsec_dev->num_resources = header->num_entries;
> -	intel_vsec_dev->info = info;
> +	intel_vsec_dev->quirks = info->quirks;
>  
>  	if (header->id == VSEC_ID_SDSI)
>  		intel_vsec_dev->ida = &intel_vsec_sdsi_ida;
>  	else
>  		intel_vsec_dev->ida = &intel_vsec_ida;
>  
> -	return intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
> +	return intel_vsec_add_aux(pdev, info->parent, intel_vsec_dev,
>  				  intel_vsec_name(header->id));
>  }
>  
> @@ -353,6 +327,16 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
>  	return have_devices;
>  }
>  
> +void intel_vsec_register(struct pci_dev *pdev,
> +			 struct intel_vsec_platform_info *info)
> +{
> +	if (!pdev || !info)
> +		return;
> +
> +	intel_vsec_walk_header(pdev, info);
> +}
> +EXPORT_SYMBOL_NS_GPL(intel_vsec_register, INTEL_VSEC);
> +
>  static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct intel_vsec_platform_info *info;
> diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
> index 0fd042c171ba..ab0f161f86c5 100644
> --- a/drivers/platform/x86/intel/vsec.h
> +++ b/drivers/platform/x86/intel/vsec.h
> @@ -11,9 +11,45 @@
>  #define VSEC_CAP_SDSI		BIT(3)
>  #define VSEC_CAP_TPMI		BIT(4)
>  
> +/* Intel DVSEC offsets */
> +#define INTEL_DVSEC_ENTRIES		0xA
> +#define INTEL_DVSEC_SIZE		0xB
> +#define INTEL_DVSEC_TABLE		0xC
> +#define INTEL_DVSEC_TABLE_BAR(x)	((x) & GENMASK(2, 0))
> +#define INTEL_DVSEC_TABLE_OFFSET(x)	((x) & GENMASK(31, 3))
> +#define TABLE_OFFSET_SHIFT		3
> +
>  struct pci_dev;
>  struct resource;
>  
> +enum intel_vsec_id {
> +	VSEC_ID_TELEMETRY	= 2,
> +	VSEC_ID_WATCHER		= 3,
> +	VSEC_ID_CRASHLOG	= 4,
> +	VSEC_ID_SDSI		= 65,
> +	VSEC_ID_TPMI		= 66,
> +};
> +
> +/**
> + * struct intel_vsec_header - Common fields of Intel VSEC and DVSEC registers.
> + * @rev:	Revision ID of the VSEC/DVSEC register space
> + * @length:	Length of the VSEC/DVSEC register space
> + * @id:		ID of the feature
> + * @num_entries:Number of instances of the feature
> + * @entry_size:	Size of the discovery table for each feature
> + * @tbir:	BAR containing the discovery tables
> + * @offset:	BAR offset of start of the first discovery table
> + */
> +struct intel_vsec_header {
> +	u8	rev;
> +	u16	length;
> +	u16	id;
> +	u8	num_entries;
> +	u8	entry_size;
> +	u8	tbir;
> +	u32	offset;
> +};
> +
>  enum intel_vsec_quirks {
>  	/* Watcher feature not supported */
>  	VSEC_QUIRK_NO_WATCHER	= BIT(0),
> @@ -33,6 +69,7 @@ enum intel_vsec_quirks {
>  
>  /* Platform specific data */
>  struct intel_vsec_platform_info {
> +	struct device *parent;
>  	struct intel_vsec_header **headers;
>  	unsigned long caps;
>  	unsigned long quirks;
> @@ -43,10 +80,10 @@ struct intel_vsec_device {
>  	struct pci_dev *pcidev;
>  	struct resource *resource;
>  	struct ida *ida;
> -	struct intel_vsec_platform_info *info;
>  	int num_resources;
>  	void *priv_data;
>  	size_t priv_data_size;
> +	unsigned long quirks;
>  };
>  
>  int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
> @@ -62,4 +99,7 @@ static inline struct intel_vsec_device *auxdev_to_ivdev(struct auxiliary_device
>  {
>  	return container_of(auxdev, struct intel_vsec_device, auxdev);
>  }
> +
> +void intel_vsec_register(struct pci_dev *pdev,
> +			 struct intel_vsec_platform_info *info);
>  #endif
> 

Please split this patch properly. I see at least 3 components (some of 
which were not even mentioned in the changelog):

- Moving enum, struct & defines (no functional changes intended patch)
- Moving quirks to new place
- The rest

-- 
 i.

