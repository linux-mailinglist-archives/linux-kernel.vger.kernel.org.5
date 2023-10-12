Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55C07C769C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441905AbjJLTWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJLTW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:22:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4877DB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:22:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C38C433C8;
        Thu, 12 Oct 2023 19:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697138547;
        bh=MF8UBOB+RPE0pevjlqdlPzoxbZCXJJU1HHFY/SxZI4k=;
        h=From:To:Cc:Subject:Date:From;
        b=t3WBVe0Kz1NyMj9SaVq+OxmMJKYeJHubR9/Ls9IDo/l4bjOajqO6UNd3Ajp3VfcKj
         eub6+1W6z9XCCsI4c1sFekcl1FAVPhTOUtEdDEtWDp00WlTJqNO6v3f8NYnQEcekLP
         PZmutOGGzl2NwdX0CueZQ5ARlcPbv13GySqtL5jSu3EdjI+u0RZR/dTFRyqsU0OWHy
         spEQl65b7D5CNAkOS1fcaW/8bYvqooEZrh7Alt5z++rjvJ9XdtWfS5DeQAsCD2zJrb
         pNq8cuBTEgL916C/DDIknT35QkbHgtRwiRTrp7P3Q7pHgiyHmJUtv+jFJXR5Do4Za5
         ka23mTmfDo6tQ==
Received: (nullmailer pid 1547085 invoked by uid 1000);
        Thu, 12 Oct 2023 19:22:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     kernel test robot <lkp@intel.com>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rockchip: Fix unused rockchip_i2s_tdm_match warning for !CONFIG_OF
Date:   Thu, 12 Oct 2023 14:22:00 -0500
Message-ID: <20231012192201.1546607-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9958d85968ed ("ASoC: Use device_get_match_data()") dropped the
unconditional use of rockchip_i2s_tdm_match resulting in this warning:

sound/soc/rockchip/rockchip_i2s_tdm.c:1315:34: warning: 'rockchip_i2s_tdm_match' defined but not used [-Wunused-const-variable=]

The fix is to drop of_match_ptr() which is not necessary because DT is
always used for this driver.

Fixes: 9958d85968ed ("ASoC: Use device_get_match_data()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310121802.CDAGVdF2-lkp@intel.com/
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 7e996550d1df..7e1625ad70c6 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -1759,7 +1759,7 @@ static struct platform_driver rockchip_i2s_tdm_driver = {
 	.remove = rockchip_i2s_tdm_remove,
 	.driver = {
 		.name = DRV_NAME,
-		.of_match_table = of_match_ptr(rockchip_i2s_tdm_match),
+		.of_match_table = rockchip_i2s_tdm_match,
 		.pm = &rockchip_i2s_tdm_pm_ops,
 	},
 };
-- 
2.42.0

