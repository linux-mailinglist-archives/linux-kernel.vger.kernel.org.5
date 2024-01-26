Return-Path: <linux-kernel+bounces-40596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBF383E2FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37DE6B232ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991FA22626;
	Fri, 26 Jan 2024 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zxdxsvq4"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77D225CC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299072; cv=none; b=lrYZ/m94dnxMeLMKHCrsNIjHuJ3McwJki866/y8EbWnKhwQECIDymnNy3uqxFLADUhjoGyqjfI0z59BEHhCBwTl6pUa7A97ngGqgt5rb58jCjFfNjucP311IRlYAMThbl7OdYyLpPoYFqvearQ9zfIcI4d2Zjyr5UD98pjCEo3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299072; c=relaxed/simple;
	bh=HH+bibQgvv7Bgy7TKR8pWSXYp9b8IZvCD70dInTijM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfthUlmrgDnzeG3Bu5PDXYFSI8eh4mFY9jrAXGdZ9KlmX+BdZxS3haKDT/QhaFaQVVw5O0Igi13cXOERctuKw5s4DYBU8x4VrF3Z+8UDsGDbHO3UcO0C7abATLJ+cHHCr+FarIowFBgt1v7eh6ca9SoR44MC7qMdm2Kh8Lzk4Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zxdxsvq4; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dc8b280155so700780a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706299070; x=1706903870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8qZh8tfmWARSxkgMSjgm0Ee+mYC8Et59eGzshH4MMI=;
        b=Zxdxsvq4TBjA+0cUGpJrzLCgYFdfXtX7pzeSC+ylQFgoMjT+3mhg2P1OJ2yHi7/oZ+
         Zj36Dg36oGXwMBsEVznbe1mtwJnNldYROKzpvmDrRecfWomlve1m5S8iye6wnO7YYArS
         mfBbQPSK8INqcdhCpmTi32JKMuTf6AHW7mR3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706299070; x=1706903870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8qZh8tfmWARSxkgMSjgm0Ee+mYC8Et59eGzshH4MMI=;
        b=ZAJ0NI0hF2GKKtgE2inJFqZyQ6oVi7WxiMuw2zTkrZ7yRigDVRFKSo38yGBmfZJbj1
         2Q1hQUrHzyA/MpAR1n1RtVYiREYJ2JJeq6C4lGy35s6drmNTajbtgQPrLP6mVISgLpl4
         IrW812klMBBijwqi05dAQsNLfmyo/P9P9ZiIgytQOWAjKgbIdiojAGThtKsXqczJRRZL
         4ZN7llWY8UraXotqT89rrGvyuOZtd0u5NmgKEEqXS+N1HgowVAisMk8bTMEgY2L3nGxT
         t61a9EU3Zzw/BcsOJrr3d8a530dSfCJlEbBKgg0gkLA8a3JFDYRCA0WsQQlv1udYTosK
         fjQQ==
X-Gm-Message-State: AOJu0Yw8mCcEfFrtkjY/iTu+Gqdt5G0p/t2rbJraYm1HJ8x5HJpw8349
	PTdUNqkAOxgNRmZashVlpb326wzL8ajr/pIiPnujP/F9bdCaPED5QXMgmqYzuKIMLpUr9uvk5UA
	4jXKvNkVKWvBBuY1myE3PVXivhjgmxeCMwDXI
X-Google-Smtp-Source: AGHT+IGQ/4wSd/NSTRBeIlGwXqntNHpdR66dbLfhnzA2JaEkrHh6UrnPd664+kqFzjqkh4QOOamCSyjf8dZjuF4i4Ck=
X-Received: by 2002:a05:6830:134f:b0:6dd:9d3a:2421 with SMTP id
 r15-20020a056830134f00b006dd9d3a2421mr221283otq.3.1706299070172; Fri, 26 Jan
 2024 11:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124030458.98408-1-dregan@broadcom.com> <20240124030458.98408-11-dregan@broadcom.com>
 <20240124184027.712b1e47@xps-13> <CAA_RMS42FaiN+Za1iY12o0YUANH9rJarBTBa=9jNn8x6_g-Fng@mail.gmail.com>
 <20240126071913.699c3795@xps-13>
In-Reply-To: <20240126071913.699c3795@xps-13>
From: David Regan <dregan@broadcom.com>
Date: Fri, 26 Jan 2024 11:57:39 -0800
Message-ID: <CAA_RMS5gX88v_Qt1csgSL_ffMNsqo2G8B164EB_Hg=hXd620eg@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] mtd: rawnand: brcmnand: allow for on-die ecc
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: David Regan <dregan@broadcom.com>, dregan@mail.com, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	computersforpeace@gmail.com, kdasu.kdev@gmail.com, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joel Peshkin <joel.peshkin@broadcom.com>, 
	Tomer Yacoby <tomer.yacoby@broadcom.com>, Dan Beygelman <dan.beygelman@broadcom.com>, 
	William Zhang <william.zhang@broadcom.com>, Anand Gore <anand.gore@broadcom.com>, 
	Kursad Oney <kursad.oney@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com, 
	andre.przywara@arm.com, baruch@tkos.co.il, 
	linux-arm-kernel@lists.infradead.org, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miqu=C3=A8l,

