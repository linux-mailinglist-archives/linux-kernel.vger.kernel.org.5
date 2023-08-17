Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9B6780166
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356002AbjHQW4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355946AbjHQW4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:56:10 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9032A3A82;
        Thu, 17 Aug 2023 15:55:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bee82fad0fso2595255ad.2;
        Thu, 17 Aug 2023 15:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692312950; x=1692917750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjEQDL946xgGUJAzfsyFPr1apPg18WStQIZsR3DmfU4=;
        b=sxBOeW/rizPWbjiPLMxAk5U9+4S7kA+IKo6PLdUGh1nAHynXu4Cy98YcoPELIZdFpM
         276r7Da3Z/NCExbqCfse6c5yqCfmSY/+XBpfNHwtcW67b80qmoaRXMx9SSOHSGypTo9C
         FLB+t7UId0qW5QYNzVgQCcFFtHKe3dhOLAoY0a5dj85fuEh8n13f/bbFS2xpMCm3VC8N
         LZMxUKxU9vkv/QPDRLgAMkUHKJCYWoqqeVX6IDEwbjjto43yrexm64v+1r61p7xBdzAP
         DsPkz6+YPq9sm4BHuFaOCj/TRVxZIZajyb9fpizanZwswt1/r5rZOnSn0I/XcV8IUMFg
         mh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312950; x=1692917750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jjEQDL946xgGUJAzfsyFPr1apPg18WStQIZsR3DmfU4=;
        b=RJMz+XnqRRVW7HpAzrdBZijcaShzWksbCHA7PI8x2flnpPlgdktjEmztZx6xIyi3Ab
         L0h2dz7zVOnMQn1vGO90Ic+W+5S+G79khNQwy+q0SKj3wiq1HyXjHB0YW8lRKE0FLPut
         4FnyG0kCsI3uqar2YWv+lYIZNKhDkH3J2Ti8e4FJDSdcKO/WphXG1E395dum38YT/zR9
         UIneOWrDHwhMt6z74aYoswn8O/8nh06bf0tR+EcIqQPgyTgRLiqF118RP/i1hygvoiUO
         43/9Gc4SwDQmhYAk5kM9+368c091hOsO5r1I/UAv0ljtiusVPv7VJNRox9YoXSaA9NRh
         ioig==
X-Gm-Message-State: AOJu0YxkH5cvOJKu5poL4AzSOuUT3PxO+0dNWYoTNv5GxNBCmza7HCVx
        Nbw2tKJKWBFYGmo7osKb/NI=
X-Google-Smtp-Source: AGHT+IG/Wnfiq+DYaLHKd8m6+SMPhdUy5ef7fWwjXDlFsqmmnP7r8TZ8PYH3y/sXF8epkg0ER55x/Q==
X-Received: by 2002:a17:902:d38d:b0:1bf:3094:32eb with SMTP id e13-20020a170902d38d00b001bf309432ebmr828426pld.50.1692312949935;
        Thu, 17 Aug 2023 15:55:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001bbd8cf6b57sm294962plb.230.2023.08.17.15.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:55:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 7/7] rtc: rzn1: Report maximum alarm limit to rtc core
Date:   Thu, 17 Aug 2023 15:55:37 -0700
Message-Id: <20230817225537.4053865-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230817225537.4053865-1-linux@roeck-us.net>
References: <20230817225537.4053865-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RZN1 only supports alarms up to one week in the future.
Report the limit to the RTC core and use the reported limit
to validate the requested alarm time when setting it.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rename range_max_offset -> alarm_offset_max
    Use the new variable to validate the limit when setting the alarm

 drivers/rtc/rtc-rzn1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index dca736caba85..c0f448bce145 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -227,7 +227,7 @@ static int rzn1_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		return ret;
 
 	/* We cannot set alarms more than one week ahead */
-	farest = rtc_tm_to_time64(&tm_now) + (7 * 86400);
+	farest = rtc_tm_to_time64(&tm_now) + rtc->rtcdev->alarm_offset_max;
 	alarm = rtc_tm_to_time64(tm);
 	if (time_after(alarm, farest))
 		return -ERANGE;
@@ -351,6 +351,7 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 
 	rtc->rtcdev->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	rtc->rtcdev->range_max = RTC_TIMESTAMP_END_2099;
+	rtc->rtcdev->alarm_offset_max = 7 * 86400;
 	rtc->rtcdev->ops = &rzn1_rtc_ops;
 	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
-- 
2.39.2

