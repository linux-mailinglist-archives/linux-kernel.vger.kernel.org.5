Return-Path: <linux-kernel+bounces-63726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C68533B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28ADA1C222E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6F25F494;
	Tue, 13 Feb 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="FZnbk+Fc"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ED558126
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836056; cv=none; b=qzN93LwQqdFcX9tzyuh54UaoEFKQr1d8SE0y4ay1D4XX10Bylz6EDgQOhKj2oawrfHeaDl+e3ILAMdxpX17LTBm4vT0jWGFC5QMclxJ9ehwm5I/BMzaTQa+XxzLelaT1ctT+pw8ucNsf0WWnIb7EjNnioGifsfCUzB/Np6qtnm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836056; c=relaxed/simple;
	bh=tjiXXFyIZh8Dfta7GQQQjWlBfYCDo0iftVeGJb06WSg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pygYXKTEdPDp9ojPswhIYCjVawH7kkupGotnXE6Slw2gcegyNLqulOdEGhIupCILPIH3PpAc4KAN1+nJP/TJUEGLDvJ59IdZnw1W2IOMNpW2ua1J1iXFW84G/XaW6zDHVLpybHop/un/ra39BPqr7My7h8xlBB75OVOnf9B/XOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=FZnbk+Fc; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1707836044;
	bh=tjiXXFyIZh8Dfta7GQQQjWlBfYCDo0iftVeGJb06WSg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=FZnbk+Fc0ZHlS5mzv3RVq/iToWaYXMMKReIlyiSddG68j5ThLukt9ycLBeKTdBEWm
	 gq2WRE0m3Mn+Y/OkDoqi8pM8hSJSfgxsbzDXD7tG5PWVpwwYP/3PD0j/RSeDCaVclH
	 h8AAOLd/jDhv72QvsPcZnZgYeKjNArdBzBX6yl5RHTOr+94VYvsLGTZuEpnGz3/3gQ
	 j8Nrs3YwTWH3wLK2st2ZJZUjaabdRmvBp3jMO2LcWQYi4oW7I2kDICOsZ07EFiBYFx
	 X6iNNGb0mz7rKhNCPQV7LFa7iRcM2GSv+aRSLxRJMrQEQC8HKWVCzGscIzmvs+Q+Lx
	 D4FiMyMpV5U/Q==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id D8EA315F4;
	Tue, 13 Feb 2024 15:54:04 +0100 (CET)
Date: Tue, 13 Feb 2024 15:54:04 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Joe Perches <joe@perches.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/1] Normalise "name (ad@dr)" MODULE_AUTHORs to "name <ad@dr>"
Message-ID: <mk3geln4azm5binjjlfsgjepow4o73domjv6ajybws3tz22vb3@tarta.nabijaczleweli.xyz>
References: <5897107ef2ef0e862c92a9c3400d52e9a2d48d93.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3tusutev6wbndiy4"
Content-Disposition: inline
In-Reply-To: <5897107ef2ef0e862c92a9c3400d52e9a2d48d93.camel@perches.com>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--3tusutev6wbndiy4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Found with git grep 'MODULE_AUTHOR(".*([^)]*@'
Fixed with
  sed -i '/MODULE_AUTHOR(".*([^)]*@/{s/ (/ </g;s/)"/>"/;s/)and/> and/}' \
    $(git grep -l 'MODULE_AUTHOR(".*([^)]*@')

