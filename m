Return-Path: <linux-kernel+bounces-165209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71B78B898B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225411F22FC9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B89584D22;
	Wed,  1 May 2024 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G67jfSpi"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A23444C8C;
	Wed,  1 May 2024 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565186; cv=none; b=HfVvvdilIivstfOg48VnMAsUWiS2wz8jAgZajf1pkdLz/ty/5Xhq8eGM2y2rpK1Gas6pKufAVq1ykMRv/ORTC66y0dDovzNJ4brpl6pQlCY0t0KgHHCCjIwRabD7oVRaYhLix+JSwvgRSBEb88hwPEspA+YMV0HT7km2J9j8VbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565186; c=relaxed/simple;
	bh=yfKRCC596ZJoJTk455c95xVYTWBIjoU2Cts08sys9E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNZk9hBGsHOQuu55cHJw1fYwiL0f/OjB5toVUe24Himk9Oqf2sOGhIkwubznvsDf5RFxoJJXvqCrqMIaZREAdsa7xjBZm9fmtDxlOyQrQ14HDt18EcA0RFn+gDgSS2k/lDqwDIvcEvUN0FF1y0vInhwRTA2bCShUzauTt9VlruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G67jfSpi; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2df83058d48so55898001fa.1;
        Wed, 01 May 2024 05:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714565183; x=1715169983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGv39vI1YGufSjKkaX0v2nDsiNj3uArz+WZ5k9USy6o=;
        b=G67jfSpirhipC8IndYbO3BscA6awhbVUezLdr+56NXUm/2Yhmte9AyHd/ACn1FfeZf
         lq3Rx+SDmJF5ilsHecRKam7gh+UcVoLi4NomhUTRuoK3rM+jdcb2qM0fYzbJriDvSHEP
         /KmNAjrRtCkJE2VGGf2TeLD+75Yc2DuejzBLw6SLyx/lr/tagtZ8npNJx7AOKnh93ykF
         pnX5b4ieBmXaepWIf0cMssOyfJrGbFNW0HHvmUvSqlKLQ3txbrgdmNgPjygQ2OGLGWYO
         ptAIn8W7REVXePzYipxlScgF8ORerqMqJzd1997Z848IQtx1AVFsMuFZFGbq7m+CdyeY
         N1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565183; x=1715169983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGv39vI1YGufSjKkaX0v2nDsiNj3uArz+WZ5k9USy6o=;
        b=rckw5wdklvB9551T5GrISXgXLxq+NgVOZwY6jWI7a1/XD/OQ/3xbb0YmxSQ45M/jlu
         /3DdrE1/8Gm/YKnZaazihGxBXsWlx96BkuJAkb6gNKp8jtrVbKUQBjfd+aYzBkuDCpOJ
         QZRPyQA617Z1KK4ZKc6Dt6M6rvM1QuIqsE2jYHFqrZzRj2LcOId/0iHxsmVVQPN8k9UI
         /ZXyR+YyT9kyVmKXv/B8jL4kNtKprAaU+j1bCVBlL5Iu5FGgZPuvC47ZtA1oVJHVb9Ok
         Ppu0pKAjVw4qnCL16uoa8AnS25pOXa4jhN6wM7YzugjGlYhdytPmrlHARPrOYVFgtsSd
         WcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBJG+sCyOfXTr+jxIKyOLQBx6n1G3jRDwgJlmdvniNBlHhDmUt4eVP4CvZtjAEXFPe+fbBfLPV+EExLAR5E1g8pxJ+K6JkNxGnOfXnzFhiQytfjBMWoaOY+2PccHJqnVkXo5amIIyIAw==
X-Gm-Message-State: AOJu0YxyzQ3unJC6t0Xi3IumiHtjnN+LbFdynBZFaKwyySW2Ke08KGYh
	0+MkSnNMr+nIMZsIK/Cz7AuzLOM2AJXXnsFxHeqH5wJEFY4i3wXxYm9JTnaQxwqa8kRNQ1Aog6U
	2sTQ8gHaIB7nf8F6o4IqIAOyB0JY=
X-Google-Smtp-Source: AGHT+IEfJCRSoroTQgkU2WwcJUPOmho1XbtPDD2rO/aHAM00ksuSJ57kwVcWo6PtZ9d4p/YE5s71TxwO3NuwteAa+vY=
X-Received: by 2002:a2e:9a93:0:b0:2d8:71d4:4c62 with SMTP id
 p19-20020a2e9a93000000b002d871d44c62mr1387590lji.49.1714565183001; Wed, 01
 May 2024 05:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADFWO8GC6RP6A7H-Cq5UZHfBY3VJZTCqssdZet61hH031euhwQ@mail.gmail.com>
 <20240430-unnamable-wrench-16c9ad780df1@spud>
In-Reply-To: <20240430-unnamable-wrench-16c9ad780df1@spud>
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Wed, 1 May 2024 14:06:12 +0200
Message-ID: <CADFWO8FnMh3OSXO5c9YnafDEf8dxu7MHuH-J32H_Dgx4VSZ=Tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
To: Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 6:50=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Apr 30, 2024 at 05:27:20PM +0200, Petar Stoykov wrote:
> > From 60f5cc7f65b07124f19428a713c3bc33b9e4a7a7 Mon Sep 17 00:00:00 2001
> > From: Petar Stoykov <pd.pstoykov@gmail.com>
> > Date: Mon, 15 Jan 2024 14:29:25 +0100
> > Subject: [PATCH 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
> >
> > Sensirion SDP500 is a digital differential pressure sensor. It provides
> > a digital I2C output. Add devicetree bindings requiring the compatible
> > string and I2C slave address (reg).
> >
> > Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> > ---
> >  .../iio/pressure/sensirion,sdp500.yaml        | 39 +++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,s=
dp500.yaml
> > b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
> > new file mode 100644
> > index 000000000000..3cdf17df7d52
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.y=
aml
> > @@ -0,0 +1,39 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/pressure/sdp500.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: sdp500/sdp510 pressure sensor with I2C bus interface
> > +
> > +maintainers:
> > +  - Petar Stoykov <pd.pstoykov@gmail.com>
> > +
> > +description: |
> > +  Pressure sensor from Sensirion with I2C bus interface.
> > +  There is no software difference between sdp500 and sdp510.
>
> I see no mention of the sdp510 elsewhere in this patch though..
> If you're trying to add support for both, then add a compatible for the
> sdp510 that falls back to the sdp500.
>

Fair point. Our focus is on the SDP500. SDP510 is the same software-wise so
I just mention it but I agree that I should add it as compatible in the cod=
e.

> > +
> > +properties:
> > +  compatible:
> > +    const: sensirion,sdp500
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
>
> Other than the fact that a fallback compatible might be required here,
> this looks like a candidate for trivial-devices.yaml.

This sounds like a more serious comment. We will definitely continue using
this driver internally for now. But do you think it's still worth adding
it as a separate driver instead of leaving it for "trivial-devices"?
It has been a useful driver for us so we thought it is worth sharing.

>
> Cheers,
> Conor.
>
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      pressure@40 {
> > +        compatible =3D "sensirion,sdp500";
> > +        reg =3D <0x40>;
> > +        vdd-supply =3D <&foo>;
> > +      };
> > +    };
> > --
> > 2.30.2

