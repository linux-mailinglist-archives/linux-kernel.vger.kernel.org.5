Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4057E7E21C5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjKFMe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjKFMen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:34:43 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FBCB8;
        Mon,  6 Nov 2023 04:34:40 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=068806c1c2=fe@dev.tdt.de>)
        id 1qzyoI-00GOQ2-BU; Mon, 06 Nov 2023 13:34:30 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qzyoH-00HTxV-HT; Mon, 06 Nov 2023 13:34:29 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 23098240049;
        Mon,  6 Nov 2023 13:34:29 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 773AC240040;
        Mon,  6 Nov 2023 13:34:28 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id F3E8D2225B;
        Mon,  6 Nov 2023 13:34:27 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [Patch v7 6/6] leds: ledtrig-tty: add additional line state evaluation
Date:   Mon,  6 Nov 2023 13:34:15 +0100
Message-ID: <20231106123415.3365732-7-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231106123415.3365732-1-fe@dev.tdt.de>
References: <20231106123415.3365732-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1699274070-07E026AA-7D4B33CC/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The serial tty interface also supports additional input signals,that
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

Add an invert flag on LED blink, so that the LED blinks in the correct or=
der.
* LED was 'on' in the previous round, then it should first go 'off' and
  then 'on' again when it should blink (data has been transferred).
* LED was 'off' in the previous round, then it should first go 'on' and
  then 'off' again when it should blink (data has been transferred).

In order to also evaluate the LED 'state' form the previous round, so we
could blink in the correct order, the 'state' must be saved in the trigge=
r
data struct.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 .../ABI/testing/sysfs-class-led-trigger-tty   | 40 ++++++++
 drivers/leds/trigger/ledtrig-tty.c            | 91 ++++++++++++++++++-
 2 files changed, 126 insertions(+), 5 deletions(-)

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
index 1a40a78bf1ee..107fbbca96de 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -17,19 +17,29 @@ struct ledtrig_tty_data {
 	const char *ttyname;
 	struct tty_struct *tty;
 	int rx, tx;
+	int state;
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
@@ -118,6 +128,18 @@ static ssize_t ledtrig_tty_attr_show(struct device *=
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
@@ -147,6 +169,18 @@ static ssize_t ledtrig_tty_attr_store(struct device =
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
@@ -167,16 +201,27 @@ static ssize_t ledtrig_tty_attr_store(struct device=
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
 	struct ledtrig_tty_data *trigger_data =3D
 		container_of(work, struct ledtrig_tty_data, dwork.work);
 	struct led_classdev *led_cdev =3D trigger_data->led_cdev;
-	enum led_trigger_tty_state state =3D TTY_LED_DISABLE;
 	unsigned long interval =3D LEDTRIG_TTY_INTERVAL;
+	int invert =3D 0;
+	int status;
 	int ret;
=20
+	if (trigger_data->state =3D=3D TTY_LED_ENABLE)
+		invert =3D 1;
+
+	/* Always disable the LED if no evaluation could be done */
+	trigger_data->state =3D TTY_LED_DISABLE;
+
 	if (!trigger_data->ttyname)
 		goto out;
=20
@@ -202,6 +247,33 @@ static void ledtrig_tty_work(struct work_struct *wor=
k)
 		trigger_data->tty =3D tty;
 	}
=20
+	status =3D tty_get_tiocm(trigger_data->tty);
+	if (status > 0) {
+		if (trigger_data->mode_cts) {
+			if (status & TIOCM_CTS)
+				trigger_data->state =3D TTY_LED_ENABLE;
+		}
+
+		if (trigger_data->mode_dsr) {
+			if (status & TIOCM_DSR)
+				trigger_data->state =3D TTY_LED_ENABLE;
+		}
+
+		if (trigger_data->mode_dcd) {
+			if (status & TIOCM_CAR)
+				trigger_data->state =3D TTY_LED_ENABLE;
+		}
+
+		if (trigger_data->mode_rng) {
+			if (status & TIOCM_RNG)
+				trigger_data->state =3D TTY_LED_ENABLE;
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
@@ -211,19 +283,22 @@ static void ledtrig_tty_work(struct work_struct *wo=
rk)
=20
 		if (trigger_data->mode_tx && (icount.tx !=3D trigger_data->tx)) {
 			trigger_data->tx =3D icount.tx;
-			state =3D TTY_LED_BLINK;
+			trigger_data->state =3D TTY_LED_BLINK;
 		}
=20
 		if (trigger_data->mode_rx && (icount.rx !=3D trigger_data->rx)) {
 			trigger_data->rx =3D icount.rx;
-			state =3D TTY_LED_BLINK;
+			trigger_data->state =3D TTY_LED_BLINK;
 		}
 	}
=20
 out:
-	switch (state) {
+	switch (trigger_data->state) {
 	case TTY_LED_BLINK:
-		led_blink_set_oneshot(led_cdev, &interval, &interval, 0);
+		led_blink_set_oneshot(led_cdev, &interval, &interval, invert);
+		break;
+	case TTY_LED_ENABLE:
+		led_set_brightness(led_cdev, led_cdev->blink_brightness);
 		break;
 	case TTY_LED_DISABLE:
 		fallthrough;
@@ -241,6 +316,10 @@ static struct attribute *ledtrig_tty_attrs[] =3D {
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
@@ -257,6 +336,8 @@ static int ledtrig_tty_activate(struct led_classdev *=
led_cdev)
 	trigger_data->mode_rx =3D true;
 	trigger_data->mode_tx =3D true;
=20
+	trigger_data->state =3D TTY_LED_DISABLE;
+
 	led_set_trigger_data(led_cdev, trigger_data);
=20
 	INIT_DELAYED_WORK(&trigger_data->dwork, ledtrig_tty_work);
--=20
2.30.2

