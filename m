Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3947B0B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjI0R5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjI0R5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:57:38 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CF0F3;
        Wed, 27 Sep 2023 10:57:35 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c012232792so200369041fa.0;
        Wed, 27 Sep 2023 10:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695837454; x=1696442254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRvQEPSEiEBX2XgILYaykwXlkKwlukHcD1HvhPUf8VQ=;
        b=Kv6E/GLJshZwmJmVNkVcbOuxJ/yU57YGeaSWbvI1ETHXwfNaHx8IyLNCR9CO5nA4WC
         WFMLLRs5lXxtyc0zdSu0DA3WUm/CUSs01hnQ0LasOszLMgvXXkYRzN7mJJaTdLLDUj4N
         m+iyx6dBfmRs2ZYXtlH+2GVuDx8lFtmrABkCmVG8Q5Wg9uPAq0GXtAzSr21kA+Ufim8B
         p7a8faA91Kbcz5UM+7sBCR9Ho/y/xoOTEq35Tw5zQeLyTg/5Cbgfn+u8Tj07si3413P5
         Po2oBtA6nrnSmWRmK5+2iHNOPrh/BZCO3t/tMPlv6jQ/pamAJX2KKl0o81fJDUJYD8Tu
         Bd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695837454; x=1696442254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRvQEPSEiEBX2XgILYaykwXlkKwlukHcD1HvhPUf8VQ=;
        b=oL4tcT/Pi84xSPmWS6U5g1QQxhzMjVZdph1NR3VMjDOEPy225u0tcHsc4EvuQdLkks
         MaozX5DPjJ4VQ1A4fWgv1TRJ8IzSODWHW1mG0YdMkg4Xkmm6M00ahfLXqpzPZyHYDHRv
         z2UgGatK7Smg4cCLwBf63/i9CfLPnrAGXPEKXhfJM+7pLhY0nrCIOxHQmIqIF9pCeh/W
         PxIxJPntUlbR3iSOg26FpcVzbIXtk5sn22JhVd/H/a7F7oPKsAUF6O9vYe14H5z9u3dN
         agte93HVbh+/yTMx/PB7vE2fFEUlmg+jxkQNKo2nOjP3nZQVWBSPVY0btvOrUM4dHtok
         Zyxw==
X-Gm-Message-State: AOJu0YzMr1qH3z8qioL92m6zXxSl+PQNUAocxDNvzbDqQSEnDHDo94yW
        Pc8b3q21bAKAWw4nZkA61qc=
X-Google-Smtp-Source: AGHT+IFbN9AL+Mtr7T7ESiWlo1UgMb1mrS8iwJl8n3UjfMto5Wb+debHnpMySSqgSMQgEhTCZIA3KQ==
X-Received: by 2002:a2e:9616:0:b0:2bc:cc1a:139c with SMTP id v22-20020a2e9616000000b002bccc1a139cmr2557448ljh.11.1695837453861;
        Wed, 27 Sep 2023 10:57:33 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906370400b0099bd8c1f67esm9654593ejc.109.2023.09.27.10.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:57:33 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v7 03/14] USB: typec: tps6598x: Add patch mode to tps6598x
Date:   Wed, 27 Sep 2023 13:53:37 -0400
Message-Id: <20230927175348.18041-4-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175348.18041-1-alkuor@gmail.com>
References: <20230927175348.18041-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 has a patch mode indicating the device requires
a configuration to get the device into operational mode

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - Return current mode and check it directly
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 32420c61660d..58679b1c0cfe 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -68,6 +68,7 @@ enum {
 	TPS_MODE_BOOT,
 	TPS_MODE_BIST,
 	TPS_MODE_DISC,
+	TPS_MODE_PTCH,
 };
 
 static const char *const modes[] = {
@@ -75,6 +76,7 @@ static const char *const modes[] = {
 	[TPS_MODE_BOOT]	= "BOOT",
 	[TPS_MODE_BIST]	= "BIST",
 	[TPS_MODE_DISC]	= "DISC",
+	[TPS_MODE_PTCH] = "PTCH",
 };
 
 /* Unrecognized commands will be replaced with "!CMD" */
@@ -593,12 +595,15 @@ static int tps6598x_check_mode(struct tps6598x *tps)
 	if (ret)
 		return ret;
 
-	switch (match_string(modes, ARRAY_SIZE(modes), mode)) {
+	ret = match_string(modes, ARRAY_SIZE(modes), mode);
+
+	switch (ret) {
 	case TPS_MODE_APP:
-		return 0;
+	case TPS_MODE_PTCH:
+		return ret;
 	case TPS_MODE_BOOT:
 		dev_warn(tps->dev, "dead-battery condition\n");
-		return 0;
+		return ret;
 	case TPS_MODE_BIST:
 	case TPS_MODE_DISC:
 	default:
@@ -765,7 +770,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	tps->irq_handler = irq_handler;
 	/* Make sure the controller has application firmware running */
 	ret = tps6598x_check_mode(tps);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	ret = tps6598x_write64(tps, TPS_REG_INT_MASK1, mask1);
-- 
2.34.1

