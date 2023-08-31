Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CDF78F388
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347246AbjHaTqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347241AbjHaTqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:46:42 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34FD2E65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:46:40 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,217,1688396400"; 
   d="scan'208";a="174632404"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2023 04:46:40 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9049840062C9;
        Fri,  1 Sep 2023 04:46:36 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <x1077012@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/3] ASoC: tlv320aic32x4-spi: Simplify probe()
Date:   Thu, 31 Aug 2023 20:46:22 +0100
Message-Id: <20230831194622.87653-4-biju.das.jz@bp.renesas.com>
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

Simplify probe() by replacing of_match_node() and spi_get_device_id() with
spi_get_device_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch
---
 sound/soc/codecs/tlv320aic32x4-spi.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-spi.c b/sound/soc/codecs/tlv320aic32x4-spi.c
index 81c05030dd3b..d5976c91766e 100644
--- a/sound/soc/codecs/tlv320aic32x4-spi.c
+++ b/sound/soc/codecs/tlv320aic32x4-spi.c
@@ -16,8 +16,6 @@
 
 #include "tlv320aic32x4.h"
 
-static const struct of_device_id aic32x4_of_id[];
-
 static int aic32x4_spi_probe(struct spi_device *spi)
 {
 	struct regmap *regmap;
@@ -31,18 +29,7 @@ static int aic32x4_spi_probe(struct spi_device *spi)
 	config.read_flag_mask = 0x01;
 
 	regmap = devm_regmap_init_spi(spi, &config);
-
-	if (spi->dev.of_node) {
-		const struct of_device_id *oid;
-
-		oid = of_match_node(aic32x4_of_id, spi->dev.of_node);
-		type = (uintptr_t)oid->data;
-	} else {
-		const struct spi_device_id *id_entry;
-
-		id_entry = spi_get_device_id(spi);
-		type = id_entry->driver_data;
-	}
+	type = (uintptr_t)spi_get_device_match_data(spi);
 
 	return aic32x4_probe(&spi->dev, regmap, type);
 }
-- 
2.25.1

