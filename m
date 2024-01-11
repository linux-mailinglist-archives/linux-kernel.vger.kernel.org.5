Return-Path: <linux-kernel+bounces-23240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9E682A955
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02724287D42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2DDFC0C;
	Thu, 11 Jan 2024 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQpE2h0o"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF211C8C;
	Thu, 11 Jan 2024 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e61ff3e37so422645e9.1;
        Thu, 11 Jan 2024 00:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704962757; x=1705567557; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XnXGwZ90m0aaWtoshE1c+60rdXXd9xE4R+DPUoXirhg=;
        b=bQpE2h0oOho6RSJJGBJPdo04CCZe45nqNgK8oN+UczucLqK8AJ07HFKt2+IKipXx8R
         vDX0rzjXzRQXq2bHwacUt2Y7aYCbdKeB5cgTTpYF0K8GwgByAwoCVpYwfDVtxeK0Wbsv
         rvM92oUnh+A8g6QBUHW8HCgHO0sYGWBBO774qlkBZWY0qdhSspZC5AwndM0cSOymRYff
         vPUh1sR8iDaeAksE5gpQYbN/3SMpUo5NG/Fs2OjHFRW73F84/9Vgw0Z9+U5WNl8+LDla
         9wB28AFQ/IJRqgUtND2xihtP4Ozjkbt1Exp3fdsdOznpndmRYCLkgsZCV+aVHf/TLVPn
         dmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704962757; x=1705567557;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnXGwZ90m0aaWtoshE1c+60rdXXd9xE4R+DPUoXirhg=;
        b=h3qTHl2UCyp3U9edeRUPcdSKPB4jFAytMO8F1RDKU3ySqJh5bPR5hnQsjyZo1c9I4D
         UGplPy76d5+58iCP8L691AC1INO/CwX7zP5wE7GEKhOdm+SQqkzdyVRg1W5QZdRCl6tE
         JDxxKKu5EeGa4IAkCz+SlNFhT5koRVD7nOBSDCb9raGkKiX7GSw68C//u6P2ZH3LKMvb
         9Qxqxo80euySgGEGobjneTFOH0OZise/CnPjca3VOaSLYCUTbaHTaVQDw9GStwO9f9cc
         FJgn4n1qzibANb/CivgOXwW2RF1kbXVFaufzQKiao50re5Rd/OBgs9fbK68WHupoP7fu
         NGJA==
X-Gm-Message-State: AOJu0YxJxl3OYedl2qC/AGkyrUgmRCkk7ZbKN2+5rzsaPBh2IdYe0M7A
	Py/jChAT+FjpmEpMSNSFhjY=
X-Google-Smtp-Source: AGHT+IHWay0LKAaf6f5AsLsJfQGOlRBcT0TnnnSJL09Q2WvM12Zsgwn+NZHu8+7z/vzkPhYyU0+OlQ==
X-Received: by 2002:a7b:c414:0:b0:40e:5be9:2ac3 with SMTP id k20-20020a7bc414000000b0040e5be92ac3mr207183wmi.137.1704962756651;
        Thu, 11 Jan 2024 00:45:56 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b0040d6b91efd9sm4930135wmq.44.2024.01.11.00.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 00:45:56 -0800 (PST)
Message-ID: <0c0b1954825dc174cab48060e96ddadadc18aefd.camel@gmail.com>
Subject: Re: [PATCH 01/13] spi: add core support for controllers with
 offload capabilities
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
Date: Thu, 11 Jan 2024 09:49:08 +0100
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
References: 
	<20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	 <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi David,


On Wed, 2024-01-10 at 13:49 -0600, David Lechner wrote:
> This adds a feature for specialized SPI controllers that can record
> a series of SPI transfers, including tx data, cs assertions, delays,
> etc. and then play them back using a hardware trigger without CPU
> intervention.
>=20
> The intended use case for this is with the AXI SPI Engine to capture
> data from ADCs at high rates (MSPS) with a stable sample period.
>=20
> Most of the implementation is controller-specific and will be handled by
> drivers that implement the offload_ops callbacks. The API follows a
> prepare/enable pattern that should be familiar to users of the clk
> subsystem.
>=20
> Consumers of this API will make calls similar to this:
>=20
> =C2=A0=C2=A0=C2=A0 /* in probe() */
> =C2=A0=C2=A0=C2=A0 offload =3D spi_offload_get(spi, 0);
> =C2=A0=C2=A0=C2=A0 ...
>=20
On top of what Mark already stated, and as we already discussed offline, I
personally don't like this provider - consumer interface for the offload. T=
he
first thing is that this is taking into account the possibility of having
multiple offload cores. While the FGPA core was designed with that in mind,=
 we
don't really have any design using multiple offloads in one spi engine (alw=
ays
one). Hence this is all pretty much untested.

If we want to already have this support, my feeling is that we should have =
a
simple integer dt property for the peripheral devices (similar to cs). When=
 a
device is being created/added, the spi core would parse this property and g=
et
it's offload index. The point is that this would all be transparent for spi
devices drivers that would only have to call the SPI API's and the core wou=
ld
make sure the right index is passed to the controller.

But honestly, IMO, I would just keep things simple for now and assume one c=
ore
per engine.

I would probably also prefer to see all the new interfaces part of the
spi_controller struct directly...

- Nuno S=C3=A1



