Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DBE7F6301
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346089AbjKWP2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346232AbjKWP2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:28:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4006A10F5;
        Thu, 23 Nov 2023 07:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700753248; x=1732289248;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=l8dcelsKzETRTjIVJYVStptG7enmi7tz5AG7PIw2WtA=;
  b=KzFaMzY2sBJrcLJ6vPpB07e/ShcnrV6X9ki6Vn12/cmivsiFOS8x/t6j
   ZkEOzoCtdtLm2kmvQbpBf9+HYHp89AKZwPQeOP3E+VkPoAQzv+21dspa/
   DjDVV316no8xrU+jJ+PB9VhjzoNDadgT9w/PUOBpEn0I3FzPOoMqFDhgE
   EcNumEp6eIIXGLAv8ojQ+YQqRYv2Y1gB5ZPJo6FnfwPX2NbSF9NIyf7fc
   GkjNl6agZzLlP9RmfrOpSQ3CfXGqFrJh3JmrTp5zVUirx1CsyGfrKcVfb
   k/lMJ+1aVMe75MKuM9+35Ybku4JzvzhiF+OYaz+gE//D40X95N8fwdtLv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396190659"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="396190659"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 07:27:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="15376681"
Received: from mstrobel-mobl.ger.corp.intel.com ([10.252.40.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 07:27:26 -0800
Date:   Thu, 23 Nov 2023 17:27:23 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V5 01/20] platform/x86/intel/vsec: Fix xa_alloc memory
 leak
In-Reply-To: <20231123040355.82139-2-david.e.box@linux.intel.com>
Message-ID: <52a6e750-71ed-b1d5-8693-2759be4cd6e5@linux.intel.com>
References: <20231123040355.82139-1-david.e.box@linux.intel.com> <20231123040355.82139-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023, David E. Box wrote:

> Fixes memory leak, caught be kmemleak, due to failure to erase auxiliary
> device entries from an xarray on removal.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V5 - New patch
> 
>  drivers/platform/x86/intel/vsec.c | 24 ++++++++++++++++--------
>  drivers/platform/x86/intel/vsec.h |  1 +
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index c1f9e4471b28..ae811bb65910 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -120,6 +120,8 @@ static void intel_vsec_dev_release(struct device *dev)
>  {
>  	struct intel_vsec_device *intel_vsec_dev = dev_to_ivdev(dev);
>  
> +	xa_erase(&auxdev_array, intel_vsec_dev->id);
> +
>  	mutex_lock(&vsec_ida_lock);
>  	ida_free(intel_vsec_dev->ida, intel_vsec_dev->auxdev.id);
>  	mutex_unlock(&vsec_ida_lock);
> @@ -136,9 +138,21 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
>  	int ret, id;
>  
>  	mutex_lock(&vsec_ida_lock);
> -	ret = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
> +	id = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
>  	mutex_unlock(&vsec_ida_lock);
> +	if (id < 0) {
> +		kfree(intel_vsec_dev->resource);
> +		kfree(intel_vsec_dev);
> +		return ret;
> +	}
> +
> +	ret = xa_alloc(&auxdev_array, &intel_vsec_dev->id, intel_vsec_dev,
> +		       PMT_XA_LIMIT, GFP_KERNEL);
>  	if (ret < 0) {
> +		mutex_lock(&vsec_ida_lock);
> +		ida_free(intel_vsec_dev->ida, id);
> +		mutex_unlock(&vsec_ida_lock);
> +
>  		kfree(intel_vsec_dev->resource);
>  		kfree(intel_vsec_dev);
>  		return ret;
> @@ -147,7 +161,7 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
>  	if (!parent)
>  		parent = &pdev->dev;
>  
> -	auxdev->id = ret;
> +	auxdev->id = id;
>  	auxdev->name = name;
>  	auxdev->dev.parent = parent;
>  	auxdev->dev.release = intel_vsec_dev_release;
> @@ -169,12 +183,6 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Add auxdev to list */
> -	ret = xa_alloc(&auxdev_array, &id, intel_vsec_dev, PMT_XA_LIMIT,
> -		       GFP_KERNEL);
> -	if (ret)
> -		return ret;
> -
>  	return 0;

BTW, there's also another unnecessary return construct around this which 
remains after this removal. The devm_add_Action_or_reset() value can be 
returned directly (maybe make another patch from that cleanup though 
since this is a Fixes patch).

-- 
 i.

