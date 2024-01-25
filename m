Return-Path: <linux-kernel+bounces-39148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CED283CB84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07A62964E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1237F133431;
	Thu, 25 Jan 2024 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pau3WQsK"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10C063413
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208451; cv=none; b=Ryr+XOd8vRD8vdFMSprfCsTYbYqAAB9ZtzzW3ODlltfpVHBJZN7LEsZwDPpMiybjaYfLLnKepcWzg+xHwEk8dozrnBOgMLl7LMbaF28FyJPLUhVJjIT5msAjmVenzub2BzJtvyKevaFFUxTcYA8XdMvqQn2fIhAp9JkpS19gp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208451; c=relaxed/simple;
	bh=lrEHeyqqmey6bgSQdTuYKMmq7AaDt9wtCW8yyJAJa7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPRvf+Vgpl1AbOiRCb5NAK6h3dom9xasX23Uy8bKxSe5HcIm3BYE79/Uncv5UniKW7QpxHIOrhUqhK0khKmfbY1irPx7ZaMLTjbcjPhH5nFJorOB2Pz0rxf2vRw6BnIfriPcjYZ9TIgYAB4xmIvfzvjTAaSvuTK3KvRBBvW/I2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pau3WQsK; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e0a64d94d1so4247447a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706208449; x=1706813249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttNcHqhpvqsqcpLQNkj3//EbIezpIbk0mMweN0OSVS8=;
        b=Pau3WQsKipTbCvr4V5WmyBNIeLh0ZrsJ7nPE45XemhiAmJUW6tXz8KmNlQCtHW2hqc
         t8cPhV1J/DnKD0lthaMVQxIb3X0FCb4v6K4unjkYenfVU2XgduANnu8Y7y0N6L7JfcXy
         RPMiCIUgCuU5xf6dQGmCPxHh5xgGG1IBY/A5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706208449; x=1706813249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttNcHqhpvqsqcpLQNkj3//EbIezpIbk0mMweN0OSVS8=;
        b=gfX/nS7LdoO+R3kcr4yNx5l1Ovfr8GhaZrbeRij1UUfnyJuRrr4/C3XyrzKQl9bKVq
         ViDmnH1/UdwpWqDr13EpADnFhISF2tsmO4IThyz36c0Ihq7z8AemmR6z3BkfDiuydEFP
         oPZECXLb3hol/5e204DuWtZF1gdhk8yuCDX6kWlQShrNOcdPpaPZB5wRDjHaxyYldeBO
         pvAO3843OnIh0LQAypYl0/Dp+Z73aIXSppmg4QNx9M79J+xxgc6JiIillSIFrgnLegZE
         8KVIdEPRnCdqb8U6B6W0GRU/k1EpK5ZYcobV4aa8HS6YtLhvh9ePTT0Z6oy1LlIaG8DI
         KYkg==
X-Gm-Message-State: AOJu0YyroXMNAVrHovPnpB5qNcOEgRERwkiRbsuZIFbW4F080u0ySaPW
	6TX+QEDVBKsxyMwdXpvkIov1T4KYa3rcGpFipki72o0DXVYm7vrHwqpJM6ugjAHnkmGgPM0RpDK
	/ASxrdkF/PJKRERZfhZ8IftJ8ohm4WGZQ/TAj
X-Google-Smtp-Source: AGHT+IEMzhey6Q+f69HKEUNoCFK5af03wKnBO6EmvVB6elV2DQ5+0JR9R9FQljOPHjmgwhSK7ddkYo7su0eyg544RPc=
X-Received: by 2002:a05:6830:116:b0:6dd:ec86:b4c3 with SMTP id
 i22-20020a056830011600b006ddec86b4c3mr215290otp.65.1706208448903; Thu, 25 Jan
 2024 10:47:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124030458.98408-1-dregan@broadcom.com> <20240124030458.98408-10-dregan@broadcom.com>
 <20240124183706.0af8fb90@xps-13>
In-Reply-To: <20240124183706.0af8fb90@xps-13>
From: David Regan <dregan@broadcom.com>
Date: Thu, 25 Jan 2024 10:47:18 -0800
Message-ID: <CAA_RMS6VeAmJUYxVYknYrcf5vVWGzEx3npSpSujFhKKL15zjVA@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] mtd: rawnand: brcmnand: update log level messages
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

On Wed, Jan 24, 2024 at 9:37=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi David,
>
> dregan@broadcom.com wrote on Tue, 23 Jan 2024 19:04:57 -0800:
>
> > Update log level messages so that more critical messages
> > can be seen.
> >
> > Signed-off-by: David Regan <dregan@broadcom.com>
> > Reviewed-by: William Zhang <william.zhang@broadcom.com>
> > ---
> > Changes in v3: None
> > ---
> > Changes in v2:
> > - Added to patch series
> > ---
> >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nan=
d/raw/brcmnand/brcmnand.c
> > index 6b5d76eff0ec..a4e311b6798c 100644
> > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > @@ -1143,7 +1143,7 @@ static int bcmnand_ctrl_poll_status(struct brcmna=
nd_host *host,
> >       if ((val & mask) =3D=3D expected_val)
> >               return 0;
> >
> > -     dev_warn(ctrl->dev, "timeout on status poll (expected %x got %x)\=
n",
> > +     dev_err(ctrl->dev, "timeout on status poll (expected %x got %x)\n=
",
>
> I don't see the point but if you want.
>
> >                expected_val, val & mask);
> >
> >       return -ETIMEDOUT;
> > @@ -2196,7 +2196,7 @@ static int brcmnand_read(struct mtd_info *mtd, st=
ruct nand_chip *chip,
> >                               return err;
> >               }
> >
> > -             dev_dbg(ctrl->dev, "uncorrectable error at 0x%llx\n",
> > +             dev_err(ctrl->dev, "uncorrectable error at 0x%llx\n",
>
> Upper layer will complain, you can keep this at the debug level.

I've discovered that the upper layer will complain, but typically
with information that is maybe not useful for debugging.

>
> >                       (unsigned long long)err_addr);
> >               mtd->ecc_stats.failed++;
> >               /* NAND layer expects zero on ECC errors */
> > @@ -2211,7 +2211,7 @@ static int brcmnand_read(struct mtd_info *mtd, st=
ruct nand_chip *chip,
> >                       err =3D brcmnand_read_by_pio(mtd, chip, addr, tra=
ns, buf,
> >                                                  oob, &err_addr);
> >
> > -             dev_dbg(ctrl->dev, "corrected error at 0x%llx\n",
> > +             dev_info(ctrl->dev, "corrected error at 0x%llx\n",
>
> Definitely not! Way too verbose. Please keep this one as it is.

ok

>
> >                       (unsigned long long)err_addr);
> >               mtd->ecc_stats.corrected +=3D corrected;
> >               /* Always exceed the software-imposed threshold */
>
>
> Thanks,
> Miqu=C3=A8l

Thanks!

-Dave

