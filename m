Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68987618D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjGYMug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjGYMuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:50:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4197FB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:50:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-992acf67388so808358166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690289399; x=1690894199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYD19a3O4cLr2nNRYtCL9dvjJwOe0PKsrRBMJLYvYmk=;
        b=GHdE9k1axkZh7NG9FIG7kI8HeFho5+otFcadAxyAUdOWSW7V/XOJ21z5Ifyub4COEC
         q8laY+zuCtm2eyIecUUCxyBTZE7qfOTVx9oxSEBy/oyDXQiTxtbhRWuGU8oBn6eshgyR
         A8dG9P0c0KnZVm3X7oE4zOsYB/aZWL6OBhVRzw+6xjNq4csxLPXaQQZShnEDhnJ+B8JU
         PXQmR6+21kJN2svkUZo0fpfsnIfgJF5VlP+B+n2L0wCT6KitWDDhEeOly03GYkqbgA+Y
         Rf0plGS60rcTO2CY44aLHydcAEQgamP+SWgUm4R1a2H0QdCZTmGa9IIUSv6tV5wV6njv
         WCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289399; x=1690894199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYD19a3O4cLr2nNRYtCL9dvjJwOe0PKsrRBMJLYvYmk=;
        b=VEn+t9IiXJ4i/DLNTmWPrYLv6J0lZtxLucZRB1VIkl5qTs5M6yZi4e7ynNiHgk+dSF
         el/XZOejWoPEGyS8sj6CbfMgDEUiPjS/XPkPwq3Zo1oC3qeuxnayqmzjeDdsCCnGgA29
         mhYXJui9IPvTSXS2i0YcZYWWEgQO4u+SQYHxVGB/zO5c4CTcRBGRQ7HVi/3iPxH4I1St
         z90B3dU3Ktr1AQMsXnWaANIHiV9kPj25ZNLf+a1LZbXR/S2XJ0TAdBzWqmqGStLWVRJk
         a6J5+j1sLtpbd7FtWcczKa0utrXIdeSkijUYRfq2kkFUXrcWbsyHdhEhayZGm1+u3cs8
         5qtQ==
X-Gm-Message-State: ABy/qLZPcwwE5xek5Asu6cYOHxcjicXT/sxWTuSDiweKpn4X0q4wDkX+
        qKAIxQgMfiVj96sAtsKcVsl8mw==
X-Google-Smtp-Source: APBJJlEwzKMO5bXsBdqEZDdoyHatzTagNOamwvW7DbUqDMkw8VGIniMLmZmh6oaFuoya9ZGaZgVklA==
X-Received: by 2002:a17:907:7819:b0:99b:4790:a4d4 with SMTP id la25-20020a170907781900b0099b4790a4d4mr12653941ejc.38.1690289399222;
        Tue, 25 Jul 2023 05:49:59 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id pk15-20020a170906d7af00b00997e8b6eaa1sm8133283ejb.41.2023.07.25.05.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:49:58 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pmbus_core: Fix Deadlock
Date:   Tue, 25 Jul 2023 14:49:52 +0200
Message-ID: <20230725124954.3824954-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725124954.3824954-1-Naresh.Solanki@9elements.com>
References: <20230725124954.3824954-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

pmbus_regulator_get_error_flags() will also acquire the update_lock,
thus unlock the mutex before trying to lock it again from within
the same thread.

Fixes a deadlock when trying to read the regulator status.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 1f7df36c48a8..1151a09243d3 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2946,37 +2946,27 @@ static int pmbus_regulator_get_status(struct regulator_dev *rdev)
 
 	mutex_lock(&data->update_lock);
 	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
-	if (status < 0) {
-		ret = status;
-		goto unlock;
-	}
+	mutex_unlock(&data->update_lock);
+	if (status < 0)
+		return status;
 
-	if (status & PB_STATUS_OFF) {
-		ret = REGULATOR_STATUS_OFF;
-		goto unlock;
-	}
+	if (status & PB_STATUS_OFF)
+		return REGULATOR_STATUS_OFF;
 
 	/* If regulator is ON & reports power good then return ON */
-	if (!(status & PB_STATUS_POWER_GOOD_N)) {
-		ret = REGULATOR_STATUS_ON;
-		goto unlock;
-	}
+	if (!(status & PB_STATUS_POWER_GOOD_N))
+		return REGULATOR_STATUS_ON;
 
 	ret = pmbus_regulator_get_error_flags(rdev, &status);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	if (status & (REGULATOR_ERROR_UNDER_VOLTAGE | REGULATOR_ERROR_OVER_CURRENT |
 	   REGULATOR_ERROR_REGULATION_OUT | REGULATOR_ERROR_FAIL | REGULATOR_ERROR_OVER_TEMP)) {
-		ret = REGULATOR_STATUS_ERROR;
-		goto unlock;
+		return REGULATOR_STATUS_ERROR;
 	}
 
-	ret = REGULATOR_STATUS_UNDEFINED;
-
-unlock:
-	mutex_unlock(&data->update_lock);
-	return ret;
+	return REGULATOR_STATUS_UNDEFINED;
 }
 
 static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
-- 
2.41.0

