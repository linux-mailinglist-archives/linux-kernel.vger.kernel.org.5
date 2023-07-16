Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9E875563F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 22:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjGPUtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 16:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjGPUs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 16:48:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803EB10D1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 13:48:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-993d1f899d7so567136166b.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689540519; x=1692132519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CehPTWLCThR4hNP1QNb08h7zd7fc6eeaIehbCL/D6Po=;
        b=ioefSi0YmWrxbMjxaoGsC1z9ksaWu/RYwuA1fhwxvur5xqpyR0DK3eaRn77adLG/uu
         Quo3NArD3K9slhztRLBxC4HIFj4sl73dtaJySMaE8bTEfozr5J8KimHpDZcUVmYl38pB
         CuJ9RXLY0IayWIWZtMsQkJEHpHess6m8gt0Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689540519; x=1692132519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CehPTWLCThR4hNP1QNb08h7zd7fc6eeaIehbCL/D6Po=;
        b=GIUp2CQ4IeonClzwBB92OZdotGGlIRhOajJALEsfTFY2qY9gwJdv9LnKCA+AiGUb4Y
         /NO/Wwm544Vgj5S63qGO1a+hD/iMOZDpzXk26epvw393456aAv5j9lokeiNKDAxvOWgp
         2b+obeo008D/xRhQpykvKJ3ErtaK62fi9UItpqGv2Yj7a4f8UVNzpiuCpWS6m0wvrmtP
         NyVOq5FEMG5ivV63tuF3fMjjA/1cabFpL4durW5m492HuqedTV0ncV9kED3r4wd13kNn
         BKBn6Mm2YG/vxWtdXWok7DWnIdU51swjAUsLlt1F3qgG4XdQ81o3JSs/kk6kVCZ8cqcU
         4/7Q==
X-Gm-Message-State: ABy/qLYGaKfkZEj6JEOWag73c1mXaU36tJ54e6z04O+tjk7aa+zUgA+h
        iRwEHYykBqrr+NgW6rsxPM0Fcg==
X-Google-Smtp-Source: APBJJlGwK9KkiBwkcTBlLkvKcf/1QQ11WG+NaM7TrdTpEtHcomfvFN8Cpu1ZdyKg+Z6D7ObsrrRJXQ==
X-Received: by 2002:a17:907:601f:b0:98c:cc3c:194e with SMTP id fs31-20020a170907601f00b0098ccc3c194emr8767838ejc.52.1689540518539;
        Sun, 16 Jul 2023 13:48:38 -0700 (PDT)
Received: from balto.c.googlers.com.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id ov15-20020a170906fc0f00b0099364d9f0e6sm8299200ejb.117.2023.07.16.13.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 13:48:37 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>
Subject: [PATCH v4] HID: hid-google-stadiaff: add support for Stadia force feedback
Date:   Sun, 16 Jul 2023 20:48:34 +0000
Message-ID: <20230716204834.2879106-1-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.41.0.455.g037347b96a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a hid-google-stadiaff module to support rumble based force feedback
on the Google Stadia controller. This works using the HID output
endpoint exposed on both the USB and BLE interface.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
---

Hi, this adds rumble support to the stadia controller using the input
interface. Up to now this has only been implemented at application level
using hidraw:

https://source.chromium.org/chromium/chromium/src/+/main:device/gamepad/hid_haptic_gamepad.cc

Tested with fftest, works both over USB and BLE.

Changes from v3:
- fixed an unintended use of dev_err instead of hid_err
- fixed the driver name reference in the commit message
- rebased so the change in hid-ids.h applies cleanly

Changes from v2:
- check stadiaff_init value at probe time and fail the probe if init
  fails

Changes from v1:
- renamed the module to hid-google-stadiaff.c
- added locking for passing the state to the worker code
- added a module removed check to prevent the work from rescheduling

 drivers/hid/Kconfig               |   7 ++
 drivers/hid/Makefile              |   1 +
 drivers/hid/hid-google-stadiaff.c | 158 ++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h             |   1 +
 4 files changed, 167 insertions(+)
 create mode 100644 drivers/hid/hid-google-stadiaff.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index e11c1c803676..545e81c8f359 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -412,6 +412,13 @@ config HID_GOOGLE_HAMMER
 	help
 	Say Y here if you have a Google Hammer device.
 
+config HID_GOOGLE_STADIA_FF
+	tristate "Google Stadia force feedback"
+	select INPUT_FF_MEMLESS
+	help
+	Say Y here if you want to enable force feedback support for the Google
+	Stadia controller.
+
 config HID_VIVALDI
 	tristate "Vivaldi Keyboard"
 	select HID_VIVALDI_COMMON
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 7a9e160158f7..8a06d0f840bc 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
 obj-$(CONFIG_HID_GLORIOUS)  += hid-glorious.o
 obj-$(CONFIG_HID_VIVALDI_COMMON) += hid-vivaldi-common.o
 obj-$(CONFIG_HID_GOOGLE_HAMMER)	+= hid-google-hammer.o
