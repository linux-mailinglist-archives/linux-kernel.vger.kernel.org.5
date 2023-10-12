Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5B17C70A1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378971AbjJLOq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378887AbjJLOq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:46:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0031DC9;
        Thu, 12 Oct 2023 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697122015; x=1728658015;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4rvTgMVM5nKGOGCNlkMh5wCDk9d3vDveiDXE4mFhScU=;
  b=L+1CpnNMMK3uX4MeXfHlFWVk3IkezKEnuW7ypT2zHD1Q1wDVf2h3PMik
   zDhscCvh5vQnxrokTiQWeuC6SV5w46/KGA5pF2p3ydb0sJRgc/BquttrU
   RBm+g4S7vL6VzgYhY5GVlYtxxZWZYUvnLyI1eMhRV5rRQvSaL9KYq2qtR
   IYi/tZDMXYdG8fW23G5BVU8DZktHVOjYrkggIMlIiBtndT9Vm7DUTJWk8
   49cn8k3F9Ug1uEJ9D0CPK2tsDHESd1luvW18FYoSerT4HseXpV0kq8pe4
   xg2Xhl8yg7ktppWzYclsXDKtvweeHPCxjkX3s0yBosuJY/tvteW0AszpO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="383793018"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="383793018"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 07:46:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="1001563054"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="1001563054"
Received: from asroczyn-mobl.ger.corp.intel.com ([10.249.36.107])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 07:46:52 -0700
Date:   Thu, 12 Oct 2023 17:46:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V3 03/16] platform/x86/intel/vsec: Use cleanup.h
In-Reply-To: <20231012023840.3845703-4-david.e.box@linux.intel.com>
Message-ID: <114e1cc4-f129-b6cd-a83b-7d822cde178@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com> <20231012023840.3845703-4-david.e.box@linux.intel.com>
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

On Wed, 11 Oct 2023, David E. Box wrote:

> Use cleanup.h helpers to handle cleanup of resources in
> intel_vsec_add_dev() after failures.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V3 - New patch.
> 
>  drivers/platform/x86/intel/vsec.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index 15866b7d3117..f03ab89ab7c0 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -15,6 +15,7 @@
>  
>  #include <linux/auxiliary_bus.h>
>  #include <linux/bits.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/idr.h>
> @@ -155,10 +156,10 @@ EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, INTEL_VSEC);
>  static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *header,
>  			      struct intel_vsec_platform_info *info)
>  {
> -	struct intel_vsec_device *intel_vsec_dev;
> +	struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
>  	struct resource *res, *tmp;
>  	unsigned long quirks = info->quirks;
> -	int i;
> +	int ret, i;
>  
>  	if (!intel_vsec_supported(header->id, info->caps))
>  		return -EINVAL;
> @@ -178,10 +179,8 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
>  		return -ENOMEM;
>  
>  	res = kcalloc(header->num_entries, sizeof(*res), GFP_KERNEL);
> -	if (!res) {
> -		kfree(intel_vsec_dev);
> +	if (!res)
>  		return -ENOMEM;
> -	}
>  
>  	if (quirks & VSEC_QUIRK_TABLE_SHIFT)
>  		header->offset >>= TABLE_OFFSET_SHIFT;
> @@ -208,8 +207,12 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
>  	else
>  		intel_vsec_dev->ida = &intel_vsec_ida;
>  
> -	return intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
> -				  intel_vsec_name(header->id));
> +	ret = intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
> +				 intel_vsec_name(header->id));
> +
> +	no_free_ptr(intel_vsec_dev);
> +
> +	return ret;

So if intel_vsec_add_aux() returned an error, intel_vsec_dev won't be 
freed because of the call call to no_free_ptr() before return. I that's 
not what you intended?

-- 
 i.

