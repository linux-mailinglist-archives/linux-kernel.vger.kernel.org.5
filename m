Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CCE776B36
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjHIVrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHIVry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:47:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92161702
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691617673; x=1723153673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lnLINdV+bftUae3cjpnQSCKjo87OUE1XQ+jB6inJzQI=;
  b=dkmRkxM/lH+vPOa9wlOrAfHKjLHOlwzkv+wIvEeh0yWjcyX20KJ2CzNL
   xD3Tefw2lRq246Dhf4v5HGAa0vZ4JOL6uI9zkqDmMF4nQU00dy8n/WZ2+
   732K5228MrZ4js8JR5XZ8WEULmgF2B1IuyUby2YdOCewirgmasnRcRSHm
   we/R/Xy3YTBkHGNtJbbREJF9IyxGGO8FWd/m97mghBcH/56MBDSbPyA/N
   3xqXbv4XMna9YrhyURI1oE7tnmB8ccZa84rS1FNfR1joJcHfIQ+3VyenN
   /M0BBczrW6Na0eo+gGt8BX6NIfgTrBO5HnWokGIY3HvghG4Y0zBYhh8WK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="457598564"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="457598564"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 14:47:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="761544892"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="761544892"
Received: from brentchi-mobl.amr.corp.intel.com (HELO desk) ([10.212.254.92])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 14:47:53 -0700
Date:   Wed, 9 Aug 2023 14:47:41 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/3] driver core: cpu: Unify redundant silly stubs
Message-ID: <20230809214741.n4k5rmnw7an4dfdr@desk>
References: <20230809102700.29449-1-bp@alien8.de>
 <20230809102700.29449-3-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809102700.29449-3-bp@alien8.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 12:26:59PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Make them all a weak function, aliasing to a single function which
> issues the "Not affected" string.
> 
> No functional changes.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  drivers/base/cpu.c | 86 ++++++++++------------------------------------
>  1 file changed, 18 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 52df435eecf8..971771347aa6 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -509,79 +509,29 @@ static void __init cpu_dev_register_generic(void)
>  }
>  
>  #ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
> -
> -ssize_t __weak cpu_show_meltdown(struct device *dev,
> -				 struct device_attribute *attr, char *buf)
> -{
> -	return sysfs_emit(buf, "Not affected\n");
> -}
> -
> -ssize_t __weak cpu_show_spectre_v1(struct device *dev,
> -				   struct device_attribute *attr, char *buf)
> -{
> -	return sysfs_emit(buf, "Not affected\n");
> -}
> -
> -ssize_t __weak cpu_show_spectre_v2(struct device *dev,
> -				   struct device_attribute *attr, char *buf)
> -{
> -	return sysfs_emit(buf, "Not affected\n");
> -}
> -
> -ssize_t __weak cpu_show_spec_store_bypass(struct device *dev,
> -					  struct device_attribute *attr, char *buf)
> -{
> -	return sysfs_emit(buf, "Not affected\n");
> -}
> -
> -ssize_t __weak cpu_show_l1tf(struct device *dev,
> -			     struct device_attribute *attr, char *buf)
> -{
> -	return sysfs_emit(buf, "Not affected\n");
> -}
> -
> -ssize_t __weak cpu_show_mds(struct device *dev,
> -			    struct device_attribute *attr, char *buf)
> -{
> -	return sysfs_emit(buf, "Not affected\n");
> -}
> -
> -ssize_t __weak cpu_show_tsx_async_abort(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> -{
> -	return sysfs_emit(buf, "Not affected\n");
> -}
> -
> -ssize_t __weak cpu_show_itlb_multihit(struct device *dev,
> -				      struct device_attribute *attr, char *buf)
> -{
> -	return sysfs_emit(buf, "Not affected\n");
> -}
> -
> -ssize_t __weak cpu_show_srbds(struct device *dev,
> +ssize_t cpu_show_not_affected(struct device *dev,
>  			      struct device_attribute *attr, char *buf)
>  {
>  	return sysfs_emit(buf, "Not affected\n");
>  }
>  
> -ssize_t __weak cpu_show_mmio_stale_data(struct device *dev,
> -					struct device_attribute *attr, char *buf)
> -{
> -	return sysfs_emit(buf, "Not affected\n");
> -}
> -
> -ssize_t __weak cpu_show_retbleed(struct device *dev,
> -				 struct device_attribute *attr, char *buf)
> -{
> -	return sysfs_emit(buf, "Not affected\n");
> -}
> -
> -ssize_t __weak cpu_show_spec_rstack_overflow(struct device *dev,
> -					     struct device_attribute *attr, char *buf)
> -{
> -	return sysfs_emit(buf, "Not affected\n");
> -}
> +#define CPU_VULN_FALLBACK(func)						\

Nit, its not actually a vulnerability fallback, does
CPU_SHOW_VULN_FALLBACK() sound better?

> +	ssize_t cpu_show_##func(struct device *,			\
> +				  struct device_attribute *, char *)	\
> +		 __attribute__((weak, alias("cpu_show_not_affected")))
> +
> +CPU_VULN_FALLBACK(meltdown);
> +CPU_VULN_FALLBACK(spectre_v1);
> +CPU_VULN_FALLBACK(spectre_v2);
> +CPU_VULN_FALLBACK(spec_store_bypass);
> +CPU_VULN_FALLBACK(l1tf);
> +CPU_VULN_FALLBACK(mds);
> +CPU_VULN_FALLBACK(tsx_async_abort);
> +CPU_VULN_FALLBACK(itlb_multihit);
> +CPU_VULN_FALLBACK(srbds);
> +CPU_VULN_FALLBACK(mmio_stale_data);
> +CPU_VULN_FALLBACK(retbleed);
> +CPU_VULN_FALLBACK(spec_rstack_overflow);
>  
>  ssize_t __weak cpu_show_gds(struct device *dev,
>  			    struct device_attribute *attr, char *buf)

Do you want me to send a separate patch for this?
