Return-Path: <linux-kernel+bounces-118155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BBD88B513
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A0C29186C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A8282D67;
	Mon, 25 Mar 2024 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nm6kcQHQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02A757E3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408396; cv=none; b=UWHLcHDCgDYdG9ibLAIG0p4Zz30FarVL51IwytPYVmFB2dhfuALF6wWPtlb+2hbntMSKxMA4PKTwePQ0Bthyz7jm4cldf7ILzhTA/MhYC12nKlNnH/5AZZFYX4ADQHurBMab2wnWkEoo/wL6a4z2CiRhCVHQxwNcV8brHM1cuQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408396; c=relaxed/simple;
	bh=K87pRojl2DKUVZKC1HR5H3/SinxpRbB96NPtB+8t4FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0xGHNBiHMqW8/wYjfccgUR/hBFAvMr8nw3bu1quQhZHmZGUAxafTJizoiH5CIDGb408GlTWzOR+7GvMmmv/3JXoVmlsnANKiRQWm7TTBQ40rycfQMRqwT+PBlApRA9SZZkekXwLXa3GeAT0p3lMy0p8ctJoGDChSQen8YIXGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nm6kcQHQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711408396; x=1742944396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K87pRojl2DKUVZKC1HR5H3/SinxpRbB96NPtB+8t4FY=;
  b=Nm6kcQHQepVBDsQjCieAQkRpxmcQGfeD+di333tLjemjPMs/08TFdPq+
   Or6QDFpKkhXQnBXaX5BMCTcISDwxyln2cMGxqVd5zkz2Og5MJOrVYBQ4Q
   fUJTyjP0J80ZpsQau5KiYziihy+Lys0SzeGXXx5A0B+tHFccS+tJWuhzY
   1jmLmO9MYlftgGk4hsSZSVBCKTTHzriAxxBb0tKYFJWq4lpc8ta0pyzb/
   82TKRnIOuSGVgKKLbLXaQzrRMvcbeKEYW8IXAkSXXrLn0Tebzb1Qk4dud
   1h69t6JTv/UEX2fZEkEEf89DPnYjen1BFn1u+wn5G0zG2oYN6ezrKma5A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10231957"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="10231957"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 16:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20442589"
Received: from kyeonghy-desk1.amr.corp.intel.com (HELO desk) ([10.251.12.159])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 16:13:14 -0700
Date: Mon, 25 Mar 2024 16:13:00 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
Message-ID: <20240325231300.qrltbzf6twm43ftb@desk>
References: <20240324190503.116160-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324190503.116160-1-xry111@xry111.site>

On Mon, Mar 25, 2024 at 03:05:03AM +0800, Xi Ruoyao wrote:
> Per the "Processor Specification Update" documentations referred by the
> intel-microcode-20240312 release note, this microcode release has fixed
> the issue for all affected models.
> 
> So don't disable INVLPG if the microcode is new enough.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
> Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20240312
> Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
> Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/x86/mm/init.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 679893ea5e68..c52be4e66e44 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -261,33 +261,41 @@ static void __init probe_page_size_mask(void)
>  	}
>  }
>  
> -#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
> -			      .family  = 6,			\
> -			      .model = _model,			\
> -			    }
> +#define INTEL_MATCH(_model, _fixed_microcode)	\
> +    { .vendor		= X86_VENDOR_INTEL,	\
> +      .family		= 6,			\
> +      .model		= _model,		\
> +      .driver_data	= _fixed_microcode,	\
> +    }

Checkpatch is complaining here:

WARNING: please, no spaces at the start of a line
#33: FILE: arch/x86/mm/init.c:265:
+    { .vendor^I^I= X86_VENDOR_INTEL,^I\$

..
total: 0 errors, 5 warnings, 53 lines checked

> +
>  /*
>   * INVLPG may not properly flush Global entries
> - * on these CPUs when PCIDs are enabled.
> + * on these CPUs when PCIDs are enabled and the
> + * microcode is not updated to fix the issue.
>   */
>  static const struct x86_cpu_id invlpg_miss_ids[] = {
> -	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
> -	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
> -	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
> -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
> -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
> -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
> +	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x34),
> +	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x432),
> +	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT,	0x15),
> +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE,	0x122),
> +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P,	0x4121),
> +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S,	0x34),

I have checked this internally, the minimum microcode version that fixed
this issue are as below:

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index c52be4e66e44..d72ad330f2fc 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -274,12 +274,12 @@ static void __init probe_page_size_mask(void)
  * microcode is not updated to fix the issue.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x34),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x432),
-	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT,	0x15),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE,	0x122),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P,	0x4121),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S,	0x34),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x2e),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x42c),
+	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT,	0x11),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE,	0x118),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P,	0x4117),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S,	0x2e),
 	{}
 };
 

