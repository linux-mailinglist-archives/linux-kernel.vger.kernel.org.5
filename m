Return-Path: <linux-kernel+bounces-109996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFC98858BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F062D1C20AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ADA76034;
	Thu, 21 Mar 2024 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkd8ok62"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A8B56B68;
	Thu, 21 Mar 2024 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022630; cv=none; b=XHtf1Lnzcmngip6C2thPWbhw4FPFmYNEuECWdfe97Vyb5iN6FzdgI1DijjDjqDam5qyXDbNZEBWqTTWPdoo4BPFoaOK9m+hyMtlulvHS2EFJzCIBCSLjvZ1/KTY5bpYwCIC1kwPLTJYawhTH1YTuQZCjt+7M4js304+dqkRRugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022630; c=relaxed/simple;
	bh=6tBrYa203xuCC51j6/N1hP+cXyjYjBcvGz8a2k1TW8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0/G/bkeqdL/NrTFXLeVP0Lht+77PaafF87uJ5S8k/sccbKIMzMOSHSVj+bQ4PhRtGUAu9pi/irWx57UWrDsln2vvRl1mei0hMtyXUrYcIbbot3/9e2Fll9YBTomwORT07msekpF4eQP9A8Kit6J5O4mj17T0dFpLqOBfyVnc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkd8ok62; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56bcb9640bbso607141a12.0;
        Thu, 21 Mar 2024 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711022627; x=1711627427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZuaEg5mTYe1p+g90HQY9VXRTkmxWXoDH9h8Hme3zkM=;
        b=kkd8ok623PBN1QBn0Ml2y6BovI/Rbt5OfNQ1TXqKBee32TVMzY+YD4xA1uqCGnSu5r
         ivu71rPeKxkTrc50Ja/yaXCwaccY/F2cIlUp5BcRRYyVoGo6nuCIpj1Mwj5uFhcGoG6q
         w9c24x7pk6j+hko5t3e1aR5Qu0M5gfcfZ7bV/F4vBDcaKieXOXnAMh3xkDLYZdpXqpCz
         UFl6pOtdHGMx4Ubm0j7+ObXSFiDVD+K8Y1WTad0NV/18zFwXqzqZvR3+6V+Us8hcETdX
         4rNX2ED3Ivch9goEYqhCg2UJ4LjIBDFaqg5vfYN0qGM9Egj8s5+m2URK21s7DpS0Nl8i
         tCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711022627; x=1711627427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZuaEg5mTYe1p+g90HQY9VXRTkmxWXoDH9h8Hme3zkM=;
        b=RCx7WpWjmQI9E0YMqdAtFNzV3jGXiOOKwWez7qE9XfJCJNXeiNUwsam26WgGmLAZJl
         WxKpHlx6LFVO/I0uQmvPV4yHjvwl76d3PujHsyAI7vZDuFpSEzc9iggyTTKjJnfedwit
         XxKMuHWUlJCM9RGSFuMVUvis2e5iAU25ZtlAMxewlpJEPdwcdVKzuOOhcgFhgYhDfSiJ
         AZedSNgS5rWVswwyWvMt4/L4bgD0ZJIrBLlThYu1X0b2Vh+bbDymCXwgk2YpfYyWB5Td
         7m28IpcdKHcC5ide8+E4iY3g4bY5eKT2d5SXzjZepJSNAIRIHvbFunyBqsScEmyOoAG8
         FJtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpaZ8oW7f1KZxzpgKmsByTGKTQU8CHC0FBip5lysMgKqpiOIDs04BRduSB0KKSokrjWSAsd5rPevXe3ZsmcvuhrmsAcDqRyU6Gvj4Px+lQVMahAHPb6xq9VRwB4VmHpH/gl4l34JIKSsljN0dJKd6l7sx3gdUHrEzLXPQIoFESHw==
X-Gm-Message-State: AOJu0Yy13zxt1NKwrre6dte6Fws/DgXy+hyU+ROnK+wV2HyorbQJOjEE
	iHjKAys+wApYrc6QCfLpJfRBzHiG/n7FdpNFdEwbgKcHFc8E7q7333W3+65taH65eI4205b1m9X
	Df8NtZfxnR20Dh01TCiZGr7rPFWY=
X-Google-Smtp-Source: AGHT+IEdNcpby97h1zjyf0aFS1poMNJpJYG+OR/wb6fEAbDA/2zXZUCsa/fIfGYqn+836ym0L8juWXu/yyXOrcfy/E4=
X-Received: by 2002:a05:6402:4145:b0:565:e646:5c15 with SMTP id
 x5-20020a056402414500b00565e6465c15mr18890285eda.31.1711022626546; Thu, 21
 Mar 2024 05:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-1-4d9813ce938e@gmail.com> <6705a278-d294-475f-bc4c-b08926c5017d@lunn.ch>
In-Reply-To: <6705a278-d294-475f-bc4c-b08926c5017d@lunn.ch>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 21 Mar 2024 09:03:34 -0300
Message-ID: <CAJq09z5wXQQQtHJ5TdSz6J+Ov0Hifde25psoWm8EiHxV8c-TYw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: realtek: describe LED usage
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Em dom., 10 de mar. de 2024 =C3=A0s 15:02, Andrew Lunn <andrew@lunn.ch> esc=
reveu:
>> On Sun, Mar 10, 2024 at 01:51:58AM -0300, Luiz Angelo Daros de Luca wrot=
e:
> > Each port can have up to 4 LEDs (3 for current rtl8365mb devices). The
> > LED reg property will indicate its LED group.
> > +                properties:
> > +                  reg:
> > +                    description:
> > +                      "reg indicates the LED group for this LED"
> > +                    enum: [0, 1, 2, 3]
>
> If this identifies the group, what identifies the actual LED? There
> are four of them. How do i say LEDs 0 and 1 are unused, 2 and 3 are
> wired to LEDs?

Do we need to mention a specific HW is not present? I guess we just
omit it, like the led@1 and led@2 in the example.

> It would be much more usual for reg to be the LED number for the
> port. And there then be a group property indicating what group the LED
> belongs to. However, i'm wondering, is group fixed? Do we actually
> need it in DT, or can there just be a table in the driver which maps
> port:led to group?

The LED groups are a fixed HW feature. The chip has dedicated pins for
each LED in each group. Those pins might have an alternative usage (as
an GPIO) but you cannot change a LED from a group to another in SW.
That's why I thought it was a thing to be described in the DT.

>          Andrew

Regards,

Luiz