On Thu, Jan 25, 2024 at 10:19=E2=80=AFPM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi David,
>
> dregan@broadcom.com wrote on Thu, 25 Jan 2024 11:47:46 -0800:
>
> > Hi Miqu=C3=A8l,
> >
> > On Wed, Jan 24, 2024 at 9:40=E2=80=AFAM Miquel Raynal <miquel.raynal@bo=
otlin.com> wrote:
> > >
> > > Hi David,
> > >
> > > dregan@broadcom.com wrote on Tue, 23 Jan 2024 19:04:58 -0800:
> > >
> > > > Allow settings for on-die ecc such that if on-die ECC is selected
> > > > don't error out but require ECC strap setting of zero
> > > >
> > > > Signed-off-by: David Regan <dregan@broadcom.com>
> > > > Reviewed-by: William Zhang <william.zhang@broadcom.com>
> > > > ---
> > > > Changes in v3: None
> > > > ---
> > > > Changes in v2:
> > > > - Added to patch series
> > > > ---
> > > >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 ++++++++++----
> > > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd=
/nand/raw/brcmnand/brcmnand.c
> > > > index a4e311b6798c..42526f3250c9 100644
> > > > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > > @@ -2727,9 +2727,11 @@ static int brcmnand_setup_dev(struct brcmnan=
d_host *host)
> > > >       cfg->blk_adr_bytes =3D get_blk_adr_bytes(mtd->size, mtd->writ=
esize);
> > > >
> > > >       if (chip->ecc.engine_type !=3D NAND_ECC_ENGINE_TYPE_ON_HOST) =
{
> > > > -             dev_err(ctrl->dev, "only HW ECC supported; selected: =
%d\n",
> > > > -                     chip->ecc.engine_type);
> > > > -             return -EINVAL;
> > > > +             if (chip->ecc.strength) {
> > > > +                     dev_err(ctrl->dev, "ERROR!!! HW ECC must be s=
et to zero for non-hardware ECC; selected: %d\n",
> > > > +                             chip->ecc.strength);
> > >
> > > Can you use a more formal string? Also clarify it because I don't
> > > really understand what it leads to.
> >
> > How about:
> >
> > dev_err(ctrl->dev, "HW ECC set to %d, must be zero for on-die ECC\n",
>
> Actually I am wondering how legitimate this is. Just don't enable the
> on host ECC engine if it's not in use. No need to check the core's
> choice.

Our chip ECC engine will either be on if it's needed or off if it's not.
Either I can do that in one place or put checks in before each
read/write to turn on/off the ECC engine, which seems a lot more
work and changes and possible issues/problems.
Turning it on/off as needed has not been explicitly tested and
could cause unforeseen consequences. This
is a minimal change which should have minimal impact.

>
> >
> > >
> > > > +                     return -EINVAL;
> > > > +             }
> > > >       }
> > > >
> > > >       if (chip->ecc.algo =3D=3D NAND_ECC_ALGO_UNKNOWN) {
> > > > @@ -2797,7 +2799,11 @@ static int brcmnand_setup_dev(struct brcmnan=
d_host *host)
> > > >       if (ret)
> > > >               return ret;
> > > >
> > > > -     brcmnand_set_ecc_enabled(host, 1);
> > > > +     if (chip->ecc.engine_type =3D=3D NAND_ECC_ENGINE_TYPE_ON_DIE)=
 {
> > > > +             dev_dbg(ctrl->dev, "Disable HW ECC for on-die ECC\n")=
;
> > >
> > > Not needed.
> >
> > Will remove.
> >
> > >
> > > > +             brcmnand_set_ecc_enabled(host, 0);
> > > > +     } else
> > > > +             brcmnand_set_ecc_enabled(host, 1);
> > >
> > > Style is wrong, but otherwise I think ECC should be kept disabled whi=
le
> > > not in active use, so I am a bit surprised by this line.
> >
> > This is a double check to turn on/off our hardware ECC.
>
> I expect the engine to be always disabled. Enable it only when you
> need (may require an additional patch before this one).

We are already turning on the ECC enable at this point,
this is just adding the option to turn it off if the NAND chip
itself will be doing the ECC instead of our controller.

>
> Thanks,
> Miqu=C3=A8l

Thanks!

-Dave

