Return-Path: <linux-kernel+bounces-112804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B7A887E5A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E798B20F6F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8203D56B;
	Sun, 24 Mar 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0m+h8G/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16903D555
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711304970; cv=none; b=nEo8Yh67Mp9pWzcWqGnedtVC3J9iZvc02CXhP4Yv2z4SO5ErG9H5iGGVg94GlAEQOdqVRAtzQwMhEviyWdFnxF+U9Lyb4nwpByiOLQlCm/tNgJ1mVAUwyAhV5a2BB61WWRotmcEZHVZSi0nQmqav75YzqlSu9SnZt88xES7Gr0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711304970; c=relaxed/simple;
	bh=qmcjZmsbwA7WDoqRbQvVdx3fPdkfsjYK3lepwHTZ1YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VF/2uD1rqcVA3HGAdzESWrTfGtf0AJOG6geaN87Xh7U4W3O5kxX03I9PoM2qJRYYj6rUdfGmERoDPHPw/swHd51M4AEYjIn4mrBYawesAuY8NJUjZ8OPgg3IPQ60yDnnpbZRXeyDkProBOs5ac2KzOOphUeU9qX0L6YnofyIAnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0m+h8G/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711304969; x=1742840969;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qmcjZmsbwA7WDoqRbQvVdx3fPdkfsjYK3lepwHTZ1YU=;
  b=I0m+h8G/sHLOuISNo1ikF1PjgQ+LiCLsOCl2WJOX2pTsUJAlA4dC1LBl
   AvRnYZpzzxxGm0Aj0kpK5tRJJjZ21iTzLgLolp1wIG2OPPrY/HAFy8Vcw
   gCreK32HaV0bMGbE7Rk9aIslr7KyBNQ96VVkqC3zAKUK1AycbahKAO5k5
   R5Ef9snyd7xeI4Hhoq3jIHJq9En+oTks3iTH3nkbY6ddUETAclzRdKViV
   nc165k+VWKEB5QRH9Wbl3ouhx6qCpek+PL3vDkoMjNLBP4R0vi5ktnYrb
   c0/5WK/5XOZvusJy8sI0/aLpwmSRIAiVxMZJcaMFW3ExTi+jsKJL4VFDn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6155206"
X-IronPort-AV: E=Sophos;i="6.07,151,1708416000"; 
   d="scan'208";a="6155206"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 11:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,151,1708416000"; 
   d="scan'208";a="19950176"
Received: from bmarken-mobl2.amr.corp.intel.com (HELO [10.212.140.250]) ([10.212.140.250])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 11:29:27 -0700
Message-ID: <319db7f3-7ce1-4096-a168-e5869c7a42f6@intel.com>
Date: Sun, 24 Mar 2024 11:29:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Don't disable INVLPG if "incomplete Global INVLPG
 flushes" is fixed by microcode
Content-Language: en-US
To: Xi Ruoyao <xry111@xry111.site>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240324170630.76084-1-xry111@xry111.site>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240324170630.76084-1-xry111@xry111.site>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/24 10:06, Xi Ruoyao wrote:
> +/*
> + * INVLPG issue is fixed with intel-microcode-20240312 for all
> + * affected models.  This table is taken from the release note
> + * of this microcode release.
> + */

That comment is much more changelog material than code comment material.

> +static const struct x86_cpu_desc invlpg_miss_fixed_ucode[] = {
> +	INTEL_CPU_DESC(INTEL_FAM6_ALDERLAKE,		2, 0x34),
> +	INTEL_CPU_DESC(INTEL_FAM6_ALDERLAKE,		5, 0x34),
> +	INTEL_CPU_DESC(INTEL_FAM6_ALDERLAKE_L,		3, 0x432),
> +	INTEL_CPU_DESC(INTEL_FAM6_ALDERLAKE_L,		4, 0x432),
> +	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GRACEMONT,	0, 0x15),
> +	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE,		1, 0x122),
> +	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE_P,		2, 0x4121),
> +	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE_P,		3, 0x4121),
> +	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE_S,		2, 0x34),
> +	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE_S,		5, 0x34),
> +	{}
> +};

Why is this listing individual steppings?  That seems nuts when the
issue affects *all* steppings or at least the invlpg_miss_ids[] table
says it affects all steppings.

The right way to do this is to take the existing table:

        INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
        INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
        INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),

and simply add the fix version:

        INTEL_WHATEVER(INTEL_FAM6_ALDERLAKE, 	  0x034),
        INTEL_WHATEVER(INTEL_FAM6_ALDERLAKE_L, 	  0x432),
        INTEL_WHATEVER(INTEL_FAM6_ATOM_GRACEMONT, 0x015),

Then you do:

	c = x86_match_cpu(invlpg_miss_ids);
	if (boot_cpu_data.microcode >= c->data)
		return 0; // no mitiagtion
	// affected, do mitigation

Then there's *one* table listing each model once and no steppings.  I
thought there's another example of this _somewhere_ but I couldn't find
it in two minutes of grepping.

