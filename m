Return-Path: <linux-kernel+bounces-150894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A88AA65D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2F41C21002
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9337E1;
	Fri, 19 Apr 2024 00:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDix1jAB"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB3A4A11
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713487735; cv=none; b=MfMYxy+7U3HIxYq82uURJuVpq0cdK/4KXgbpfxWv7TwvX9t4rXMgsxvW9pmxhzQ+xKKLH+YtdMBWyukJf+DPCgHA3r5Pwu1E8MGD1jgjGR7rJEALcwrNGN7zx12W7RkiY1LXoqYdrNuMaguCBnlIZOMwOsEpyP1pfEemCqBQjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713487735; c=relaxed/simple;
	bh=Cn8iBDpyHzBToc5x2IxvNZY+fV3HfAE451iVksU1Vo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxfzQ0+q5iwJnRTfuoLrn9OvT2qNJ4wHkgtVVjIAnrTcdfJ8MIDFeHla2A7uUqevyBZkTOwahlX3sX/0P6mQl8ETzqavsDXyE+c3FangD3Qgw87dy7P9erMFUvM9INaYETdE+N4ss8JcMmC6LnlruQJ9Krk0SRWeuwLp0yXIg+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDix1jAB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a528e7f2b6so1210002a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713487733; x=1714092533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+i6MbUVulprM4w6RPq5RF1Rimz1Zb3d0BGvo/86t4ac=;
        b=PDix1jABHlli+FBeBekbds2MntpEVeWPx7VlFVuTSlL5hrsRTXX1WXUitpmoMqMtpO
         j+izpENX2eXA/O5LG9U/+8lVhOw4+qjTZhx/YPCy1LedvWePqHH9SoT8sPKaFezaTj58
         c1vSlje/4SLFQbtz5uhJEBhbeqkdYLt1uCc4DGCdyhIwl4hNaEjVQSDy2RdWnTcJq1CG
         P+A+zv9QTa967FyZU4i/s4apEjvm2qh2CudbTgmN0BymDr38upahFt7FcPMKOlqH4JmA
         T9C9E6sEav/EwzgNYMpR6a8UWq4enhAlxU/mBAvar/LIyCV0abgPx6ontp7+mvot3D3Q
         TCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713487733; x=1714092533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+i6MbUVulprM4w6RPq5RF1Rimz1Zb3d0BGvo/86t4ac=;
        b=gwHltP113BQmJPM4WsfZRi2pqbQtp8YFNUXu4T8WTsXvcekv17FHEypv/+fNCbonzd
         uJw0YtFkRNV3IMFFjrcVgwMXYshUXRSXlr4R57zpaN4xLDXhl3On+wCBO7cAGdznfDKI
         VHcNTcXFaJKyX1Z6B3oUjh9ZBs/cSIgg20dO7t1/VPUt1hE82S9Sd7qQSdms9wNib4iT
         /lcu+jHrd0+kiZtsEUZQ/1P31nr27LD2LC1Vc/D9WSM/RyoJAwv2IIfI19Mrpv5UIYCG
         k6WDqsaOblMeVd1wvxfgYB19WgSHWGwXne7PXCAXm/7ZUxzIdMGvDEKpRunFxmNUCBLf
         mAww==
X-Forwarded-Encrypted: i=1; AJvYcCUOdzdfNJdErbWvl/XKAv3MeHzIBPLmQL8aRs46M8hXD7/KQrCieIMZkdBxaynY+apEmuZKBtRFvEfFSoMNfED7gJUmBOKweXdkJOoh
X-Gm-Message-State: AOJu0YwEUbxyKRBBqZz7dYLwmNxY53sbNINmJ/l/cx6s44Rk0wr9j+o/
	6bJtKdw4BYYGkLHwW9jUxqJhxrqIgfFOPXvvAA+P6F41+O+GsaROlHQ3DTQ9XdepYJgW2vKFvOY
	K/Eol36XJZcBCL5fiFskTRcsxTWoup2ttVWczag==
