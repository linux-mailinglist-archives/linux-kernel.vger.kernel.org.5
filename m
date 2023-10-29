Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C047DAF26
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjJ2W5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjJ2W4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:56:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6206E1;
        Sun, 29 Oct 2023 15:55:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EE3C433C9;
        Sun, 29 Oct 2023 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620140;
        bh=3WqHVuQmYqKjH49ZdI3DyMGWGcEBUXr7RFhzrjTJFhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TD5CqIn0imcIWVLJ/3i+5GeO4pHgAQq3nAC1hyMiQNNefLP/PSB21A7t334zLICbS
         D/7JXhphfMqfa+GlogfibeIUMQnts6QdGffKgs2WDtSJVX8LYkNdtO6b8F2XwCLZc1
         I1uvRIO/dsKse+KZpU09OWUvqJb3/pul+qqi3yMKb8ciCWyPxB16p8/lZt+ozvQEIM
         ztgMVC5wkyVtgMWodzPs+Esszyp2sbvefqef09Cv/u0kVnPhTooYU/0kTLOAq1GNCj
         7Uvgf9i9F0v/yuChg724ctBO7+DWT66IIItTZv6LGaqFb4cl2vEskCjWDWkN9SZkqt
         Fjb7aKd6L/Nzg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Roy Chateau <roy.chateau@mep-info.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, shenghao-ding@ti.com,
        kevin-lu@ti.com, baojun.xu@ti.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.5 29/52] ASoC: codecs: tas2780: Fix log of failed reset via I2C.
Date:   Sun, 29 Oct 2023 18:53:16 -0400
Message-ID: <20231029225441.789781-29-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roy Chateau <roy.chateau@mep-info.com>

[ Upstream commit 4e9a429ae80657bdc502d3f5078e2073656ec5fd ]

Correctly log failures of reset via I2C.

Signed-off-by: Roy Chateau <roy.chateau@mep-info.com>
Link: https://lore.kernel.org/r/20231013110239.473123-1-roy.chateau@mep-info.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2780.c b/sound/soc/codecs/tas2780.c
index 86bd6c18a9440..41076be238542 100644
--- a/sound/soc/codecs/tas2780.c
+++ b/sound/soc/codecs/tas2780.c
@@ -39,7 +39,7 @@ static void tas2780_reset(struct tas2780_priv *tas2780)
 		usleep_range(2000, 2050);
 	}
 
-	snd_soc_component_write(tas2780->component, TAS2780_SW_RST,
+	ret = snd_soc_component_write(tas2780->component, TAS2780_SW_RST,
 				TAS2780_RST);
 	if (ret)
 		dev_err(tas2780->dev, "%s:errCode:0x%x Reset error!\n",
-- 
2.42.0

