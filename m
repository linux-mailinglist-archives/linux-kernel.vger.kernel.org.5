Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46247585B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjGRTjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjGRTjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:39:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCBE1993
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:39:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A36960B5C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B585AC433C8;
        Tue, 18 Jul 2023 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689709183;
        bh=OI+6NAgh7fvRkW4GOVEolrLWGzju1tGac3iQGqIIz7Q=;
        h=From:To:Cc:Subject:Date:From;
        b=KhMX2Ptpq5Ss99M/8yx6BhTUwqIjkES2nocQw3xhJNpXm5Zcc3mvCiIY00aPcaxMY
         ETLnuW8er3b9pKI0dw29LSdwldXUhz8Zw6JiF/VdgEg9+UE5ruLGrN6uF/KloieXZm
         yRwKP55z+YJCsbvZfP3pCox7TAXv0Qx3pLq9T2uKKgOO2ZA1sqebqFiSr5Qt/td1QY
         TqEMaRazrkDtgKFaDO19UAmIMDhgISKrYFT9LbG2CdsTIS3CkdbFQu7T3r+w4sslA5
         YTXza9gNduntAZwa5AaIoxDDygwsUsLfUAWWoqxk+ImYl/S5ANdqX1trY7QHPRcR/5
         3yKpentG//Dkw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Okan Sahin <okan.sahin@analog.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: max77857: mark more functions static
Date:   Tue, 18 Jul 2023 21:39:31 +0200
Message-Id: <20230718193938.3593118-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

A few functions in the new driver are global but only used in this file:

drivers/regulator/max77857-regulator.c:209:5: error: no previous prototype for 'max77859_get_voltage_sel' [-Werror=missing-prototypes]
drivers/regulator/max77857-regulator.c:221:5: error: no previous prototype for 'max77859_set_current_limit' [-Werror=missing-prototypes]
drivers/regulator/max77857-regulator.c:235:5: error: no previous prototype for 'max77859_get_current_limit' [-Werror=missing-prototypes]

Mark them static, which produces potentially better code and avoids the warning.

Fixes: af71cccadeced ("regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator Support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/regulator/max77857-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max77857-regulator.c b/drivers/regulator/max77857-regulator.c
index c5482ffd606ec..e1150a9a11f26 100644
--- a/drivers/regulator/max77857-regulator.c
+++ b/drivers/regulator/max77857-regulator.c
@@ -206,7 +206,7 @@ static int max77859_set_voltage_sel(struct regulator_dev *rdev,
 			       MAX77859_CONT3_DVS_START);
 }
 
-int max77859_get_voltage_sel(struct regulator_dev *rdev)
+static int max77859_get_voltage_sel(struct regulator_dev *rdev)
 {
 	__be16 reg;
 	int ret;
@@ -218,7 +218,7 @@ int max77859_get_voltage_sel(struct regulator_dev *rdev)
 	return FIELD_GET(MAX77859_VOLTAGE_SEL_MASK, __be16_to_cpu(reg));
 }
 
-int max77859_set_current_limit(struct regulator_dev *rdev, int min_uA, int max_uA)
+static int max77859_set_current_limit(struct regulator_dev *rdev, int min_uA, int max_uA)
 {
 	u32 selector;
 
@@ -232,7 +232,7 @@ int max77859_set_current_limit(struct regulator_dev *rdev, int min_uA, int max_u
 	return regmap_write(rdev->regmap, MAX77859_REG_CONT5, selector);
 }
 
-int max77859_get_current_limit(struct regulator_dev *rdev)
+static int max77859_get_current_limit(struct regulator_dev *rdev)
 {
 	u32 selector;
 	int ret;
-- 
2.39.2

