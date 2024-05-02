Return-Path: <linux-kernel+bounces-166730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8388B9E98
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63FE289A24
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6476516C6BD;
	Thu,  2 May 2024 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="WztdJbb2"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6316C689
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667460; cv=none; b=RpigpCFJZTW+chDfgwLb4IrUW2lNB9/MF2EZaojn0CTUm8kMGha6kExhHgblsz85jkiS9S6pl2JMM+80QjxhvBTs3ey8Htqqu54l1YiJuF70ET81bULqIUoDWNQgRQRVRm0v9TTHVfJDWUOjJJR4wCeNQ9kL4MVJqmsKnWWOrMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667460; c=relaxed/simple;
	bh=aHuxs/I6XLGRGQ/72zxO4l40M59XNy3lmJuj4wefAl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5u0Z2MGVsgefyz5JMRwPI4jhF8NabMO5x/h0c3+jTdvos/84tZdEipe8om6pGgFAEp3irnnBENKXl5TTOD+sppzNqGCPWeEG9/ZS6DZuJH4BWN93J5Nq5gqPYC+/91QzSoOhVGh7H0kSIfaGBIBkUx/J7pIBHXc5qK8rGWvEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=WztdJbb2; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Zg1E666oAXkkSZ5xpv+tRBDtuqcXpdV8arhoPGKeKok=; b=WztdJbb2tJhvi4Uc
	C4kKqjfu6FIQr1Mdced+l+vChIRpFd8RMRjCqM1lqTYZk3VVYnjkZKsYxCwah8lyUoAzFXAZdok9g
	nF0Ta7KMn+z9u7bqByIBPofrYquvGLFZ77yZdhHnRrzRvFWV9gxtkQu0RW1ApknulwTvKrsdEyL1N
	ynJJlL75x2K02Rz7MWFzqAMVz5VU6O68iBsNtuzvf0i/CHsLl5GGfEd0svBdHO+K/oFIXYc2+eloD
	/rWD5Y9GaRjVjjPT/9TBfIVP4prMsgjwewGvRRI0b9ukhm+KJabagG4hqEbpSLPJmRmDJQSzZK9BZ
	xxI3+eHvs908jtXAGw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s2Yfx-004ILZ-2H;
	Thu, 02 May 2024 15:48:49 +0000
From: linux@treblig.org
To: sudipm.mukherjee@gmail.com
Cc: arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-parport@lists.infradead.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/3] parport: Remove parport_driver.devmodel
Date: Thu,  2 May 2024 16:48:23 +0100
Message-ID: <20240502154823.67235-4-linux@treblig.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502154823.67235-1-linux@treblig.org>
References: <20240502154823.67235-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'devmodel' hasn't actually been used since:
  'commit 3275158fa52a ("parport: remove use of devmodel")'
and everyone now has it set to true and has been fixed up; remove
the flag.

