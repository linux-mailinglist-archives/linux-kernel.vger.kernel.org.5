Return-Path: <linux-kernel+bounces-150664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C3E8AA290
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860E61C21044
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CE417AD9F;
	Thu, 18 Apr 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ffd2ya2d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="762nyUUU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405A17A93E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713467623; cv=none; b=WCktE7czn6TQ1wFFI4z2fkCwKlsBy6rVGHw5MdrkI9IIPVg3MFbXMMbnRisjlN2V17mWCFAUhovf7Da/xdUlaLloCjJxNCGeyA44ipvFt37wv8f+pCSPkseTSAG68SeyjyytgWaPrzl5nDsyMGQA40RAJusFaE0u8PXfCgFCE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713467623; c=relaxed/simple;
	bh=Iz678KAmXfBm/mZt3v+X1aeipm5kBNZsPm3UhrqtPf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zvn1Y0NQU+utlwnB1K2fGvoUqUKJpekW101jUC6AvnqEFPlvb31XpD0xPWjdYyknD574DA4GAWPf5+2TUNgbz+0UzFo3TgTqTVqeX3MB5oFsgUnJzf4JnytFpOVSGwUVNK8OyIVFR6drQSPV5h4z8Ye0e+cDfUpTmaTTfkcEtTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ffd2ya2d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=762nyUUU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713467619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j9rMqMzziPBG66zzSo6AyqknRc91sFEhQHJFsmE6nzg=;
	b=Ffd2ya2doIEt7x3rnqzKbBOJK2Fz1s6IYUY7CduKWzuTopfZzIDlTe2xyeFpFjbKYPNsXb
	VvBO/WNbKFb3xHW8MBlieiz4HX4Qx0LLbP/nkwNOFcAyucKy3cRe0uY14vLExD33Ssm51t
	uKuEAn3M5XF5WRNSveCHiwspacH9Xu7RG5d24hDDaCCY93c+qDpOqWqyMzdOpmwG+uZYuv
	pNHBXmCP2DGqsS5nbWAxFwXXXZf6Ba/lCORs56rpccQ3ZFTNcRB32VeoakHrqv5M8xmrXB
	idoybO+j3Ic20KugPSoFeTG8qX9f8m3G9XzNepSs71mvq15m192pGSs6K2XNMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713467619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j9rMqMzziPBG66zzSo6AyqknRc91sFEhQHJFsmE6nzg=;
	b=762nyUUUP9eTxaItKAik/TRrsj62zTb2lQlaflWMsqPAFYqhiNIc5NZ95f8t9VN9gj89Ln
	B/RWEIasyvfYYdDw==
To: Lyude Paul <lyude@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
In-Reply-To: <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
Date: Thu, 18 Apr 2024 21:13:34 +0200
Message-ID: <87plumxz4x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 18 2024 at 13:20, Lyude Paul wrote:

> Just gave it a try, unfortunately I'm still seeing the same result on
> that branch.
>
> One more piece of information I apparently missed when reporting this
> yesterday btw: I noticed one more kernel message that comes before the
> panic that's probably relevant:
>
> ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1

Can you please apply the debug patch below which should make it boot
again.

Please also provide the output of the files underneath of

       /sys/kernel/debug/x86/topo/

Thanks,

        tglx
---
 arch/x86/kernel/cpu/topology.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -176,6 +176,8 @@ static __init void topo_register_apic(u3
 {
 	int cpu, dom;
 
+	pr_info("APIC ID %x present %d\n", apic_id, present);
+
 	if (present) {
 		set_bit(apic_id, phys_cpu_present_map);
 
@@ -201,10 +203,7 @@ static __init void topo_register_apic(u3
 		 */
 		if (hypervisor_is_type(X86_HYPER_NATIVE) &&
 		    topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map)) {
-			pr_info_once("Ignoring hot-pluggable APIC ID %x in present package.\n",
-				     apic_id);
-			topo_info.nr_rejected_cpus++;
-			return;
+			pr_info("Hot-pluggable APIC ID %x in present package.\n", apic_id);
 		}
 
 		topo_info.nr_disabled_cpus++;



