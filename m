Return-Path: <linux-kernel+bounces-155293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8F88AE857
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FAA5B22367
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B65C136988;
	Tue, 23 Apr 2024 13:38:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF164135A61
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879481; cv=none; b=fLrhqycjjGbLgjhCnHPdwQ3KOgBbTojQVzK4qAIq2Q0qPZe1uxxuOAE8uuncpmAWEPNzAVMdXfWx0xJzg2Z1NX0nQAcInJP4EAh+lB63BFGRb+UvTDC6gmB5ozh2gPnOI/2P5YSGaSq2xGYMXgfpzi4rJXNm9W2/e1fBl0unE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879481; c=relaxed/simple;
	bh=69jnoKvvCDmMn/lAjGuLECv91VIAAt67LYlGv0q5hNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwfcsRdQcTt3EXMrSHo+p6m3VuRWyQtSsXrkCLNs/WDduNVGMrMa0v82WvpA3dguXXFMe4YlP+mCyRc9iP5g8iLl1YaOViPqGLQOZfndxskcIuyANmFB80yeep0iE5oqL6uU9Tc9Wf4V0gjzg8naWbpUaXsI9U8F8y9qMA4V72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1rzGLJ-0000Fg-JC; Tue, 23 Apr 2024 15:37:53 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1rzGLI-00Du9u-IJ; Tue, 23 Apr 2024 15:37:52 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1rzGLI-009tVB-1Z;
	Tue, 23 Apr 2024 15:37:52 +0200
Date: Tue, 23 Apr 2024 15:37:52 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Message-ID: <Zie5sN473m2rgNTK@pengutronix.de>
References: <20240307-dwc3-gadget-complete-irq-v2-1-8c5e9b35f7b9@pengutronix.de>
 <20240402230555.xgt5uilc42diyr4m@synopsys.com>
 <20240402231848.4hzzrxegjrcmdab2@synopsys.com>
 <20240404002906.wk6xbz2wp2tf2xwn@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M6Szu+DUfPV4wPeQ"
Content-Disposition: inline
In-Reply-To: <20240404002906.wk6xbz2wp2tf2xwn@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--M6Szu+DUfPV4wPeQ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thinh,

On Thu, Apr 04, 2024 at 12:29:14AM +0000, Thinh Nguyen wrote:
>On Tue, Apr 02, 2024, Thinh Nguyen wrote:
>> On Tue, Apr 02, 2024, Thinh Nguyen wrote:
>> > My concern here is for the case where transfer_in_flight =3D=3D true a=
nd
>>
>> I mean transfer_in_flight =3D=3D false
>>
>> > list_empty(started_list) =3D=3D false. That means that the requests in=
 the
>> > started_list are completed but are not given back to the gadget driver.
>> >
>> > Since they remained in the started_list, they will be resubmitted again
>> > on the next usb_ep_queue. We may send duplicate transfers right?
>
>Actually, since the requests are completed, the HWO bits are cleared,
>nothing is submitted and no duplicate. But since the requests are not
>given back yet from the started_list, then the next Start_Transfer
>command will begin with the TRB address of the completed request
>(HWO=3D0), the controller may not process the next TRBs. Have you tested
>this scenario?
>
>> >
>> > You can try to cleanup requests in the started_list, but you need to be
>> > careful to make sure you're not out of sync with the transfer completi=
on
>> > events and new requests from gadget driver.
>> >
>
>Was the problem you encounter due to no_interrupt settings where the
>it was set to the last request of the uvc data pump?
>
>if that's the case, can UVC function driver make sure to not set
>no_interrupt to the last request of the data pump from the UVC?

Actually no. What I want to do is to ensure that the dwc3 stream
is stopped when the hardware was drained. Which is a valid point
in my case. Since we are actually potentially enqueueing new request
in the complete handler, be it zero length or real transfers.

Calling kick_transfer on an drained hw will absolutely run into
missed isocs if the irq thread was called late. We saw this on real hardwar=
e,
where another irq_thread was scheduled with the same priority as the
dwc3 irq_thread but was running so long that the HW was running dry in
between the hw irq and the actual dwc3_irq_thread run.

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--M6Szu+DUfPV4wPeQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmYnuawACgkQC+njFXoe
LGT/DxAAwz6KulNc5KIUpueaEMu7WCq3l/4Bf+MoO37W9b1F8VVNE2jwZaLn/8iO
rYUEIyJ6yqeiB4PrT3oBUwmqXQ39xMzzPqeFYwNA9WOa9e2vBVNE9ZesNpZVra/Q
uNEoMVN56nWz2kIRLhl5egV5t96GGQMI4zi6UQx8OHXK6zKbhJcNh5zrDZT6gbRi
X2MDOKF2TS9jrJK8TyU+gtbyjPdcrgmKfhv/XYmk3KaMBnVMx9EFoevQ+n2Vl6Nn
51qkbjEooQ4uma+IitEI6tLjaytCOq57JPkMOUqArzXyhDyAhzmo8Lj0RDAhfFus
TFk1TP6ee30tT4+Wvn6x8zD4FdOwqhYhaDfqRhmwdTGuAZ4bjGbsYhn/IT3PSNGF
VyA1XiBqd+aqqBoxqTqMUChZ/uXjxqnJSjryCdwkNjHbxxkjoA9WWPE3QyBZXewn
oEKaNC7G34SiyqubGuLinDBD9Q6gbtNSxCSxCdAEOWKUfI6NVjwr9Dve7dhpTlAu
EqfJJu+Ittz3kB5qddDV43OVc7tpv2Tl6t04gyIuiNyoWxY0InHVJUhYW8hXFle7
EaRn10m7ApNsKmF3Xmixw1uO6qp/Op4F2lvFIgNgkOowrm+zLWUULeR8RFx/HvWR
b5cfRa47S0aUYmloKE93BoH7hN5S/JQ8fNzT+C3ljMr/eL3cEt0=
=kvaR
-----END PGP SIGNATURE-----

--M6Szu+DUfPV4wPeQ--

