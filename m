Return-Path: <linux-kernel+bounces-158832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B799D8B257A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E3BB297B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EAD14C597;
	Thu, 25 Apr 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy7Tb4TZ"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB80414BF90;
	Thu, 25 Apr 2024 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059852; cv=none; b=eydTmPku6QQ8EFtGs95CLoBruAseEA+6gMVIhPGApfzm94yS4gz3ufKBHlNSW9kYm2XwinvcMPBYZaQFF4HXMUeYwGuzb2S+zqEx9a+bHBUlawWz3rdR36hfPHlSQHBzJ9TBkB80KW0E65hxJbTSnDKAyiPwI+C0OyvqtMkQAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059852; c=relaxed/simple;
	bh=kA/D6zVPXYWszEjkvYSf0smpFm+zOmzsl5H0CAhJfi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SS2ePyuRoSJ31A6I0AQdAz6KgPFcHr/mLm027hGv83Z7c7A+0f6TZbBQGxbJGZsmdJrDmaneFEFlBvRH0zx3F/GIVaL6J7WT2H2pJSgVkXZEuy/DXa5kq/jQg2NKQQQhwhRs1GRwwYhiWvUwehQjA8DDvD+8SzzVAawn6nvcmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy7Tb4TZ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-479de34dc36so437506137.1;
        Thu, 25 Apr 2024 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714059850; x=1714664650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR/AyfcnU5bia8L6mI9WG+m8xZ5cR1LfRzpwQN9yZhM=;
        b=Jy7Tb4TZ3plaBKNRou6OAt6K1d/cyc63bV4OKR4GlkzrcvcUtiVTYKk/2SJADwB2bg
         EaF8yatdbsewdhJpwiSJdqqyGxMvfGAZgo07ros0jH3qAKMBz3AtBL2ziWS7B0vfi9JZ
         +abpzwwIScZ21hSB94XHAturTZNhZlGFGR/q0HEk+4Ryed+f5Fhg5B5RRq0+loxreBPh
         Fj5mZvC3cVI76ANQ9YC/GI4NHsqa315hachBA14UaEMbeM2r4qCCb4GzF3CnTRxP/5xx
         1ZQ6MrAXpMx1eV5S6XVniItC6z0nj2m/zwieZUvQmdZZ6nMyo9CyOCOQUR/z03OnjXev
         S7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714059850; x=1714664650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iR/AyfcnU5bia8L6mI9WG+m8xZ5cR1LfRzpwQN9yZhM=;
        b=eQFerOCUEW7cBYHJMzitf+DgVxjk8NVrF5GZu2/KcftqQXuSbIRCvxZgtEkZhxSly7
         54tAJnRbarNNRIpxPI/C7sFbMvObH6LNI9GUBk8w5dd1OOJ77jrca+kP8KWCOxRovxaW
         6YtfIrF/ChwyR4Sd44ol10MuQAzhkNTegJ8Z30srKT7+61gF73dfA3NvvJniN3gSjTM3
         H9tubieJzejolIZv89n6ikaUrcRFpI/8Lc6i0L4hZWGgTzioMIudghdDmH4yYLQWZl4Z
         h+2pxxoUrK3Z/zKLzZ5hV/ZbLMBIGDesh1MaIcDtCdr9MrYIwJqPn4NT9lSAHMqyRf+q
         XB0w==
X-Forwarded-Encrypted: i=1; AJvYcCURDHHdN4x6iYPZbM3fCsKnJAg1OwPeO5kKMTIOWImWm/NK89qyf5ozEBWokvsJBuZMCbgJz2x2PQ35AFKNdEM5EDyF2OscmPrrkkb/2wRZqxk1tqILpKBFgegGeDMe5r6Jelr6E7cz7yUUeivPyyCrI+HhGgBR6g2P+/Vstbz+cZ5vHenOCorAoKaioojmSS7gm7DbZwLQIRMwj12wW2GQbPVAg526
X-Gm-Message-State: AOJu0Yx6sMi1kdwGjoziNiyo1JLDXpnPRnwvkJq8WfhIm3Hv6+bLiJ3p
	4Y1t59Mmitk7YK1QLvI/zBJTGVKFnC97Z8kuCfdjL4n1HKKOO5jKT3pGig5g9819jSwwcRoy5Ak
	TcAeJNT8xLZO+aSEzLnRJNYkD+Jk=
X-Google-Smtp-Source: AGHT+IFxZFKxyvkvDsztzyBVqo6Z2bFHlhiyFlQQf6hu37wkpPlB+vINFBMirYxG2K7XXSgfChsLzeevVqM7rx5Erkg=
X-Received: by 2002:a05:6122:552:b0:4cb:fc25:7caa with SMTP id
 y18-20020a056122055200b004cbfc257caamr7129680vko.14.1714059849704; Thu, 25
 Apr 2024 08:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423182428.704159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240423182428.704159-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <7a3d4b8a-e89e-499e-92b7-9f63fbc84011@kernel.org>
In-Reply-To: <7a3d4b8a-e89e-499e-92b7-9f63fbc84011@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 25 Apr 2024 16:43:28 +0100
Message-ID: <CA+V-a8uz0OrsM1AxqtpeHB0f1+F6aEqHGp_t3_OPhh0ZqJ26HQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: renesas,sdhi: Group single const
 value items into an enum list
To: Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thank you for the review.

On Wed, Apr 24, 2024 at 6:42=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 23/04/2024 20:24, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Group single const value items into an enum list.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > - Updated commit message
> > - Grouped single const value items into an enum list.
> > ---
> >  .../devicetree/bindings/mmc/renesas,sdhi.yaml  | 18 +++++++-----------
> >  1 file changed, 7 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/=
Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > index 29f2400247eb..2bf90095742b 100644
> > --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > @@ -13,15 +13,13 @@ properties:
> >    compatible:
> >      oneOf:
> >        - items:
> > -          - const: renesas,sdhi-sh73a0  # R-Mobile APE6
> > -      - items:
> > -          - const: renesas,sdhi-r7s72100 # RZ/A1H
> > -      - items:
> > -          - const: renesas,sdhi-r7s9210 # SH-Mobile AG5
> > -      - items:
> > -          - const: renesas,sdhi-r8a73a4 # R-Mobile APE6
> > -      - items:
> > -          - const: renesas,sdhi-r8a7740 # R-Mobile A1
> > +          - enum:
>
> You wanted to drop the items, but I still see it here.
>
Ah, I missed that.

> > +              - renesas,sdhi-sh73a0  # R-Mobile APE6
> > +              - renesas,sdhi-r7s72100 # RZ/A1H
> > +              - renesas,sdhi-r7s9210 # SH-Mobile AG5
> > +              - renesas,sdhi-r8a73a4 # R-Mobile APE6
> > +              - renesas,sdhi-r8a7740 # R-Mobile A1
> > +              - renesas,sdhi-mmc-r8a77470 # RZ/G1C
>
> Keep list alphabetically ordered.
>
This list is sorted based on SoC, I will sort it  alphabetically.

Geert is that OK with you?

Cheers,
Prabhakar

