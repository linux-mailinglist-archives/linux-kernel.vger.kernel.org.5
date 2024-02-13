Return-Path: <linux-kernel+bounces-63837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E62853545
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135E21C22E76
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE545F859;
	Tue, 13 Feb 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MtvDxhL+"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF65F575
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839587; cv=none; b=tzhw9GBf+JRwOztSw+zV0m+m9XQ6j6Z1xd1Ry0CtRYpr8LrMAh6gE5XIE0aV5YWgEyvTcbSk+ZamP1aSs6cRS4R/OVBszzCb39oQaP9Kvv1ZPgEgKBaVsoVpv4sMq5jhUdb+msWntq/Bs3jPhYIWAHYDXleHo3f8ERNcHYxw2Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839587; c=relaxed/simple;
	bh=9A1aL1knmmwJVorj88nXW9OtdjLYNUKnXWl0BQKd3Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkFykBAP86DxmyaZCEUYVc9zGnPrJ7BpML6XooIR+2EPgOl8ZGOrRgKrOPguEGBq8IMMgoobQNN/v/br3tuZcJjE9wlH+t12Gbsnp+k55l7lBg3urMwWiODz6CBfJtmPs2wOHWhh3wLbYrVUu+/RTniTL1TC3qEwKPJ/eeuzeo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MtvDxhL+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso11269a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707839583; x=1708444383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBXU1a0C1GpqZ/Yh6XHCPcPsqtZQLKwjO20TKE3Arqc=;
        b=MtvDxhL+Dv+2hyfcuuBkK78bTBhM8FfextBcZIxytdEiWQEgC1Y99i1cSR6iB6zg/D
         RnxU8E4b/Db3z3FT1Hok1qS2/uQSWTTb5oHtD4U1uyVO8xREFmEx6AxUJ6cPK/2OJEbM
         gZUpawNo1bC37nabqUOreN1Zl1FwIlu2qHbGAoA5KeONGYsgBBWkm2uz9a4N7osjuFYO
         IBraaTw+pVYTgCwuFLeL7+QmkkVtOkzy6LCUhV2rhEkQCHW0N/41NnQAQ8Xeax4xJY5k
         f2wFuRjRoOobP01Upx3WGkKOHJZRvimLdssbJvGtORWgAqHVBbt1dA0MiQqV5CNd96HQ
         kw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839583; x=1708444383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBXU1a0C1GpqZ/Yh6XHCPcPsqtZQLKwjO20TKE3Arqc=;
        b=JjxzezJocT3c/esKxCkTKDSd+ZSD7Iwv0/m3ynTWuFxy5Ktm+ViIW8S8MaUIJcieIj
         zeWk6Xy5U2JTTA4qqugWUz/2S2QQjr61AQbk0cIX4JWx/c/GH1QFOK/daw8cEDG8C88f
         eZCw92hRVWQg0v0/JNllMU7zDOuw+B7eZbj4nyaauxGbylilAapqeXW/XIreI48KJfc1
         XLDU8vlvNdMoDvNHjwKvS8UUD4SZIlLqfyRc53XtCYVJxTQ6VOqHi6sjEPhwGNgRO7qS
         0UOHhGEYhJ1+DLfMBkBrPftXBjdFBx48pAmwMOpDKEEJCmO9YgkeWwpNYy6HFBL1QJUb
         El0g==
X-Forwarded-Encrypted: i=1; AJvYcCVGT2f8EleJaRp8rYYgp5D7FU0dr3fBBdFv7AvPxXKiqFDTvkalBy1/xec/KcR4k8Y0VNuWJwZzVHRH/VPZpw3AWryfMoZqYyxbMP/8
X-Gm-Message-State: AOJu0YwOVVLg4xN3v1PusDfvX+BEQoIoqoSFxqQVZ7/6Bb3Q5DJG7I2M
	NqcEamS1FV1D1z9l5kkI4vGSAZIw0ashOEheHid7j46ZU9Tu4njSYmw4k5kiI3M3q+bSLOvy+B2
	KbgEsBRxAU9RVbTU7drpez384yEvhIQ9FG75+
X-Google-Smtp-Source: AGHT+IHO4nXHXvIeiK2c1XPlkV5MqBQcEx/6pbzTc8rR72I7ntPP6rrE8mRSCDELaXel/6Zxu9D7gKkN/LWr+JpZIgM=
X-Received: by 2002:a50:9f08:0:b0:561:e7d8:50a8 with SMTP id
 b8-20020a509f08000000b00561e7d850a8mr5534edf.0.1707839583026; Tue, 13 Feb
 2024 07:53:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203190927.19669-1-petr@tesarici.cz> <ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net>
 <Zct5qJcZw0YKx54r@xhacker> <CANn89i+4tVWezqr=BYZ5AF=9EgV2EPqhdHun=u=ga32CEJ4BXQ@mail.gmail.com>
 <20d94512-c4f2-49f7-ac97-846dc24a6730@roeck-us.net>
