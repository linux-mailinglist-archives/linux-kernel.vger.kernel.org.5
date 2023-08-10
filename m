Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8353E7776BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjHJLT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjHJLTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:19:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA22810D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:19:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bfcf4c814so118995266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666358; x=1692271158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek/EFmjYIZAWl1StO2DXwfZYUUJoPpWDI9dK+SHClFc=;
        b=sWcRcAm2WnY2nBcI5QrjyIh2fIJrpdk23DLspFdb3hY634Tpf2dzqMe5bqtn4CI436
         Xpwavp3HD1r/p38EK5rRiOq0t4GWo//DoiUXdOBBfmtYJGCdIaY/1vVJIyc4z4vcn4ZC
         petuZA1Bb584OYkxgPAmCcK5anl9IK01RSZ8L6n2KXYLsjuU9RpZ1MUuyT6lrDFfZCsT
         bG6gBNH+mBqT5wWmVb3wo/Xi9sBP1Fz+crpOgAUPu9YPfksP2Egbvdngc6lKatE2mM63
         SLuW3FuP4rXOsnZw1QWSS0DP56hsjOw0PkHAkE8qxZtwuTE2raSmQHmTx701DDvKLSe2
         N5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666358; x=1692271158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ek/EFmjYIZAWl1StO2DXwfZYUUJoPpWDI9dK+SHClFc=;
        b=MLHsJfxJn8Z7IHmygBIcW9h46SXyXBHoP20p6xbQWd5wuAuiSTg+raYBAd28gTXf7D
         WBsMu293bXzjhmWCgHp3a1rR/oX5kscmKPvYRhn8ERZxeSjQ4YxIWeOGzhMqxBFNnTXu
         8SEAHQMEtdM1uH+zEi4vm3ZvnB2iMnM97eIXxaGXn+pmdp6HgVkqYvSpa5Y7GaAFGEhx
         BohEWZcO/6OxGD25nrIO7MZnjV1H+pnxhHXbEDGinvN4mSkImjxVLwJ7AEAXq+nadxa6
         C3wcEY9ZZ5kfcusBnC/O2E+NB2mVYc7JutVleSHnX0Aa+St2K/hp1DCERKEsUf6nDkGG
         i6yQ==
X-Gm-Message-State: AOJu0YxZRSww0xjPdUIx/ZDN4J1vYv7eTcddHV6czMJRhGgln4+XyKIr
        OE4KDqESrASHTzpamjmVWCfphg==
X-Google-Smtp-Source: AGHT+IF5IupLT9h3p6U7AYxRTllmVW4Kr+Namj6Wfx45DTSBI9K+JDUIkqhUz3mBkqTa9RE6YIz3KQ==
X-Received: by 2002:a17:907:75c9:b0:99b:ef1e:3836 with SMTP id jl9-20020a17090775c900b0099bef1e3836mr1922452ejc.9.1691666358538;
        Thu, 10 Aug 2023 04:19:18 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id qn17-20020a170907211100b00992b510089asm797018ejb.84.2023.08.10.04.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:19:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] regulator: max77857: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 13:19:13 +0200
Message-Id: <20230810111914.204847-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810111914.204847-1-krzysztof.kozlowski@linaro.org>
References: <20230810111914.204847-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'id' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  max77857-regulator.c:56:24: error: cast to smaller integer type 'enum max77857_id' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/max77857-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max77857-regulator.c b/drivers/regulator/max77857-regulator.c
index 44a510547318..145ad0281857 100644
--- a/drivers/regulator/max77857-regulator.c
+++ b/drivers/regulator/max77857-regulator.c
@@ -53,7 +53,7 @@ enum max77857_id {
 
 static bool max77857_volatile_reg(struct device *dev, unsigned int reg)
 {
-	enum max77857_id id = (enum max77857_id)dev_get_drvdata(dev);
+	enum max77857_id id = (uintptr_t)dev_get_drvdata(dev);
 
 	switch (id) {
 	case ID_MAX77831:
@@ -91,7 +91,7 @@ static int max77857_get_status(struct regulator_dev *rdev)
 
 static unsigned int max77857_get_mode(struct regulator_dev *rdev)
 {
-	enum max77857_id id = (enum max77857_id)rdev_get_drvdata(rdev);
+	enum max77857_id id = (uintptr_t)rdev_get_drvdata(rdev);
 	unsigned int regval;
 	int ret;
 
@@ -125,7 +125,7 @@ static unsigned int max77857_get_mode(struct regulator_dev *rdev)
 
 static int max77857_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
-	enum max77857_id id = (enum max77857_id)rdev_get_drvdata(rdev);
+	enum max77857_id id = (uintptr_t)rdev_get_drvdata(rdev);
 	unsigned int reg, val;
 
 	switch (id) {
-- 
2.34.1

