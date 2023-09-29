Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBA47B3465
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjI2OLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjI2OLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:11:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BEE1B7;
        Fri, 29 Sep 2023 07:11:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94B3C433CA;
        Fri, 29 Sep 2023 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695996694;
        bh=QDzwivM9waT9P3iQApji1MwpmtdWkdeTyx0Uagh5Pj4=;
        h=From:Date:Subject:To:Cc:From;
        b=pP9LARu977UQoMcfnHW7o4VD1t3C1SIf/NcQ+ClVo18vpixPGKC1XCplMj6uP9akF
         2W0YfmAtqG3BAIPG0GLfMAvjGTZD7LntYjudfB5Zla/1zf441vSURxY90beZJbXZW5
         pxmKyCwpWjs7OWZpHQx6Zrvthe3EPBqT1AFyxdo5Fwn0yGrEpQW3VPCC7mCyFfvq6u
         hf06eHqBAl8peOcONEmYTbxxgPwCX0ForXG7v9itF9mj0D5d95JI1V3UzaFEbAaTRB
         0763v0GHf+eUOfb64ECd8wr+RYWwSXvni7uc/USWlZ4/iuUVrX3AvTU+XNH89eB777
         qLyQkl/qxaqpw==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 16:11:24 +0200
Subject: [PATCH] gpio: fx6408: Convert to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-gpio-fx16408-v1-1-7fdd3218f7d6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAvbFmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSyNL3fSCzHzdtApDMxMDC10Tc7MkQxMTcxOzpGQloJaCotS0zAqwcdG
 xtbUAebgutV4AAAA=
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QDzwivM9waT9P3iQApji1MwpmtdWkdeTyx0Uagh5Pj4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFtsVtRqMuMLDGIsqZL/rf92AgoNUdo2rro3rl
 HectEvnM12JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbbFQAKCRAk1otyXVSH
 0BzpB/9LSosAdCA5uHVpkR1EbHufGrxMKwZe0zPvXZF57Rz5eSvSbenexUt0nxqKMU+QsDE2E8n
 6DLAscury3Ka21ZYrnvcxL5EjcmX6/n6vwZUZ0gkE/fgzm5CldLCYDuqey96dIJ8i8pw1OJZNq0
 LCH/4PiCzV7JSvX+MfuNQbZRipwVLbn131skSrxDXB/qoJLq5m/SMd+oAP5c51YpNqc6GXPPmRg
 oWLN/y3PUszaacLwqElnv6dRqoeoNH8MUx3cUUAkgMBfxmZfJVm08stzQ6DbMeY9cSW8F9vCrWL
 YQDluy0vn4xRkLwhyWaVFrFR/lBBnSVjFBtizB2CFXuoQVm9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpio/gpio-fxl6408.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-fxl6408.c b/drivers/gpio/gpio-fxl6408.c
index c14b5cc5e519..991549888904 100644
--- a/drivers/gpio/gpio-fxl6408.c
+++ b/drivers/gpio/gpio-fxl6408.c
@@ -84,7 +84,7 @@ static const struct regmap_config regmap = {
 	.rd_table = &rd_table,
 	.volatile_table = &volatile_table,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.num_reg_defaults_raw = FXL6408_REG_INT_STS + 1,
 };
 

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230929-gpio-fx16408-476b144746bc

Best regards,
-- 
Mark Brown <broonie@kernel.org>

