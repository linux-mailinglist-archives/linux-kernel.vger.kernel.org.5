Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D6D792B13
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjIEQrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354883AbjIEPaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:30:08 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDFB197
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 08:30:03 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-412091b9035so17941581cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693927803; x=1694532603; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6W+TfrXmtjK34RUfVd7nGUPmJuAkk0DxWpwHLygpJ3U=;
        b=OZudrJW53VISzHcSQ22P4UL4IoATzRwCV561vMFCBB0S1O1pfKWlzc1lN1DpSlvwbr
         o111Po6X2gKWlwbvoV4ronrrz0TqveBv64wqI5j9AtjSPauvGI9CJwPTiHMbyVSa1WL1
         HvEF9HGicQOdha8PrsSrkI9ceGJzqhXyRhNX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693927803; x=1694532603;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6W+TfrXmtjK34RUfVd7nGUPmJuAkk0DxWpwHLygpJ3U=;
        b=OVNUpTtNsZvD21uxKohk9mjMM4OTPzyrqhu3pOryuTieG/hIoZoJLQBG9/k6I/d5f6
         f0gjqXEKcMx00nk+lL5XVIEWbOsg5TuFQmUb/VS3WW0Ub6+P/QO/N6pQHInqUx4yJTk+
         BUExf9iKZ6AOncGXeaSc9r4z62b/Q+tCkaAmxEaw/1Ds4e2H2oqqTDCEGUhiNwhbKMSM
         XZBPVHRdD65AE8jaL3Lee59C7fl5Rfugso2w7lEUrhCcsrdBhOxvaVgPoq43Lwp+VTe0
         hydUwI6SF7OMhlRq9Ls+S4hHoDrYxdrvyUuD4zrCbutM2p4k05nWKDTnewzlRRYBqBhs
         +1Vw==
X-Gm-Message-State: AOJu0YypFqI+T3KgP+mULBjml/GGuCG4nh40zkQk6NmeqaL3sKxBfRz7
        d1Qr1gCreOlVWOGyaz3aHxXUyA==
X-Google-Smtp-Source: AGHT+IEQFo3g2YFqBxE2kIB03JTfw9xkEk6xbsE4/FEYCt0KvdZMdDVV1Yv6YqMq8bu3dlKWF0b62A==
X-Received: by 2002:a05:622a:110:b0:412:6db3:eda9 with SMTP id u16-20020a05622a011000b004126db3eda9mr18573275qtw.58.1693927802873;
        Tue, 05 Sep 2023 08:30:02 -0700 (PDT)
Received: from denia.c.googlers.com (122.213.145.34.bc.googleusercontent.com. [34.145.213.122])
        by smtp.gmail.com with ESMTPSA id d4-20020ac84e24000000b0040ff1b4b400sm2642301qtw.73.2023.09.05.08.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 08:30:02 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 05 Sep 2023 15:29:52 +0000
Subject: [PATCH v2] media: uvcvideo: Fix power line control for a Chicony
 camera
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230817-chicony-v2-1-88335519989d@chromium.org>
X-B4-Tracking: v=1; b=H4sIAHBJ92QC/2WNQQ6DIBREr2JYl0bQYttV79G4APzITyqYT0tqj
 Hcvuu3yzbzMrCwBISR2r1ZGkDFhDAXkqWLW6zACx6Ewk7Vs6qvouPVoY1j4zTYXJ+tWWeVYsY1
 OwA3pYP3uzy/HSWcIezcTOPweL8++sMf0jrQcp1ns6f9+FlzwTpkB2kE5p8zDeooTfqZzpJH12
 7b9AKWuN8G9AAAA
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device does not implement the control properly.

Fixes v4l2-compliance error:

info: checking control 'Power Line Frequency' (0x00980918)
fail: v4l2-test-controls.cpp(552): could not set valid menu item 3

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
This camera, like other Chicony devices, do not implement properly the
Power Line Frequency control.

This time, I do not have direct access to the device, just to the
report, but since other devices from the same family are showing the
same error, it is safe to assume that the same fix will work here.
---
Changes in v2:
- Fix IntefaceProtocol, the camera is uvc1.5
- I managed to write 0 to the control, so the proper quirk is uvc11 not
  limited
- Changes by Laurent:
	- Rename device
	- s/v4l/v4l2
- Link to v1: https://lore.kernel.org/r/20230817-chicony-v1-1-76bde4d6ff6b@chromium.org
---
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 08fcd2ffa727..4b5ea3501753 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2592,6 +2592,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
+	/* Chicony Electronics Co., Ltd Integrated Camera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x04f2,
+	  .idProduct		= 0xb67c,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
 	/* Chicony EasyCamera */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,

---
base-commit: 4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
change-id: 20230817-chicony-9c35f2046c6f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

