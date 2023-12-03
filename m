Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5CF8023F3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 14:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjLCMub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 07:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCMu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 07:50:29 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81518C2;
        Sun,  3 Dec 2023 04:50:35 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bf5398755so13770e87.0;
        Sun, 03 Dec 2023 04:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701607834; x=1702212634; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N+T2khgtXnTEu6PTq9Za/aCSsZG0UtepvpPeYmqH1AI=;
        b=RVxXNc1fVU30OByHtwm1C+ynk/77NbMJ4H8aC9mYE4fOpsxT54uXOa5PdrS4vWezSi
         J+/8RwyYMx6O/5iVuICXTkdZkKPNDk5+DCKlRUbKqWSJHoQA7ryEQ0Ix92QBZBBse+DI
         x75RIgMA3NxQzdTmNPyvGEjmqAHUZBIT7Sf3UiklvdJF6iGbjFVKxBvbOfAjT00AcMps
         pde/G0wjzoUjLcThzJL9fLGyxV+Xm/qcCPulDBHFMdHKuPZnqmDaP+6nmrvpn4zDD7GZ
         b+boXf9XKNMUaeNgTCDn918i6IotMY+d6koFc+Y6KibrMN1HPeSW+oaYLcgY3HvBBCma
         TfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701607834; x=1702212634;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+T2khgtXnTEu6PTq9Za/aCSsZG0UtepvpPeYmqH1AI=;
        b=f+uieW5JM5/e0krK4vtz6LSU/+sDyWK6FvJI1wdAOXf6xNrTUsgYqWaZJq2WJF8kBT
         0f7r836qSXs5D8D/ZaG8x3IAEJcCrLirXSyl/Cf9Uq9zNGALZv/EoPqWRUdJVfhFlIjp
         GN/j5svetAhnxciCOvFCTnIdG63ryeYZ6f8CxHCFT4zdjQ6PceZW0TDAwiWODCK7Ws2r
         EabakvpAKpAEixZKD8cUgGGlzYU6RJnd7RZQpjWZPdNY7p9kaYwiDsUfojsWGDT7UdiC
         kVdUL1UD+Q4hDyapNdlr6EI4XZYGWRD3aBYlblO+d2krmd42Mkru9m42M0oxxptc5gx9
         HVXA==
X-Gm-Message-State: AOJu0YzbLaZ1B+kkKTx2Qyh35AdLcO3Xu18xO5F6zw3rqdtLowIoqLIK
        jFgk8bPnYXe8bO3AAmZMPXAVdcWDNWMLHSpR42polp+9cFIn40LyNSI=
X-Google-Smtp-Source: AGHT+IFnBM5d3SM2ajAzeiu42JMgrWc7/49n6/x5LcR4l3UNcxplNKnyBhTo2MOka2C4MuZivEPNOf37cl+tQSEfnLw=
X-Received: by 2002:a05:6512:3c99:b0:50b:ed57:7597 with SMTP id
 h25-20020a0565123c9900b0050bed577597mr1969122lfv.4.1701607833092; Sun, 03 Dec
 2023 04:50:33 -0800 (PST)
MIME-Version: 1.0
From:   Wei Shuai <cpuwolf@gmail.com>
Date:   Sun, 3 Dec 2023 20:50:19 +0800
Message-ID: <CACa7zymSNJJy1MJeNzzH22MAOH4=fxu_GJcdaY5JRqM3A_jkGA@mail.gmail.com>
Subject: [PATCH] Input: expand keycode space
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dmitry Torokhov,

Today I found out that in 2008, you have expanded the number of
potential key codes from 512 to 768.

I request to expand keycode space again, from 0x2ff to 0x4ff. I have
tested this patch on Ubuntu Kernel, it works well with a USB HID
joystick that has more than 80 keys.

Story back to I found Linux kernel has max USB HID joystick buttons up
to 80, no more.  But Windows OS and Mac OS have no such limitations.

I have a USB HID joystick device, which has 104 buttons, larger than 80.

I did a lot of google search, but nothing I got. then I have to look
at Kernel source, to find out where this number max 80 comes from

Eventually, I found the final limitation

#define BTN_JOYSTICK 0x120
#define BTN_DEAD 0x12f
#define BTN_TRIGGER_HAPPY 0x2c0
#define KEY_MAX 0x2ff

include/uapi/linux/input-event-codes.h

according to function hidinput_configure_usage() in file drivers/hid/hid-input.c

the USB joystick button mapping is not a continuous space, generally speak
the mapping space is from

BTN_JOYSTICK~BTN_DEAD 0x120~0x12f=0x10
BTN_TRIGGER_HAPPY~KEY_MAX 0x2c0~0x2ff=40

0x10+0x40=0x60=80

and finally, I got the max limitation of 80 for joystick keys.

This patch is about expanding keycode space from 0x2ff to 0x4ff. I
expect this patch won't go with ease, because it affects user space
application definition as well. I believe sooner or later Linux kernel
will face keycode is not enough


Signed-off-by: Wei Shuai <cpuwolf@gmail.com>
---
 include/linux/mod_devicetable.h        | 2 +-
 include/uapi/linux/input-event-codes.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 8d764aab29de..35eb59ae1f19 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -311,7 +311,7 @@ struct pcmcia_device_id {
 /* Input */
 #define INPUT_DEVICE_ID_EV_MAX         0x1f
 #define INPUT_DEVICE_ID_KEY_MIN_INTERESTING    0x71
-#define INPUT_DEVICE_ID_KEY_MAX                0x2ff
+#define INPUT_DEVICE_ID_KEY_MAX                0x4ff
 #define INPUT_DEVICE_ID_REL_MAX                0x0f
 #define INPUT_DEVICE_ID_ABS_MAX                0x3f
 #define INPUT_DEVICE_ID_MSC_MAX                0x07
diff --git a/include/uapi/linux/input-event-codes.h
b/include/uapi/linux/input-event-codes.h
index b6a835d37826..ad1b9bed3828 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -774,7 +774,7 @@

 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING    KEY_MUTE
-#define KEY_MAX                        0x2ff
+#define KEY_MAX                        0x4ff
 #define KEY_CNT                        (KEY_MAX+1)

 /*
--
2.17.1
