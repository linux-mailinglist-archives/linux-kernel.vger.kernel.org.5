Return-Path: <linux-kernel+bounces-129970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45C88972D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB2D8B28490
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D5A43AB0;
	Wed,  3 Apr 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L0GQva3t"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C29461
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154766; cv=none; b=JPtXvgHnWOS6l0uYIR7M9RuQObkgENKQMESmdgikMyhvnBWKRyJLeq5u2Zob5kR3x6bzm0w8WujSR+EkdV7+eE6RVQB5eFjK3b0iUVlGWpHz5RSvCV/ugumULMnzL1K0kMPQun9r1FyyiNmXdhIB3pS9OKNUlenOAqR6fRszuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154766; c=relaxed/simple;
	bh=NFjdXLlgi82XB9MHJJMYP5zXbzCDvpHPjdFoTlHV6MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nX4iEx3349shIDIpj+SMUOEVl9LYAExN7Ij2r2pFBosVcRe/VXSwlHecy3hGjFWG8+dIuDtolc3Tr0PUA9JODLYu53oWVRnOFf/oM9NV/SA/IUX5j0RXvVH8LPd5PGNgh85jbyxNqUUBlNRZ9/ZnMsH+EGE0tVUK+/WmXIbmCrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L0GQva3t; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34356c24701so1097995f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712154762; x=1712759562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ix/8c1ilrYNmwrdxWqcssNgIc1QrW6kN4sfH/cde0dQ=;
        b=L0GQva3tNJPlUWK5ZQNDu2v1guapFftTYHlEKpBNfo/+R+pFXfxUzGZjafM7PHqFRE
         eRwzDKsT6zfe9/wQbyr9VsnytuU5cKnorWsqJb2z9SH69H0/JNeMcf/HqstdAkGrtAqP
         oigCiWISPYAAQDmLGAk0K88yUoTQB6PbHlEAAIRqoVX/WLJGjKbmhGAuVqVhy3RmJUDt
         y6/zCObDpeU+kPgcG1778FO0NOl2gcy3BofwYHX6g2SALIujezu8u6zMtvm40E5mR2Sb
         UtmNHsOqa+pSha99t24fJ83qfomYloJST8VCQwxIzdrqfT8pqygFIK/UDOY6aBuE2UXs
         ZM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712154762; x=1712759562;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ix/8c1ilrYNmwrdxWqcssNgIc1QrW6kN4sfH/cde0dQ=;
        b=uxOE+7bkTht6rufqHPxBWWsD0RZI/AE5+KqFp7lS8PuXgffy9ijkfA7DmFCnjTFSJ6
         Mo8VGjD0eJyORGex1/t5dr3vpJjY85YvGTloVzRGE8PcTMFiGAxaKlUegRGir+WWxfMe
         KKRZOO+5QeWrLFjuauCzp4u2EzerdwyEp+oMBnJn+EUTdekOm5odWPLigHVnhS3Ke0SX
         POJryE3l8sNnxav+eZM2Nkem36IFVGzi7AwdIfjBQwj692QqKPyQY+i4B559XQXtIk1r
         6FpgrHXreMgkbGQmA0f94arxhbM9zld/jWY6X3seMEdZH8vtR0ZlcZt2HS3KjVsurnOE
         qsfA==
X-Forwarded-Encrypted: i=1; AJvYcCXJbeP/JnwjfVy2Rca4DSc47F3tJkcn6gRvWoTFS4XW1+SYIQ4YEfndTmOe9YbUorRzG5KnrzzLHdhyAdpIvOmQ8560Ry7fYuRZAWIx
X-Gm-Message-State: AOJu0YxEeEYMONi/mHfxJviw+31ik3BJOTgHaxjJd+me3bDXGtsc9hg7
	aThZoTaowNu4TdbKjSZv/2/mRxYU+sqhPFbPlWkOJzh+s478EouYG76Y/09ArS4=
X-Google-Smtp-Source: AGHT+IF+rducJKyg9N1fxyviGtP7YNA1PUZ07gz8sOG55KqBdYvkrsv2fO+MaJb3JTg7lgGWXHsGLw==
X-Received: by 2002:adf:f4c8:0:b0:33e:a5e1:eccc with SMTP id h8-20020adff4c8000000b0033ea5e1ecccmr10326145wrp.68.1712154762219;
        Wed, 03 Apr 2024 07:32:42 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7318:e6ff:1aaf:f7b5:4ce8? ([2a10:bac0:b000:7318:e6ff:1aaf:f7b5:4ce8])
        by smtp.gmail.com with ESMTPSA id co20-20020a0560000a1400b0034334af2957sm15999487wrb.37.2024.04.03.07.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 07:32:42 -0700 (PDT)
