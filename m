Return-Path: <linux-kernel+bounces-157528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9923A8B1262
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DE328F7E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631816EC12;
	Wed, 24 Apr 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPh9VQPU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AE816D4D1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983222; cv=none; b=dH2Ufnb1ncNE6MwzuOKJtzXwiq0a1MTLqazMkoGLKgztdaDYlUxOVj7Sf1rX71JkOlGmQWeNyJ2Iw/JgXHvC0SUXxWZX1wW9RnZ14s2rrUQzLDuKEYiYc7oCQd+vDxxvx6Eea6vgTBG6ZpScVg0+1J+iKdMvlTMW4Hz3NNIIS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983222; c=relaxed/simple;
	bh=abPWopN//NmQWtu+Y5v3ubjHMIaG4BQbX/z10WFr8TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow0OEjgF4Fu6pfupPUICmRLzwj6da/ilgOHi57GFk+1dh7zdEl8I1O81q2qMpuFreqm/p59+T6cGC9/EQPvAqmn3MpVfwUvCbNQBKuyKUgFcMsK3NUVoW5ZlMr1aiD+aqzkMkWsV+r2w40IVD5I6q4IczjAvuslTCXgGThaQMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPh9VQPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29049C2BD11;
	Wed, 24 Apr 2024 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713983221;
	bh=abPWopN//NmQWtu+Y5v3ubjHMIaG4BQbX/z10WFr8TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPh9VQPUhow8VDzz2IDIgbDmdiO42O/vPbw96koB2+PvfRyf6roPDkl42O8oVDNN/
	 /1ANIU1PGVR/XeIMqARTcqin+FAClXOJLMTrb1ojFhzbo2+l3bNruCS0J9dGOHWU4M
	 T8pq9vFS/JHT/snVnmZb1a1wBlXgUMC0yY8j6raHYJzYyEkXqC04fCf5J4LkIsTID+
	 Xlsb4x0kdLF+A1IjCw14ZFvOlT+gtTmTQa4ZoEejcJx7pklgw3g1ZVxew5COqUtYSy
	 nMrbKwZx8SkBmTSm7RD4aQhrQUpzvmjOaJClOktaNp5rvsP73pn53v7/7MIbkyI070
	 VcCSD7/i6TL0g==
Date: Wed, 24 Apr 2024 11:26:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH 2/9] x86/purgatory: Simplify stack handling
Message-ID: <20240424182659.GA2126602@dev-arch.thelio-3990X>
References: <20240424155309.1719454-11-ardb+git@google.com>
 <20240424155309.1719454-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424155309.1719454-13-ardb+git@google.com>

On Wed, Apr 24, 2024 at 05:53:12PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The x86 purgatory, which does little more than verify a SHA-256 hash of
> the loaded segments, currently uses three different stacks:
> - one in .bss that is used to call the purgatory C code
> - one in .rodata that is only used to switch to an updated code segment
>   descriptor in the GDT
> - one in .data, which allows it to be prepopulated from the kexec loader
>   in theory, but this is not actually being taken advantage of.
> 
> Simplify this, by dropping the latter two stacks, as well as the loader
> logic that programs RSP.
> 
> Both the stacks in .bss and .data are 4k aligned, but 16 byte alignment
> is more than sufficient.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/include/asm/kexec.h      |  1 -
>  arch/x86/kernel/kexec-bzimage64.c |  8 --------
>  arch/x86/purgatory/entry64.S      |  8 --------
>  arch/x86/purgatory/setup-x86_64.S |  2 +-
>  arch/x86/purgatory/stack.S        | 18 ------------------

This needs a small fix up to build.

  make[6]: *** No rule to make target 'arch/x86/purgatory/stack.o', needed by 'arch/x86/purgatory/purgatory.ro'.

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index acc09799af2a..2b6b2fb033d6 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
 
-purgatory-y := purgatory.o stack.o setup-x86_$(BITS).o sha256.o entry64.o string.o
+purgatory-y := purgatory.o setup-x86_$(BITS).o sha256.o entry64.o string.o
 
 targets += $(purgatory-y)
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))

