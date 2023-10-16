Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A1A7CA040
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjJPHON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjJPHOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:14:04 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C71101;
        Mon, 16 Oct 2023 00:13:52 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=966793e2c5=fe@dev.tdt.de>)
        id 1qsHnJ-005biK-0g; Mon, 16 Oct 2023 09:13:41 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1qsHnI-00A6Ja-4m; Mon, 16 Oct 2023 09:13:40 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id ACA7924004D;
        Mon, 16 Oct 2023 09:13:39 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 0C1C3240049;
        Mon, 16 Oct 2023 09:13:39 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 5E0272BD62;
        Mon, 16 Oct 2023 09:13:38 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v3 4/4] trigger: ledtrig-tty: add new line mode to triggers
Date:   Mon, 16 Oct 2023 09:13:32 +0200
Message-ID: <20231016071332.597654-5-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231016071332.597654-1-fe@dev.tdt.de>
References: <20231016071332.597654-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1697440420-D3E9C639-E5308D60/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, the LED blinks when data is sent via the tty (rx/tx).
The serial tty interface also supports additional input signals, that can
also be evaluated within this trigger. This commit is adding the followin=
g
additional input sources, which could be controlled via the
'/sys/class/<leds>/' sysfs interface.

DCE =3D Data Communication Equipment (Modem)
DTE =3D Data Terminal Equipment (Computer)

- line_cts:
  DCE is ready to accept data from the DTE (CTS =3D Clear To Send). If th=
e
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
 .../ABI/testing/sysfs-class-led-trigger-tty   |  53 ++++
 drivers/leds/trigger/ledtrig-tty.c            | 279 +++++++++++++++++-
 2 files changed, 322 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-tty b/Docu=
mentation/ABI/testing/sysfs-class-led-trigger-tty
index 2bf6b24e781b..e1f578ac8656 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-tty
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
@@ -4,3 +4,56 @@ KernelVersion:	5.10
 Contact:	linux-leds@vger.kernel.org
 Description:
 		Specifies the tty device name of the triggering tty
+
+What:		/sys/class/leds/<led>/rx
+Date:		September 2023
+KernelVersion:	6.7
+Description:
+		Signal reception (rx) of data on the named tty device.
+		If set to 0, the LED will not blink on reception.
+		If set to 1 (default), the LED will blink on reception.
+
+What:		/sys/class/leds/<led>/tx
+Date:		September 2023
+KernelVersion:	6.7
+Description:
+		Signal transmission (tx) of data on the named tty device.
+		If set to 0, the LED will not blink on transmission.
+		If set to 1 (default), the LED will blink on transmission.
+
+What:		/sys/class/leds/<led>/line_cts
+Date:		September 2023
+KernelVersion:	6.7
+Description:
+		DCE is ready to accept data from the DTE (Clear To Send). If
+		the line state is detected, the LED is switched on.
+		If set to 0 (default), the LED will not evaluate CTS.
+		If set to 1, the LED will evaluate CTS.
+
+What:		/sys/class/leds/<led>/line_dsr
+Date:		September 2023
+KernelVersion:	6.7
+Description:
+		DCE is ready to receive and send data (Data Set Ready). If
+		the line state is detected, the LED is switched on.
+		If set to 0 (default), the LED will not evaluate DSR.
+		If set to 1, the LED will evaluate DSR.
+
+What:		/sys/class/leds/<led>/line_car
+Date:		September 2023
+KernelVersion:	6.7
+Description:
+		DTE is receiving a carrier from the DCE (Data Carrier Detect).
+		If the line state is detected, the LED is switched on.
+		If set to 0 (default), the LED will not evaluate CAR (DCD).
+		If set to 1, the LED will evaluate CAR (DCD).
+
+What:		/sys/class/leds/<led>/line_rng
+Date:		September 2023
+KernelVersion:	6.7
+Description:
+		DCE has detected an incoming ring signal on the telephone
+		line (Ring Indicator). If the line state is detected, the
+		LED is switched on.
+		If set to 0 (default), the LED will not evaluate RNG (RI).
+		If set to 1, the LED will evaluate RNG (RI).
diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/le=
dtrig-tty.c
index 1c6fadf0b856..50bef4c8f321 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -16,6 +16,28 @@ struct ledtrig_tty_data {
 	const char *ttyname;
 	struct tty_struct *tty;
 	int rx, tx;
+	unsigned long mode;
+#define LEDTRIG_TTY_MODE_TX	0
+#define LEDTRIG_TTY_MODE_RX	1
+#define LEDTRIG_TTY_MODE_CTS	2
+#define LEDTRIG_TTY_MODE_DSR	3
+#define LEDTRIG_TTY_MODE_CAR	4
+#define LEDTRIG_TTY_MODE_RNG	5
+};
+
+enum tty_led_state {
+	TTY_LED_BLINK,
+	TTY_LED_ENABLE,
+	TTY_LED_DISABLE,
+};
+
+enum ledtrig_tty_attr {
+	LEDTRIG_TTY_ATTR_TX,
+	LEDTRIG_TTY_ATTR_RX,
+	LEDTRIG_TTY_ATTR_CTS,
+	LEDTRIG_TTY_ATTR_DSR,
+	LEDTRIG_TTY_ATTR_CAR,
+	LEDTRIG_TTY_ATTR_RNG,
 };