In-Reply-To: <20d94512-c4f2-49f7-ac97-846dc24a6730@roeck-us.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 16:52:52 +0100
Message-ID: <CANn89iL1piwsbsBx4Z=kySUfmPa9LbZn-SNthgA+W6NEnojgSQ@mail.gmail.com>
Subject: Re: [PATCH net v3] net: stmmac: protect updates of 64-bit statistics counters
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jisheng Zhang <jszhang@kernel.org>, Petr Tesarik <petr@tesarici.cz>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, Marc Haber <mh+netdev@zugschlus.de>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 4:26=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Tue, Feb 13, 2024 at 03:51:35PM +0100, Eric Dumazet wrote:
> > On Tue, Feb 13, 2024 at 3:29=E2=80=AFPM Jisheng Zhang <jszhang@kernel.o=
rg> wrote:
> > >
> > > On Sun, Feb 11, 2024 at 08:30:21PM -0800, Guenter Roeck wrote:
> > > > Hi,
> > > >
> > > > On Sat, Feb 03, 2024 at 08:09:27PM +0100, Petr Tesarik wrote:
> > > > > As explained by a comment in <linux/u64_stats_sync.h>, write side=
 of struct
> > > > > u64_stats_sync must ensure mutual exclusion, or one seqcount upda=
te could
> > > > > be lost on 32-bit platforms, thus blocking readers forever. Such =
lockups
> > > > > have been observed in real world after stmmac_xmit() on one CPU r=
aced with
> > > > > stmmac_napi_poll_tx() on another CPU.
> > > > >
> > > > > To fix the issue without introducing a new lock, split the static=
s into
> > > > > three parts:
> > > > >
> > > > > 1. fields updated only under the tx queue lock,
> > > > > 2. fields updated only during NAPI poll,
> > > > > 3. fields updated only from interrupt context,
> > > > >
> > > > > Updates to fields in the first two groups are already serialized =
through
> > > > > other locks. It is sufficient to split the existing struct u64_st=
ats_sync
> > > > > so that each group has its own.
> > > > >
> > > > > Note that tx_set_ic_bit is updated from both contexts. Split this=
 counter
> > > > > so that each context gets its own, and calculate their sum to get=
 the total
> > > > > value in stmmac_get_ethtool_stats().
> > > > >
> > > > > For the third group, multiple interrupts may be processed by diff=
erent CPUs
> > > > > at the same time, but interrupts on the same CPU will not nest. M=
ove fields
> > > > > from this group to a newly created per-cpu struct stmmac_pcpu_sta=
ts.
> > > > >
> > > > > Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistic=
s where necessary")
> > > > > Link: https://lore.kernel.org/netdev/Za173PhviYg-1qIn@torres.zugs=
chlus.de/t/
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Petr Tesarik <petr@tesarici.cz>
> > > >
> > > > This patch results in a lockdep splat. Backtrace and bisect results=
 attached.
> > > >
> > > > Guenter
> > > >
> > > > ---
> > > > [   33.736728] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > [   33.736805] WARNING: inconsistent lock state
> > > > [   33.736953] 6.8.0-rc4 #1 Tainted: G                 N
> > > > [   33.737080] --------------------------------
> > > > [   33.737155] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> > > > [   33.737309] kworker/0:2/39 [HC1[1]:SC0[2]:HE0:SE0] takes:
> > > > [   33.737459] ef792074 (&syncp->seq#2){?...}-{0:0}, at: sun8i_dwma=
c_dma_interrupt+0x9c/0x28c
> > > > [   33.738206] {HARDIRQ-ON-W} state was registered at:
> > > > [   33.738318]   lock_acquire+0x11c/0x368
> > > > [   33.738431]   __u64_stats_update_begin+0x104/0x1ac
> > > > [   33.738525]   stmmac_xmit+0x4d0/0xc58
> > >
> > > interesting lockdep splat...
> > > stmmac_xmit() operates on txq_stats->q_syncp, while the
> > > sun8i_dwmac_dma_interrupt() operates on pcpu's priv->xstats.pcpu_stat=
s
> > > they are different syncp. so how does lockdep splat happen.
> >
> > Right, I do not see anything obvious yet.
>
> Wild guess: I think it maybe saying that due to
>
>         inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
>
> the critical code may somehow be interrupted and, while handling the
> interrupt, try to acquire the same lock again.

This should not happen, the 'syncp' are different. They have different
lockdep classes.

One is exclusively used from hard irq context.

The second one only used from BH context.

