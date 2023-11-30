Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9507FED79
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345081AbjK3LC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjK3LCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:02:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1051E10E5;
        Thu, 30 Nov 2023 03:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701342151; x=1732878151;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c7oz0UEaAq0Ujr9AK7uExxzrAyiLZa8EboDA/OApfNE=;
  b=jStqfFGdclGLXaGE5aSnQKB6PFyxGjqPPTeIF0oBPTp0qnwDIb5nfL6T
   OPnh0myMfGXft6JndKG/L2fYGPqvLnZGh5F3qdvprBlfQz7omHVycpv4O
   yIzwG92DxKjZ93qFiJrACOIAbBVG75DJ4ePxEpuf3D/AaNe5zb7uOuBDf
   XzriP1SUzcR9Y6vLVUvhZ7qXkmFIROMHrErFeRtBaFdFyQ1LneMejgJxx
   3hPK3BIVNIXihJY9eRCRs3WRgBPl2WBVOlCJwDexQKBi0RyC+EaQX260q
   1LLr/fhjWgD8snNCGFHS0VmuHQxg8OA4cpA8E3rYHAdpZtLdI4GdrGClv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="392172392"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="392172392"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 03:02:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="745596790"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="745596790"
Received: from bergler-mobl.ger.corp.intel.com ([10.249.33.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 03:02:27 -0800
Date:   Thu, 30 Nov 2023 13:02:24 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V6 01/20] platform/x86/intel/vsec: Fix xa_alloc memory
 leak
In-Reply-To: <20231129222132.2331261-2-david.e.box@linux.intel.com>
Message-ID: <5c21230-1176-4168-f31f-a0c1f1713ca8@linux.intel.com>
References: <20231129222132.2331261-1-david.e.box@linux.intel.com> <20231129222132.2331261-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2128018015-1701342149=:1808"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2128018015-1701342149=:1808
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 29 Nov 2023, David E. Box wrote:

> Commit 936874b77dd0 ("platform/x86/intel/vsec: Add PCI error recovery
> support to Intel PMT") added an xarray to track the list of vsec devices to
> be recovered after a PCI error. But it did not provide cleanup for the list
> leading to a memory leak that was caught by kmemleak.  Do xa_alloc() before
> devm_add_action_or_reset() so that the list may be cleaned up with
> xa_erase() in the release function.
> 
> Fixes: 936874b77dd0 ("platform/x86/intel/vsec: Add PCI error recovery support to Intel PMT")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> 
> V6 - Move xa_alloc() before ida_alloc() to reduce mutex use during error
>      recovery.
>    - Fix return value after id_alloc() fail
>    - Add Fixes tag
>    - Add more detail to changelog
> 
> V5 - New patch
> 
>  drivers/platform/x86/intel/vsec.c | 24 ++++++++++++++----------
>  drivers/platform/x86/intel/vsec.h |  1 +
>  2 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index c1f9e4471b28..2d568466b4e2 100644
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
> @@ -135,19 +137,27 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
>  	struct auxiliary_device *auxdev = &intel_vsec_dev->auxdev;
>  	int ret, id;
>  
> -	mutex_lock(&vsec_ida_lock);
> -	ret = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
> -	mutex_unlock(&vsec_ida_lock);
> +	ret = xa_alloc(&auxdev_array, &intel_vsec_dev->id, intel_vsec_dev,
> +		       PMT_XA_LIMIT, GFP_KERNEL);
>  	if (ret < 0) {
>  		kfree(intel_vsec_dev->resource);
>  		kfree(intel_vsec_dev);
>  		return ret;
>  	}
>  
> +	mutex_lock(&vsec_ida_lock);
> +	id = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
> +	mutex_unlock(&vsec_ida_lock);
> +	if (id < 0) {
> +		kfree(intel_vsec_dev->resource);
> +		kfree(intel_vsec_dev);
> +		return id;

Thanks, this looks much better this way around but it is missing 
xa_alloc() rollback now that the order is reversed.

Once that is fixed,

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-2128018015-1701342149=:1808--
