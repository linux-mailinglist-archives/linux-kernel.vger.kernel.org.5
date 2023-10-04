Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1239C7B7EC6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbjJDMKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJDMKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:10:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9665A1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:10:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b64b98656bso391951566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 05:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1696421414; x=1697026214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDAx+WeaAfeMTk0iyLZZaQojNWk87fXDiAYeAoWRhyA=;
        b=UHZm4+ptLtwHZrCy4sbUWMmi+RFNBU4b0OdlF941O4z5synKR4xgn/MapkXP7xWChA
         Z0RHX2txBYtwAOGMx8k1c3OE8Lv98TRNoeCPGTNGmHqt8MMmzoJiYU97Z68MJM4SyTOh
         1E9ui2qG5qlq0TLZNdV/w5RuULqokJXnWaAegADJxTqTzex7VB9W5hxEbZTexrD5N1Lf
         lL+X5yHK+8zekNV2A+Ob7Nail9RktVPARkqQAnVWfSwRTLL31YgWZX0wkjVgwTsq23cs
         kcO3T831y/IRDZ+VE5548ghGzypzFp3Qm7YANlFG1ea2zfxV9hk2wSCIt/UYNMMEa3/Y
         0sMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696421414; x=1697026214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDAx+WeaAfeMTk0iyLZZaQojNWk87fXDiAYeAoWRhyA=;
        b=DcQ6C5u9/Li7RZbU/zLyUSs7fSwrfKIPHkRjYL02gxDEOJdUiZPfW9J4p4quMA5GXq
         oB0t1maHyBloSQfycmU3XP066J9nKHmnIIeJlDPF0raAy5m/8kDAua1V+ClCcPEBlbJq
         uAJYb+7kif4OPBg4DYPZMJUr8R0ZDiqZCfub9MGkQJVKXAgoJhM9Kz0CWmTQX0iRpNH6
         LZcLTcHf+v+Gk3H31shgq3LA/LGPyfEpR3lRS4e0ZAQWK8mjFTWTaA0PZ1qgpj1Kvatp
         u+k2LNzTyUgWii1+OTVOv352ALeOQh50nHI/XGqaWjBFuOm888ggdyGvIJ3x8Fl/Y70d
         vZdw==
X-Gm-Message-State: AOJu0Yxy24sFApVQh2pO8zbZtLp1ioBBEL+uTu+UbTy0wWuBJOOVXBQ5
        FprxdCs8bv2Fax0tiik09vRA/bQQzAa7xFvmeB/8cw==
X-Google-Smtp-Source: AGHT+IEb+AhsnXs0qFKFGdHgtiPE8jk4p0NJB2rHEJKvIL1DBeOmrt4voUnOkZ3fAWQiHBuHeHCXjg==
X-Received: by 2002:a17:906:4d2:b0:9ae:5212:e3b with SMTP id g18-20020a17090604d200b009ae52120e3bmr1578847eja.5.1696421414138;
        Wed, 04 Oct 2023 05:10:14 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id d10-20020aa7ce0a000000b005288f0e547esm2354627edv.55.2023.10.04.05.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:10:13 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] regulator: userspace-consumer: Retrieve supplies from DT
Date:   Wed,  4 Oct 2023 14:10:08 +0200
Message-ID: <20231004121010.1192344-2-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004121010.1192344-1-naresh.solanki@9elements.com>
References: <20231004121010.1192344-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naresh Solanki <Naresh.Solanki@9elements.com>

Instead of hardcoding a single supply, retrieve supplies from DT.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
Changes in V2:
- Use strlen for SUPPLY_SUFFIX_LEN,
- Remove bracket for single line statements in if statement.
- Remove extra space in variable declaration.
- Simplify multi line statement by calculating size in seperate
  variable.
- Add function prop_supply_name & simplify code.
- Use devm_kstrdup instead to simplify code further.
- Update DT binding to align with changes.
---
 drivers/regulator/userspace-consumer.c | 51 ++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 97f075ed68c9..13c0a86ab32c 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -115,12 +115,41 @@ static const struct attribute_group attr_group = {
 	.is_visible =  attr_visible,
 };
 
+#define SUPPLY_SUFFIX "-supply"
+#define SUPPLY_SUFFIX_LEN strlen(SUPPLY_SUFFIX)
+
+static size_t prop_supply_name(char *prop_name)
+{
+	int len = strlen(prop_name);
+
+	if (len <= SUPPLY_SUFFIX_LEN)
+		return 0;
+
+	if (strcmp(prop_name + len - SUPPLY_SUFFIX_LEN, SUPPLY_SUFFIX) == 0)
+		return len - SUPPLY_SUFFIX_LEN;
+
+	return 0;
+}
+
+static int get_num_supplies(struct platform_device *pdev)
+{
+	struct  property *prop;
+	int num_supplies = 0;
+
+	for_each_property_of_node(pdev->dev.of_node, prop) {
+		if (prop_supply_name(prop->name))
+			num_supplies++;
+	}
+	return num_supplies;
+}
+
 static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 {
 	struct regulator_userspace_consumer_data tmpdata;
 	struct regulator_userspace_consumer_data *pdata;
 	struct userspace_consumer_data *drvdata;
-	int ret;
+	struct property *prop;
+	int ret, supplies_size;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
@@ -131,11 +160,25 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 		memset(pdata, 0, sizeof(*pdata));
 
 		pdata->no_autoswitch = true;
-		pdata->num_supplies = 1;
-		pdata->supplies = devm_kzalloc(&pdev->dev, sizeof(*pdata->supplies), GFP_KERNEL);
+		pdata->num_supplies = get_num_supplies(pdev);
+
+		supplies_size = pdata->num_supplies * sizeof(*pdata->supplies);
+		pdata->supplies = devm_kzalloc(&pdev->dev, supplies_size, GFP_KERNEL);
 		if (!pdata->supplies)
 			return -ENOMEM;
-		pdata->supplies[0].supply = "vout";
+
+		for_each_property_of_node(pdev->dev.of_node, prop) {
+			const char *prop_name = prop->name;
+			size_t supply_len = prop_supply_name(prop->name);
+
+			if (!supply_len)
+				continue;
+
+			char *supply_name = devm_kstrdup(&pdev->dev, prop_name, GFP_KERNEL);
+
+			supply_name[supply_len] = '\0';
+			pdata->supplies[0].supply = supply_name;
+		}
 	}
 
 	if (pdata->num_supplies < 1) {
-- 
2.41.0

