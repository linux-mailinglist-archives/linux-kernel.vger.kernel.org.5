Return-Path: <linux-kernel+bounces-167815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFED8BAF98
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D051F22FE0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823061514E5;
	Fri,  3 May 2024 15:14:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F734AEE5;
	Fri,  3 May 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714749282; cv=none; b=NyVc7dwhIGSWwKAAVRI1n4QjF0YAsFoW/kVaY9Dza92pBHw0JvpFa16O0zPQooRg0oq/WcdHVbUzURRruyExmGCgG6/ib6qNtXYoLg76QZQZKB56v8Gwf4CYLZz/c5njyF0ZxXMbt1Tp88QfjNl9RrlZY8cA3h653QtFiQ10U7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714749282; c=relaxed/simple;
	bh=oIK/+yonHStfriJ2pSk81av181eeZd+1Iw0axU58rgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgJ3sITYgTExTc5BQErKxS68NA6SVgSJ5W/ZpS9PtTxzytW0LfEQjJlTIheXFkYU5mSxnXRn1GHeFGpZGVR+62mrg3K+VXNHPMepPaPiO/mdCn9j6BwmECuntLTOWT3WOY28McuRmkgQ3oYpeSL4wSJYfZieo0cFAZQhM6LjxYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FA9513D5;
	Fri,  3 May 2024 08:15:04 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.34.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08C043F73F;
	Fri,  3 May 2024 08:14:36 -0700 (PDT)
Date: Fri, 3 May 2024 16:14:29 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Sumit Garg <sumit.garg@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, puranjay12@gmail.com
Subject: Re: [PATCH v2 1/2] arm64/arch_timer: include <linux/percpu.h>
Message-ID: <ZjT_M45l9xoNLiX6@FVFF77S0Q05N>
References: <20240502123449.2690-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502123449.2690-1-puranjay@kernel.org>

On Thu, May 02, 2024 at 12:34:48PM +0000, Puranjay Mohan wrote:
> arch_timer.h includes linux/smp.h to use DEFINE_PER_CPU() and it works
> because smp.h includes percpu.h. The next commit will remove percpu.h
> from smp.h and it will break this usage.
> 
> Explicitly include percpu.h and remove smp.h
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Looks like this was a thinko in commit:

  6acc71ccac7187fc ("arm64: arch_timer: Allows a CPU-specific erratum to only affect a subset of CPUs")

.. which, as you say, should have included <linux/percpu.h> rather than
<linux/smp.h>.

This is a cleanup regardless of the next patch.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/arch_timer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 934c658ee947..f5794d50f51d 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -15,7 +15,7 @@
>  #include <linux/bug.h>
>  #include <linux/init.h>
>  #include <linux/jump_label.h>
> -#include <linux/smp.h>
> +#include <linux/percpu.h>
>  #include <linux/types.h>
>  
>  #include <clocksource/arm_arch_timer.h>
> -- 
> 2.40.1
> 

