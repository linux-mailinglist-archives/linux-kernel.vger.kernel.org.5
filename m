Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96F5800A59
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378683AbjLAMEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378677AbjLAMEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:04:34 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209E71712;
        Fri,  1 Dec 2023 04:04:40 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9bbb30c34so25436111fa.1;
        Fri, 01 Dec 2023 04:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701432278; x=1702037078; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cFGGsXWJYUMlhTjzhtr1dm6frB37gIvfJ6/goCKEQzA=;
        b=FIRcqsCTQqyyCJ4vRfgMDjzOSOhpFj5eDWwIUfoTsiKjLmWwWnN+X3BjDdQ734G1kA
         ZUqE/La1Le4/pNk0pkQuW54Z0K16a4Ln9DMIkUgqZmZNn+OVmiki2C5eR8czXIllmzGU
         +8wnhWSwIQZG7SdtPTd5I3EqzdWBQLad+7WgzUvepnJtJd4SKMYy6cycIQr1jhZTl110
         gZ9v0kUimwrU9mygQpuAb9MehBkVlAEoE4fiV4CyU4OlWzC5kpEfkH4+M1cHqKCvcCAa
         b/w/0mhRGLfU6fEhPYpMuAsfUmp64LjivH65Qv+C6ZZmoPN0ODWD1TALAVzBVQV1xwiI
         Q4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701432278; x=1702037078;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFGGsXWJYUMlhTjzhtr1dm6frB37gIvfJ6/goCKEQzA=;
        b=GDNB7h9aGprSpvugFhDTExNdBRvbuo75iPqJG5re1+1vmAdX5pwxqy+bUKOpp87Qhe
         bCVnbM48kQwruX+chKRTalsfB5RxhK52O9/btv1mC0UXtD+kuGBMk27+U8mNKkyYUnPO
         rTTY1OkxleelllZUW2HsRvpF02g0eK8ln2bDyuEoxY6BndLSg7hTPhUy5+Nc0escDcLz
         tJYJGTz6/pJJa7huShlVrWv7lBPvED7WQodiPc5EBf+Q/FmqQbZ1GsG9sSgj+NZ5X3y5
         7ZuSIVCQUURg+WuRD/0JfAYnz8ZHS/GBVahD0Q6Zk7RqiIu2PzpQXSfa5mGE6sLxJiTa
         IY6A==
X-Gm-Message-State: AOJu0YxvGRHrUmEXyVWgBmQhxd87DwEf4SFI4CeuQp2+mDwudscZfTG0
        iU1vzact/mCqUjd8PdT7RdbDAazmiYA=
X-Google-Smtp-Source: AGHT+IEnxB85obz7UrlnLFd8Xc1Q/asbLoYqk3628y9z9E30U/uaNuCiNZIvHZNd4cFI048rueVrjA==
X-Received: by 2002:a2e:98c5:0:b0:2c9:92e7:8fb1 with SMTP id s5-20020a2e98c5000000b002c992e78fb1mr704815ljj.1.1701432278016;
        Fri, 01 Dec 2023 04:04:38 -0800 (PST)
