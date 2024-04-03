Return-Path: <linux-kernel+bounces-129654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD1D896DFA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086001C25ECF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD87142E89;
	Wed,  3 Apr 2024 11:20:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D973506
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712143247; cv=none; b=Zc7QThrhFjRCYPuFsbEx38wnAZJ4DPrhYjgXH9aiU/Kc3ytdupQdWGxHlZQJ35LyDkX1h2HEN0UNmgLy/gfwLIdSrSaLG5f0QZ8dwOQ5DweDVGmYyLuJJAr4RoGO0/ONPhhfAlsmOM4/AJkcyF1jX+kWvMtIJ3A7VUdkIhE9Rgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712143247; c=relaxed/simple;
	bh=S6kayVt4WvqiDLd16zycrRONGPF78Qx9a0MeQPkyGFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evOkM84Lu4gVXMxaRgOgv10u8JKtNIE9BfJfanMb/adffQt7b/tNr0HrnwTHkT0iEEreWm+Tky8AP9rOGZVCRnVLMINUc27stAnEei9M3fPfvWY7C4qLJlaMbcSiRb5vaFRkBbplgWgMJjY9lt/0pBdsYaGKAwzOVwOJmC8HoHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 132641007;
	Wed,  3 Apr 2024 04:21:16 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84A8A3F64C;
	Wed,  3 Apr 2024 04:20:41 -0700 (PDT)
Date: Wed, 3 Apr 2024 12:20:38 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: agordeev@linux.ibm.com, anil.s.keshavamurthy@intel.com,
	aou@eecs.berkeley.edu, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, davem@davemloft.net, gor@linux.ibm.com,
	hca@linux.ibm.com, jarkko@kernel.org, jcalvinowens@gmail.com,
	linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
	mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com,
	palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de,
	will@kernel.org
Subject: Re: [PATCH 4/4] kprobes: Remove core dependency on modules
Message-ID: <Zg07hrb_RMUu2tq7@FVFF77S0Q05N>
References: <20240326163624.3253157-1-mark.rutland@arm.com>
 <20240326163624.3253157-5-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326163624.3253157-5-mark.rutland@arm.com>

On Tue, Mar 26, 2024 at 04:36:24PM +0000, Mark Rutland wrote:
> From: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Tracing with kprobes while running a monolithic kernel is currently
> impossible because KPROBES depends on MODULES. While this dependency is
> necessary when KPROBES_USE_MODULE_ALLOC=y, all the other module-specific
> code only exist to handle the case when MODULES=y, and can be hidden
> behind ifdeffery.
> 
> Add the necessary ifdeffery, and remove the dependency on MODULES=N when
> KPROBES_USE_MODULE_ALLOC=n.
> 
> Currently this allows kprobes to be used when CONFIG_MODULES=n on arm64
> and riscv, and other architectures can enable support by implementing
> their own kprobes_alloc_insn_page() and kprobes_free_insn_page() which
> do not depend on MODULES.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> Link: https://lore.kernel.org/all/20240326012102.27438-1-jarkko@kernel.org/
> [Mark: Remove execmem changes, depend on !KPROBES_USE_MODULE_ALLOC]
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> ---
>  arch/Kconfig                |  2 +-
>  kernel/kprobes.c            | 12 +++++++++++-
>  kernel/trace/trace_kprobe.c | 15 +++++++++++++--
>  3 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 85bb59f7b8c07..cf43de9ffb5b9 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -52,7 +52,7 @@ config GENERIC_ENTRY
>  
>  config KPROBES
>  	bool "Kprobes"
> -	depends on MODULES
> +	depends on MODULES || !KPROBES_USE_MODULE_ALLOC

Whoops; that should be:

	depends on MODULES || HAVE_KPROBES_ALLOC

.. with similar fixups in the commit message to describe HAVE_KPROBES_ALLOC
rather than KPROBES_USE_MODULE_ALLOC (which does not exist in any version of
the series that got sent to the list).

I'll send a v2 with that fixed (and the other changes from Jarkko's v7 base
patch) once I've locally tested that for architectures with and without
HAVE_KPROBES_ALLOC.

Mark.

