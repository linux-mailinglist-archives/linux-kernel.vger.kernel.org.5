Return-Path: <linux-kernel+bounces-112345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21FD8878AA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C9C283443
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA4428E19;
	Sat, 23 Mar 2024 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="pMJjZ7DU"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBCB18EB4;
	Sat, 23 Mar 2024 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196598; cv=none; b=ROqDCBr9D0DTg+XTrrYxXvm9qx4Lk2pqBa13Ctw92KQHi6WAYfAj+g//egkZ7YN7QJu5sSJiZIKMXd9BYPoEkXnLnkZlWfhC21Ej3jiGV5AzhZ+6+jCutKJqNIVLgmnxw3SrwFpuI7tFcetkMjZ0+LMOPO0+9Iuiqu2We+hwqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196598; c=relaxed/simple;
	bh=LGZmnx4kEYMKIxOiADFF+d27qH/RtDksq5NSSrkEVdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbfVLOaAWNa/m2oNmy1MzQfRgyJroPe7vx/zMz/zOzuEGq223gjHYJVJv8aw+zvTFfsE4bjp7RHa6XL1YsGL7h9hpF8qrkmkXFJg+g3qUoWX4StM3bFTGgNPjT921hFeqqJVzl4q9dHxpdPJk92XTgcJAJYYD9jSU6Ow0bXzD8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=pMJjZ7DU; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id DC1AC6165D86;
	Sat, 23 Mar 2024 13:16:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1711196181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laMK9FaOj3uTTgORMDz9RWjBdjgfu6XCe/rl7QS8SZ8=;
	b=pMJjZ7DUMccYviqhAeygl7vw4UDAExQ6cCegNgVmrjPvkcPDKmXoGPv5aOVtjwCDTT0XhJ
	12U29t5UH6D2DV5eT8uOKk11bv/gq+tnOW5pPRq63DtOYZu4X0Upe/fZ6PRGlpgZrOPiqb
	oeprGod9PYc+yZyYRGLPVWALSxgP3S8=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ricardo Ribalda <ribalda@chromium.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 "hn.chen" <hn.chen@sunplusit.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject:
 Re: [PATCH v10 3/6] media: uvcvideo: Quirk for invalid dev_sof in Logitech
 C922
Date: Sat, 23 Mar 2024 13:16:08 +0100
Message-ID: <2722561.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20240323-resend-hwtimestamp-v10-3-b08e590d97c7@chromium.org>
References:
 <20240323-resend-hwtimestamp-v10-0-b08e590d97c7@chromium.org>
 <20240323-resend-hwtimestamp-v10-3-b08e590d97c7@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12402031.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart12402031.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Sat, 23 Mar 2024 13:16:08 +0100
Message-ID: <2722561.mvXUDI8C0e@natalenko.name>
MIME-Version: 1.0

Hello.

On sobota 23. b=C5=99ezna 2024 11:48:04, CET Ricardo Ribalda wrote:
> Logitech C922 internal SOF does not increases at a stable rate of 1kHz.
> This causes that the device_sof and the host_sof run at different rates,
> breaking the clock domain conversion algorithm. Eg:
>=20
> 30 (6) [-] none 30 614400 B 21.245557 21.395214 34.133 fps ts mono/SoE
> 31 (7) [-] none 31 614400 B 21.275327 21.427246 33.591 fps ts mono/SoE
> 32 (0) [-] none 32 614400 B 21.304739 21.459256 34.000 fps ts mono/SoE
> 33 (1) [-] none 33 614400 B 21.334324 21.495274 33.801 fps ts mono/SoE
> * 34 (2) [-] none 34 614400 B 21.529237 21.527297 5.130 fps ts mono/SoE
> * 35 (3) [-] none 35 614400 B 21.649416 21.559306 8.321 fps ts mono/SoE
> 36 (4) [-] none 36 614400 B 21.678789 21.595320 34.045 fps ts mono/SoE
> ...
> 99 (3) [-] none 99 614400 B 23.542226 23.696352 33.541 fps ts mono/SoE
> 100 (4) [-] none 100 614400 B 23.571578 23.728404 34.069 fps ts mono/SoE
> 101 (5) [-] none 101 614400 B 23.601425 23.760420 33.504 fps ts mono/SoE
> * 102 (6) [-] none 102 614400 B 23.798324 23.796428 5.079 fps ts mono/SoE
> * 103 (7) [-] none 103 614400 B 23.916271 23.828450 8.478 fps ts mono/SoE
> 104 (0) [-] none 104 614400 B 23.945720 23.860479 33.957 fps ts mono/SoE

How do I check whether C920 (046d:082d) is affected too? I have got one, I =
can run tests on it as long as those will not blow the webcam up.

Thanks.

