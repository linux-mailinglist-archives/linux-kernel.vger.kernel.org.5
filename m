Return-Path: <linux-kernel+bounces-63720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6C5853399
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B40286D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBE75B20F;
	Tue, 13 Feb 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLJi+XbP"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCCD5A7B7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835913; cv=none; b=XNzpdlNzyh5C9VSRWtFF7oB11kKvZP/2m9eFBvhkeyzRU7c5kgqSN9R1ds642nDzbwqQLwBKpNq/fVHBz6fHdKNVMYz8Gr46PAQfwNBlhR5i25ohwLV9F9BwDzV6ghSA0Oqy4PhCC3ZcPUkyE1P4vQNKGO4ONo19VEZE332q9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835913; c=relaxed/simple;
	bh=RT+W1llQ2r6hGJ2t8R1MHmof1Jb0u4B+SyQ/6sc6Ooo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWzyhIS3RVdiMGTL1G3xS+78smmr0+MkweqTWYhC6aPF4pfib/hZgXOdcz+P9OR+vjikbur7l3uo1e64HAhAz2PML6gGGDJ0qSaejxK+us3xw7pTxCuw3wf4ccfm4V4Kb37QUPLR2E3VmMlIJ4vnKQ2Uipi0l1mfoHDxQXgPXXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rLJi+XbP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so10772a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707835909; x=1708440709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMWDpGfDclpJH/Ggj2FwXDcO3lILA0riLoFGeoe6y8s=;
        b=rLJi+XbPHgA+xjmPulEAK8ADas8+q4elMrkva0fxiNioZbQ9mG0V9PnDduUW3zyegK
         kidLXmXdYDehgpmFcpCvcw4/QZiz9zW0gcw9+HHAny5O+t+DiGaU6gxbroufLZdBwT91
         ex07EHVLL47ptjx5FUasZCPSsrDfL2oIG2d1ZNnM+wOel/QFg3A3ceBzdYk2MqiJG4HT
         SgVS6SurZ6uPFlkojlnhaogpXvkfjMueRkuWAikclG6JIs80h5NgciWp2oR/dRoA4htM
         1ig0s5vMt6befWsq4YDf300GHY5y+hGBuKrtTbEoQi2daUApb7FvGdQ6RRbRec+u4s/M
         vaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835909; x=1708440709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMWDpGfDclpJH/Ggj2FwXDcO3lILA0riLoFGeoe6y8s=;
        b=s7ok6VyAJKuxlBqM9EnYl/ZggcNxwsS6+PHgZiNm+utjvnYuByXySSzREaCTpkSeoh
         QEAxbuptVvvs/s4s+BynxZEtdviJMTcADut15dB4BqSHTupzod5A1q7dfBJSVcqUsgkt
         bzKpxhJA+CKb52ndsjvUDqDxGnBuhNpxah56T9NfbvNPJINuDGZDQ+HMJTSaw/Dv/y1P
         KBrv/sJIu7zSCDbQgE54Uh5Ua8lp54R0Ro5jXG6LXJjeBARIA9VDfsrNHeApD0DC6kE1
         PxaaIpPZX9X9vzNZrB4CXubkjujYiL1T6w/UA+Tt1MV/RzSxSY5a96vQ+2Af5ZBlyZ+G
         1QlA==
X-Forwarded-Encrypted: i=1; AJvYcCWj73+AfB5yzh70zc8HmhrGPOTUp6LCz2+oWNb1L7WdqlvcVbo3j+PH/YmII64y2boR1vd7URX/vrb1NIL0b7MKgKEJS3zjct1VtdW+
X-Gm-Message-State: AOJu0YyQ5bxlivmtVUWooQO3e2/jnaHBAj17Or2Q1pHOHEiw7GJqU5vU
	xFAqB/l/tYSATZ/Y4hzWdkoqlJ7HQ2jyM+gke9cGy0ivxuPggfYbNZcUDhTvAGPj5nEdIDm0Da3
	dvPaDeAmYn7MfP7CYwG2TtlILGpOTDuNR5Vbt
