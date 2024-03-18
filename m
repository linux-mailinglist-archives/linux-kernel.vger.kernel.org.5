Return-Path: <linux-kernel+bounces-106044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D8A87E84B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489AB1C21AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6608C36138;
	Mon, 18 Mar 2024 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DsRh2wPZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2rXzzq0j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3746F3717F;
	Mon, 18 Mar 2024 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760305; cv=none; b=HzKgJbV3uK6dd2YGKJUx94kP2Jm+vmMHKQiW3WrZ1oSm5URIwE+0/INCFiBtaKwkRcn6z6pQf/s/YFFtTwBfuIOcD95y0YvUkKi191zUEcVJK/M94TKKoI3WnqtYmDuBRou726JK9vyfKjTHTFpk5XvbpQfz+RyIeg7O6T13vKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760305; c=relaxed/simple;
	bh=z5VR/SCFO4fju311eNKwJ63qRf/aHwz2D5n4iQqSiBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qpGvhHVBc1qATxPX4whZPGF8T7jP57IHJvIkPBH3rHNdckL7n6efKWDpdWa7oz9f5mbcWOcKWF+Xa0/oxvmR721uTMM4imEM95XJnVH2KgNNojeno7dfRkAooOjD6LzBDKEQ5z+jRCj+BmsGn4J8RAoXwvoiQfeazuUmkGDEkqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DsRh2wPZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2rXzzq0j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710760300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kz9iUiUQcoOz3awzuNQ4c0iM+L+HbF9KJgq1+b8ISwY=;
	b=DsRh2wPZKF+ZU54Ol3+3tkG/vZylyJKaZweh1MbTMk/lURjsHdIIxR9igCB9VHwjgkxD8a
	gQYsU5LPNq2+1Al2TIP9sSnKu2NbYbkdsewheKEY/AnZUJmCVi3AKiUn6h+IhdxT/snRIb
	ej5HcPt2e8UzOp7tPCSdLosji5ZhlQP8dyxLwV3TlUerZc6wKsq4dkfHuXMwWq7Iyep5js
	/YgKUt/0Lnm9kv/9dw9hRxSzq9sMEw7b38IAz5P7sfwz+gNxeuFeVrbAEUueNJ97JkK3v3
	iScWXdApPrwJwhOZlgmxSmolkbFc2qbTJK1oMkT2xsaPjSPLM9tk0m2FMRoa+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710760300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kz9iUiUQcoOz3awzuNQ4c0iM+L+HbF9KJgq1+b8ISwY=;
	b=2rXzzq0jJ81Gok9ryRYJKmRQDOliceDGov4GITW3TRUy+rv/y+7Ff0yLJIQxjp1Rt4Gemp
	yIEWeVdtMHkqiWCQ==
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>,
 x86@kernel.org, Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org, lkp@intel.com,
 oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
In-Reply-To: <877ci3j80k.ffs@tglx>
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
 <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
 <87y1ajjsv9.ffs@tglx> <87o7bfjeae.ffs@tglx>
 <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
 <877ci3j80k.ffs@tglx>
Date: Mon, 18 Mar 2024 12:11:39 +0100
Message-ID: <87zfuviyl0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Mar 16 2024 at 02:11, Thomas Gleixner wrote:
> On Fri, Mar 15 2024 at 16:23, Linus Torvalds wrote:
>> Either we should just make all machines look like they have the proper
>> local apic mappings, or we shouldn't look at any local apic rules AT
>> ALL.
>
> Sure. I can simply check if there was an APIC registered instead.

Like the below. I'm not entirely sure though whether the sanity checks
should return an error code, which is what caused the crash Guenter
observed, but I couldn't come up with something sensible either.

Returning 0 might keep the machine alive, but does it make sense?

Thanks,

        tglx
---
 arch/x86/kernel/cpu/topology.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -277,10 +277,21 @@ int topology_get_logical_id(u32 apicid,
 	/* Remove the bits below @at_level to get the proper level ID of @apicid */
 	unsigned int lvlid = topo_apicid(apicid, at_level);
 
-	if (lvlid >= MAX_LOCAL_APIC)
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

