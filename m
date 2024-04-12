Return-Path: <linux-kernel+bounces-141923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5908A2525
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B941F220D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D981F60B;
	Fri, 12 Apr 2024 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bdbq2dtJ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162F11946B;
	Fri, 12 Apr 2024 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895956; cv=none; b=FIhuQ10aot+X96rUWm9sI9ApC1ZVDkcE8vJECN6dO0ErbySXL9I3f6IcyWLVmq8eHxvy7dBH6cP1JkCqOHm1zEzVbPQRA7Prs7UHyPsnN/O9bVYXLCbX0BvNe6Jv8fwiuoVrVo8eohrFnCfzImhiWRXixZ4ugZ9sX8oM1i7qOGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895956; c=relaxed/simple;
	bh=UXbo+VS3HHVZECLQFPPlo7cRc4uXeWiQu+h4jwMQiA0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=s+9CaASWwpXkK0OEjBfXd5slXnvU3jI0fYa8b4nmuNUKNYRHCG8VStzzaRPQ/W3YBgQce9xeoDLlgeq4P4X4MrhsKPnFLj3Z6PRUANENtxWt877bPCB1hPLAFT80C3hoJXPD83MoqXCRhhLCvfNGtsKFR11Ahb6YAB8fEp9b8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=bdbq2dtJ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712895951;
	bh=WBC4cv0DYkfR7yWyrEkjR6eFWgM6jUZNJEeYO0+dobg=;
	h=Date:From:To:Cc:Subject:From;
	b=bdbq2dtJaXPAZgNeoQEJQ/3y2Mezvmy3uc89NQkijUyu/hGCXxXfITIbBolT5XOri
	 56WvWa2oNOBqzYjiai1suoibxQ9ksotlJc495RUzCTazPqLDDj82YLprYkvOdVQXvP
	 4o2zIaQSU22u4IcmINr6/ysELQlBa8TzyGRQ2umGl6AQjaPiDS4ZjSIStykJeWSFRz
	 /OhQVRhgCg4TmsnGCI79R8a/LeKZ+1w4gTztsgKOZH9WrYWzVPaIRPH+7tPLkgYcKk
	 SueosgVUPKYm2SiETWRzeOvaVNzFUPeWQbXKx6JOO2YqhyvHM4pK/CyNtYfp7GY07z
	 +X4wXw36NoiLw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VG3Qk3wvRz4wnv;
	Fri, 12 Apr 2024 14:25:50 +1000 (AEST)
Date: Fri, 12 Apr 2024 14:25:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Fabio Estevam <festevam@denx.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Javier Carrasco
 <javier.carrasco@wolfvision.net>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the usb tree with the usb.current tree
Message-ID: <20240412142547.3598ff68@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fHlOQajDx9FUIMSQd+7qE/k";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/fHlOQajDx9FUIMSQd+7qE/k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  drivers/usb/misc/onboard_usb_hub.c

between commit:

  34b990e9bb54 ("usb: misc: onboard_usb_hub: Disable the USB hub clock on f=
ailure")

from the usb.current tree and commit:

  31e7f6c015d9 ("usb: misc: onboard_hub: rename to onboard_dev")

from the usb tree.

I fixed it up (I deleted this file and applied the following patch) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

rom: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 12 Apr 2024 14:20:48 +1000
Subject: [PATCH] fix up for "usb: misc: onboard_hub: rename to onboard_dev"

interacting with "usb: misc: onboard_usb_hub: Disable the USB hub clock
on failure"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/usb/misc/onboard_usb_dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_=
usb_dev.c
index 648ea933bdad..f2bcc1a8b95f 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -93,7 +93,7 @@ static int onboard_dev_power_on(struct onboard_dev *onboa=
rd_dev)
 	if (err) {
 		dev_err(onboard_dev->dev, "failed to enable supplies: %pe\n",
 			ERR_PTR(err));
-		return err;
+		goto disable_clk;
 	}
=20
 	fsleep(onboard_dev->pdata->reset_us);
@@ -102,6 +102,10 @@ static int onboard_dev_power_on(struct onboard_dev *on=
board_dev)
 	onboard_dev->is_powered_on =3D true;
=20
 	return 0;
+
+disable_clk:
+	clk_disable_unprepare(onboard_dev->clk);
+	return err;
 }
=20
 static int onboard_dev_power_off(struct onboard_dev *onboard_dev)
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/fHlOQajDx9FUIMSQd+7qE/k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYYt8sACgkQAVBC80lX
0Gxc3Qf/ejYJlt3su6EtCwBPDbHTHYOh+dr89CSi0na5fsVSXuRdGOyUPUE7DazH
iYG2YPKcaDE4VFJCa1JNMxtIw38Kw1/hnMfkTB/Nl6I09zvej/1y/isBxBUHN5sP
aI8zdrN5PgMf5FLA8hKS1vHPVnkQfvUNoqXL3PPUBWOYhT5b1VEwHBXqjAY4tJ31
HYwdHnpYcUU4+HBP7zVVRGRhzakGvdFfmnuRwcTuNIHFmMMRRuT/V+1t2Y7iWxLh
UmqpGRCISQXbIPmGYhb56clQ2EixjZH2CqMQImCVX1JZi4PjVgFQ8Y8Utu67H8UO
bPnnjhfQEFx/qD7HIKnBUAOEDSPsfA==
=6Yqr
-----END PGP SIGNATURE-----

--Sig_/fHlOQajDx9FUIMSQd+7qE/k--

