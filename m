Return-Path: <linux-kernel+bounces-122619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BA688FA78
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0799D2A6D76
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2605054BCB;
	Thu, 28 Mar 2024 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLVMBC2m"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6B73C0B;
	Thu, 28 Mar 2024 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616139; cv=none; b=RK1YtJIcESihg3/JuitRjmQTW0GUHo5klO+rpefA7AWsRTKuP0tCS/k5aPAXcVruYzmCgXBDE8MooJg1eFXxh8c1lfMDUTexfi9JIb0euflySyt11AYAKZXYdKCO0nbAtUq/BI4n3RfsRb8UT/NqP5m3AJO9bFAEsnpZ39K6Yh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616139; c=relaxed/simple;
	bh=SwBW22qcadeQkdheN+7fvVJxa3pXoLgtNXHI9mpQwMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQeDAZ044dH2hTVVW+aSYEVpNIKEm9gTUV1K6rmrpBoaecmzY4VGPtRH67j60zvb2SO2hSSpHKGa/jkbtet1yLK1wcrTaC5VsVb51Vg2JnHl03pjPeItSZ88O4ktxb6m4WSxHqz01aOf3WBjcuazOTJgA3MLjJsMlGptE9Vvkfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLVMBC2m; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56899d9bf52so861131a12.2;
        Thu, 28 Mar 2024 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711616136; x=1712220936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ3BMMhKAmNs4bhyvnKkEZ82vtuSNj39yw+KO8d5Hvg=;
        b=OLVMBC2mxMDY7aZaVLrGjedUwVH0dALObfWJkVPY6EkI03jEE8dYVKYBjiyqdQQNXY
         wJvLghol2GvG4zbNa3tbDy2txfAQh+o/HWCP4pvfiTBB+y7PptxmxD4sP4sFEBo/5UA7
         ZNafiL3r0PO658cNJ6VVraYMnXHBAizE26PTxtQHI8jV4Er9s04lLkm3yMupVVuDx/h6
         c6uaW3hR+psloD9er4a1inNoJkaCLONwmoOq/VAI1uvxUM98f2XjRH1PVGgIMWuBk2xY
         zMDd40nxcl3Smw4eRg0ySsoRcLXrKbOuHeoLx+kGuapxXjFwd1BitTRqlP+bv3GdG+D5
         teAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711616136; x=1712220936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZ3BMMhKAmNs4bhyvnKkEZ82vtuSNj39yw+KO8d5Hvg=;
        b=VT3dg2YmLas9ojNp08jEPD4yEA44LmdR8msGYkxjBVF6bWV4aIB1iB8mWVnws68zj5
         pfiQEubratZypnF5BUtXZeyvos3XlfLEIIz/7U5XFt++WnulcyL6vhDvyrKa/gBBKlVp
         JjvGYln1e5mOiA8MhipkZ3xanJywPw1zzG14Ii1vJJBYlUwrTziCY/zqO3hpGV/2XwHT
         lA+TRhXdcsGyBLZlB4hZCXlzz2vrkbxlY9PY3lMzze5mSPmiTcROKnIpUQZ5dSklVPxP
         jr5A3BcHG/LzAzvbYoKo1UhTqyalozqOCoWaMc/kkN6TagZ+z7lqknw01PeVJXX8X1g1
         RCcw==
X-Forwarded-Encrypted: i=1; AJvYcCXaiFM+p/tGBfu0DGuzhU+Hm5T9qI9+fCjWPxLfU1xJU7Fcoszx1NKqjIsRg1qd9P5vf3iBjAz1HWQ3QWsSUI5zM1l52Yt4RNxsUDDOVdx6sCVm/0D3TA0VEHpjKDl9o/R8omanQu6Rr/SIySgslvdphHE4ny1Ob4twWVhQBeM28D8Ikz4=
X-Gm-Message-State: AOJu0YyWakyeAQCbOX9HKqNlyszxw4+f8Cqs9t3gZhWO9JSuGZXQvWR5
	nmVVIdFowZUieK1InX6HGx9K7WxfjVotzu63+lZGXUsDPAUYECyD4RpGbtSDO31L8WQ6ztSp+Qt
	t10xd662KjzrHw4d+UkwSTPw4mqCGy7zZxpfjKw==
