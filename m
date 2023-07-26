Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BAA7628E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGZCxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGZCxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:53:05 -0400
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DC0193
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:53:03 -0700 (PDT)
Received: by mail-oo1-xc4a.google.com with SMTP id 006d021491bc7-565cd3f645bso8858260eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690339983; x=1690944783;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zVwrDQnfQU6HXjK9I2MjxgI4YzaboORQ+uZeRLX6Kuo=;
        b=A34Z3jwJk5FcFyKLj0Hvo4W+ZuIIYqI2nyUH4IBIMkeeG2vaurzvdSlar8NV6eRjVD
         GJ17bK8p/O69s29qVsws3yH5Avr3piqKUPoe73TV7YGuIfztSx6OZGCrmYif/lnbaDej
         MyByAat57PMRapSQz/N1JRwijLv6bG7SCyzbsfcMZANpTAR4yZ3wAu9EypdraLgu+nkl
         j4dmHqIP0xHTgvOYNYYWfMxGshNcT10XhlLKIy+cK8JukSQbECEe6/2cewmJtL2LCiQm
         MkChXeM50jxJ/fSqirb2RG43MyaIGtn+YXDJGKm9aVApjwJ5fctHMEj95D8Dw7f/HdxV
         nsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690339983; x=1690944783;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVwrDQnfQU6HXjK9I2MjxgI4YzaboORQ+uZeRLX6Kuo=;
        b=ZwTmS2rALRW+Yn9s6YxcVVOfcNkEJ36P0KpCpuYJLQLEaovKD9DwmMJxxCSyc96N3T
         4Wtg6f+p2SPy7IZRmzAg9wDOa4lf5SXeyAeiPzjRJOFawMta4krcfiOfzYZY5NVjL/mp
         8nzmx2LUiU5gCo+80zU9DMVlvCGPIZYOClmSnmX8qq5h115vI2MuAkaH9h3ONpS+BOyl
         KV4Pd26mrY91STlkB4EjPXiZ9LcHDTWnlYOdJUaR97Xn7yVK0HxZ2p0UzTjKcpmTRYEX
         0Mj6n3dzBW6RA6aiUc5CUBSH0M3Ha8Mnd8I11Pn1yuQUWiZb6K9QMo4/3yhPYsbM1gkc
         5xWw==
X-Gm-Message-State: ABy/qLZnz2bbapjxVQDjy1A4BkpMm5cHSEs9QjPzBJGy/vaEYO6I4YzL
        Ypc6ULFgFyJ3UZxFaY9EJEOXsDQFCuZ11PkDfi50
X-Google-Smtp-Source: APBJJlHCZsZO+1qTbe8UXl9QTH49h15wpQlNswbBb6UeEG+J3ado5z1SppNiYnR0njVfeQXDZjPsKXKcJlWEbt3O1W5q
X-Received: from horchata.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:5b3])
 (user=jefferymiller job=sendgmr) by 2002:a05:6808:1387:b0:3a1:f3ed:e9e with
 SMTP id c7-20020a056808138700b003a1f3ed0e9emr1924600oiw.3.1690339983068; Tue,
 25 Jul 2023 19:53:03 -0700 (PDT)
Date:   Wed, 26 Jul 2023 02:52:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230726025256.81174-1-jefferymiller@google.com>
Subject: [PATCH v4] Input: psmouse - add delay when deactivating for SMBus mode
From:   Jeffery Miller <jefferymiller@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        Jonathan Denose <jdenose@chromium.org>, jdenose@google.com,
        Andrew Duggan <aduggan@synaptics.com>,
        Andrew Duggan <andrew@duggan.us>, loic.poulain@linaro.org,
        benjamin.tissoires@redhat.com,
        Jeffery Miller <jefferymiller@google.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a period of time between the psmouse deactivate and the
ability to communicate with the SMBus companion. Insert a
sleep after the deactivate to account for the delay and ensure
the SMBus companion is responsive.

Attempting to read from the SMBus companion too quickly was causing
the touchpad on machines with an i801_smbus companion to stop working
after a sleep/resume cycle.

