Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B75800B7D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378939AbjLANMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378922AbjLANMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:12:53 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9278710D;
        Fri,  1 Dec 2023 05:12:59 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bd8efb765so987389e87.1;
        Fri, 01 Dec 2023 05:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701436377; x=1702041177; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AjyqWLSmP05fxX/Y2CUMDmYvLGb7hv9oWylOkZNdwF8=;
        b=b7rURTol3Ty6IQWmeHGYk+DXRPBDXyodjNySTVVN7pbYTI+QqDw8wGOySYdD354ns+
         bD9EDvbmXLrgJQg6TTAq+LVz90Qo/UQs5N8XgnO3LJKSResFBdalAUfD4H7l7gaE96OB
         XuPSZF92K8i8HBjUtd8xqyK39SrzVbkE/dfTPkhVwYwSCsk+xiik6gXZf76WyaAmKRMG
         Oyvm5bKRL9h4GwBqWDultCVUAei6wBMMV+voxsKOJVt4fNUQCLi/q22fFKexd5O5ObT4
         sT8VYR6m+fFLXj596U3AQz8BF++uzWKZc0sAnslCIg6vKJu8FOVHoGMw3ngycqFUDDtW
         DJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701436377; x=1702041177;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjyqWLSmP05fxX/Y2CUMDmYvLGb7hv9oWylOkZNdwF8=;
        b=BH2cH135Wlg7vQT+Vwi02k1PZo94KPiV28TDDlizN7zCKZwwsoXi/j8LzVotfFJ9X/
         8UlmtA2kYi2oLrulGR6Mjsd2lyhE0672ickf/ZdMuuxyy42qpBKh05ucelbLtJhpeSDg
         GCf1uIYTAk4lWewAXMlsdBOj0y4Sav4jV2T/kx2sCghb/traubAkgMaLGgvbWcAMilci
         +eE4F4pf/ubOz/iWFW56u3egtWFEiJTDUVNSWya+sYyVw+kEaEc36DKpiymws4nMegBd
         G4Okg/VNShzLKykxIyHOiPrgT29IaIL/kNRDFIB3WYW4IHn0dMIRsmYW8LkoMA1x0Crq
         rhBg==
X-Gm-Message-State: AOJu0YzTPJUF7OAFyUtHXX1sTQMrmTw3UUgGlfQXeEfE/eaPRMjVgNB2
        DGGl6UkP14wQvJQCnlfYdlpiAU95oFY=
X-Google-Smtp-Source: AGHT+IHUF2tY1y7AXzdbrzQwSmvwFhjYcu8IAXD6Fi9CRr8PenxUoYoh53kZrm4kEa0E3BgBovMPjQ==
X-Received: by 2002:a05:6512:23a5:b0:50b:c3b9:76e1 with SMTP id c37-20020a05651223a500b0050bc3b976e1mr776137lfv.37.1701436377106;
        Fri, 01 Dec 2023 05:12:57 -0800 (PST)
Received: from [192.168.20.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id v26-20020a05651203ba00b00507a66f747csm420907lfp.30.2023.12.01.05.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:12:56 -0800 (PST)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
Date:   Fri, 01 Dec 2023 14:17:13 +0100
Subject: [PATCH v2] Input: pxrc - simplify mutex handling with guard macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-pxrc-guard-v2-1-714779672bc8@gmail.com>
X-B4-Tracking: v=1; b=H4sIANjcaWUC/23MSw7CIBSF4a00dywGuClUR92H6QAB6U3sI6Ckp
 mHvYscO/5Ocb4fkI/kE12aH6DMlWuYa8tSAHc0cPCNXGySXKCQXbN2iZeFtomMcncVWa3FHBfW
 wRv+g7cBuQ+2R0muJn8PO4rf+ZbJggmF3Qe1Vq1F1fZgMPc92mWAopXwB41haGKQAAAA=
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2831;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=Io5ea7Dmw9B+JcwG48J2CQVafp3mDV/lXy5QHkwQuNQ=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBladzkuMQ7IbZDJlFR+Aw0hV2XtiuCQiDvOQ0qX
 YnATZp6f4+JAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZWnc5AAKCRCIgE5vWV1S
 MmSqEACZIuTuuXzVNkoEkDoDYoDotXDzrQVuA6cp+wBPHN23lQcCQytOfEiE4A2jMk4r7czQcSx
 jLdzJbjNLA8hB7mjSSgmCpjefBZDxKbS52gMWmRQav0yOXCM/7xjxsESbCl9Oa4iimT9GLHEwdq
 LDjbJjc7IKxxRpPi+2ofsLQZmnjhECvJA2Ieu0O5xJxPfMrFuI0eTc5dzyriUhPiCjKtFsXdgXz
 NN+i62xSa29k9k+pLHuQnd0DTVLyBYC08KILyq7f/lytoqdrtP9RwB518xaxcy/cWciZKhPob3n
 83RzttjQrPwX21q2CViMRKOpRXpfKMqMvMmK03ZqmdHKikbHaOlyEYla8LeSCvGNCpoB+/Ono15
 KG+OVlgCncJTd7orHceYt+NE1Igm03T7mSqyXnBmULMrgVWG7UuCJ20DBf5lRelgrwoy6hiBJXA
 s9He1TBi+rl0j59h4HP47aPhtkeHP7NV6/P/pvm6cYAJBdDzhIBsD5nowKcuDPqSsi8njBn26NF
 ZGFCbGIEd3o6q0h2LYF4JbkcPZpsKRhZ0sE/bRbNq/VxtPRuhWhcwm9+p0p6h0vBCXyBv3206sn
 set+QQ+4uj8Eh8LrDbGr6GTjbZQTe21vxmisYwC5+8aQxXZuUtMB7xvrFAP/VcUNnXIDzDpk96a
 A8fhEVHZMrVsnGQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the guard(mutex) macro for handle mutex lock/unlocks.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Changes in v2:
- Add guard in pxrc_open()
- Link to v1: https://lore.kernel.org/r/20231201-pxrc-guard-v1-1-38937e657368@gmail.com
---
 drivers/input/joystick/pxrc.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index ea2bf5951d67..d4b699418361 100644
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
@@ -83,31 +85,26 @@ static int pxrc_open(struct input_dev *input)
 	struct pxrc *pxrc = input_get_drvdata(input);
 	int retval;
 
-	mutex_lock(&pxrc->pm_mutex);
+	guard(mutex)(&pxrc->pm_mutex);
 	retval = usb_submit_urb(pxrc->urb, GFP_KERNEL);
 	if (retval) {
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

