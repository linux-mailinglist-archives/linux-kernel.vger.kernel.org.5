Return-Path: <linux-kernel+bounces-109933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D338B8857EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA9E2822A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5DF5821C;
	Thu, 21 Mar 2024 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yyoPSu+z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RFAXhyJ3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3B15812F;
	Thu, 21 Mar 2024 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019674; cv=none; b=W0HlBmRbiZRRRNcP+uKFjNcMlTNPGFowYHeEMcnFwmDUqKtDLTZ/wJm+aiMHSUPeFB9aekfBNh/4CtPS/1cXzmxSqvRPr6Nen8G511uzqP48fsqZuUwujalTy88ZW4G32YvwqWFg4N1dTCbCDW/6kOJcotFDDe2IWuWMZeXzDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019674; c=relaxed/simple;
	bh=2QjovQg5WKK+1OaQxPTlBgZTKhFNsOA5kuD5wd/TvHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kaj3w4o/tduqy/eYedFYWa0RRStbUEts7upugufL6LOsvLFtUqRdkn0SL6yho3mcruQ4drRRtKWOtoXtlde+8QGU2agde6Kv9c1e5nGF2+IGW/AZtmCB+NdKuZJU1oV10lXUyZGgc7tycH/U4JHBJa0qvHfBJlif3IgEU++D/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yyoPSu+z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RFAXhyJ3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711019667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8obbwSnzuUFaxqMybHilSrOftM5wBOHep+jfUErEiQ=;
	b=yyoPSu+zdY75RKZVMLCRhmMaavjaWyrO142Aq8qF2Cupvs+qcumSgHrouFexuQdRbHl96B
	Ownj7W9StJ9vuhILTFl+uKs05qCBED2200VfqnoQfSFVyXyDLQW1gpGCFnKBU/joJKd4Qt
	ZASe9rLu6V6izS6trlZoULsh5K9gB1UaEjm7DFxjItgzmBclYXmSXIv3MCrVeypc/0vfoX
	yREvpoJJD/Sw8OtoZsNrvLjBQV4D7N9rnBMsPq48To0OW0MbcHpzpq5rcZMjNUrnlas0Vi
	Y7JyFiAG47+YsDUg2B6VIDGjhM+ysuUueA6Qf/1fCW4G029E4KH6ZvOzVR9Z2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711019667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8obbwSnzuUFaxqMybHilSrOftM5wBOHep+jfUErEiQ=;
	b=RFAXhyJ34HelHYfVFB/xaFUMP4ULdgFVuAq2z9BYyvKTFJchwJ4vZVdnDfGU0Xc0Wdtc3d
	4RhP9hGYjz6dv5BQ==
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Linus Torvalds
 <torvalds@linuxfoundation.org>, Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
In-Reply-To: <d51ec9a1-5221-4005-9980-8258df8b5102@roeck-us.net>
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net> <87bk79i8km.ffs@tglx>
 <d51ec9a1-5221-4005-9980-8258df8b5102@roeck-us.net>
Date: Thu, 21 Mar 2024 12:14:27 +0100
Message-ID: <87r0g3hm5o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 20 2024 at 08:46, Guenter Roeck wrote:
> On 3/20/24 01:58, Thomas Gleixner wrote:
>> On Fri, Mar 15 2024 at 09:17, Guenter Roeck wrote:
>>> I don't know the code well enough to determine what is wrong.
>>> Please let me know what I can do to help debugging the problem.
>> 
>> Could you provide me the config and the qemu command line?
>> 
>
> defconfig-CONFIG_SMP and
>
> qemu-system-x86_64 -kernel arch/x86/boot/bzImage -cpu Haswell \
>       --append "console=ttyS0" -nographic -monitor none
>
> The cpu doesn't really matter as long as it is an Intel CPU.
> A root file system isn't needed since the boot doesn't get that far.

Now it get's interesting because I can't reproduce it with that setup at
all.

What's weird is that I saw it exactly once on 64-bit in a VM with a UP
config two days ago, but when I started to add instrumentation it never
came back even after backing the instrumentation changes out. I have
seriously no idea what's going on there.

Is it fully reproducible on your side?

If so can you please provide a full dmesg and then apply the patch below
and provide the resulting full dmesg too?

I found two other issues while trying to find a way to reproduce, but
those are completely unrelated to the problem you are observing.

Thanks,

        tglx
---
 arch/x86/kernel/cpu/topology.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -176,6 +176,8 @@ static __init void topo_register_apic(u3
 {
 	int cpu, dom;
 
+	pr_info("APIC: %x %d\n", apic_id, present);
+
 	if (present) {
 		set_bit(apic_id, phys_cpu_present_map);
 
@@ -277,10 +279,23 @@ int topology_get_logical_id(u32 apicid,
 	/* Remove the bits below @at_level to get the proper level ID of @apicid */
 	unsigned int lvlid = topo_apicid(apicid, at_level);
 
-	if (lvlid >= MAX_LOCAL_APIC)
+	pr_info("APIC logical ID: %x %x %d\n", apicid, lvlid, at_level);
+
+	if (WARN_ON_ONCE(lvlid >= MAX_LOCAL_APIC))
 		return -ERANGE;
-	if (!test_bit(lvlid, apic_maps[at_level].map))
+
+	/*
+	 * If there was no APIC registered, then the map check below would
+	 * fail. With no APIC this is guaranteed to be an UP system and
+	 * therefore all topology levels have only one entry and their
+	 * logical ID is obviously 0.
+	 */
+	if (topo_info.boot_cpu_apic_id == BAD_APICID)
+		return 0;
+
+	if (WARN_ON_ONCE(!test_bit(lvlid, apic_maps[at_level].map)))
 		return -ENODEV;
+
 	/* Get the number of set bits before @lvlid. */
 	return bitmap_weight(apic_maps[at_level].map, lvlid);
 }

