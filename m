Return-Path: <linux-kernel+bounces-23311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA55682AAE1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9691C2108D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107B811704;
	Thu, 11 Jan 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGZloLFT"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C407411C85;
	Thu, 11 Jan 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd17a979bcso57344311fa.0;
        Thu, 11 Jan 2024 01:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704965284; x=1705570084; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sf6VBUtsDqW13HEBWxXrEjwH5/MBLlUs1U/ZJvZMatA=;
        b=lGZloLFTZDUV36+2mYEzCVaZ4B4yw1DyyxgJ7LEVVsFLUOSaT+dCn9zRqCOycv+oGk
         ZyFouRV/l5dRdTraCEemijlkybhiKjMJJUf0fJ9ylzvwadJhHPDcynDL4F9yyl/qYHLR
         8J54uV3zzrGPHHSwV6Ft8VlqwXvWMIUwaiHR8FlAiPr3czU6X5wtAKXI00RMPajV2Rz/
         8mZA2EDzIwrS9UbQL/W66b9iVZrQe5Bu1p1JaNygOuspu+xHjUhju1narayNa8CJhDHL
         qlhk3kVqxXaEKXS9gN2lxOfadprgvy/cfwAEN3kqg41drb03Zr64xPozNwxC96UJQLsx
         76QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704965284; x=1705570084;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sf6VBUtsDqW13HEBWxXrEjwH5/MBLlUs1U/ZJvZMatA=;
        b=grSiZ7J1eFyFK4CdBWjUoWYUvBevUV469ibvjEK0cq1NdHr02AaIByVO3G/730qUYO
         GUlpQsp2jtGq+L+z1fFXbQCBwcCqIWld7dgHsG9YJ2WWJSIZBUz/52pqHkXCGtb3jIIu
         wv404RWKUkPdMaTjKGHJBwBowg4n330HUCGesd9uHGk0v91nfzojHG0MJLkT0HhCaS7f
         Davcbl2uWV+8o7XaC9k5I5QZSd1AJsO7K0+hGZIeFIV+XOWfnl+jtTH0NtwjRxFX07nG
         ZxLmxwzImUS08cttRhrAKrG8RLuMvdWRMXUGYqtiqlo/I0+xs4bRZZQ5cVPsZFeYetZ9
         6Eeg==
X-Gm-Message-State: AOJu0Yxi9giT48TsMWpGOPpidOW1NQp4R4hLBNpbOhl230Oam91isBZC
	1mAsWWz5sSXyS2/3i2p4WbQ=
X-Google-Smtp-Source: AGHT+IGHqmiX56xgaRdznksFbY34dhZM1Wo+zbmAdkiJ4fw2/vjUMX0b5qweYiWo+2S3241dOg+0cA==
X-Received: by 2002:a2e:9848:0:b0:2cc:3e6d:8dcb with SMTP id e8-20020a2e9848000000b002cc3e6d8dcbmr106629ljj.104.1704965283355;
        Thu, 11 Jan 2024 01:28:03 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4f01000000b003377be178a5sm699950wru.78.2024.01.11.01.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:28:03 -0800 (PST)
Message-ID: <00c5f84a4bc5a4e3423f401af7b4f374c930407d.camel@gmail.com>
Subject: Re: [PATCH 12/13] iio: offload: add new PWM triggered DMA buffer
 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Frank Rowand
 <frowand.list@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>,  linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 11 Jan 2024 10:31:15 +0100
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-12-e42c6a986580@baylibre.com>
References: 
	<20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	 <20240109-axi-spi-engine-series-3-v1-12-e42c6a986580@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-10 at 13:49 -0600, David Lechner wrote:
> This adds a new driver for handling SPI offloading using a PWM as the
> trigger and DMA for the received data. This will be used by ADCs in
> conjunction with SPI controllers with offloading support to be able
> to sample at high rates without CPU intervention.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0drivers/iio/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> =C2=A0drivers/iio/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> =C2=A0.../iio/buffer/industrialio-hw-triggered-buffer.c=C2=A0 |=C2=A0=C2=
=A0 1 +
> =C2=A0drivers/iio/offload/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 21 ++
> =C2=A0drivers/iio/offload/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/iio/offload/iio-pwm-triggered-dma-buffer.c | 212
> +++++++++++++++++++++
> =C2=A06 files changed, 238 insertions(+)
>=20
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 52eb46ef84c1..56738282d82f 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -90,6 +90,7 @@ source "drivers/iio/imu/Kconfig"
> =C2=A0source "drivers/iio/light/Kconfig"
> =C2=A0source "drivers/iio/magnetometer/Kconfig"
> =C2=A0source "drivers/iio/multiplexer/Kconfig"
> +source "drivers/iio/offload/Kconfig"

The offload stuff is something very particular to a spi controller feature.=
 Not
sure if having this as a generic thing makes sense at this point.

IMO, the IIO way of looking at the offload engine is as an HW triggered cor=
e for
capturing data. Hence, I would support the whole thing as an HW triggered
buffer. And, if we are really going the path of having the offload core as =
a
platform device, we could have different compatibles for each pair of trigg=
er +
data_capture (or explicit dt properties).

Just my 2 cents...

- Nuno S=C3=A1