+obj-$(CONFIG_HID_GOOGLE_STADIA_FF)	+= hid-google-stadiaff.o
 obj-$(CONFIG_HID_VIVALDI)	+= hid-vivaldi.o
 obj-$(CONFIG_HID_GT683R)	+= hid-gt683r.o
 obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
diff --git a/drivers/hid/hid-google-stadiaff.c b/drivers/hid/hid-google-stadiaff.c
new file mode 100644
index 000000000000..3731575562ab
--- /dev/null
+++ b/drivers/hid/hid-google-stadiaff.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Stadia controller rumble support.
+ *
+ * Copyright 2023 Google LLC
+ */
+
+#include <linux/hid.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+#define STADIA_FF_REPORT_ID 5
+
+struct stadiaff_device {
+	struct hid_device *hid;
+	struct hid_report *report;
+	spinlock_t lock;
+	bool removed;
+	uint16_t strong_magnitude;
+	uint16_t weak_magnitude;
+	struct work_struct work;
+};
+
+static void stadiaff_work(struct work_struct *work)
+{
+	struct stadiaff_device *stadiaff =
+		container_of(work, struct stadiaff_device, work);
+	struct hid_field *rumble_field = stadiaff->report->field[0];
+	unsigned long flags;
+
+	spin_lock_irqsave(&stadiaff->lock, flags);
+	rumble_field->value[0] = stadiaff->strong_magnitude;
+	rumble_field->value[1] = stadiaff->weak_magnitude;
+	spin_unlock_irqrestore(&stadiaff->lock, flags);
+
+	hid_hw_request(stadiaff->hid, stadiaff->report, HID_REQ_SET_REPORT);
+}
+
+static int stadiaff_play(struct input_dev *dev, void *data,
+			 struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
+	unsigned long flags;
+
+	spin_lock_irqsave(&stadiaff->lock, flags);
+	if (!stadiaff->removed) {
+		stadiaff->strong_magnitude = effect->u.rumble.strong_magnitude;
+		stadiaff->weak_magnitude = effect->u.rumble.weak_magnitude;
+		schedule_work(&stadiaff->work);
+	}
+	spin_unlock_irqrestore(&stadiaff->lock, flags);
+
+	return 0;
+}
+
+static int stadiaff_init(struct hid_device *hid)
+{
+	struct stadiaff_device *stadiaff;
+	struct hid_report *report;
+	struct hid_input *hidinput;
+	struct input_dev *dev;
+	int error;
+
+	if (list_empty(&hid->inputs)) {
+		hid_err(hid, "no inputs found\n");
+		return -ENODEV;
+	}
+	hidinput = list_entry(hid->inputs.next, struct hid_input, list);
+	dev = hidinput->input;
+
+	report = hid_validate_values(hid, HID_OUTPUT_REPORT,
+				     STADIA_FF_REPORT_ID, 0, 2);
+	if (!report)
+		return -ENODEV;
+
+	stadiaff = devm_kzalloc(&hid->dev, sizeof(struct stadiaff_device),
+				GFP_KERNEL);
+	if (!stadiaff)
+		return -ENOMEM;
+
+	hid_set_drvdata(hid, stadiaff);
+
+	input_set_capability(dev, EV_FF, FF_RUMBLE);
+
+	error = input_ff_create_memless(dev, NULL, stadiaff_play);
+	if (error)
+		return error;
+
+	stadiaff->removed = false;
+	stadiaff->hid = hid;
+	stadiaff->report = report;
+	INIT_WORK(&stadiaff->work, stadiaff_work);
+	spin_lock_init(&stadiaff->lock);
+
+	hid_info(hid, "Force Feedback for Google Stadia controller\n");
+
+	return 0;
+}
+
+static int stadia_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		return ret;
+	}
+
+	ret = stadiaff_init(hdev);
+	if (ret) {
+		hid_err(hdev, "force feedback init failed\n");
+		hid_hw_stop(hdev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void stadia_remove(struct hid_device *hid)
+{
+	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
+	unsigned long flags;
+
+	spin_lock_irqsave(&stadiaff->lock, flags);
+	stadiaff->removed = true;
+	spin_unlock_irqrestore(&stadiaff->lock, flags);
+
+	cancel_work_sync(&stadiaff->work);
+	hid_hw_stop(hid);
+}
+
+static const struct hid_device_id stadia_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STADIA) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STADIA) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, stadia_devices);
+
+static struct hid_driver stadia_driver = {
+	.name = "stadia",
+	.id_table = stadia_devices,
+	.probe = stadia_probe,
+	.remove = stadia_remove,
+};
+module_hid_driver(stadia_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8a310f8ff20f..42c43d309f98 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -531,6 +531,7 @@
 #define USB_DEVICE_ID_GOOGLE_DON	0x5050
 #define USB_DEVICE_ID_GOOGLE_EEL	0x5057
 #define USB_DEVICE_ID_GOOGLE_JEWEL	0x5061
+#define USB_DEVICE_ID_GOOGLE_STADIA	0x9400
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
-- 
2.41.0.455.g037347b96a-goog