> Instead of disabling completely the hardware timestamping for such
> hardware we take the assumption that the packet handling jitter is
> under 2ms and use the host_sof as dev_sof.
>=20
> We can think of the UVC hardware clock as a system with a coarse clock
> (the SOF) and a fine clock (the PTS). The coarse clock can be replaced
> with a clock on the same frequency, if the jitter of such clock is
> smaller than its sampling rate. That way we can save some of the
> precision of the fine clock.
>=20
> To probe this point we have run three experiments on the Logitech C922.
> On that experiment we run the camera at 33fps and we analyse the
> difference in msec between a frame and its predecessor. If we display
> the histogram of that value, a thinner histogram will mean a better
> meassurement. The results for:
> - original hw timestamp: https://ibb.co/D1HJJ4x
> - pure software timestamp: https://ibb.co/QC9MgVK
> - modified hw timestamp: https://ibb.co/8s9dBdk
>=20
> This bug in the camera firmware has been confirmed by the vendor.
>=20
> lsusb -v
>=20
> Bus 001 Device 044: ID 046d:085c Logitech, Inc. C922 Pro Stream Webcam
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x046d Logitech, Inc.
>   idProduct          0x085c C922 Pro Stream Webcam
>   bcdDevice            0.16
>   iManufacturer           0
>   iProduct                2 C922 Pro Stream Webcam
>   iSerial                 1 80B912DF
>   bNumConfigurations      1
>=20
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c |  9 +++++++++
>  drivers/media/usb/uvc/uvc_video.c  | 11 +++++++++++
>  drivers/media/usb/uvc/uvcvideo.h   |  1 +
>  3 files changed, 21 insertions(+)
>=20
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/u=
vc_driver.c
> index bbd90123a4e76..723e6d5680c2e 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2574,6 +2574,15 @@ static const struct usb_device_id uvc_ids[] =3D {
>  	  .bInterfaceSubClass	=3D 1,
>  	  .bInterfaceProtocol	=3D 0,
>  	  .driver_info		=3D UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
> +	/* Logitech HD Pro Webcam C922 */
> +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		=3D 0x046d,
> +	  .idProduct		=3D 0x085c,
> +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	=3D 1,
> +	  .bInterfaceProtocol	=3D 0,
> +	  .driver_info		=3D UVC_INFO_QUIRK(UVC_QUIRK_INVALID_DEVICE_SOF) },
>  	/* Chicony CNF7129 (Asus EEE 100HE) */
>  	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uv=
c_video.c
> index b2e70fcf4eb4c..d6ca383f643e3 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -558,6 +558,17 @@ uvc_video_clock_decode(struct uvc_streaming *stream,=
 struct uvc_buffer *buf,
>  	stream->clock.last_sof =3D dev_sof;
> =20
>  	host_sof =3D usb_get_current_frame_number(stream->dev->udev);
> +
> +	/*
> +	 * On some devices, like the Logitech C922, the device SOF does not run
> +	 * at a stable rate of 1kHz. For those devices use the host SOF instead.
> +	 * In the tests performed so far, this improves the timestamp precision.
> +	 * This is probably explained by a small packet handling jitter from the
> +	 * host, but the exact reason hasn't been fully determined.
> +	 */
> +	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
> +		dev_sof =3D host_sof;
> +
>  	time =3D uvc_video_get_time();
> =20
>  	/*
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvc=
video.h
> index 6fb0a78b1b009..cb9dd50bba8ac 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -73,6 +73,7 @@
>  #define UVC_QUIRK_FORCE_Y8		0x00000800
>  #define UVC_QUIRK_FORCE_BPP		0x00001000
>  #define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00002000
> +#define UVC_QUIRK_INVALID_DEVICE_SOF	0x00004000
> =20
>  /* Format flags */
>  #define UVC_FMT_FLAG_COMPRESSED		0x00000001
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart12402031.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmX+yAgACgkQil/iNcg8
M0s+MRAAg2lbDDFv5wAwubZkpD73CX/5IFItET9QIux0st3lZoNBLjvE+UDw97fb
GbRdXzXbtrt9hhsL9KA7mA5rx6ZTm4kudvNCCs+oyDbD03va0/Tw+LM4GpoxbKHB
vOccP0nB+XJtyRXx3KcZKLQBP2HLRuK8bzIMRoP4GPzBG7IYOjZ1W4DKxxv8UWZp
iUn2WwA57hWxFXBtjzaQSn9+emXaR2HetoonzTWaohs70kj6X6RpGmgWTq+/D+P6
eftOEepDl2y/0vWdmsOSEJhcvIL/Zj2ddqPzwoWGS978Us39SNWxH/LdVMcmvQlm
EaRziKkjLk4kV80FhGWFrRklpsHmNIt6jg7el8z2CTHXtkXil1UJhYbX2lSRMgYh
AJV7a4FdurmBleoSZCJorIokGAqrmqRlxHZP9pxS0QDlxZdTC7Ju+rgpQ55sBxkD
NEfmVJtO+z56StHGrBG6LXCNJgHGb+QH9y43BJICx8P//RFG0gaNSx3gLauD5S6z
oTslJgNUdhmkJhjtJv/o53nATK0u6COsITjULNc2B6jlO0iEmdRoH/k5Vt/ZgIj2
Uskrfr2quRMJi3GLdoTP1Wlj0oL953b9ZfRssFM8PjJ6VXX/HXU0qcP8YLXQT/Cy
KH237EaR8UZ/cDD0bwPPw3zfnhzp0/c7poNKhntXECdDDPZr1Ms=
=xLSN
-----END PGP SIGNATURE-----

--nextPart12402031.O9o76ZdvQC--




