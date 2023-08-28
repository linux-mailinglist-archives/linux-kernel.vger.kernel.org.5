Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80678B6BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjH1RtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjH1RtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:49:06 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8442A12E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:49:03 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,208,1688396400"; 
   d="scan'208";a="174236471"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2023 02:49:02 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D72F34048F0A;
        Tue, 29 Aug 2023 02:48:58 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2] ASoC: cs42xx8-i2c: Simplify probe()
Date:   Mon, 28 Aug 2023 18:48:56 +0100
Message-Id: <20230828174856.122559-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify probe() by replacing of_match_device->i2c_get_match_data() and
extend matching support for ID table. Also replace
dev_err()->dev_err_probe() to simplify the code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
Note:
 This patch is only compile tested.

v1->v2:
 * Added Ack from Charles Keepax.
 * Restored the error EINVAL.
---
 sound/soc/codecs/cs42xx8-i2c.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs42xx8-i2c.c b/sound/soc/codecs/cs42xx8-i2c.c
index a422472820fb..9028c0f0fe77 100644
--- a/sound/soc/codecs/cs42xx8-i2c.c
+++ b/sound/soc/codecs/cs42xx8-i2c.c
@@ -18,21 +18,15 @@
 
 #include "cs42xx8.h"
 
-static const struct of_device_id cs42xx8_of_match[];
-
 static int cs42xx8_i2c_probe(struct i2c_client *i2c)
 {
 	int ret;
 	struct cs42xx8_driver_data *drvdata;
-	const struct of_device_id *of_id;
-
-	of_id = of_match_device(cs42xx8_of_match, &i2c->dev);
-	if (!of_id) {
-		dev_err(&i2c->dev, "failed to find driver data\n");
-		return -EINVAL;
-	}
 
-	drvdata = (struct cs42xx8_driver_data *)of_id->data;
+	drvdata = (struct cs42xx8_driver_data *)i2c_get_match_data(i2c);
+	if (!drvdata)
+		return dev_err_probe(&i2c->dev, -EINVAL,
+				     "failed to find driver data\n");
 
 	ret = cs42xx8_probe(&i2c->dev,
 		devm_regmap_init_i2c(i2c, &cs42xx8_regmap_config), drvdata);
-- 
2.25.1

