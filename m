Return-Path: <linux-kernel+bounces-109988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1988858A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D612827C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19D55D733;
	Thu, 21 Mar 2024 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itpAkv0S"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401758AAF;
	Thu, 21 Mar 2024 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022203; cv=none; b=REmNzSYE4z8pioBMe/aMD2zIaq3Dasad4v/Aw2C+nCaAeGYB+G1QoLMxyBmNAW/FqFfsZk93pH8kBED+pqjPy8LCOj9/joEmeEXt0eVAdMe4RTInC8tuNhA12v+/hRWzISQCnfUvGvFsKG52ST1LvdPsb4mANx9dP8Hsy1MRX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022203; c=relaxed/simple;
	bh=ClOpV1tUHPrV9xbbPmCV71AFRJniHeEgt5+wDpHdPuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLlkUKUK2s0VUt1U34uN+CBjF50CgFhBkQq0yOzbNpi/Zo0Y0BC4K2bLAhzTCeF7Swgx4dHclVRrCHipYeMJlSOPfjhTZEZGaRDPkLUjJlEbwPutgALngFr1Nltc+rU7q3mQCDWLZX5BbLZVK4rAnxujt4ZdQBSsN/kwtwhe2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itpAkv0S; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso910903e87.1;
        Thu, 21 Mar 2024 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711022199; x=1711626999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qroAAFcs7TC1tOdTn1sB37AUBpgXbN1aHENpqRPoyEw=;
        b=itpAkv0SePTYNevgPlq4Ns4hfmR8925Z4mz1eYaF7VZiPy9+ThNzBkC9aHnkUmEFcx
         PCD/gof8HJvnrgNM6lheFsDVrVsUp17EELTW03Zx761R0Y8wO+XO64ubt6jOuaRwLKkg
         k3l9ij4FfC1BwOP79tyq10SbX6/UwXSpUn4xbiV7MQ6UtBOmCTYOuH4dqnuisgq+C+x+
         K5ZCV+IMq6dZnggvcHWgICdSJPXR7kQDnOz4kJ9WB6kwLMF3AHzdlKanv0pDbD+Zq91r
         eHMyH5FYzw2J9x5x70UcPywJ96MO9xQb6RZKU7Mfs/9S1EZAEzz+CxbQccnJ8vn2OFjF
         sWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711022199; x=1711626999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qroAAFcs7TC1tOdTn1sB37AUBpgXbN1aHENpqRPoyEw=;
        b=oeedb5k08ClJOAYbHjM5oBI+h4VIwWNuSXHEl9Y6KfWOWW+aOakpqAsUi87nZzUr5s
         YgUfY3Fj5efWufxceHrMD7glqSFkRI2tiG9Elxq7oK2trSuGUfFD2uYP9IOABXqXHQmh
         35n/HIo+L8oAh8GV3827JyTIBWEBwSrEd3lSjdeKFQPW4kJnht0dvSiEM0GkXmVnECzW
         ouoVZ6TeSfhzkVoO3lO9ZR2f8iKbELGCm9HBn2jAYDBX/s8DnbkylvB8/JLqzzAskOll
         TqK/Nk3oku9UZBdt86W6YnPpxkKYouxHt/4BFKbOj7RsWgeUpX1KRrTjHtvjSLYV/5x/
         2ssQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUI6LcleibY41khsjPOelNfELVzEJWTJ5CYE8EJY03FukNKPuhRp5qo0SqwBt/uuFI3nxkVfweRlDiWHFO+/6A33K2gvumN5PzOQzMKGJ8YcEhiUGB/aA0ejsq1InLKzjKWtJPdQnk005/YF/8qJ+jyXp/yG9mnq7ak8fGjjSkcw==
X-Gm-Message-State: AOJu0Yw2MIVZsKJ62yp0qD3sxFZdo2AUDbTbIpDTHUUU+Gg3G07LtYYe
	YIseVuOZOV6WP+cROZ7H1hDLfdyE9pVC7EryW5l8LNMtYvccdqBiRVcjTWzE3g/HCpW+k9BDmm4
	vUgCSkLTJGD56LI9A3qtBkt3LypQ=
X-Google-Smtp-Source: AGHT+IGoMlZM1r7Zbtwlbo2uEyA+VsoDZudn1PSQ5QwgZ9K0dJhVnqBX5wuYEerXv39Ut1ues4IiMPxranFe7AEBRTc=
X-Received: by 2002:a19:ca5a:0:b0:515:9479:a997 with SMTP id
 h26-20020a19ca5a000000b005159479a997mr691094lfj.10.1711022199188; Thu, 21 Mar
 2024 04:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-1-4d9813ce938e@gmail.com> <d2568101-f3e0-4c2d-8613-52d023e22b77@kernel.org>
In-Reply-To: <d2568101-f3e0-4c2d-8613-52d023e22b77@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 21 Mar 2024 08:56:27 -0300
Message-ID: <CAJq09z6q2gaZYqc-=fQEMOA1ViAKTEJqT9iF2xsYCde9syouig@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: realtek: describe LED usage
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof

> On 10/03/2024 05:51, Luiz Angelo Daros de Luca wrote:
> > Each port can have up to 4 LEDs (3 for current rtl8365mb devices). The
> > LED reg property will indicate its LED group.
> >
>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline), work on fork of kernel
> (don't, instead use mainline) or you ignore some maintainers (really
> don't). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
>
> > An example of LED usage was included in an existing switch example.
> >
> > Cc: devicetree@vger.kernel.org
>
> Please drop the autogenerated scripts/get_maintainer.pl CC-entries from
> commit msg. There is no single need to store automated output of
> get_maintainers.pl in the git log. It can be easily re-created at any
> given time, thus its presence in the git history is redundant and
> obfuscates the log.

It is a left-over before I adopted b4. I'll do the cleanup.

>

> > +patternProperties:
> > +  '^(ethernet-)?ports$':
> > +    type: object
> > +    additionalProperties: true
> > +
> > +    patternProperties:
> > +      '^(ethernet-)?port@[0-6]$':
> > +        type: object
> > +        additionalProperties: true
> > +
> > +        properties:
> > +          leds:
>
> type: object
> additionalProperties: false
>
> > +            description:
> > +              "LEDs associated with this port"
>
> Drop quotes.

At some in my frequent system upgrades (rolling release), it
uninstalled the yamllint

warning: python package 'yamllint' not installed, skipping

It should have catched that before.

>
> > +
> > +            patternProperties:
> > +              '^led@[a-f0-9]+$':
>
> [0-3]

leds are already defined for a port. I'm just trying to add a
restriction to allow only 0-3 leds and use that to identify the group.
These suggestions will redefine the leds property, forcing me to
declare #address-cells, #size-cells for leds and reference the led
schema in led@[0-3]. Is there a way to just add a constraint to what
is already present?

>
> > +                type: object
> > +                additionalProperties: true
>
> This cannot be 'true'. Which then will point you to errors and missing
> ref to leds schema and need to use unevaluatedProperties: false.
>
>
> > +
> > +                properties:
> > +                  reg:
> > +                    description:
> > +                      "reg indicates the LED group for this LED"
>
> Drop quotes
>
>
> Best regards,
> Krzysztof
>

