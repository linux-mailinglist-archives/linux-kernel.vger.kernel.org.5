Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AE180EA30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346349AbjLLLRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346323AbjLLLRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:17:23 -0500
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F156BE8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:17:24 -0800 (PST)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
        by mx0.infotecs.ru (Postfix) with ESMTP id C40CF12012AD;
        Tue, 12 Dec 2023 14:17:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru C40CF12012AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
        t=1702379842; bh=zI2gWSJaikJQQTNYhl9y8i2BycI4SSfJAtCWPehw3t4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=sWtVXkhytZVPVCz6YZf5pTlqRT5Dy82//QV2B4RwaTMQ9DIRHTl7rqRde8H/kTFiK
         Sm1aMsnQeZCeupp7HYXtxi815HRoahuzU7Z+ddeisMSGWmCLdQ+lOB547nq4Sd0FVG
         Wo973aXgo7QanfsQRYckA3ILnfmnuAJRy1WqtpFM=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
        by mx0.infotecs-nt (Postfix) with ESMTP id C205D316AAFE;
        Tue, 12 Dec 2023 14:17:21 +0300 (MSK)
From:   Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Daniel Starke <daniel.starke@siemens.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russ Gorby <russ.gorby@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH 5.10 1/3] tty: n_gsm: fix tty registration before control
 channel open
Thread-Topic: [PATCH 5.10 1/3] tty: n_gsm: fix tty registration before control
 channel open
Thread-Index: AQHaLOzGya5kVhAh/kSEVoCyWeJ41A==
Date:   Tue, 12 Dec 2023 11:17:21 +0000
Message-ID: <20231212111431.4064760-2-Ilia.Gavrilov@infotecs.ru>
References: <20231212111431.4064760-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20231212111431.4064760-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/12/12 08:32:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/12/12 02:27:00 #22664189
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

commit 01aecd917114577c423f07cec0d186ad007d76fc upstream.

The current implementation registers/deregisters the user ttys at mux
attach/detach. That means that the user devices are available before any
control channel is open. However, user channel initialization requires an
open control channel. Furthermore, the user is not informed if the mux
restarts due to configuration changes.
Put the registration/deregistration procedure into separate function to
improve readability.
Move registration to mux activation and deregistration to mux cleanup to
keep the user devices only open as long as a control channel exists. The
user will be informed via the device driver if the mux was reconfigured in
a way that required a mux re-activation.
This makes it necessary to add T2 initialization to gsmld_open() for the
ldisc open code path (not the reconfiguration code path) to avoid deletion
of an uninitialized T2 at mux cleanup.

