Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1420B751FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjGMLV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjGMLVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:21:54 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0801F26AE;
        Thu, 13 Jul 2023 04:21:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 11B531BF208;
        Thu, 13 Jul 2023 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689247287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iaGYvCgK+q34WSSKPrB7Pwd2mXJV/fa98+tweN5VGpM=;
        b=FO5o8KINBx1x1L7zhGkRhU8SP3FUAyfCOs7X7oc5mb8/MVXkEecsnsdJBw2FHsTj//zXWx
        JF2fSPm9nqxFZBGb9/5AQfXTfkVzUIFwIMQ3+3JQ8NU7g00x4gaxx20bWeZw1UDPtudnJC
        cdfX+WmX/UYI33ykOCFMb0uQp/Cxwr6pw7k3pAuMO0FwYoAxb9y3X0ZCEksDVf+U0xDp0Q
        ROegZkDmZ9o0YOSgVxwKFckGtsSlOhVTvGGbLAPoblZe2NF/htdfOa9svxJ+rQtYCCxRW9
        vw4wYqRsy4vLjPqfspqG4VheFVKN5AjaKX1IgbwVc2D4zZpjsTCmXCK5NQl33w==
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: [PATCH] ASoC: cs42l51: fix driver to properly autoload with automatic module loading
Date:   Thu, 13 Jul 2023 13:21:12 +0200
Message-ID: <20230713112112.778576-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.petazzoni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 2cb1e0259f50 ("ASoC: cs42l51: re-hook of_match_table
pointer"), 9 years ago, some random guy fixed the cs42l51 after it was
split into a core part and an I2C part to properly match based on a
Device Tree compatible string.

However, the fix in this commit is wrong: the MODULE_DEVICE_TABLE(of,
....) is in the core part of the driver, not the I2C part. Therefore,
automatic module loading based on module.alias, based on matching with
the DT compatible string, loads the core part of the driver, but not
the I2C part. And threfore, the i2c_driver is not registered, and the
codec is not known to the system, nor matched with a DT node with the
corresponding compatible string.

In order to fix that, we move the MODULE_DEVICE_TABLE(of, ...) into
the I2C part of the driver. The cs42l51_of_match[] array is also moved
as well, as it is not possible to have this definition in one file,
and the MODULE_DEVICE_TABLE(of, ...) invocation in another file, due
to how MODULE_DEVICE_TABLE works.

Thanks to this commit, the I2C part of the driver now properly
autoloads, and thanks to its dependency on the core part, the core
part gets autoloaded as well, resulting in a functional sound card
without having to manually load kernel modules.

Fixes: 2cb1e0259f50 ("ASoC: cs42l51: re-hook of_match_table pointer")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 sound/soc/codecs/cs42l51-i2c.c | 6 ++++++
 sound/soc/codecs/cs42l51.c     | 7 -------
 sound/soc/codecs/cs42l51.h     | 1 -
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index b2106ff6a7cb..e7db7bcd0296 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -19,6 +19,12 @@ static struct i2c_device_id cs42l51_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs42l51_i2c_id);
 
+const struct of_device_id cs42l51_of_match[] = {
+	{ .compatible = "cirrus,cs42l51", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs42l51_of_match);
+
 static int cs42l51_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_config config;
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index a67cd3ee84e0..a7079ae0ca09 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -823,13 +823,6 @@ int __maybe_unused cs42l51_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(cs42l51_resume);
 
-const struct of_device_id cs42l51_of_match[] = {
-	{ .compatible = "cirrus,cs42l51", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, cs42l51_of_match);
-EXPORT_SYMBOL_GPL(cs42l51_of_match);
-
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
 MODULE_DESCRIPTION("Cirrus Logic CS42L51 ALSA SoC Codec Driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index a79343e8a54e..125703ede113 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -16,7 +16,6 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap);
 void cs42l51_remove(struct device *dev);
 int __maybe_unused cs42l51_suspend(struct device *dev);
 int __maybe_unused cs42l51_resume(struct device *dev);
-extern const struct of_device_id cs42l51_of_match[];
 
 #define CS42L51_CHIP_ID			0x1B
 #define CS42L51_CHIP_REV_A		0x00
-- 
2.41.0

