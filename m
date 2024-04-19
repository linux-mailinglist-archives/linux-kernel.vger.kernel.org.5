Return-Path: <linux-kernel+bounces-151724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BAA8AB2CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9E7283FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AE1130AD8;
	Fri, 19 Apr 2024 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwCCYdyR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5751812F59E;
	Fri, 19 Apr 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542744; cv=none; b=CsOIG8O5Hhrc+x8YV2AqhR23lxqeQTvL+yNaue0yGlLsaiNtJ49R49vMKuSrmrSbVjdOPTtRyQHR0Y1sPcmdxB18iYc+RdB6OfwFiOt9tCgtLl6e6zyzk6Xgu6az/KrsJEdUTkJ2yJHzHti0AqYUYeFuv2DkAC1sxlCAbVWw8gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542744; c=relaxed/simple;
	bh=3VqTx/MC+ZdPcEqq8wvrQXMLukiRoXnaGbZ1BaGpXo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rslob81SzlcobcpUHZ5NFthCV9tssEwDXIf5tezFVrV3drjkAgxFAwWg3f3io6yQodEqXv7CKToc+Chkhc8kvUDo/b/WiZna+8YkexCUiqekhmTni8SyLzqILFYjO5j3qUDDRibA9FS2G1h+7YZ8mV4Md9chxkVuTrkGsE1hLv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwCCYdyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78379C32781;
	Fri, 19 Apr 2024 16:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713542743;
	bh=3VqTx/MC+ZdPcEqq8wvrQXMLukiRoXnaGbZ1BaGpXo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OwCCYdyRv/+5/Zt90V/3HakgGm2piuce3WMCL8Zx/Kv5xKhKrE2jJIC92F6qogMg2
	 2h2gqGWpgfgViad0yQPYAzIom6t56N1mf80JkNoe5m1jKHnIL8VDINOTEOGJDbFAYS
	 Pn1p1DV6ZOUzQ/WG25q1ZF7GNNMALjZE+Z67Fv96tayRRWEsILvRdcxKd1ukgjL2Iw
	 MNOq5bFmblTiPLgb/RBjcA1HyGiqoG+qsGyTYCWQuuiZSY6mvoFQYFfzcXiKUmJ17X
	 OOi7/Fi3ufK1uZCNJkIWZsLzHdIKdWgoJ6nMu8npFKsljzNQY5OIZ61JrXkM822k0c
	 cgmfxtZH/ytiA==
Date: Fri, 19 Apr 2024 09:05:37 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] cpu: Re-enable CPU mitigations by default for !X86
 architectures
Message-ID: <20240419160537.namt5yaxhhvwwa3r@treble>
References: <20240417001507.2264512-1-seanjc@google.com>
 <20240417001507.2264512-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240417001507.2264512-2-seanjc@google.com>

On Tue, Apr 16, 2024 at 05:15:06PM -0700, Sean Christopherson wrote:
> Add a generic Kconfig, CPU_MITIGATIONS, to control whether or not CPU
> mitigations are enabled by default, and force it on for all architectures
> except x86.  A recent commit to turn mitigations off by default if
> SPECULATION_MITIGATIONS=n kinda sorta missed that "cpu_mitigations" is
> completely generic, where as SPECULATION_MITIGATIONS is x86 specific.
> 
> Alternatively, SPECULATION_MITIGATIONS could simply be defined in common
> code, but that creates weirdness for x86 because SPECULATION_MITIGATIONS
> ends up being defined twice, and the default behavior would likely depend
> on the arbitrary include order (if the two definitions diverged).
> 
> Ideally, CPU_MITIGATIONS would be unconditionally on by default for all
> architectures, and manually turned off, but there is no way to unselect a
> Kconfig.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lkml.kernel.org/r/20240413115324.53303a68%40canb.auug.org.au
> Fixes: f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

It seems confusing to have two config options which have very similar
names and similar purposes (with subtle differences depending on the
arch).

How about we instead just get rid of the x86-specific
SPECULATION_MITIGATIONS and replace it with a menu which depends on
CPU_MITIGATIONS:

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4474bf32d0a4..85a4d57bce1e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2488,17 +2488,8 @@ config PREFIX_SYMBOLS
 	def_bool y
 	depends on CALL_PADDING && !CFI_CLANG
 
-menuconfig SPECULATION_MITIGATIONS
-	bool "Mitigations for speculative execution vulnerabilities"
-	default y
-	help
-	  Say Y here to enable options which enable mitigations for
-	  speculative execution hardware vulnerabilities.
-
-	  If you say N, all mitigations will be disabled. You really
-	  should know what you are doing to say so.
-
-if SPECULATION_MITIGATIONS
+menu "CPU speculative execution mitigation defaults"
+	depends on CPU_MITIGATIONS
 
 config MITIGATION_PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
@@ -2643,7 +2634,7 @@ config MITIGATION_SPECTRE_BHI
 	  indirect branches.
 	  See <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 
-endif
+endmenu
 
 config ARCH_HAS_ADD_PAGES
 	def_bool y
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 2b8fd6bb7da0..70c1e7eb64f0 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -191,6 +191,16 @@ config GENERIC_CPU_AUTOPROBE
 config GENERIC_CPU_VULNERABILITIES
 	bool
 
+config CPU_MITIGATIONS
+	bool "Mitigations for CPU speculative execution vulnerabilities"
+	default y
+	help
+	  Say Y here to enable mitigations for CPU speculative execution
+	  vulnerabilities.
+
+	  If you say N, all mitigations will be disabled. You really
+	  should know what you are doing to say so.
+
 config SOC_BUS
 	bool
 	select GLOB
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 07ad53b7f119..bb0ff275fb46 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3207,8 +3207,8 @@ enum cpu_mitigations {
 };
 
 static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
-						     CPU_MITIGATIONS_OFF;
+	IS_ENABLED(CONFIG_CPU_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
+					     CPU_MITIGATIONS_OFF;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {

