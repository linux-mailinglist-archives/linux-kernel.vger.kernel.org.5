Return-Path: <linux-kernel+bounces-131933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B9F898DB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA2AB22968
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F0312FF89;
	Thu,  4 Apr 2024 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4apwjV3X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mizQNvXw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0771C6A7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254013; cv=none; b=XOmLD69i5rv/VDoeziVuPIyBl7qq5MGsYpNH4lUNScGqwdr/zx3x84vaakjFTGiyupJeGWaHEnU04huVfxGavcvhTc1JhQxUoy5bmoEl7pWqUu7mE/j+CzssYtvwbb1jImnjgIGTCPU6xqzGuKbBtbzm9jhTD6t68iUkjixQkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254013; c=relaxed/simple;
	bh=QoLMfyS7OryKky/C77CP/bov/U+XO9FMaNdn4XGGGYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QNfEQ3lCE2fcYr5TNa2vs+1W4Ew++RPlbHG6Ll2q20MP9tXZZJtQhdxjBlx49QRU6w74I3GvD26lDsmHoZFoENdLza7kuZgYKuN3IL/u9csUmLNXTDi/NknWSaO2lzvQVbnfVUEA9mRZohotYQET8JWvhZcj6MZsYRW9WvTsXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4apwjV3X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mizQNvXw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712254010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/fgkUAxp94u/u/q7gTRy7tKml6S4rbKnwyliwWGMB4=;
	b=4apwjV3XPHGQRUeLTzwPznNMY6Ont3HZQyDZIPVYpuLkiMuf+X41zF8RzSwoewrdc4EzRw
	+KCd0AhAPAdvNNND0ZgPweiGYQ0pKvD8XG7wuZTtS1KBJlK1A8ie37KQKANDUj0ikcQ6L8
	Vuyjfdi9clhFDvWXNYXrlDfyoYT3vjvLgQ1+8MGdCrZsUVPpTstU53+75V++oDs6ZM6u/F
	FaH3zcmtIbJULJ4zZGgOeetuIQiiMtdWfWgeibxuV1yNl1ftK7IbBMazh2z/fd10it0DpA
	DfMbsNF17MqA2xXlRDpc/fWdU4kaezLY/LTK+nAUiynUwJ2I2OEBXEgNLxYGfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712254010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/fgkUAxp94u/u/q7gTRy7tKml6S4rbKnwyliwWGMB4=;
	b=mizQNvXwSzQgHXCZVcA/Nbu0EoYCP4w9sgXZiAuEwvk131QhDzHa9WLrnFOnX+ZbIdjcCT
	/UhQ+kBCNCjg9wDg==
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge
 Chromebooks
In-Reply-To: <87sf019kbd.ffs@tglx>
References: <874jchb7na.ffs@tglx>
 <20240404152317.464796-1-laura.nao@collabora.com> <87sf019kbd.ffs@tglx>
Date: Thu, 04 Apr 2024 20:06:50 +0200
Message-ID: <87plv59f45.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Laura!

On Thu, Apr 04 2024 at 18:14, Thomas Gleixner wrote:
> Can you please provide 'cpuid -r' output too as 'cpuid' does a few
> tweaks to the raw data and it's hard to match it back to the code.

Don't bother. I think I figured it out.

Can you please test the patch below?

Thanks,

        tglx
---
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 1a8b3ad493af..0d91a04b1741 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -29,7 +29,17 @@ static bool parse_8000_0008(struct topo_scan *tscan)
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
 
@@ -73,12 +83,14 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
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

