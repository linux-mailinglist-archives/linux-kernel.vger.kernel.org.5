Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DE178F8CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348426AbjIAHAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345362AbjIAHAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:00:06 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 389DFC5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 00:00:04 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,218,1688396400"; 
   d="scan'208";a="178409324"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2023 16:00:03 +0900
Received: from localhost.localdomain (unknown [10.226.92.203])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D1255400264E;
        Fri,  1 Sep 2023 15:59:59 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 1/3] ASoC: wm8580: Simplify probe()
Date:   Fri,  1 Sep 2023 07:59:50 +0100
Message-Id: <20230901065952.18760-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230901065952.18760-1-biju.das.jz@bp.renesas.com>
References: <20230901065952.18760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify probe() by replacing of_match_device->i2c_get_match_data()
and extend matching support for ID table.

While at it, remove comma in the terminator entry and simplify probe()
by replacing dev_err()->dev_err_probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3->v4:
 * No change.
v2->v3:
 * Added Rb tag from Andy.
 * Restored OF table postion and moved in patch#2
v1->v2:
 * Added Ack from Charles Keepax.
 * Removed comma in the terminator entry.
 * Restored original error code -EINVAL
---
 sound/soc/codecs/wm8580.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 6d22f7d40ec2..826c39ec4a1e 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -997,7 +997,6 @@ MODULE_DEVICE_TABLE(of, wm8580_of_match);
 
 static int wm8580_i2c_probe(struct i2c_client *i2c)
 {
-	const struct of_device_id *of_id;
 	struct wm8580_priv *wm8580;
 	int ret, i;
 
@@ -1022,14 +1021,9 @@ static int wm8580_i2c_probe(struct i2c_client *i2c)
 
 	i2c_set_clientdata(i2c, wm8580);
 
-	of_id = of_match_device(wm8580_of_match, &i2c->dev);
-	if (of_id)
-		wm8580->drvdata = of_id->data;
-
-	if (!wm8580->drvdata) {
-		dev_err(&i2c->dev, "failed to find driver data\n");
-		return -EINVAL;
-	}
+	wm8580->drvdata = i2c_get_match_data(i2c);
+	if (!wm8580->drvdata)
+		return dev_err_probe(&i2c->dev, -EINVAL, "failed to find driver data\n");
 
 	ret = devm_snd_soc_register_component(&i2c->dev,
 			&soc_component_dev_wm8580, wm8580_dai, ARRAY_SIZE(wm8580_dai));
-- 
2.25.1

