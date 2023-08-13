Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791AD77A897
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjHMQDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjHMQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:03:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E11BE7;
        Sun, 13 Aug 2023 09:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E05063595;
        Sun, 13 Aug 2023 16:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C25AC433C8;
        Sun, 13 Aug 2023 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942558;
        bh=ISOphjDrsW6TjiazSKyOZf0nG3NXWsbXvGngRyQWbPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYCxjkBGtysMInJe6laFUS+IRjqUC7NnROjdg/Ji+Y6Ezwozk1KurjyfuU9GNPpnr
         qJBQiGrLy1GPLytu02ixazCg0FSZrN7YhZzthc7FLdZr973M2jl7/OiNqAYB22DOX1
         7UAlVTbPG+NauA40Dltk2PXGdNFKR5C+Qs34IJj7XiOCmk96RtElRU/GOBaQLj1Mpr
         /XofShx3Jj3UHfHeSG/dEsHBCeXCL7GZcKnf3YbAbud8ciXLpUkTidpj+Dr/JKaPWV
         gNQ6e+1Ye73xK+bSxN1vGxE0tG+9p0lXbDQmO/qDAC42VTnPbhRioIkUIS1vwA1CZ/
         o80BrqQRyKqbA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuming Fan <shumingf@realtek.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, oder_chiou@realtek.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 24/47] ASoC: rt5682-sdw: fix for JD event handling in ClockStop Mode0
Date:   Sun, 13 Aug 2023 11:59:19 -0400
Message-Id: <20230813160006.1073695-24-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
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

[ Upstream commit 02fb23d72720df2b6be3f29fc5787ca018eb92c3 ]

When the system suspends, peripheral Imp-defined interrupt is disabled.
When system level resume is invoked, the peripheral Imp-defined interrupts
should be enabled to handle JD events.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Reported-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://lore.kernel.org/r/20230721090643.128213-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682-sdw.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index c1a94229dc7e3..868a61c8b0608 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -786,8 +786,15 @@ static int __maybe_unused rt5682_dev_resume(struct device *dev)
 	if (!rt5682->first_hw_init)
 		return 0;
 
-	if (!slave->unattach_request)
+	if (!slave->unattach_request) {
+		if (rt5682->disable_irq == true) {
+			mutex_lock(&rt5682->disable_irq_lock);
+			sdw_write_no_pm(slave, SDW_SCP_INTMASK1, SDW_SCP_INT1_IMPL_DEF);
+			rt5682->disable_irq = false;
+			mutex_unlock(&rt5682->disable_irq_lock);
+		}
 		goto regmap_sync;
+	}
 
 	time = wait_for_completion_timeout(&slave->initialization_complete,
 				msecs_to_jiffies(RT5682_PROBE_TIMEOUT));
-- 
2.40.1