X-Google-Smtp-Source: AGHT+IHvhJAZ8u8NbdyyMWW9Qdo19ozFbcLnpn2nmLxzT6yaxoL9DdwJWbhTCPyHaoQcP7I5NTV0L5vVt0pITogV8iU=
X-Received: by 2002:a17:90a:c907:b0:2ab:9f04:703a with SMTP id
 v7-20020a17090ac90700b002ab9f04703amr782215pjt.41.1713487733583; Thu, 18 Apr
 2024 17:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
 <20240410071439.2152588-3-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=V2J=Tth2zhpo-kPo4uvESt70mFneO2V6TV-haac0VZuQ@mail.gmail.com>
 <CACRpkdYtM=5jdQddCqRFgBRXvcJEjk1ULJNKKFz7jhhkGxV59Q@mail.gmail.com>
 <CAHwB_NLfaQWhFSbZ2ASmYgXJaVOTrjac3F0hyCJdwTTo-zHJrQ@mail.gmail.com> <CACRpkdYoM40RZyjTxLwDNta2+uV31_zzoj7XrXqhyyqrDtd5zQ@mail.gmail.com>
In-Reply-To: <CACRpkdYoM40RZyjTxLwDNta2+uV31_zzoj7XrXqhyyqrDtd5zQ@mail.gmail.com>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Fri, 19 Apr 2024 08:48:42 +0800
Message-ID: <CAHwB_N+39-kTcNX91JvNGM4HEJ_ZArKt2Vs61g-OR-Mz6akocw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] drm/panel: boe-tv101wum-nl6: Support for BOE
 nv110wum-l60 MIPI-DSI panel
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>, sam@ravnborg.org, neil.armstrong@linaro.org, 
	daniel@ffwll.ch, airlied@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Linus Walleij <linus.walleij@linaro.org> =E4=BA=8E2024=E5=B9=B44=E6=9C=8818=
=E6=97=A5=E5=91=A8=E5=9B=9B 22:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Apr 18, 2024 at 2:42=E2=80=AFPM cong yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
>
> > I learned from himax that even if the same controller is used with
> > different glasses, the corresponding parameters are not fixed.
> >
> > For example: _INIT_DCS_CMD(0xB9, 0x83, 0x10, 0x21, 0x55, 0x00),
> >
> > even in the group initial code, the same register will be loaded with
> > parameters twice.
> (...)
> > So assuming that the registers of the two screens is the same now,
> > it cannot be set as a common parameter.
> > Otherwise, it may be a bit troublesome for the maintainers.
> >
> > If necessary, I can break out starry_himax83102_j02, boe_nv110wum and
> > ivo_t109nw41
> > as separate driver. Then add some define to these registers.
>
> Why would you do a separate driver per panel despite they have
> the same display controller? I don't get it.
>
> Use one driver, use different compatible strings for the different
> panels and use the corresponding sequence for each panel
> selected by compatible string.

I mean add starry_himax83102_j02, boe_nv110wum and ivo_t109nw41
together to make a separate driver and break out boe-tv101wum-nl6 ,
because they belong to the same controller.

As Doug said =EF=BC=9A
=E2=80=9CI'm just guessing, but if those are the same controller as
the two new ones you're adding in this series, maybe all
3 of them should be in their own driver? Maybe we can do something to
make more sense of some of these commands too? =E2=80=9D


Thanks.
>
> For example, see drivers/gpu/drm/panel/panel-novatek-nt35510.c:
>
> static const struct of_device_id nt35510_of_match[] =3D {
>         {
>                 .compatible =3D "frida,frd400b25025",
>                 .data =3D &nt35510_frida_frd400b25025,
>         },
>         {
>                 .compatible =3D "hydis,hva40wv1",
>                 .data =3D &nt35510_hydis_hva40wv1,
>         },
>         { }
> };
>
>
> Take some inspiration from this driver and how we parameterize
> the different data depending on compatible string.
>
> Yours,
> Linus Walleij

