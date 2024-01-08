Return-Path: <linux-kernel+bounces-19807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E142827487
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 219F7B21B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7511351C50;
	Mon,  8 Jan 2024 15:55:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EA451C36
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 087B6C15;
	Mon,  8 Jan 2024 07:55:48 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DF453F64C;
	Mon,  8 Jan 2024 07:55:00 -0800 (PST)
Date: Mon, 8 Jan 2024 15:54:58 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Brandt, Oliver - Lenze" <oliver.brandt@lenze.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"will@kernel.org" <will@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: mm: disable PAN during caches_clean_inval_user_pou
Message-ID: <ZZwa0msD9KSJg54-@FVFF77S0Q05N>
References: <e6dc8a44a140d1e54bc1408c36704b581433ec10.camel@lenze.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6dc8a44a140d1e54bc1408c36704b581433ec10.camel@lenze.com>

Hi Oliver,

On Mon, Jan 08, 2024 at 01:00:39PM +0000, Brandt, Oliver - Lenze wrote:
> Using the cacheflush() syscall from an 32-bit user-space fails when
> ARM64_PAN is used. We 'll get an endless loop:
> 
> 	1. executing "dc cvau, x2" results in raising an abort
> 	2. abort handler does not fix the reason for the abort and
> 	   returns to 1.
> 
> Disabling PAN for the time of the cache maintenance fixes this.

Hmm... the ARM ARM says PSTATE.PAN is not supposed to affect DC CVAU.

Looking at the latest ARM ARM (ARM DDI 0487J.a), R_PMTWB states:

| The PSTATE.PAN bit has no effect on all of the following:
|
| o Instruction fetches.
| o Data cache instructions, except DC ZVA.
| o If FEAT_PAN2 is not implemented, then address translation instructions.
| o If FEAT_PAN2 is implemented, then the address translation instructions
|   other than AT S1E1RP and AT S1E1WP.

So IIUC, DC CVAU shouldn't be affected by PAN.

This could be a CPU bug; which CPU are you seeing this with?

Mark.

> Fixes: 338d4f49d6f7 ("arm64: kernel: Add support for Privileged Access Never")
> Cc: stable@vger.kernel.org
> Signed-off-by: Oliver Brandt <oliver.brandt@lenze.com>
> ---
>  arch/arm64/mm/cache.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> index 503567c864fde..333c4c2baa568 100644
> --- a/arch/arm64/mm/cache.S
> +++ b/arch/arm64/mm/cache.S
> @@ -70,10 +70,12 @@ SYM_FUNC_ALIAS(__pi_caches_clean_inval_pou, caches_clean_inval_pou)
>   */
>  SYM_FUNC_START(caches_clean_inval_user_pou)
>  	uaccess_ttbr0_enable x2, x3, x4
> +	ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN, CONFIG_ARM64_PAN)
>  
>  	caches_clean_inval_pou_macro 2f
>  	mov	x0, xzr
>  1:
> +	ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN, CONFIG_ARM64_PAN)
>  	uaccess_ttbr0_disable x1, x2
>  	ret
>  2:
> -- 
> 2.43.0

