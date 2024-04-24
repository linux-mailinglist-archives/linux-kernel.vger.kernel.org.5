Return-Path: <linux-kernel+bounces-156346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A84A8B0196
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D9A1F22F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FCE156C64;
	Wed, 24 Apr 2024 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M5Hq08+z"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC915687B;
	Wed, 24 Apr 2024 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713939131; cv=none; b=KXpeyeN2ryMYjvGA6N2RpLlFI7NmMUJSk/YAeZzI/ymzCNnqo3h5lsI1pn0AGGZXlC2S7U4eLBwddJtpSEkAFyo+EnWa51dMtCMhXnbG1/vmEQBkoTjaT0tLvQZjpU4El0jUTokCDKnUDC2RC3t4uaWuv07MaxB/AY/nQO2T+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713939131; c=relaxed/simple;
	bh=e+pY0b+TxkCDq9VqprImL8hLbk8nSPOMUDZewdOsEq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsrEQn+36Hy0dgLu6QuSGFp51+0947H4zpOYL8N0lVaSIlcDoXV05wX2sm6MyNqFpO1lpK+unbGDDbnmM2R4KCLHN3Br2qYhRcYLJND0vqNL9oHVMe9hckxztHT0k+/5/Wc1BsEdVJXrG37kIKwzDHtoWybPPLfE7tHqhqwH1Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=M5Hq08+z; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713939125;
	bh=oLOZg5DNKCFBb0IMA7uYnIkTcwkEnAqu0gabN8OsK1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M5Hq08+zXyF7JyhLSwQf1Jpxg+B0er2A5HrCANgkDeKjFDlfB2Kj3ufSkaM1w0zYt
	 qPCoAKbuiBOxAq8xBXPoQkFSlKK49gF5tkesfKOSfY8bj2H5JvdBFymCbEexBxov4o
	 crwzIFFOaTfisAIwPc92hIhVKV7wXXt6EwUidxxDLKJp5l+eHO+aRq3N9u03eHWAhz
	 26Rw4HlKBlMRoS4AnHxbxGUR6m3yrXKaWbw/kd5m94c8n+XjfvUNS7Jyx66aFLGcWU
	 l9UnL/1han1+S2vTdloOpEELf87nEhjk9gxnuaKvGLdGYCo/kMS10/2lPAbvqah2JS
	 c3yMvbrvoQ1UA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VPTCm2BJ3z4wyj;
	Wed, 24 Apr 2024 16:12:03 +1000 (AEST)
Date: Wed, 24 Apr 2024 16:12:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Fabio Estevam <festevam@denx.de>, Javier Carrasco
 <javier.carrasco@wolfvision.net>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <20240424161202.7e45e19e@canb.auug.org.au>
In-Reply-To: <2024041230-slaw-subsiding-9e85@gregkh>
References: <20240412142547.3598ff68@canb.auug.org.au>
	<2024041230-slaw-subsiding-9e85@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0xI_=SLPommwheHLLKfHSDi";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/0xI_=SLPommwheHLLKfHSDi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Fri, 12 Apr 2024 09:58:52 +0200 Greg KH <greg@kroah.com> wrote:
>
> On Fri, Apr 12, 2024 at 02:25:47PM +1000, Stephen Rothwell wrote:
> >=20
> > Today's linux-next merge of the usb tree got a conflict in:
> >=20
> >   drivers/usb/misc/onboard_usb_hub.c
> >=20
> > between commit:
> >=20
> >   34b990e9bb54 ("usb: misc: onboard_usb_hub: Disable the USB hub clock =
on failure")
> >=20
> > from the usb.current tree and commit:
> >=20
> >   31e7f6c015d9 ("usb: misc: onboard_hub: rename to onboard_dev")
> >=20
> > from the usb tree.
> >=20
> > I fixed it up (I deleted this file and applied the following patch) and
> > can carry the fix as necessary. This is now fixed as far as linux-next
> > is concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflicting
> > tree to minimise any particularly complex conflicts. =20
>=20
> Thanks, I knew this would happen, I'll apply your fixup when merging the
> two branches together.

It looks like the fix up patch did not get applied (repeated below).

--=20
Cheers,
Stephen Rothwell

From: Stephen Rothwell <sfr@canb.auug.org.au>
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


--Sig_/0xI_=SLPommwheHLLKfHSDi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYoorIACgkQAVBC80lX
0Gx8nwf+Ky1H4cJiZmlF6KmnzitTA7p+81Gssp+3gCMJn0rsO0we+aMNsYI86roh
SJCwDscx1enNllif/xoPVG63aoLRbOWPWkLAYgsH0m0tItSneUOykxV3ltTriDMk
KcTDP9dwLxeNE5t+WCA+4jG6qYi2krbo1wNH81K8f2wfuqIebqWT28WYAuEBKJbm
pHSkU8JlZBlxjUEfTfXoSkbOzZHuiadxtmASfA8hOgMgEQo0eIrWHE34KOgxH7Sq
FJrYt8833Os8OfvGxLjlB+vwdqLSknAehA7VTcxZtHNxbOtwF82wsQrlW6OtDk5J
TUELCJRbD0EV+eXTgAws10OJv2mdpA==
=8vas
-----END PGP SIGNATURE-----

--Sig_/0xI_=SLPommwheHLLKfHSDi--

