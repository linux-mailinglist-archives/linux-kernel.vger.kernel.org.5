Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32707E65A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjKIIvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjKIIvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:51:11 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E87C1FFB;
        Thu,  9 Nov 2023 00:50:59 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=06912c668f=fe@dev.tdt.de>)
        id 1r10kT-001kKT-Di; Thu, 09 Nov 2023 09:50:49 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1r10kS-00E9lP-L8; Thu, 09 Nov 2023 09:50:48 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 4DA00240040;
        Thu,  9 Nov 2023 09:50:48 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id A5738240049;
        Thu,  9 Nov 2023 09:50:47 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id D602A211D4;
        Thu,  9 Nov 2023 09:50:46 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [Patch v8 4/6] leds: ledtrig-tty: replace mutex with completion
Date:   Thu,  9 Nov 2023 09:50:36 +0100
Message-ID: <20231109085038.371977-5-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231109085038.371977-1-fe@dev.tdt.de>
References: <20231109085038.371977-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URIBL_DBL_BLOCKED_OPENDNS,
        URIBL_ZEN_BLOCKED_OPENDNS autolearn=ham autolearn_force=no
        version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1699519849-857377EA-ADE3D56F/0/0
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
 drivers/leds/trigger/ledtrig-tty.c | 60 +++++++++++++++---------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/le=
dtrig-tty.c
index 86595add72cd..3badf74fa420 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
=20
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/leds.h>
 #include <linux/module.h>
@@ -12,15 +13,24 @@
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
+static int ledtrig_tty_waitforcompletion(struct device *dev)
 {
-	schedule_delayed_work(&trigger_data->dwork, 0);
+	struct ledtrig_tty_data *trigger_data =3D led_trigger_get_drvdata(dev);
+	int ret;
+
+	ret =3D wait_for_completion_timeout(&trigger_data->sysfs,
+					  msecs_to_jiffies(LEDTRIG_TTY_INTERVAL * 20));
+
+	if (ret =3D=3D 0)
+		return -ETIMEDOUT;
+
+	return ret;
 }
=20
 static ssize_t ttyname_show(struct device *dev,
@@ -28,14 +38,16 @@ static ssize_t ttyname_show(struct device *dev,
 {
 	struct ledtrig_tty_data *trigger_data =3D led_trigger_get_drvdata(dev);
 	ssize_t len =3D 0;
+	int completion;
=20
-	mutex_lock(&trigger_data->mutex);
+	reinit_completion(&trigger_data->sysfs);
+	completion =3D ledtrig_tty_waitforcompletion(dev);
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
@@ -46,7 +58,7 @@ static ssize_t ttyname_store(struct device *dev,
 	struct ledtrig_tty_data *trigger_data =3D led_trigger_get_drvdata(dev);
 	char *ttyname;
 	ssize_t ret =3D size;
-	bool running;
+	int completion;
=20
 	if (size > 0 && buf[size - 1] =3D=3D '\n')
 		size -=3D 1;
@@ -59,9 +71,10 @@ static ssize_t ttyname_store(struct device *dev,
 		ttyname =3D NULL;
 	}
=20
-	mutex_lock(&trigger_data->mutex);
-
-	running =3D trigger_data->ttyname !=3D NULL;
+	reinit_completion(&trigger_data->sysfs);
+	completion =3D ledtrig_tty_waitforcompletion(dev);
+	if (completion < 0)
+		return completion;
=20
 	kfree(trigger_data->ttyname);
 	tty_kref_put(trigger_data->tty);
@@ -69,11 +82,6 @@ static ssize_t ttyname_store(struct device *dev,
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
@@ -86,13 +94,8 @@ static void ledtrig_tty_work(struct work_struct *work)
 	struct led_classdev *led_cdev =3D trigger_data->led_cdev;
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
@@ -117,11 +120,8 @@ static void ledtrig_tty_work(struct work_struct *wor=
k)
 	}
=20
 	ret =3D tty_get_icount(trigger_data->tty, &icount);
-	if (ret) {
-		dev_warn(led_cdev->dev, "Failed to get icount, stop polling\n");
-		mutex_unlock(&trigger_data->mutex);
-		return;
-	}
+	if (ret)
+		goto out;
=20
 	if (icount.rx !=3D trigger_data->rx ||
 	    icount.tx !=3D trigger_data->tx) {
@@ -134,7 +134,7 @@ static void ledtrig_tty_work(struct work_struct *work=
)
 	}
=20
 out:
-	mutex_unlock(&trigger_data->mutex);
+	complete_all(&trigger_data->sysfs);
 	schedule_delayed_work(&trigger_data->dwork,
 			      msecs_to_jiffies(LEDTRIG_TTY_INTERVAL * 2));
 }
@@ -157,7 +157,9 @@ static int ledtrig_tty_activate(struct led_classdev *=
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

