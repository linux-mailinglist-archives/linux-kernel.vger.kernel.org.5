Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA50A7D3A95
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjJWPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjJWPVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:21:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448C1110;
        Mon, 23 Oct 2023 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698074475; x=1729610475;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pdByTcU2UJYbHtQU12lGAmZaXicyoDyqZzukpOyjk54=;
  b=jirQYPJZpcPvTk5ifiotU/CcUAeFZR2sCWp2rZ3AvU7ck6GRLIoBsQ0J
   lWXdSyw52zZyhbobrAuKvD+lAbwXd3EU9CYeH00V9vzfZ1tp+AmssevmL
   UWKzVfb5sEiIEYcBYIcw1FsEDS8S6f2MKSQXOQTN5/BtUhCXR0bXl9CdK
   zDOl+TBt6ptnPtZGtpinyBQ9gIS4jEuPzk2IxL7Zi0hAENjah8kGd/5iH
   xbfNVwacxrBHBT54xSawMdPUE6p1A0lpyPWse7DCAuhzrPfGn70H8hQtp
   1EdTaT0UP8lWw4REIzoBH1kCjmBXbMmulvuTlUoXd+YQfgTtzxeVndKZs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384063253"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="384063253"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 08:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="6114576"
Received: from foliveix-mobl5.amr.corp.intel.com ([10.251.211.194])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 08:21:08 -0700
Date:   Mon, 23 Oct 2023 18:21:11 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V4 04/17] platform/x86/intel/vsec: Add
 intel_vsec_register
In-Reply-To: <20231018231624.1044633-5-david.e.box@linux.intel.com>
Message-ID: <991521f5-73c1-81f3-f721-15aac9c1d035@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com> <20231018231624.1044633-5-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023, David E. Box wrote:

Use () in the shortlog after the function name.

> From: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> 
> Add and export intel_vsec_register() to allow the registration of Intel
> extended capabilities from other drivers. Add check to look for memory
> conflicts before registering a new capability. Add a parent field to
> intel_vsec_platform_info to allow specifying the parent device for
> device managed cleanup.

While reviewing this patch, I couldn't understand why the parent is never 
assigned with anything?

> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V4 - Move res cleanup to previous patch
> 
> V3 - Replace kfree on request_mem_region fail with use of cleanup.h helper.
> 
> V2 - New patch splitting previous PATCH 1
> 
>  drivers/platform/x86/intel/vsec.c | 19 +++++++++++++++++--
>  drivers/platform/x86/intel/vsec.h |  4 ++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index 28191313d515..638dfde6a9e2 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -188,6 +188,12 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
>  			     header->offset + i * (header->entry_size * sizeof(u32));
>  		tmp->end = tmp->start + (header->entry_size * sizeof(u32)) - 1;
>  		tmp->flags = IORESOURCE_MEM;
> +
> +		/* Check resource is not in use */
> +		if (!request_mem_region(tmp->start, resource_size(tmp), ""))
> +			return -EBUSY;
> +
> +		release_mem_region(tmp->start, resource_size(tmp));
>  	}
>  
>  	intel_vsec_dev->pcidev = pdev;
> @@ -205,9 +211,8 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
>  	 * intel_vsec_add_aux()
>  	 */
>  	no_free_ptr(res);
> -	ret = intel_vsec_add_aux(pdev, NULL, no_free_ptr(intel_vsec_dev),
> +	ret = intel_vsec_add_aux(pdev, info->parent, no_free_ptr(intel_vsec_dev),
>  				 intel_vsec_name(header->id));
> -

Extra newline change.

-- 
 i.

>  	return ret;
>  }
>  
> @@ -325,6 +330,16 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
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
> index d3fefba3e623..a15fda2fcd28 100644
> --- a/drivers/platform/x86/intel/vsec.h
> +++ b/drivers/platform/x86/intel/vsec.h
> @@ -69,6 +69,7 @@ enum intel_vsec_quirks {
>  
>  /* Platform specific data */
>  struct intel_vsec_platform_info {
> +	struct device *parent;
>  	struct intel_vsec_header **headers;
>  	unsigned long caps;
>  	unsigned long quirks;
> @@ -98,4 +99,7 @@ static inline struct intel_vsec_device *auxdev_to_ivdev(struct auxiliary_device
>  {
>  	return container_of(auxdev, struct intel_vsec_device, auxdev);
>  }
> +
> +void intel_vsec_register(struct pci_dev *pdev,
> +			 struct intel_vsec_platform_info *info);
>  #endif
> 

