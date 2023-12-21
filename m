Return-Path: <linux-kernel+bounces-7744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA6381AC85
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D882835BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E843B3C0F;
	Thu, 21 Dec 2023 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Aubdeicm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B5A184C;
	Thu, 21 Dec 2023 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703124588;
	bh=SQPj3HUnBXBdCf7DMtt5ufwXC9cul2cKhzw9rtRPKJE=;
	h=Date:From:To:Cc:Subject:From;
	b=AubdeicmHTt5iSFlzJ8q1Whh+nIKxNLzB1hHPTAG1T6csV54TNdKExwM7OCexL3lo
	 Zdlox/qu+Ajls/2/b7XOfFUdeEHWseHuSXQzpDM4oWpvED/CltUgR81ZuvOwvzGJAT
	 q9nJaskMIcE3w2WWJFVdAP2I7pwKPtKp2Q5QF/bQabertGbnNQyDfJZQUPmm3R+wh3
	 FY9hv4DGvuHSmJPx5Y51nyXh20RZoU1eZovPydtpnKl2IA5cq/f4MkOgwaYYvzbGSk
	 5XVeYibhsm6bdoKcPbtcv08mRi9c9OThfksonBJ0uOaqk2aXluIFrZI+/UI3d2omnJ
	 H45xYKNguSBlg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SwYlv5Xgvz4xGC;
	Thu, 21 Dec 2023 13:09:47 +1100 (AEDT)
Date: Thu, 21 Dec 2023 13:09:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Networking <netdev@vger.kernel.org>, Mathis Marion
 <mathis.marion@silabs.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robimarko@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20231221130946.7ed9a805@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Fa.4Qy/BxRLuQekLcKhZ6B1";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Fa.4Qy/BxRLuQekLcKhZ6B1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/net/phy/aquantia/aquantia_firmware.c: In function 'aqr_fw_load_memo=
ry':
drivers/net/phy/aquantia/aquantia_firmware.c:135:23: error: implicit declar=
ation of function 'crc_ccitt_false'; did you mean 'crc_ccitt_byte'? [-Werro=
r=3Dimplicit-function-declaration]
  135 |                 crc =3D crc_ccitt_false(crc, crc_data, sizeof(crc_d=
ata));
      |                       ^~~~~~~~~~~~~~~
      |                       crc_ccitt_byte

Caused by commit

  e93984ebc1c8 ("net: phy: aquantia: add firmware load support")

interacting with commit

  56ded2dd1a43 ("lib: crc_ccitt_false() is identical to crc_itu_t()")

from the mm tree.

I have applied the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 21 Dec 2023 12:49:11 +1100
Subject: [PATCH] fix up for "net: phy: aquantia: add firmware load support"

interacting with commit

  56ded2dd1a43 ("lib: crc_ccitt_false() is identical to crc_itu_t()")

from the mm tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/phy/aquantia/Kconfig             | 2 +-
 drivers/net/phy/aquantia/aquantia_firmware.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/aquantia/Kconfig b/drivers/net/phy/aquantia/Kc=
onfig
index a35de4b9b554..1a65678583cf 100644
--- a/drivers/net/phy/aquantia/Kconfig
+++ b/drivers/net/phy/aquantia/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config AQUANTIA_PHY
 	tristate "Aquantia PHYs"
-	select CRC_CCITT
+	select CRC_ITU_T
 	help
 	  Currently supports the Aquantia AQ1202, AQ2104, AQR105, AQR405
diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy=
/aquantia/aquantia_firmware.c
index ff34d00d5a0e..0c9640ef153b 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -3,7 +3,7 @@
 #include <linux/bitfield.h>
 #include <linux/of.h>
 #include <linux/firmware.h>
-#include <linux/crc-ccitt.h>
+#include <linux/crc-itu-t.h>
 #include <linux/nvmem-consumer.h>
=20
 #include <asm/unaligned.h>
@@ -132,7 +132,7 @@ static int aqr_fw_load_memory(struct phy_device *phydev=
, u32 addr,
 		crc_data[3] =3D word;
=20
 		/* ...calculate CRC as we load data... */
-		crc =3D crc_ccitt_false(crc, crc_data, sizeof(crc_data));
+		crc =3D crc_itu_t(crc, crc_data, sizeof(crc_data));
 	}
 	/* ...gets CRC from MAILBOX after we have loaded the entire section... */
 	up_crc =3D phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTE=
RFACE2);
@@ -164,7 +164,7 @@ static int aqr_fw_boot(struct phy_device *phydev, const=
 u8 *data, size_t size,
 		phydev_err(phydev, "bad firmware CRC in firmware\n");
 		return ret;
 	}
-	calculated_crc =3D crc_ccitt_false(0, data, size - sizeof(u16));
+	calculated_crc =3D crc_itu_t(0, data, size - sizeof(u16));
 	if (read_crc !=3D calculated_crc) {
 		phydev_err(phydev, "bad firmware CRC: file 0x%04x calculated 0x%04x\n",
 			   read_crc, calculated_crc);
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/Fa.4Qy/BxRLuQekLcKhZ6B1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWDnmoACgkQAVBC80lX
0Gzmfwf/QMypL/PxMl3HbvqpSQwtGBjPeOmrcx+lqyuw66CeHBYqVkOWnAS0yuDn
N6KT6xeXOp/iYE9NekpidJzQ1GtPN/Ip9AtTnn54KiW0rLJDq2AEVZPV7dOPQu88
6xDXJAM0c+7CRjSTWoDEINl/0AWLq0sePRStDwGCsVWKJfFTXPb/FjrtyGI9gsiB
fzcBgN0zCeuYxD7Jy3em9ObVmtyVpG2yqYrgNaHlvUEnE2FNkl/O3efHuHuXuYnn
kh22xaZZ+CXlBUncQCF/dsPX/N5Wcc/Bly5roJ7PizS3J6hxe5xBQck7yjocOGuH
OKGO+ZaQ2BBCKp7UD4vPFy3uqaSylA==
=ZdrR
-----END PGP SIGNATURE-----

--Sig_/Fa.4Qy/BxRLuQekLcKhZ6B1--

