Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E02D801DE3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjLBQz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjLBQzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:55:41 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C0611D;
        Sat,  2 Dec 2023 08:55:48 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bd8efb765so2500301e87.1;
        Sat, 02 Dec 2023 08:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701536146; x=1702140946; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OqM23L3ZBOiFkrQehgKT9qIc91HIQNnBMvZSBVgd4XU=;
        b=FxLGuKWjAKmbiejX5qZYZ9XxjcTjHGvDQKdykO5/9AElm0TADX5p36+JeQKpGgq70V
         Cq+KHMsgfVf7UDYiZ+Hev0pyv1yJBk2+oBXiYzQKuQqaUiVRuO8WRyZwYahcUqeZRElO
         5v6uiEMX0R9PKtAiHC60k6S5DpMn4deftiJFVwJ06/I8l1JHZCymSllyFuwlb3pT6Xgl
         w3HpUgO4fg1ipZU8bMMcNV14AOtS733pFlvnqvambdYpZn9uErmYjJgtDphqGAT+QYil
         eBxCpVLNoxeXIFdy3a3ZYzdrppW8kNRFAkg9tALve2n1Y2LuvhtYKYcIpRWSwWTjKPGU
         5KdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701536146; x=1702140946;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqM23L3ZBOiFkrQehgKT9qIc91HIQNnBMvZSBVgd4XU=;
        b=qM6iNQAjbVl1PHfKuHfnBVToi+JWR/uwOrUa2QWldixT2lGAzDFs1JzN2yNs8uSiAe
         +SFmWZg3eQwzejGa3mvWL1WASw0aoEol1Mr8cCjBLZ1zjHkPyPwQynJ94yd0VBCxw0sd
         yQfSNkzyj5Ro84Q3qqjy+4iEbgAC+4iJdievP3VAlfPFI0e/SwmvJsEEsZ5hE/rxCbZi
         03qtwsjqxUEnbTBu1f4gMuwY+mCpo/mFzvMeZ4nu16/xcgLDpP2cB4OCXLbcJ7VitqYK
         9WtuAS4fPoDDfKuo72mRexqdBtq+1k5tex6scPTRaKyAYUUbixhGwlfIRMt3Gzey79tJ
         4C5Q==
X-Gm-Message-State: AOJu0Yw1PJQ95UtMqICe5KliAxSfDg7jFOaY5z17aew0IOtQ4Z+wy9ix
        n0DqTE9dWMrFPj4pMNwXIA0uKXxKhI8=
X-Google-Smtp-Source: AGHT+IGnGZN3yTELLaOclWjuFFz2e4dOCHO1zuHAZ7JwAp/3pySmAB8nEUrgpPg/0Y7s+Q+4k3qL8Q==
X-Received: by 2002:a05:6512:32a6:b0:50b:c4c3:367e with SMTP id q6-20020a05651232a600b0050bc4c3367emr1813480lfe.36.1701536145475;
        Sat, 02 Dec 2023 08:55:45 -0800 (PST)
