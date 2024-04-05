Return-Path: <linux-kernel+bounces-133223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799EB89A0C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A602875FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EFF16F857;
	Fri,  5 Apr 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuAbHezG"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930B916F82E;
	Fri,  5 Apr 2024 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330065; cv=none; b=DRNMymWi9UeWVXOr78RntceBG9HTNk3gtdSPyPYtyC7jq2KiQEwQmGW0+hwagyCoxXKzI8VJsP+XI2mGgbPquvhfsBVHk/6BVjQo1ggFbt7q/54JI0Rtmx4zOMKE0++hHItrvXFe1azXw5eEQx2Y9fViWPZB88No6sb5Oj6D1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330065; c=relaxed/simple;
	bh=9D9DenBTVepGCiAnwWjmyy9NSqBU6RaDcI55bqc6d84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4gLYdVGSkG/u7aF2PB4N+yNH3OGSS0eT7FLY1XJfj70xbegmvRuO5jtC5W1sssvyUKn2RUGrCKI7w8uUaD74oArMQY5jUfTmbfwSJAR4Y8O1OqN8m1AagXEP2d+g0xSc4FNPU/CAwUezKbbnvNEboxSxhWLoHHf8Jdw0FeB1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuAbHezG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso3482678a12.0;
        Fri, 05 Apr 2024 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712330062; x=1712934862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGKFgV43FD5U2mte5hGPJIMIz/YhsRwMZmsLfoC6f9I=;
        b=NuAbHezGJSQs+GhQGccbNoskoQ05Ir03F+8fyUuZQ13zmgeDKNa0QxsJZZBTohFT0n
         MBeQz0flgy1zyHnr7HIZxf/Pqln6WBWs/6FxyN2cRE6P6nPQUCXEYmt2+z97Gdqx/BKM
         QZoi08WM9bnvyCV2Bj+4TbSVSaN9oeIGf8dn05q5AhdiPRUdLa/l7wjy9fUXsvkjmiGa
         XZ53mQpPOU58bJN5t4xknilKOEAuoJWPpO68DsFtzAJC82MznKLJSQl+McvehXoMyJjj
         o1rTVcSLZRoGcxF6+9CkoFFGpSOsKNwold+gf6WiFui+JVrh7SJb0elZJtQUj/nfgWei
         eWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712330062; x=1712934862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGKFgV43FD5U2mte5hGPJIMIz/YhsRwMZmsLfoC6f9I=;
        b=BLbx5HnPLWunzatPX11RhsqDzO/gg/axJRILwx8sG0cUeCauet3P8HX8QCNhbtQL22
         xBC6pTIhH7SqG2BuTuCcldG+OLmTWNec3XAPfBt8iSHTskrw91ZOdstSAj/+1Auwz8L1
         4Pntz4Ypagm9x8I/m67fLN87vBvLnXYROeL4EIpZYkS2yVk2wRteEkDrmLx10V2/QJfF
         J4bqswpVr0ezKNQ/r79ps5uBaRInOBptnW+1g4MeFeWO5Advpcin697t+7w3r9wRf6nw
         CRg4vKTkYCSOw9RlgZF1R0/rZR0tSAFd/Bs9CvNb2Pp7TCKV/xgdYDSbIOWh3ehxt46a
         7vKA==
X-Forwarded-Encrypted: i=1; AJvYcCWnbCYZVinF9lDp6eyer+XFo/2jp5bPa8gTDEdfOqP5T8OAIzThbxWEZG7sHIPpl3Ryr4nmXW3OHVRF1qAoupBHoXKIgG/+2MZzTzKfdNpXyDYg4cIR+GvtM5wNc46TTYtNfew1GrkNfQAS/i38JyaP7QC3MeEp6GHSsZC61FjLIaLhxKuo
X-Gm-Message-State: AOJu0Yznj8d0UNpUFCEmWb9T1KrQvUW7qPIW42Y0bggo1X6Pm6zrjo5H
	vLTGgRTiVaSwIbcPI+SxCHTHVrciXRSyP/0SsLTWG/S9ICnzmztsQ3ygtb7vftnp495ukPs5yNg
	YKPEDtUqZ8HT+0XuoRniobKBaFxQ=
X-Google-Smtp-Source: AGHT+IF5lz7iBaNDwiKSZBytjKe8aT7ZrBPoZ/ExEFBBG7jmd0L3DU84p/NhC1TphTH+AMs0r6S2IzcuyVW6U7D4hQY=
X-Received: by 2002:a17:907:ea3:b0:a51:adad:f5b2 with SMTP id
 ho35-20020a1709070ea300b00a51adadf5b2mr1003886ejc.68.1712330061796; Fri, 05
 Apr 2024 08:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404222009.670685-1-andreas@kemnade.info> <20240404222009.670685-3-andreas@kemnade.info>
In-Reply-To: <20240404222009.670685-3-andreas@kemnade.info>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Apr 2024 18:13:45 +0300
Message-ID: <CAHp75VeZ9U_+1rJQjr4KvvzjYQGzfKtk+BK00vqvKcVn2-yP3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: edt-ft5x06 - add ft5426
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	o.rempel@pengutronix.de, u.kleine-koenig@pengutronix.de, hdegoede@redhat.com, 
	ye.xingchen@zte.com.cn, p.puschmann@pironex.com, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	caleb.connolly@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:20=E2=80=AFAM Andreas Kemnade <andreas@kemnade.inf=
o> wrote:
>
> As ft5426 seems to be compatible with this driver, add it.
> Debug output during identification: Model "generic ft5x06 (79)", Rev. "

..

> @@ -1484,6 +1484,7 @@ static const struct of_device_id edt_ft5x06_of_matc=
h[] =3D {
>         { .compatible =3D "edt,edt-ft5206", .data =3D &edt_ft5x06_data },
>         { .compatible =3D "edt,edt-ft5306", .data =3D &edt_ft5x06_data },
>         { .compatible =3D "edt,edt-ft5406", .data =3D &edt_ft5x06_data },
> +       { .compatible =3D "focaltech,ft5426", .data =3D &edt_ft5506_data =
},

Why a different vendor prefix?
In case you need to use this one, keep the list sorted, currently this
splits the edt,* ones.

>         { .compatible =3D "edt,edt-ft5506", .data =3D &edt_ft5506_data },
>         { .compatible =3D "evervision,ev-ft5726", .data =3D &edt_ft5506_d=
ata },
>         /* Note focaltech vendor prefix for compatibility with ft6236.c *=
/

--=20
With Best Regards,
Andy Shevchenko

