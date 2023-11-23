Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35537F5DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345022AbjKWL1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345075AbjKWL1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:27:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DAFB9;
        Thu, 23 Nov 2023 03:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700738841; x=1732274841;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Dpdbf3qu+kHyCzPBin8khrpCfZ/HN0JZ1Qw8Bvex67w=;
  b=NWC5MqjzuNs3iyJFV6xrada0QZZAz5SZuboClXEZSsX3C9hZp1FgC8pq
   M1LR9LmCEzLOKwUoaRDS72YDIrYaZFvPcKXeJHo8uhNgDRMBlUDwZvQE3
   MKKTOD0vNGL1zJ+gfJsea0Sbrgukj6ISSZoyFbVbkhbGiPY+bGL+jb12y
   RVWqdKotBMMi5Q2HPpws2S92D9O1NSYy2hS1FWVIaoj/9nht6kJe1wHnx
   HVmmm3G5sN68E7j9H3L4bPToKgfm4GRzCN3ovHwhIvLNnHmRhGTkoicTr
   objGTOCR5tIQfKC1ePr7yNqmuNWtCP++QqMFLi1BX1gKuxxQZyIdWXH43
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5440588"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="5440588"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 03:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="890765082"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="890765082"
Received: from mstrobel-mobl.ger.corp.intel.com ([10.252.40.70])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 03:27:19 -0800
Date:   Thu, 23 Nov 2023 13:27:09 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V5 01/20] platform/x86/intel/vsec: Fix xa_alloc memory
 leak
In-Reply-To: <20231123040355.82139-2-david.e.box@linux.intel.com>
Message-ID: <3d5f782e-6ce6-52c1-4cd1-b210768b5128@linux.intel.com>
References: <20231123040355.82139-1-david.e.box@linux.intel.com> <20231123040355.82139-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changelog is quite terse, please improve ;-).

Missing Fixes tag.

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

Can't order of xa_alloc() and ida_alloc() be reversed such that you don't 
need to do this double mutex dance?

-- 
 i.

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
>  }
>  EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, INTEL_VSEC);
> diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
> index 0fd042c171ba..0a6201b4a0e9 100644
> --- a/drivers/platform/x86/intel/vsec.h
> +++ b/drivers/platform/x86/intel/vsec.h
> @@ -45,6 +45,7 @@ struct intel_vsec_device {
>  	struct ida *ida;
>  	struct intel_vsec_platform_info *info;
>  	int num_resources;
> +	int id; /* xa */
>  	void *priv_data;
>  	size_t priv_data_size;
>  };
> 

