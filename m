Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5667E65AB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjKIIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjKIIvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:51:12 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA642D65;
        Thu,  9 Nov 2023 00:51:02 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=06912c668f=fe@dev.tdt.de>)
        id 1r10kV-00E9my-C2; Thu, 09 Nov 2023 09:50:51 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1r10kU-001kLD-ID; Thu, 09 Nov 2023 09:50:50 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 26D7B240040;
        Thu,  9 Nov 2023 09:50:50 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 7A8A3240049;
        Thu,  9 Nov 2023 09:50:49 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 86941211D4;
        Thu,  9 Nov 2023 09:50:48 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [Patch v8 6/6] leds: ledtrig-tty: add additional line state evaluation
Date:   Thu,  9 Nov 2023 09:50:38 +0100
Message-ID: <20231109085038.371977-7-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231109085038.371977-1-fe@dev.tdt.de>
References: <20231109085038.371977-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        URIBL_DBL_BLOCKED_OPENDNS,URIBL_ZEN_BLOCKED_OPENDNS autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1699519851-CE6F33D8-1C4D7CE9/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The serial tty interface also supports additional input signals, that
can also be evaluated within this trigger. This change is adding the
following additional input sources, which could be controlled
via the '/sys/class/<leds>/' sysfs interface.

Explanation:
DCE =3D Data Communication Equipment (Modem)
DTE =3D Data Terminal Equipment (Computer)

- cts:
  DCE is ready to accept data from the DTE (CTS =3D Clear To Send). If
  the line state is detected, the LED is switched on.
  If set to 0 (default), the LED will not evaluate CTS.
  If set to 1, the LED will evaluate CTS.

- dsr:
  DCE is ready to receive and send data (DSR =3D Data Set Ready). If the
  line state is detected, the LED is switched on.
  If set to 0 (default), the LED will not evaluate DSR.
  If set to 1, the LED will evaluate DSR.

- dcd:
  DTE is receiving a carrier from the DCE (DCD =3D Data Carrier Detect).
  If the line state is detected, the LED is switched on.
  If set to 0 (default), the LED will not evaluate DCD.
  If set to 1, the LED will evaluate DCD.

- rng:
  DCE has detected an incoming ring signal on the telephone line
  (RNG =3D Ring Indicator). If the line state is detected, the LED is
  switched on.
  If set to 0 (default), the LED will not evaluate RNG.
  If set to 1, the LED will evaluate RNG.

Also add an invert flag on LED blink, so that the LED blinks in the
correct order.

* If one off the new enabled input signals are evaluatet as 'enabled',
  and data are transmitted, then the LED should first blink 'off' and
  then 'on' (invert).
* If all the new enabled input signals are evaluatet as 'disabled',
  and data are transmitted, then the LED should first blink 'on' and
  then 'off'.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 .../ABI/testing/sysfs-class-led-trigger-tty   | 40 ++++++++++
 drivers/leds/trigger/ledtrig-tty.c            | 77 ++++++++++++++++++-
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-tty b/Docu=
mentation/ABI/testing/sysfs-class-led-trigger-tty
index 504dece151b8..30cef9ac0f49 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-tty
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
@@ -20,3 +20,43 @@ Description:
 		Signal transmission (tx) of data on the named tty device.
 		If set to 0, the LED will not blink on transmission.
 		If set to 1 (default), the LED will blink on transmission.
+
+What:		/sys/class/leds/<led>/cts
+Date:		February 2024
+KernelVersion:	6.8
+Description:
+		CTS =3D Clear To Send
+		DCE is ready to accept data from the DTE.
+		If the line state is detected, the LED is switched on.
+		If set to 0 (default), the LED will not evaluate CTS.
+		If set to 1, the LED will evaluate CTS.
+
+What:		/sys/class/leds/<led>/dsr
+Date:		February 2024
+KernelVersion:	6.8
+Description:
+		DSR =3D Data Set Ready
+		DCE is ready to receive and send data.
+		If the line state is detected, the LED is switched on.
+		If set to 0 (default), the LED will not evaluate DSR.
+		If set to 1, the LED will evaluate DSR.
+
+What:		/sys/class/leds/<led>/dcd
+Date:		February 2024
+KernelVersion:	6.8
+Description:
+		DCD =3D Data Carrier Detect
+		DTE is receiving a carrier from the DCE.
+		If the line state is detected, the LED is switched on.
+		If set to 0 (default), the LED will not evaluate CAR (DCD).
+		If set to 1, the LED will evaluate CAR (DCD).
+
+What:		/sys/class/leds/<led>/rng
+Date:		February 2024
+KernelVersion:	6.8
+Description:
+		RNG =3D Ring Indicator
+		DCE has detected an incoming ring signal on the telephone
+		line. If the line state is detected, the LED is switched on.
+		If set to 0 (default), the LED will not evaluate RNG.
+		If set to 1, the LED will evaluate RNG.
diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/le=
dtrig-tty.c
index 1a40a78bf1ee..7291b2d970c6 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -19,17 +19,26 @@ struct ledtrig_tty_data {
 	int rx, tx;
 	bool mode_rx;
 	bool mode_tx;
+	bool mode_cts;
+	bool mode_dsr;
+	bool mode_dcd;
+	bool mode_rng;
 };
=20
 /* Indicates which state the LED should now display */
 enum led_trigger_tty_state {
 	TTY_LED_BLINK,
+	TTY_LED_ENABLE,
 	TTY_LED_DISABLE,
 };
=20
 enum led_trigger_tty_modes {
 	TRIGGER_TTY_RX =3D 0,
 	TRIGGER_TTY_TX,
+	TRIGGER_TTY_CTS,
+	TRIGGER_TTY_DSR,
+	TRIGGER_TTY_DCD,
+	TRIGGER_TTY_RNG,
 };
