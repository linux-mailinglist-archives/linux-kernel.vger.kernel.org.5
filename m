Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9867ABA69
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjIVUM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjIVUMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:12:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADB0A9;
        Fri, 22 Sep 2023 13:12:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b11cc499c2so75849566b.2;
        Fri, 22 Sep 2023 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695413568; x=1696018368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLN4bH4coEcvi6teZvOLHVyuO9WrCZeFHK+MQxHhiSE=;
        b=Q+MDi79B34rn0IDIq1eh/yY2iHVurOgFyUiqsg/xPtxsnFofbZbLvqldyT2ctgUX1y
         W7caN0KeXe2/qDZWnveUDcyXS/ngusLxMrXj4aJwJewp4XS+AtXQKy4NoND3RmQu4VPG
         kyX34p+7LHpG/P5GqTuSzZX3H+uCP9Nfdj64tPNT5wB9750761OkCH9XGtt1oZee1Ylh
         s3tCL/71yYNu4T8j/mtDT8W0U0TveMZpO8fLyIMUpx70n/hAz/MGofFLQitdhP6wzshg
         3C0Zm8FEDihdWoGXl4L8IaSAUTbJbrvSR2DiAUvhx5v6BIhMdIGdTS52HcPATmCbKN1t
         Oj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695413568; x=1696018368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLN4bH4coEcvi6teZvOLHVyuO9WrCZeFHK+MQxHhiSE=;
        b=twT8Bv4NFQ1BqicyOBp6QMNPc7Lh2bJGws5JnsaFdxHjrBHqfpeV/whrWcb7eGkxAm
         DvSeTbIikr8I3eBu1ujw5B4+Ewx4TCzXndIXzPk0btSIYGBGDmmON5q03xhMN1vGIUJ1
         oPw+O8GfHsR+qH/KVH673AJwCnSbyMd4rSss0uLNg97Z70CiZe8+PMr43NlUBUX1HuAW
         GWnvxwvyfL1bRDEy3jsHhRkQLgs8mIwGHDJ453CNmbzIKatSLTD0wl9rQGRR/ne+pJFk
         k4GXuLAisr8DKVsS5XS5b8PT/Q9NNspc95t6YVsH2XpO+xuEu7L7lnkya89j2FSlT9Tt
         jtJw==
X-Gm-Message-State: AOJu0YzVBbUuEO4yDgQUpfgb0Q1UfhFYJjjolNn+75d3g71x4bZ6wSqU
        QZXvEpImIuz8y/VA7hVKBy8=
X-Google-Smtp-Source: AGHT+IF7G+E5H3ZPGE5wynI5t2ubz7n8rEDRMyWSsuis7DkkkZP6qj1ZyGy+rEZaWqQCRHQKvfooLQ==
X-Received: by 2002:a17:906:5a5d:b0:9ae:699d:8a29 with SMTP id my29-20020a1709065a5d00b009ae699d8a29mr299359ejc.6.1695413567731;
        Fri, 22 Sep 2023 13:12:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5af6b6.dynamic.kabel-deutschland.de. [95.90.246.182])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090646c300b009ae57888718sm3101778ejs.207.2023.09.22.13.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 13:12:47 -0700 (PDT)
From:   Nikita Bune <w1s2d5@gmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Nikita Bune <w1s2d5@gmail.com>, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/watchdog: fix checkpatch error
Date:   Fri, 22 Sep 2023 22:10:25 +0200
Message-Id: <20230922201025.64164-1-w1s2d5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch ERROR: do not initialise statics to 0

Signed-off-by: Nikita Bune <w1s2d5@gmail.com>
---
 drivers/watchdog/uniphier_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
index 8e9242c23022..7a080600d865 100644
--- a/drivers/watchdog/uniphier_wdt.c
+++ b/drivers/watchdog/uniphier_wdt.c
@@ -41,7 +41,7 @@
 #define WDT_PERIOD_MIN			1
 #define WDT_PERIOD_MAX			128
 
-static unsigned int timeout = 0;
+static unsigned int timeout;
 static bool nowayout = WATCHDOG_NOWAYOUT;
 
 struct uniphier_wdt_dev {
-- 
2.34.1

