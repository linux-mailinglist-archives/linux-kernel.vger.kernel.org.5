Return-Path: <linux-kernel+bounces-85599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D253486B82B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8780428A80F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987CA7443B;
	Wed, 28 Feb 2024 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R+e+/28X"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB927441E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148716; cv=none; b=I9rzKEoddxe7djLPxLBf27Sbu46qN3S+3qLloXtXGHpmrW52rUBNnPcvA1xQYdgyXljlfw3z7auz7e47jaOd9T6SH72ff3ZjuZ+uDaIeTD4ARSyRTej/imtr13UDKW8Z9mSbMjjQrni7pQccSCb40N0b1ZVzuDphYcZrLKp/+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148716; c=relaxed/simple;
	bh=CsmB9fARMIy01DhD7lmpgmTlIpsn7iHrh8AsXbNH4Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpyIX9F7L7ecVKir584tXcRoNIxI2RDMUw//iEVW9TXEYTjJYTBBnmENr8oEIOgBu8IP2p+7mi9bQgoXCcaRS5ApLTtczVC7nNEuHW4eqbQDUoUI63ZDUOI3ROrdFGIXaeHRfiBb8zhN6UOkUE7ErLG6HWaPzPcI4YW5IWh0/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R+e+/28X; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so963931fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709148713; x=1709753513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxzW+l5jEUWB61rf6mBekKpON+Tg5s7JQK0g/jqbljE=;
        b=R+e+/28XFP3gGWzZNSrdTpdZ5fVQwpEtlww2QcKiPhIOOZWn0laZ+VKF09Tq8ARaGb
         owsDODN3TLjcbRIPFA9NklS7uriteutH0rnNLndr8D151IacX3qNvXAukUcq8pjx0xFR
         CfT8umv62mZdOVMHrFRpRZ73fhR0Z1iNnWiJoYhe3ZDyrVW77EqcF9CoZfzkj5RM6AcX
         J15Gx2B62xWNt94JOZ5yDzq1QWJtrRVDW+jDOEPHW4Rrp0hxgShC375Ur8kuAKsxNJVe
         b/3JYUjeLT7wjqyvseTtfrw7MSJBiiNeWZmGvDSm4HX6fl/nqZYCqhdhdYhN/W7Wfzyw
         ifhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148713; x=1709753513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxzW+l5jEUWB61rf6mBekKpON+Tg5s7JQK0g/jqbljE=;
        b=Jb4ewfKMMdESTgnstspGMbB3iOXArTu+Fv22V6W37lSrklcIfxC9F2MiwrxuPpFb1P
         A2dOxX9lVFr4xezwCs08bhnyITCrtD1MuLrvVw30VWnwKVAuxSZW6jppIM9OMSC4mKgU
         iOmS0Z9Uzv5tvawMycqOUOB38N2gXdXbwRJ9XnF6IOlFb13pnXKnjxPW9GDZqmD0q4ql
         2ROrU6xZxNXZ/z7G5RfwU2bnHdvCgT3MLE6Lsojrv1bD1PeejSUAe0z4/I3MpgqKRpt0
         3BMDBJ/H8csfv+h/NBlSvpul721nLU94OxMUG0UPk8Qnsk3Codlcs1zdi/5XYgKWEI4/
         vIeg==
X-Forwarded-Encrypted: i=1; AJvYcCVdV5ou1EUDyEAPnGumRTdSbrjOyQK8XWVpDtXUKoV7nNFctNuZRML/jk6d0x3XYNWo7ZjurZwDGfi+r9+FwaKGMlt75qWKLmDs/eP0
X-Gm-Message-State: AOJu0YwTvxnw74TNWCmlFtGRdIECZsMH7Zo74TaQksKAcucImrtgat0a
	bAnk29HJmwEyXWIMHH3xC4tVkHkVJaZB5UlZBsb5ghD3D5kngE7id51xykrFtBQ1NWIKMU4JmWG
	mrEakKczND3x5W6A7tOeK8J3RLKrZsakFFxwUjg==
X-Google-Smtp-Source: AGHT+IHKGzn3Jy+jvSzStiobwmQa7F/8DIMpq3pQzjfiiVl4yPJkJ9M8hV1Z785oJhbfM5/KLC2JWML5w3BPF2F7DOQ=
X-Received: by 2002:a2e:9d02:0:b0:2d2:650f:9587 with SMTP id
 t2-20020a2e9d02000000b002d2650f9587mr8698177lji.13.1709148712666; Wed, 28 Feb
 2024 11:31:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228122617.185814-1-alisa.roman@analog.com> <20240228122617.185814-4-alisa.roman@analog.com>
In-Reply-To: <20240228122617.185814-4-alisa.roman@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 28 Feb 2024 13:31:41 -0600
Message-ID: <CAMknhBGsD+soKKVBwFxa5AzVgxzgKFyoN54kR5eJ9zk039iHag@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de, 
	jic23@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com, nuno.sa@analog.com, 
	alisa.roman@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 6:26=E2=80=AFAM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The default configuration for these channels can be changed
> from the devicetree.
>
> Also add an example for AD7194 devicetree.
>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> Signed-off-by: romandariana <alisa.roman@analog.com>

Why two SOBs with the same email?

> ---
>  .../bindings/iio/adc/adi,ad7192.yaml          | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index 16def2985ab4..c62862760311 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -21,8 +21,15 @@ properties:
>        - adi,ad7190
>        - adi,ad7192
>        - adi,ad7193
> +      - adi,ad7194
>        - adi,ad7195
>
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
>    reg:
>      maxItems: 1
>

Based on the discussion in v3, I was expecting to see an aincom-supply
property added. (Although that probably belongs in a separate patch
since it applies to all existing chips, not just the one being added
here.)


> @@ -96,8 +103,44 @@ required:
>    - spi-cpol
>    - spi-cpha
>
> +patternProperties:
> +  "^channel@([0-9]+)$":
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel index.
> +        minimum: 1
> +        maximum: 16

I guess this is OK, but max of 16 is a bit artificial since there
could be unusual use cases where inputs are reused on multiple
channels. Technically, there are 16 * 17 =3D 272 possible combinations
that could appear.