Received: from [192.168.20.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id p16-20020a2e8050000000b002c9ab8665dbsm403556ljg.90.2023.12.01.04.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:04:37 -0800 (PST)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
Date:   Fri, 01 Dec 2023 13:08:45 +0100
Subject: [PATCH] Input: pxrc - simplify mutex handling with guard macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-pxrc-guard-v1-1-38937e657368@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMzMaWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIwND3YKKomTd9NLEohRdA+OUZGNTc3PDJGMzJaCGgqLUtMwKsGHRsbW
 1AC+uBKZcAAAA
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2490;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=J2aDNtOKerDabG3xq6vc6cmVNSqHopFyVOYoNyDWuQo=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBlaczhURCPEHjCdUwlcntauD9yDr9AAr6z+3Rwf
 e0nauU80ayJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZWnM4QAKCRCIgE5vWV1S
 MsqeEACS9xZqI63uQ+PRWyyLHL1fWX90zwOpX67UIu4hI9EE4MrYoUKaRQDuGXQbbMXBubMNL5I
 bGCXnY1SXw0kQKRf48Vmb6l0ODAxwNzWDYftp1cPbtr0wUQQtUZ+V/vkms+uZW/pmK/BIL/XDXn
 jSydZZMTtOVS2H0WmIPeEA9Cqyn0WSc+3SorhdLIVMdlUKILnhqWGkiU2111BqdkUb40G9hUW0X
 USdMmBDkBfwYAWJ1vpVkjdXmtycYBGdbB7AI86jQh9aO+ypySTgjEYNg/m/ozZPPNH16B0rHIFS
 8UhMqZ7gNpGUUuozxFoNi+EjePJSa6LA/BKrrerDU/P4iExnQUQzYmHuaP6e6hEIO8fghF2KHkH
 nLBRRoRGmuAx0ms5mYiboUqXxqGy27nnLpJz8Xl9gIUxh68pRaUZvwgNoRJX2Zob6BFxSPPb6iC
 88MAjDVmULiCRh7mvQ7Gzko4sJZyZuOoDKlCjNX3DxPl2pN12dFDUOhHjXoyZJIiM1563C3sgn/
 Ei2RuxHlWSD88j40GTNkgdApkyCGBPo30GV9Fkw4T8Y9hoeBX4WTTHaGErP976LhbjQWZXjVQqC
 qeIAtq9cB8MGCAzRP5SNCl6ZwRh87sjWONwGqTlAnLZgPEywSnejsso/wTr9otMgLb6358V35yf
 6hVXp2bvRMQ3nZA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the guard(mutex) macro for handle mutex lock/unlocks.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/joystick/pxrc.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index ea2bf5951d67..3c3bf7179b46 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -5,15 +5,17 @@
  * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/cleanup.h>
 #include <linux/errno.h>
-#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
 #include <linux/uaccess.h>
+
 #include <linux/usb.h>
 #include <linux/usb/input.h>
-#include <linux/mutex.h>
-#include <linux/input.h>
 
 #define PXRC_VENDOR_ID		0x1781
 #define PXRC_PRODUCT_ID		0x0898
@@ -89,25 +91,20 @@ static int pxrc_open(struct input_dev *input)
 		dev_err(&pxrc->intf->dev,
 			"%s - usb_submit_urb failed, error: %d\n",
 			__func__, retval);
-		retval = -EIO;
-		goto out;
+		return -EIO;
 	}
 
 	pxrc->is_open = true;
-
-out:
-	mutex_unlock(&pxrc->pm_mutex);
-	return retval;
+	return 0;
 }
 
 static void pxrc_close(struct input_dev *input)
 {
 	struct pxrc *pxrc = input_get_drvdata(input);
 
-	mutex_lock(&pxrc->pm_mutex);
+	guard(mutex)(&pxrc->pm_mutex);
 	usb_kill_urb(pxrc->urb);
 	pxrc->is_open = false;
-	mutex_unlock(&pxrc->pm_mutex);
 }
 
 static void pxrc_free_urb(void *_pxrc)
@@ -208,10 +205,9 @@ static int pxrc_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct pxrc *pxrc = usb_get_intfdata(intf);
 
-	mutex_lock(&pxrc->pm_mutex);
+	guard(mutex)(&pxrc->pm_mutex);
 	if (pxrc->is_open)
 		usb_kill_urb(pxrc->urb);
-	mutex_unlock(&pxrc->pm_mutex);
 
 	return 0;
 }
@@ -221,11 +217,10 @@ static int pxrc_resume(struct usb_interface *intf)
 	struct pxrc *pxrc = usb_get_intfdata(intf);
 	int retval = 0;
 
-	mutex_lock(&pxrc->pm_mutex);
+	guard(mutex)(&pxrc->pm_mutex);
 	if (pxrc->is_open && usb_submit_urb(pxrc->urb, GFP_KERNEL) < 0)
 		retval = -EIO;
 
-	mutex_unlock(&pxrc->pm_mutex);
 	return retval;
 }
 

---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231201-pxrc-guard-03dc35771b36

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>

