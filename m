Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63577CF6C8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345386AbjJSL2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345376AbjJSL2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:28:32 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC974115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:28:28 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9670043017=fe@dev.tdt.de>)
        id 1qtRCL-00GiF0-C0; Thu, 19 Oct 2023 13:28:17 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qtRCK-00CHK1-GV; Thu, 19 Oct 2023 13:28:16 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 0ABF5240040;
        Thu, 19 Oct 2023 13:28:16 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 5ADDB240049;
        Thu, 19 Oct 2023 13:28:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id C42B0214C3;
        Thu, 19 Oct 2023 13:28:14 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        ansuelsmth@gmail.com, m.brock@vanmierlo.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v4 3/3] leds: ledtrig-tty: add new line mode evaluation
Date:   Thu, 19 Oct 2023 13:28:09 +0200
Message-ID: <20231019112809.881730-4-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231019112809.881730-1-fe@dev.tdt.de>
References: <20231019112809.881730-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate-ID: 151534::1697714897-CEEF23D8-6E0C60A0/0/0
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, the LED blinks when data is sent via the tty (rx/tx).
The serial tty interface also supports additional input signals, that can
also be evaluated within this trigger. This change is adding the followin=
g
additional input sources, which could be controlled
via the '/sys/class/<leds>/' sysfs interface.

- line_cts:
  DCE is ready to accept data from the DTE (CTS =3D Clear To  Send). If t=
he
  line state is detected, the LED is switched on.
  If set to 0 (default), the LED will not evaluate CTS.
  If set to 1, the LED will evaluate CTS.

- line_dsr:
  DCE is ready to receive and send data (DSR =3D Data Set Ready). If the =
line
  state is detected, the LED is switched on.
  If set to 0 (default), the LED will not evaluate DSR.
  If set to 1, the LED will evaluate DSR.

- line_car:
  DTE is receiving a carrier from the DCE (DCD =3D Data Carrier Detect). =
If
  the line state is detected, the LED is switched on.
  If set to 0 (default), the LED will not evaluate CAR (DCD).
  If set to 1, the LED will evaluate CAR (DCD).

- line_rng:
  DCE has detected an incoming ring signal on the telephone line
  (RI =3D Ring Indicator). If the line state is detected, the LED is
  switched on.
  If set to 0 (default), the LED will not evaluate RNG (RI).
  If set to 1, the LED will evaluate RNG (RI).

Explanation:
DCE =3D Data Communication Equipment (Modem)
DTE =3D Data Terminal Equipment (Computer)

In addition to the new line_* entries in sysfs, the indication for the
direction of the transmitted data is independently controllable via the
new rx and tx sysfs entrie now too. These are on by default. Thus the
trigger behaves as before this change.

- rx:
  Signal reception (rx) of data on the named tty device.
  If set to 0, the LED will not blink on reception.
  If set to 1 (default), the LED will blink on reception.

- tx:
  Signal transmission (tx) of data on the named tty device.
  If set to 0, the LED will not blink on transmission.
  If set to 1 (default), the LED will blink on transmission.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 .../ABI/testing/sysfs-class-led-trigger-tty   |  54 +++++
 drivers/leds/trigger/ledtrig-tty.c            | 192 +++++++++++++++++-
 2 files changed, 235 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-tty b/Docu=
mentation/ABI/testing/sysfs-class-led-trigger-tty
index 2bf6b24e781b..08127b1a4602 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-tty
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
@@ -4,3 +4,57 @@ KernelVersion:	5.10
 Contact:	linux-leds@vger.kernel.org
 Description:
 		Specifies the tty device name of the triggering tty
+
+What:		/sys/class/leds/<led>/rx
+Date:		October 2023
+KernelVersion:	6.7
+Description:
+		Signal reception (rx) of data on the named tty device.
+		If set to 0, the LED will not blink on reception.
+		If set to 1 (default), the LED will blink on reception.
+
+What:		/sys/class/leds/<led>/tx
+Date:		October 2023
+KernelVersion:	6.7
+Description:
+		Signal transmission (tx) of data on the named tty device.
+		If set to 0, the LED will not blink on transmission.
+		If set to 1 (default), the LED will blink on transmission.
+
+car rng
+What:		/sys/class/leds/<led>/line_cts
+Date:		October 2023
+KernelVersion:	6.7
+Description:
+		DCE is ready to accept data from the DTE (Clear To Send). If
+		the line state is detected, the LED is switched on.
+		If set to 0 (default), the LED will not evaluate CTS.
+		If set to 1, the LED will evaluate CTS.
+
+What:		/sys/class/leds/<led>/line_dsr
+Date:		October 2023
+KernelVersion:	6.7
+Description:
+		DCE is ready to receive and send data (Data Set Ready). If
+		the line state is detected, the LED is switched on.
+		If set to 0 (default), the LED will not evaluate DSR.
+		If set to 1, the LED will evaluate DSR.
+
+What:		/sys/class/leds/<led>/line_car
+Date:		October 2023
+KernelVersion:	6.7
+Description:
+		DTE is receiving a carrier from the DCE (Data Carrier Detect).
+		If the line state is detected, the LED is switched on.
+		If set to 0 (default), the LED will not evaluate CAR (DCD).
+		If set to 1, the LED will evaluate CAR (DCD).
+
+What:		/sys/class/leds/<led>/line_cts
+Date:		October 2023
+KernelVersion:	6.7
+Description:
+		DCE has detected an incoming ring signal on the telephone
+		line (Ring Indicator). If the line state is detected, the
+		LED is switched on.
+		If set to 0 (default), the LED will not evaluate RNG (RI).
+		If set to 1, the LED will evaluate RNG (RI).
diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/le=
dtrig-tty.c
index 8ae0d2d284af..6a96439a7e55 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -16,6 +16,24 @@ struct ledtrig_tty_data {
 	const char *ttyname;
 	struct tty_struct *tty;
 	int rx, tx;
+	unsigned long mode;
+};
+
+enum led_trigger_tty_state {
+	TTY_LED_BLINK,
+	TTY_LED_ENABLE,
+	TTY_LED_DISABLE,
+};
+
+enum led_trigger_tty_modes {
+	TRIGGER_TTY_RX =3D 0,
+	TRIGGER_TTY_TX,
+	TRIGGER_TTY_CTS,
+	TRIGGER_TTY_DSR,
+	TRIGGER_TTY_CAR,
+	TRIGGER_TTY_RNG,
+	/* Keep last */
+	__TRIGGER_TTY_MAX,
 };
