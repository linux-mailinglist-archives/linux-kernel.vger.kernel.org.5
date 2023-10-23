Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81737D3A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjJWPQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjJWPQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:16:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A9DFD;
        Mon, 23 Oct 2023 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698074162; x=1729610162;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0YaGt4PogPOyXc9eKQtxsUb6I+hoSZBtR9QsLM3nwbc=;
  b=OEvaJ6y+f8UI5rH/Y1H/3cuyPHeXTuGQX2G2wKxdupklR/JPfxkH90jg
   c6Pdfe1ovPHw3cYE2HtTPfJkWpwI8oufamZnP+PaQP3v47DXX6AEkvcbC
   XN0FPrejA1GrHJ/vgvNsjE6xGRnxJdv4iXoTUSVMAgyezEU7oaGR3fKP0
   4/JUJof8EcsIMYVpRpaUh+RrTtHwVTdEciYZryLRXHpedO38Ox3ZG8kX8
   JkepbuR54NrTlCen/YDSYJhxJdujvy0SFvJDuSNqf8NGf1bQUnOhaQZ7b
   6YoXXYDXocKVdFAB4HK3LBhl2ucTYQSusUGgaGynoduQI9CrooFJafkQA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384061950"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="384061950"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 08:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="758160305"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="758160305"
Received: from foliveix-mobl5.amr.corp.intel.com ([10.251.211.194])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 08:15:59 -0700
Date:   Mon, 23 Oct 2023 18:15:51 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V4 03/17] platform/x86/intel/vsec: Use cleanup.h
In-Reply-To: <20231018231624.1044633-4-david.e.box@linux.intel.com>
Message-ID: <a06ab9b-4530-2196-14a2-7d78972c5b3@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com> <20231018231624.1044633-4-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-691496953-1698074160=:1721"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-691496953-1698074160=:1721
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 18 Oct 2023, David E. Box wrote:

> Use cleanup.h helpers to handle cleanup of resources in
> intel_vsec_add_dev() after failures.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V4 - Do no_free_ptr() before and in call to intel_vsec_add_aux().
>    - Add resource cleanup in this patch.
> 
> V3 - New patch.
> 
>  drivers/platform/x86/intel/vsec.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index b14eba545770..28191313d515 100644
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
> @@ -147,10 +148,11 @@ EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, INTEL_VSEC);
>  static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *header,
>  			      struct intel_vsec_platform_info *info)
>  {
> -	struct intel_vsec_device *intel_vsec_dev;
> -	struct resource *res, *tmp;
> +	struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
> +	struct resource __free(kfree) *res = NULL;
> +	struct resource *tmp;
>  	unsigned long quirks = info->quirks;
> -	int i;
> +	int ret, i;
>  
>  	if (!intel_vsec_supported(header->id, info->caps))
>  		return -EINVAL;
> @@ -170,10 +172,8 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
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
> @@ -200,8 +200,15 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
>  	else
>  		intel_vsec_dev->ida = &intel_vsec_ida;
>  
> -	return intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
> -				  intel_vsec_name(header->id));
> +	/*
> +	 * Pass the ownership of intel_vsec_dev and resource within it to
> +	 * intel_vsec_add_aux()
> +	 */
> +	no_free_ptr(res);
> +	ret = intel_vsec_add_aux(pdev, NULL, no_free_ptr(intel_vsec_dev),
> +				 intel_vsec_name(header->id));
> +
> +	return ret;

This looks good other than you don't need to add the ret variable at all. 
After changing that, please add:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-691496953-1698074160=:1721--
