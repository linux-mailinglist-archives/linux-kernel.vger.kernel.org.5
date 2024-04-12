Return-Path: <linux-kernel+bounces-142948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D797C8A326C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056741C24520
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E481487CD;
	Fri, 12 Apr 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UCiX17OE"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D371474B3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935658; cv=none; b=jf5kJhG82fA1oKYEynZZqrqel2ufsymzkPpunwqn0xyn7alHk9XbSe3IyZ7YMnsz3h8B6nAThf5KvNlnGw3HaOaWOmy2v6NuyQ73xt15rcT3ARzvkgo2xkJ188ohbXRo8EfY81OqEa2xgAfP+3V3TIpyEywQCkFzxJXfKBr6fV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935658; c=relaxed/simple;
	bh=aD1S0VSA9Rf1Y9Q1f0q+Bvh40I5d5XVACe2gL/oovSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uP8hFLP8TAO3HJ1rAwhQH9UNY7IvABPgOOvR4UVNlB9wJd7I4mjKIe8go3upKzcNI46MQJXyFlXL3/cSGBsUo9IcY32VWfQhdZ8SiaIzbZ33B90GZOpHfnWj6buZX9z+7UESeu8h6b9V980eZvIGHCkJMglSbl7rSg1N+ozkdFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UCiX17OE; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b4e94ecd2so3136136d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712935654; x=1713540454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbEJNdBEgg7zteIjPRT61BO8wQHmtBNPFF5TlQkKbKo=;
        b=UCiX17OEsn6Js+L7WHX2rNR3uRdlnMXc961IfF/roVN8777rs0v9ekDZVSTjFiKkD3
         io2Z1D7LnoNXD839OOOZZj4+/+Z4s91KFHJqv7R7VoAOBmF6in0h4oDD8PfCkfVf9gp1
         /zKwciBoBRJLlUPHcpVvwQNzZ3wBz7oGh+owE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712935654; x=1713540454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbEJNdBEgg7zteIjPRT61BO8wQHmtBNPFF5TlQkKbKo=;
        b=QiJt4LZX/T1nvHQlk1o9y0wts/T8BkZnD6TUeECWeclbv4MPbsFCSD/c6tUA+u+d9k
         cF5MglSKmdqLMnjjTeXF2or5X8m7iAXXzoCfPm20mAl9LaJB1HGENH5fJ9KQ7GWSF60c
         URgjlfYaydDXDGbsBxhHjhTcKWc7plGrhozLCp/Jc5e+KNlAJCEt4QQbVQMTvfSFi4dF
         r+L4h3w3wVM5MHb2nHMY+YIZAMPdxJO/BEq0Lfif7EueTrayrZMrMGvdDwyQUSB15aUY
         JmNLODxVUiwULm3ptZ6d8+iIUiJYP8lsNrBHT1AkTgeb02d8A8prnNAcXsGyFjIZNMSn
         KXcA==
X-Forwarded-Encrypted: i=1; AJvYcCXUjCRL93gfKu5qc/wzrkHj88u69xmxPKwVyOMWsaAXwLUEf9837MzyLRBu0dw6ZxChEuIT6t0z28rJaP+93hj4VFGMV69Z/xn0x9T2
X-Gm-Message-State: AOJu0YxjcEc7ZMvFd3OpjgIXsKLXU4cw33TRbBQL09mC0cwsxbsrpSEM
	uNONhUCDJlZcJcKvGCjAgUZR565v3ukIqwbNInW1dQJTpaMoq4SS06jtf6Id4Nd/CHgd2H2TsIO
	l8DVYsh8fllBRQjv3ewgvjZ0YrlNMXUqDXugf
X-Google-Smtp-Source: AGHT+IGJKQQefkr1OCMZT+YQUVp/D1HI8E8z4+jZz882PNsanR0PyfyPLE/FkkTXry1gEPywtXO+rLndVVy0mTpZQc0=
X-Received: by 2002:a05:6214:293:b0:69b:1323:5d12 with SMTP id
 l19-20020a056214029300b0069b13235d12mr3428619qvv.38.1712935654688; Fri, 12
 Apr 2024 08:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326200645.1182803-1-sjg@chromium.org> <20240408151057.1d1fcfb3@xps-13>
In-Reply-To: <20240408151057.1d1fcfb3@xps-13>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Apr 2024 09:27:23 -0600
Message-ID: <CAFLszTi1tp1-vdy2JLoarVxH_CWB8UMV+sHu=vrn4E7w62i6sw@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: mtd: fixed-partitions: Add alignment properties
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: devicetree@vger.kernel.org, Michael Walle <mwalle@kernel.org>, 
	U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Rob Herring <robh@kernel.org>, 
	linux-mtd@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

