Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BDD7B7EBD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242308AbjJDMHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242218AbjJDMHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:07:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C55ECE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:07:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso3587585a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 05:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1696421255; x=1697026055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDAx+WeaAfeMTk0iyLZZaQojNWk87fXDiAYeAoWRhyA=;
        b=GC4/UBX5DfVUAypUfkP0Xbkjj7i1mKLgpupYA3AZTPN4nmUg8hnT3IFVrDUyeA5Tqh
         xXR6jCTtXgx2uhzrOMfRJzS46fSMnsH6H9jKp/Oy5FdonNnzrBNAs/wSMgq6CWViaibN
         A7mXVTqosWPmvhuqB7s/FPwq9R12HqvDrdr1T76RY1+bfzOAlTUJGWimrHIn9L/XmZq4
         b4dhhww0lZl93GOQVYYgQ/IviSbL4S83e6pQeuk5VgY41yCaEY/p0Uj5Jo0OuzzGGmmC
         szaYbjjS/1wovYLzP3WFQ3IBUTAv5HH5rXQ71Y6fO7nBRQCO1PtmnHH/nOUG2kZIRpgt
         hVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696421255; x=1697026055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDAx+WeaAfeMTk0iyLZZaQojNWk87fXDiAYeAoWRhyA=;
        b=CC/56FgwLrb2S9aBcqcy2FN20eKv+feiNrDH0meFWJkp5NS2P70BqUW5YYRHdwPBlP
         DS/J08Kx+T562mHNh3vOY9UNwmPQGOyiVbWXrjpxEKO+f7b8l/DLXZri5zbOSzcfxuc/
         OjsjGhfcYL5Zvf1EXSuYzAHewaYcIWst0fPfWUoK5pFYWDWBL9kmuIKErhrib7PG2Hy7
         MJT0StvbW05FVSNi9PE/hfh7FAGgqzx3aqR8B8fw6KH1zJzf149XNnzz7Tm/0tL9jtau
         tCIa8oNClmuqw9x7Mhz4FN/d2RcApyFbQvADeT7Mp7QC9USsxOmJZ2GEk7F2otVgML4l
         wxOg==
X-Gm-Message-State: AOJu0YwI8c9kp4L1gfPIqOM9Z68/rphwb2o8rg9g8ftHhhHt7grBKc3k
        t1StORaUUncb+FucV+9F1zfrNQ==
X-Google-Smtp-Source: AGHT+IHm5WHp148GToyXRnO3HZAAJJvI1L3HMfiDFBTvaQ05/9SJsF5Tx9xPQ28BlrR75g7KTEqV2A==
X-Received: by 2002:a05:6402:1843:b0:522:580f:8c75 with SMTP id v3-20020a056402184300b00522580f8c75mr1695418edy.17.1696421255040;
        Wed, 04 Oct 2023 05:07:35 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id e6-20020aa7d7c6000000b005362bcc089csm2324665eds.67.2023.10.04.05.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:07:34 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] regulator: userspace-consumer: Retrieve supplies from DT
Date:   Wed,  4 Oct 2023 14:05:27 +0200
Message-ID: <20231004120529.1155700-2-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120529.1155700-1-naresh.solanki@9elements.com>
References: <20231004120529.1155700-1-naresh.solanki@9elements.com>
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

