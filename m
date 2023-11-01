Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292207DE416
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343871AbjKAPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344665AbjKAOqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:46:45 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3273EDC;
        Wed,  1 Nov 2023 07:46:43 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso4523438a34.0;
        Wed, 01 Nov 2023 07:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698850002; x=1699454802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jeA19kl1acYj+K5OAp8lk/hS9qxEtIjfOF2DeOY2Wk=;
        b=oR8sOc8IS7ND8q7t6Dpf9jTtI7ICLx3r9zVXXSDumYHXKIU8LVQvbRTq9MujYec6GK
         DUPoVs3LVmL3CoOforCS6uflkAMK2z/H3Rk7z8tjuyuCqyS94IsammqJGa6YSGUb+ttR
         5aFg9sb1Pj8EN0Yf1dDU+/VIqPgrGZAWomvNpJ6fTT/g0uAoX+hnSDKlXp0oOfx12qEW
         QZQ5idyNNEZtDz67h2tJfOzRKbrnxjL26jxAY1sZvRnmHcQOSH040EnHP/P1cj+SvubC
         yxv12qcs6eUSRW0z4NEUIWiuTRIFP5j/hBxx9pcXZmoPnZBf+aYT59gu0FZ9ufbSJZZV
         7xmw==
X-Gm-Message-State: AOJu0YxvPWuzedPRQTQ5/nM51hiC7gyc78VGd9JPxcUcB19Lwk3BLyGa
        1tPYdkL+w20f9wHjPgUVsQ==
X-Google-Smtp-Source: AGHT+IE+dz1IOeT7KVIPxGWJde5p4oVtUL0RCQEmKwS1I+MeRIbZm2OK92ubWKocNbqh109fS8FEdQ==
X-Received: by 2002:a9d:6197:0:b0:6cd:da93:90ce with SMTP id g23-20020a9d6197000000b006cdda9390cemr15395286otk.19.1698850002398;
        Wed, 01 Nov 2023 07:46:42 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a13-20020a0568300b8d00b006b8c87551e8sm216507otv.35.2023.11.01.07.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 07:46:41 -0700 (PDT)
Received: (nullmailer pid 121158 invoked by uid 1000);
        Wed, 01 Nov 2023 14:46:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] opp: ti: Use device_get_match_data()
Date:   Wed,  1 Nov 2023 09:45:00 -0500
Message-ID: <20231101144501.118972-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

As this driver only does DT based matching, of_match_device() will never
return NULL if we've gotten to probe(). Therefore, the NULL check and
error return for it can be dropped.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Add missing commit msg
---
 drivers/opp/ti-opp-supply.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index 8f3f13fbbb25..e3b97cd1fbbf 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -373,23 +374,15 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device *cpu_dev = get_cpu_device(0);
-	const struct of_device_id *match;
 	const struct ti_opp_supply_of_data *of_data;
 	int ret = 0;
 
-	match = of_match_device(ti_opp_supply_of_match, dev);
-	if (!match) {
-		/* We do not expect this to happen */
-		dev_err(dev, "%s: Unable to match device\n", __func__);
-		return -ENODEV;
-	}
-	if (!match->data) {
+	of_data = device_get_match_data(dev);
+	if (!of_data) {
 		/* Again, unlikely.. but mistakes do happen */
 		dev_err(dev, "%s: Bad data in match\n", __func__);
 		return -EINVAL;
 	}
-	of_data = match->data;
-
 	dev_set_drvdata(dev, (void *)of_data);
 
 	/* If we need optimized voltage */
-- 
2.42.0

