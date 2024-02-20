Return-Path: <linux-kernel+bounces-72439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 793D485B340
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEE01C21632
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB6A381A8;
	Tue, 20 Feb 2024 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="yqa6N57A"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE8E1EB48
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412171; cv=none; b=Lv3MIQ9SKSTZbpC+1RhVhYxYUfkkNl0HqHhCganxFu/G2MmCr5OcATPnIJzRdthRDN6aZt5LjL22tXZtaSsirUUL6+Q3DKP65cQIeqDWim09PsQAmzSjPiwzdi75ifKaa5RhWeXkb9WijOnzINn9aKGLJLjetAmv8aUXIsYV4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412171; c=relaxed/simple;
	bh=wgHSKeYmXnu5YtZR/gEwqP/Reo7xcpiV0Yva1dABvR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9rlexZE7KcWyK9LSUijbD+Y0g/AlJpHtJ7QVPTdFNDfKBGrvEtTBCkPwJ9gUDfz0cmvMoaIcnj2+1PJewBVuIgREcW5A2rPQ5XT4ReWSpMq1H9XpNilKwF2r28huzL/x4HTOQ1e+3sMLYXAs8ZolkoxsNohf5dM6qUpYrzwRdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yqa6N57A; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-428405a0205so803531cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708412168; x=1709016968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aa1eJ+wSIVg0VORBPoC8dMZAELGFCjWNXbVSxIUYLxk=;
        b=yqa6N57AQE0jaDa+8FjNsBAH3EI2X/JiuLowjZXIJH0JzQNxd2KzTbqTcxnJk/pT71
         kZThoecys/MRnpypJMPJoxmJPXEcR5MJ1MTJUg1qaj0c3eMLjXUP9xDNB6ghl5N93LAw
         S7jFysnVvl7PmNJwBUw/jMa54A9h3mSHj9WZsYpWTgOTGPe0hr/h45DQwfjsvUctzd//
         c4qQblJGOK4Gw7dMLq92hYJ1zm39+7ZSfxW1o4ZxklWa62N/PlGc/AEMbg+sKW38YxT6
         iKBefrEN75oluylHDSTDcPZASmg77CUF5KOVwZzZG+9XqiXEuxgwGeZ7MYEOHi/A20Zg
         JxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708412168; x=1709016968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aa1eJ+wSIVg0VORBPoC8dMZAELGFCjWNXbVSxIUYLxk=;
        b=aSB6WBSx7VklKjaDT6Lilm7mUsqSJi233Hiunq1x609vU4OmCbWofRWp7HuncLTZ3a
         eL3pBHG9YEzlVj3ReR+TVqf1Zb+bScmxPGJv9V09Hd1GPq3xK4L6ndCr6mux5wpktf4j
         mhizAPa2PzOIeiTPGVn8qM8mfawZrvIEBbhI7w6gowMJBUcD/pIF5dbU+I118Wp2hobo
         dejpqlBHYmkSN4q+mAG/266ZtvRan9pbUtRN4Q8tRDdVpGlVslzyA0FgBf4n4sQ9b6wc
         0JL1YiJrJZhYAySLe3aBioSbd4vqAlOO6Nwpk0JrIhJAFtzBt7sgSTnhDsw5xGIqx+4P
         2fFg==
X-Forwarded-Encrypted: i=1; AJvYcCWagy3aGvKcza6b6uzv+/cDZ6NdYEw5cCicxSafWD0e+/yamADc7e6A18HwLGGGKiYnTmbU3k0axUovHWIJjhDp91s2n99I7E+nbWHw
X-Gm-Message-State: AOJu0Yya3ybe1hFk80E1EP0eDvid4EXEi8U+xo0SWGYB8nCtZQnIqcdO
	DWxP/Emjqu6q8LWA+ZMsbxuW1Rr8Zen03KByNn56zvQ0Binz+He9Mhcrfwmr427wRM9O31FiOVh
	Yjv2XPU83ijYxngdXRL7mx0OMoK9YuMFbxXpJdZTL627TP2eqGA==
