Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E767F2050
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjKTW2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjKTW2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:28:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3161497
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:28:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BF6C433C7;
        Mon, 20 Nov 2023 22:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700519318;
        bh=bXCpdr2eVuRieBZCu88Dpd9XKIAOtGduXyMB0bsi/HE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBiHsOdD3KFE8GxtQyGOtwJhdbYDQjLSx0xBZSXl51cmJVzogfiMVkEyyP7PPpEO9
         xWHVCPPxW1dHmLOjzgmKL2NC7B979wXZ6sOxh+wbDp1Hv/EdERIH/fq7cjjx3xHBsK
         rwGI1ixxwnCkJxpxkzgwy35DIlR9IC2mHrJTFmrrrGQxiid4BJ+yViM59Y5/UVWlGd
         pTKP3Rs4G0oWgvOHuG0e/X++HLOyGqN+2VW5b3MRH0Lvm8rcTAZUFA27650gv0fagv
         ut/siDNbDzj217yHO+Nlosn++OjCQWQMIlT1e4oY7mfnFX8BRxv3nxK96WL/OWzazz
         4/zqjeRsj5rxA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] pinctrl: pinconf-generic: resize the pin config array directly
Date:   Tue, 21 Nov 2023 07:28:31 +0900
Message-Id: <20231120222832.4063882-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120222832.4063882-1-masahiroy@kernel.org>
References: <20231120222832.4063882-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pinconf_generic_parse_dt_config() allocates memory that is large enough
to contain all the config parameters. Then, kmemdup() copies the found
configs to the memory with the exact size.

There is no need to allocate memory twice; you can directly resize the
initial memory using krealloc_array().

I also changed kcalloc() to kmalloc_array() to keep the consistency with
krealloc_array(). This change has no impact because you do not need to
zero out the 'cfg' array.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/pinctrl/pinconf-generic.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 8313cb5f3b3c..ba4fe2466e78 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -247,7 +247,6 @@ int pinconf_generic_parse_dt_config(struct device_node *np,
 {
 	unsigned long *cfg;
 	unsigned int max_cfg, ncfg = 0;
-	int ret;
 
 	if (!np)
 		return -EINVAL;
@@ -256,7 +255,7 @@ int pinconf_generic_parse_dt_config(struct device_node *np,
 	max_cfg = ARRAY_SIZE(dt_params);
 	if (pctldev)
 		max_cfg += pctldev->desc->num_custom_params;
-	cfg = kcalloc(max_cfg, sizeof(*cfg), GFP_KERNEL);
+	cfg = kmalloc_array(max_cfg, sizeof(*cfg), GFP_KERNEL);
 	if (!cfg)
 		return -ENOMEM;
 
@@ -266,30 +265,22 @@ int pinconf_generic_parse_dt_config(struct device_node *np,
 		parse_dt_cfg(np, pctldev->desc->custom_params,
 			     pctldev->desc->num_custom_params, cfg, &ncfg);
 
-	ret = 0;
-
 	/* no configs found at all */
 	if (ncfg == 0) {
+		kfree(cfg);
 		*configs = NULL;
 		*nconfigs = 0;
-		goto out;
+		return 0;
 	}
 
-	/*
-	 * Now limit the number of configs to the real number of
-	 * found properties.
-	 */
-	*configs = kmemdup(cfg, ncfg * sizeof(unsigned long), GFP_KERNEL);
-	if (!*configs) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	/* Now resize the array to store the real number of found properties. */
+	*configs = krealloc_array(cfg, ncfg, sizeof(unsigned long), GFP_KERNEL);
+	if (!*configs)
+		return -ENOMEM;
 
 	*nconfigs = ncfg;
 
-out:
-	kfree(cfg);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pinconf_generic_parse_dt_config);
 
-- 
2.40.1

