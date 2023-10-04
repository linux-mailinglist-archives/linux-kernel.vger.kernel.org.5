Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234CB7B78F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbjJDHoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjJDHoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:44:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3201EA7;
        Wed,  4 Oct 2023 00:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696405467; x=1727941467;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HKyMyXXmNZTLZ/sWs9XnApS+uswItVk7HgUN/6QRBRI=;
  b=QJnpiGmQnIGaY1PwhAZU8mAnpeqNhCppbmq51OG8zQBIeXw1/5RIrvyf
   fh6DmaOrR0z70fhzpcYy9fxzKf7slp8nIHYai/42mgeDyP+1OzpLPTLiY
   RebEtSFPMe3mNtA3kjOaTUHux5IIUKjmP35uIDPc2joxweZJgH9ELc/+L
   q1xs4CglYcSZCEQeJ7gOiFh13fddURbf9vxPyTMrXkSQ+CJPAwZzZP2hJ
   hbaOyY4cNkCQE8WXxNCwhlzKoIGU0IYuSgIMixJcgryrk06CDo2sJos3r
   c/tW3QHGvLLDId8IXSti4IzYhWivjPOIfgnIUivy4wobhscm4dCcR94YI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="447262713"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="447262713"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 00:44:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="924990196"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="924990196"
Received: from cyrillet-mobl.ger.corp.intel.com ([10.252.55.203])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 00:44:25 -0700
Date:   Wed, 4 Oct 2023 10:44:23 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V2 03/13] platform/x86/intel/vsec: Add
 intel_vsec_register
In-Reply-To: <20231004020222.193445-4-david.e.box@linux.intel.com>
Message-ID: <3ae9ceaf-21f9-96c5-89a7-118e4c7340f8@linux.intel.com>
References: <20231004020222.193445-1-david.e.box@linux.intel.com> <20231004020222.193445-4-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023, David E. Box wrote:

> From: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> 
> Add and export intel_vsec_register() to allow the registration of Intel
> extended capabilities from other drivers. Add check to look for memory
> conflicts before registering a new capability. Add a parent field to
> intel_vsec_platform_info to allow specifying the parent device for
> device managed cleanup.
> 
> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V2 - New patch splitting previous PATCH 1
> 
>  drivers/platform/x86/intel/vsec.c | 21 ++++++++++++++++++++-
>  drivers/platform/x86/intel/vsec.h |  4 ++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index b14eba545770..c5d0202068cf 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -188,6 +188,15 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
>  			     header->offset + i * (header->entry_size * sizeof(u32));
>  		tmp->end = tmp->start + (header->entry_size * sizeof(u32)) - 1;
>  		tmp->flags = IORESOURCE_MEM;
> +
> +		/* Check resource is not in use */
> +		if (!request_mem_region(tmp->start, resource_size(tmp), "")) {
> +			kfree(res);
> +			kfree(intel_vsec_dev);
> +			return -EBUSY;

Convert this function to do proper rollback as there's already
kfree(intel_vsec_dev) above this one, or better yet, use the new cleanup 
thing if you know how to use it.

-- 
 i.


> +		}
> +
> +		release_mem_region(tmp->start, resource_size(tmp));
>  	}
>  
>  	intel_vsec_dev->pcidev = pdev;
> @@ -200,7 +209,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
>  	else
>  		intel_vsec_dev->ida = &intel_vsec_ida;
>  
> -	return intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
> +	return intel_vsec_add_aux(pdev, info->parent, intel_vsec_dev,
>  				  intel_vsec_name(header->id));
>  }
>  
> @@ -318,6 +327,16 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
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
