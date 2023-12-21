Return-Path: <linux-kernel+bounces-7875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FEB81AE92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12A9285387
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3234DD2FF;
	Thu, 21 Dec 2023 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Vs3XnrV2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B19C2E6;
	Thu, 21 Dec 2023 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703138287;
	bh=W9WVhROU+IkzZLwkcXujAUaruo43ab/6jRxwxCmucCQ=;
	h=Date:From:To:Cc:Subject:From;
	b=Vs3XnrV2DBaQye1qqFRU4nZywhbLwz/LF0l9b3l4mN+9cwK5d8CqBypB26Ab0T3xy
	 6cTaRexp+nnVR/VUQw93kuDu0VrVy1RGqAwwy9Ee58MWHhqMZ1s6rRzrTN5bQgzA+Q
	 S1WsHC7SK6Gjz7oibeZpp3CiIq7cs1R7Gys5TJnNHwoCpw/echOXiZ9sBflu8fRr/f
	 QhZdjZPoKz3Duntd1azZtX8+1Qdwr4dRLfCw71vrPOXy9PMBcJF8sddOXcZSQ+Actf
	 QHA/TrNyNlW1P4SChFzu0oH+M5Zvy03CuAeaQc+nC1OU/Xh1MSN7cOQAcDL+zbqiBQ
	 J5/qJm+f32IAQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SwfqL44kgz4wbr;
	Thu, 21 Dec 2023 16:58:06 +1100 (AEDT)
Date: Thu, 21 Dec 2023 16:58:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Sean Young <sean@mess.org>, Flavio Suligoi <f.suligoi@asem.it>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pwm tree
Message-ID: <20231221165805.0c4771c1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/V1ol2N+FvGoGBHhVCu54mCy";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/V1ol2N+FvGoGBHhVCu54mCy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the backlight tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/video/backlight/mp3309c.c: In function 'mp3309c_bl_update_status':
drivers/video/backlight/mp3309c.c:134:23: error: implicit declaration of fu=
nction 'pwm_apply_state'; did you mean 'pwm_apply_args'? [-Werror=3Dimplici=
t-function-declaration]
  134 |                 ret =3D pwm_apply_state(chip->pwmd, &pwmstate);
      |                       ^~~~~~~~~~~~~~~
      |                       pwm_apply_args

Caused by commit

  c748a6d77c06 ("pwm: Rename pwm_apply_state() to pwm_apply_might_sleep()")

interacting with commit

  2e914516a58c ("backlight: mp3309c: Add support for MPS MP3309C")

from the backlight tree.

I have appplied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 21 Dec 2023 16:13:37 +1100
Subject: [PATCH] fix up for "backlight: mp3309c: Add support for MPS MP3309=
C"

from the backlight tree interacting with commit

  c748a6d77c06 ("pwm: Rename pwm_apply_state() to pwm_apply_might_sleep()")

from the pwm tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/video/backlight/mp3309c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp=
3309c.c
index 34d71259fac1..b0d9aef6942b 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -131,7 +131,7 @@ static int mp3309c_bl_update_status(struct backlight_de=
vice *bl)
 					    chip->pdata->levels[brightness],
 					    chip->pdata->levels[chip->pdata->max_brightness]);
 		pwmstate.enabled =3D true;
-		ret =3D pwm_apply_state(chip->pwmd, &pwmstate);
+		ret =3D pwm_apply_might_sleep(chip->pwmd, &pwmstate);
 		if (ret)
 			return ret;
=20
@@ -393,7 +393,7 @@ static int mp3309c_probe(struct i2c_client *client)
 					    chip->pdata->default_brightness,
 					    chip->pdata->max_brightness);
 		pwmstate.enabled =3D true;
-		ret =3D pwm_apply_state(chip->pwmd, &pwmstate);
+		ret =3D pwm_apply_might_sleep(chip->pwmd, &pwmstate);
 		if (ret)
 			return dev_err_probe(chip->dev, ret,
 					     "error setting pwm device\n");
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/V1ol2N+FvGoGBHhVCu54mCy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWD0+0ACgkQAVBC80lX
0Gwpcgf/QoObjAEU4FGHKar8ldO1j/e87uJFegGqZXmSYkUNnDT6CkOdSG5Csk0u
q6AIBGqQML5cuG/QFgLaNtg+7ZvbwfG5kzAXUYJG9MTWLp7GHXO/omSsnvNmZBwe
//prFdmkw90HwIigWCS6PpBq9QxbJW6bTzVd/56QLsKxy6a7SaEwL/TLFNMpRWBR
N5kVBXf07veREM39cqmLBL/JtawQTziLhw+gX2Zb3e3yBVGcaz88j2C9od8BuLMI
kqutrcehxIOe0in/GG3/sES+/tAzsECjZkYy5xMB7yJYrQ1ngfnfYVbpA8B/X7qf
QpLp2I4aUSyMVGQfiEtf9sKrX/VKDg==
=Vrbr
-----END PGP SIGNATURE-----

--Sig_/V1ol2N+FvGoGBHhVCu54mCy--

