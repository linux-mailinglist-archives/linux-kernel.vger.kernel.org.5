Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945087A3660
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbjIQP2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbjIQP2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:28:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B740120;
        Sun, 17 Sep 2023 08:27:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-403012f27e1so39450635e9.1;
        Sun, 17 Sep 2023 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694964475; x=1695569275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD+60v9C6UaRp0/siQLtHNIFl77ZDBkVdyJlYrRa+7Y=;
        b=Gv1GZU9pH77NwfVpQIXgURem5swR3VLvbLwVzgtCXu+IojZri9otJ54Gj/r1pGOz3Y
         fhffDw+HELJw0TRA+qf0+ZvJJB1AfUzpjXuBS6VFVTvqOIBo2D3894Fyt8AHc00JybyZ
         m+/P2IvvZCCS3/kQn0zW9FQN0+mZ6UeDQSTW/biqvtsBk2bwW4Ez3XhC2NX8NfaMOgFF
         6S+hfweTp9sqY8Mbvb7Lm7RyMVpe8ooegY1DXeR+8wet3M8KTJlUFKyK9oMiZ+zoTwya
         nHxIwKmAIDzu4fbrwksD1Ty4cCLgLQXBYluCVU+XzGX7VGL0O8e0kMOF6xXAeR9W0ZpN
         1QAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964475; x=1695569275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LD+60v9C6UaRp0/siQLtHNIFl77ZDBkVdyJlYrRa+7Y=;
        b=ilMMzHBwBBOIoWkSXW1zjcnJ/bKBcFGZ6LbS0koP5qniuSAkhmPoED9lxlCOYZfF1h
         xevSQt6ag8aISEkpEwQ4FYSqFM6B/qd8/YCcHcPzGu+56TOJLJJz4tR7Wz+/NrnRwkso
         uPNhEWYbt8l0u0sA+CRs69F93J8q1kYJZx/vElsI1jLhIogjDjiB/E9BkHwCAMPKLgow
         n6AasUzBxOHJ7pUZioNNPaw+lc4i+eH4BCfIN6zTZUUePIHJUyxbXYeiRvWvm3M4JHJl
         bumeSkXRGqTCQU3lfKSvJD3r+6hKayk/Fkp9WHP20FtB3hoCwyH+Igeo/b+5EHn6YH6P
         JArQ==
X-Gm-Message-State: AOJu0Yyi9XihZt94z+d5nphykaprFW+O+bqJwzC71XI/LkycM/Nrup3V
        tRPAY7rdsUKGXuyQhU36U2g=
X-Google-Smtp-Source: AGHT+IFMoEpnwQyNLknzPee617qhcmJR/O2NloQ0cpT0cp57T8tjIvz2LAXQD9gdl6ee6PnfvYX2lA==
X-Received: by 2002:a7b:c40b:0:b0:401:be70:53b6 with SMTP id k11-20020a7bc40b000000b00401be7053b6mr6000332wmi.15.1694964475610;
        Sun, 17 Sep 2023 08:27:55 -0700 (PDT)
Received: from localhost.localdomain ([5.45.134.53])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b003fe15ac0934sm7388865wmp.1.2023.09.17.08.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:27:55 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: [PATCH v5 15/15] USB: typec: Do not check VID for tps25750
Date:   Sun, 17 Sep 2023 11:26:39 -0400
Message-Id: <20230917152639.21443-16-alkuor@gmail.com>
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

tps25750 doesn't have VID register, check VID for PD controllers
other than tps25750

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
 drivers/usb/typec/tipd/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 326c23bfa8e6..c1399e12a170 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1142,10 +1142,6 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (IS_ERR(tps->regmap))
 		return PTR_ERR(tps->regmap);
 
-	ret = tps6598x_read32(tps, TPS_REG_VID, &vid);
-	if (ret < 0 || !vid)
-		return -ENODEV;
-
 	/*
 	 * Checking can the adapter handle SMBus protocol. If it can not, the
 	 * driver needs to take care of block reads separately.
@@ -1176,6 +1172,12 @@ static int tps6598x_probe(struct i2c_client *client)
 
 	tps->irq_handler = irq_handler;
 
+	if (!tps->is_tps25750) {
+		ret = tps6598x_read32(tps, TPS_REG_VID, &vid);
+		if (ret < 0 || !vid)
+			return -ENODEV;
+	}
+
 	/* Make sure the controller has application firmware running */
 	ret = tps6598x_check_mode(tps, &mode);
 	if (ret)
-- 
2.34.1

