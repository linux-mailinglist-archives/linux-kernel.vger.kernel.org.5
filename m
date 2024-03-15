Return-Path: <linux-kernel+bounces-104993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAB487D761
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3651F22568
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12CB5A784;
	Fri, 15 Mar 2024 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bpkLH16S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ceUaHtTA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276059B7C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710546292; cv=none; b=EmdHGx+NVhMmuHvZ4dMlSNouXa5J/9iCJzZZD0s6mKxCH4deoAvgkcDY+Lz5XSUGK989RBhflvfvdGPzpixs4kWPtz9KiejuBxSurNPKAfpdINp8t2zICOz0MkCplr3fZx3vjAY1K/7NlFXD3qNS8AJbl4KHDRaKwgC1e2amoLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710546292; c=relaxed/simple;
	bh=UP/vv0P23On/QzgGKCR3QJOcuR1vItgINWra9wRRCdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fi0iPjW0ex3elbRU3KdWPC+QaTTZD/UfS9e/eElxWCO9Svlv8pIEZ+aVKuAZa4+yxg3SonmIuW3SIabzV/jHr+pIduWOFE8EfolKkdkxhIKTa3mZEJkwe3b1wKyoLpMi6jrIdRK2eo1nwxbiEtdv2o1Xea3FVGcDhCgh/3bPi+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bpkLH16S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ceUaHtTA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710546286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UP/vv0P23On/QzgGKCR3QJOcuR1vItgINWra9wRRCdQ=;
	b=bpkLH16STURVE77ulmGqn2pCSQjlaU84IlC8Sf/xXloGqJGl9JawtRkgfLqTUj85ovH2P6
	hlgO+WRlcfyTOIGLCOaRuAyCaxFKsGZWD8yhl716gt+i1uSx2a7cCWmkHMK3gHU9dsSMn8
	QkNnKL0LELQjtEPWZbbe1ERcuqscjZEixJIpP1cdyHg02/OgCb76hmZrVXKQsDvXRW/tiq
	wPVVv736oq8qdjNwbGEPFNg94lyiqbiZIQYDg1xiczXzjz/4X6vWC3MEIdjf8IjdmWpOgo
	7NrZmp5OuAO+UYuEidQ466JJn4s8dzfvCWMstC/dOhQMroIT51w5f0V9r15OaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710546286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UP/vv0P23On/QzgGKCR3QJOcuR1vItgINWra9wRRCdQ=;
	b=ceUaHtTADsLgNSlJzbgHxkvjzP6iI1RqJIlSXh180ZO45Ht6krTS0MxsM8c38BfcEDinIx
	kufqNJUumv2vBNAg==
To: Adam Dunlap <acdunlap@google.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, Arjan van de Ven
 <arjan@linux.intel.com>, Wei Liu <wei.liu@kernel.org>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Jacob Xu
 <jacobhxu@google.com>, Alper Gun <alpergun@google.com>, Kevin Loughlin
 <kevinloughlin@google.com>, Peter Gonda <pgonda@google.com>, Ard
 Biesheuvel <ardb@kernel.org>
Cc: Adam Dunlap <acdunlap@google.com>
Subject: Re: [PATCH v3] x86/asm: Force native_apic_mem_read to use mov
In-Reply-To: <20240206223620.1833276-1-acdunlap@google.com>
References: <20240206223620.1833276-1-acdunlap@google.com>
Date: Sat, 16 Mar 2024 00:44:45 +0100
Message-ID: <87frwrjc0i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 06 2024 at 14:36, Adam Dunlap wrote:

Can you please use foo() as notation for functions all over the place
including the subject line, which also wants s/mov/the MOV instruction/
and use MOV instead of mov.

> When done from a virtual machine, instructions that touch APIC memory
> must be emulated. By convention, MMIO access are typically performed via
> io.h helpers such as 'readl()' or 'writeq()' to simplify instruction
> emulation/decoding (ex: in KVM hosts and SEV guests) [0].
>
> Currently, native_apic_mem_read does not follow this convention,
> allowing the compiler to emit instructions other than the mov generated
> by readl(). In particular, when compiled with clang and run as a SEV-ES
> or SEV-SNP guest, the compiler would emit a testl instruction which is
> not supported by the SEV-ES emulator, causing a boot failure in that
> environment. It is likely the same problem would happen in a TDX guest
> as that uses the same instruction emulator as SEV-ES.
>
> To make sure all emulators can emulate APIC memory reads via mov, use
> the readl function in native_apic_mem_read. It is expected that any
> emulator would support mov in any addressing mode it is the most generic
> and is what is ususally emitted currently.
>
> The testl instruction is emitted when native_apic_mem_read
> is inlined into __xapic_wait_icr_idle. The emulator comes from
> insn_decode_mmio in arch/x86/lib/insn-eval.c. It would not be worth it

s/It would/It's/

Either it's a fact or not.

> to extend insn_decode_mmio to support more instructions since, in
> theory, the compiler could choose to output nearly any instruction for
> such reads which would bloat the emulator beyond reason.
>
> An alterative to this approach would be to use inline assembly instead
> of the readl helper, as that is what native_apic_mem_write does. I
> consider using readl to be cleaner since it is documented to be a simple
> wrapper and inline assembly is less readable. native_apic_mem_write
> cannot be trivially updated to use writel since it appears to use custom
> asm to workaround for a processor-specific bug.

How is this paragraph relevant?

> [0] https://lore.kernel.org/all/20220405232939.73860-12-kirill.shutemov@linux.intel.com/
>
> Signed-off-by: Adam Dunlap <acdunlap@google.com>
> Tested-by: Kevin Loughlin <kevinloughlin@google.com>

Other than the above nit picks:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>


