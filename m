Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CBC77F67E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350885AbjHQMil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHQMiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:38:15 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98503271F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:38:14 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6418c819c3cso35634166d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692275893; x=1692880693;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUdVhj0ALIzjhCaAziKr2GAojaQsEAHnyIShQwoSvjs=;
        b=Ml1CrhZ42fDMxkxMto37w+tczDqJUjteWrLleKqCF2KvReoQMdR1bg/BP//xS/kpde
         H3NZcnAJtGsSR1Xr4YtIQoTzj9r3bXZiASg8yj6GGj0L8AyystAmt4r64AYt5uWrgX1+
         V2RGGyB59DHqeY/lxQi5SvJOF4ZDIJ+z/SNcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692275893; x=1692880693;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUdVhj0ALIzjhCaAziKr2GAojaQsEAHnyIShQwoSvjs=;
        b=eCSm/H6AYrzI5FZlPacwsfWdKQmxHajfd8Pia8LUWrSqeAIha1sZm43dQ29YYU103z
         cLjP6VCZOAlAZgSbKgGxkkXcjnG9Z/wD2uiVSXMaVzacwXQ6tayUmWDqoEG1T9bUQMgC
         F6wt4jkWSkNyNRIote4tjxqJiq4g6cXaFgKlx/Ylg9iVREOtgaoGEFE05sV6EQyhFcvb
         39dsPuBCJchX7cf/uRSq3vFduMAGRsFrO06f3ckO8LSddpfvQfV5vNrDF8h5AL7A4OwH
         dimRr74AnanWWJ07baFVB9b6qk9eoRx08OX5nu9FMXK6UzjvSgAZciZWBuB13zJQIkff
         H+DQ==
X-Gm-Message-State: AOJu0YwUgccmicnfYqAYdsDCjZtgE3p7HNddhp5KXv4/4kQb+x6saif7
        A7gJ75Tu0xFplzGg2VZ4ODaTFg==
X-Google-Smtp-Source: AGHT+IEmdLIBX4TcduDSnebSMlZV9RYUgLFDw6JyS8Q64QUNaAtypqYuQsSEQOyKRfaSNE2ThLHmrw==
X-Received: by 2002:a0c:aa96:0:b0:649:bf3:6dc0 with SMTP id f22-20020a0caa96000000b006490bf36dc0mr3988634qvb.39.1692275893731;
        Thu, 17 Aug 2023 05:38:13 -0700 (PDT)
Received: from denia.c.googlers.com (122.213.145.34.bc.googleusercontent.com. [34.145.213.122])
        by smtp.gmail.com with ESMTPSA id o12-20020a05620a130c00b00767cd2dbd82sm5108761qkj.15.2023.08.17.05.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:38:13 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 17 Aug 2023 12:38:04 +0000
Subject: [PATCH] media: uvcvideo: Fix power line control for a Chicony
 camera
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230817-chicony-v1-1-76bde4d6ff6b@chromium.org>
X-B4-Tracking: v=1; b=H4sIAKsU3mQC/x2N0QqDMAwAf0XybKDWzam/MnyoWboGRpQUZCL++
 +oejzu4AzKbcIaxOsB4kyyLFmjqCigFfTPKqzB451vXNw+kJLTojgO19+jdraMuQqnnkBlnC0r
 p6tdPRAsb6+VW4yjf/+U5necP/GwcPHUAAAA=
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device does not implement the control properly.

Fixes vl2-compliance error:

info: checking control 'Power Line Frequency' (0x00980918)
fail: v4l2-test-controls.cpp(552): could not set valid menu item 3

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
This camera, like other Chicony devices, do not implement properly the
Power Line Frequency control.

This time, I do not have direct access to the device, just to the
report, but since other devices from the same family are showing the
same error, it is safe to assume that the same fix will work here.
---
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 08fcd2ffa727..db2556e95b72 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2592,6 +2592,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
+	/* Chicony Electronics Co., Ltd */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x04f2,
+	  .idProduct		= 0xb67c,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
 	/* Chicony EasyCamera */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,

---
base-commit: 4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
change-id: 20230817-chicony-9c35f2046c6f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