On resume the rmi4_smbus would fail with errors reading the SMBus version
number:
```
[5454] i2c_i801:i801_check_post:414: i801_smbus 0000:00:1f.3: No response
smbus_result: i2c-0 a=02c f=0000 c=fd BYTE_DATA rd res=-6
rmi4_smbus 0-002c: failed to get SMBus version number!
...
rmi4_f01 rmi4-00.fn01: Failed to restore normal operation: -6.
rmi4_f01 rmi4-00.fn01: Resume failed with code -6.
rmi4_physical rmi4-00: Failed to suspend functions: -6
rmi4_smbus 0-002c: Failed to resume device: -6
```
In this case the rmi_smb_get_version fails with -ENXIO if it happens too
soon after the preceding serio_resume -> psmouse_deactivate call.

On boot this issue could cause the touchpad to stay in the limited PS/2
mode. This only reproduced in 1 in 10 boots on the Lenovo T440p.
Failures in the log on boot would show up as:
```
psmouse serio1: synaptics: Trying to set up SMBus access
[122] i2c_i801:i801_check_post:437: i801_smbus 0000:00:1f.3: No response
psmouse serio1: synaptics: SMbus companion is not ready yet
```

Experimentation on the Lenovo T440p showed that a delay of 7-12ms on
resume allowed the companion to respond.

The 30ms delay in this patch was chosen based on the linux-input message:
Link: https://lore.kernel.org/all/BYAPR03MB47572F2C65E52ED673238D41B2439@BYAPR03MB4757.namprd03.prod.outlook.com/

Signed-off-by: Jeffery Miller <jefferymiller@google.com>
---

Early boot dmesg include:
```
rmi4_smbus 0-002c: registering SMbus-connected sensor
rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM2722-001, fw id: 0
```

The resume order looks correct. The `psmouse serio1` resume returns
before the rmi_smb_resume is called showing the patch from
https://lore.kernel.org/all/89456fcd-a113-4c82-4b10-a9bcaefac68f@google.com/
is applied and working for that ordering.

I attempted to try to rule out some interaction between the concurrent
input resume calls for other i8042 devices.
Adding a 7ms delay after psmouse_deactivate which is called in the
preceding psmouse serio1 serio_resume function also allows
this version call to succeed.

If the rmi_smb_probe device_disable_async_suspend patch is applied
it will also avoid this issue on resume. However the time between
the psmouse_deactivate call for serio_resume and rmi_smb_resume
was over 60ms on my test machine. This would naturally be long
enough to avoid this particular delay.


Changes in v4:
- Moved the delay out of rmi4_smbus to psmouse_smbus based on review
  comments. This also fixes an issue at boot time.

Changes in v3:
- Tagged mail message Link to resolve checkpatch warning.

Changes in v2:
- Changed to a single retry of 30ms based on previous feedback.

 drivers/input/mouse/psmouse-smbus.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
index 2a2459b1b4f2..7b13de979908 100644
--- a/drivers/input/mouse/psmouse-smbus.c
+++ b/drivers/input/mouse/psmouse-smbus.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/libps2.h>
@@ -118,13 +119,18 @@ static psmouse_ret_t psmouse_smbus_process_byte(struct psmouse *psmouse)
 	return PSMOUSE_FULL_PACKET;
 }
 
-static int psmouse_smbus_reconnect(struct psmouse *psmouse)
+static void psmouse_activate_smbus_mode(struct psmouse_smbus_dev *smbdev)
 {
-	struct psmouse_smbus_dev *smbdev = psmouse->private;
-
-	if (smbdev->need_deactivate)
-		psmouse_deactivate(psmouse);
+	if (smbdev->need_deactivate) {
+		psmouse_deactivate(smbdev->psmouse);
+		/* Give the device time to switch into SMBus mode */
+		msleep(30);
+	}
+}
 
+static int psmouse_smbus_reconnect(struct psmouse *psmouse)
+{
+	psmouse_activate_smbus_mode(psmouse->private);
 	return 0;
 }
 
@@ -257,8 +263,7 @@ int psmouse_smbus_init(struct psmouse *psmouse,
 		}
 	}
 
-	if (need_deactivate)
-		psmouse_deactivate(psmouse);
+	psmouse_activate_smbus_mode(smbdev);
 
 	psmouse->private = smbdev;
 	psmouse->protocol_handler = psmouse_smbus_process_byte;
-- 
2.41.0.487.g6d72f3e995-goog

