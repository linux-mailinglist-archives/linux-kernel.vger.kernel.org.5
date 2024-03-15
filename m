Return-Path: <linux-kernel+bounces-104032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CC787C810
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33821C20E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854FEDDB3;
	Fri, 15 Mar 2024 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0yMAhMOE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j6KTCR0C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D057D529;
	Fri, 15 Mar 2024 03:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710474123; cv=none; b=h6bxETXCSDkK2NL8hfNwLCuNY+rclrNnTy5t0+RWIZkf/4SASDn30g0ztyuqks5z1Hx5Fa78mi6SZv6fLWWEEyz9//GObNI9ze1yubUgph//Og5TmIjv2TinlSyUnIXl50fpOjlZBHa5ikz5F6t3sTx1tEchzRZbs3tbsp2qaRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710474123; c=relaxed/simple;
	bh=qFwYzpyJJ4NK6tII7INFj3TlsiX1d4gDtSntFjvpnxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qsuf50bnKtO3PmvUO9GEnajKtxSSSqu3n7HOxRhXzhTDN7HiDvBC4Ca+6s/HgqCqWyw7C94PB3CPTSOTZyfSGWuoIC9bbJs5cLL/0MVLqjabceNJ+tE13918A03Pz0q5hYo3U19RWLiFpjNi3H0/HAhOx+ikIuQrttpzpOOPYUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0yMAhMOE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j6KTCR0C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710474120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6yhiK0T3M/mv1qJaDNYYpBRpuW+wgtid0VYYoXXfl+U=;
	b=0yMAhMOEbDigULVlhnioC3kDJW7hKPnt5MVROKOUbtCq15FJrqGEf//R0KNZXPuhgFjQlX
	W6x/LXiDCIE8EvMMNFLreYKVDOdM6lYukX7ok1qdfRtjLPEkicXNKLHVhNfGs/DtiVMLRY
	vo6EPlht4RY/2850GIoUfk73wGBvO+OX/4mq6SKH4aBxXhKcl5Guu/+ebhzL0223NLTSRu
	xB4tsUOPQYFkIF32NabV5X8YwpwEunQHCv/leYIHq8gvAq+sdYNvp9A3Px4OIl4h5ZJy4M
	cFWs4mgOS6sHC6X4yZIJTZgjJdmd3+wo+Zg859xlproe2W1ILwezUVGKPgBw4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710474120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6yhiK0T3M/mv1qJaDNYYpBRpuW+wgtid0VYYoXXfl+U=;
	b=j6KTCR0CEeeEMN3bzbxcmzR7cnYgg9NedtTBGABTxroBgXXq5a+Iw/nJvJ0XJPSl98rIiO
	vs+cSWECFoDR1aBQ==
To: Enlin Mu <enlinmu@gmail.com>
Cc: Enlin Mu <enlin.mu@outlook.com>, linux-kernel@vger.kernel.org,
 enlin.mu@unisoc.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hrtimer:Add get_hrtimer_cpu_base()
In-Reply-To: <CAAfh-jM6TSbFHUYCi0kC7JgszCaz=-So7+=at-aDfTSrOPjraQ@mail.gmail.com>
References: <TYSPR04MB7084FCAF74B4CFA30D386B698A2A2@TYSPR04MB7084.apcprd04.prod.outlook.com>
 <87cyrxm7ua.ffs@tglx>
 <CAAfh-jOu0hG1hfWX9kL_gOXkSLXEVGNkddP-azO=pjNAKsRGhA@mail.gmail.com>
 <877ci5m3c4.ffs@tglx>
 <CAAfh-jM6TSbFHUYCi0kC7JgszCaz=-So7+=at-aDfTSrOPjraQ@mail.gmail.com>
Date: Fri, 15 Mar 2024 04:41:59 +0100
Message-ID: <87h6h8kvp4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15 2024 at 11:12, Enlin Mu wrote:
> Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=8814=
=E6=97=A5=E5=91=A8=E5=9B=9B 19:59=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Thu, Mar 14 2024 at 18:45, Enlin Mu wrote:
>> > Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=881=
4=E6=97=A5=E5=91=A8=E5=9B=9B 18:22=E5=86=99=E9=81=93=EF=BC=9A
>> >>
>> >> On Wed, Mar 13 2024 at 05:30, Enlin Mu wrote:
>> >> > From: Enlin Mu <enlin.mu@unisoc.com>
>> >> >
>> >> > On the Arm platform,arch_timer may occur irq strom,
>> >> > By using the next_timer of hrtimer_cpu_base, it is
>> >> > possible to quickly locate abnormal timers.
>> >> > As it is an out of tree modules,the function needs
>> >> > to be exproted.
>> >>
>> >> No. We are not exporting for out of tree code.
>> > Can you explain it?
>>
>> Exporting functions or variables requires an in tree usecase.
>
> OK, Thanks, I  got it.

No, you did not get it at all.

Q: Where is the actual in kernel use case which utilizes the exported
   symbol in a module?

A: There is still none.

For further clarification there will be none ever because you are
violating all encapsulation rules of the kernel subsytems without
providing at least an attempt of justification.

Nothing outside of the timer core subsystem has any business to fiddle
with this data structure ever. Period.

