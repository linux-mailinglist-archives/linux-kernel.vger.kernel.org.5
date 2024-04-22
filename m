Return-Path: <linux-kernel+bounces-152952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9248AC68D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41BD1C2199D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C145025A;
	Mon, 22 Apr 2024 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itu84G3X"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291014AEC1;
	Mon, 22 Apr 2024 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773830; cv=none; b=ENQSNuATw0UtSwMpZLqKb2Z2P4E0G9JrfD8aDcCDcUj1URBni/wQQrKYmqpuqjkPfieF+GnpMqFnNxG9SXplxHPYpnrRSvy8PHYztCLarZEPGZMwAw8o+tj1eMV3OaaoEcT1KiXoQXKlKna8yv/fIIDYrWjaN3nUS84DrPeSzwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773830; c=relaxed/simple;
	bh=M9B7WRjrvk2JAsBFwlrLC6qkllLzalEbntZIoYH3cKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNrRqNfzryRIzRpsiT/XFHoAagKms8zKTfgxaBxqUgxpf5VqB7oK/TjiNlu0xTrUon7cK9rrmZgGWi1lt6pGG8LffEDXJx40i55kU2d27/yOIA3r8+0vh22b0GKmLmWIaoSZMn1p3IRxexKU8dE+647B+PBjyqkZF+25sdnFR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itu84G3X; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4702457ccbso455388366b.3;
        Mon, 22 Apr 2024 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713773827; x=1714378627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POE7+7bDdgxJYrWynyeU3Cirtp8tecozyW6D2rsQgo8=;
        b=itu84G3XOf6V0qGmoMJMy7DGC5TUJ9Qbh6K2ZoLABhklzCNZ+TZmv0cJrNyrxqVHzU
         1yvtgaNnahz1KQHXf8cKKMw7LeOKqkArp5nTjZWgSA/WZF3+tlOwwXAfg0B5QiMkjzss
         KYejzdOaJlzTZlTDpIY6ODaCiB73/w62GkZ8muFvblBGjfi1nmB6ZoO6OckfKLPo/tNL
         kb0bvPoHW3IvZR+mVX7suU1nOAUoFKGxNoNpMPMSen//uXavL2jhTtCkgYGWS4jwPC5z
         go5rcJCoKLLhTRgduekGS9l67LajAnv2NKPuAI2W0eBG+DR0sBzWgxE4u/JjtJBmtC8b
         XvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713773827; x=1714378627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POE7+7bDdgxJYrWynyeU3Cirtp8tecozyW6D2rsQgo8=;
        b=iB4LmxspRV3x7DSJNE2SW0tlT1ysW/trdsxQfOrPZnUvRhOqLxAutpEg8k+Bx04p3g
         bFDSXwQytBe6f5nYiSBJ3DLIcsnaBjcX/q3TWlQslmYnJiqQhCpPS+8yygNAFM5TRR+w
         EyR82vU2mKthBmL0m/17SToooGkBN+6yA6jNo+n47WR8EVInUKNFtHzDy8M9VlnqIVYm
         RvkcSFzEyAL9EBONCYeAkeKckmuWfs7j8bMR1ZSu9OwE9i9xA3yinL/WMxxkFIjcR4Pj
         faCKrDOQqR/+5bXDZmmOp895glIrhicB4vO4gwZllyftZAnt3C0ec3vrbqZ562XzDfEu
         xU0g==
X-Forwarded-Encrypted: i=1; AJvYcCV9sTC/7oN4FAXn6THEZTRpdFBEO4L9njeyOr8ns2BVsv3i2uayecnSGHn3pnpyHr6AuN74z9H9b8h5Ui1L5gkdmXEQkefVhghlxe+jMWijin6xfe71UYqxOahnW5MaRiweZEHUGhUk5EAFM+uPnGUwuzUE92GZrlTITFH/vKj6EB7azWE=
X-Gm-Message-State: AOJu0Ywu6/k2bzDxcJ80rAECABHbuqKqFC0hQnE1Avk3Mlcr8Pb+Ypq6
	BSsvlAjEQrm254rh08261S5SxJ1irFsKt8Jp/V5X+8ZDTnbiIIM4cItFIPQZLLVR//lJyJ9Ju0e
	eUG1bhNyMddJ56qoIog/Cxj+n8ms=
