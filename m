Return-Path: <linux-kernel+bounces-147451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C9F8A7464
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6B51C2130D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976A4137C23;
	Tue, 16 Apr 2024 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="OVAL6Ibt"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5247313777F;
	Tue, 16 Apr 2024 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294615; cv=none; b=jdspJkRVkPW1oLQGQ+RMWHO88WPTRIcpRiQ9Uv98SazMjALGUcBjLLZFtCt7096fUPJFOLJo0oA+SO6VFn3kW7XsRf23pLSPKMLrhWJAAMul2cVe7fBR5Y2mRS9vHTKRbOmdZTV1rdcprFbfq9iELcCsj1gAf07ewu9Bdb88Yqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294615; c=relaxed/simple;
	bh=WQTkJLLntSkg4Yc3SDjamszWTI1ugXj8/1kk1dIE0XA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnF1BKwNd0VDHW40iMi03iVkzoQ36nrLCVaPNmJAi/6gGe2tZND5EsWMvoDqNaCZPwSv0pXmJL6rcD8nb5wYXwTMb3T5opVD+JMFOphBMPvQAlNqxRe1xHcenj/FU86E4nxlIgfbjsYd39OS8I4rDG3BG81h5Ab5xCn/bySX6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=OVAL6Ibt; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1713294606; x=1713553806;
	bh=WQTkJLLntSkg4Yc3SDjamszWTI1ugXj8/1kk1dIE0XA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OVAL6IbtkrYJSVYkHbt/zf2IMqOMpqMBX3SR3yVmni9/IF1t1ZPHIAL38on6j0bEM
	 Tu+7U6a+rbvr+YRgjqdUQ2UE0juI1uA/mRY6BRq9uv/yK0i/y0W5ObE9fxmwauQo02
	 s561qIhmPsG/ot4kMUSYiORhQVVNWpqZLwsQG9BD88e0km4ztR1jmOjC9QT1Nf3jqT
	 xN2tyse2iR9hbX51ltbuTfgVY0nbqEW0qrkSZCFMtcAQGEgKuzz4Vu1CDMgeC2KdFS
	 P2AD9yMEel4CWeUqP9zuBCEA6dcCzeejPW3C7kRxn7gfozigLPumpRP5+7/veJah8B
	 6+gbbDim6mcJA==
Date: Tue, 16 Apr 2024 19:09:52 +0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: Michael Pratt <mcpratt@pm.me>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Wander Lairson Costa <wander@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH v2 2/3] serial: 8250: Store whether fifo device is enabled
Message-ID: <TYV02sftzpleM60PqVjM3niI3BqS03AyOPPAg0urAoBKyhgGGQyq1OSkZQM8aZ70Q-KaT7-lYiHl9xH-wjcdsMNvKPiJZDsvwC1uN5uEn7E=@pm.me>
In-Reply-To: <Zh7Jqf2sJNw1mVyJ@smile.fi.intel.com>
References: <20240416182741.22514-1-mcpratt@pm.me> <20240416182741.22514-3-mcpratt@pm.me> <Zh7Jqf2sJNw1mVyJ@smile.fi.intel.com>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tuesday, April 16th, 2024 at 14:55, Andy Shevchenko <andriy.shevchenko@l=
inux.intel.com> wrote:

>=20
> > @@ -3392,6 +3392,8 @@ void serial8250_console_write(struct uart_8250_po=
rt *up, const char *s,
>=20
> > + up->fifo_enable =3D use_fifo;
>=20
>=20
> This seems incorrect / not the only one place to assign this. What if the
> console not enabled at compile time? What if it's not enabled at boot tim=
e?
>

This is 8250 specific, and currently, it's the only place there
where it's decided whether or not to use the fifo device
by checking a bunch of flags and values.

If you're suggesting that these checks are moved out of this function somew=
here else,
I would probably agree with that, but let's save that idea for the future..=
.

If you're suggesting that there could be a null pointer, I don't think that=
's possible
in this function... (the name of the pointer being "up" might be confusing?=
)

Sorry if I'm misunderstanding what you mean.

> --
> With Best Regards,
> Andy Shevchenko

--
MCP

