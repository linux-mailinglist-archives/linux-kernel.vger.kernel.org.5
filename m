Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717DD780162
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355943AbjHQW4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355938AbjHQW4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:56:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE983592;
        Thu, 17 Aug 2023 15:55:47 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bdc19b782aso2721895ad.0;
        Thu, 17 Aug 2023 15:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692312947; x=1692917747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTlnm6sGIO31jUGXUD0CO65f2YiL6ybxcsMLmHiDeHU=;
        b=kwlm7mNhxTgprppiKt7Pvjl1pFLb5htxS+x3HzcvYrhNovyMFHGVCvlMGSWusXGkXs
         2jGxl8bnzrbEkrEqrt1+IDWh4VroLHYpInimpsCWCb2nAK/WcXBF6iynFxVtHSV1RAf/
         yCOm1qAPxdGASYIxKVdp2uORGTmQ2lCg2I88BOKJWkZRk01qeguSAH4HABEjPZ4rq+R3
         y1AbcPXaCccPPYyEzpl+1h4KuvzlXvGYFaczGtk89OTAi2H0WJqJTE0K2L5/JqAtDO8K
         3olNb9zkqfHiXQAt/QXW2aPxuB18SVxMRvbIFTntlnsRsqkf/jbe7w+V1KLt6Mxx6XJq
         niOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312947; x=1692917747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MTlnm6sGIO31jUGXUD0CO65f2YiL6ybxcsMLmHiDeHU=;
        b=cS72ZSjFR7DvEvFDjG59DqhYYjt+FwWMXRx9mbwMzI9znX5LsMfyTTWG1gH4dvoe/0
         GWQImAbeHLmGR4n2A6wvuqOFNxgj0vbQCVvP4ayu0pgVtqO0CwAycWER4zonx24rAkww
         h/27SMFwoldYDAsd7ogYpZ8LcGViqCRZhiXxDYtyX7e1HSWT5cSJz43n9/TxwKSoUhuC
         w/QYOyW3PxWfvAhcGegYeYuhizD8T6rp6OJIN/HJvuqWI4AmVo2Yc0kSd3saVwwmUIJc
         H69Vnw6qcnTP0OwzKIKieeHvJtPGjgPtsjv/wFTgD8dL0YyU1JXMwemXyAE491NOrXGZ
         2Shw==
X-Gm-Message-State: AOJu0YxXPlMAq1ng8+q9RikSNFgnn+YkK8fnBtyTN7reK4mggKeN7Tq5
        RzGkBkHadAomeYXTkMbdNgY=
X-Google-Smtp-Source: AGHT+IFn+oYy10wGoisjfnlfb0srVFvmaNBXWiaTt2UPVed+845FW9/w9Oa4qB0bN7y41x6tmth99g==
X-Received: by 2002:a17:903:2644:b0:1b5:5059:e733 with SMTP id je4-20020a170903264400b001b55059e733mr705405plb.17.1692312947173;
        Thu, 17 Aug 2023 15:55:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j15-20020a170902da8f00b001bba7aab826sm287927plx.163.2023.08.17.15.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:55:46 -0700 (PDT)
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
Subject: [PATCH v2 5/7] rtc: tps6586x: Report maximum alarm limit to rtc core
Date:   Thu, 17 Aug 2023 15:55:35 -0700
Message-Id: <20230817225537.4053865-6-linux@roeck-us.net>
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

tps6586x only supports alarms up to 16,383 seconds in the future.
Report the limit to the RTC core.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rename range_max_offset -> alarm_offset_max

 drivers/rtc/rtc-tps6586x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-tps6586x.c b/drivers/rtc/rtc-tps6586x.c
index 9f14e2475747..20faf08c254c 100644
--- a/drivers/rtc/rtc-tps6586x.c
+++ b/drivers/rtc/rtc-tps6586x.c
@@ -252,6 +252,7 @@ static int tps6586x_rtc_probe(struct platform_device *pdev)
 
 	rtc->rtc->ops = &tps6586x_rtc_ops;
 	rtc->rtc->range_max = (1ULL << 30) - 1; /* 30-bit seconds */
+	rtc->rtc->alarm_offset_max = ALM1_VALID_RANGE_IN_SEC;
 	rtc->rtc->start_secs = mktime64(2009, 1, 1, 0, 0, 0);
 	rtc->rtc->set_start_time = true;
 
-- 
2.39.2

