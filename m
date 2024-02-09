Return-Path: <linux-kernel+bounces-59841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CAF84FC65
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474C51C22A54
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B203282888;
	Fri,  9 Feb 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xlwy4N1j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99B57339
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504988; cv=none; b=uG9Gx/Mi0YHyljntMmfFViywao9BUzXlhLw1MwRhDNjhOF04Vv8VlqvAGr1RM8XxGyhgwEgyqjiPlEUkAnrvLIoJ/F83X85Hv44XchsV3+gX9Bx5tQ7+l7+7oWMjjDtylJyii7Th5nzfUAiFW/TmO+S6BNAz6mQmgI6Q7d5pOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504988; c=relaxed/simple;
	bh=SO31TmbkBMJBQykzmqYbyMuh5uGqCUjrVHEFJC8knyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5NQyIZoJC9d4+guOBz21qbAL9cP2HTyfgHVAGFaIO3TakFZ4avBMl6DMXXih/4uUNPNvOtnn1G+NHf0m8SkbTDTKl5AcLLn2CvugLuK8ApMGAD31yLMd181+JL1UKqRZw9DIJy67QChL9X+BUKsxwN3aAqVEnD4uN790QDLOBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xlwy4N1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A416C433F1;
	Fri,  9 Feb 2024 18:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707504987;
	bh=SO31TmbkBMJBQykzmqYbyMuh5uGqCUjrVHEFJC8knyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xlwy4N1jANhELD5loPDx1a5pvan3SJFF75/x/kYJsso5EIG3oERDQn1VHdZxIZt0G
	 8+UYqP99aIi6jd/nkPq6p7yU8MzY4Pr0lSk8a4l+pAMZpPaly7WimS0l5WVibvr8tn
	 UhjXAkDwVuqhhnEyeEosWsVD3z9HYzRlFckAMnmllF9Doca0lqTz9qD1XiaTq5VyiD
	 h0wHcTbixni70dHExcE40Xxq5h1O01H/R98+P445VroAG2KABsR/2oB7EFNzj3xfGr
	 mqKI1b4hLvHabgponutJiU0FT6LvpQ5gI4MYfBuvH79C13CdA7oSLHFodvxTQx/DUJ
	 XuKD1qPwfqiOw==
Date: Fri, 9 Feb 2024 10:56:25 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	antonio.gomez.iglesias@linux.intel.com,
	alyssa.milburn@linux.intel.com, andrew.cooper3@citrix.com,
	linux-kernel@vger.kernel.org,
	Alyssa Milburn <alyssa.milburn@intel.com>
Subject: Re: [PATCH] x86/bugs: Default retbleed to =stuff when retpoline is
 auto enabled
Message-ID: <20240209185625.hca6lts6dv4cd3fu@treble>
References: <20240208-retbleed-auto-stuff-v1-1-6f12e513868f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240208-retbleed-auto-stuff-v1-1-6f12e513868f@linux.intel.com>

On Thu, Feb 08, 2024 at 05:12:15PM -0800, Pawan Gupta wrote:
> @@ -1025,10 +1041,17 @@ static void __init retbleed_select_mitigation(void)
>  				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
>  			else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY) && boot_cpu_has(X86_FEATURE_IBPB))
>  				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
> +		} else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
> +			   spectre_v2_parse_cmdline() == SPECTRE_V2_CMD_AUTO &&

spectre_v2_parse_cmdline() has side effects (printks) and shouldn't be
called twice.

And what's the point of checking spectre_v2= anyway?  Shouldn't retbleed
be mitigated by default, independently of whatever the user may have
specified for Spectre v2?

> +			   spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
> +			if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING))
> +				retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
> +			else
> +				pr_err("WARNING: Retpoline enabled, but kernel not compiled with CALL_DEPTH_TRACKING.\n");

If retbleed is vulnerable then the sysfs file should show that.

Also, I think this pr_err() is redundant with RETBLEED_INTEL_MSG and can
be removed.

-- 
Josh