On Mon, 8 Apr 2024 at 07:11, Miquel Raynal <miquel.raynal@bootlin.com> wrot=
e:
>
> Hi Simon,
>
> sjg@chromium.org wrote on Tue, 26 Mar 2024 14:06:44 -0600:
>
> > Add three properties for controlling alignment of partitions, aka
> > 'entries' in fixed-partition.
> >
> > For now there is no explicit mention of hierarchy, so a 'section' is
> > just the 'fixed-partitions' node.
> >
> > These new properties are inputs to the Binman packaging process, but ar=
e
> > also needed if the firmware is repacked, to ensure that alignment
> > constraints are not violated. Therefore they are provided as part of
> > the schema.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >
> > Changes in v10:
> > - Update the minimum to 2
> >
> > Changes in v9:
> > - Move binding example to next batch to avoid build error
> >
> > Changes in v7:
> > - Drop patch 'Add binman compatible'
> > - Put the alignment properties into the fixed-partition binding
> >
> > Changes in v6:
> > - Correct schema-validation errors missed due to older dt-schema
> >   (enum fix and reg addition)
> >
> > Changes in v5:
> > - Add value ranges
> > - Consistently mention alignment must be power-of-2
> > - Mention that alignment refers to bytes
> >
> > Changes in v2:
> > - Fix 'a' typo in commit message
> >
> >  .../bindings/mtd/partitions/partition.yaml    | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition=
yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > index 1ebe9e2347ea..656ca3db1762 100644
> > --- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > @@ -57,6 +57,57 @@ properties:
> >        user space from
> >      type: boolean
> >
> > +  align:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 2
> > +    maximum: 0x80000000
> > +    multipleOf: 2
> > +    description:
> > +      This sets the alignment of the entry in bytes.
> > +
> > +      The entry offset is adjusted so that the entry starts on an alig=
ned
> > +      boundary within the containing section or image. For example =E2=
=80=98align =3D
> > +      <16>=E2=80=99 means that the entry will start on a 16-byte bound=
ary. This may
> > +      mean that padding is added before the entry. The padding is part=
 of
> > +      the containing section but is not included in the entry, meaning=
 that
> > +      an empty space may be created before the entry starts. Alignment
> > +      must be a power of 2. If =E2=80=98align=E2=80=99 is not provided=
, no alignment is
> > +      performed.
> > +
> > +  align-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 2
> > +    maximum: 0x80000000
> > +    multipleOf: 2
> > +    description:
> > +      This sets the alignment of the entry size in bytes. It must be a=
 power
> > +      of 2.
> > +
> > +      For example, to ensure that the size of an entry is a multiple o=
f 64
> > +      bytes, set this to 64. While this does not affect the contents o=
f the
> > +      entry within binman itself (the padding is performed only when i=
ts
> > +      parent section is assembled), the end result is that the entry e=
nds
> > +      with the padding bytes, so may grow. If =E2=80=98align-size=E2=
=80=99 is not provided,
> > +      no alignment is performed.
>
> I don't think we should mention binman here. Can we have a software
> agnostic description? This should be understandable from anyone playing
> with mtd partitions I guess.

OK

>
> > +
> > +  align-end:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 2
> > +    maximum: 0x80000000
> > +    multipleOf: 2
>
> seems not to perfectly match the constraint, but I don't know if there
> is a powerOf keyword? (same above)

I believe this was discussed earlier. No there is no such option!

>
> > +    description:
> > +      This sets the alignment (in bytes) of the end of an entry with r=
espect
> > +      to the containing section. It must be a power of 2.
> > +
> > +      Some entries require that they end on an alignment boundary,
> > +      regardless of where they start. This does not move the start of =
the
> > +      entry, so the contents of the entry will still start at the begi=
nning.
> > +      But there may be padding at the end. While this does not affect =
the
> > +      contents of the entry within binman itself (the padding is perfo=
rmed
>
> content?                                same comment about binman?

OK

>
> > +      only when its parent section is assembled), the end result is th=
at the
> > +      entry ends with the padding bytes, so may grow. If =E2=80=98alig=
n-end=E2=80=99 is not
> > +      provided, no alignment is performed.
> > +
> >  if:
> >    not:
> >      required: [ reg ]
Regards,
SImon