(There are still comments all over about it)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/ata/pata_parport/pata_parport.c  | 1 -
 drivers/auxdisplay/ks0108.c              | 1 -
 drivers/auxdisplay/panel.c               | 1 -
 drivers/char/lp.c                        | 1 -
 drivers/char/ppdev.c                     | 1 -
 drivers/i2c/busses/i2c-parport.c         | 1 -
 drivers/input/joystick/db9.c             | 1 -
 drivers/input/joystick/gamecon.c         | 1 -
 drivers/input/joystick/turbografx.c      | 1 -
 drivers/input/joystick/walkera0701.c     | 1 -
 drivers/input/serio/parkbd.c             | 1 -
 drivers/net/hamradio/baycom_epp.c        | 1 -
 drivers/net/hamradio/baycom_par.c        | 1 -
 drivers/net/plip/plip.c                  | 1 -
 drivers/parport/daisy.c                  | 1 -
 drivers/pps/clients/pps_parport.c        | 1 -
 drivers/pps/generators/pps_gen_parport.c | 1 -
 drivers/scsi/imm.c                       | 1 -
 drivers/scsi/ppa.c                       | 1 -
 drivers/spi/spi-butterfly.c              | 1 -
 drivers/spi/spi-lm70llp.c                | 1 -
 include/linux/parport.h                  | 4 ----
 sound/drivers/mts64.c                    | 1 -
 sound/drivers/portman2x4.c               | 1 -
 24 files changed, 27 deletions(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 9a2cb9ca9d1da..93ebf566b54ec 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -768,7 +768,6 @@ static struct parport_driver pata_parport_driver = {
 	.name = DRV_NAME,
 	.match_port = pata_parport_attach,
 	.detach = pata_parport_detach,
-	.devmodel = true,
 };
 
 static __init int pata_parport_init(void)
diff --git a/drivers/auxdisplay/ks0108.c b/drivers/auxdisplay/ks0108.c
index 234f9dbe6e300..51587f0fdaaec 100644
--- a/drivers/auxdisplay/ks0108.c
+++ b/drivers/auxdisplay/ks0108.c
@@ -162,7 +162,6 @@ static struct parport_driver ks0108_parport_driver = {
 	.name = "ks0108",
 	.match_port = ks0108_parport_attach,
 	.detach = ks0108_parport_detach,
-	.devmodel = true,
 };
 module_parport_driver(ks0108_parport_driver);
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 049ff443e790d..a731f28455b45 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1706,7 +1706,6 @@ static struct parport_driver panel_driver = {
 	.name = "panel",
 	.match_port = panel_attach,
 	.detach = panel_detach,
-	.devmodel = true,
 };
 module_parport_driver(panel_driver);
 
diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 2f171d14b9b50..2aca7676e19ba 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -1016,7 +1016,6 @@ static struct parport_driver lp_driver = {
 	.name = "lp",
 	.match_port = lp_attach,
 	.detach = lp_detach,
-	.devmodel = true,
 };
 
 static int __init lp_init(void)
diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index ee951b265213f..07f4858b8a0a2 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -832,7 +832,6 @@ static struct parport_driver pp_driver = {
 	.probe		= pp_probe,
 	.match_port	= pp_attach,
 	.detach		= pp_detach,
-	.devmodel	= true,
 };
 
 static int __init ppdev_init(void)
diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
index 0af86a5425683..3249bbd5eb43c 100644
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -400,7 +400,6 @@ static struct parport_driver i2c_parport_driver = {
 	.name = "i2c-parport",
 	.match_port = i2c_parport_attach,
 	.detach = i2c_parport_detach,
-	.devmodel = true,
 };
 module_parport_driver(i2c_parport_driver);
 
diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
index 4fba28b1a1e75..3ef66e4585449 100644
--- a/drivers/input/joystick/db9.c
+++ b/drivers/input/joystick/db9.c
@@ -673,7 +673,6 @@ static struct parport_driver db9_parport_driver = {
 	.name = "db9",
 	.match_port = db9_attach,
 	.detach = db9_detach,
-	.devmodel = true,
 };
 
 static int __init db9_init(void)
diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
index 41d5dac054481..7ed4892749fa3 100644
--- a/drivers/input/joystick/gamecon.c
+++ b/drivers/input/joystick/gamecon.c
@@ -1016,7 +1016,6 @@ static struct parport_driver gc_parport_driver = {
 	.name = "gamecon",
 	.match_port = gc_attach,
 	.detach = gc_detach,
-	.devmodel = true,
 };
 
 static int __init gc_init(void)
diff --git a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
index dfb9c684651f3..baa14acaa3a8f 100644
--- a/drivers/input/joystick/turbografx.c
+++ b/drivers/input/joystick/turbografx.c
@@ -274,7 +274,6 @@ static struct parport_driver tgfx_parport_driver = {
 	.name = "turbografx",
 	.match_port = tgfx_attach,
 	.detach = tgfx_detach,
-	.devmodel = true,
 };
 
 static int __init tgfx_init(void)
diff --git a/drivers/input/joystick/walkera0701.c b/drivers/input/joystick/walkera0701.c
index 27d95d6cf56e3..59eea813f258f 100644
--- a/drivers/input/joystick/walkera0701.c
+++ b/drivers/input/joystick/walkera0701.c
@@ -293,7 +293,6 @@ static struct parport_driver walkera0701_parport_driver = {
 	.name = "walkera0701",
 	.match_port = walkera0701_attach,
 	.detach = walkera0701_detach,
-	.devmodel = true,
 };
 
 module_parport_driver(walkera0701_parport_driver);
diff --git a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
index 0d54895428f5d..ac1f9ea3f969b 100644
--- a/drivers/input/serio/parkbd.c
+++ b/drivers/input/serio/parkbd.c
@@ -218,6 +218,5 @@ static struct parport_driver parkbd_parport_driver = {
 	.name = "parkbd",
 	.match_port = parkbd_attach,
 	.detach = parkbd_detach,
-	.devmodel = true,
 };
 module_parport_driver(parkbd_parport_driver);
diff --git a/drivers/net/hamradio/baycom_epp.c b/drivers/net/hamradio/baycom_epp.c
index ccfc83857c260..9e366f275406d 100644
--- a/drivers/net/hamradio/baycom_epp.c
+++ b/drivers/net/hamradio/baycom_epp.c
@@ -1193,7 +1193,6 @@ static int baycom_epp_par_probe(struct pardevice *par_dev)
 static struct parport_driver baycom_epp_par_driver = {
 	.name = "bce",
 	.probe = baycom_epp_par_probe,
-	.devmodel = true,
 };
 
 static void __init baycom_epp_dev_setup(struct net_device *dev)
diff --git a/drivers/net/hamradio/baycom_par.c b/drivers/net/hamradio/baycom_par.c
index fd7da5bb1fa5a..00ebc25d0b22a 100644
--- a/drivers/net/hamradio/baycom_par.c
+++ b/drivers/net/hamradio/baycom_par.c
@@ -503,7 +503,6 @@ static int baycom_par_probe(struct pardevice *par_dev)
 static struct parport_driver baycom_par_driver = {
 	.name = "bcp",
 	.probe = baycom_par_probe,
-	.devmodel = true,
 };
 
 static int __init init_baycompar(void)
diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
index cc7d1113ece0e..e39bfaefe8c50 100644
--- a/drivers/net/plip/plip.c
+++ b/drivers/net/plip/plip.c
@@ -1358,7 +1358,6 @@ static struct parport_driver plip_driver = {
 	.probe		= plip_probe,
 	.match_port	= plip_attach,
 	.detach		= plip_detach,
-	.devmodel	= true,
 };
 
 static void __exit plip_cleanup_module (void)
diff --git a/drivers/parport/daisy.c b/drivers/parport/daisy.c
index 6d78ec3a762fc..2231dbfd870d0 100644
--- a/drivers/parport/daisy.c
+++ b/drivers/parport/daisy.c
@@ -97,7 +97,6 @@ static int daisy_drv_probe(struct pardevice *par_dev)
 static struct parport_driver daisy_driver = {
 	.name = "daisy_drv",
 	.probe = daisy_drv_probe,
-	.devmodel = true,
 };
 
 /* Discover the IEEE1284.3 topology on a port -- muxes and daisy chains.
diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index 42f93d4c6ee32..4af3260f9e86c 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -216,7 +216,6 @@ static struct parport_driver pps_parport_driver = {
 	.name = KBUILD_MODNAME,
 	.match_port = parport_attach,
 	.detach = parport_detach,
-	.devmodel = true,
 };
 module_parport_driver(pps_parport_driver);
 
diff --git a/drivers/pps/generators/pps_gen_parport.c b/drivers/pps/generators/pps_gen_parport.c
index b3e084b75c237..d46eed1594951 100644
--- a/drivers/pps/generators/pps_gen_parport.c
+++ b/drivers/pps/generators/pps_gen_parport.c
@@ -232,7 +232,6 @@ static struct parport_driver pps_gen_parport_driver = {
 	.name = KBUILD_MODNAME,
 	.match_port = parport_attach,
 	.detach = parport_detach,
-	.devmodel = true,
 };
 module_parport_driver(pps_gen_parport_driver);
 
diff --git a/drivers/scsi/imm.c b/drivers/scsi/imm.c
index 180a5ddedb2cd..0ad3d3e9eb308 100644
--- a/drivers/scsi/imm.c
+++ b/drivers/scsi/imm.c
@@ -1285,7 +1285,6 @@ static struct parport_driver imm_driver = {
 	.name		= "imm",
 	.match_port	= imm_attach,
 	.detach		= imm_detach,
-	.devmodel	= true,
 };
 module_parport_driver(imm_driver);
 
diff --git a/drivers/scsi/ppa.c b/drivers/scsi/ppa.c
index d592ee9170c11..9bf42e16cff77 100644
--- a/drivers/scsi/ppa.c
+++ b/drivers/scsi/ppa.c
@@ -1157,7 +1157,6 @@ static struct parport_driver ppa_driver = {
 	.name		= "ppa",
 	.match_port	= ppa_attach,
 	.detach		= ppa_detach,
-	.devmodel	= true,
 };
 module_parport_driver(ppa_driver);
 
diff --git a/drivers/spi/spi-butterfly.c b/drivers/spi/spi-butterfly.c
index 1d267e6c22a4f..84eb454ed443c 100644
--- a/drivers/spi/spi-butterfly.c
+++ b/drivers/spi/spi-butterfly.c
@@ -315,7 +315,6 @@ static struct parport_driver butterfly_driver = {
 	.name =		"spi_butterfly",
 	.match_port =	butterfly_attach,
 	.detach =	butterfly_detach,
-	.devmodel = true,
 };
 module_parport_driver(butterfly_driver);
 
diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index 3c0c24ed1f3db..e61e89b4119f4 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -318,7 +318,6 @@ static struct parport_driver spi_lm70llp_drv = {
 	.name =		DRVNAME,
 	.match_port =	spi_lm70llp_attach,
 	.detach =	spi_lm70llp_detach,
-	.devmodel =	true,
 };
 module_parport_driver(spi_lm70llp_drv);
 
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 190de3569e25c..464c2ad280396 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -256,7 +256,6 @@ struct parport_driver {
 	void (*match_port)(struct parport *);
 	int (*probe)(struct pardevice *);
 	struct device_driver driver;
-	bool devmodel;
 };
 
 #define to_parport_driver(n) container_of(n, struct parport_driver, driver)
@@ -299,9 +298,6 @@ int __must_check __parport_register_driver(struct parport_driver *,
  *	to receive notifications about ports being found in the
  *	system, as well as ports no longer available.
  *
- *	If devmodel is true then the new device model is used
- *	for registration.
- *
  *	The @driver structure is allocated by the caller and must not be
  *	deallocated until after calling parport_unregister_driver().
  *
diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index 5cfd0e99a13f5..b1b333d1cf396 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -882,7 +882,6 @@ static struct parport_driver mts64_parport_driver = {
 	.probe		= snd_mts64_dev_probe,
 	.match_port	= snd_mts64_attach,
 	.detach		= snd_mts64_detach,
-	.devmodel	= true,
 };
 
 /*********************************************************************
diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 619e3f5944772..6fd9e88700215 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -668,7 +668,6 @@ static struct parport_driver portman_parport_driver = {
 	.probe		= snd_portman_dev_probe,
 	.match_port	= snd_portman_attach,
 	.detach		= snd_portman_detach,
-	.devmodel	= true,
 };
 
 /*********************************************************************
-- 
2.44.0


