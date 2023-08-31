Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F06B78F387
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344969AbjHaTql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347244AbjHaTqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:46:39 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 458FEE7B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:46:36 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,217,1688396400"; 
   d="scan'208";a="174632400"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2023 04:46:36 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A3F7740078BB;
        Fri,  1 Sep 2023 04:46:32 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <x1077012@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/3] ASoC: tlv320aic32x4-i2c: Simplify probe()
Date:   Thu, 31 Aug 2023 20:46:21 +0100
Message-Id: <20230831194622.87653-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831194622.87653-1-biju.das.jz@bp.renesas.com>
References: <20230831194622.87653-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify probe() by replacing of_match_node() and i2c_match_id() with
i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2->v3:
 * Added Rb tag from Andy.
v1->v2:
 * Return value of i2c_get_match_data() passed to type paramemter in
   aic32x4_probe().
---
 sound/soc/codecs/tlv320aic32x4-i2c.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-i2c.c b/sound/soc/codecs/tlv320aic32x4-i2c.c
index 713f3f63b5e3..b27b5ae1e4b2 100644
--- a/sound/soc/codecs/tlv320aic32x4-i2c.c
+++ b/sound/soc/codecs/tlv320aic32x4-i2c.c
@@ -16,9 +16,6 @@
 
 #include "tlv320aic32x4.h"
 
-static const struct of_device_id aic32x4_of_id[];
-static const struct i2c_device_id aic32x4_i2c_id[];
-
 static int aic32x4_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap *regmap;
@@ -30,18 +27,7 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c)
 	config.val_bits = 8;
 
 	regmap = devm_regmap_init_i2c(i2c, &config);
-
-	if (i2c->dev.of_node) {
-		const struct of_device_id *oid;
-
-		oid = of_match_node(aic32x4_of_id, i2c->dev.of_node);
-		type = (uintptr_t)oid->data;
-	} else {
-		const struct i2c_device_id *id;
-
-		id = i2c_match_id(aic32x4_i2c_id, i2c);
-		type = id->driver_data;
-	}
+	type = (uintptr_t)i2c_get_match_data(i2c);
 
 	return aic32x4_probe(&i2c->dev, regmap, type);
 }
-- 
2.25.1

