Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54077F9E18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjK0LDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjK0LDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:03:19 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF2B113;
        Mon, 27 Nov 2023 03:03:24 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=1709d64187=fe@dev.tdt.de>)
        id 1r7ZOZ-00HQdp-2E; Mon, 27 Nov 2023 12:03:19 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1r7ZOY-000Ydh-C2; Mon, 27 Nov 2023 12:03:18 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 00E4724004D;
        Mon, 27 Nov 2023 12:03:18 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 6BFFE240040;
        Mon, 27 Nov 2023 12:03:17 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 2512E33D8E;
        Mon, 27 Nov 2023 12:03:17 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, gregkh@linuxfoundation.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v9 2/4] leds: ledtrig-tty: replace mutex with completion
Date:   Mon, 27 Nov 2023 12:03:09 +0100
Message-ID: <20231127110311.3583957-3-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127110311.3583957-1-fe@dev.tdt.de>
References: <20231127110311.3583957-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1701082999-65079C7C-1C077096/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this commit, the mutex handling is replaced by the completion
handling. When handling mutex, it must always be ensured that the held
mutex is also released again. This is more error-prone should the number
of code paths increase.

This is a preparatory commit to make the trigger more configurable via
additional sysfs parameters. With this change, the worker always runs and
is no longer stopped if no ttyname is set.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/leds/trigger/ledtrig-tty.c | 59 +++++++++++++++---------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/le=
dtrig-tty.c
index 8ae0d2d284af..0d73bec1529f 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
=20
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/leds.h>
 #include <linux/module.h>
@@ -12,15 +13,23 @@
 struct ledtrig_tty_data {
 	struct led_classdev *led_cdev;
 	struct delayed_work dwork;
-	struct mutex mutex;
+	struct completion sysfs;
 	const char *ttyname;
 	struct tty_struct *tty;
 	int rx, tx;
 };
=20
-static void ledtrig_tty_restart(struct ledtrig_tty_data *trigger_data)
+static int ledtrig_tty_wait_for_completion(struct device *dev)
 {
-	schedule_delayed_work(&trigger_data->dwork, 0);
+	struct ledtrig_tty_data *trigger_data =3D led_trigger_get_drvdata(dev);
+	int ret;
+
+	ret =3D wait_for_completion_timeout(&trigger_data->sysfs,
+					  msecs_to_jiffies(LEDTRIG_TTY_INTERVAL * 20));
+	if (ret =3D=3D 0)
+		return -ETIMEDOUT;
+
+	return ret;
 }
=20
 static ssize_t ttyname_show(struct device *dev,
@@ -28,14 +37,16 @@ static ssize_t ttyname_show(struct device *dev,
 {
 	struct ledtrig_tty_data *trigger_data =3D led_trigger_get_drvdata(dev);
 	ssize_t len =3D 0;
+	int completion;
=20
-	mutex_lock(&trigger_data->mutex);
+	reinit_completion(&trigger_data->sysfs);
+	completion =3D ledtrig_tty_wait_for_completion(dev);
+	if (completion < 0)
+		return completion;
=20
 	if (trigger_data->ttyname)
 		len =3D sprintf(buf, "%s\n", trigger_data->ttyname);
=20
-	mutex_unlock(&trigger_data->mutex);
-
 	return len;
 }
=20
@@ -46,7 +57,7 @@ static ssize_t ttyname_store(struct device *dev,
 	struct ledtrig_tty_data *trigger_data =3D led_trigger_get_drvdata(dev);
 	char *ttyname;
 	ssize_t ret =3D size;
-	bool running;
+	int completion;
=20
 	if (size > 0 && buf[size - 1] =3D=3D '\n')
 		size -=3D 1;
@@ -59,9 +70,10 @@ static ssize_t ttyname_store(struct device *dev,
 		ttyname =3D NULL;
 	}
=20
-	mutex_lock(&trigger_data->mutex);
-
-	running =3D trigger_data->ttyname !=3D NULL;
+	reinit_completion(&trigger_data->sysfs);
+	completion =3D ledtrig_tty_wait_for_completion(dev);
+	if (completion < 0)
+		return completion;
=20
 	kfree(trigger_data->ttyname);
 	tty_kref_put(trigger_data->tty);
@@ -69,11 +81,6 @@ static ssize_t ttyname_store(struct device *dev,
=20
 	trigger_data->ttyname =3D ttyname;
=20
-	mutex_unlock(&trigger_data->mutex);
-
-	if (ttyname && !running)
-		ledtrig_tty_restart(trigger_data);
-
 	return ret;
 }
 static DEVICE_ATTR_RW(ttyname);
@@ -85,13 +92,8 @@ static void ledtrig_tty_work(struct work_struct *work)
 	struct serial_icounter_struct icount;
 	int ret;
=20
-	mutex_lock(&trigger_data->mutex);
-
-	if (!trigger_data->ttyname) {
-		/* exit without rescheduling */
-		mutex_unlock(&trigger_data->mutex);
-		return;
-	}
+	if (!trigger_data->ttyname)
+		goto out;
=20
 	/* try to get the tty corresponding to $ttyname */
 	if (!trigger_data->tty) {
@@ -116,11 +118,8 @@ static void ledtrig_tty_work(struct work_struct *wor=
k)
 	}
=20
 	ret =3D tty_get_icount(trigger_data->tty, &icount);
-	if (ret) {
-		dev_info(trigger_data->tty->dev, "Failed to get icount, stopped pollin=
g\n");
-		mutex_unlock(&trigger_data->mutex);
-		return;
-	}
+	if (ret)
+		goto out;
=20
 	if (icount.rx !=3D trigger_data->rx ||
 	    icount.tx !=3D trigger_data->tx) {
@@ -134,7 +133,7 @@ static void ledtrig_tty_work(struct work_struct *work=
)
 	}
=20
 out:
-	mutex_unlock(&trigger_data->mutex);
+	complete_all(&trigger_data->sysfs);
 	schedule_delayed_work(&trigger_data->dwork,
 			      msecs_to_jiffies(LEDTRIG_TTY_INTERVAL * 2));
 }
@@ -157,7 +156,9 @@ static int ledtrig_tty_activate(struct led_classdev *=
led_cdev)
=20
 	INIT_DELAYED_WORK(&trigger_data->dwork, ledtrig_tty_work);
 	trigger_data->led_cdev =3D led_cdev;
-	mutex_init(&trigger_data->mutex);
+	init_completion(&trigger_data->sysfs);
+
+	schedule_delayed_work(&trigger_data->dwork, 0);
=20
 	return 0;
 }
--=20
2.30.2