=20
 static void ledtrig_tty_restart(struct ledtrig_tty_data *trigger_data)
@@ -78,13 +96,106 @@ static ssize_t ttyname_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(ttyname);
=20
+static ssize_t ledtrig_tty_attr_show(struct device *dev, char *buf,
+	enum led_trigger_tty_modes attr)
+{
+	struct ledtrig_tty_data *trigger_data =3D led_trigger_get_drvdata(dev);
+	int bit;
+
+	switch (attr) {
+	case TRIGGER_TTY_RX:
+	case TRIGGER_TTY_TX:
+	case TRIGGER_TTY_CTS:
+	case TRIGGER_TTY_DSR:
+	case TRIGGER_TTY_CAR:
+	case TRIGGER_TTY_RNG:
+		bit =3D attr;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sprintf(buf, "%u\n", test_bit(bit, &trigger_data->mode));
+}
+
+static ssize_t ledtrig_tty_attr_store(struct device *dev, const char *bu=
f,
+	size_t size, enum led_trigger_tty_modes attr)
+{
+	struct ledtrig_tty_data *trigger_data =3D led_trigger_get_drvdata(dev);
+	unsigned long state;
+	int ret;
+	int bit;
+
+	ret =3D kstrtoul(buf, 0, &state);
+	if (ret)
+		return ret;
+
+	switch (attr) {
+	case TRIGGER_TTY_RX:
+	case TRIGGER_TTY_TX:
+	case TRIGGER_TTY_CTS:
+	case TRIGGER_TTY_DSR:
+	case TRIGGER_TTY_CAR:
+	case TRIGGER_TTY_RNG:
+		bit =3D attr;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (state)
+		set_bit(bit, &trigger_data->mode);
+	else
+		clear_bit(bit, &trigger_data->mode);
+
+	return size;
+}
+
+#define DEFINE_TTY_TRIGGER(trigger_name, trigger) \
+	static ssize_t trigger_name##_show(struct device *dev, \
+		struct device_attribute *attr, char *buf) \
+	{ \
+		return ledtrig_tty_attr_show(dev, buf, trigger); \
+	} \
+	static ssize_t trigger_name##_store(struct device *dev, \
+		struct device_attribute *attr, const char *buf, size_t size) \
+	{ \
+		return ledtrig_tty_attr_store(dev, buf, size, trigger); \
+	} \
+	static DEVICE_ATTR_RW(trigger_name)
+
+DEFINE_TTY_TRIGGER(rx, TRIGGER_TTY_RX);
+DEFINE_TTY_TRIGGER(tx, TRIGGER_TTY_TX);
+DEFINE_TTY_TRIGGER(line_cts, TRIGGER_TTY_CTS);
+DEFINE_TTY_TRIGGER(line_dsr, TRIGGER_TTY_DSR);
+DEFINE_TTY_TRIGGER(line_car, TRIGGER_TTY_CAR);
+DEFINE_TTY_TRIGGER(line_rng, TRIGGER_TTY_RNG);
+
+static bool ledtrig_tty_evaluate(struct ledtrig_tty_data *trigger_data,
+		int flag)
+{
+	int status;
+
+	status =3D tty_get_tiocm(trigger_data->tty);
+
+	if (status >=3D 0)
+		return (status & flag);
+
+	return false;
+}
+
 static void ledtrig_tty_work(struct work_struct *work)
 {
 	struct ledtrig_tty_data *trigger_data =3D
 		container_of(work, struct ledtrig_tty_data, dwork.work);
+	struct led_classdev *led_cdev =3D trigger_data->led_cdev;
+	unsigned long interval =3D LEDTRIG_TTY_INTERVAL;
 	struct serial_icounter_struct icount;
+	enum led_trigger_tty_state state;
+	int current_brightness;
 	int ret;
=20
+	state =3D TTY_LED_DISABLE;
 	mutex_lock(&trigger_data->mutex);
=20
 	if (!trigger_data->ttyname) {
@@ -115,22 +226,71 @@ static void ledtrig_tty_work(struct work_struct *wo=
rk)
 		trigger_data->tty =3D tty;
 	}
=20
-	ret =3D tty_get_icount(trigger_data->tty, &icount);
-	if (ret) {
-		dev_info(trigger_data->tty->dev, "Failed to get icount, stopped pollin=
g\n");
-		mutex_unlock(&trigger_data->mutex);
-		return;
+	if (test_bit(TRIGGER_TTY_CTS, &trigger_data->mode)) {
+		if (ledtrig_tty_evaluate(trigger_data, TIOCM_CTS))
+			state =3D TTY_LED_ENABLE;
+	}
+
+	if (test_bit(TRIGGER_TTY_DSR, &trigger_data->mode)) {
+		if (ledtrig_tty_evaluate(trigger_data, TIOCM_DSR))
+			state =3D TTY_LED_ENABLE;
 	}
=20
-	if (icount.rx !=3D trigger_data->rx ||
-	    icount.tx !=3D trigger_data->tx) {
-		unsigned long interval =3D LEDTRIG_TTY_INTERVAL;
+	if (test_bit(TRIGGER_TTY_CAR, &trigger_data->mode)) {
+		if (ledtrig_tty_evaluate(trigger_data, TIOCM_CAR))
+			state =3D TTY_LED_ENABLE;
+	}
+
+	if (test_bit(TRIGGER_TTY_RNG, &trigger_data->mode)) {
+		if (ledtrig_tty_evaluate(trigger_data, TIOCM_RNG))
+			state =3D TTY_LED_ENABLE;
+	}
+
+	/* The rx/tx handling must come after the evaluation of TIOCM_*,
+	 * since the display for rx/tx has priority
+	 */
+	if (test_bit(TRIGGER_TTY_RX, &trigger_data->mode) ||
+	    test_bit(TRIGGER_TTY_TX, &trigger_data->mode)) {
+		ret =3D tty_get_icount(trigger_data->tty, &icount);
+		if (ret) {
+			dev_info(trigger_data->tty->dev, "Failed to get icount, stopped polli=
ng\n");
+			mutex_unlock(&trigger_data->mutex);
+			return;
+		}
+
+		if (test_bit(TRIGGER_TTY_RX, &trigger_data->mode) &&
+		    (icount.tx !=3D trigger_data->tx)) {
+			trigger_data->tx =3D icount.tx;
+			state =3D TTY_LED_BLINK;
+		}
+
+		if (test_bit(TRIGGER_TTY_TX, &trigger_data->mode) &&
+		    (icount.rx !=3D trigger_data->rx)) {
+			trigger_data->rx =3D icount.rx;
+			state =3D TTY_LED_BLINK;
+		}
+	}
=20
+	current_brightness =3D led_cdev->brightness;
+	if (current_brightness)
+		led_cdev->blink_brightness =3D current_brightness;
+
+	if (!led_cdev->blink_brightness)
+		led_cdev->blink_brightness =3D led_cdev->max_brightness;
+
+	switch (state) {
+	case TTY_LED_BLINK:
 		led_blink_set_oneshot(trigger_data->led_cdev, &interval,
 				      &interval, 0);
-
-		trigger_data->rx =3D icount.rx;
-		trigger_data->tx =3D icount.tx;
+		break;
+	case TTY_LED_ENABLE:
+		led_set_brightness(led_cdev, led_cdev->blink_brightness);
+		break;
+	case TTY_LED_DISABLE:
+		fallthrough;
+	default:
+		led_set_brightness(led_cdev, LED_OFF);
+		break;
 	}
=20
 out:
@@ -141,6 +301,12 @@ static void ledtrig_tty_work(struct work_struct *wor=
k)
=20
 static struct attribute *ledtrig_tty_attrs[] =3D {
 	&dev_attr_ttyname.attr,
+	&dev_attr_rx.attr,
+	&dev_attr_tx.attr,
+	&dev_attr_line_cts.attr,
+	&dev_attr_line_dsr.attr,
+	&dev_attr_line_car.attr,
+	&dev_attr_line_rng.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(ledtrig_tty);
@@ -153,6 +319,10 @@ static int ledtrig_tty_activate(struct led_classdev =
*led_cdev)
 	if (!trigger_data)
 		return -ENOMEM;
=20
+	/* Enable default rx/tx LED blink */
+	set_bit(TRIGGER_TTY_TX, &trigger_data->mode);
+	set_bit(TRIGGER_TTY_RX, &trigger_data->mode);
+
 	led_set_trigger_data(led_cdev, trigger_data);
=20
 	INIT_DELAYED_WORK(&trigger_data->dwork, ledtrig_tty_work);
--=20
2.30.2

