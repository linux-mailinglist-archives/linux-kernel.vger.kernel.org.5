Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7CF7FC906
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjK1Vxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjK1Vx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:53:27 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4264AD5D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:53:34 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77a453eb01cso319195985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701208413; x=1701813213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TajWNb6t94eI72grT/BNIlEfldBslVEJjpPP4Fw+5CE=;
        b=auHt8sq8z/bV5pf2W0Ywsg+2BV3Z49M5WRcJgbGFv9ijj57mPyJCEWzvjzepTtrVk4
         AGRqKaOJy+VdyNRQJTfBAU8WTTHPuibONfotDXUPbP5/eFI2Y31v7a8jRkv9CZjjChy4
         OvHRy6UL5m7T4a+rnD2B8F1zrSzkYsR4pW4RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701208413; x=1701813213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TajWNb6t94eI72grT/BNIlEfldBslVEJjpPP4Fw+5CE=;
        b=hw9ShrnH855e9klbEj3gANoLBgFLKJlLdBbJmrzvI/AIB/RDdqcC9lyRX48S9uO1+M
         DJ+ioJynCN1wneGbbZ3a/aCI84Y00xHpD9qrV4Ou4h5+Uz/71VSMMzgg2CLfgsx0QRtG
         /RIsIQzcc8E1k6tnGCAo1kU8unp9EulBxcwJEjgzXUp7vZTZhovZc+OoLloR7gmcbF6Z
         AcUG6YbpIu5S2LkRdXO1+Cbi7Z5jORFFABTDt/QgUJR7DzCaSxm5S5tGgaHePcCZkLmf
         419lV9uK3ITSLXdclGgj7JlogoIMWbrWi8YWdQ4yRn5n+0n1RFsNHP+v+q4I8ryqEmh1
         53MQ==
X-Gm-Message-State: AOJu0YzR9oz5RvRG6kjTaV/2+NnQx2J6EMXglplF2MbgNN6w/vx71x7u
        EWrs7ghkBa7OVpHp+uMAmPtyMp6hpbnMuLXYRLrONw==
X-Google-Smtp-Source: AGHT+IF+BiZT25SBF1s07utqoXa/9+AfTrzu2F1UN/e7OZ2tZTGEDW9QrPkA3aRgkFwpu/5wm4X9Sw==
X-Received: by 2002:a05:620a:8390:b0:774:35da:75ac with SMTP id pb16-20020a05620a839000b0077435da75acmr19458381qkn.55.1701208413129;
        Tue, 28 Nov 2023 13:53:33 -0800 (PST)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with UTF8SMTPSA id i16-20020a05620a405000b0077da4bc07afsm2261753qko.121.2023.11.28.13.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 13:53:32 -0800 (PST)
From:   Esther Shimanovich <eshimanovich@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-input@vger.kernel.org,
        Esther Shimanovich <eshimanovich@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jonathan Denose <jdenose@chromium.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH] Input: i8042 - add noloop quirk for Acer P459-G2-M
Date:   Tue, 28 Nov 2023 21:48:54 +0000
Message-ID: <20231128214851.1.Ibc66f1742765467808fb28a394f8f35af920aa49@changeid>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Acer P450-G2-M, after the user opens the laptop lid and the device
resumes from S3 deep sleep, the screen remains dark for a few seconds.
If the user presses a keyboard key while the screen is still dark, the
mouse and keyboard stop functioning.

To fix this bug, enable the noloop quirk.

Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
---

 drivers/input/serio/i8042-acpipnpio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 028e45bd050bf..b81539bacb931 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -941,6 +941,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
 	},
+	{
+		/* Acer TravelMate P459-G2-M */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate P459-G2-M"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
 	{
 		/* ULI EV4873 - AUX LOOP does not work properly */
 		.matches = {
-- 
2.43.0.rc1.413.gea7ed67945-goog

