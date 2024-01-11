Return-Path: <linux-kernel+bounces-23287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC88982AA7B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732742835CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B21A14F61;
	Thu, 11 Jan 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMzdJDz4"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC414A9C;
	Thu, 11 Jan 2024 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55818b733f7so3075876a12.3;
        Thu, 11 Jan 2024 01:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704963867; x=1705568667; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nKYfbtGZSuWol92QjWEdUhJKfrs3o8tz2BQxPjW/QIM=;
        b=dMzdJDz4WB1CeTHby1ByA00cUGc90h7htVkqNdzl9x7FwsqDbxzVn5y3tNRf/5l4E1
         JKakH6WAi4VNiQObUGEwH++8WVN9IwIx9cgyqqFJaRP6+ZbBB4rUaYMNkGwHstrWfgFR
         9NbmOvsrzJF2lTyExHyy70sxsEq4iwfiIz9yIsm4D6R+97i0detMqV+PZva5bKVqP5Gm
         4mHoF32FiInHksplJoTWtyLI/ZGpG6cwGhiANxSukdyEsJp04z6ogHdn46MCPlykD5QR
         ThBRjflLfnB2qbunON8XAlRra8qwUq5RwtN7kBRXrL65WC7zprcIGMhgQx6yE7EJpRmq
         hQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704963867; x=1705568667;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKYfbtGZSuWol92QjWEdUhJKfrs3o8tz2BQxPjW/QIM=;
        b=qKbF3RJNHvhgnYl7OH75Gie8pP4TFxFrPewBk4ucQKwuErw6CjNVAPUhO+pCiHqxxc
         IbhAdmkceOL/+TZKJBYkT54Cr3JoRnufUA+HXoME9kLZCjW9kgq1uCCwEK/GDGXgPQHy
         mDMytWd1XamKg2K7jnJLuf5FTN7yDbkqFIIhZsAkAKHlSyc6nl0U49vLEZ34eq9lhZWq
         XkJ6slIJFaLBE+k2lLuSrYXRa3iEpgtAyljge4jmw4h6pjgRdvm6/OBFyrs88Sicqrk5
         U2Vqabo9JumEsBNEg+vvYl1uQB6aEjtJid665OzOVklDbaLbw0DFyW2n3ZQuS9ohm/e7
         w6Kw==
X-Gm-Message-State: AOJu0YzH67KYhIV/qyJLfiBxNr45FaIh5tS+OzpWv2HS0CjhUsCOgRvq
	aIv4YHR82sbVIwb33ETX2m8=
X-Google-Smtp-Source: AGHT+IGNchkmZ4xR/1cEDGA6uaCwadY4fTil39N89Fv7dqdCC2nauGrYBDo4A90POu6tgiDlQ9c9uA==
X-Received: by 2002:a17:906:4557:b0:a28:a409:aeeb with SMTP id s23-20020a170906455700b00a28a409aeebmr424289ejq.61.1704963867146;
        Thu, 11 Jan 2024 01:04:27 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709063bc700b00a29bd8f9edbsm326112ejf.72.2024.01.11.01.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:04:26 -0800 (PST)
Message-ID: <501bb280c6bd7dcb49929e7dbd242807b828e7de.camel@gmail.com>
Subject: Re: [PATCH 04/13] spi: dt-bindings: adi,axi-spi-engine: add offload
 bindings
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rob Herring <robh@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  Frank Rowand
 <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>,  linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 11 Jan 2024 10:07:38 +0100
In-Reply-To: <20240110231456.GB2854345-robh@kernel.org>
References: 
	<20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	 <20240109-axi-spi-engine-series-3-v1-4-e42c6a986580@baylibre.com>
	 <20240110231456.GB2854345-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-10 at 17:14 -0600, Rob Herring wrote:
> On Wed, Jan 10, 2024 at 01:49:45PM -0600, David Lechner wrote:
> > The ADI AXI SPI Engine driver supports offloading SPI transfers to
> > hardware. This is essentially a feature that allows recording an
> > arbitrary sequence of SPI transfers and then playing them back with
> > no CPU intervention via a hardware trigger.
> >=20
> > This adds the bindings for this feature. Each SPI Engine instance
> > can have from 0 to 32 offload instances. Each offload instance has a
> > trigger input and a data stream output. As an example, this could be
> > used with an ADC SPI peripheral. In this case the trigger is connected
> > to a PWM/clock to determine the sampling rate for the ADC and the outpu=
t
> > stream is connected to a DMA channel to pipe the sample data to memory.
> >=20
> > SPI peripherals act as consumers of the offload instances. Typically,
> > one SPI peripheral will be connected to one offload instance. But to
> > make the bindings future-proof, the property is an array.
>=20
> Is there some sort of arbitration between multiple offload engines on=20
> the same chip select? If not, I don't see how it would work.
>=20
> I think this whole thing could be simplified down to just 3=20
> SPI controller properties: pwms, dmas, and adi,offload-cs-map. Each=20
> property is has entries equal the number of offload engines. The last=20
> one maps an offload engine to a SPI chip-select.
>=20

I think the whole reason why the offload is being treated as a node + platf=
orm
device is to have these properties (or other possible properties depending =
on
the trigger and data capture being used) in it and so respect the HW
configuration.

While that is conceptually correct I feel that this is bringing a lot of ex=
tra
complexity. The end consumer of the offload core (which is a property/featu=
re of
the spi cotroller) are obviously the peripheral devices that in our usecase=
s are
converters and hence IIO devices. So those are the ones consuming all the d=
ata.
I saw Mark already giving some pointers and speaking about having a way to
support the triggers (being it pwm, clock, gpio, etc...) directly in the sp=
i
framework and I think that would be nice. For the dmas, I think it would be=
 more
complicated. While we can setup the dma transfer directly in the spi contro=
ller,
we would need a mechanism to transfer each block of data (periodically) as =
soon
as we have it to the peripheral device. In case of IIO, that would then hav=
e to
connect to IIO DMA buffers so the data can be consumed in userspace and tha=
t
would be the tricky part I believe.

What we have been doing out of tree is to control the trigger and dmas in t=
he
peripheral device even if that does not really directly respect the HW setu=
p (as
these are properties of the offload core). Hence, we can just allocate an I=
IO
DMA buffer, enable the offload message with the messages we want and data c=
an be
directly transferred to userspace (without any intervention of the peripher=
al
driver) using the IIO interfaces for it.

To sum it up, I think having the trigger being handled by the spi framework=
 or
even have it as an IIO generic trigger would be simple. To have the dma
transfers in the spi controller would be more complex but anything is possi=
ble,
I guess :).

- Nuno S=C3=A1
>=20
>=20