Also:
  in drivers/media/usb/siano/smsusb.c normalise ", INC" to ", Inc";
     this is what every other MODULE_AUTHOR for this company says,
     and it's what the header says
  in drivers/sbus/char/openprom.c normalise a double-spaced separator;
     this is clearly copied from the copyright header,
     where the names are aligned on consecutive lines thusly:
      * Linux/SPARC PROM Configuration Driver
      * Copyright (C) 1996 Thomas K. Dyas (tdyas@noc.rutgers.edu)
      * Copyright (C) 1996 Eddie C. Dost  (ecd@skynet.be)
     but the authorship branding is single-line

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
(this grep seems to've found two more instances than the one you posted)

 arch/sparc/kernel/chmc.c                  | 2 +-
 arch/sparc/kernel/ds.c                    | 2 +-
 drivers/block/sunvdc.c                    | 2 +-
 drivers/char/hw_random/n2-drv.c           | 2 +-
 drivers/char/tpm/st33zp24/i2c.c           | 2 +-
 drivers/char/tpm/st33zp24/spi.c           | 2 +-
 drivers/char/tpm/st33zp24/st33zp24.c      | 2 +-
 drivers/char/tpm/tpm-interface.c          | 2 +-
 drivers/char/tpm/tpm_atmel.c              | 2 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c        | 2 +-
 drivers/char/tpm/tpm_nsc.c                | 2 +-
 drivers/char/tpm/tpm_tis.c                | 2 +-
 drivers/char/tpm/tpm_tis_core.c           | 2 +-
 drivers/char/tpm/tpm_vtpm_proxy.c         | 2 +-
 drivers/crypto/n2_core.c                  | 2 +-
 drivers/hwmon/dell-smm-hwmon.c            | 2 +-
 drivers/hwmon/ultra45_env.c               | 2 +-
 drivers/i2c/muxes/i2c-mux-mlxcpld.c       | 2 +-
 drivers/leds/leds-sunfire.c               | 2 +-
 drivers/media/common/siano/smscoreapi.c   | 2 +-
 drivers/media/common/siano/smsdvb-main.c  | 2 +-
 drivers/media/dvb-frontends/cx24117.c     | 2 +-
 drivers/media/usb/siano/smsusb.c          | 2 +-
 drivers/net/ethernet/broadcom/tg3.c       | 2 +-
 drivers/net/ethernet/sun/cassini.c        | 2 +-
 drivers/net/ethernet/sun/niu.c            | 2 +-
 drivers/net/ethernet/sun/sunhme.c         | 2 +-
 drivers/net/ethernet/sun/sunvnet.c        | 2 +-
 drivers/net/ethernet/sun/sunvnet_common.c | 2 +-
 drivers/net/ppp/pptp.c                    | 2 +-
 drivers/platform/x86/compal-laptop.c      | 2 +-
 drivers/platform/x86/intel/oaktrail.c     | 2 +-
 drivers/platform/x86/mlx-platform.c       | 2 +-
 drivers/s390/net/fsm.c                    | 2 +-
 drivers/sbus/char/openprom.c              | 2 +-
 drivers/scsi/esp_scsi.c                   | 2 +-
 drivers/scsi/jazz_esp.c                   | 2 +-
 drivers/scsi/mesh.c                       | 2 +-
 drivers/scsi/qlogicpti.c                  | 2 +-
 drivers/scsi/sun3x_esp.c                  | 2 +-
 drivers/scsi/sun_esp.c                    | 2 +-
 drivers/video/fbdev/hgafb.c               | 2 +-
 net/ipv4/gre_demux.c                      | 2 +-
 net/ipv6/ip6_gre.c                        | 2 +-
 net/iucv/iucv.c                           | 2 +-
 net/mpls/mpls_gso.c                       | 2 +-
 46 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
index d5fad5fb04c1..00e571c30bb5 100644
--- a/arch/sparc/kernel/chmc.c
+++ b/arch/sparc/kernel/chmc.c
@@ -30,7 +30,7 @@
 #define PFX DRV_MODULE_NAME	": "
 #define DRV_MODULE_VERSION	"0.2"
=20
-MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_DESCRIPTION("UltraSPARC-III memory controller driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index 4a5bdb0df779..ffdc15588ac2 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -33,7 +33,7 @@
=20
 static char version[] =3D
 	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
-MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_DESCRIPTION("Sun LDOM domain services driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 7bf4b48e2282..9105d7ec671d 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -28,7 +28,7 @@
=20
 static char version[] =3D
 	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
-MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_DESCRIPTION("Sun LDOM virtual disk client driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-dr=
v.c
index 2e669e7c14d3..1b49e3a86d57 100644
--- a/drivers/char/hw_random/n2-drv.c
+++ b/drivers/char/hw_random/n2-drv.c
@@ -29,7 +29,7 @@
 static char version[] =3D
 	DRV_MODULE_NAME " v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
=20
-MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_DESCRIPTION("Niagara2 RNG driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2=
c.c
index 661574bb0acf..45ca33b3dcb2 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -167,7 +167,7 @@ static struct i2c_driver st33zp24_i2c_driver =3D {
=20
 module_i2c_driver(st33zp24_i2c_driver);
=20
-MODULE_AUTHOR("TPM support (TPMsupport@list.st.com)");
+MODULE_AUTHOR("TPM support <TPMsupport@list.st.com>");
 MODULE_DESCRIPTION("STM TPM 1.2 I2C ST33 Driver");
 MODULE_VERSION("1.3.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/sp=
i.c
index f5811b301d3b..5149231f3de2 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -284,7 +284,7 @@ static struct spi_driver st33zp24_spi_driver =3D {
=20
 module_spi_driver(st33zp24_spi_driver);
=20
-MODULE_AUTHOR("TPM support (TPMsupport@list.st.com)");
+MODULE_AUTHOR("TPM support <TPMsupport@list.st.com>");
 MODULE_DESCRIPTION("STM TPM 1.2 SPI ST33 Driver");
 MODULE_VERSION("1.3.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp=
24/st33zp24.c
index a5b554cd4778..c0771980bc2f 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -582,7 +582,7 @@ int st33zp24_pm_resume(struct device *dev)
 EXPORT_SYMBOL(st33zp24_pm_resume);
 #endif
=20
-MODULE_AUTHOR("TPM support (TPMsupport@list.st.com)");
+MODULE_AUTHOR("TPM support <TPMsupport@list.st.com>");
 MODULE_DESCRIPTION("ST33ZP24 TPM 1.2 driver");
 MODULE_VERSION("1.3.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interf=
ace.c
index 66b16d26eecc..757336324c90 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -524,7 +524,7 @@ static void __exit tpm_exit(void)
 subsys_initcall(tpm_init);
 module_exit(tpm_exit);
=20
-MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
+MODULE_AUTHOR("Leendert van Doorn <leendert@watson.ibm.com>");
 MODULE_DESCRIPTION("TPM Driver");
 MODULE_VERSION("2.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
index 54a6750a6757..9fb2defa9dc4 100644
--- a/drivers/char/tpm/tpm_atmel.c
+++ b/drivers/char/tpm/tpm_atmel.c
@@ -229,7 +229,7 @@ static void __exit cleanup_atmel(void)
 module_init(init_atmel);
 module_exit(cleanup_atmel);
=20
-MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
+MODULE_AUTHOR("Leendert van Doorn <leendert@watson.ibm.com>");
 MODULE_DESCRIPTION("TPM Driver");
 MODULE_VERSION("2.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_=
nuvoton.c
index 5490f7e0fa43..3c3ee5f551db 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -654,6 +654,6 @@ static struct i2c_driver i2c_nuvoton_driver =3D {
=20
 module_i2c_driver(i2c_nuvoton_driver);
=20
-MODULE_AUTHOR("Dan Morav (dan.morav@nuvoton.com)");
+MODULE_AUTHOR("Dan Morav <dan.morav@nuvoton.com>");
 MODULE_DESCRIPTION("Nuvoton TPM I2C Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
index 038701d48351..0f62bbc940da 100644
--- a/drivers/char/tpm/tpm_nsc.c
+++ b/drivers/char/tpm/tpm_nsc.c
@@ -410,7 +410,7 @@ static void __exit cleanup_nsc(void)
 module_init(init_nsc);
 module_exit(cleanup_nsc);
=20
-MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
+MODULE_AUTHOR("Leendert van Doorn <leendert@watson.ibm.com>");
 MODULE_DESCRIPTION("TPM Driver");
 MODULE_VERSION("2.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 2c52b7905b07..f301b8fc5fcf 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -428,7 +428,7 @@ static void __exit cleanup_tis(void)
=20
 module_init(init_tis);
 module_exit(cleanup_tis);
-MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
+MODULE_AUTHOR("Leendert van Doorn <leendert@watson.ibm.com>");
 MODULE_DESCRIPTION("TPM Driver");
 MODULE_VERSION("2.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_cor=
e.c
index 1b350412d8a6..a57cf698e18d 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1361,7 +1361,7 @@ int tpm_tis_resume(struct device *dev)
 EXPORT_SYMBOL_GPL(tpm_tis_resume);
 #endif
=20
-MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
+MODULE_AUTHOR("Leendert van Doorn <leendert@watson.ibm.com>");
 MODULE_DESCRIPTION("TPM Driver");
 MODULE_VERSION("2.0");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_=
proxy.c
index 30e953988cab..11c502039faf 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -711,7 +711,7 @@ static void __exit vtpm_module_exit(void)
 module_init(vtpm_module_init);
 module_exit(vtpm_module_exit);
=20
-MODULE_AUTHOR("Stefan Berger (stefanb@us.ibm.com)");
+MODULE_AUTHOR("Stefan Berger <stefanb@us.ibm.com>");
 MODULE_DESCRIPTION("vTPM Driver");
 MODULE_VERSION("0.1");
 MODULE_LICENSE("GPL");
diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index 7a3083debc2b..59d472cb11e7 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -41,7 +41,7 @@
 static const char version[] =3D
 	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
=20
-MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_DESCRIPTION("Niagara2 Crypto driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 6d8c0f328b7b..88e48e30c893 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -108,7 +108,7 @@ struct dell_smm_cooling_data {
 	struct dell_smm_data *data;
 };
=20
-MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
+MODULE_AUTHOR("Massimo Dal Zotto <dz@debian.org>");
 MODULE_AUTHOR("Pali Roh=C3=A1r <pali@kernel.org>");
 MODULE_DESCRIPTION("Dell laptop SMM BIOS hwmon driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hwmon/ultra45_env.c b/drivers/hwmon/ultra45_env.c
index 9823afb0675a..2765d5f1b7f0 100644
--- a/drivers/hwmon/ultra45_env.c
+++ b/drivers/hwmon/ultra45_env.c
@@ -18,7 +18,7 @@
=20
 #define DRV_MODULE_VERSION	"0.1"
=20
-MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_DESCRIPTION("Ultra45 environmental monitor driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-mu=
x-mlxcpld.c
index 3dda00f1df78..4c6ed1d58c79 100644
--- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
+++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
@@ -187,7 +187,7 @@ static struct platform_driver mlxcpld_mux_driver =3D {
=20
 module_platform_driver(mlxcpld_mux_driver);
=20
-MODULE_AUTHOR("Michael Shych (michaels@mellanox.com)");
+MODULE_AUTHOR("Michael Shych <michaels@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox I2C-CPLD-MUX driver");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("platform:i2c-mux-mlxcpld");
diff --git a/drivers/leds/leds-sunfire.c b/drivers/leds/leds-sunfire.c
index 6fd89efb420a..a621e5e5c75c 100644
--- a/drivers/leds/leds-sunfire.c
+++ b/drivers/leds/leds-sunfire.c
@@ -17,7 +17,7 @@
 #include <asm/fhc.h>
 #include <asm/upa.h>
=20
-MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_DESCRIPTION("Sun Fire LED driver");
 MODULE_LICENSE("GPL");
=20
diff --git a/drivers/media/common/siano/smscoreapi.c b/drivers/media/common=
/siano/smscoreapi.c
index 7d4bc2733f2b..7ebcb10126c9 100644
--- a/drivers/media/common/siano/smscoreapi.c
+++ b/drivers/media/common/siano/smscoreapi.c
@@ -2155,7 +2155,7 @@ module_init(smscore_module_init);
 module_exit(smscore_module_exit);
=20
 MODULE_DESCRIPTION("Siano MDTV Core module");
-MODULE_AUTHOR("Siano Mobile Silicon, Inc. (uris@siano-ms.com)");
+MODULE_AUTHOR("Siano Mobile Silicon, Inc. <uris@siano-ms.com>");
 MODULE_LICENSE("GPL");
=20
 /* This should match what's defined at smscoreapi.h */
diff --git a/drivers/media/common/siano/smsdvb-main.c b/drivers/media/commo=
n/siano/smsdvb-main.c
index f80caaa333da..d893a0e4672b 100644
--- a/drivers/media/common/siano/smsdvb-main.c
+++ b/drivers/media/common/siano/smsdvb-main.c
@@ -1267,5 +1267,5 @@ module_init(smsdvb_module_init);
 module_exit(smsdvb_module_exit);
=20
 MODULE_DESCRIPTION("SMS DVB subsystem adaptation module");
-MODULE_AUTHOR("Siano Mobile Silicon, Inc. (uris@siano-ms.com)");
+MODULE_AUTHOR("Siano Mobile Silicon, Inc. <uris@siano-ms.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/media/dvb-frontends/cx24117.c b/drivers/media/dvb-fron=
tends/cx24117.c
index ac6e47d81b9e..75fc7ad263d0 100644
--- a/drivers/media/dvb-frontends/cx24117.c
+++ b/drivers/media/dvb-frontends/cx24117.c
@@ -1647,7 +1647,7 @@ static const struct dvb_frontend_ops cx24117_ops =3D {
=20
=20
 MODULE_DESCRIPTION("DVB Frontend module for Conexant cx24117/cx24132 hardw=
are");
-MODULE_AUTHOR("Luis Alves (ljalvs@gmail.com)");
+MODULE_AUTHOR("Luis Alves <ljalvs@gmail.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.1");
 MODULE_FIRMWARE(CX24117_DEFAULT_FIRMWARE);
diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/sms=
usb.c
index 9d9e14c858e6..723510520d09 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -724,5 +724,5 @@ static struct usb_driver smsusb_driver =3D {
 module_usb_driver(smsusb_driver);
=20
 MODULE_DESCRIPTION("Driver for the Siano SMS1xxx USB dongle");
-MODULE_AUTHOR("Siano Mobile Silicon, INC. (uris@siano-ms.com)");
+MODULE_AUTHOR("Siano Mobile Silicon, Inc. <uris@siano-ms.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/bro=
adcom/tg3.c
index 04964bbe08cf..61a0168f9b0e 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -221,7 +221,7 @@ static inline void _tg3_flag_clear(enum TG3_FLAGS flag,=
 unsigned long *bits)
 #define FIRMWARE_TG3TSO		"tigon/tg3_tso.bin"
 #define FIRMWARE_TG3TSO5	"tigon/tg3_tso5.bin"
=20
-MODULE_AUTHOR("David S. Miller (davem@redhat.com) and Jeff Garzik (jgarzik=
@pobox.com)");
+MODULE_AUTHOR("David S. Miller <davem@redhat.com> and Jeff Garzik <jgarzik=
@pobox.com>");
 MODULE_DESCRIPTION("Broadcom Tigon3 ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(FIRMWARE_TG3);
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/=
cassini.c
index b317b9486455..bfb903506367 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -176,7 +176,7 @@ static char version[] =3D
 static int cassini_debug =3D -1;	/* -1 =3D=3D use CAS_DEF_MSG_ENABLE as va=
lue */
 static int link_mode;
=20
-MODULE_AUTHOR("Adrian Sun (asun@darksunrising.com)");
+MODULE_AUTHOR("Adrian Sun <asun@darksunrising.com>");
 MODULE_DESCRIPTION("Sun Cassini(+) ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE("sun/cassini.bin");
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 21431f43e4c2..f68aa813d4fb 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -61,7 +61,7 @@ union niu_page {
 static char version[] =3D
 	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
=20
-MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_DESCRIPTION("NIU ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/s=
unhme.c
index b983b9c23be6..50ace461a1af 100644
--- a/drivers/net/ethernet/sun/sunhme.c
+++ b/drivers/net/ethernet/sun/sunhme.c
@@ -59,7 +59,7 @@
=20
 #define DRV_NAME	"sunhme"
=20
-MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_DESCRIPTION("Sun HappyMealEthernet(HME) 10/100baseT ethernet driver=
");
 MODULE_LICENSE("GPL");
=20
diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/=
sunvnet.c
index e220620d0ffc..2f30715e9b67 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -44,7 +44,7 @@
=20
 static char version[] =3D
 	DRV_MODULE_NAME " " DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")";
-MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_DESCRIPTION("Sun LDOM virtual network driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethern=
et/sun/sunvnet_common.c
index 3525d5c0d694..dbe51524b275 100644
--- a/drivers/net/ethernet/sun/sunvnet_common.c
+++ b/drivers/net/ethernet/sun/sunvnet_common.c
@@ -39,7 +39,7 @@
  */
 #define	VNET_MAX_RETRIES	10
=20
-MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_DESCRIPTION("Sun LDOM virtual network support library");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.1");
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 6833ef0c7930..689687bd2574 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -694,6 +694,6 @@ module_init(pptp_init_module);
 module_exit(pptp_exit_module);
=20
 MODULE_DESCRIPTION("Point-to-Point Tunneling Protocol");
-MODULE_AUTHOR("D. Kozlov (xeb@mail.ru)");
+MODULE_AUTHOR("D. Kozlov <xeb@mail.ru>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NET_PF_PROTO(PF_PPPOX, PX_PROTO_PPTP);
diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/co=
mpal-laptop.c
index 61c745490d71..5546fb189491 100644
--- a/drivers/platform/x86/compal-laptop.c
+++ b/drivers/platform/x86/compal-laptop.c
@@ -1107,7 +1107,7 @@ module_init(compal_init);
 module_exit(compal_cleanup);
=20
 MODULE_AUTHOR("Cezary Jackiewicz");
-MODULE_AUTHOR("Roald Frederickx (roald.frederickx@gmail.com)");
+MODULE_AUTHOR("Roald Frederickx <roald.frederickx@gmail.com>");
 MODULE_DESCRIPTION("Compal Laptop Support");
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/intel/oaktrail.c b/drivers/platform/x86/i=
ntel/oaktrail.c
index fa720967e69b..217630f40c3f 100644
--- a/drivers/platform/x86/intel/oaktrail.c
+++ b/drivers/platform/x86/intel/oaktrail.c
@@ -365,7 +365,7 @@ static void __exit oaktrail_cleanup(void)
 module_init(oaktrail_init);
 module_exit(oaktrail_cleanup);
=20
-MODULE_AUTHOR("Yin Kangkai (kangkai.yin@intel.com)");
+MODULE_AUTHOR("Yin Kangkai <kangkai.yin@intel.com>");
 MODULE_DESCRIPTION("Intel Oaktrail Platform ACPI Extras");
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx=
-platform.c
index 32981e2ad3b3..9d70146fd742 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -6659,6 +6659,6 @@ static void __exit mlxplat_exit(void)
 }
 module_exit(mlxplat_exit);
=20
-MODULE_AUTHOR("Vadim Pasternak (vadimp@mellanox.com)");
+MODULE_AUTHOR("Vadim Pasternak <vadimp@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox platform driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/s390/net/fsm.c b/drivers/s390/net/fsm.c
index 0ff61d00feb1..8672d225ba77 100644
--- a/drivers/s390/net/fsm.c
+++ b/drivers/s390/net/fsm.c
@@ -9,7 +9,7 @@
 #include <linux/slab.h>
 #include <linux/timer.h>
=20
-MODULE_AUTHOR("(C) 2000 IBM Corp. by Fritz Elfert (felfert@millenux.com)");
+MODULE_AUTHOR("(C) 2000 IBM Corp. by Fritz Elfert <felfert@millenux.com>");
 MODULE_DESCRIPTION("Finite state machine helper functions");
 MODULE_LICENSE("GPL");
=20
diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 30b9751aad30..cc178874c4a6 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -33,7 +33,7 @@
 #include <linux/pci.h>
 #endif
=20
-MODULE_AUTHOR("Thomas K. Dyas (tdyas@noc.rutgers.edu) and Eddie C. Dost  (=
ecd@skynet.be)");
+MODULE_AUTHOR("Thomas K. Dyas <tdyas@noc.rutgers.edu> and Eddie C. Dost <e=
cd@skynet.be>");
 MODULE_DESCRIPTION("OPENPROM Configuration Driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0");
diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index 97816a0e6240..0175d2282b45 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -2753,7 +2753,7 @@ static void __exit esp_exit(void)
 }
=20
 MODULE_DESCRIPTION("ESP SCSI driver core");
-MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
=20
diff --git a/drivers/scsi/jazz_esp.c b/drivers/scsi/jazz_esp.c
index 494a671fb556..fb04b0b515ab 100644
--- a/drivers/scsi/jazz_esp.c
+++ b/drivers/scsi/jazz_esp.c
@@ -204,6 +204,6 @@ static struct platform_driver esp_jazz_driver =3D {
 module_platform_driver(esp_jazz_driver);
=20
 MODULE_DESCRIPTION("JAZZ ESP SCSI driver");
-MODULE_AUTHOR("Thomas Bogendoerfer (tsbogend@alpha.franken.de)");
+MODULE_AUTHOR("Thomas Bogendoerfer <tsbogend@alpha.franken.de>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index e276583c590c..0a48da52d1dc 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -54,7 +54,7 @@
 #define KERN_DEBUG KERN_WARNING
 #endif
=20
-MODULE_AUTHOR("Paul Mackerras (paulus@samba.org)");
+MODULE_AUTHOR("Paul Mackerras <paulus@samba.org>");
 MODULE_DESCRIPTION("PowerMac MESH SCSI driver");
 MODULE_LICENSE("GPL");
=20
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 5d560d9b8944..6177f4798f3a 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1468,7 +1468,7 @@ static struct platform_driver qpti_sbus_driver =3D {
 module_platform_driver(qpti_sbus_driver);
=20
 MODULE_DESCRIPTION("QlogicISP SBUS driver");
-MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("2.1");
 MODULE_FIRMWARE("qlogic/isp1000.bin");
diff --git a/drivers/scsi/sun3x_esp.c b/drivers/scsi/sun3x_esp.c
index 09219c362acc..e20f314cf3e7 100644
--- a/drivers/scsi/sun3x_esp.c
+++ b/drivers/scsi/sun3x_esp.c
@@ -273,7 +273,7 @@ static struct platform_driver esp_sun3x_driver =3D {
 module_platform_driver(esp_sun3x_driver);
=20
 MODULE_DESCRIPTION("Sun3x ESP SCSI driver");
-MODULE_AUTHOR("Thomas Bogendoerfer (tsbogend@alpha.franken.de)");
+MODULE_AUTHOR("Thomas Bogendoerfer <tsbogend@alpha.franken.de>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 MODULE_ALIAS("platform:sun3x_esp");
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index 64a7c2c6c5ff..5ce6c9d19d1e 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -608,6 +608,6 @@ static struct platform_driver esp_sbus_driver =3D {
 module_platform_driver(esp_sbus_driver);
=20
 MODULE_DESCRIPTION("Sun ESP SCSI driver");
-MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
+MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
index 264c8cedba15..c3bc5b78b749 100644
--- a/drivers/video/fbdev/hgafb.c
+++ b/drivers/video/fbdev/hgafb.c
@@ -670,7 +670,7 @@ static void __exit hgafb_exit(void)
  *
  * -----------------------------------------------------------------------=
-- */
=20
-MODULE_AUTHOR("Ferenc Bakonyi (fero@drama.obuda.kando.hu)");
+MODULE_AUTHOR("Ferenc Bakonyi <fero@drama.obuda.kando.hu>");
 MODULE_DESCRIPTION("FBDev driver for Hercules Graphics Adaptor");
 MODULE_LICENSE("GPL");
=20
diff --git a/net/ipv4/gre_demux.c b/net/ipv4/gre_demux.c
index cbb2b4bb0dfa..3757fd93523f 100644
--- a/net/ipv4/gre_demux.c
+++ b/net/ipv4/gre_demux.c
@@ -217,5 +217,5 @@ module_init(gre_init);
 module_exit(gre_exit);
=20
 MODULE_DESCRIPTION("GRE over IPv4 demultiplexer driver");
-MODULE_AUTHOR("D. Kozlov (xeb@mail.ru)");
+MODULE_AUTHOR("D. Kozlov <xeb@mail.ru>");
 MODULE_LICENSE("GPL");
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 070d87abf7c0..2dd77c2ba218 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2405,7 +2405,7 @@ static void __exit ip6gre_fini(void)
 module_init(ip6gre_init);
 module_exit(ip6gre_fini);
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("D. Kozlov (xeb@mail.ru)");
+MODULE_AUTHOR("D. Kozlov <xeb@mail.ru>");
 MODULE_DESCRIPTION("GRE over IPv6 tunneling device");
 MODULE_ALIAS_RTNL_LINK("ip6gre");
 MODULE_ALIAS_RTNL_LINK("ip6gretap");
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 6334f64f04d5..1f27bc26c790 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -1903,6 +1903,6 @@ static void __exit iucv_exit(void)
 subsys_initcall(iucv_init);
 module_exit(iucv_exit);
=20
-MODULE_AUTHOR("(C) 2001 IBM Corp. by Fritz Elfert (felfert@millenux.com)");
+MODULE_AUTHOR("(C) 2001 IBM Corp. by Fritz Elfert <felfert@millenux.com>");
 MODULE_DESCRIPTION("Linux for S/390 IUCV lowlevel driver");
 MODULE_LICENSE("GPL");
diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
index 533d082f0701..f779b4f23b78 100644
--- a/net/mpls/mpls_gso.c
+++ b/net/mpls/mpls_gso.c
@@ -106,5 +106,5 @@ module_init(mpls_gso_init);
 module_exit(mpls_gso_exit);
=20
 MODULE_DESCRIPTION("MPLS GSO support");
-MODULE_AUTHOR("Simon Horman (horms@verge.net.au)");
+MODULE_AUTHOR("Simon Horman <horms@verge.net.au>");
 MODULE_LICENSE("GPL");
--=20
2.39.2

--3tusutev6wbndiy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmXLgowACgkQvP0LAY0m
WPFYoBAAkOfndQED2gqysEEkM92e0M8Fak4WCXPC7HnSQZMDMBa3M6CE/7dQKDMV
l+9u5DRzz8Rn4UupMqrPt5v3KYYLmneQrJRhps3Hdh48IF8BnYDcJEVKokzxJZg9
kYFNqOdi1vHvWp3vqXOe2KLXdNaURpOfkolya/BkldxtCOLX1M8Qcm812QxfS9l1
ZUv2WCU8h9iQwIXdkBBNLqF7cyPQrP7mfozUGjSseBbrNiI5RHqryJfZht2/xBDJ
0tNyOxiLVLysYDTtC+xomQEBPm/VOxu8rUWPtq0fer+IOgJXBqhFFDohfIkLACEe
QuDBXiyLucofh0fClgWP0HFhzgm8oa1yn9JfWeHYvbueaou5dLtI24ofNIzrh7uu
HP6e+p3I4S1Q0QI2ptCC218phdYJKtfrZnD/5gl82L+AmLB3g900V5zSPgQi3uJw
WDnURKPCxoUbx5RQ0RLi6XuoWFmVyq7uBcsrTf11cqQkTZN6rjsA6RyCouGUsZAc
ggw9Z2wyXDan/uRAXA3a5Nc5b97FEJKc76pfuVmEaMeIZjtFsjtuCL0HqP35f+Yy
xsJsJ+9MGtI65+ozsTSTtf1Y4M3/5XZrw+2ojvYq/MD5Bi7saXIVx3wuwzAhg92Q
Ivo/8PjRsvacFixi8JmH/t6yTpcopTo5y5C2MA3Co7SQRkC09l4=
=GKUE
-----END PGP SIGNATURE-----

--3tusutev6wbndiy4--

