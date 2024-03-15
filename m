Return-Path: <linux-kernel+bounces-104973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781A487D6D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3482C282462
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B6D59B7A;
	Fri, 15 Mar 2024 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NmQShR6/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PcbOpbRi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D45154BF7;
	Fri, 15 Mar 2024 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710543344; cv=none; b=MJCNcMuKN4M+vzV4UYPJItQhpeKxoFoer9SERS7IXXCXCQV8KP48KUKTvbpWY+nh5ZNnoeAxvZ1aTjryJNJIuXhL3tuJ1cgKVLoE5GBaVVq8HVUfWLjQP7ZPZt7TW5AVZLwy2T+DIyHBftIG3Bna9huKR6STS2kRRj7ySkTjqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710543344; c=relaxed/simple;
	bh=0/VOjcMaYIEC1VaXonbBm81DGBQ87M/ir9auh4I+oPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qru5GJcDLbivemTdNLr8P7/VAsa4OEhxG8TSR/Suc1ebXV3g+6v0C0/peiLgg9o6taAes2NwM2zfYwxaCkFQH9gLSHG8innhQvmRnvfqWDt5wsfUzSCL6koJomBC9Xx8YZ/vBCjteu2Ry0DHuV8UZfnLZ/HzAfjpuJCkYZGWp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NmQShR6/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PcbOpbRi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710543338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tc/I/k/ZfzmyvgN+5eD3gfox+0pZdAK/4qXTdx0YhS4=;
	b=NmQShR6/W1Tuq2M0iBem82+tc+bPYx++QmA5N28Ht4EbfMpY19HkTCfwRqHkAH0OQE9W6r
	BEsRu/dnWEcLEFS93Qv0toFPzYuS2cOdyvYy8Uos139eYv6RDXyUovOuaBBcFHr+RZCU5g
	sm1IhvOkWF0YETTJ0t9khcvBGhzVdIBF1h8HXot311q6bi5Yb1onKlv3RsEMZuFQN6u6mK
	2uYF5Jq1aOwcza+LoOrhWDLon7Z15Dfxi3Frtni62wVJ+pJWv7tQaYtsur02GpvE9HVpkj
	hSoSq4Q+pY+FJJDb74dhhrJJ8YXIgCLMDFQ+gKqE3hjW3nCCdXGPsycBeVDTvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710543338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tc/I/k/ZfzmyvgN+5eD3gfox+0pZdAK/4qXTdx0YhS4=;
	b=PcbOpbRiXsbU5KC+U7WjkwiHm9oOKmFNBC5aWpcC934jLu8yLBRIpDgl+j70Z+2EAiJJ7U
	tOd6HY6UGXkmEtCA==
To: Linus Torvalds <torvalds@linuxfoundation.org>, Guenter Roeck
 <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Uros Bizjak
 <ubizjak@gmail.com>, linux-sparse@vger.kernel.org, lkp@intel.com,
 oe-kbuild-all@lists.linux.dev
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
In-Reply-To: <87y1ajjsv9.ffs@tglx>
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
 <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
 <87y1ajjsv9.ffs@tglx>
Date: Fri, 15 Mar 2024 23:55:37 +0100
Message-ID: <87o7bfjeae.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 15 2024 at 18:40, Thomas Gleixner wrote:
> On Fri, Mar 15 2024 at 09:42, Linus Torvalds wrote:
>> On Fri, 15 Mar 2024 at 09:17, Guenter Roeck <linux@roeck-us.net> wrote:
>> Thomas, over to you. I wonder if maybe all those topology macros
>> should just return 0 on an UP build, but that
>> topology_get_logical_id() thing looks a bit wrong regardless.
>>
>> It really shouldn't depend on local apic data for configs that may not
>> *have* a local apic.
>
> Right. Let me look.

Not really. The problem is that a SMP build can run on a UP machine w/o
APIC or command line disables the APIC and will run into the exactly
same problem. The only case where we know that it is impossible is when
APIC support is disabled, which is silly but topic for a different
discussion.

So the proper thing to do is to check for num_possible_cpus() == 1 in
that function.

Sure you can argue that we could avoid it for SMP=n builds completely,
but I think the right thing to do is to aim for removing CONFIG_SMP and
make the UP build a subset of a generic SMP capable build which has
CONFIG_NR_CPUS=1, i.e. num_possible_cpus() = 1. Why?

Because it consolidates the code and makes UP use exactly the same
mechanisms as SMP which pretty much avoids the problem we see today that
UP lacks test coverage and becomes more esoteric and untested over time.

The downside is a slightly larger kernel image for such a build.

Though if we pretend that we seriously care about that 10% larger memory
footprint or about the marginal performance benefit of SMP=n on dead
hardware, then we are just taking the wrong pills.

The point is that this very commit in question was heading deliberately
into the direction of removing the by now silly differences of UP/SMP
for correctness sake. It just happened to unearth the missing check in
topology_get_logical_id(), but that check is required independent of
SMP=y/n as I pointed out above.

Thanks,

        tglx

---
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 3259b1d4fefe..118d9f7792ee 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -279,6 +279,15 @@ int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level)
 
 	if (lvlid >= MAX_LOCAL_APIC)
 		return -ERANGE;
+	/*
+	 * Spare the exercise on UP as there is only one instance at any
+	 * level and the map check below might fail because the CPU does
+	 * not have a local APIC or local APIC has been disabled on the
+	 * kernel command line.
+	 */
+	if (num_possible_cpus() == 1)
+		return 0;
+
 	if (!test_bit(lvlid, apic_maps[at_level].map))
 		return -ENODEV;
 	/* Get the number of set bits before @lvlid. */

