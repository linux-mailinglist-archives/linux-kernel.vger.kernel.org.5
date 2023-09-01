Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE62D78FCD9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349337AbjIAMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbjIAMBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:01:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F4D10EF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:01:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso2376609a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693569663; x=1694174463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS/0ElWUbV8BeVd+6AgHAloG3yh8d3D/aZCsvM27g5c=;
        b=dYtJR3J8jVBGQWSRkwxQC1Mjk4V89T+SFg0OVPktOEX173pBH1RMBoA7Y5YY+6oXIB
         2DGKImoqatGQ1QeAy0hnb33T9YbQdsAJZ2UHsVOnaPWFqSdd6hJM+5F2Oy/AHQzocv6m
         W7zDoXC1XLctatW4Nxq0lEOfmHAR3Qs0NxAcC82jX88rn/LknrXLaVrJ5yr9gapMqJAQ
         UU2No4Aw9s0+nOLulNGyKcU5pgVyGehB7H8aQroL0jgEZAV8rFK/CaumQF5fSjoPxSJw
         DZWuI0YHl+5xZL1gLcOabkNABzxkkcHZxCSl/Q5odhRNhqdY4jkR6U0Ii84fpyviP2LT
         KW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693569663; x=1694174463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oS/0ElWUbV8BeVd+6AgHAloG3yh8d3D/aZCsvM27g5c=;
        b=By/Imx1ac1TiMHiLpGV4V4774fZK2ZQfjFTr8prFCh3C5P5W3oxWTDGixO3JmQNP6m
         raseO8pMmSSbZsHxuO7/31iLhay/D3FA2a6hp+Kwz8+rNn/Fhr7t3/VJrfHuFes7vD5D
         pYDfeGEW9O4cYcdjKhfkTxSI5ZvLS9DSzgcNuf2djaOmxO9T2FDp76Vrh4IA3KRZjrQc
         YBQAVYXj3o9PAbkY2AahxspL6+e3d4UE1o9hdZZzLZ0G+ZHYi6fQ3FNphtZJbbkgjiO1
         TkGen4ZisQiL+DS4EtZPmdJ0CrBp+wLg9IxpNYaic9QfOIfmyxBh+Zor3YMINzHXFSAk
         X2xQ==
X-Gm-Message-State: AOJu0YwsZ9GQCQCAhpxOVflyxc+6RnMdjvQ35qlRWxQTprVEVksmN5uJ
        4b7Z6cErT25JgYkKSZp0K1+G1Q==
X-Google-Smtp-Source: AGHT+IEV6aXOvW/K5E49cBpDsHJ6RPd3sDkgSq3TDoEjuLdw9Iaukbt/a2aU3OL05Q/sA3k8mg4Ynw==
X-Received: by 2002:a17:906:189:b0:9a2:1df2:8e08 with SMTP id 9-20020a170906018900b009a21df28e08mr1670600ejb.45.1693569662760;
        Fri, 01 Sep 2023 05:01:02 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id kg12-20020a17090776ec00b00993928e4d1bsm1877343ejc.24.2023.09.01.05.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 05:01:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] power: reset: syscon-poweroff: get regmap from parent node
Date:   Fri,  1 Sep 2023 14:00:57 +0200
Message-Id: <20230901120057.47018-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901120057.47018-1-krzysztof.kozlowski@linaro.org>
References: <20230901120057.47018-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like syscon-reboot device, the syscon-poweroff is supposed to be a
child of syscon node, thus we can take the same approach as
syscon-poweroff: deprecate the 'regmap' field in favor of taking it from
the parent's node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/reset/syscon-poweroff.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/syscon-poweroff.c
index 11b955983279..764aeea6c34a 100644
--- a/drivers/power/reset/syscon-poweroff.c
+++ b/drivers/power/reset/syscon-poweroff.c
@@ -37,8 +37,11 @@ static int syscon_poweroff_probe(struct platform_device *pdev)
 
 	map = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
 	if (IS_ERR(map)) {
-		dev_err(dev, "unable to get syscon");
-		return PTR_ERR(map);
+		map = syscon_node_to_regmap(dev->parent->of_node);
+		if (IS_ERR(map)) {
+			dev_err(dev, "unable to get syscon");
+			return PTR_ERR(map);
+		}
 	}
 
 	if (of_property_read_u32(dev->of_node, "offset", &offset)) {
-- 
2.34.1

