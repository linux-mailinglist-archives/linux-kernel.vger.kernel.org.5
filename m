Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98B37B3907
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjI2RjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjI2RjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:39:18 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AE4195;
        Fri, 29 Sep 2023 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696009154;
        bh=W5xM3Txn9PEOVtEBA1zRK/LCXQhgKhgHvmFCijy64WI=;
        h=From:Date:Subject:To:Cc:From;
        b=mYmvzhSAvNPEUX4++pDCcwGZX82vBn8zpTox1N/nKOcaWJ/XNUQFvC64j1Sivcjeb
         BI5pvqdk0lYwwsuYb/bbSSRhXikXMO4e5tizZwZQdVrh/R2Rd8WH4Yo/TPKlXlfkby
         MAguxAZx6BCu8u1Ba4gZZu/oWpCTy49cHi+Tw23c=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Fri, 29 Sep 2023 19:39:00 +0200
Subject: [PATCH] power: supply: core: remove opencoded string_lower()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230929-power_supply-string_lower-v1-1-3141a2634d53@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIALMLF2UC/x2MWwqAMAzAriL9duAmKPMqIiJatSBztD4Z3t3pZ
 wJJAEEmFKiSAIwHCa0ugk4T6OfOTahoiAwmM3lmjVV+PZFb2b1fbiUbk5va5XMq14UebVkiFgZ
 i7xlHuv533TzPC0m8GyxrAAAA
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696009154; l=1573;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=W5xM3Txn9PEOVtEBA1zRK/LCXQhgKhgHvmFCijy64WI=;
 b=iCSDW/uuOBs5cAmRcRWMdP4nKFuq3RlYVhLVRLvmDfOGl9Rz0bJQ0M9WpROsOOdM9w59s+Yl/
 MR9NyysF9vhDYmGw5EHd1mBHgtsIwl4a2vgElRfwGyUrNkaa61eTkKS
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

string_lower from string_helpers.h can be used to modify the string
in-place.
Use it to get rid of the custom str_to_lower().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_sysfs.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index d483a81560ab..977611e16373 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -15,6 +15,7 @@
 #include <linux/power_supply.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/string_helpers.h>
 
 #include "power_supply.h"
 
@@ -398,14 +399,6 @@ static const struct attribute_group *power_supply_attr_groups[] = {
 	NULL,
 };
 
-static void str_to_lower(char *str)
-{
-	while (*str) {
-		*str = tolower(*str);
-		str++;
-	}
-}
-
 void power_supply_init_attrs(struct device_type *dev_type)
 {
 	int i;
@@ -420,7 +413,8 @@ void power_supply_init_attrs(struct device_type *dev_type)
 				__func__, i);
 			sprintf(power_supply_attrs[i].attr_name, "_err_%d", i);
 		} else {
-			str_to_lower(power_supply_attrs[i].attr_name);
+			string_lower(power_supply_attrs[i].attr_name,
+				     power_supply_attrs[i].attr_name);
 		}
 
 		attr = &power_supply_attrs[i].dev_attr;

---
base-commit: 71e58659bfc02e4171345f80b13d6485e9cdf687
change-id: 20230929-power_supply-string_lower-3161f977ee62

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

