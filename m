Return-Path: <linux-kernel+bounces-139263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4120A8A00AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E381C22EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76674181327;
	Wed, 10 Apr 2024 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HMDN2imC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VF7GiSeX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021913C9BB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777677; cv=none; b=L/MSMld5fKRAvosdKEXhRwYlPuiLG0ArUVhpEYn0kC2jU/1tYoTbSHUHvkQnbQdlHCTHlTXWxx+jEiBA4tQ0ULCfB9KK/TM8dBCPf7BqJpN7PMMRjuVuYwratpNK0csitwbpvwueEC6+XlMlP4mNABqJdfAtAKfFA4k46MpbOhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777677; c=relaxed/simple;
	bh=fY6+WvW3hkdWZaAxo0deKXe/8KWqIVNXBr2BIirxmTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R+ahsr+IvqJkrvCmAR8TgwJnrPTgggGmP1g4IhQySXCWfT4a7wHBf3/wRtOH9TUonC2NiaRdkF3zS2b48nMqclPB4GnkdN0NOLh9V+ObFNfDvLC+nQjdU56hF1i5IEAPlVyM17lwyxvr51K4HmVT41mKjxyLosdPyggrhdh9vQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HMDN2imC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VF7GiSeX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712777674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zp/EtX3qMN10K3KBzcAg3kdV/12QTlHSX0dqop3x9f4=;
	b=HMDN2imCIBN/b7ktsutXjXqjRDR7ntAAA/CnE+hm6mQ7/sJYLvqEE0lO3XArMcjBDvKRAl
	jiUd4PIbqpIjqAtMgcitbHG0IaLWwpxeGBKAo1SvQ/Q0F18FN5THvocPgVleXQRGWwrv1W
	Vzconq2cnuM3ymru3Nwgz/OgNNsv+VTD8X68fKB4WtpCpyoOER2qd4Clo+EabHdW1x6gwJ
	QiHJWGRLyIBsv/Z6fj2kEUpp5GjSCL3FrZT+wCxwk6H5Z0gYFTaGoJ6MJvCK/HEp3MzSgL
	1TluufqU/8ppM/lHE85jqmdgwTLCj3pnN0Ppv5op2izJlEZ4DAkSj7QToDTClA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712777674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zp/EtX3qMN10K3KBzcAg3kdV/12QTlHSX0dqop3x9f4=;
	b=VF7GiSeXE+n5qF/XYUxQetLULBfufOdvK8N14QmUpiVo0kAUVsFM29l1FkIntAvtxJmjLL
	2+Gn94YJs4hqjxDA==
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge
 Chromebooks
In-Reply-To: <20240410161141.261818-1-laura.nao@collabora.com>
References: <878r1l48xn.ffs@tglx>
 <20240410161141.261818-1-laura.nao@collabora.com>
Date: Wed, 10 Apr 2024 21:34:33 +0200
Message-ID: <87il0p2era.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Laura!

On Wed, Apr 10 2024 at 18:11, Laura Nao wrote:
> On 4/10/24 15:57, Thomas Gleixner wrote:
>> I just moved the exit check a bit so we should see the scan info. That
>> should tell me what goes south.
>
> Here's the full kernel log with the latest patch applied: 
> https://pastebin.com/raw/r2CkP396

Ok. Now I can see it.

	pr_info("NPP %u\n", tscan.amd_nodes_per_pkg);

The output is:

<6>[    0.000000] NPP 3

The original code then reads out 1, which is what's expected on that
machine.

Now that bogus value '3' is used later in

    a %= b / 3

as b == 2, the division result is zero, which makes the %= operation
crash with a division by zero. As there are no handlers yet, nothing to
see.

The problem causing the bogus readout sits between my keyboard and my
chair.

I'll send out the fixes with proper change logs later tonight.

Thanks for all your help!

       tglx

