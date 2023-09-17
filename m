Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3590E7A3668
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbjIQP2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjIQP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:27:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF4811F;
        Sun, 17 Sep 2023 08:27:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40472f9db24so36127975e9.2;
        Sun, 17 Sep 2023 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694964452; x=1695569252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/OQx1tSDBSLV+D4ziu7/m5M5iv3V8DehxeIrYNTs6k=;
        b=Ytc/HWWA3p5zxh6JakRudNaXgI+twkdnmUQq47NuopbX7bnclWdSso0UfyJhVlXs2p
         Edq+vcUSI9YguteMiK93br2XtFrNP+LPZaa5SJhDFFuNzav77ZTN+TK67qKTPF6j/BjE
         dUzj8uN+kf4vd5ByP0W0Ji/7/ugm4IdXWL2YcqOF2xK6UK16Ll9IQL7U8IrvcLvj9vAY
         2n06uXoXLr5GDETTWdXZaJH9GaRcyF4eQjCtP+UcJrsXnoIhORfMg2lVUUrpBsN2rmnM
         TUoZFsoGrgyIpMNUCgEozlPT2BeRJD0V0vFhOUHsbdR5Nnvy53+jpyw2fuJ/P0XPSa92
         hCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964452; x=1695569252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/OQx1tSDBSLV+D4ziu7/m5M5iv3V8DehxeIrYNTs6k=;
        b=SNEVZSYKMjyz01UmGZGoe9CBdDBt7R8jQc5TBam9vOoXdrH2ll3vx3dkHi/W1CbzQf
         71PdwL+9SGifPdsFI07L0fAVPKO9Zv3I25sxaCuOVHjdY4hSo6UqTJ1tUzA61rEw0fJi
         9X/X85RiVYO1s+ayRRl0W2ZDEQYSm2e0EMijtoei/sH5//QFMlZLk/oiciXSZh6AOi7D
         vfMTu/YP7wKiy0s89QzG0wkCzqcUBhzvqsZ7NFahBR8xzpjTL2BEQKiWwvo+vLToGcF/
         JTdZcoGjCRPd0UsOTEiSy9a1OXTy0KPY2fUPAUF0SRd43hpS+dWtpdAw9DwhBKtvQwJz
         bDCA==
X-Gm-Message-State: AOJu0Yy4m6dVF6M7ld1RaNUhtQWj/aW/K87wdTuK8ovyFFUtiH7eHfr7
        3Ijfa/8CQt+FqBLL+jXkidQ=
X-Google-Smtp-Source: AGHT+IHrv5TtM34LmV6LdzcIwq/lFHrevCPfCaGHWAlJA/NCVFP7bCafP4Q+vTdNNEFFZv9aerHxwg==
X-Received: by 2002:a7b:c44b:0:b0:401:b2c7:349d with SMTP id l11-20020a7bc44b000000b00401b2c7349dmr6696119wmi.29.1694964451804;
        Sun, 17 Sep 2023 08:27:31 -0700 (PDT)
Received: from localhost.localdomain ([5.45.134.53])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b003fe15ac0934sm7388865wmp.1.2023.09.17.08.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:27:31 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: [PATCH v5 06/15] USB: typec: Clear dead battery flag
Date:   Sun, 17 Sep 2023 11:26:30 -0400
Message-Id: <20230917152639.21443-7-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230917152639.21443-1-alkuor@gmail.com>
References: <20230917152639.21443-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

Dead battery flag must be cleared after switching tps25750 to APP mode
so the PD controller becomes fully functional.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
 drivers/usb/typec/tipd/core.c     | 16 ++++++++++++++++
 drivers/usb/typec/tipd/tps6598x.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index b3d4b2b5bf5f..3ad8112c78b6 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -933,6 +933,22 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 
 	} while (mode != TPS_MODE_APP);
 
+	/*
+	 * The dead battery flag may be triggered when the controller
+	 * port is connected to a device that can source power and
+	 * attempts to power up both the controller and the board it is on.
+	 * To restore controller functionality, it is necessary to clear
+	 * this flag
+	 */
+	if (status & TPS_BOOT_STATUS_DEAD_BATTERY_FLAG) {
+		ret = tps6598x_exec_cmd(tps, "DBfg", 0, NULL, 0, NULL, 1000, 0);
+		if (ret) {
+			dev_err(tps->dev,
+				"failed to clear dead battery %d\n", ret);
+			return ret;
+		}
+	}
+
 	dev_info(tps->dev, "controller switched to \"APP\" mode\n");
 
 	return 0;
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 5e942c089c27..362e1eca53ad 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -200,6 +200,7 @@
 #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_B    (BIT(2) | BIT(1))
 
 /* BOOT STATUS REG*/
+#define TPS_BOOT_STATUS_DEAD_BATTERY_FLAG	BIT(2)
 #define TPS25750_BOOT_STATUS_I2C_EEPROM_PRESENT	BIT(3)
 
 #endif /* __TPS6598X_H__ */
-- 
2.34.1

