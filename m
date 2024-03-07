Return-Path: <linux-kernel+bounces-95300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC43B874BF1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2325EB2422A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11225128360;
	Thu,  7 Mar 2024 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHV5nH3a"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB1839E8;
	Thu,  7 Mar 2024 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805968; cv=none; b=Ly7b3OIt5i/avo6fsMg/za0tuE4X4CU9dk5YcaFxKk/6x6OddtXjQKq4JRe065BZERs2uxAidYqoo8jMN6ZQHYkTCXa9KqMIry25ihnqjRmGU8OnLM3aay4eRq2sFM57X9va0NzymCcvW9vrvaS4Iss121TAxbRoFg/W8WN6FMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805968; c=relaxed/simple;
	bh=qfvjHQwoqdDzaovBoDzuxv7Cbdh0CpWNZMeToAZU+68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZpYQFBrRdjfRgwwnWg50TcF/iY04lSZbqGnF8UebqmSePamIf4h0yczjYmDoeW3iJgo3j6QocmcxA/ghL7itKj2hxsrjFI6bNzjx66w1CX+V9qj7wlsHkHCb38iGXS6zHsY7V/i1gRR0j95/F59pHB13MP+nrgktT6eGXejm5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHV5nH3a; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4d37ab398dcso96361e0c.3;
        Thu, 07 Mar 2024 02:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709805965; x=1710410765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ltGQZ/KJpP2IEJRV87ZbGJjG+U5zUA6j0BQLiJ1uwI=;
        b=gHV5nH3afIiNa6/7OU7yqAAgKxETc1A6Movqn0eOb7PaWD6CWowqcREH4NHa/CXult
         k4z9YPZhRRK2At2Pu1RQYlHzcvC1TokLuETp278lXm+d98I5KVrSLpz8AKNV5YcGEl8H
         HPDzg9woETGVKECe6y85tIOn5RU+H1OEa49m7ajhaRo4TMfYg4quEUuvyOC5/OZLW1YT
         EnPW0J22eRmbynCbNaicF8RYSXoPY09ENOGURmi+IakZ5d93DCwPNXLFZbXseJyO5udU
         UbrXL8dYgL5/6yK7I+l+vM4flpEZftYzJ9ZPWmD0fzLOIG1rmr2GwsaAU/lfqIYPzohc
         +C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709805965; x=1710410765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ltGQZ/KJpP2IEJRV87ZbGJjG+U5zUA6j0BQLiJ1uwI=;
        b=J9eAkSBJ3peXFsUIaZbKTNDdzBJPocUGnsxnbuLjrJ6MJdXs/9l5r75A4Y6L6g///t
         Y9JE838tXw8BS/d6YP6eydiXRoSC/kjpAnTo4JuzDyH4Zb3xaLedZGL5tv9OSHbbcSKF
         VB7/wTYGdZ19Kd32k/BAPT380E8fDF2dERE0jNLl5oRuK7lNP4HFBuPQJA8SXyWIuT0l
         FyCtFmwu1XZXn6Bx0ySGaFjpJlULvlsh9/5n1Gmd7RO1jgH7F8iz7td8WF4bH+At0iNZ
         zxTKA3fshk9HHlafuj/VodY1a7MKH1DAjtC63ObtR/0ICksDjS3dpz+fOmv2AUBA24oZ
         50vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKGSse4JqZ05AvNSSTIRcKFdyVn1Hrbmx4EOu95YszG3gWsSMaCYNWLt72IZa6YFE2kKI2geEm6seTxbzF25z03DdeHhA2bFSUCvgfr63aChi++mCzX3Gw3YJrNI4ARcgtMkAXPg20u7ENEsomKo9gnUwRj0/vNP7Pq45/ToMT1rZ8P+X9frwakpVPtK5gBMIHlLBplQWg+E1g67oUOf8E26/H72riDsTt
