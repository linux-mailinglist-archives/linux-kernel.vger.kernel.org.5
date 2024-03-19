Return-Path: <linux-kernel+bounces-107376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F7587FBA8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBC0281BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5139F7D419;
	Tue, 19 Mar 2024 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs56Prpc"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14A7C6CC;
	Tue, 19 Mar 2024 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843483; cv=none; b=uR+dT2wk08ekWP9KljnyChH7PomlyeONu3SvS5fmHC7bYoQU6P08tkiTFQxx80GmoVCHXbPIM+Rg5vB3RxYcSlx3KmRuJey9F6mV0uXfjBeP5PV/CCVnOPaE+kFwoYrG/dJPovwMd9y1sgHdx7BLecxO/eVXYntNbhO31R4ov0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843483; c=relaxed/simple;
	bh=365o9eDCvsM8wbCp72AERkVI996vUgJ5Na3hZvSH5kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSx+7pE84NsC2rhjy0GDpobpKvCLE/vEchc60PU6mxPKZGMk3oe14l2WRi5yJRUq+tnCMvBQnDt/HujZTSecI7C63IFWD4SttKjZJ4Ovd7VLZSafiQGIgwJ+9Bwuuzs0OK21JlG4upErwDn98gLgh1Y/lczR0qNWEc9+VB5VKq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rs56Prpc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-414612cfd82so8067915e9.2;
        Tue, 19 Mar 2024 03:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710843480; x=1711448280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnHSJBNeEvbT29QiMgDZHpJRvsgypNSMg8OafGtTRvs=;
        b=Rs56Prpca1H7JfSW05TjlEWPxif3iROSD8vF6zKqKJxISmWC28NkwvXfCAyxHxCaZS
         NsVZRjX0lV1/HDDGu5y9FfAoWfwtQp2O0nK/A8jy1RauqzfqZe4WRKHNZTmlZuJ2pDAZ
         fFb7nB6uEZHXmshM3PIKtv8dGjnolelzhsuaaTxhWdo/WFguDNuso9/+ZSwXLkUwkqlz
         3K8TS1zCOs/9ZiSMLUvX4ZszMvLaM+34CDXXYkhe8OHvgo/1bZgvB+n69GwMjizYaRkv
         YHkFpQmRtSRTAl6HD3sgZDjzVbdF8JQ+BAHP4RjEgS1g1OZGPJoJ+LgtMEZSf+7dfwX9
         YcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843480; x=1711448280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnHSJBNeEvbT29QiMgDZHpJRvsgypNSMg8OafGtTRvs=;
        b=VC2dM0ljm+k6TamiSp6/GYCbdb/5X3wN9u43hxHuDi5YI7D3HIJxqbxRl9kNBMxnVy
         nq3fFJcqq+YZXSdxcJs4L94dQ9AdUfQps6t5Rkf5A09/Y0j1oDiNyZJ90HA7Sci1DiHT
         aN7T2WlHvXGsfYX3MHfHL17Jlw7nCNvt7mYLuXm7O1JZZRR1D6SeE+C3eNDSd22dXiXp
         e1OFdOJJz09ZQq3EOFLyWD8jjdlCpxsKsEXeVvEEczjGfroDZ9RWVrh9tzbifcniw1j1
         Achk2U8R/X4SPEPGtf3dQYCetWSBwOQfrVrZ1HBuCy2xZbbYgUB7HslX1CM5Qx88Vrrf
         qSnw==
X-Forwarded-Encrypted: i=1; AJvYcCXAYT1URPSnVu2rGx87R0YBVa9z8C1sXX7ydiv+48ZgUPkqBjrzjUnjQo/rSBj2c1IcVZPcuq+cyjHNDGX8wUoiGZRa28LIvHBrKFZs
X-Gm-Message-State: AOJu0Yztjawinhwkjh+++rPcjI9XV3KzgJvP5XIkeuzcqbiO5O/Ce/qY
	PuKTMtZqqy34hEpdLFmT+Sw8wXDXW+m+Pw2MeL2B3V9SW49Qc3zM
