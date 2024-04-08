Return-Path: <linux-kernel+bounces-135508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C48BC89C6DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C711F23D21
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4BB12A160;
	Mon,  8 Apr 2024 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JyMQ8LnK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kyoO6H0X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907C612A14E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585973; cv=none; b=gfwh4zeNzHfFykjKafiPHwG0+MUDzra7UtgROaHtkjwo7WPEcQ39mqaDYeZ1iGzS6efCdI9ejrtsf2bNzVj4qMalF4vNeXNWi2YaWajQF/6T2iIf0DpC9eZOVcaWCFpuS32B+A/+dXrQ2mAk544bvl4A3LONNbQq+tm/FO/tsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585973; c=relaxed/simple;
	bh=dburm2e0CH8RMC8ZTCT8ZG/KPOT3+NbIGLgwYleaQGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W/5HURQT1L04rUMHiosiU42Mar+R8XujDsCDr535/1wGcOQ8UylJhj0obRyItIvOUOQ6PINNX7TRezWtJL6O/HSQy+nOem2DfZczADZds5IW9xxtRG+BMcI3MOpqKdCL3iuG+P5tr12UxzwS0HU3hpg1eMl78UAW4A0ZGUotTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JyMQ8LnK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kyoO6H0X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712585969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zjhyLQPDLHKrpTEkAe5cnDIyWOE69JGkyLJy181UziI=;
	b=JyMQ8LnKeAoO5DRg2np8AeZd3nbWuoGJvoaJYJpH9Cse3j7soPQk1687SvFW06rRB64QDs
	Zast2jMyMkAHWKIHyIEcouQ8K0ZJU17if5DGR7PHxjp0GBxuhHscy2AzbUs72HDKJJWjm+
	Wj/qUD2xtAh6ayi+nh51UlEyrmKWLeBoXIHGYdaA/C2TMq/uGFDVH/4aliw2S9Ywa+U1Db
	gghkg7XeLb78XZnP4phJwzYyZU5rOLJrZ7CWesOX4WFpYuPXiVBKSArBi1MpxbyKnWOi8C
	iR439lbfOAZeVKakN8hp/VP92ev9Nn+bG61WGufql+QStaH3beca1dIH9xYJ2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712585969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zjhyLQPDLHKrpTEkAe5cnDIyWOE69JGkyLJy181UziI=;
	b=kyoO6H0XTyjNhhV/ui/mCn2yrgxkjTfIMs0FSIxPTuzmbkAMR0iANW7eZoRo7r2yajjqdb
	QujbPKCrPYymZGBA==
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge
 Chromebooks
In-Reply-To: <20240408110605.164608-1-laura.nao@collabora.com>
References: <87zfu46zal.ffs@tglx>
 <20240408110605.164608-1-laura.nao@collabora.com>
Date: Mon, 08 Apr 2024 16:19:29 +0200
Message-ID: <87r0fg6ioe.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Laura!

On Mon, Apr 08 2024 at 13:06, Laura Nao wrote:
> Just tried that and it doesn't boot, nothing on the serial console (I
> kept earlyprintk=ttyS0,115200 in the cmdline).

Thanks for trying. Now let's take a small step back.

Please reset the tree to:

      ace278e7eca6 ("x86/smpboot: Teach it about topo.amd_node_id")

That's the commit right before switching over and according to your
bisect it works. Now apply the patch below, which just runs the new
topology scan function but discards the result.

Thanks,

        tglx
---
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -29,7 +29,17 @@ static bool parse_8000_0008(struct topo_
 	if (!sft)
 		sft = get_count_order(ecx.cpu_nthreads + 1);
 
-	topology_set_dom(tscan, TOPO_SMT_DOMAIN, sft, ecx.cpu_nthreads + 1);
+	/*
+	 * cpu_nthreads describes the number of threads in the package
+	 * sft is the number of APIC ID bits per package
+	 *
+	 * As the number of actual threads per core is not described in
+	 * this leaf, just set the CORE domain shift and let the later
+	 * parsers set SMT shift. Assume one thread per core by default
+	 * which is correct if there are no other CPUID leafs to parse.
+	 */
+	topology_update_dom(tscan, TOPO_SMT_DOMAIN, 0, 1);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, sft, ecx.cpu_nthreads + 1);
 	return true;
 }
 
@@ -73,12 +83,14 @@ static bool parse_8000_001e(struct topo_
 	tscan->c->topo.initial_apicid = leaf.ext_apic_id;
 
 	/*
-	 * If leaf 0xb is available, then SMT shift is set already. If not
-	 * take it from ecx.threads_per_core and use topo_update_dom() -
-	 * topology_set_dom() would propagate and overwrite the already
-	 * propagated CORE level.
+	 * If leaf 0xb is available, then the domain shifts are set
+	 * already and nothing to do here.
 	 */
 	if (!has_0xb) {
+		/*
+		 * Leaf 0x80000008 set the CORE domain shift already.
+		 * Update the SMT domain, but do not propagate it.
+		 */
 		unsigned int nthreads = leaf.core_nthreads + 1;
 
 		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nthreads);
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -133,6 +133,10 @@ static void parse_topology(struct topo_s
 	tscan->ebx1_nproc_shift = get_count_order(ebx.nproc);
 
 	switch (c->x86_vendor) {
+	case X86_VENDOR_AMD:
+		if (IS_ENABLED(CONFIG_CPU_SUP_AMD))
+			cpu_parse_topology_amd(tscan);
+		break;
 	case X86_VENDOR_CENTAUR:
 	case X86_VENDOR_ZHAOXIN:
 		parse_legacy(tscan);



