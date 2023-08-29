Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC0E78C58F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjH2Nds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbjH2Ndd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D6ECCF;
        Tue, 29 Aug 2023 06:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D00A6574C;
        Tue, 29 Aug 2023 13:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB00C433CB;
        Tue, 29 Aug 2023 13:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315954;
        bh=24D+O0ROl68RuyCISL7V7d9L9V1jcNP9honW3jJuhUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qgm5eoM4cTdmz4vncnGIMyHoqPInDfSPCKHJr5e/3bGWaAysFZj5Z9ErvuZqIIyt/
         JKSwe3v1z+oFEfmC/KoakXVqivDtAXTlQXXNRYwOWkr9Yl5kCKXJ52+pVuEvSWqMCS
         zvg5JJtPWv4E2uHo0c/o9wDMMSk4nehC6alsABAWe3pFBpFQouFYSvSpKP62KgjPjO
         IshuOYxxkyHltHtSSSP0sB1tvwgJiWawUYwlo4zMJ904aAIA4cP57l6Uyo3Ouur0WP
         H9RkgaUxN/8ziesGvwpu5Bgy6Ox6At3KhmqhaokOJclEe/9Pxx5rJuZfbL3zlKwZYH
         AULC9OdoIdmgQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuming Fan <shumingf@realtek.com>,
        Sasha Levin <sashal@kernel.org>, oder_chiou@realtek.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.4 12/17] ASoC: rt1308-sdw: fix random louder sound
Date:   Tue, 29 Aug 2023 09:31:59 -0400
Message-Id: <20230829133211.519957-12-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133211.519957-1-sashal@kernel.org>
References: <20230829133211.519957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit 37aba3190891d4de189bd5192ee95220e295f34d ]

This patch uses a vendor register to check whether the system hibernated ever.
The driver will only set the preset when the driver brings up or the system hibernated.
It will avoid the unknown issue that makes the speaker output louder and can't control the volume.

Signed-off-by: Shuming Fan <shumingf@realtek.com
Link: https://lore.kernel.org/r/20230811093822.37573-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt1308-sdw.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index 1797af824f60b..e2699c0b117be 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -52,6 +52,7 @@ static bool rt1308_volatile_register(struct device *dev, unsigned int reg)
 	case 0x300a:
 	case 0xc000:
 	case 0xc710:
+	case 0xcf01:
 	case 0xc860 ... 0xc863:
 	case 0xc870 ... 0xc873:
 		return true;
@@ -213,7 +214,7 @@ static int rt1308_io_init(struct device *dev, struct sdw_slave *slave)
 {
 	struct rt1308_sdw_priv *rt1308 = dev_get_drvdata(dev);
 	int ret = 0;
-	unsigned int tmp;
+	unsigned int tmp, hibernation_flag;
 
 	if (rt1308->hw_init)
 		return 0;
@@ -242,6 +243,10 @@ static int rt1308_io_init(struct device *dev, struct sdw_slave *slave)
 
 	pm_runtime_get_noresume(&slave->dev);
 
+	regmap_read(rt1308->regmap, 0xcf01, &hibernation_flag);
+	if ((hibernation_flag != 0x00) && rt1308->first_hw_init)
+		goto _preset_ready_;
+
 	/* sw reset */
 	regmap_write(rt1308->regmap, RT1308_SDW_RESET, 0);
 
@@ -282,6 +287,12 @@ static int rt1308_io_init(struct device *dev, struct sdw_slave *slave)
 	regmap_write(rt1308->regmap, 0xc100, 0xd7);
 	regmap_write(rt1308->regmap, 0xc101, 0xd7);
 
+	/* apply BQ params */
+	rt1308_apply_bq_params(rt1308);
+
+	regmap_write(rt1308->regmap, 0xcf01, 0x01);
+
+_preset_ready_:
 	if (rt1308->first_hw_init) {
 		regcache_cache_bypass(rt1308->regmap, false);
 		regcache_mark_dirty(rt1308->regmap);
-- 
2.40.1

