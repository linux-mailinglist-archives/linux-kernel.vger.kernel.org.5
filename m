Return-Path: <linux-kernel+bounces-93727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6302E873419
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B9EB2C219
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4651660262;
	Wed,  6 Mar 2024 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ax8isse2"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF845FDA3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720254; cv=none; b=pIgMyZJjEPIeMopQQrRJ8OVhyy21cx/ooGTBRSd/BcR0U5ZBEettB3qzZC/OITA2eeNaN1WYFPrEZyYhZoXzp3pMzx0W3EidtcEGJeftY4gHnAnhVR3pX13VhH4zTy27XJW3oX/DvPzTDwE+eccHbiZTKqLin60H/s6SsySX7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720254; c=relaxed/simple;
	bh=aftI2J7tWkan9F3k+WavIQOst/Q5zH24e7gYDaM6WSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=makjnKLtylsSVYqAbKBO9QIYzdYzLdemvKCQ0AosGroyZvPo45O8zt74eqPO20Tc86DSO4PSbHwaV0ONOHDojDZZ6P/+ShwEnzV/4YH1jmQc5s0JuBysuHDDExswS/C+Zsrt+33bDvNBefZQssH+vtetzkYNtXr3HWS6nNvRhg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ax8isse2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso10767a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 02:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709720251; x=1710325051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXp3dvj8RXyd5VC25WQpvIY0TxZT9QViO+VH9V+80YQ=;
        b=ax8isse2Qrt0neu0ZgmwndWhy7bYynNrWDe28OZRNaaw2JYZIq0xVm1XBTNvxoOv3K
         M+U6YZLd8aP47h6FFpkqu2wx1HnIapmxb1+dfMitbmcrjfnZwb8yiwvpX5ybi/9iJsSH
         qeJytmX5UIU1kuvKoCs1+uq4uBKG11juCntX9koKVL8yA/NFbagR1OTkI00dArdVOirL
         yrSLPTSwUgCibfvLxSP5PZVaS+DKTMsR/iIkXMNcrn308VKFdKcL1QdFKC0odHwVAEMP
         3corNO22Y4tdo1XyBEbGIMJnfUp+3cG9ZXupM0uHaCb+yvA371Ski/dwtenCJ8oF2JCb
         NSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709720251; x=1710325051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXp3dvj8RXyd5VC25WQpvIY0TxZT9QViO+VH9V+80YQ=;
        b=JVC9AgXlHsRtFfN49j/c2CSva7k/CUWwcWcprFnXjny/sj7g2NIMNrf537c+WjyIJH
         ROuo7IYewaxhCJ7bxZPWGAyAuLR3i+LZYD1EPE7ACu9nLfeQsyIzPHI6qokANNtXHCQP
         dzxJB/roUSik/I0/V2C6Fve2oQ6Q/AutYVUboUl/0PPBGM/w1wmaemNRYb+wqLHdcnUQ
         ywL0ViKOaveV6JNy+EB4XKlpo2YCpSuCbQ+XJi6KhJXtqLYpDDR3c4nnR39wDRC5PfMu
         Tjqy465PX7jnySE5OCLxDINBoAE+HAZrIsi+ZefG2yX7XZD6grkFZNuHtOsHjFEfCna/
         YjMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEObwnArYJWjsS8Tn1xrn9d6xPn9Easag19GOjre/jQD0wR6OFboQYmCK7eaYq3vyo8etnKox5AlVOBt+XOmm9TYRginFLdH1uhX45
X-Gm-Message-State: AOJu0Yw7xxyt9VKScZTT5xpdjpsKkI+jC8497tWIqhmV7o8WLj5yXJPB
	Dz68/DIu1XNxFLBUPMlkj3ydtJloxQb7a83qanMN0orq7rZL4Oq7BbvO9aXcCPVXsFzIcE7Z/s1
	WsXtIuv7KoDvUDtZdgId4263B4l+9k6maXkA9
