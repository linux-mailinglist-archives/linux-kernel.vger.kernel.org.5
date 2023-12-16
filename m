Return-Path: <linux-kernel+bounces-2190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FB8815925
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403F1285E51
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734C32C69F;
	Sat, 16 Dec 2023 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKY4+2ul";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rP9aWcIK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82AA18EB1;
	Sat, 16 Dec 2023 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 16 Dec 2023 12:58:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702731532;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCmp3T+knp1U2hYoByK4bhCzVso6/l7XB1ru7MM2DrQ=;
	b=PKY4+2ulXfJyLbM5w9zxB9NXj8L+74iucfszlreFdltcQVxcaXZ2JM/4WZ+NbOfHWCJztA
	1BRjVcoRQDzmFlVpUObL1c3xHdnfVo2Co8j48M/s3YkVMt/Hic24bwkBbGW5EgGIldb+2f
	MzTWTt1GREYtn9V2U9r7+8Abd88M3VfY5QFi616f35vivQBeL4NKy6NPsli+iQUmeBJCAK
	3PPAz8C/UizCaeOAOmSNgrl+fiHuKxDQDcLtcGcyLmVns73VFDEAA+xBZrqMnItRvAy40C
	ZgX3NVyFSuMidabyXJt4w+HzMPSS6kwbvoZT+q7D/gT4hkSWACFW8++m3K+kfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702731532;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCmp3T+knp1U2hYoByK4bhCzVso6/l7XB1ru7MM2DrQ=;
	b=rP9aWcIK8/zyVZJZStGABzJ+I0KpnsaIuHbAxJfKYz/tiXkdXHfMtWVyv2FaVkWjuPhEe3
	9dX+snpD0cCgCPBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/smpboot/64: Handle X2APIC BIOS inconsistency gracefully
Cc: Chris Lindee <chris.lindee@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ashok Raj <ashok.raj@intel.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <CA%2B2tU59853R49EaU_tyvOZuOTDdcU0RshGyydccp9R1NX9bEeQ@mail.gmail.com>
References:
 <CA%2B2tU59853R49EaU_tyvOZuOTDdcU0RshGyydccp9R1NX9bEeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170273153180.398.6629279525112148301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     69a7386c1ec25476a0c78ffeb59de08a2a08f495
Gitweb:        https://git.kernel.org/tip/69a7386c1ec25476a0c78ffeb59de08a2a08f495
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Dec 2023 09:58:58 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 15 Dec 2023 19:33:54 +01:00

x86/smpboot/64: Handle X2APIC BIOS inconsistency gracefully

Chris reported that a Dell PowerEdge T340 system stopped to boot when upgrading
to a kernel which contains the parallel hotplug changes.  Disabling parallel
hotplug on the kernel command line makes it boot again.

It turns out that the Dell BIOS has x2APIC enabled and the boot CPU comes up in
X2APIC mode, but the APs come up inconsistently in xAPIC mode.

Parallel hotplug requires that the upcoming CPU reads out its APIC ID from the
local APIC in order to map it to the Linux CPU number.

In this particular case the readout on the APs uses the MMIO mapped registers
because the BIOS failed to enable x2APIC mode. That readout results in a page
fault because the kernel does not have the APIC MMIO space mapped when X2APIC
mode was enabled by the BIOS on the boot CPU and the kernel switched to X2APIC
mode early. That page fault can't be handled on the upcoming CPU that early and
results in a silent boot failure.

If parallel hotplug is disabled the system boots because in that case the APIC
ID read is not required as the Linux CPU number is provided to the AP in the
smpboot control word. When the kernel uses x2APIC mode then the APs are
switched to x2APIC mode too slightly later in the bringup process, but there is
no reason to do it that late.

Cure the BIOS bogosity by checking in the parallel bootup path whether the
kernel uses x2APIC mode and if so switching over the APs to x2APIC mode before
the APIC ID readout.

Fixes: 0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")
Reported-by: Chris Lindee <chris.lindee@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Tested-by: Chris Lindee <chris.lindee@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/CA%2B2tU59853R49EaU_tyvOZuOTDdcU0RshGyydccp9R1NX9bEeQ@mail.gmail.com
---
 arch/x86/kernel/head_64.S | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 086a2c3..0f81032 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -255,6 +255,22 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	testl	$X2APIC_ENABLE, %eax
 	jnz	.Lread_apicid_msr
 
+#ifdef CONFIG_X86_X2APIC
+	/*
+	 * If system is in X2APIC mode then MMIO base might not be
+	 * mapped causing the MMIO read below to fault. Faults can't
+	 * be handled at that point.
+	 */
+	cmpl	$0, x2apic_mode(%rip)
+	jz	.Lread_apicid_mmio
+
+	/* Force the AP into X2APIC mode. */
+	orl	$X2APIC_ENABLE, %eax
+	wrmsr
+	jmp	.Lread_apicid_msr
+#endif
+
+.Lread_apicid_mmio:
 	/* Read the APIC ID from the fix-mapped MMIO space. */
 	movq	apic_mmio_base(%rip), %rcx
 	addq	$APIC_ID, %rcx

