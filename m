Return-Path: <linux-kernel+bounces-141360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7461C8A1DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D1ECB2B2E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84DF502BA;
	Thu, 11 Apr 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k7UpgUEn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aPpPeN85"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C53B4C629
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854542; cv=none; b=uBx8jIF5HW1FFAAVRY/i7hL/7X0KdUZmORyLeW/G8EPxEk9jkGF/CQZku9aTFAhQbMFq0vbJsgnSZtEs1xqRd1VS83rWE7ApmnMh3E2/id7k5bSxcvg/XORFykwGLMD87Ps0/6PL1h3+AB4Hx0LzyLTaK2RcpFHJ/kAivB0/5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854542; c=relaxed/simple;
	bh=aryO/c1uQgmEOTObfNrdfHzECktcnoGdCFewhnZiGzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QsUak2C/QLvHR2A+iLs37LjEwt4ypS3xHkEijIbv5wMyOEumIk/6x0C++4MvdVgx0QkPvXafb0LWXt2AKUAEkqOEzwCUlbhLVFcXtMgklCvQyvclkOMdYJtNh30gDPMMfOPQH6O2+4E6df9TmxEraAU//NXAzmMksCsdp0E5Z00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k7UpgUEn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aPpPeN85; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712854539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TsFOOJcOHJ7plsoN3ZMIm7IsVte2hrryLXZRjUEr1RQ=;
	b=k7UpgUEn0wKgyPCHTVl9AdGUS1mZ8RZtbsXU+Oo9fjYrectt91xIn2uJTXMrUnGCLqiQzS
	G3rr2kGJQT1g0UHhhTwfrP5NMo6YYIj6htcACHGP+/gVx0hqudsBG7DpxSaBKnXefxjSc9
	+ElnAW3k4ku9u29lTzC6PnvHnRktxJIvyuia+zA7knFKP1/BWyuCIoCEvNODVr+y3ziS9f
	Nvctid1B8O6rWMFcTr++i1RenI25EY/4Jy5XKeuiKbOE7zCotX4CFz+QQ3cFUE0ybSJVUc
	OoL35pTqFb5TG5aXXOW0yGMi12WCapT8HmBvKY4aigIA3kMfLFD02hyyoEQryQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712854539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TsFOOJcOHJ7plsoN3ZMIm7IsVte2hrryLXZRjUEr1RQ=;
	b=aPpPeN85qog8fqmo/cs6Sk8O76+uFImdLyx0TCkKcZCavesdNjxOd9Fhc7+4N/5Rj+RE09
	afEAKxCax8iZHSCA==
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org
Subject: [PATCH] x86/cpu/amd: Move TOPOEXT enablement into the topology parser
Date: Thu, 11 Apr 2024 18:55:38 +0200
Message-ID: <878r1j260l.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The topology rework missed that early_init_amd() tries to re-enable the
Topology Extensions when the BIOS disabled them.

The new parser is invoked before early_init_amd() so the re-enable attempt
happens too late.

Move it into the AMD specific topology parser code where it belongs.

Fixes: f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology parser")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/amd.c          |   15 ---------------
 arch/x86/kernel/cpu/topology_amd.c |   21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 15 deletions(-)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -535,7 +535,6 @@ static void early_detect_mem_encrypt(str
 
 static void early_init_amd(struct cpuinfo_x86 *c)
 {
-	u64 value;
 	u32 dummy;
 
 	if (c->x86 >= 0xf)
@@ -603,20 +602,6 @@ static void early_init_amd(struct cpuinf
 
 	early_detect_mem_encrypt(c);
 
-	/* Re-enable TopologyExtensions if switched off by BIOS */
-	if (c->x86 == 0x15 &&
-	    (c->x86_model >= 0x10 && c->x86_model <= 0x6f) &&
-	    !cpu_has(c, X86_FEATURE_TOPOEXT)) {
-
-		if (msr_set_bit(0xc0011005, 54) > 0) {
-			rdmsrl(0xc0011005, value);
-			if (value & BIT_64(54)) {
-				set_cpu_cap(c, X86_FEATURE_TOPOEXT);
-				pr_info_once(FW_INFO "CPU: Re-enabling disabled Topology Extensions Support.\n");
-			}
-		}
-	}
-
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
 		if (c->x86 == 0x17 && boot_cpu_has(X86_FEATURE_AMD_IBPB))
 			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -147,6 +147,26 @@ static void legacy_set_llc(struct topo_s
 	tscan->c->topo.llc_id = apicid >> tscan->dom_shifts[TOPO_CORE_DOMAIN];
 }
 
+static void topoext_fixup(struct topo_scan *tscan)
+{
+	struct cpuinfo_x86 *c = tscan->c;
+	u64 msrval;
+
+	/* Try to re-enable TopologyExtensions if switched off by BIOS */
+	if (cpu_has(c, X86_FEATURE_TOPOEXT) || c->x86_vendor != X86_VENDOR_AMD ||
+	    c->x86 != 0x15 || c->x86_model < 0x10 || c->x86_model > 0x6f)
+		return;
+
+	if (msr_set_bit(0xc0011005, 54) <= 0)
+		return;
+
+	rdmsrl(0xc0011005, msrval);
+	if (msrval & BIT_64(54)) {
+		set_cpu_cap(c, X86_FEATURE_TOPOEXT);
+		pr_info_once(FW_INFO "CPU: Re-enabling disabled Topology Extensions Support.\n");
+	}
+}
+
 static void parse_topology_amd(struct topo_scan *tscan)
 {
 	bool has_0xb = false;
@@ -176,6 +196,7 @@ static void parse_topology_amd(struct to
 void cpu_parse_topology_amd(struct topo_scan *tscan)
 {
 	tscan->amd_nodes_per_pkg = 1;
+	topoext_fixup(tscan);
 	parse_topology_amd(tscan);
 
 	if (tscan->amd_nodes_per_pkg > 1)

