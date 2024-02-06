Return-Path: <linux-kernel+bounces-55393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A8984BC29
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E655E1F23C8B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063EBEDF;
	Tue,  6 Feb 2024 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="14eBsMkD"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97587D51C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240869; cv=none; b=RRKP00Rg/nEpj5nqryN1QfqYJatJyMINTFRjB3zgcStKqdfrX0ToCgqRoezqLT7djtS9pymR+vgkv3bzw4EZ3tl6tf0RIY1Tm8RrdNiQkgaj5reT+gImmzKm5CVeFRg6eECChR7a2rWcj3XFt8BBLKOXpLkd2fJ784DzG0h93Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240869; c=relaxed/simple;
	bh=BGYgn4pwip7xm8wZ1TGqp7QgodhzA/a+8J+7CXk661c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DH7udH1nV34uxBrT6HYoJGdrvCvSTetQB3dZ7uRTDiA+AQBzyEP4jE6er+f7nN8SpKHLdRnQksFEz1McmMjayQ6CWI3gNut4qOKpMftuEIKijm+d2qW4M1SCxqhsnjG+1cW5KBjcvUxQl9LFK2p1MGLZurEoQvSCWE4wDMgphCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=14eBsMkD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0a96bad85so40719921fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 09:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707240864; x=1707845664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpmnZurxd3Ncre4ry66TEipTMru+C8BAh2dBgzUnWpc=;
        b=14eBsMkDUc9gezEe/s8BYcTt157KxEyD121V8Bt8QksVs/mHnTugZXycIC7lJ3TPjP
         Bv9YoMeD0n6/Gn9r6f+0ZgHJm42UdNHfIhU7c4iDmFy7a8U6mLPrKauwKPsB/f2bWSHJ
         xlnJk4UFM4Kxs7l0Efh1F8WApCuVMbQvu8Adp2dSxKq62fZbgKkAPqkxgmc1bx9g2AaX
         QdXYcgodDN+vs6EoiTZ7l69svRWOW8JoqfCTDLGXpTwJkaneynIK0z915zPcx1FWOdxT
         75qfpKagLmOzfu6W0+tq+2XvMekdrwtqZFVuFdHLHLis8Nte3KINVcKw95SM2ljL40v5
         zLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240864; x=1707845664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpmnZurxd3Ncre4ry66TEipTMru+C8BAh2dBgzUnWpc=;
        b=aKiY5MDAhJBxlR0hS8YZ3G+dEa81VCs9zBS4Z6O+/I6W98INzS1dhATlXatyLTfsB9
         Q/Uyznby1kLQgG9vLqkiBew7PxEx9gR+eswqsBzDPDu7AEjLM9dVKFTVRf16XnbM8lMX
         tKFYtxGPHMLL7Q7DRbESmFlrG2oidwfcOhYbCLzDFwcctuiW3KhMNQzqT5f7xtiu/8Bp
         +k7rZi+AsUFrGHRkKqoGA1sClM27pXRWr2Zm/uQima5Cc6+sF8npgK8PRSGF3IGfpw5Z
         BJ+kn9EJY2wssVmE1yNSDru4dIx8ucvuT+khcNB2BbQUtTv7cV9flvFj0yhQ2igSocEb
         I77Q==
X-Gm-Message-State: AOJu0YzYL4nqSkYRsS6aQINDtg8sNaPQpZByCl1VoKebYoYEr+oJrmM+
	WE2Yg7Aub11CH/MnawtAB4wep1eQg+lCygc4gTQMJr8ylRGX3HtwVULtoqqHtEsqf3le8Ku/E74
	ddDMB1HVjZsfi6gHvl5GPwgBReCiPW1LoCEhGnkLpD7PGaSwfWEM=
X-Google-Smtp-Source: AGHT+IHeO+vgPTOIdvMuGjPatUo0mlDXrgtJyq8JotpLBwIQn4VQzamYSWR9VNr613H7eBXZT5jM1Kx3+NpKtIU81Us=
X-Received: by 2002:a05:651c:23c:b0:2d0:a464:747 with SMTP id
 z28-20020a05651c023c00b002d0a4640747mr2286725ljn.49.1707240864576; Tue, 06
 Feb 2024 09:34:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com> <20240206-ad7944-mainline-v1-1-bf115fa9474f@baylibre.com>
In-Reply-To: <20240206-ad7944-mainline-v1-1-bf115fa9474f@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 6 Feb 2024 11:34:13 -0600
Message-ID: <CAMknhBGG_RS1t0OJw6_UnNQ_=S4YgN4i1YN26V8n=f9y28J9hQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add ad7944 ADCs
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 11:26=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> This adds a new binding for the Analog Devices, Inc. AD7944, AD7985, and
> AD7986 ADCs.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 231 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   8 +
>  2 files changed, 239 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> new file mode 100644
> index 000000000000..a023adbeba42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml

..


+  adi,reference:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ internal, internal-buffer, external ]
+    default: internal

..

> +allOf:
> +  # ref-supply is only used for external reference voltage
> +  - if:
> +      not:
> +        required:
> +          - adi,reference
> +    then:
> +      properties:
> +        ref-supply: false
> +    else:
> +      if:
> +        properties:
> +          adi,reference:
> +            const: external
> +      then:
> +        required:
> +          - ref-supply
> +      else:
> +        properties:
> +          ref-supply: false

This seems like something that could potentially be improved in the
dtschema tooling. Since adi,reference has a default of "internal", I
would expect:

     if:
       properties:
         adi,reference:
           const: external
     then:
       required:
         - ref-supply
     else:
       properties:
         ref-supply: false

to be sufficient here. However, currently, if the adi,reference
property is omitted from the dts/dtb, the condition here evaluates to
true and unexpectedly (incorrectly?) the validator requires the
ref-supply property.

