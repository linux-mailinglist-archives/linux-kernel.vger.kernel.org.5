Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE9575E7F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjGXBhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjGXBgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB1749DF;
        Sun, 23 Jul 2023 18:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 981D760F7A;
        Mon, 24 Jul 2023 01:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC73C433C7;
        Mon, 24 Jul 2023 01:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162305;
        bh=49ZYWdB0TYGJyVBafWTGK2cns5HV2jajdznxNr4Zybc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r32pvdBTX29bPSzltcLOp2syWFSOHfjW6DJrvCAvZ92c7kM454lRCEDQ7mOZW9S1g
         a6jZHy6ar5mTEgv95ONjj1DLgXmwr1eSPTgJuAzQKb6jpwt+VHKE18srBIP7cAuDjq
         5YFm7nppCvUM/hBKDbuvPFONS0yuSi+ufP1bZpx1d2K+/7xlGEkHtf+w6IW5YbOfWH
         oU2rwdRj3VVhkEH3cCp7lGbMzlSKrgQT+DAZ434EsWskL/NlBy7q9eYKeSRkMhj2ok
         mF7ROqS2WhReUv8kJKs52rLa8vMXB94Txc5IEeMrYhY800IF6BK5kQUDPjbuXn0U19
         u3j/GLIEOodlw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Hongfei <luhongfei@vivo.com>, Lee Jones <lee@kernel.org>,
        Sasha Levin <sashal@kernel.org>, rpurdie@rpsys.net,
        jacek.anaszewski@gmail.com, pavel@ucw.cz,
        linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 02/40] led: qcom-lpg: Fix resource leaks in for_each_available_child_of_node() loops
Date:   Sun, 23 Jul 2023 21:31:02 -0400
Message-Id: <20230724013140.2327815-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013140.2327815-1-sashal@kernel.org>
References: <20230724013140.2327815-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Hongfei <luhongfei@vivo.com>

[ Upstream commit 8f38f8fa7261819eb7d4fb369dc3bfab72259033 ]

Ensure child node references are decremented properly in the error path.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Link: https://lore.kernel.org/r/20230525111705.3055-1-luhongfei@vivo.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 1c849814a4917..212df2e3d3502 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1173,8 +1173,10 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 		i = 0;
 		for_each_available_child_of_node(np, child) {
 			ret = lpg_parse_channel(lpg, child, &led->channels[i]);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(child);
 				return ret;
+			}
 
 			info[i].color_index = led->channels[i]->color;
 			info[i].intensity = 0;
@@ -1352,8 +1354,10 @@ static int lpg_probe(struct platform_device *pdev)
 
 	for_each_available_child_of_node(pdev->dev.of_node, np) {
 		ret = lpg_add_led(lpg, np);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			return ret;
+		}
 	}
 
 	for (i = 0; i < lpg->num_channels; i++)
-- 
2.39.2

