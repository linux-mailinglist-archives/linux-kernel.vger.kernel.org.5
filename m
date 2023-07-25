Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC0B7618F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjGYMyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjGYMyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:54:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFF319A2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:54:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5221e2e69bdso4204795a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690289674; x=1690894474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MkRYmXmHZ+64hiKvKzZjrtd77nbRk+uqXsZ3jdXGpc=;
        b=Aj6w7q3BdmsRSLmcTTqeGv9mNeJhH42tnBilSqCOOSWFLWvdjkHlD0pIVf0xJa+31k
         TMRPxH9UjCWpAwqz1AtCfG+vwK4y3/uFyjk8qNJJes5CjcxtXqCvGKFsEurEPIxQQFi1
         MVrYA4S78fJIiJdWGPJfXmb3Pk9fwDz7gHSiX8eQlFzq3UQ7T2/8c+/uHR9mcvuu6Fub
         xJwCWB1DF+g+xDM7A+k01oqJWMubV53tEKmBPiKHDx1ZKZOUQEMZcve4aOxaYDXDTXC8
         FuHftBsSLCQ62+1Pj1BQdZb/exlYTUWkhNkoFeeVY8DLGpJ0mUEf0VcuqX5Kue/ehUCL
         4Uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289674; x=1690894474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MkRYmXmHZ+64hiKvKzZjrtd77nbRk+uqXsZ3jdXGpc=;
        b=T6lUEboG2Bub4OyFWJK6sYKv983bFP3HqWwUCz9ncOhdLPYxNuHfYiZuMzrKCR51Rs
         fAwhUhQUxwNNp6U/tkbINi8Hz6Ea/i/lvb5OX/LxJDmQqDFYk4lF6jZe1pmsw6kerJM4
         Fu1fqPIY3WQX8f8ok+Z0aLgAiXEbY2JBxDfazlbTg+U4mzcQVP5JTXbIKq8QjnTNir+u
         asz4XYNZjaauUQsbjgfSFJoN3g6LpIW8hGLLkh4buZnmc1nyKTMiU7Y3SmbaRvfdRU7l
         F/RUFgtinc1SyD0cjh95flmD0a1EJ0CrVldY9f6bJ4paZ+2eowjIRoX3H71bfgrhljX4
         974Q==
X-Gm-Message-State: ABy/qLb9f3hI2d6Lay8JH36xwUvDnbWg1/hUmG73RvlRKfOvybQiQw7Y
        XiLpu8UUnd5FoM/BffVyjji0EQ==
X-Google-Smtp-Source: APBJJlFArk8UU2wj3uy9zsuNg0zcth6a3PvBukhgkt5QwJIOzNGUf7EkojPwDZBDoVnAknWTu6SFXw==
X-Received: by 2002:a05:6402:645:b0:522:2111:105d with SMTP id u5-20020a056402064500b005222111105dmr7394161edx.20.1690289674437;
        Tue, 25 Jul 2023 05:54:34 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id u11-20020a056402064b00b0051dfa2e30b2sm7516682edx.9.2023.07.25.05.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:54:34 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] pmbus_core: Fix Deadlock
Date:   Tue, 25 Jul 2023 14:54:27 +0200
Message-ID: <20230725125428.3966803-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725125428.3966803-1-Naresh.Solanki@9elements.com>
References: <20230725125428.3966803-1-Naresh.Solanki@9elements.com>
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
index 30aeb59062a5..42f4250c53ed 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2949,37 +2949,27 @@ static int pmbus_regulator_get_status(struct regulator_dev *rdev)
 
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

