Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD30380F563
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjLLSUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjLLSUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:20:35 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA4FA7;
        Tue, 12 Dec 2023 10:20:41 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b844357f7cso4549044b6e.1;
        Tue, 12 Dec 2023 10:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702405240; x=1703010040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MG0kHx/oifOSLDd2eZhcCz6WYCO6nowTVaZB71maBP0=;
        b=gq2kTEJSg84MRS7n0cUDnmcRSJQOzNcEojXUhDHyfEI1T0gllppWlDxY2d1zS9AdaI
         jXsx187B24HB6gUIgfQmX01J7n/wrEwWVRyEDfxwfRY0k7BC14tP1bAHi5gBLnLuWQS3
         a75WMFJVSmyDCvyKi2A7O5+3Mk5lbtFAifW+tQ1SgDy1Igzq/g6Yh1BmoxwOxijAsvIR
         cjk2EseqPNWF5Z23Yz/Jp/26g+vQ4U4+KzqU+BNpgtRAkkGyMQghfm5rSIUys+QThpJU
         48ChiR4xPkaCQwNPrz8i4uwEAzf0k0/Zq/PCKE1PZx9Dj3GBssewqkne6cablCwzpdLJ
         aPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702405240; x=1703010040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MG0kHx/oifOSLDd2eZhcCz6WYCO6nowTVaZB71maBP0=;
        b=f2s9Z/hOX4ZQ3PV9zmUD4nXX77u5zj4HaBo0BPeWjzxv6hZz/2AvB6CVyAMD0otvHg
         BTFt8SyGEge/wKudgoXLBTxxhC8KGoZd5KYkanGFfZFV3nQRev3mTKYtQzIiVKf0se1n
         +N/fdscAv7yCCUlAxQzaASYFs7wEZVAL5cmcgBFpYDS0LzSGLci2QB45rtw8z52KNm5H
         +lm0XjM36igzE1XA5JG74GL9qE7DKDLNJSH7wwFKCN9DaBdtD2vyxkztjVVq+shSZkMz
         twvtYYhWB871qm5iAjvPQJNagUMk4FMn+JwD8/lS6Sfy44kPDsrmH8KrYcGnD+miP86V
         2ImQ==
X-Gm-Message-State: AOJu0YxctfwXkRVZGe7oWam2YLFj4R/N3RHxyNKH8Yb+/o4IFR/PqfdJ
        X9nLmLHZAdstRdHl11c4OwU=
X-Google-Smtp-Source: AGHT+IEbyC8pFG5dVcoSLt1h1Y4Z3LT9BkhG8TpLrj13m7XRTV+HO2+ACG1zAELEOTTAU4xGc0YHHw==
X-Received: by 2002:a05:6808:2125:b0:3b8:b063:6b96 with SMTP id r37-20020a056808212500b003b8b0636b96mr8916492oiw.69.1702405240547;
        Tue, 12 Dec 2023 10:20:40 -0800 (PST)
Received: from guyc-asus.. ([173.216.104.94])
        by smtp.gmail.com with ESMTPSA id q11-20020a056808200b00b003b85dd815bbsm2483053oiw.53.2023.12.12.10.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:20:40 -0800 (PST)
From:   Guy Chronister <guylovesbritt@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: google_hammer: Fix invalid ENOSYS warning and unsigned.
Date:   Tue, 12 Dec 2023 12:20:38 -0600
Message-Id: <20231212182038.28530-1-guylovesbritt@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed warnings about ENOSYS and bare unsigned without int.

Signed-off-by: Guy Chronister <guylovesbritt@gmail.com>
---
 drivers/hid/hid-google-hammer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index c6bdb9c4ef3e..d567f020bead 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -324,7 +324,7 @@ static int hammer_kbd_brightness_set_blocking(struct led_classdev *cdev,
 	}
 
 	ret = hid_hw_output_report(led->hdev, led->buf, sizeof(led->buf));
-	if (ret == -ENOSYS)
+	if (ret == -EINVAL)
 		ret = hid_hw_raw_request(led->hdev, 0, led->buf,
 					 sizeof(led->buf),
 					 HID_OUTPUT_REPORT,
@@ -420,7 +420,7 @@ static int hammer_event(struct hid_device *hid, struct hid_field *field,
 }
 
 static bool hammer_has_usage(struct hid_device *hdev, unsigned int report_type,
-			unsigned application, unsigned usage)
+			unsigned int application, unsigned int usage)
 {
 	struct hid_report_enum *re = &hdev->report_enum[report_type];
 	struct hid_report *report;
-- 
2.40.1

