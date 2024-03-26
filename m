Return-Path: <linux-kernel+bounces-119116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EF388C45C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3FC300FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC167602D;
	Tue, 26 Mar 2024 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ccbib.org header.i=@ccbib.org header.b="Ji3jGEE9"
Received: from mail.multiname.org (h4.multiname.org [94.130.68.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695C5125C9;
	Tue, 26 Mar 2024 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.130.68.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461847; cv=none; b=bZZ8+dvZwG1oC/RKp+sRTH3Ke0MPubK6zj+LtBDQopm/8cokfW3rq5b3B/xedGRbGR49hEB9UWVxGClWVfI1bHgO/avfH1HbKPz5cIdMXvx1euKt0Yfm5I1Y0qFUNdC1BP/logDLciHZloAQZQXbTFFBByP22OVpv5PWJhQEc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461847; c=relaxed/simple;
	bh=kAw9k+LFDrKZWmnFSG9W+3GRp1EStC0PTWb9L4AGv6U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9pk5BxoVxHQ8W1wcDKG2rTrkp6wX/QZXgpfsEbetxYSxx3YH1kY1EMZPPikBmwglbjltoCiLry/xTra/nC66MWceFhreBykHQJFjTVg7mtTaWKGr6XAp+WAHxCf1YlBKNdBGvW03anobf1vfWdLxcVDKINQBO9WywfQno0sEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ccbib.org; spf=pass smtp.mailfrom=ccbib.org; dkim=pass (4096-bit key) header.d=ccbib.org header.i=@ccbib.org header.b=Ji3jGEE9; arc=none smtp.client-ip=94.130.68.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ccbib.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ccbib.org
Received: from raab.fritz.box (unknown [IPv6:2a02:1748:dd5c:fec0:221:9bff:fe61:eebd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.multiname.org (Postfix) with ESMTPSA id 4V3s3b6rGdzPLs9B;
	Tue, 26 Mar 2024 15:03:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ccbib.org; s=20220806;
	t=1711461836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KIo+nzMht9DjNalrh+8JfHFES0AtewbPHT7HbC94Y8=;
	b=Ji3jGEE9oPN9MjjiQebUJEj8oStxLH7J5fJuAj3vSZmdfAwAj118KbogRpjm9grkWU5Q/4
	z9nWslujQFlfBTkBQlrBQv1cNMOy4gmqkZQQkF4g/CdDoWCvCPiJ4f13uJR0udKzHBMQzr
	lUYcPR1zBwGFzBS075FJzcK7kR4IuL6PV9Jv7fIWB+XnwwOoDqjwMsANeXjhY1pFQ1JjY8
	ZhZ1KswQ0ZSllYhkqJYHru9Zn8yUSccD0AaiTW/9H0uzOHbRIB7MPeF/FaMmngpETAov5P
	IhADNClp+73dIIDevKyqCu3DQWHSsy2qXGW6PvifChhfHFSvzjwapoQlPODLicXuJeJAIe
	erPVwSsJ2Dz/J6+M0mduXo6KojI0EMYSj4PO0VUdMVM60NiaWSjfwoDadF1Eo9AMnfGSZP
	vd7EGqdZ31XA/vRQu4QodLeHoBpF34FEZenFNFm/jet2VAvzJvoQG/WTI8f9Fw21DOeqeE
	EoE6D1X06cjP2j0xAP+u19eYvhuBd4weZ+9+ZqvZkM7g17tKW0Wgt+/iT+/gb0TQ+3daj8
	4QdOxROXRVFHtdoGM0ZSiDKhr9EjS111baSdS4mkXKH3/N9US16foQW7Wl8QF6wBfBnX+1
	5ekjThHdd/ovUY6jb44XtiCsbH/ADOwkfvsvrNauxijGxVN4MJOH8=
Message-ID: <e3765f2d7de8a9d26e97750a6a0d1e26da74ab9b.camel@ccbib.org>
Subject: Re: [PATCH] iio: dht11: set debug log level for parsing error
 messages
From: Harald Geyer <harald@ccbib.org>
To: George Stark <gnstark@salutedevices.com>, lars@metafoo.de,
 jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@salutedevices.com
Date: Tue, 26 Mar 2024 15:03:55 +0100
In-Reply-To: <01ed720d-a990-40dd-8a59-a95ea960ecec@salutedevices.com>
References: <20240325165406.226916-1-gnstark@salutedevices.com>
	 <c2fb93a5b2e6f437e2c92d0d797509c619cb63a8.camel@ccbib.org>
	 <01ed720d-a990-40dd-8a59-a95ea960ecec@salutedevices.com>
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

Am Montag, dem 25.03.2024 um 23:18 +0300 schrieb George Stark:
> On 3/25/24 21:48, Harald Geyer wrote:
> > Am Montag, dem 25.03.2024 um 19:54 +0300 schrieb George Stark:
> > > Protocol parsing errors could happen due to several reasons like
> > > noise
> > > environment, heavy load on system etc. If to poll the sensor
> > > frequently
> > > and/or for a long period kernel log will become polluted with
> > > error
> > > messages if their log level is err (i.e. on by default).
> >=20
> > Yes, these error are often recoverable. (As are many other HW
> > errors,
> > that typically are logged. Eg USB bus resets due to EMI)
> >=20
> > [...]
> >=20
> > The idea is, that these messages help users understand issues with
> > their HW (like too long cables, broken cables etc). But it is true,
> > that they will slowly accumulate in many real world scenarios
> > without
> > anything being truly wrong.
>=20
> I agree with you that it's very convenient to just take a look to
> dmesg
> and see device connection problems at once. But unlike e.g. usb user
> has
> to actually start reading sensor to perform communication and read
> errors will be propagated to the userspace and could be noticed \
> handled.

Not really. The log lines contain additional information useful for
understanding the problem with the setup.

> Anyway I believe we should use uniform approach for read errors -
> currently in the driver there're already dbg messages:
>=20
> "lost synchronisation at edge %d\n"
> "invalid checksum\n"

These errors are usually caused by EMI and there isn't much to do aside
from trying again until we find a time window with less interference.
They are not logged, because in some cases they might be very frequent
and can be handled by the user space client programatically anyway.

> I changed log level from err to dbg for the messages:
>=20
> "Only %d signal edges detected\n"

This mostly indicates a problem with the setup. Long cable, dead
sensor, high (interrupt) load etc.

Its true that this can happen during normal operation. - Usually when
the system takes too long to enter the irq handler.

But the primary causes are:
1) Your wiring is broken. In this case, the message is immediately
helpful and points you in the right direction. (Only if you understand
the protocol though.)
2) Your sensor is dead or "crashed", which also warrants an error msg
IMO.

The "crashed" case is a bit special. Some chips seem to randomly stop
working after a couple of hours and the only remedy is to power cycle
them. This could be done automatically. - I have the sensor power
supply pin on a GPIO and reset it from userspace in my setup. I tried
to work on a version of the driver some years ago, that would
optionally register with a regulator and manage sensor resets from
within the kernel driver. If this was actually implemented, we could
reduce the logging to cases, where the reset didn't solve the problem.

I stopped working on this, because it would have required changes to
the regulator framework, to be actually useful, and the regulator
maintainers didn't seem to keen about them. However, if you want to
pick this up in an effort to reduce unnecessary error conditions and
messages, I certainly would be happy.

> "Don't know how to decode data: %d %d %d %d\n"

This would indicate a sensor, that uses the same protocol but an
unsupported data format. This is a permanent error and therefor should
be logged IMO.

I guess, if you have a bad readout due to EMI but the checksum
accidentally matches, then you might get this message too. But this
should be a very rare case.

> They all are from a single callback and say the same thing -
> communication problem.

Not really. See above.

> If we make all those messages as errors it'd be great to have
> mechanism
> to disable them e.g. thru module parameter or somehow without
> rebuilding
> kernel.

No. What you try to change is cosmetic at best. It certainly doesn't
justify adding any complexity.

Since Jonathan deferred to my judgment:

As you can see, I did consider the trade-off between useful diagnostics
and spamming the log carefully. So naturally I'm inclined to reject
your proposal unless it solves an actual problem.

Also people still mail me directly with bogus bug reports about the
driver when really they have some issue with their setup. I fear, if we
reduce diagnostics, it will increase that noise.

So I reject your proposed changes, if they are for the sake of
unification. I'm willing to discuss, what the most sensible trade-off
is, but it would need to actually add to the considerations I already
did.

Best regards,
Harald


>  Those errors can be bypassed by increasing read rate.
>=20
> >=20
> > I don't consider the dmesg buffer being rotated after a month or
> > two a
> > bug. But I suppose this is a corner case. I'll happily accept
> > whatever
> > Jonathan thinks is reasonable.
> >=20
> > Best regards,
> > Harald
> >=20
> >=20
> > > Signed-off-by: George Stark <gnstark@salutedevices.com>
> > > ---
> > > I use DHT22 sensor with Raspberry Pi Zero W as a simple home
> > > meteo
> > > station.
> > > Even if to poll the sensor once per tens of seconds after month
> > > or
> > > two dmesg
> > > may become full of useless parsing error messages. Anyway those
> > > errors are caught
> > > in the user software thru return values.
> > >=20
> > > =C2=A0=C2=A0drivers/iio/humidity/dht11.c | 4 ++--
> > > =C2=A0=C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/humidity/dht11.c
> > > b/drivers/iio/humidity/dht11.c
> > > index c97e25448772..e2cbc442177b 100644
> > > --- a/drivers/iio/humidity/dht11.c
> > > +++ b/drivers/iio/humidity/dht11.c
> > > @@ -156,7 +156,7 @@ static int dht11_decode(struct dht11 *dht11,
> > > int
> > > offset)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dht11->temperature =3D temp_int * 1000;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dht11->humidity =3D hum_int * 1000;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dev_err(dht11->dev,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dev_dbg(dht11->dev,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0"Don't know how to decode data: %d %d %d
> > > %d\n",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0hum_int, hum_dec, temp_int, temp_dec);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EIO;
> > > @@ -239,7 +239,7 @@ static int dht11_read_raw(struct iio_dev
> > > *iio_dev,
> > > =C2=A0=C2=A0#endif
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D 0 && dht11->num_edges <
> > > DHT11_EDGES_PER_READ - 1) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev=
_err(dht11->dev, "Only %d signal edges
> > > detected\n",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev=
_dbg(dht11->dev, "Only %d signal edges
> > > detected\n",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dht11->num_edges);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0ret =3D -ETIMEDOUT;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > --
> > > 2.25.1
> > >=20
> >=20
>=20


