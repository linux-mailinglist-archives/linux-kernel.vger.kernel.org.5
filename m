Return-Path: <linux-kernel+bounces-104738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF4387D2F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A28C7B210D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D14C635;
	Fri, 15 Mar 2024 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="io5Jwlx2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rzl3uy7Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F54AEC6;
	Fri, 15 Mar 2024 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524446; cv=none; b=Ep/eeNf+89OHieUmz7LOgHnp2PEvuE2KY8Q5bKgPnHXdeb0dyWK1SbPyZV1L9zRyVDVqt5STIN8anfLeS85mHmhwOar0d/nW3PmZQjmJXmpbjjQDWYUohT4iJGt6asbAjcc2hkDYpXmqfTdkgWwMgUT42D4WZIfUzWuZoDWE5C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524446; c=relaxed/simple;
	bh=+P6cYE986o0G9h5M0KvP9uEpUTHZAkf7yj89OpBYdmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HyfP6kvkDi6FmxO2v1tv8SPt4eRTCMSRDHyHenjJxxg43HwhKHWBtABNylhZumy4/17hC6S/17u5FMLib99lGOKoafrY4h+k88lEZfkOIHbNAQIoyTCyIygLlDjyJwvJdXNOfPlOm8ig/seLKOZdctDcy4t9C826hE8Xqe3kWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=io5Jwlx2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rzl3uy7Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710524443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1wKAoieX4GWiPiXZklKeg/Psrl4l9AmnBkO9+pwsixM=;
	b=io5Jwlx20Rn73Kus+artMPOdGRv/nsSZUaxjK+F1FyQTO70i03B4GnU3VriOIgqmBpm1i4
	3dxE99wDhfIwJClUFBVaQzbujAjl+qdfdORmswqzOeKq7QU50/Cw4lPz8FbGMK6etl0NHv
	nipNwSJ0BXYqR/7odjONCNF+K6k0HQTtdZE4Kf+JqaXtO57Plu4RKROxMz/MESxdnZQCOA
	d6MX2hWcABk2Oj91PWx8+fXKB5LuUZYkIdeWGzgrJfsg0hioGKle2ASJo8SfbjrrZTnrUJ
	l5L94yPyf3l5Jvuz8pl4UGLdLCdxtnAoqcY8b+dThcpYH4sqdZrNlm6u1gGlWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710524443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1wKAoieX4GWiPiXZklKeg/Psrl4l9AmnBkO9+pwsixM=;
	b=rzl3uy7Q5ii/hnmpFveouaIiGlaqvgUPZU3r5T0nIPbtAXrYn6EoNtu9r7Sg/w30WOXKy0
	oDYBm6oVEtUmtqCw==
To: Linus Torvalds <torvalds@linuxfoundation.org>, Guenter Roeck
 <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Uros Bizjak
 <ubizjak@gmail.com>, linux-sparse@vger.kernel.org, lkp@intel.com,
 oe-kbuild-all@lists.linux.dev
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
In-Reply-To: <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
 <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
Date: Fri, 15 Mar 2024 18:40:42 +0100
Message-ID: <87y1ajjsv9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 15 2024 at 09:42, Linus Torvalds wrote:
> On Fri, 15 Mar 2024 at 09:17, Guenter Roeck <linux@roeck-us.net> wrote:
> Without line numbers (if you have debug info for that kernel, it's
> good to run "scripts/decode_stacktrace.sh" on stack traces) it's hard
> to really know what's up, but I strongly suspect that it's this:
>
>         rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
>
> because we have
>
>    topology_logical_die_id(cpu) ->
>        (cpu_data(cpu).topo.logical_die_id)
>
> and we have
>
>     c->topo.logical_die_id = topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);
>
> and topology_get_logical_id() does this:
>
>         if (lvlid >= MAX_LOCAL_APIC)
>                 return -ERANGE;
>         if (!test_bit(lvlid, apic_maps[at_level].map))
>                 return -ENODEV;
>
> so that -ENODEV is not entirely unlikely for a UP run.
>
> This also explains why it *used* to work - that whole thing is new to
> the current merge window and came in through commit ca7e91776912
> ("Merge tag 'x86-apic-2024-03-10' of ...").
>
> Thomas, over to you. I wonder if maybe all those topology macros
> should just return 0 on an UP build, but that
> topology_get_logical_id() thing looks a bit wrong regardless.
>
> It really shouldn't depend on local apic data for configs that may not
> *have* a local apic.

Right. Let me look.

