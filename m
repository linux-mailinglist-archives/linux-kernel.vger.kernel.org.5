Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F44775E885
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjGXBmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjGXBlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:41:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB5E10F0;
        Sun, 23 Jul 2023 18:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEF5D60FC0;
        Mon, 24 Jul 2023 01:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545BCC433CB;
        Mon, 24 Jul 2023 01:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162362;
        bh=eXyvUkrwpMxOY34fwUW5NqWmLWH7bqUegN7Mlt4da2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gAHEvGOHze84rTxVIkumTHHYwYxovOyvgKeUHMqMOPgHFz6dJfV6SmhX0UKeyDag8
         laQlWq/WaPUBlaIHSyfbOEV4dKrEyrxZVTcUf9m+tAD6B/4GgWPIxl0prkSm4jBxSU
         0RK1Gy+ckxSYwMoqpHp+daA+QWK/MjDyuLjj0UL2AwIcGAPjr9sywP7vC+hvKSW5Dd
         DrLozHRSr7SID7A+fnAVpuakSt+dsE3LjRVjWV6yGiNrzFjZ9deSj8kBh7PDQ88FXY
         L5AA5FXHWBdGfgEzEy+xEGmXJDYpIrFVC4hehGP7dDaBU7/RC+CWOOwuATz0y1ucZZ
         9n38Lk6vkwz9A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Hongfei <luhongfei@vivo.com>, Lee Jones <lee@kernel.org>,
        Sasha Levin <sashal@kernel.org>, rpurdie@rpsys.net,
        jacek.anaszewski@gmail.com, pavel@ucw.cz,
        linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/34] led: qcom-lpg: Fix resource leaks in for_each_available_child_of_node() loops
Date:   Sun, 23 Jul 2023 21:32:05 -0400
Message-Id: <20230724013238.2329166-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index f1c2419334e6f..f85a5d65d1314 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1112,8 +1112,10 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
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
@@ -1291,8 +1293,10 @@ static int lpg_probe(struct platform_device *pdev)
 
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