Fixes: d50f6dcaf22a ("tty: n_gsm: expose gsmtty device nodes at ldisc open =
time")
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
Link: https://lore.kernel.org/r/20220701061652.39604-2-daniel.starke@siemen=
s.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
 drivers/tty/n_gsm.c | 117 ++++++++++++++++++++++++++++++--------------
 1 file changed, 79 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 3693ad9f4521..7a883a2c0c50 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -235,6 +235,7 @@ struct gsm_mux {
 	struct gsm_dlci *dlci[NUM_DLCI];
 	int old_c_iflag;		/* termios c_iflag value before attach */
 	bool constipated;		/* Asked by remote to shut up */
+	bool has_devices;		/* Devices were registered */
=20
 	spinlock_t tx_lock;
 	unsigned int tx_bytes;		/* TX data outstanding */
@@ -464,6 +465,68 @@ static u8 gsm_encode_modem(const struct gsm_dlci *dlci=
)
 	return modembits;
 }
=20
+/**
+ *	gsm_register_devices	-	register all tty devices for a given mux index
+ *
+ *	@driver: the tty driver that describes the tty devices
+ *	@index:  the mux number is used to calculate the minor numbers of the
+ *	         ttys for this mux and may differ from the position in the
+ *	         mux array.
+ */
+static int gsm_register_devices(struct tty_driver *driver, unsigned int in=
dex)
+{
+	struct device *dev;
+	int i;
+	unsigned int base;
+
+	if (!driver || index >=3D MAX_MUX)
+		return -EINVAL;
+
+	base =3D index * NUM_DLCI; /* first minor for this index */
+	for (i =3D 1; i < NUM_DLCI; i++) {
+		/* Don't register device 0 - this is the control channel
+		 * and not a usable tty interface
+		 */
+		dev =3D tty_register_device(gsm_tty_driver, base + i, NULL);
+		if (IS_ERR(dev)) {
+			if (debug & 8)
+				pr_info("%s failed to register device minor %u",
+					__func__, base + i);
+			for (i--; i >=3D 1; i--)
+				tty_unregister_device(gsm_tty_driver, base + i);
+			return PTR_ERR(dev);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ *	gsm_unregister_devices	-	unregister all tty devices for a given mux ind=
ex
+ *
+ *	@driver: the tty driver that describes the tty devices
+ *	@index:  the mux number is used to calculate the minor numbers of the
+ *	         ttys for this mux and may differ from the position in the
+ *	         mux array.
+ */
+static void gsm_unregister_devices(struct tty_driver *driver,
+				   unsigned int index)
+{
+	int i;
+	unsigned int base;
+
+	if (!driver || index >=3D MAX_MUX)
+		return;
+
+	base =3D index * NUM_DLCI; /* first minor for this index */
+	for (i =3D 1; i < NUM_DLCI; i++) {
+		/* Don't unregister device 0 - this is the control
+		 * channel and not a usable tty interface
+		 */
+		tty_unregister_device(gsm_tty_driver, base + i);
+	}
+}
+
 /**
  *	gsm_print_packet	-	display a frame for debug
  *	@hdr: header to print before decode
@@ -2178,6 +2241,10 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, boo=
l disc)
 	del_timer_sync(&gsm->t2_timer);
=20
 	/* Free up any link layer users and finally the control channel */
+	if (gsm->has_devices) {
+		gsm_unregister_devices(gsm_tty_driver, gsm->num);
+		gsm->has_devices =3D false;
+	}
 	for (i =3D NUM_DLCI - 1; i >=3D 0; i--)
 		if (gsm->dlci[i])
 			gsm_dlci_release(gsm->dlci[i]);
@@ -2201,15 +2268,21 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bo=
ol disc)
 static int gsm_activate_mux(struct gsm_mux *gsm)
 {
 	struct gsm_dlci *dlci;
+	int ret;
=20
 	if (gsm->encoding =3D=3D 0)
 		gsm->receive =3D gsm0_receive;
 	else
 		gsm->receive =3D gsm1_receive;
=20
+	ret =3D gsm_register_devices(gsm_tty_driver, gsm->num);
+	if (ret)
+		return ret;
+
 	dlci =3D gsm_dlci_alloc(gsm, 0);
 	if (dlci =3D=3D NULL)
 		return -ENOMEM;
+	gsm->has_devices =3D true;
 	gsm->dead =3D false;		/* Tty opens are now permissible */
 	return 0;
 }
@@ -2475,39 +2548,14 @@ static int gsmld_output(struct gsm_mux *gsm, u8 *da=
ta, int len)
  *	will need moving to an ioctl path.
  */
=20
-static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
+static void gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 {
-	unsigned int base;
-	int ret, i;
-
 	gsm->tty =3D tty_kref_get(tty);
 	/* Turn off tty XON/XOFF handling to handle it explicitly. */
 	gsm->old_c_iflag =3D tty->termios.c_iflag;
 	tty->termios.c_iflag &=3D (IXON | IXOFF);
-	ret =3D  gsm_activate_mux(gsm);
-	if (ret !=3D 0)
-		tty_kref_put(gsm->tty);
-	else {
-		/* Don't register device 0 - this is the control channel and not
-		   a usable tty interface */
-		base =3D mux_num_to_base(gsm); /* Base for this MUX */
-		for (i =3D 1; i < NUM_DLCI; i++) {
-			struct device *dev;
-
-			dev =3D tty_register_device(gsm_tty_driver,
-							base + i, NULL);
-			if (IS_ERR(dev)) {
-				for (i--; i >=3D 1; i--)
-					tty_unregister_device(gsm_tty_driver,
-								base + i);
-				return PTR_ERR(dev);
-			}
-		}
-	}
-	return ret;
 }
=20
-
 /**
  *	gsmld_detach_gsm	-	stop doing 0710 mux
  *	@tty: tty attached to the mux
@@ -2518,12 +2566,7 @@ static int gsmld_attach_gsm(struct tty_struct *tty, =
struct gsm_mux *gsm)
=20
 static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 {
-	unsigned int base =3D mux_num_to_base(gsm); /* Base for this MUX */
-	int i;
-
 	WARN_ON(tty !=3D gsm->tty);
-	for (i =3D 1; i < NUM_DLCI; i++)
-		tty_unregister_device(gsm_tty_driver, base + i);
 	/* Restore tty XON/XOFF handling. */
 	gsm->tty->termios.c_iflag =3D gsm->old_c_iflag;
 	tty_kref_put(gsm->tty);
@@ -2619,7 +2662,6 @@ static void gsmld_close(struct tty_struct *tty)
 static int gsmld_open(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm;
-	int ret;
=20
 	if (tty->ops->write =3D=3D NULL)
 		return -EINVAL;
@@ -2635,12 +2677,11 @@ static int gsmld_open(struct tty_struct *tty)
 	/* Attach the initial passive connection */
 	gsm->encoding =3D 1;
=20
-	ret =3D gsmld_attach_gsm(tty, gsm);
-	if (ret !=3D 0) {
-		gsm_cleanup_mux(gsm, false);
-		mux_put(gsm);
-	}
-	return ret;
+	gsmld_attach_gsm(tty, gsm);
+
+	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
+
+	return 0;
 }
=20
 /**
--=20
2.39.2
