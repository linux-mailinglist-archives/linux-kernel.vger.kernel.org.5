Return-Path: <linux-kernel+bounces-96819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 047278761D8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA9A1F216BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52345380F;
	Fri,  8 Mar 2024 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2Ci6wbn"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7794F5F9;
	Fri,  8 Mar 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893208; cv=none; b=bhG7nwDbJB/e9iFDogysCPlq/Fp415t0Z+eEKIWrVwfnT/ugpq6JgHhgPqEjZsZxYVN/uyDfbIELrrLBjWE5+UIFil0/5U8q0MrYHPOHPH14+w/sarzkCmq07oIfbEgrFqNIbS81yDuNIABuZAkBQrzD1Nugdzmd9TkVhlWXnW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893208; c=relaxed/simple;
	bh=/D9RFcnsiPTtrDahvT+uPlRMBnSBcdNj1fD4mx8V2q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKjbv/6FEV5gSnb/14orP5x4J6NcVuq+AoC4eMdMK8iOPcNzks4wrPOAMvgElnpKeZNOh8gv+z8Hda3R2+9EpEjIHcu0q017DUIJsIH0ZGkAYEXaguhuzDdvOArKqmRM+cHUuK4oaBxfivIkr4VVz15SgMJ7Vum8g47BalD/7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2Ci6wbn; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7db1a21e83fso413546241.2;
        Fri, 08 Mar 2024 02:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709893205; x=1710498005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3YRsmPk4+j+DhswmeO7tX7vN7xRI4YjcgMo0LaTJpk=;
        b=H2Ci6wbnftg/xLqSiVEp2jJ3krYiEGZC2jHEQyeRWRE3en3CYaTSLDIKoTd7jN3UEd
         u2KwWuDJ0/Cwi9ATuULgVwe7yOLkxJz7kXtK0LuTo1juWbOCW0JgSPfikdLACjgphtQZ
         b06i20qiZGAGEneiLiR4gNCTqTWzfHxlLbeL9WepgM4y6sagFi7IxDe/Td174LdPx8Ma
         r30idJ4gGrRUJwyxSeCIwBCPG9YS5zn7i5UDKfAIxO121mO2BkUFcWKinUWQnBBlgzGY
         kHuHPYvHC4Y5bZX6QvnFNd/ilD98bGzzjSnYRcEwtz73KJ6u3nTECynm/ZEu72c3CEYj
         4JTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709893205; x=1710498005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3YRsmPk4+j+DhswmeO7tX7vN7xRI4YjcgMo0LaTJpk=;
        b=cR9hsASYmtpSXDr6D9EwAcb+cMSeuSz3431PxybF/B0NcqILxRrjtR3IfDCXxf4qGz
         LpIIY2VpRHvf1iCJ3fiH7lI8xGdwbu9OLaHQzU+GMxwOSY45eJhO5EupzIDOif1fup8u
         yFUQQLtpnRkWrtokWik7d5y4ztM/hP9rFzPLmJeBlGWmv0wckcyzQ2WbVkqYgmeRcVIE
         6jelPvIiOaDfG1lJrEW+huUg5+qSMQ37D8lzQbYdiMXrsZ1EuJKmUDRPineQTKQ+As19
         hPAHTYUQOGFxNgw8K2yGynpG+f6Mh92yEzj5pjGblNj9U1RfCqnaJc6ZiQvnsMHaS6hv
         4fGg==
X-Forwarded-Encrypted: i=1; AJvYcCU0HXYtrLzKDeRdFjqLQl/EgnFoGgBbgJVsftWblB59gQT7/tvp6g/refy1rVlFd7worb7HKeIsBE5qH/K2DsrNxiGe1D1f+rSxfKzeS2aEB1FDlHcgPcw/+MwnJRWkxOenMmFVsx12a5MMI3kHL4b2PkhAiA+EyYlv7OMpkUJe/mQ0jF3/XXCXbFDPFMS8dgu/1vyNyy4uXMGNMU1qCeZ6EowiKrTnPQln
X-Gm-Message-State: AOJu0YxmOuRRA1dCj4XBH2zYbrOMIUBoZMxrX6O/rV+kD9Ybum/GLLYe
	owMeuknXbAvxG8eH+l8C7C8kgVEXtPAw77h8cyg2aNWtHdvDMiIafYDyWL7627yzs9exM5whRDc
	8spYeahhx49/hlHDl3DgsqfaCAj3wDmpjyhM=
