Return-Path: <linux-kernel+bounces-67712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69E1856F89
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749861F2215C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CFF13B791;
	Thu, 15 Feb 2024 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rh9lSOmr"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3B713EFE4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033768; cv=none; b=DyxOWu8vOSqagYoKNNuat3aa9H//rPjUzDlMRg+iWAICWLnTEGc8wrshPa2bhmP5oywxLXAhGwVi0PFaJxbntamP6w7sIICmVWsz4Kg3EaAreIdiJKlQUpMy1besGV1UzjhWKaCEua/Fp3nMdj4xsO6A8fC7FzDS5eGsvpsQRak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033768; c=relaxed/simple;
	bh=egrIl87HVa6P/9NzKEjM0euP217KPHODBvobgCHy12A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJX+BVChuMP0Am9tTcOIdoU+1GK5gupamBMyKX+6fwfOqhRmuRkDVRb52oDs7nK0PK1r/z66Ph4h2/eV16TnAFqFlfNSjluCQuCje3Xg3YnIORbEg7SjUiNdrR4VzfUzLdrLhUNmr2RCszkXK2YLG96w6/keD/zVkqyX61cBVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rh9lSOmr; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51178bbb5d9so119887e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708033764; x=1708638564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy4dy8qC/aEpgjhI6zSmtJIrU/2TuVH5URvhfhOyGwE=;
        b=rh9lSOmrU+eCmbHKQwi9E9XEvOeICGmz0ntsyrw+XJ/xjZjRAzEo7QVJAjidP3IrfC
         Sn9KbY2qYcHOPcpMaeIzajiJaqwBgGXfNeko9YB92BEcHsrXlM0Vyat4NlPZWUEjOmqc
         LHIgsXjkIHmtkVhyhdyS03Y7RhuFh7k5Y2tCq9XmOODfe+jkuzIRgvq45VIchQ5ru2lx
         VkvomhrYCA4hTxEbGkbUdZKLNjHHar1DQAUlrs6+ST9FZq4UoWY5PysTWkg5FIqFXhlj
         NTCYMgp6dIwRA9qwpplKmd76Dhk05r9uzdOkHqfav4GkP91JK+/O5ffcmDyefwwQZFBL
         tVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708033764; x=1708638564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy4dy8qC/aEpgjhI6zSmtJIrU/2TuVH5URvhfhOyGwE=;
        b=CqTvbzmmzhqO+g3ckVSqtT+RVuY1yhqLRHA6xPCMwHOuvW+zRKBOrjxPQ4pY3BoWrJ
         WhD1wiOKGpQ63gYyDXic75wmizQT9yZsHChQcPoiIxX/TOfai49yv/iAs5fHJyZa151t
         sfJPud5Cglve5RlgDudQthd7LunB2/943SoBT2+tqllRsel4WfIqADtS9epzMM6z4e6e
         Wc2nS+FAkYLFu6g4bosd4U2jodeBnMS/D6xzP/1sHJPRY8MQvUufEaq1Y/jUjz29RzlH
         PXYd3iNbQuh2zPW4wO/hwIPwCsWSJ75Bi0FJCSWn3hmELyKy30EIm8kpJfFhgTDjMiaW
         00dg==
X-Forwarded-Encrypted: i=1; AJvYcCU3yHcIcYpny2Z33jF4Izw3KcclnXEaRQFMLGM0SUv4L7jQUl5ukNbzDF6SxNpqiAFc+oPKMde1WcPo4tLOWcsc2YJMzYt7gUXR/JFs
X-Gm-Message-State: AOJu0YymQFjNYo8v/umjatCwDLlFVRoilGOwRJ2rPEC/WC98STfxLkSg
	mLgvT1qNsBrCQXmrWEs8uI3KV7mhA2Ye26xO1ZH2Ej21vi5438oiWBm/8vH0VgxHNdRDoGrBH9V
	bDp5ZjREKaV7gxaIu8LEz7NFcIlD15Jnlkbd33A==
X-Google-Smtp-Source: AGHT+IFblS658xAUkyzNInl0/6coFWFu424jBrjv6P7mBNcHohWTiH831Tul1x/9RSSF6JS9qjHsfg7rEDFJ3nMR9BI=
X-Received: by 2002:a2e:9c87:0:b0:2d2:1699:fb5e with SMTP id
 x7-20020a2e9c87000000b002d21699fb5emr210697lji.2.1708033764453; Thu, 15 Feb
 2024 13:49:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
 <20240206-ad7944-mainline-v1-1-bf115fa9474f@baylibre.com> <CAMknhBGG_RS1t0OJw6_UnNQ_=S4YgN4i1YN26V8n=f9y28J9hQ@mail.gmail.com>
 <20240215132334.GA3847183-robh@kernel.org>
In-Reply-To: <20240215132334.GA3847183-robh@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 15 Feb 2024 15:49:13 -0600
Message-ID: <CAMknhBF8BQQfXkMvu3dS-RtaYBeOZ7mfCNxMaq3LOWwLp1_cxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add ad7944 ADCs
To: Rob Herring <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 7:23=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Feb 06, 2024 at 11:34:13AM -0600, David Lechner wrote:
> > On Tue, Feb 6, 2024 at 11:26=E2=80=AFAM David Lechner <dlechner@baylibr=
e.com> wrote:
> > >
> >
> >      if:
> >        properties:
> >          adi,reference:
> >            const: external
>
>          required:
>            - adi,reference
>
> >      then:
> >        required:
> >          - ref-supply
> >      else:
> >        properties:
> >          ref-supply: false
> >
> > to be sufficient here. However, currently, if the adi,reference
> > property is omitted from the dts/dtb, the condition here evaluates to
> > true and unexpectedly (incorrectly?) the validator requires the
> > ref-supply property.
>
> That's just how json-schema works. With the above, it should work for
> you.
>
> However, redesigning the binding would make things simpler. Just make
> 'ref-supply' being present mean external ref. No 'ref-supply' is then
> internal. Then you just need a boolean for 'internal-buffer' mode and:
>
> dependentSchemas:
>   ref-supply:
>     not:
>       required: ['adi,internal-buffer-ref']
>

Per Jonathan's suggestion, I plan to simplify the bindings like this
but just use the presence/absence of refin-supply as this boolean
value to simplify it even further.

