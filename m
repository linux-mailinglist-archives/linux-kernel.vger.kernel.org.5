Return-Path: <linux-kernel+bounces-117754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B50B88AF1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0640E2E422B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67124A0A;
	Mon, 25 Mar 2024 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ccbib.org header.i=@ccbib.org header.b="M0p8rRvh"
Received: from mail.multiname.org (h4.multiname.org [94.130.68.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC4D63C7;
	Mon, 25 Mar 2024 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.130.68.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393033; cv=none; b=BJp3FSuAggNSW8lu+cVGENcPZd4wWt9NeRxA/97JkbFj7HnqDxsL68ldqG4M0kRGp3xSlkNOJmtkbZ5LST12JIjnqgxv4uey1VmIdGg4JEvWe41WhzVN0Voi+MGuXNzGPVWZcRSbDFTfAiwdxzt6RX2xbYgrz1gbixsQ0cvr3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393033; c=relaxed/simple;
	bh=iKrKQs6gu/1W/XFPp5YwYP46/FGNk4CUHMBRezq0H+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WLug3uxMuFI4zH7ouV7bYlBvtiw9wR7PqUSoclZYQKDqp3Ff/hspZVU8QaukzDQBLAVNrHAUSdymPuTuVhB4vxRoRhtzt8i9aCI0IY7FWijv5Sd1jzaFfX8IebR5uUpV4pIIdKbdzONjwi4QBTyUPCQ+AM88AvDPbSYo3XMFVm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ccbib.org; spf=pass smtp.mailfrom=ccbib.org; dkim=pass (4096-bit key) header.d=ccbib.org header.i=@ccbib.org header.b=M0p8rRvh; arc=none smtp.client-ip=94.130.68.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ccbib.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ccbib.org
Received: from raab.fritz.box (unknown [IPv6:2a02:1748:dd5c:fec0:221:9bff:fe61:eebd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.multiname.org (Postfix) with ESMTPSA id 4V3MPs0dmlzPLsB2;
	Mon, 25 Mar 2024 19:48:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ccbib.org; s=20220806;
	t=1711392481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyyAZJSSGrCTUFGc9OJFG4mJqS6OcJzmjq75LpNVV7Q=;
	b=M0p8rRvh6Z0cducA4rEuwCBqh/QKRN1jAjjXmeYDOoa7jsrf7+lSqLhDl8aSFJrELbv1++
	YdUiLbEfHOePypk9OyqZgnfrYrKd7D/LJ7wB68s4EhysCV0kwHAGWhEsvSKtd0wcy6UTyS
	FDgESpH8ov5k0cznyHZdMDuV+Zcbuq5UzKD2E23OhKzk4O7+5tZeBKAlvGaFCLiy3vITWg
	Xnfcko66v+MdJoSwAWkHCPYQ8Hpn3YPN0+cUY8SeA0WlX5k8o61d8et2b2G9HBaf9Vc3+5
	zuWQsc3eCCCfvpTUeap1XhdbPTulMlLxq3/UL0+noXGvYJyPCp/OVhmzhGv1/dNBjzOvpA
	EsNG/z8Nlou6ZuuV1DyC0GtsqmcSWrimnwuRK7w7rqFrLYHK8pYxoOX7REJ4YMw1Cq3Kdj
	Ej5ygeCtRK1Heurn7HrGjs7ZGms3N/47QQ0kWFt4V2SbsxV88B4fc/s4Je0nkwWbYxNMOp
	krcsMA24kMS3p0KvPdUyW0UQHZujheRFC6j8PE+drvbxY6KtRrnjU4T/6I2KACZ3BqnHRk
	0VxDEtM6nKRGOqbSW2B1tK/79nW6o3Nyv/dS8Q5KBe9tpGn5o6jscZZm2LoC2hwvkzrVbA
	PHTohzP+iX/SjVwvCK7hMfgnT/iozjiM059A0C+qcCmkivt9cNDQU=
Message-ID: <c2fb93a5b2e6f437e2c92d0d797509c619cb63a8.camel@ccbib.org>
Subject: Re: [PATCH] iio: dht11: set debug log level for parsing error
 messages
From: Harald Geyer <harald@ccbib.org>
To: George Stark <gnstark@salutedevices.com>, jic23@kernel.org,
 lars@metafoo.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@salutedevices.com
Date: Mon, 25 Mar 2024 19:48:00 +0100
In-Reply-To: <20240325165406.226916-1-gnstark@salutedevices.com>
References: <20240325165406.226916-1-gnstark@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi George!

I'm torn on this:

Am Montag, dem 25.03.2024 um 19:54 +0300 schrieb George Stark:
> Protocol parsing errors could happen due to several reasons like
> noise
> environment, heavy load on system etc. If to poll the sensor
> frequently
> and/or for a long period kernel log will become polluted with error
> messages if their log level is err (i.e. on by default).

Yes, these error are often recoverable. (As are many other HW errors,
that typically are logged. Eg USB bus resets due to EMI)

However they are still genuine errors of the HW.

>  Also some types
> of those messages already have dbg level so use unified log level for
> all such cases.

My take so far has been: Debug level messages are for debugging the
code (ie adding/testing support of new device variants etc). Users
aren't expected to know about or enable debug output. OTOH anything
actually going wrong is an error and should be logged as such.

The idea is, that these messages help users understand issues with
their HW (like too long cables, broken cables etc). But it is true,
that they will slowly accumulate in many real world scenarios without
anything being truly wrong.

I don't consider the dmesg buffer being rotated after a month or two a
bug. But I suppose this is a corner case. I'll happily accept whatever
Jonathan thinks is reasonable.

Best regards,
Harald


> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
> I use DHT22 sensor with Raspberry Pi Zero W as a simple home meteo
> station.
> Even if to poll the sensor once per tens of seconds after month or
> two dmesg
> may become full of useless parsing error messages. Anyway those
> errors are caught
> in the user software thru return values.
>=20
> =C2=A0drivers/iio/humidity/dht11.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/humidity/dht11.c
> b/drivers/iio/humidity/dht11.c
> index c97e25448772..e2cbc442177b 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -156,7 +156,7 @@ static int dht11_decode(struct dht11 *dht11, int
> offset)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dht11->temperature =3D temp_int * 1000;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dht11->humidity =3D hum_int * 1000;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0dev_err(dht11->dev,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0dev_dbg(dht11->dev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"Do=
n't know how to decode data: %d %d %d
> %d\n",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hum=
_int, hum_dec, temp_int, temp_dec);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EIO;
> @@ -239,7 +239,7 @@ static int dht11_read_raw(struct iio_dev
> *iio_dev,
> =C2=A0#endif
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D 0 && dht11->num_edges <
> DHT11_EDGES_PER_READ - 1) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(d=
ht11->dev, "Only %d signal edges
> detected\n",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_dbg(d=
ht11->dev, "Only %d signal edges
> detected\n",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dht11->num_edges);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
 =3D -ETIMEDOUT;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0}
> --
> 2.25.1
>=20


