Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844597FEF29
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjK3MdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjK3MdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:33:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612C01B4;
        Thu, 30 Nov 2023 04:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701347607; x=1732883607;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=X9DUqCTYs2NSws6YB5I+N/M5vmT59fEYfpiJrfIeckQ=;
  b=WTcEhCzpf4hzD4unRDkb0h/bisTNvtp3yVEMiNspRrUkdSRHqjXhrlWx
   JfLImYpQLUT3AYh4KvFjskHni2menR/+vBbkMDBxURNCRFhUZdxr2+Ttf
   7zzdh7OVQ51kkJBBedFqQgcgLMOlUp3o/uGtkcEfJCxe4BalaDMCSg+kw
   FTC8Pg/OQ8u5kYSNT2pZnrHBxnRAjFxJHepuCE+2ttTtt/+t2rJmdKiPC
   vf4oA8AlF9H8bSCuHWSAEGZaYiSgvu637gIHIVOqMuEtFWCelJhOW9Kvk
   e5zF0wmNo7W5RKh2pErXifSxup/2WISilvS/lQHE82av8cCQjdQWj0twn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="396124006"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="396124006"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 04:33:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="10749085"
Received: from bergler-mobl.ger.corp.intel.com ([10.249.33.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 04:33:05 -0800
Date:   Thu, 30 Nov 2023 14:33:02 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] platform/x86/intel/tpmi: Add additional TPMI header
 fields
In-Reply-To: <20231128185605.3027653-2-srinivas.pandruvada@linux.intel.com>
Message-ID: <57956e96-449e-979e-dda0-fe1d1639f8a4@linux.intel.com>
References: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com> <20231128185605.3027653-2-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023, Srinivas Pandruvada wrote:

> TPMI information header added additional fields in version 2. Some of the
> reserved fields in version 1 are used to define new fields.
> Parse new fields and export as part of platform data. These fields include:
> - PCI segment ID
> - Partition ID of the package, useful when more than one Intel VSEC PCI
> device per package
> - cdie_mask: Mask of all compute dies in this partition
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/platform/x86/intel/tpmi.c | 11 ++++++++++-
>  include/linux/intel_tpmi.h        |  6 ++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
> index 311abcac894a..c89aa4d14bea 100644
> --- a/drivers/platform/x86/intel/tpmi.c
> +++ b/drivers/platform/x86/intel/tpmi.c
> @@ -128,6 +128,9 @@ struct intel_tpmi_info {
>   * @dev:	PCI device number
>   * @bus:	PCI bus number
>   * @pkg:	CPU Package id
> + * @segment: PCI segment id
> + * @partition: Package Partition id
> + * @cdie_mask: Bitmap of compute dies in the current partition
>   * @reserved:	Reserved for future use
>   * @lock:	When set to 1 the register is locked and becomes read-only
>   *		until next reset. Not for use by the OS driver.
> @@ -139,7 +142,10 @@ struct tpmi_info_header {
>  	u64 dev:5;
>  	u64 bus:8;
>  	u64 pkg:8;
> -	u64 reserved:39;
> +	u64 segment:8;
> +	u64 partition:2;
> +	u64 cdie_mask:16;
> +	u64 reserved:13;
>  	u64 lock:1;
>  } __packed;
> @@ -684,6 +690,9 @@ static int tpmi_process_info(struct intel_tpmi_info *tpmi_info,
>  	tpmi_info->plat_info.bus_number = header.bus;
>  	tpmi_info->plat_info.device_number = header.dev;
>  	tpmi_info->plat_info.function_number = header.fn;
> +	tpmi_info->plat_info.cdie_mask = header.cdie_mask;
> +	tpmi_info->plat_info.partition = header.partition;
> +	tpmi_info->plat_info.segment = header.segment;
>  
>  	iounmap(info_mem);
>  
> diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
> index ee07393445f9..939663bb095f 100644
> --- a/include/linux/intel_tpmi.h
> +++ b/include/linux/intel_tpmi.h
> @@ -14,7 +14,10 @@
>  
>  /**
>   * struct intel_tpmi_plat_info - Platform information for a TPMI device instance
> + * @cdie_mask:	Mask of all compute dies in the partition
>   * @package_id:	CPU Package id
> + * @partition:  Package partition id when multiple VSEC PCI devices per package
> + * @segment: PCI segment ID
>   * @bus_number:	PCI bus number
>   * @device_number: PCI device number
>   * @function_number: PCI function number
> @@ -23,7 +26,10 @@
>   * struct is used to return data via tpmi_get_platform_data().
>   */
>  struct intel_tpmi_plat_info {
> +	u16 cdie_mask;
>  	u8 package_id;
> +	u8 partition;
> +	u8 segment;
>  	u8 bus_number;
>  	u8 device_number;
>  	u8 function_number;

I've a number of questions about this patch...

- There no version check anywhere, yet commit message talks about v2?

- What will those fields have in v1?

- Entirely unrelated to the rest of this serie? So no users for these?
  Why not send this along with the patches containing the actual users
  so it'd have been easier to find the answers from the patches?

-- 
 i.