X-Google-Smtp-Source: AGHT+IFzN9GPJqnlcdxg+4MBTcutynzSM9kc0VYGdbncVxOop1NdXQ7El5EKMQWyRCDRwWMggY1CRe/j3i4jxkYO18c=
X-Received: by 2002:ac8:7511:0:b0:42d:f55b:a7ee with SMTP id
 u17-20020ac87511000000b0042df55ba7eemr451272qtq.21.1708412168437; Mon, 19 Feb
 2024 22:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202095636.868578-1-saravanak@google.com> <20240202095636.868578-3-saravanak@google.com>
 <CAMuHMdVon3mdivZQ0O6D4+va0nGBrUQbDp23bEq661QD=4t7+g@mail.gmail.com>
In-Reply-To: <CAMuHMdVon3mdivZQ0O6D4+va0nGBrUQbDp23bEq661QD=4t7+g@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 19 Feb 2024 22:55:36 -0800
Message-ID: <CAGETcx_N=QX8Dst_En=2EW-7coSvPhZn=q_T-V6S8E8kZfcnPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] driver core: fw_devlink: Improve detection of
 overlapping cycles
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 2:59=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Saravana,
>
> On Fri, Feb 2, 2024 at 10:57=E2=80=AFAM Saravana Kannan <saravanak@google=
com> wrote:
> > fw_devlink can detect most overlapping/intersecting cycles. However it =
was
> > missing a few corner cases because of an incorrect optimization logic t=
hat
> > tries to avoid repeating cycle detection for devices that are already
> > marked as part of a cycle.
>
> Nice (I assume it's due to this patch ;-), with v6.8-rc5 I see much fewer
> dependency cycle messages.

Thanks!

It's not due to this patch. It's due to this other series:
https://lore.kernel.org/lkml/20240207011803.2637531-1-saravanak@google.com/

I forget why the cycle warning doesn't show up between fea80000.csi2
and video@e6ef7000, but I had the same improvement on my test device
and there was a valid reason why it doesn't show up. So, an
unintentional, but non-buggy benefit of that series.

-Saravana

>
> E.g. on Salvator-XS:
>
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef7000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef6000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef5000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef4000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef3000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef2000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef1000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef0000/ports/port@1/endpoint@0
> -platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef3000/ports/port@1/endpoint@2
> -platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef2000/ports/port@1/endpoint@2
> -platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef1000/ports/port@1/endpoint@2
> -platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef0000/ports/port@1/endpoint@2
> -platform fead0000.hdmi: Fixed dependency cycle(s) with
> /soc/sound@ec500000/ports/port@1/endpoint
> -platform feae0000.hdmi: Fixed dependency cycle(s) with
> /soc/sound@ec500000/ports/port@2/endpoint
> -platform feb00000.display: Fixed dependency cycle(s) with
> /soc/hdmi@feae0000/ports/port@0/endpoint
> -platform feb00000.display: Fixed dependency cycle(s) with
> /soc/hdmi@fead0000/ports/port@0/endpoint
> -platform hdmi0-out: Fixed dependency cycle(s) with
> /soc/hdmi@fead0000/ports/port@1/endpoint
> -platform hdmi1-out: Fixed dependency cycle(s) with
> /soc/hdmi@feae0000/ports/port@1/endpoint
> -platform vga-encoder: Fixed dependency cycle(s) with /vga/port/endpoint
> -platform vga-encoder: Fixed dependency cycle(s) with
> /soc/display@feb00000/ports/port@0/endpoint
>
> -i2c 2-0010: Fixed dependency cycle(s) with
> /soc/sound@ec500000/ports/port@0/endpoint
> -i2c 2-0010: Fixed dependency cycle(s) with /soc/sound@ec500000
>
> -i2c 4-0070: Fixed dependency cycle(s) with
> /soc/csi2@fea80000/ports/port@0/endpoint
> -i2c 4-0070: Fixed dependency cycle(s) with
> /soc/csi2@feaa0000/ports/port@0/endpoint
> -i2c 4-0070: Fixed dependency cycle(s) with /hdmi-in/port/endpoint
> -i2c 4-0070: Fixed dependency cycle(s) with /cvbs-in/port/endpoint
>
> FTR, the only remaining ones (on Salvator-XS) are:
>
>     platform soc: Fixed dependency cycle(s) with
> /soc/interrupt-controller@f1010000
>     platform e6060000.pinctrl: Fixed dependency cycle(s) with
> /soc/pinctrl@e6060000/scif_clk
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

