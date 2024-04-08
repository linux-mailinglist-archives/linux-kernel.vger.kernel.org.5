Return-Path: <linux-kernel+bounces-135022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BE289BA0C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E122809E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EEC3BBC8;
	Mon,  8 Apr 2024 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lwMEQRfP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2gAX/aOT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA753BB20
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564438; cv=none; b=TOz+VVi6VR8L98mx4+bnxsqA+BqAhdOMDYuXer3z3y6Q/Jw9H4d3Rixr4YBJOc2L/XXb5RiV46idaBuFLwMBqzFpGcGj3r0PdTcMSdP5yDx/PxqM1qZeYfsBWRlate56JCEodQ8zG8VNSotj3Zb2+JeBKKgSTd/kqo/k7RQqrpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564438; c=relaxed/simple;
	bh=6KcrIOycZ3UQaXDbv1ynZutea7vqMZldQFCg0ePvU1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gqR5bEBJaAKisUKXv1lj5UhsM1xmMcTbzTjeaHbi211c6gBRqQPOnDGzfjkRWzBZkCGF42UirOhhP/eMEmnoCSiop1Rhs2r53m7HlKu+8CUylQ7NWpliSE78q/trJAcWyAmS7Tb5iiBj+BmXACKzuirpr6d2FqbDKC5e2V+9nNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lwMEQRfP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2gAX/aOT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712564435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMVoXZYiIlU4ozo0MMikevpPJnSQyAU1xeiARptVQkM=;
	b=lwMEQRfPQrZHwqAmcMB4zNpJtkLi8QKVo1LTD3fkZGIpURL/vTWo+9kgfnEW1cv4kVfHzr
	Ze3Scqi//prSRq+m1VLRkfo89oq/Y/xSC9UrJBTUcCWKgSZ8BAdI5LFDw+9szCOHb0AOmw
	yr3DkRPJh35NxSaNFQvLXLuUECDnsGFxmEpkwD2UN6wdixnobDoR5u6ar9QBVTx5rWngD7
	lh2q8tdL/PNGhcR+8mnBhQZcOkZ+uahk4bjlZOJhcSivzp4Sm2/HyRiZMvPUJ9nrnriot7
	Wtugu9jamIGI4eli0RYeP5yAg66PT59MePdEj75w0QucKbX7JgbBn1IEVW17WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712564435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMVoXZYiIlU4ozo0MMikevpPJnSQyAU1xeiARptVQkM=;
	b=2gAX/aOTReJ9BYRzukzs7x7HXkdrbC/ojll590P0SHoWe3KeuMrM0gwSI190xlkZrlKcoX
	KpZCGlL7nYVBSsDg==
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge
 Chromebooks
In-Reply-To: <87msq797pf.ffs@tglx>
References: <87ttkg7wvg.ffs@tglx>
 <20240405135837.306376-1-laura.nao@collabora.com> <87msq797pf.ffs@tglx>
Date: Mon, 08 Apr 2024 10:20:34 +0200
Message-ID: <87zfu46zal.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Laura!

On Fri, Apr 05 2024 at 16:59, Thomas Gleixner wrote:
> On Fri, Apr 05 2024 at 15:58, Laura Nao wrote:
>> On 4/5/24 15:38, Thomas Gleixner wrote:
>>> 
>>> Can you please boot a working kernel and provide the output of:
>>> 
>>> # rdmsr 0xc0011005
>>
>> # rdmsr 0xc0011005
>> 2fabbfff2fd3fbff
>
> Ok. So the CPU does not advertise FEATURE_TOPOEXT which is consistent
> with CPUID.
>
> Now I'm even more puzzled because then the patch I gave you should make
> a difference. I need to run some errands now, I will provide a debug
> patch later this evening.

Hmm. No real good idea yet.

Can you please checkout

    c749ce393b8f ("x86/cpu: Use common topology code for AMD")

and apply the patch further up in the thread and see whether that
boots. We'll take it from there.

Thanks,

        tglx