X-Gm-Message-State: AOJu0YxGeyucRyayFX3U+Gog5PYAF7qvW0H68uF/i3wUXOVP/U6afNnN
	G48HlR6bC98OZk0y1h3IV4MDrEF7sanDYtY+TRJffEW+WxYvHMGaaRgHrnFnMuhjmaLcXnkqEbT
	ZuuJRDvxCyxcbxIL3twEXh8ymltU=
X-Google-Smtp-Source: AGHT+IHqy5vDNZO7eZ5kNXfFGy2+p+Y++hS5k9Y/ZeQNmqzSf3qqPj0MCm3dfxWU7rbUDFBOnpfrMcuwSK4zgT7SoUM=
X-Received: by 2002:ac5:c357:0:b0:4d3:345c:6a6b with SMTP id
 l23-20020ac5c357000000b004d3345c6a6bmr6365367vkk.16.1709805965620; Thu, 07
 Mar 2024 02:06:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306231007.13622-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240306231007.13622-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <a3b3ea89-8f4c-4deb-befb-d5219584901e@linaro.org>
In-Reply-To: <a3b3ea89-8f4c-4deb-befb-d5219584901e@linaro.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 7 Mar 2024 10:04:59 +0000
Message-ID: <CA+V-a8tE=tHLWAOnLvrSXeATtevuyP-B=BzowKzvZzqebQNCrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: serial: renesas,scif: Validate
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

On Thu, Mar 7, 2024 at 9:53=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/03/2024 00:10, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > This commit adds support to validate the 'interrupts' and 'interrupt-na=
mes'
> > properties for every supported SoC. This ensures proper handling and
> > configuration of interrupt-related properties across supported platform=
s.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../bindings/serial/renesas,scif.yaml         | 117 +++++++++++++-----
> >  1 file changed, 85 insertions(+), 32 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml=
 b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > index af72c3420453..1a5f4568ae4f 100644
> > --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > @@ -82,38 +82,6 @@ properties:
> >    reg:
> >      maxItems: 1
> >
> > -  interrupts:
>
> Properties should be defined in top-level block with widest constraints
> (min/maxItems). Your if:then: narrows them per each variant.
>
Agreed, I will fix that.

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
> > -
> > -  interrupt-names:
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
>
> This probably could be:
>
>         minItems: 4
>         items:
>           - const: eri
>           - const: rxi
>           - const: txi
>           - const: bri
>           - const: dri
>           - const: tei
>
> > -
> >    clocks:
> >      minItems: 1
> >      maxItems: 4
> > @@ -173,6 +141,91 @@ allOf:
> >        required:
> >          - resets
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - renesas,scif-r8a7742
> > +              - renesas,scif-r8a7743
> > +              - renesas,scif-r8a7744
> > +              - renesas,scif-r8a7745
> > +              - renesas,scif-r8a77470
> > +              - renesas,scif-r8a774a1
> > +              - renesas,scif-r8a774b1
> > +              - renesas,scif-r8a774c0
> > +              - renesas,scif-r8a774e1
> > +              - renesas,scif-r8a7778
> > +              - renesas,scif-r8a7779
> > +              - renesas,scif-r8a7790
> > +              - renesas,scif-r8a7791
> > +              - renesas,scif-r8a7792
> > +              - renesas,scif-r8a7793
> > +              - renesas,scif-r8a7794
> > +              - renesas,scif-r8a7795
> > +              - renesas,scif-r8a7796
> > +              - renesas,scif-r8a77961
> > +              - renesas,scif-r8a77965
> > +              - renesas,scif-r8a77970
> > +              - renesas,scif-r8a77980
> > +              - renesas,scif-r8a77990
> > +              - renesas,scif-r8a77995
> > +              - renesas,scif-r8a779a0
> > +              - renesas,scif-r8a779f0
> > +              - renesas,scif-r8a779g0
>
> There is no way compatibility strings express it?
>
I'll cut it short to below as suggested by Geert,

   - renesas,rcar-gen1-scif
   - renesas,rcar-gen2-scif
   - renesas,rcar-gen3-scif
   - renesas,rcar-gen4-scif

Cheers,
Prabhakar

