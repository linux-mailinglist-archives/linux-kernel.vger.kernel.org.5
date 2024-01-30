Return-Path: <linux-kernel+bounces-44602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C98D8424E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E32283EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F376A00D;
	Tue, 30 Jan 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="dEYyiex9"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141867E78
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617624; cv=none; b=Pq2HM9kGP/HKpoFmRXcKaxrCJXVDV5KxB6zdHO58T3R+StaWeRjCf+9nZWhyGifdY4PTMQGx3eXLMNcseJXhycpFNcuiY4gFG/zFfnsacS8bVX7PqPwSmtFnRaxB0QjYaGsqqkUFmj3DX3BMO0WLipnvMOXBn1H4EhUvUqqZMlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617624; c=relaxed/simple;
	bh=GGdqrxBG/Y3kLs+G2Ip6CA1IfInjv/UEkQbeiGuRPmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbRw4G+LRvR/Pko73qRXXRS3ztPBcGseeLF4LjsKn2zunZYDE/5oYQN/KrTF5jbR+bZeOwKkzq+FqCxk/FrzsGawxmtSJDnFXxybn4itlKzle8MPQWCIR6PJsVPDLQhrCK62ZJ126K6/ptiKIitpccFLzmrAKA3/cirO/IUWsnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=dEYyiex9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-295c1110b8aso179955a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706617622; x=1707222422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Cg42jMmh8yB78v9tW9O2QrPA3XJnOTs63T0IGlo0Ag=;
        b=dEYyiex9KVkCRIISxp56fZ7qsiGAsbWAM3c9kMYiIj7u+/IF7KA8r38EmN3iVfBbJ1
         5bqsRPln0o+4eP9Yx2K9c+pH4f1FmVwTHaC/WNFI9o13V6ZuoI+t3Dc8t0keMKomq0NW
         elzL2Fv4d9IL37hhCS2xdzA5xAzqJ3o187aRmHUNy44WqURUG4XpIFEZO4t9Rga1Wgb7
         m08AN5Jq0neQ+FUQ+ov/gNe3RX2IkNaIg6JYwTsu6bVNZox6gBPIDnfX4J7ILqckdKq6
         WrwZATuVXJkALTbITzxHSOZJOZvzpG9Oe8+Wn0GRVXL4Ssil37tuehnUn7EFq7P/uLvc
         r6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706617622; x=1707222422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Cg42jMmh8yB78v9tW9O2QrPA3XJnOTs63T0IGlo0Ag=;
        b=cBDPTRfztEizcfSPh+0ieUrF22/y0KPmILDbSM13ca21oTWlo+e6kb57RNF3ZD6iSE
         T8VYzv0uVm/ty/d2FNGMjAKUrgCeltHPMG2xvf35K8HaJwNvods4VyUn31uPLRwnI1QH
         /ZQpfXSvebXckbn2Zlm4do2KomHsCdG3iVXNHNU6Ndw8gnjwHqsUh/3rYZTRxa6iiiKb
         bGyeaEDZIBWsZeMpEz2Pwn1PFKAdzc8lkzvZGeqJYqI1jVggMfp+uZpmMsI9URonN5mH
         EexsvKJ5nxI1MAxGwgeyjDdcOHyMA3AQFEiLVoOTz8SgV1J0QcPGrmcRLlodOSXC3BIv
         0GvA==
X-Gm-Message-State: AOJu0YwWsdpEl1EcEF0L8zyuNIIhgksAXcXS9EwREKtrLRbE/vRpxLiY
	Hs7cyk0MwJXPbpCl0bPbrBGKzUCiWXEWbEEPKw7HqzIqKxJ+XuOxo27+kh7aL+jRZ67i/90rgo4
	DTNTmQ5sskhVY8cveHZWw9NaEdpaIkElLQgz3+Q==
X-Google-Smtp-Source: AGHT+IHAMTQklNebRk9oHCShAru7ITmaKw01qzstitEzo2Fy4hiAPRN/fIH2bhyjVs2CepvG4itNBb0nwlQ3okFa80w=
X-Received: by 2002:a17:90a:f2d1:b0:293:f46e:a354 with SMTP id
 gt17-20020a17090af2d100b00293f46ea354mr3843800pjb.3.1706617622223; Tue, 30
 Jan 2024 04:27:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130120807.460335-1-naresh.solanki@9elements.com> <b305291e-199d-4a0b-b24e-09910f1eed37@linaro.org>
In-Reply-To: <b305291e-199d-4a0b-b24e-09910f1eed37@linaro.org>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 30 Jan 2024 17:56:51 +0530
Message-ID: <CABqG17in2+0eHMRBvyunWKizgSBpYPq+CGsMO7FQo13pApPvaw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: cy8x95x0: Minor fix & update
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, mazziesaccount@gmail.com, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 30 Jan 2024 at 17:49, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/01/2024 13:08, Naresh Solanki wrote:
> > Update maxItems to 60 for gpio-reserved-ranges to allow multiple gpio
> > reserved ranges.
> > Add input-enable property to allow configuring a pin as input.
> > Rearrange allOf
>
> Why?
allOf is aligned with other implementations.
>
> > Update example.
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >  .../bindings/pinctrl/cypress,cy8c95x0.yaml    | 28 +++++++++++++++----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
> > index 7f30ec2f1e54..89ce0cb68834 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
> > @@ -45,7 +45,8 @@ properties:
> >      maxItems: 1
> >
> >    gpio-reserved-ranges:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 60
> >
> >    vdd-supply:
> >      description:
> > @@ -85,6 +86,8 @@ patternProperties:
> >
> >        bias-disable: true
> >
> > +      input-enable: true
> > +
> >        output-high: true
> >
> >        output-low: true
> > @@ -101,6 +104,9 @@ patternProperties:
> >
> >      additionalProperties: false
> >
> > +allOf:
> > +  - $ref: pinctrl.yaml#
> > +
>
> That's not a correct placement.
ok. Will remove this specific change.
>
> >  required:
> >    - compatible
> >    - reg
> > @@ -112,9 +118,6 @@ required:
> >
> >  additionalProperties: false
> >
> > -allOf:
> > -  - $ref: pinctrl.yaml#
> > -
> >  examples:
> >    - |
> >      #include <dt-bindings/interrupt-controller/arm-gic.h>
> > @@ -133,6 +136,21 @@ examples:
> >          interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> >          interrupt-controller;
> >          vdd-supply = <&p3v3>;
> > -        gpio-reserved-ranges = <5 1>;
> > +        gpio-reserved-ranges = <1 2>, <6 1>, <10 1>, <15 1>;
> > +
> > +        pinctrl-0 = <&U62160_pins>, <&U62160_ipins>;
> > +        pinctrl-names = "default";
> > +        U62160_pins: cfg-pins {
> > +                        pins = "gp03", "gp16", "gp20", "gp50", "gp51";
>
> Your indentation is totally broken.
sorry I missed checking on this before sending the patch for review. will fix
it to use two space for indentation.

Regards,
Naresh
>
>
> Best regards,
> Krzysztof
>

