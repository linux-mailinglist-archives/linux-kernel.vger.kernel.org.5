Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2F77FFBD5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjK3T4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjK3T4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:56:31 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C6010EF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:56:36 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db5311eab29so1259755276.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701374195; x=1701978995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ylcdNyt/KgUOR07ZWWJkcl4KatMQeoh7FaMP2m7i8c=;
        b=Pyc5AnrNfKBSmzjlMHMk6HGki80P0UphIlXxWoSQ7dKgwdElDeE40x82eryEHct3JZ
         qPWtB7g+HlWeY6q2zVZ0qkeiyHrzZExYReGMu3aKEqxOyflrkBTTLIl8ohYBovnJyI7N
         cGupptA7UTgerChxc495dD0abjr12IN5F6m6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701374195; x=1701978995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ylcdNyt/KgUOR07ZWWJkcl4KatMQeoh7FaMP2m7i8c=;
        b=D/iRjwxUR9SAE/zDCbC7P69FNbyK6tF9iRAh40y146yKLPr9XhIl16iIYqf55tQY+/
         /IUFGzIzHWgh9kIB5dfJh6Lm47fEWJxOMnRgCgq4xfupYtXM/yualhGURUzdHJnfzQbA
         e4x705alCleyh0tYFNNns+zrZOQMA9+FFsLwc4Zn+WrRGehMEE3ihHCgiI43RPno+49s
         l2LEb9qPEzfPCx+N/xWfTVFX+0JJg6FG4De5aXE26H/qEl6Ygh7JIBXzB4R5EOBdXaAE
         t1Q09ASO6xFJNFhsiH9Roxoy0tt2e5RVNC5lxnukyucr/8xYEu8no/TewNPevKLzGa+o
         eaeQ==
X-Gm-Message-State: AOJu0YzN9OS8ENMLvxD2Kkiau32iwzb2ecHGvfh2cya5FhWIImPBYYA4
        /hsOx0HNWRwnbyrOpZwA4KcLBmGtfU6kySbqf2U=
X-Google-Smtp-Source: AGHT+IEkuCKfvEd40usAvYx3mzY4LjwGa+9w3CAhq7hGzQiQ4JddG3l9cvrLwAGDY9oCbg8YNLpnRg==
X-Received: by 2002:a5b:a52:0:b0:db5:d88:d463 with SMTP id z18-20020a5b0a52000000b00db50d88d463mr8689641ybq.51.1701374195338;
        Thu, 30 Nov 2023 11:56:35 -0800 (PST)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with UTF8SMTPSA id c15-20020a0ce14f000000b0067a39a44ca5sm769778qvl.77.2023.11.30.11.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 11:56:34 -0800 (PST)
From:   Esther Shimanovich <eshimanovich@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-input@vger.kernel.org,
        Esther Shimanovich <eshimanovich@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jonathan Denose <jdenose@chromium.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH v2] Input: i8042 - add nomux quirk for Acer P459-G2-M
Date:   Thu, 30 Nov 2023 19:56:19 +0000
Message-ID: <20231130195615.v2.1.Ibe78a9df97ecd18dc227a5cff67d3029631d9c11@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
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

After the laptop lid is opened, and the device resumes from S3 deep
sleep, if the user presses a keyboard key while the screen is still black,
the mouse and keyboard become unusable.

Enabling this quirk prevents this behavior from occurring.

Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
---
Hello! Thanks for the prompt response. I had previously tried the
i8042.nomux=1 quirk which didn't seem to work. But I was trying it
together with other quirks, which may have changed the behavior.
When I applied the nomux quirk to the driver, that did fix the bug
on my device. Submitting the new patch!

Changes in v2:
- change noloop to nomux

 drivers/input/serio/i8042-acpipnpio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 028e45bd050bf..612c4e3427cef 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -360,6 +360,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
+	{
+		/* Acer TravelMate P459-G2-M */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate P459-G2-M"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
 	{
 		/* Amoi M636/A737 */
 		.matches = {
-- 
2.43.0.rc2.451.g8631bc7472-goog

