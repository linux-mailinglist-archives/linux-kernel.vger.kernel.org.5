Return-Path: <linux-kernel+bounces-102581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 859CF87B436
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F681F232B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703705A0FC;
	Wed, 13 Mar 2024 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEkcr5TN"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD759B7D;
	Wed, 13 Mar 2024 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710367795; cv=none; b=b+N7IOSA3V5nD9gUH+yZI109xRUN1JwGa0ldwNDsUdVK4Nbdb2pgmBwUtH9DGVJaxHWrcxhAB9IW7IwFY2BJqa3w+QtSTvZkWqgM9mY0rPBGBv85EWwCGab5A53vbfVDwfbks80b9GA2h3xvjaESWozPuUhoEMyEs/wBfAwlZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710367795; c=relaxed/simple;
	bh=4hpePpaFTE6U7CK4ISiZbOEK8A4i2CFiX0UrbxY6QFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBXugimgob9W+0BiscPQAYw9e1+2+9xHS5ZvcITCZ4dMP9kd/oGCaa7ksgy4gRgf/OHiSJXjkw5XpBHkyIDD1rqLfmEC+r3sTu/tuBWkRC7kvLvB8CS0HvKEGO5g+1rG16jeUaqQ2DgljgDgB8vxiLFq64swmFgIH8jh9W40ikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEkcr5TN; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7dbb7f8016eso758632241.1;
        Wed, 13 Mar 2024 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710367793; x=1710972593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daWXvFeY9rVW7OCBrBWc6Xoloz3pKxS60zVN6U+OS54=;
        b=kEkcr5TNNc952m2N/g0xoNSdz7HSN98Ky3GSKJelAIbRaP7A98nZBXyMvRCokBnmLY
         5kUX1VPZTpRqwLyiJjJBNKBjXH94xmMNOpJ3OtJ/BZy/TaoH+hK6imfVeQW7+QoUqESg
         JWvsvcsR6FHeP/TYNpsszeO2YQD/idkOlWrb0W1Nr9mG7ZvPCNMdEEwPv/y68Y8uMZoe
         PFiCCs/llV5z6wQWPizyE8oM9A0RBSPxx9d9BxLaap7wd8I6VylbbzbLT6Uz/eg9M2mv
         rBZS8cHcBuRn5MJx6rHmlDkkX+6uz+0ilpewklxUOpg8f+ixlytcfGFXZN5gYaWMgXNe
         Oduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710367793; x=1710972593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daWXvFeY9rVW7OCBrBWc6Xoloz3pKxS60zVN6U+OS54=;
        b=pcKCjQdPHzVLw+7t+h9RnOM5P8pHj57mCo+UjNxDsL66t4b6BlFVYMZ1cQCkxdVsR1
         bvqpJCUIY+P/ukhLbRTiwG/o3k4di50JI7kl3JoTQATgl2TO1nvQL5yKXwefasjo6fy1
         l1Yd1gk0/Tc+ooLc3/z1z1PB8W/YaV2IhHNZtTpRZ/oRB0SRRHTnLcNhSIo5vrM88kQR
         eH+RNvB/p2tGYp31oIDCQD0cxt6NxGaB52igHu+jwSFkQrK6lmZoCe0OZFKJOzDk9G+H
         PXWUmBjSleMtM3SXJkcn8efd5M6NgIDdT+RGwzWb9Kwgagq8yvW7DOXouyAoUD+rf/vr
         x9qg==
X-Forwarded-Encrypted: i=1; AJvYcCWgJK3DQixlX/eb+J+Gl82u2U9nW70vRSqmVNEkvn1EcI54FEo/HuIh3fy3nawkL+3DrruQlx13yHLigkD3JS74MfeNDK++le99Mw9bpx4yGEq4t7oLF42r/+iDfylVxBDYWZkuSvW+2uCcAWlPvw46c221Oh5jM7B0UTzIZASMNBiSgXqWNZzj9TxHVQq0qdJMAo7wHuL+gYncbI+Kkf7IvmogPfQwnw==
X-Gm-Message-State: AOJu0Yz9vpXHSxiCXT9PYN+EyIUIPW3FJn+pQR79XQ3cAyw1kGntE7sg
	Owef/3KGanCBEUuLUcSxwNLhODqJ+Bj2r9wevb06IxbdW9wOk7AbYAggrNyrP9bz7J2jmhtDoIN
	oIxdKPcepM5286uFEzDD2LzLiZok=
X-Google-Smtp-Source: AGHT+IHEH3fqCM6u2M1oBHOKBnOFhk9tpx1sgww/vfX8Gmw+JTdMXok3gn5hIEQvYF/wzB4BR7nx+Ps1ixoUwk8Ph18=
X-Received: by 2002:a1f:f48d:0:b0:4d3:34f4:7e99 with SMTP id
 s135-20020a1ff48d000000b004d334f47e99mr118866vkh.0.1710367793051; Wed, 13 Mar
 2024 15:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313083828.5048-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <619c6117-d9b2-4520-9138-311327b17a8e@linaro.org>
In-Reply-To: <619c6117-d9b2-4520-9138-311327b17a8e@linaro.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 13 Mar 2024 22:08:32 +0000
Message-ID: <CA+V-a8vicbBrnu__w=KubF3VfRte_v23pUumFEd7O3buSjOyPg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow
 'input' and 'output-enable' properties
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thank you for the review.

On Wed, Mar 13, 2024 at 5:02=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/03/2024 09:38, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On the RZ/G3S SMARC platform, the 'input' property is utilized in gpio-=
hog
> > nodes, and the 'output-enable' property is used for ETH0/1 TXC pins. Up=
date
> > the binding documentation to include these properties, addressing the
> > following dtbs_check warnings:
> >
> > arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: pinctrl@11030000: k=
ey-1-gpio-hog: 'anyOf' conditional failed, one must be fixed:
> >       'input' does not match any of the regexes: 'pinctrl-[0-9]+'
> >       True is not of type 'object'
> >       [[144, 1]] is not of type 'object'
> >       ['key-1-gpio-irq'] is not of type 'object'
> >       from schema $id: http://devicetree.org/schemas/pinctrl/renesas,rz=
g2l-pinctrl.yaml#
> >
> > arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: pinctrl@11030000: e=
th0: 'anyOf' conditional failed, one must be fixed:
> >       'mux', 'tx_ctl', 'txc' do not match any of the regexes: 'pinctrl-=
[0-9]+'
> >       'output-enable' does not match any of the regexes: 'pinctrl-[0-9]=
+'
> >       from schema $id: http://devicetree.org/schemas/pinctrl/renesas,rz=
g2l-pinctrl.yaml#
> >
>
> In the future, please trim the error messages only to relevant parts, e.g=
.
>
> arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: pinctrl@11030000: key=
-1-gpio-hog: 'anyOf' conditional failed, one must be fixed:
>         'input' does not match any of the regexes: 'pinctrl-[0-9]+'
>
> Because all other four lines are really not helping.
>
Sure I will keep that in mind.

> Anyway, no need to resend just for that:
>
Thanks.

Cheers,
Prabhakar