X-Google-Smtp-Source: AGHT+IFdl0FftVh0XL4WgEwBkni9DHeEr8l08lps6xbWM7T1YFUWMH9NANb4rR4i2mAfkji0A469Jg==
X-Received: by 2002:a05:600c:4f88:b0:412:efc8:299b with SMTP id n8-20020a05600c4f8800b00412efc8299bmr1384372wmq.39.1710843479483;
        Tue, 19 Mar 2024 03:17:59 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id ck7-20020a5d5e87000000b0033b48190e5esm6798380wrb.67.2024.03.19.03.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:17:58 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 19 Mar 2024 11:17:55 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, peterz@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
	seanjc@google.com, pbonzini@redhat.com, eranian@google.com,
	irogers@google.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
Subject: Re: [PATCH v4 1/2] x86/cpufeatures: Add dedicated feature word for
 CPUID leaf 0x80000022[EAX]
Message-ID: <ZflmU+H2Lt2I0VOq@gmail.com>
References: <cover.1710836172.git.sandipan.das@amd.com>
 <846eebace0aea3a600b81b06bddd0024e5ac1350.1710836172.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846eebace0aea3a600b81b06bddd0024e5ac1350.1710836172.git.sandipan.das@amd.com>


* Sandipan Das <sandipan.das@amd.com> wrote:

> Move the existing scattered performance monitoring related feature bits
> from CPUID leaf 0x80000022[EAX] into a dedicated word since additional
> bits will be defined from the same leaf in the future. This includes
> X86_FEATURE_PERFMON_V2 and X86_FEATURE_AMD_LBR_V2.
> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  arch/x86/include/asm/cpufeature.h        |  7 +++++--
>  arch/x86/include/asm/cpufeatures.h       | 10 +++++++---
>  arch/x86/include/asm/disabled-features.h |  3 ++-
>  arch/x86/include/asm/required-features.h |  3 ++-
>  arch/x86/kernel/cpu/common.c             |  3 +++
>  arch/x86/kernel/cpu/scattered.c          |  2 --
>  arch/x86/kvm/cpuid.c                     |  5 +----
>  arch/x86/kvm/reverse_cpuid.h             |  1 -
>  8 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
> index a1273698fc43..68dd27d60748 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -33,6 +33,7 @@ enum cpuid_leafs
>  	CPUID_7_EDX,
>  	CPUID_8000_001F_EAX,
>  	CPUID_8000_0021_EAX,
> +	CPUID_8000_0022_EAX,

>  #define X86_FEATURE_SYSCALL32		( 3*32+14) /* "" syscall in IA32 userspace */
>  #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
>  #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
> -#define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
> +/* FREE!				( 3*32+17) */
>  #define X86_FEATURE_CLEAR_CPU_BUF	( 3*32+18) /* "" Clear CPU buffers using VERW */
>  #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
>  #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
> @@ -209,7 +209,7 @@
>  #define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable */
>  #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
>  #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
> -#define X86_FEATURE_PERFMON_V2		( 7*32+20) /* AMD Performance Monitoring Version 2 */
> +/* FREE!				( 7*32+20) */
>  #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
>  #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
>  #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
> @@ -459,6 +459,10 @@
>  #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
>  #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
>  
> +/* AMD-defined performance monitoring features, CPUID level 0x80000022 (EAX), word 21 */
> +#define X86_FEATURE_PERFMON_V2		(21*32+ 0) /* AMD Performance Monitoring Version 2 */
> +#define X86_FEATURE_AMD_LBR_V2		(21*32+ 1) /* AMD Last Branch Record Extension Version 2 */

Thank you! I presume you tested both patches on the relevant system 
with the X86_FEATURE_AMD_LBR_PMC_FREEZE bug?

Thanks,

	Ingo