X-Google-Smtp-Source: AGHT+IGrAB9/8/ThqY/liT9EWXmOS6hU9aihtHZ6M3gq7/6RMfNrLZxU7vIInruG1ZNLRZkXRwoYYz0XSIzblbu//vs=
X-Received: by 2002:a05:6122:468f:b0:4d3:3446:6bc9 with SMTP id
 di15-20020a056122468f00b004d334466bc9mr10750338vkb.14.1709893205014; Fri, 08
 Mar 2024 02:20:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307114217.34784-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240307114217.34784-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <4ba7af38-5cc1-428a-afec-75610934fc72@linaro.org>
In-Reply-To: <4ba7af38-5cc1-428a-afec-75610934fc72@linaro.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 8 Mar 2024 10:18:58 +0000
Message-ID: <CA+V-a8txZr8WWxtN-=Ek3WZ3GwLT3m+Tcog-5zAx+A4kZL1=yQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thank you for the review.

On Thu, Mar 7, 2024 at 1:50=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/03/2024 12:42, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > This commit adds support to validate the 'interrupts' and 'interrupt-na=
mes'
>
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/sub=
mitting-patches.rst#L95
>
Sure, I will update the description.

> > properties for every supported SoC. This ensures proper handling and
> > configuration of interrupt-related properties across supported platform=
s.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * Defined the properties in top-level block instead of moving into
> >   if/else block for each SoC.
> > * Used Gen specific callback strings instead of each SoC variant
>
> You are sending quite a lot of patchsets touching the same, all in one
> day. This just adds to the confusion.
>
Ok, I'll make it as a single series.

> > ---
> >  .../bindings/serial/renesas,scif.yaml         | 90 +++++++++++++------
> >  1 file changed, 62 insertions(+), 28 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml=
 b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > index af72c3420453..6ba6b6d52208 100644
> > --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > @@ -83,36 +83,24 @@ properties:
> >      maxItems: 1
> >
> >    interrupts:
> > -    oneOf:
> > -      - items:
> > -          - description: A combined interrupt
> > -      - items:
> > -          - description: Error interrupt
> > -          - description: Receive buffer full interrupt
> > -          - description: Transmit buffer empty interrupt
> > -          - description: Break interrupt
> > -      - items:
> > -          - description: Error interrupt
> > -          - description: Receive buffer full interrupt
> > -          - description: Transmit buffer empty interrupt
> > -          - description: Break interrupt
> > -          - description: Data Ready interrupt
> > -          - description: Transmit End interrupt
> > +    minItems: 1
> > +    items:
> > +      - description: Error interrupt or single combined interrupt
>
> That's not correct, your first interrupt can be combined.
>
In here we are combining and making a single list hence the
description is updated as "Error interrupt or single combined
interrupt". so that we dont have to list the items in the below
if/else checks. Also when the interrupts are combined we dont specify
interrupt-names hence in the below check we  set "interrupt-names:
false"

> > +      - description: Receive buffer full interrupt
> > +      - description: Transmit buffer empty interrupt
> > +      - description: Break interrupt
> > +      - description: Data Ready interrupt
> > +      - description: Transmit End interrupt
> >
> >    interrupt-names:
> > -    oneOf:
> > -      - items:
> > -          - const: eri
> > -          - const: rxi
> > -          - const: txi
> > -          - const: bri
> > -      - items:
> > -          - const: eri
> > -          - const: rxi
> > -          - const: txi
> > -          - const: bri
> > -          - const: dri
> > -          - const: tei
> > +    minItems: 4
> > +    items:
> > +      - const: eri
> > +      - const: rxi
> > +      - const: txi
> > +      - const: bri
> > +      - const: dri
> > +      - const: tei
> >
> >    clocks:
> >      minItems: 1
> > @@ -173,6 +161,52 @@ allOf:
> >        required:
> >          - resets
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - renesas,rcar-gen1-scif
> > +              - renesas,rcar-gen2-scif
> > +              - renesas,rcar-gen3-scif
> > +              - renesas,rcar-gen4-scif
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 1
>
> You need to list the items here.
>
Shouldn't the already squashed interrupts list still be valid here?
Why do we need to list the item here (and below)? If we list items for
interrupts should we be doing the same for interrupt-names too?

Cheers,
Prabhakar

> > +
> > +        interrupt-names: false
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - renesas,scif-r7s72100
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          minItems: 4
> > +          maxItems: 4
>
> List the items
>
> > +
> > +        interrupt-names:
> > +          maxItems: 4
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - renesas,scif-r7s9210
> > +              - renesas,scif-r9a07g044
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          minItems: 6
>
> List the items
>
> > +
> > +        interrupt-names:
> > +          minItems: 6
> > +
> >  unevaluatedProperties: false
> >
> >  examples:
>
> Best regards,
> Krzysztof
>