X-Google-Smtp-Source: AGHT+IGdGb378Q6HBFI7vnqwgZAe/ou95qevOvoX9Sk6JXOvi4Phmy2Xhg+rj7Z4WCygmd7t+cDyddlSEuxBKKtbxVQ=
X-Received: by 2002:a17:907:2d9f:b0:a56:cb24:fbb9 with SMTP id
 gt31-20020a1709072d9f00b00a56cb24fbb9mr388348ejc.20.1713773827167; Mon, 22
 Apr 2024 01:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409095637.2135-1-ychuang570808@gmail.com>
 <20240409095637.2135-4-ychuang570808@gmail.com> <ZhZTsV3RKpuyeUr4@surfacebook.localdomain>
 <643a0d80-3d99-420e-9e77-acc67728fbe7@gmail.com>
In-Reply-To: <643a0d80-3d99-420e-9e77-acc67728fbe7@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Apr 2024 11:16:31 +0300
Message-ID: <CAHp75VfMb_=XKoQNbbVphLg-eQgc6eJbZOW36g_hU=-iK2bSOQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver
To: Jacky Huang <ychuang570808@gmail.com>
Cc: linus.walleij@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, j.neuschaefer@gmx.net, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ychuang3@nuvoton.com, schung@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 7:10=E2=80=AFAM Jacky Huang <ychuang570808@gmail.co=
m> wrote:
> On 2024/4/10 =E4=B8=8B=E5=8D=88 04:54, Andy Shevchenko wrote:

..

> >> +#define MA35_GP_MODE_MASK_WIDTH              2
> >> +
> >> +#define MA35_GP_SLEWCTL_MASK_WIDTH   2
> > I looked at the code how you use these... Oh, please switch to FIELD_GE=
T() /
> > FIELD_PREP() (don't forget to include bitfield.h)
> >
> > ...
> >
> > ...
> >> +             regval &=3D ~GENMASK(setting->shift + MA35_MFP_BITS_PER_=
PORT - 1,
> >> +                                setting->shift);
> > This will generate an awful code. Use respective FIELD_*() macros.
> >
> > ...
> >
> >> +     regval &=3D ~GENMASK(gpio * MA35_GP_MODE_MASK_WIDTH - 1,
> >> +                        gpio * MA35_GP_MODE_MASK_WIDTH);
> >> +     regval |=3D mode << gpio * MA35_GP_MODE_MASK_WIDTH;
> > Ditto.
> >
> > ...
> >
> >> +     regval &=3D GENMASK(gpio * MA35_GP_MODE_MASK_WIDTH - 1,
> >> +                       gpio * MA35_GP_MODE_MASK_WIDTH);
> >> +
> >> +     return regval >> gpio * MA35_GP_MODE_MASK_WIDTH;
> > Ditto.

..

> Allow me to remove irrelevant parts.
>
> I attempted to follow your advice and use FIELD_GET() and FIELD_PREP(),
> but found
> it impractical. The reason is that these two macros require their 'mask'
> argument
> to be a constant, otherwise compilation errors occur, which is the issue
> I encountered.
> Since the mask here is calculated and not a constant, compilation errors
> occur.
>
> Taking MA35_GP_REG_MODE as an example, within 32 bits, every 2 bits
> represent
> the mode of a GPIO pin, and the mask is obtained by GENMASK(gpio * 2 -1,
> gpio * 2),

This is not good for the compiler, it can't figure out (at least in
some _supported_ by Linux kernel versions on some architectures) that
GENMASK can be constant here just left-shifted by arbitrary bits.

> where the 'gpio' argument is a variable, not a constant, leading to
> compilation
> errors.
>
> Due to this reason, I will leave this part unchanged, or do you have any
> other suggestions?

If you need non-constant field_get()/field_prep(), add a new patch
that moves them from drivers/iio/temperature/mlx90614.c (and there are
more custom implementations:
https://elixir.bootlin.com/linux/latest/A/ident/field_get) to the
bitfield.h and use them in your code.

--=20
With Best Regards,
Andy Shevchenko