X-Google-Smtp-Source: AGHT+IGfqYACGEjUOI7V/Rpir4fZ5TMPFFsY+2iSCEWPhBFRoQxs5ewCRgGTA1Fws5XWHQJLWgigu9RN1cYbpTwOfTE=
X-Received: by 2002:a50:d581:0:b0:562:deb:df00 with SMTP id
 v1-20020a50d581000000b005620debdf00mr47709edi.4.1707835909232; Tue, 13 Feb
 2024 06:51:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203190927.19669-1-petr@tesarici.cz> <ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net>
 <Zct5qJcZw0YKx54r@xhacker>
In-Reply-To: <Zct5qJcZw0YKx54r@xhacker>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 15:51:35 +0100
Message-ID: <CANn89i+4tVWezqr=BYZ5AF=9EgV2EPqhdHun=u=ga32CEJ4BXQ@mail.gmail.com>
Subject: Re: [PATCH net v3] net: stmmac: protect updates of 64-bit statistics counters
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Petr Tesarik <petr@tesarici.cz>, 
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

On Tue, Feb 13, 2024 at 3:29=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Sun, Feb 11, 2024 at 08:30:21PM -0800, Guenter Roeck wrote:
> > Hi,
> >
> > On Sat, Feb 03, 2024 at 08:09:27PM +0100, Petr Tesarik wrote:
> > > As explained by a comment in <linux/u64_stats_sync.h>, write side of =
struct
> > > u64_stats_sync must ensure mutual exclusion, or one seqcount update c=
ould
> > > be lost on 32-bit platforms, thus blocking readers forever. Such lock=
ups
> > > have been observed in real world after stmmac_xmit() on one CPU raced=
 with
> > > stmmac_napi_poll_tx() on another CPU.
> > >
> > > To fix the issue without introducing a new lock, split the statics in=
to
> > > three parts:
> > >
> > > 1. fields updated only under the tx queue lock,
> > > 2. fields updated only during NAPI poll,
> > > 3. fields updated only from interrupt context,
> > >
> > > Updates to fields in the first two groups are already serialized thro=
ugh
> > > other locks. It is sufficient to split the existing struct u64_stats_=
sync
> > > so that each group has its own.
> > >
> > > Note that tx_set_ic_bit is updated from both contexts. Split this cou=
nter
> > > so that each context gets its own, and calculate their sum to get the=
 total
> > > value in stmmac_get_ethtool_stats().
> > >
> > > For the third group, multiple interrupts may be processed by differen=
t CPUs
> > > at the same time, but interrupts on the same CPU will not nest. Move =
fields
> > > from this group to a newly created per-cpu struct stmmac_pcpu_stats.
> > >
> > > Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics wh=
ere necessary")
> > > Link: https://lore.kernel.org/netdev/Za173PhviYg-1qIn@torres.zugschlu=
s.de/t/
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Petr Tesarik <petr@tesarici.cz>
> >
> > This patch results in a lockdep splat. Backtrace and bisect results att=
ached.
> >
> > Guenter
> >
> > ---
> > [   33.736728] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   33.736805] WARNING: inconsistent lock state
> > [   33.736953] 6.8.0-rc4 #1 Tainted: G                 N
> > [   33.737080] --------------------------------
> > [   33.737155] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> > [   33.737309] kworker/0:2/39 [HC1[1]:SC0[2]:HE0:SE0] takes:
> > [   33.737459] ef792074 (&syncp->seq#2){?...}-{0:0}, at: sun8i_dwmac_dm=
a_interrupt+0x9c/0x28c
> > [   33.738206] {HARDIRQ-ON-W} state was registered at:
> > [   33.738318]   lock_acquire+0x11c/0x368
> > [   33.738431]   __u64_stats_update_begin+0x104/0x1ac
> > [   33.738525]   stmmac_xmit+0x4d0/0xc58
>
> interesting lockdep splat...
> stmmac_xmit() operates on txq_stats->q_syncp, while the
> sun8i_dwmac_dma_interrupt() operates on pcpu's priv->xstats.pcpu_stats
> they are different syncp. so how does lockdep splat happen.

Right, I do not see anything obvious yet.