X-Google-Smtp-Source: AGHT+IEaRNnQwsDV5h/jJAyuRY2UuSSKqo6/ZssDUcS4IdliuD1AivloeSKEHCB7mXUWavBTCp+AAniu+YaHMq/FGWY=
X-Received: by 2002:a50:8744:0:b0:567:9d6a:b82b with SMTP id
 4-20020a508744000000b005679d6ab82bmr274320edv.7.1709720250668; Wed, 06 Mar
 2024 02:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203190927.19669-1-petr@tesarici.cz> <ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net>
 <Zct5qJcZw0YKx54r@xhacker> <CANn89i+4tVWezqr=BYZ5AF=9EgV2EPqhdHun=u=ga32CEJ4BXQ@mail.gmail.com>
 <20d94512-c4f2-49f7-ac97-846dc24a6730@roeck-us.net> <CANn89iL1piwsbsBx4Z=kySUfmPa9LbZn-SNthgA+W6NEnojgSQ@mail.gmail.com>
 <a3749d3f-ced1-4c48-adaf-348c8dee7610@leemhuis.info> <20240228120308.48d6a9c2@meshulam.tesarici.cz>
 <e3181555-c08d-463f-a9a9-b08c69875c84@leemhuis.info> <20240306100153.32d305f7@meshulam.tesarici.cz>
 <20240306110312.04ddcde3@meshulam.tesarici.cz>
In-Reply-To: <20240306110312.04ddcde3@meshulam.tesarici.cz>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Mar 2024 11:17:17 +0100
Message-ID: <CANn89iLfgK7zTWMutOycKyVepq=8n26MO_LTsUAy2JdVtXr-_g@mail.gmail.com>
Subject: Re: [PATCH net v3] net: stmmac: protect updates of 64-bit statistics counters
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, Marc Haber <mh+netdev@zugschlus.de>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org, 
	alexis.lothore@bootlin.com, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 11:03=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@tesari=
ci.cz> wrote:
>
> On Wed, 6 Mar 2024 10:01:53 +0100
> Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:
>
> > On Wed, 6 Mar 2024 09:23:53 +0100
> > "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.i=
nfo> wrote:
> >
> > > On 28.02.24 12:03, Petr Tesa=C5=99=C3=ADk wrote:
> > > > On Wed, 28 Feb 2024 07:19:56 +0100
> > > > "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhu=
is.info> wrote:
> > > >
> > > >> Net maintainers, chiming in here, as it seems handling this regres=
sion
> > > >> stalled.
> > > > Indeed, I was too busy with sandbox mode...
> > >
> > > Hmm, no reply in the past week to Petr's request for help from someon=
e
> > > with more knowledge about the field. :-/
> > >
> > > So I guess this means that this won't be fixed for 6.8? Unfortunate, =
but
> > > well, that's how it it sometimes.
> >
> > For the record, I _can_ reproduce lockdep splats on my device, but they
> > don't make any sense to me. They seem to confirm Jisheng Zhang's
> > conclusion that lockdep conflates two locks which should have different
> > lock-classes.
> >
> > So far I have noticed only one issue: the per-cpu syncp's are not
> > initialized. I'll recompile and see if that's what confuses lockdep.
>
> That wasn't the issue. FTR the syncp was in fact initialized, because
> devm_netdev_alloc_pcpu_stats() is a macro that also takes care of the
> initialization of the syncp struct field.
>
> The problem is u64_stats_init().
>
> Commit 9464ca650008 ("net: make u64_stats_init() a function") changed
> it to an inline function. But that's wrong. It uses seqcount_init(),
> which in turn declares:
>
>         static struct lock_class_key __key;
>
> This assumes that each lock gets its own instance. But if
> u64_stats_init() is a function (albeit an inline one), all calls
> within the same file end up using the same instance.
>
> Eric, would it be OK to revert the above-mentioned commit?

Oh, nice !

Well, this would not be a revert, let's keep type safety checks if possible=
.

Thanks.