Message-ID: <6ffcc9bd-039a-4ab4-a84d-eeedbc6fa1cc@suse.com>
Date: Wed, 3 Apr 2024 17:32:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/bugs: Default retbleed to =stuff when retpoline is
 enabled
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 antonio.gomez.iglesias@linux.intel.com, alyssa.milburn@linux.intel.com,
 andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
 Alyssa Milburn <alyssa.milburn@intel.com>, stable@kernel.org
References: <20240402-retbleed-auto-stuff-v3-1-e65f275a8ec8@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240402-retbleed-auto-stuff-v3-1-e65f275a8ec8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3.04.24 г. 8:54 ч., Pawan Gupta wrote:
> On Intel systems when retpoline mitigation is enabled for spectre-v2,
> retbleed=auto does not enable RSB stuffing. This may make the system
> vulnerable to retbleed. Retpoline is not the default mitigation when
> IBRS is present, but in virtualized cases a VMM can hide IBRS from
> guests, resulting in guest deploying retpoline by default. Even if IBRS
> is enumerated, a user can still select spectre_v2=retpoline.
> 
> As with other mitigations, mitigate retbleed by default. On Intel
> systems when retpoline is enabled, and retbleed mitigation is set to
> auto, enable Call Depth Tracking and RSB stuffing i.e. retbleed=stuff
> mitigation. For AMD/Hygon auto mode already selects the appropriate
> mitigation.
> 
> Reported-by: Alyssa Milburn <alyssa.milburn@intel.com>
> Cc: stable@kernel.org
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
> v3:
> - Rebased to v6.9-rc2
> 
> v2: https://lore.kernel.org/r/20240212-retbleed-auto-stuff-v2-1-89401649341a@linux.intel.com
> - Mitigate retbleed by default for spectre_v2=retpoline. (Josh)
> - Add the missing ',' in the comment. (Josh)
> - Rebased to v6.8-rc4
> 
> v1: https://lore.kernel.org/r/20240208-retbleed-auto-stuff-v1-1-6f12e513868f@linux.intel.com
> ---
>   arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index e7ba936d798b..69d8ce58f244 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1092,11 +1092,17 @@ static void __init retbleed_select_mitigation(void)
>   			else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
>   				 boot_cpu_has(X86_FEATURE_IBPB))
>   				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
> +		} else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
> +			   spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
> +			if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING))
> +				retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
> +			else
> +				pr_err("WARNING: Retpoline enabled, but kernel not compiled with CALL_DEPTH_TRACKING.\n");
>   		}
>   
>   		/*
> -		 * The Intel mitigation (IBRS or eIBRS) was already selected in
> -		 * spectre_v2_select_mitigation().  'retbleed_mitigation' will
> +		 * If Intel mitigation (IBRS or eIBRS) was already selected in
> +		 * spectre_v2_select_mitigation(),  'retbleed_mitigation' will
>   		 * be set accordingly below.
>   		 */
>   

nit: I think those outer 'ifs' might be a bit easier to grok if
they are turned into a switch:


26 do_cmd_auto:
     25         case RETBLEED_CMD_AUTO:
     24                 switch(boot_cpu_data.x86_vendor) {
     23                 case X86_VENDOR_AMD:
     22                 case X86_VENDOR_HYGON:
     21                         if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY))
     20                                 retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
     19                         else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
     18                                  boot_cpu_has(X86_FEATURE_IBPB))
     17                                 retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
     16                         break;
     15                 case X86_VENDOR_INTEL:
     14                         if (spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
     13                                 if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING))
     12                                         retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
     11                                 else
     10                                         pr_err("WARNING: Retpoline enabled, but kernel not compiled with CALL_DEPTH_TRACKING.\n");
      9                         }
      8
      7                         /*
      6                          * The Intel mitigation (IBRS or eIBRS) was already selected in
      5                          * spectre_v2_select_mitigation().  'retbleed_mitigation' will
      4                          * be set accordingly below.
      3                          */
      2                 default:
      1                         break;
   1112                 }





> 
> ---
> base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
> change-id: 20240208-retbleed-auto-stuff-53e0fa91305e
> 
> 

