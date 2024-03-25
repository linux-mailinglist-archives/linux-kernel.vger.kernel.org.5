Return-Path: <linux-kernel+bounces-117278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 793A688A98B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D795341870
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F1116EBF7;
	Mon, 25 Mar 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DOfmjgT9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H7mY1Ult"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C916E89E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377756; cv=none; b=uxrlVZ5Wrvts81We0n9Nhr3QhDbMf+6EoOoT01RD6nVKAN0DJTClaB+FfFGQhEnqED+L4udCLbdi+vhw19cas89xNqqzdPruGg7wCr37/vDjBX/og4mit/ZqHca9WXNx7eboRPUxAluCabPk+wRrLRYgzc6AVgV/YFqFZEOmXNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377756; c=relaxed/simple;
	bh=lsAQp3ERS44ME+2Xi8BayjvKDLe8qjYX01IIerraZD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d2wwEoKvQ5sVqOzx7sxtD+Tivqh0O3WiM5VQaJ2ZYQXC78E+pqxuu+lFLUhGaaTWulmHGhm8Uzsbj2DMUaV7yPiJvFvl+GHyUh20CaCM9LCG/Cj/8dp2S1/EPPhb85owmxUFi5sA+k0bkrVUCfs5t77RFeBEA3D7LXUIdC6lG10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DOfmjgT9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H7mY1Ult; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711377752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6h6lGRc26CvpJhmCYM8Lh4xDDFxGLIelD6+6GfqS57c=;
	b=DOfmjgT9IrlClC+WCCW+GyBQZPaJmcVRGMeZb2YIW9fD8EvznnXy4MPB8VNA5yw5aMwJM8
	qRmBy7CFUf9oz+cJ/oCJkJafgzzwO6xfSQZZX+fzJ1Kfs5u1T2MHJLh8mn/ceedytZlC/p
	NkUrXiqfUWRbL8N1Q2Lo4xUZgQTaNcmVqbPu2NyzG2gNEnRVS0zorovAT9zWjNsNpfsbIi
	2JTzFO0EpNzhL3bkWSBUttOUPRvjyKZk2PGcH7hgfvdIgyX7Cd1g0igYV8cqUlC/cN7Uut
	RVg7CK/mrqnZqxbv4LTH1aSrTz14RY31bjqwP01U/kjPvt07ZnHo9GcXHVa3uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711377752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6h6lGRc26CvpJhmCYM8Lh4xDDFxGLIelD6+6GfqS57c=;
	b=H7mY1UltKDDHbG9M5CMnYCmPRtkGA8iktO2yS9nlhRLf3sSOwBW3QDq5q1rP+SJL5JZQCy
	tB47ga5WQThJs6AA==
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 linux-kernel@vger.kernel.org, ssengar@microsoft.com,
 sgeorgejohn@microsoft.com
Subject: Re: [PATCH] x86/numa: Map NUMA node to CPUs as per DeviceTree
In-Reply-To: <20240324162833.GA18417@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1710265404-23146-1-git-send-email-ssengar@linux.microsoft.com>
 <87v85bfzg0.ffs@tglx>
 <20240324162833.GA18417@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Date: Mon, 25 Mar 2024 15:42:32 +0100
Message-ID: <87jzlqfk4n.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Mar 24 2024 at 09:28, Saurabh Singh Sengar wrote:
> I recognize that due to recent changes, each dtb platform will now need to set
> a pointer for x86_init.mpparse.early_parse_smp_cfg to get the dtb_cpu_setup
> executed.

No. DT does not need the early parse call. The early parse call _cannot_
enumerate APICs.

> This was not the requirement before because earlier x86_dtb_init was
> anyway getting called.

For the wrong reasons.

> Do you think we should improve this as well by setting
> x86_init.mpparse.early_parse_smp_cfg to x86_dtb_parse_smp_config for all the
> dtb platforms by default.

No.

> I see the ce4100 platform is setting the parse_smp_cfg, shouldn't the
> early_parse_smp_cfg be more accurate there ?

Again. No. Early is not the point where APICs can be enumerated.

What we can do is the below.

Thanks,

        tglx
---
--- a/arch/x86/include/asm/prom.h
+++ b/arch/x86/include/asm/prom.h
@@ -24,18 +24,15 @@ extern u64 initial_dtb;
 extern void add_dtb(u64 data);
 void x86_of_pci_init(void);
 void x86_dtb_parse_smp_config(void);
+void x86_flattree_get_config(void);
 #else
 static inline void add_dtb(u64 data) { }
 static inline void x86_of_pci_init(void) { }
 static inline void x86_dtb_parse_smp_config(void) { }
+static inline void x86_flattree_get_config(void) { }
 #define of_ioapic 0
 #endif
 
-#ifdef CONFIG_OF_EARLY_FLATTREE
-void x86_flattree_get_config(void);
-#else
-static inline void x86_flattree_get_config(void) { }
-#endif
 extern char cmd_line[COMMAND_LINE_SIZE];
 
 #endif /* __ASSEMBLY__ */
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -277,9 +277,9 @@ static void __init dtb_apic_setup(void)
 	dtb_ioapic_setup();
 }
 
-#ifdef CONFIG_OF_EARLY_FLATTREE
 void __init x86_flattree_get_config(void)
 {
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	u32 size, map_len;
 	void *dt;
 
@@ -301,8 +301,10 @@ void __init x86_flattree_get_config(void
 
 	if (initial_dtb)
 		early_memunmap(dt, map_len);
-}
 #endif
+	if (of_have_populated_dt())
+		x86_init.mpparse.parse_smp_cfg = x86_dtb_parse_smp_config;
+}
 
 void __init x86_dtb_parse_smp_config(void)
 {