X-Google-Smtp-Source: AGHT+IF/Gh0fqkummHE++ODJJmmDYUghD6sTKPcA5xCjIEGld6dcTsKYDT2r02IGeAmJKxsFDo1HaPJup4R1syV1vdI=
X-Received: by 2002:a05:6402:34cd:b0:56c:56dd:3b5f with SMTP id
 w13-20020a05640234cd00b0056c56dd3b5fmr438045edc.3.1711616135807; Thu, 28 Mar
 2024 01:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-loongson1-nand-v6-0-7f9311cef020@gmail.com>
 <20240327-loongson1-nand-v6-1-7f9311cef020@gmail.com> <20240327-bonehead-handlebar-1ca8dab95179@spud>
In-Reply-To: <20240327-bonehead-handlebar-1ca8dab95179@spud>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Thu, 28 Mar 2024 16:54:59 +0800
Message-ID: <CAJhJPsX7Ds-UdFpTpLgFMW+rTGAgAYSKAieAMn12Z8RjNn-A8A@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: Add Loongson-1 NAND Controller
To: Conor Dooley <conor@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 12:23=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Wed, Mar 27, 2024 at 06:43:59PM +0800, Keguang Zhang via B4 Relay wrot=
e:
> > From: Keguang Zhang <keguang.zhang@gmail.com>
> >
> > Add devicetree binding document for Loongson-1 NAND Controller.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > Changes in v6:
> > - A newly added patch
> > ---
> >  .../devicetree/bindings/mtd/loongson,ls1x-nfc.yaml | 66 ++++++++++++++=
++++++++
> >  1 file changed, 66 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/loongson,ls1x-nfc.ya=
ml b/Documentation/devicetree/bindings/mtd/loongson,ls1x-nfc.yaml
> > new file mode 100644
> > index 000000000000..2494c7b3b506
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/loongson,ls1x-nfc.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/loongson,ls1x-nfc.yaml#
>
> Please make the filename match the compatible.
>
Got it. I'll rename it to loongson,ls1-nfc.yaml and change the
compatible as follows.
  compatible:
   items:
     - enum:
         - loongson,ls1a-nfc
         - loongson,ls1b-nfc
         - loongson,ls1c-nfc
     - const: loongson,ls1-nfc

> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Loongson-1 NAND Controller
> > +
> > +maintainers:
> > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > +
> > +allOf:
> > +  - $ref: nand-controller.yaml
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: loongson,ls1b-nfc
> > +      - items:
> > +          - enum:
> > +              - loongson,ls1a-nfc
> > +              - loongson,ls1c-nfc
> > +          - const: loongson,ls1b-nfc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  dmas:
> > +    maxItems: 1
> > +
> > +  dma-names:
> > +    const: rxtx
>
> If you only have one dma, why do you need a dma-names entry for it?
>
Without "dma-names", the following error will come out when doing
dt_binding_check.
  nand-controller@1fe78000: 'dma-names' is a required property

In addition, loongson1_nand.c calls dma_request_chan(). Then
dma_request_chan() calls of_dma_request_slave_channel(), in which the
'dma-names' is necessary.
struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
                                             const char *name)
{
       ...
       count =3D of_property_count_strings(np, "dma-names");
       if (count < 0) {
               pr_err("%s: dma-names property of node '%pOF' missing
or empty\n",
                       __func__, np);
               return ERR_PTR(-ENODEV);
       }
       ...
}

Thanks for your review!

> Looks fine to me otherwise though,
> COnor.
>
> > +
> > +patternProperties:
> > +  "^nand@[0-3]$":
> > +    type: object
> > +    $ref: raw-nand-chip.yaml
> > +
> > +    unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - dmas
> > +  - dma-names
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    nand-controller@1fe78000 {
> > +        compatible =3D "loongson,ls1b-nfc";
> > +        reg =3D <0x1fe78000 0x40>;
> > +
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        dmas =3D <&dma 0>;
> > +        dma-names =3D "rxtx";
> > +
> > +        nand@0 {
> > +            reg =3D <0>;
> > +            nand-use-soft-ecc-engine;
> > +            nand-ecc-algo =3D "hamming";
> > +        };
> > +    };
> >
> > --
> > 2.40.1
> >
> >



--
Best regards,

Keguang Zhang

