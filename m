Return-Path: <linux-kernel+bounces-126866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92748941C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4801C21977
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D3A4AEE0;
	Mon,  1 Apr 2024 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="PKMxoe+A"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F5481D5;
	Mon,  1 Apr 2024 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989938; cv=none; b=P4jMSUbt07SIvLJK4JLlCScWwwHV88soG7lfDtIRnQEUMezUYuhp8RUPFpBrQBV4K3un+suYexs6Y1ZkqMD8k34Hgbu0Kl3uhLp38ieTi8+Lc3DuCH2bwgk6oIVeNyblb9pCWD69JKJX4Pzwz/XdxdoZ8aPTQRQ3LQMq/M0mO6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989938; c=relaxed/simple;
	bh=dy4TsSyZ9KfrYMBOe0ovVesbC9ccx+VUrTBRTCitf/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTCNFE87t2owY/YbPe9x4ilTUEjFRUlvnB0cUOpmxjCfCJzA9p6fojYtAr8lcdEozCEN1taHwSywW470nSDMUuE6TgFmOTy8VQgAef+Iif9EcsRYpMm3+GDJ5eAke2PhcIWhZWyVeMacWCKJe2w5nTX1zUvoTnDWGPuZ5uH4b4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=PKMxoe+A; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 68F8E62FD5E0;
	Mon,  1 Apr 2024 18:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1711989931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAjz4MKZi39vNHP//SIAL+tM7VX8sjhM3OZ1h2IEnfs=;
	b=PKMxoe+AGftfg/s7R2viEIo7q+PE1+a8swfPhLP+dGqIOSPD/qXgcYviFqpYDlw270HHbI
	gHJ0ZDvhySTNda9J6vkax2mHq9XqAS3Rw0WSbmIKpPVEigIJxkrzdM5p/mThSASqiHCfQR
	MjzykhhWYRFmMsFPRRLlkRaTbNmfW5g=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "hn.chen" <hn.chen@sunplusit.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject:
 Re: [PATCH] media/uvcvideo: add quirk for invalid dev_sof in Logitech C920
Date: Mon, 01 Apr 2024 18:45:16 +0200
Message-ID: <6046664.lOV4Wx5bFT@natalenko.name>
In-Reply-To: <20240325142611.15550-1-oleksandr@natalenko.name>
References: <20240325142611.15550-1-oleksandr@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4923946.31r3eYUQgx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4923946.31r3eYUQgx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Date: Mon, 01 Apr 2024 18:45:16 +0200
Message-ID: <6046664.lOV4Wx5bFT@natalenko.name>
In-Reply-To: <20240325142611.15550-1-oleksandr@natalenko.name>
References: <20240325142611.15550-1-oleksandr@natalenko.name>
MIME-Version: 1.0

On pond=C4=9Bl=C3=AD 25. b=C5=99ezna 2024 15:26:11, CEST Oleksandr Natalenk=
o wrote:
> Similarly to Logitech C922, C920 seems to also suffer from a firmware
> bug that breaks hardware timestamping.
>=20
> Add a quirk for this camera model too.
>=20
> Before applying the quirk:
>=20
> ```
> 100 (4) [-] none 100 200717 B 212.919114 213.079004 33.727 fps ts mono/SoE
> 101 (5) [-] none 101 200889 B 213.003703 213.114996 11.822 fps ts mono/SoE
> 102 (6) [-] none 102 200926 B 213.035571 213.146999 31.379 fps ts mono/SoE
> 103 (7) [-] none 103 200839 B 213.067424 213.179003 31.394 fps ts mono/SoE
> 104 (0) [-] none 104 200692 B 213.293180 213.214991 4.430 fps ts mono/SoE
> 105 (1) [-] none 105 200937 B 213.322374 213.247001 34.254 fps ts mono/SoE
> 106 (2) [-] none 106 201013 B 213.352228 213.279005 33.496 fps ts mono/SoE
> =E2=80=A6
> ```
>=20
> After applying the quirk:
>=20
> ```
> 154 (2) [-] none 154 192417 B 42.199823 42.207788 27.779 fps ts mono/SoE
> 155 (3) [-] none 155 192040 B 42.231834 42.239791 31.239 fps ts mono/SoE
> 156 (4) [-] none 156 192213 B 42.263823 42.271822 31.261 fps ts mono/SoE
> 157 (5) [-] none 157 191981 B 42.299824 42.303827 27.777 fps ts mono/SoE
> 158 (6) [-] none 158 191953 B 42.331835 42.339811 31.239 fps ts mono/SoE
> 159 (7) [-] none 159 191904 B 42.363824 42.371813 31.261 fps ts mono/SoE
> 160 (0) [-] none 160 192210 B 42.399834 42.407801 27.770 fps ts mono/SoE
> ```
>=20
> Link: https://lore.kernel.org/lkml/5764213.DvuYhMxLoT@natalenko.name/
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/u=
vc_driver.c
> index 723e6d5680c2e..444d7089885ea 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2573,7 +2573,8 @@ static const struct usb_device_id uvc_ids[] =3D {
>  	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
>  	  .bInterfaceSubClass	=3D 1,
>  	  .bInterfaceProtocol	=3D 0,
> -	  .driver_info		=3D UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
> +	  .driver_info		=3D UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT
> +					       | UVC_QUIRK_INVALID_DEVICE_SOF) },
>  	/* Logitech HD Pro Webcam C922 */
>  	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
>=20

Gentle ping on this one.

Also, should I have added:

=46ixes: 5d0fd3c806b9 ("[media] uvcvideo: Disable hardware timestamps by de=
fault")

?

(it's not that this change re-enables HW timestamping, but 5d0fd3c806b9 exp=
licitly mentions C920 as affected)

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart4923946.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmYK5JwACgkQil/iNcg8
M0vQbw//a6GrNbz1zBqVfcyTN5UhJIxpyiYBs2K8P5tmSMEJZbobZyX5AWZ6stWf
x5v5UTF6GZL2wWjZsr8m7V3TvzFezDS5lB+yGfE2mcoWV7ULGe+Uel9/TxFeMCZH
5Kmpkdxh8GuWXMUCd7roFSfUSLYJfON1i9HjUOInLNzKaTq5B41Gy1V5UaU1fRVN
W5iY1+SuCJjlQmn56uAlSUm+YcWQywIRM4i14W7dFBJKD07zHCJ23YBcFieiK6ql
H/MrF9koSNi1l3iPKyHyhIlvBxP/xFODFH7avR2aEmkiuVZbGD4AhrnBWnLjo0vJ
17UNno+k+/mkHLMIliZjZMA45m35Z3VKW/DqnMsuiiUV6D6EMPoo9PTPlZOf88hZ
atAHIBeCY33xUZYXRz70FiZ5GlcHRqJVMSOu3UBHFQkKsA0vTTZSGjF6mgZyA98i
obytmxaZezJbZcR53zPOKG9ABQ0dw+Ky+lhz6ARzqX8o2RHLEmRV8eyQ3lTfUSwT
9DLminOHNDw9joqL18x5+a0/MgQi5fYlICxEirFp06o/M7BARjYHwmKHXHiz1Fj+
aiptxwb36qHS3KpYqOv1dQCDxctayv+na0vyJX39fBsi+FrcX8ORgW4V/68ySIy/
mGR+mC9OIGtF33W5Mnb79+OlFnAG9TB9T8Nlce5Z8ikjgyCM4cc=
=w7/U
-----END PGP SIGNATURE-----

--nextPart4923946.31r3eYUQgx--