Received: from [192.168.20.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id p5-20020ac24ec5000000b0050bed20fba4sm132400lfr.5.2023.12.02.08.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 08:55:44 -0800 (PST)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
Date:   Sat, 02 Dec 2023 17:59:48 +0100
Subject: [PATCH v3] Input: pxrc - simplify mutex handling with guard macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-pxrc-guard-v3-1-2ca8bc8cf689@gmail.com>
X-B4-Tracking: v=1; b=H4sIAINia2UC/3WMQQ6CMBAAv0L2bA3blS548h/GA5QKTYSSVhsM4
 e8WbiZ6nElmFgjGWxPgnC3gTbTBujEBHTLQfT12Rtg2MchcEsocxTR7LbpX7VuRU6upYMaGFKR
 g8uZu5312vSXubXg6/97fETf7cxNRoKCyIjaqYFLlpRtq+zhqN8C2ifJ/KlPKeGKuFMtGf6Xru
 n4ABiHEQ98AAAA=
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3397;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=rp2QrbcyItVfZQOhCeBm/WAOyO3FQQkXSpIoX1Nfpzk=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBla2KdEzLLTcPVc1Vh0+mMELnAP9qdICs2kMVwm
 LKEeqWSu5mJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZWtinQAKCRCIgE5vWV1S
 MkV5EADU4J8H+rAaeTTwC9N8hdh0wBiXtFOQUV22PtuZuyWTxFqhCsm1ltuIj4bvSLpK2vcXdNO
 cOgTMQj76lRYsagmLFCuhXpHMCNg/s6BxfdIVQEE0ywXGMPZCkclJ9Tp9SxurvRuuau+gDk6yIP
 aiuUxXCONWDZylXnh5W78Yhygmj1Hs8/S7isC5OP0vM9RVcI46ICew5fT6Ml5JYARaASQvL+ksu
 Xuc/NBvcY7bKgfdYXL4UoPuaujhJPFaTuOEbREOE1tbkHHXTQ2ren+ItLppHOWkQLO2+D5nECi/
 3QquCvb1jZJgW/hnOmXr94nrzIDDu8qo+OvEFYXC0Xg9ADVLp4EgPKyjkQOmBbBRFZh6NXrpEIP
 1hEegWbtZ7mk0dO8L+GxuSiT3/RMHGzUxu8iNogbNY+hiuzQ4LKwYZIAjDu9d8KIxqu7bYY4ZqD
 5Qn0VaYyBtJ4l1S1St7SZjqBlMOtNTpg6r+ZPT9Xsm+S7NZUwKwtaCepr0uF9P+fGLblE/DF9ol
 uEIakFUY/RifcWtB+8fuAEiJBP3gVxQPBduUIYPaafi2x/9Q9I1UpfTjvT06VVtV5hDSR4Ewp7S
 T2QbayPNn3aXqVEbMe1ukm9CFe0DKYeK1i0e7A1NQy1nSl0dhdyxUGPqmfqa4p33ug6q+ZoP5Ec
 Oxp9Fci8x79l5uw==
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
Changes in v3:
- Rename retval->error in pxrc_open() as it now only holds error code
- Return early instead of assign retval in pxrc_resume()
- Link to v2: https://lore.kernel.org/r/20231201-pxrc-guard-v2-1-714779672bc8@gmail.com

Changes in v2:
- Add guard in pxrc_open()
- Link to v1: https://lore.kernel.org/r/20231201-pxrc-guard-v1-1-38937e657368@gmail.com
---
 drivers/input/joystick/pxrc.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index ea2bf5951d67..52d9eab667b7 100644
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
@@ -81,33 +83,28 @@ static void pxrc_usb_irq(struct urb *urb)
 static int pxrc_open(struct input_dev *input)
 {
 	struct pxrc *pxrc = input_get_drvdata(input);
-	int retval;
+	int error;
 
-	mutex_lock(&pxrc->pm_mutex);
-	retval = usb_submit_urb(pxrc->urb, GFP_KERNEL);
-	if (retval) {
+	guard(mutex)(&pxrc->pm_mutex);
+	error = usb_submit_urb(pxrc->urb, GFP_KERNEL);
+	if (error) {
 		dev_err(&pxrc->intf->dev,
 			"%s - usb_submit_urb failed, error: %d\n",
-			__func__, retval);
-		retval = -EIO;
-		goto out;
+			__func__, error);
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
@@ -219,14 +215,12 @@ static int pxrc_suspend(struct usb_interface *intf, pm_message_t message)
 static int pxrc_resume(struct usb_interface *intf)
 {
 	struct pxrc *pxrc = usb_get_intfdata(intf);
-	int retval = 0;
 
-	mutex_lock(&pxrc->pm_mutex);
+	guard(mutex)(&pxrc->pm_mutex);
 	if (pxrc->is_open && usb_submit_urb(pxrc->urb, GFP_KERNEL) < 0)
-		retval = -EIO;
+		return -EIO;
 
-	mutex_unlock(&pxrc->pm_mutex);
-	return retval;
+	return 0;
 }
 
 static int pxrc_pre_reset(struct usb_interface *intf)

---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231201-pxrc-guard-03dc35771b36

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>

