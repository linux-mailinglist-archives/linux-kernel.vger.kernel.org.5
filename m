Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A7D7B46C0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbjJAK0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjJAK0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:26:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA99BD
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 03:26:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74055C433C9;
        Sun,  1 Oct 2023 10:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696155966;
        bh=V7OXee8raUC8dwb0bE/FHj2NE8mjYScLr3Xy6xI6M8w=;
        h=From:Date:Subject:To:Cc:From;
        b=N80L8JfpgWjWlJsiV3V1Nn9qRslzlMmC9FqQdcakAFy4pf1S//kWMYSJXQ2twoa6l
         WBxzinVVKCTazkbAYGW8HqAs8VbG9e0h4tnOKR/xe9di0Pd1VRfCqfnv0vQDZEjYge
         nJKgLGHvVkB1mgSLkR5MF1pppld2Wh8FME5oSGA61oeAAUrpNEgO+zTDn5gu2Pc5m6
         so168JQE6fOQl68x9uorLhHrLNBPjT4N3kCFR5MDM2urbpdlPtcIQNoy+8mDHLxT3l
         DJSNpvOJiMBy77VuJ6c29UkHaTv15LN0k4fctRtfhzVGbiXpkrTqUNJM8xeV2hPCDE
         gRAiM3kO6aHLA==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 11:24:49 +0100
Subject: [PATCH] drm/bridge: lt9211: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-drm-lt9211-maple-v1-1-1cf74fb10991@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPBIGWUC/x3MQQqAIBBA0avErBvQiSi7SrSwnGogLTQiiO6et
 HyL/x9IHIUTdMUDkS9JsocMXRYwrTYsjOKygRRVypBBFz1upyGt0dtjY5xpVK1q7OTqCnJ2RJ7
 l/pf98L4fUvH3PmIAAAA=
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; i=broonie@kernel.org;
 h=from:subject:message-id; bh=V7OXee8raUC8dwb0bE/FHj2NE8mjYScLr3Xy6xI6M8w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGUk7Pbq47HdMAkKf8TTVJkgCz7sN/pPbocs8f
 n4PSEdATuGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRlJOwAKCRAk1otyXVSH
 0JvKB/9gAuu+FkI5060DDDy64WpKt3+zKAM4KyMlW/FpnC18Qk9M1sx7PKpP2xRYpiZpXYrZ2+f
 +X7uFSzbRkPlgrWTppzExOFTxG1M/HaqlX5kJwKwH/kWRvMDcBIiPUms1FlbrkFMVMzb3th+Msh
 O1h/4cGSiEiKvGU2PW5ln/vyeWGSXriB55wQWqse+7aqkWZW5gRgU8mE1qmShLt5a33YIIXQGos
 iy5mE7cuFtYUD4bpDjbmuKos5M6ouGZd/rhe/EorSq5InJfqe+ULMm+JgoLLT5dud3I7OaTHUw9
 m8vilck7pmNRRhjR5ThzArxTsQ64YNToqeOVZIvInLfgi0F4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpu/drm/bridge/lontium-lt9211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index 4d404f5ef87e..c8881796fba4 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -89,7 +89,7 @@ static const struct regmap_config lt9211_regmap_config = {
 	.volatile_table	= &lt9211_rw_table,
 	.ranges = &lt9211_range,
 	.num_ranges = 1,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = 0xda00,
 };
 

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230929-drm-lt9211-maple-f2b0807acd53

Best regards,
-- 
Mark Brown <broonie@kernel.org>

