Return-Path: <linux-kernel+bounces-39210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC2F83CCCA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7832954CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C91353EA;
	Thu, 25 Jan 2024 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BrFkc3Ux"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A963407
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212080; cv=none; b=qxea6OdbnZejdFB2/v2WqoUccQDFBXimQqE64hxudnn8khnIO3EPQ8lkAAMVwwKvBu30IR2+0N5H9i5ecz/xniM+DEgo8GGfOcc928opvlV/1kCbpfFkisreeQ+rQoY9OZqzYPKDJKI0LRRH8k3HalO7yweYbmrDRjNgCebhaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212080; c=relaxed/simple;
	bh=9bbfXQdHeX85Eu9CetucjpRjjTfXD9PsAZtUPaED0GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCUZRx1XfOzVxfKbJWKPP4sK5Llhh1M2Rke6NBrv2gsuxo6LiIxL34GOoquBG0446xfEBygScGV+xN2ZHP6QagS9+D803dHbsYfvrlvGiy7BQ9cWa8CYfQSmhvoQTtyl3AnuJZYi0u84APoX4c4iZRS/aYlbbjuq4oEv8+Pd0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BrFkc3Ux; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dddb927d02so4209918a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706212077; x=1706816877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyIWFQ1vFWoo45M1BlWLEeXRVeP9Nt7FD+B+f6FiY+w=;
        b=BrFkc3UxC0+vEyeUqbL3ItUFfEKVP07R+fhogoYwnmfvqIk9DecZzdVyV6drx7WEZ6
         +Re7kCx033wYNJanapQVMCGYi9rjyOfn6YqHPnHsrFj7QyKky2vOJqKfiDMHrWLDFzlW
         tqE52AMOjwwVzOtkPhAvTaloo3RjTzHYVB2aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212077; x=1706816877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyIWFQ1vFWoo45M1BlWLEeXRVeP9Nt7FD+B+f6FiY+w=;
        b=QbH6JoieKZ4dw4ZsMYf5M+4QtIu0cts7PqHl4f15qSPj0JLyJVbYTCXl1qza54A96r
         cYLLfGPJD8yITqRxCZWxDzCX+U68wQJE+AS4J1+Oa0gQGrtVxfBDz7vS6p5fJt5Gonw2
         V0UjPMm11VpHuef6onMoJuH1ozNjlC7mmpWd/cwy4bUNyOakTds1VpnISjnckb64cz8X
         GjRq4M0HP2Y96WtmwDQoaYwKJESqPxp5KH1jCxhTGPfSjik3RZevFYkVJ0I2SsoYx0Hi
         lNMMCm5iWKFb2x/5vWwzmTywe7O7OjVWZZ3pr2k0kjImFPVohfJL8NVIjXrFwaS/3svW
         9rFA==
X-Gm-Message-State: AOJu0YxCRkYztNnmZADSpN5zLhJ239sW3oxyPAdVVwWLXOqx32o47/DG
	xyCIGkiFCKa5xDonmpd1lAvt7e5c2M/4pO+20rv0HwGxE0+w7c7zr4wAOQQfeXIB7qKq5fj/pMP
	9UVGqkAz9IP6SBIHTqYBH591gLOjAxQJnR9s6
X-Google-Smtp-Source: AGHT+IGekG3Dtb9CcWAk4PYoE+WDZ1VA7nT/CUBW+XazLbLifZzJFyi+b1ofXaGFHNvhlX5SIyIFFhz3O6B/sKC2sg0=
X-Received: by 2002:a9d:7495:0:b0:6db:fa81:564a with SMTP id
 t21-20020a9d7495000000b006dbfa81564amr488303otk.3.1706212076800; Thu, 25 Jan
 2024 11:47:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124030458.98408-1-dregan@broadcom.com> <20240124030458.98408-11-dregan@broadcom.com>
 <20240124184027.712b1e47@xps-13>
In-Reply-To: <20240124184027.712b1e47@xps-13>
From: David Regan <dregan@broadcom.com>
Date: Thu, 25 Jan 2024 11:47:46 -0800
Message-ID: <CAA_RMS42FaiN+Za1iY12o0YUANH9rJarBTBa=9jNn8x6_g-Fng@mail.gmail.com>
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

On Wed, Jan 24, 2024 at 9:40=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi David,
>
> dregan@broadcom.com wrote on Tue, 23 Jan 2024 19:04:58 -0800:
>
> > Allow settings for on-die ecc such that if on-die ECC is selected
> > don't error out but require ECC strap setting of zero
> >
> > Signed-off-by: David Regan <dregan@broadcom.com>
> > Reviewed-by: William Zhang <william.zhang@broadcom.com>
> > ---
> > Changes in v3: None
> > ---
> > Changes in v2:
> > - Added to patch series
> > ---
> >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nan=
d/raw/brcmnand/brcmnand.c
> > index a4e311b6798c..42526f3250c9 100644
> > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > @@ -2727,9 +2727,11 @@ static int brcmnand_setup_dev(struct brcmnand_ho=
st *host)
> >       cfg->blk_adr_bytes =3D get_blk_adr_bytes(mtd->size, mtd->writesiz=
e);
> >
> >       if (chip->ecc.engine_type !=3D NAND_ECC_ENGINE_TYPE_ON_HOST) {
> > -             dev_err(ctrl->dev, "only HW ECC supported; selected: %d\n=
",
> > -                     chip->ecc.engine_type);
> > -             return -EINVAL;
> > +             if (chip->ecc.strength) {
> > +                     dev_err(ctrl->dev, "ERROR!!! HW ECC must be set t=
o zero for non-hardware ECC; selected: %d\n",
> > +                             chip->ecc.strength);
>
> Can you use a more formal string? Also clarify it because I don't
> really understand what it leads to.

How about:

dev_err(ctrl->dev, "HW ECC set to %d, must be zero for on-die ECC\n",

>
> > +                     return -EINVAL;
> > +             }
> >       }
> >
> >       if (chip->ecc.algo =3D=3D NAND_ECC_ALGO_UNKNOWN) {
> > @@ -2797,7 +2799,11 @@ static int brcmnand_setup_dev(struct brcmnand_ho=
st *host)
> >       if (ret)
> >               return ret;
> >
> > -     brcmnand_set_ecc_enabled(host, 1);
> > +     if (chip->ecc.engine_type =3D=3D NAND_ECC_ENGINE_TYPE_ON_DIE) {
> > +             dev_dbg(ctrl->dev, "Disable HW ECC for on-die ECC\n");
>
> Not needed.

Will remove.

>
> > +             brcmnand_set_ecc_enabled(host, 0);
> > +     } else
> > +             brcmnand_set_ecc_enabled(host, 1);
>
> Style is wrong, but otherwise I think ECC should be kept disabled while
> not in active use, so I am a bit surprised by this line.

This is a double check to turn on/off our hardware ECC.

>
> >
> >       brcmnand_print_cfg(host, msg, cfg);
> >       dev_info(ctrl->dev, "detected %s\n", msg);
>
>
> Thanks,
> Miqu=C3=A8l

Thanks!

-Dave