=20
 static void ledtrig_tty_restart(struct ledtrig_tty_data *trigger_data)
@@ -78,14 +100,186 @@ static ssize_t ttyname_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(ttyname);
=20
+static ssize_t ledtrig_tty_attr_show(struct device *dev, char *buf,
+	enum ledtrig_tty_attr attr)
+{
+	struct ledtrig_tty_data *trigger_data =3D led_trigger_get_drvdata(dev);
+	int bit;
+
+	switch (attr) {
+	case LEDTRIG_TTY_ATTR_TX:
+		bit =3D LEDTRIG_TTY_MODE_TX;
+		break;
+	case LEDTRIG_TTY_ATTR_RX:
+		bit =3D LEDTRIG_TTY_MODE_RX;
+		break;
+	case LEDTRIG_TTY_ATTR_CTS:
+		bit =3D LEDTRIG_TTY_MODE_CTS;
+		break;
+	case LEDTRIG_TTY_ATTR_DSR:
+		bit =3D LEDTRIG_TTY_MODE_DSR;
+		break;
+	case LEDTRIG_TTY_ATTR_CAR:
+		bit =3D LEDTRIG_TTY_MODE_CAR;
+		break;
+	case LEDTRIG_TTY_ATTR_RNG:
+		bit =3D LEDTRIG_TTY_MODE_RNG;
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
+	size_t size, enum ledtrig_tty_attr attr)
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
+	case LEDTRIG_TTY_ATTR_TX:
+		bit =3D LEDTRIG_TTY_MODE_TX;
+		break;
+	case LEDTRIG_TTY_ATTR_RX:
+		bit =3D LEDTRIG_TTY_MODE_RX;
+		break;
+	case LEDTRIG_TTY_ATTR_CTS:
+		bit =3D LEDTRIG_TTY_MODE_CTS;
+		break;
+	case LEDTRIG_TTY_ATTR_DSR:
+		bit =3D LEDTRIG_TTY_MODE_DSR;
+		break;
+	case LEDTRIG_TTY_ATTR_CAR:
+		bit =3D LEDTRIG_TTY_MODE_CAR;
+		break;
+	case LEDTRIG_TTY_ATTR_RNG:
+		bit =3D LEDTRIG_TTY_MODE_RNG;
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
+static ssize_t tx_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return ledtrig_tty_attr_show(dev, buf, LEDTRIG_TTY_ATTR_TX);
+}
+
+static ssize_t tx_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	return ledtrig_tty_attr_store(dev, buf, size, LEDTRIG_TTY_ATTR_TX);
+}
+static DEVICE_ATTR_RW(tx);
+
+static ssize_t rx_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return ledtrig_tty_attr_show(dev, buf, LEDTRIG_TTY_ATTR_RX);
+}
+
+static ssize_t rx_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	return ledtrig_tty_attr_store(dev, buf, size, LEDTRIG_TTY_ATTR_RX);
+}
+static DEVICE_ATTR_RW(rx);
+
+static ssize_t line_cts_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return ledtrig_tty_attr_show(dev, buf, LEDTRIG_TTY_ATTR_CTS);
+}
+
+static ssize_t line_cts_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	return ledtrig_tty_attr_store(dev, buf, size, LEDTRIG_TTY_ATTR_CTS);
+}
+static DEVICE_ATTR_RW(line_cts);
+
+static ssize_t line_dsr_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return ledtrig_tty_attr_show(dev, buf, LEDTRIG_TTY_ATTR_DSR);
+}
+
+static ssize_t line_dsr_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	return ledtrig_tty_attr_store(dev, buf, size, LEDTRIG_TTY_ATTR_DSR);
+}
+static DEVICE_ATTR_RW(line_dsr);
+
+static ssize_t line_car_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return ledtrig_tty_attr_show(dev, buf, LEDTRIG_TTY_ATTR_CAR);
+}
+
+static ssize_t line_car_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	return ledtrig_tty_attr_store(dev, buf, size, LEDTRIG_TTY_ATTR_CAR);
+}
+static DEVICE_ATTR_RW(line_car);
+
+static ssize_t line_rng_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return ledtrig_tty_attr_show(dev, buf, LEDTRIG_TTY_ATTR_RNG);
+}
+
+static ssize_t line_rng_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	return ledtrig_tty_attr_store(dev, buf, size, LEDTRIG_TTY_ATTR_RNG);
+}
+static DEVICE_ATTR_RW(line_rng);
+
+
+static int ledtrig_tty_flag(struct ledtrig_tty_data *trigger_data, unsig=
ned int flag)
+{
+	unsigned int status;
+	int ret;
+
+	status =3D tty_get_tiocm(trigger_data->tty);
+	if (status & flag)
+		ret =3D 1;
+	else
+		ret =3D 0;
+
+	return ret;
+}
+
 static void ledtrig_tty_work(struct work_struct *work)
 {
 	struct ledtrig_tty_data *trigger_data =3D
 		container_of(work, struct ledtrig_tty_data, dwork.work);
+	struct led_classdev *led_cdev =3D trigger_data->led_cdev;
 	unsigned long interval =3D LEDTRIG_TTY_INTERVAL;
 	struct serial_icounter_struct icount;
+	enum tty_led_state state;
+	int current_brightness;
 	int ret;
=20
+	state =3D TTY_LED_DISABLE;
 	mutex_lock(&trigger_data->mutex);
=20
 	if (!trigger_data->ttyname) {
@@ -116,20 +310,75 @@ static void ledtrig_tty_work(struct work_struct *wo=
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
+	if (test_bit(LEDTRIG_TTY_MODE_CTS, &trigger_data->mode)) {
+		ret =3D ledtrig_tty_flag(trigger_data, TIOCM_CTS);
+		if (ret)
+			state =3D TTY_LED_ENABLE;
 	}
=20
-	if (icount.rx !=3D trigger_data->rx ||
-	    icount.tx !=3D trigger_data->tx) {
+	if (test_bit(LEDTRIG_TTY_MODE_DSR, &trigger_data->mode)) {
+		ret =3D ledtrig_tty_flag(trigger_data, TIOCM_DSR);
+		if (ret)
+			state =3D TTY_LED_ENABLE;
+	}
+
+	if (test_bit(LEDTRIG_TTY_MODE_CAR, &trigger_data->mode)) {
+		ret =3D ledtrig_tty_flag(trigger_data, TIOCM_CAR);
+		if (ret)
+			state =3D TTY_LED_ENABLE;
+	}
+
+	if (test_bit(LEDTRIG_TTY_MODE_RNG, &trigger_data->mode)) {
+		ret =3D ledtrig_tty_flag(trigger_data, TIOCM_RNG);
+		if (ret)
+			state =3D TTY_LED_ENABLE;
+	}
+
+	/* The rx/tx handling must come after the evaluation of TIOCM_*,
+	 * since the display for rx/tx has priority
+	 */
+	if (test_bit(LEDTRIG_TTY_MODE_TX, &trigger_data->mode) ||
+	    test_bit(LEDTRIG_TTY_MODE_RX, &trigger_data->mode)) {
+		ret =3D tty_get_icount(trigger_data->tty, &icount);
+		if (ret) {
+			dev_info(trigger_data->tty->dev, "Failed to get icount, stopped polli=
ng\n");
+			mutex_unlock(&trigger_data->mutex);
+			return;
+		}
+
+		if (test_bit(LEDTRIG_TTY_MODE_TX, &trigger_data->mode) &&
+		    (icount.tx !=3D trigger_data->tx)) {
+			trigger_data->tx =3D icount.tx;
+			state =3D TTY_LED_BLINK;
+		}
+
+		if (test_bit(LEDTRIG_TTY_MODE_RX, &trigger_data->mode) &&
+		    (icount.rx !=3D trigger_data->rx)) {
+			trigger_data->rx =3D icount.rx;
+			state =3D TTY_LED_BLINK;
+		}
+	}
+
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
@@ -140,6 +389,12 @@ static void ledtrig_tty_work(struct work_struct *wor=
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
@@ -152,6 +407,10 @@ static int ledtrig_tty_activate(struct led_classdev =
*led_cdev)
 	if (!trigger_data)
 		return -ENOMEM;
=20
+	/* Enable default rx/tx LED blink */
+	set_bit(LEDTRIG_TTY_MODE_TX, &trigger_data->mode);
+	set_bit(LEDTRIG_TTY_MODE_RX, &trigger_data->mode);
+
 	led_set_trigger_data(led_cdev, trigger_data);
=20
 	INIT_DELAYED_WORK(&trigger_data->dwork, ledtrig_tty_work);
--=20
2.30.2

