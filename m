Return-Path: <linux-kernel+bounces-43223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0B1841116
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D68B25718
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84372152E18;
	Mon, 29 Jan 2024 17:43:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DA2154BE4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550236; cv=none; b=d+VJvxWrH/lxkNxvVoqboRFdC62mFi8XDwvmbb9DGQCF40ZrznymilCEODP1t77pmyA2p4HChmEZ/WoPjk5qOQxsGHqo9qnlJhb3EZIegoqzZ0g5r2nYRXsIYcUw4/5DD99d+3zU3QtOEw+f5UnDef5CGTX+Ecf0PJHCmTeEszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550236; c=relaxed/simple;
	bh=TZeS3q4De6vKPAIIj6+EfcIDjIRp8+LL0VujoZxmg+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roTVEXFAP4OyU/Nig6LdtusNDiTecZHzxpV3wS487Z3rZSjWGToM3fWRGg7hZCi5TuAtmYAl+PVm98vUahESJFoS7f0XJZm+ltgwf5kuFu2TNgI/uBkUzU7Pwp7KRRPNzpUggceyQ31BAZ5dTO/GCBTLx7BrTQpvAs9lPHq0F2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 719E5DA7;
	Mon, 29 Jan 2024 09:44:36 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.48.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A2B13F738;
	Mon, 29 Jan 2024 09:43:48 -0800 (PST)
Date: Mon, 29 Jan 2024 17:43:24 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, wangkefeng.wang@huawei.com,
	Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH v10 3/6] arm64: add uaccess to machine check safe
Message-ID: <ZbfjvD1_yKK6IVVY@FVFF77S0Q05N>
References: <20240129134652.4004931-1-tongtiangen@huawei.com>
 <20240129134652.4004931-4-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129134652.4004931-4-tongtiangen@huawei.com>

On Mon, Jan 29, 2024 at 09:46:49PM +0800, Tong Tiangen wrote:
> If user process access memory fails due to hardware memory error, only the
> relevant processes are affected, so it is more reasonable to kill the user
> process and isolate the corrupt page than to panic the kernel.
> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  arch/arm64/lib/copy_from_user.S | 10 +++++-----
>  arch/arm64/lib/copy_to_user.S   | 10 +++++-----
>  arch/arm64/mm/extable.c         |  8 ++++----
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
> index 34e317907524..1bf676e9201d 100644
> --- a/arch/arm64/lib/copy_from_user.S
> +++ b/arch/arm64/lib/copy_from_user.S
> @@ -25,7 +25,7 @@
>  	.endm
>  
>  	.macro strb1 reg, ptr, val
> -	strb \reg, [\ptr], \val
> +	USER(9998f, strb \reg, [\ptr], \val)
>  	.endm

This is a store to *kernel* memory, not user memory. It should not be marked
with USER().

I understand that you *might* want to handle memory errors on these stores, but
the commit message doesn't describe that and the associated trade-off. For
example, consider that when a copy_form_user fails we'll try to zero the
remaining buffer via memset(); so if a STR* instruction in copy_to_user
faulted, upon handling the fault we'll immediately try to fix that up with some
more stores which will also fault, but won't get fixed up, leading to a panic()
anyway...

Further, this change will also silently fixup unexpected kernel faults if we
pass bad kernel pointers to copy_{to,from}_user, which will hide real bugs.

So NAK to this change as-is; likewise for the addition of USER() to other ldr*
macros in copy_from_user.S and the addition of USER() str* macros in
copy_to_user.S.

If we want to handle memory errors on some kaccesses, we need a new EX_TYPE_*
separate from the usual EX_TYPE_KACESS_ERR_ZERO that means "handle memory
errors, but treat other faults as fatal". That should come with a rationale and
explanation of why it's actually useful.

[...]

> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
> index 478e639f8680..28ec35e3d210 100644
> --- a/arch/arm64/mm/extable.c
> +++ b/arch/arm64/mm/extable.c
> @@ -85,10 +85,10 @@ bool fixup_exception_mc(struct pt_regs *regs)
>  	if (!ex)
>  		return false;
>  
> -	/*
> -	 * This is not complete, More Machine check safe extable type can
> -	 * be processed here.
> -	 */
> +	switch (ex->type) {
> +	case EX_TYPE_UACCESS_ERR_ZERO:
> +		return ex_handler_uaccess_err_zero(ex, regs);
> +	}

Please fold this part into the prior patch, and start ogf with *only* handling
errors on accesses already marked with EX_TYPE_UACCESS_ERR_ZERO. I think that
change would be relatively uncontroversial, and it would be much easier to
build atop that.

Thanks,
Mark.