=20
 static int ledtrig_tty_waitforcompletion(struct device *dev)
@@ -118,6 +127,18 @@ static ssize_t ledtrig_tty_attr_show(struct device *=
dev, char *buf,
 	case TRIGGER_TTY_TX:
 		state =3D trigger_data->mode_tx;
 		break;
+	case TRIGGER_TTY_CTS:
+		state =3D trigger_data->mode_cts;
+		break;
+	case TRIGGER_TTY_DSR:
+		state =3D trigger_data->mode_dsr;
+		break;
+	case TRIGGER_TTY_DCD:
+		state =3D trigger_data->mode_dcd;
+		break;
+	case TRIGGER_TTY_RNG:
+		state =3D trigger_data->mode_rng;
+		break;
 	}
=20
 	return sysfs_emit(buf, "%u\n", state);
@@ -147,6 +168,18 @@ static ssize_t ledtrig_tty_attr_store(struct device =
*dev, const char *buf,
 	case TRIGGER_TTY_TX:
 		trigger_data->mode_tx =3D state;
 		break;
+	case TRIGGER_TTY_CTS:
+		trigger_data->mode_cts =3D state;
+		break;
+	case TRIGGER_TTY_DSR:
+		trigger_data->mode_dsr =3D state;
+		break;
+	case TRIGGER_TTY_DCD:
+		trigger_data->mode_dcd =3D state;
+		break;
+	case TRIGGER_TTY_RNG:
+		trigger_data->mode_rng =3D state;
+		break;
 	}
=20
 	return size;
@@ -167,6 +200,10 @@ static ssize_t ledtrig_tty_attr_store(struct device =
*dev, const char *buf,
=20
 DEFINE_TTY_TRIGGER(rx, TRIGGER_TTY_RX);
 DEFINE_TTY_TRIGGER(tx, TRIGGER_TTY_TX);
+DEFINE_TTY_TRIGGER(cts, TRIGGER_TTY_CTS);
+DEFINE_TTY_TRIGGER(dsr, TRIGGER_TTY_DSR);
+DEFINE_TTY_TRIGGER(dcd, TRIGGER_TTY_DCD);
+DEFINE_TTY_TRIGGER(rng, TRIGGER_TTY_RNG);
=20
 static void ledtrig_tty_work(struct work_struct *work)
 {
@@ -175,6 +212,8 @@ static void ledtrig_tty_work(struct work_struct *work=
)
 	struct led_classdev *led_cdev =3D trigger_data->led_cdev;
 	enum led_trigger_tty_state state =3D TTY_LED_DISABLE;
 	unsigned long interval =3D LEDTRIG_TTY_INTERVAL;
+	bool invert =3D false;
+	int status;
 	int ret;
=20
 	if (!trigger_data->ttyname)
@@ -202,6 +241,33 @@ static void ledtrig_tty_work(struct work_struct *wor=
k)
 		trigger_data->tty =3D tty;
 	}
=20
+	status =3D tty_get_tiocm(trigger_data->tty);
+	if (status > 0) {
+		if (trigger_data->mode_cts) {
+			if (status & TIOCM_CTS)
+				state =3D TTY_LED_ENABLE;
+		}
+
+		if (trigger_data->mode_dsr) {
+			if (status & TIOCM_DSR)
+				state =3D TTY_LED_ENABLE;
+		}
+
+		if (trigger_data->mode_dcd) {
+			if (status & TIOCM_CAR)
+				state =3D TTY_LED_ENABLE;
+		}
+
+		if (trigger_data->mode_rng) {
+			if (status & TIOCM_RNG)
+				state =3D TTY_LED_ENABLE;
+		}
+	}
+
+	/*
+	 * The evaluation of rx/tx must be done after the evaluation
+	 * of TIOCM_*, because rx/tx has priority.
+	 */
 	if (trigger_data->mode_rx || trigger_data->mode_tx) {
 		struct serial_icounter_struct icount;
=20
@@ -211,11 +277,13 @@ static void ledtrig_tty_work(struct work_struct *wo=
rk)
=20
 		if (trigger_data->mode_tx && (icount.tx !=3D trigger_data->tx)) {
 			trigger_data->tx =3D icount.tx;
+			invert =3D state =3D=3D TTY_LED_ENABLE;
 			state =3D TTY_LED_BLINK;
 		}
=20
 		if (trigger_data->mode_rx && (icount.rx !=3D trigger_data->rx)) {
 			trigger_data->rx =3D icount.rx;
+			invert =3D state =3D=3D TTY_LED_ENABLE;
 			state =3D TTY_LED_BLINK;
 		}
 	}
@@ -223,7 +291,10 @@ static void ledtrig_tty_work(struct work_struct *wor=
k)
 out:
 	switch (state) {
 	case TTY_LED_BLINK:
-		led_blink_set_oneshot(led_cdev, &interval, &interval, 0);
+		led_blink_set_oneshot(led_cdev, &interval, &interval, invert);
+		break;
+	case TTY_LED_ENABLE:
+		led_set_brightness(led_cdev, led_cdev->blink_brightness);
 		break;
 	case TTY_LED_DISABLE:
 		fallthrough;
@@ -241,6 +312,10 @@ static struct attribute *ledtrig_tty_attrs[] =3D {
 	&dev_attr_ttyname.attr,
 	&dev_attr_rx.attr,
 	&dev_attr_tx.attr,
+	&dev_attr_cts.attr,
+	&dev_attr_dsr.attr,
+	&dev_attr_dcd.attr,
+	&dev_attr_rng.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(ledtrig_tty);
--=20
2.30.2

