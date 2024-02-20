Return-Path: <linux-kernel+bounces-73701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1AB85C620
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA051C2154A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DED151CCC;
	Tue, 20 Feb 2024 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P2HhyoOz"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57151509A5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462466; cv=none; b=ZiQI3N8g24Ir87ArxVOOoJYNcugNzrJcYsGvb4vi0QwuwfM3xY0gD+eL+igjusBrBNgfLiTcDKEyfnX0wh0pjeQiS/mI5/yViwFTs2EsXGRZJ7pxEPKHWqufR9Ik7WtHvU2j+kK1rv8AwQjnwYlhmEo+P5oLI1J+TXvrZNc365I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462466; c=relaxed/simple;
	bh=Yi0rtUqZLJm2S6u03a6Dmkff761MDSWQIxTDSQNuYdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvCwlixradsKhttoXMNBtxPnVRoZEp2obzIcpdHiRK/Ap6S7/Uw2JIObk/bqTBnEP3WRfb9kkLw3ghCl2WnRXkn4dOUs9qMJncXI9NrQuIHxfmPbiE+7fi2d4kq1EEBAondXzCcYAzyRYJUlg1OH4NlEwTiwjw/H2+Z13deP7nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P2HhyoOz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511ac32fe38so9073559e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708462462; x=1709067262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyh9FR/LCnL9UHf/YvsJlGBxSygyQQc/DzYerA/eUFA=;
        b=P2HhyoOzqDJnE/Y9Kp4LbRwJniYfxSYfnuKrMCkUjU7WJTvr9S+LS+/wJSUhqRXiFB
         Tt6YhgakC0FwtiO38IQF7jExcdNUwVBRtbi4o5moscJax1HnT1tybfnc4AUIy5JSSMnQ
         C4BZ/uIkIWXgKkVI4fJi5D5RbI4INhnU8nZK3EFyzOmwqWYcTmPghry8dzdS+YJmW4+N
         3M7VwYawEO+u5oiBoC2ev0ouFnIWeBGt+fb0/wBqzT/Po4RjNOf9KqVt6P8jX4gN0Ioj
         W/vuoi8SeoF6B9G6A3r1ig0HtoFALXKogb3OvOnI2poUqkdVPDwv42gkK1p8GW2YngVI
         yQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708462462; x=1709067262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyh9FR/LCnL9UHf/YvsJlGBxSygyQQc/DzYerA/eUFA=;
        b=ZFJA8MW1i85KT17LD+AVrFFDQIqr+nm6EwmPXJ1ixgUxfKcel2VXJRNL4KVjnwERIu
         V4RF9j4GYOYOuW77WTLOxg21h+M3Jyi7VTQ6pce1hxVr6jwqG4MfirodAdqJ1ghJoSjT
         BxOPncuf3EuW+SrgPqQoHBHQS244DzKiXzvemfR/1BK/YJMLJdA2fblPG/Sq6BSpnHAP
         Q8CQnzRkvAObcFBNao6cS/2X8rjsvVS2WffjwsDzJkzizqmQAf4lN+6uUakVNQijdfGI
         1npFUlunFwi2wnbZ9PcUB2BtcIm1JWlTJPcbJGSRkPhWNG0CPL+P1fuwApVNTw0UIzlN
         64kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs0Td77ebs3fpZODC2XY0kmYkLv94IZJSGPycnQPMJH+hAkLau3fCHhmmj0tbmCxUVmZpA7nVOkg68ovYgtzxA7HynIPXBReVeFhmO
X-Gm-Message-State: AOJu0YxFeKL6mfd6Q8IOJO8PJlsq1NOEBGt+aH8ci1uP5oYFMtcPnyPE
	PzyBADBqIetxymuTAk7Ggy0ZWnLiTsRayUUw8jd+ije3nFSYKGgmoCktwpgDstPo9hOz3zd4ck+
	SvMaZv5KJvmuuRPuutfTq1tqBXYX7f2SpZ81Sz3N3QQPoisnHcwo=
X-Google-Smtp-Source: AGHT+IHZqlcVgt+ktb4ViHXtjGE0NSdsEiIKRla1wDkZQzzWbmG1Zgv7ZNzPVhE7Wq2SOamQcI56TcuJ7km+1hUpqHA=
X-Received: by 2002:a05:6512:1321:b0:512:bd65:860a with SMTP id
 x33-20020a056512132100b00512bd65860amr5309051lfu.5.1708462462005; Tue, 20 Feb
 2024 12:54:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
In-Reply-To: <20240220094344.17556-1-mitrutzceclan@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 20 Feb 2024 14:54:10 -0600
Message-ID: <CAMknhBEZ7Y1Yx=wJGnfvYWGKPLas3pbCyY+sN8vrBzdkYO-A4w@mail.gmail.com>
Subject: Re: [PATCH v13 1/3] dt-bindings: adc: add AD7173
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org, 
	linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Walle <michael@walle.cc>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
	Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 3:43=E2=80=AFAM Dumitru Ceclan <mitrutzceclan@gmail=
com> wrote:
>

..

> +
> +  avdd-supply:
> +    description: Avdd supply, can be used as reference for conversion.
> +                 This supply is referenced to AVSS, voltage specified he=
re
> +                 represens (AVDD - AVSS).

The datasheets call this AVDD1, not AVDD. Would be nice to use the
correct name to avoid ambiguity.

Also check spelling `represents` above and below.

> +
> +  avdd2-supply:
> +    description: Avdd2 supply, used as the input to the internal voltage=
 regulator.
> +                 This supply is referenced to AVSS, voltage specified he=
re
> +                 represens (AVDD2 - AVSS).
> +
> +  iovdd-supply:
> +    description: iovdd supply, used for the chip digital interface.
> +
> +  clocks:
> +    maxItems: 1
> +    description: |

Don't need `|` here.

> +      Optional external clock source. Can include one clock source: exte=
rnal
> +      clock or external crystal.
> +
> +  clock-names:
> +    enum:
> +      - ext-clk
> +      - xtal
> +
> +  '#clock-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@[0-9a-f]$":
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 15

Parts ending in -2 only have four channels.

> +
> +      diff-channels:
> +        items:
> +          minimum: 0
> +          maximum: 31
> +

Are we missing `bipolar: true` here? (since we have
unevaluatedProperties: false)

> +      adi,reference-select:
> +        description: |
> +          Select the reference source to use when converting on
> +          the specific channel. Valid values are:
> +          vref       : REF+  /REF=E2=88=92
> +          vref2      : REF2+ /REF2=E2=88=92
> +          refout-avss: REFOUT/AVSS (Internal reference)
> +          avdd       : AVDD  /AVSS
> +
> +          External reference ref2 only available on ad7173-8.
> +          If not specified, internal reference used.
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum:
> +          - vref
> +          - vref2
> +          - refout-avss
> +          - avdd
> +        default: refout-avss
> +
> +    required:
> +      - reg
> +      - diff-channels
> +
> +required:
> +  - compatible
> +  - reg

Aren't the various power supplies supposed to be required?

- avdd-supply
- avdd2-supply
- iovdd-supply

