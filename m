Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A9476FC17
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjHDIfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHDIfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:35:19 -0400
Received: from mail-ej1-x661.google.com (mail-ej1-x661.google.com [IPv6:2a00:1450:4864:20::661])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8433D3A85
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:35:16 -0700 (PDT)
Received: by mail-ej1-x661.google.com with SMTP id a640c23a62f3a-99bcc0adab4so259638166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google; t=1691138115; x=1691742915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GSVTdC1th3Ukx8AgC8lNqpynQmQtELOulnR7M8l/f7M=;
        b=KOwPaz7gZkyWZPuu2uMYiRqp4NRH9rSvMOyZmicVUYzhf96luS1dtfsdjKlQ/9wdNK
         Kg3ZNGMcr8xDjqht23BvMyOFPdrBlVEGnaCBs07jHmJ1btj3A3ZRMn9KJ0M1aA8vrbB3
         MnRAHEQW3urPDuCU3wGK/c/nJRezsALhpmZsadtxzMF/dC5LnsdhyvEFukkv1TeFmm0d
         mJyUeIhfxp5Y5whOrJyyulpKo8G+XmYtNNMVjj4wKJBrssHP7dyXJwzKHPOTSVfSupBy
         b8F0Gt1qvAMTx8EWz9TTOel4kHY0Y/PxpwQTx62uDtAEyh9VebmWUmg1HlRnvEcnFQeU
         RL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138115; x=1691742915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSVTdC1th3Ukx8AgC8lNqpynQmQtELOulnR7M8l/f7M=;
        b=jJ/Y/6+HQ/4oMSMNftFihUHTpmWThIWkHJYM9xdzg8tB4SgGk89PlZoh4QkZ4O0675
         Y06A4YJGMjJGuO0lkDLt+xNPvP4UkQdCpRBUj1RWQUEHk2HVChiUuS1cGibuVpuFJ8bK
         x9HCyQ3dCBarP3D15bQayyPIcl/YPMxsflQHkRpK0TyE/JJYdV9HntyUiCg+iDrc69Mz
         Fm2VaqEQ59aCN2Q8a/RdN2Sv9I8vwb6Qa8PowFlKrcePRLPliteKFNDZ8RwDiBOYWsxj
         PcWw3ZZ/cyJB1zkDKJHBPMdNGs7ttwVosireVj94cGnBve0hErPHYGerBJOpJfOCQHl5
         OcgA==
X-Gm-Message-State: AOJu0YwmqZqwH5UhHhElgBQLwJMFnqXWBKwUfSEXfclXgxY0d3lEAE6e
        4HaIuJsomuVLRdWXfgji5xwEwwEDVzdvz5k/zfYuBPjytafw
X-Google-Smtp-Source: AGHT+IFScUhdHbtrS37ckTH4rX3ST8P3AMBSAm/pAMtaNEohm2GA5/IprLxWn1V1GuxPyryYYT/WlAxGYCGh
X-Received: by 2002:a17:906:51c6:b0:99b:d007:67b1 with SMTP id v6-20020a17090651c600b0099bd00767b1mr994884ejk.72.1691138114959;
        Fri, 04 Aug 2023 01:35:14 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id t24-20020a170906065800b00982360305f5sm172071ejb.9.2023.08.04.01.35.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 04 Aug 2023 01:35:14 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.12.154] (port=40918 helo=FR-BES-DKT15120.home)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1qRqJX-0003QU-T1; Fri, 04 Aug 2023 10:37:39 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     Mark Brown <broonie@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: da9063: better fix null deref with partial DT
Date:   Fri,  4 Aug 2023 10:34:30 +0200
Message-Id: <20230804083514.1887124-1-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 2.25.1
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

Two versions of the original patch were sent but V1 was merged instead
of V2 due to a mistake.

So update to V2.

The advantage of V2 is that it completely avoids dereferencing the pointer,
even just to take the address, which may fix problems with some compilers.
Both versions work on my gcc 9.4 but use the safer one.

Fixes: 98e2dd5f7a8b ("regulator: da9063: fix null pointer deref with partial DT config")
Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
Tested-by: Benjamin Bara <benjamin.bara@skidata.com>
Cc: stable@vger.kernel.org
---
 drivers/regulator/da9063-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index dfd5ec9f75c9..a0621665a6d2 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -778,9 +778,6 @@ static int da9063_check_xvp_constraints(struct regulator_config *config)
 	const struct notification_limit *uv_l = &constr->under_voltage_limits;
 	const struct notification_limit *ov_l = &constr->over_voltage_limits;
 
-	if (!config->init_data) /* No config in DT, pointers will be invalid */
-		return 0;
-
 	/* make sure that only one severity is used to clarify if unchanged, enabled or disabled */
 	if ((!!uv_l->prot + !!uv_l->err + !!uv_l->warn) > 1) {
 		dev_err(config->dev, "%s: at most one voltage monitoring severity allowed!\n",
@@ -1031,9 +1028,12 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 			config.of_node = da9063_reg_matches[id].of_node;
 		config.regmap = da9063->regmap;
 
-		ret = da9063_check_xvp_constraints(&config);
-		if (ret)
-			return ret;
+		/* Checking constraints requires init_data from DT. */
+		if (config.init_data) {
+			ret = da9063_check_xvp_constraints(&config);
+			if (ret)
+				return ret;
+		}
 
 		regl->rdev = devm_regulator_register(&pdev->dev, &regl->desc,
 						     &config);
-- 
2.25.1

