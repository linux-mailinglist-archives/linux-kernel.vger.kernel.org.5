Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB67B46BE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjJAKYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjJAKYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:24:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F36E1
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 03:24:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19773C433CA;
        Sun,  1 Oct 2023 10:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696155869;
        bh=yoJaYufx0bDHukVriI2up9rpCoy/yNPOKsU2euT4nUs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HsvrXYa4+n75/j7GM6S3kJy/In/n04B2J7QbMZoijCqpx2VN3oJC0M/g0jIGPp5ne
         qIqLGLaUYo/16/U6iehlFfp+aszTeZF1eaX97SAAAU9ieLPpPx0muJ8okGfI/rGEQH
         gD2PEfp26SQgbLmVTGGTh9vmfRdp1jd7UuK8RreuBvcdo/UV6iDaO5DfRdqyiGZpIP
         pi8UjxtSYLQpkcQ2N9o9/dACMRvDkMRM5MDi76+7Eg/6fEBLqrxxfZEN7vUJQBmPeh
         Kbe5xg2ab9YGkrdVx4aVzV6jWnvcv7FejFjsS9fR2PJPNVeoJMkkzHlwgm6YZGL5PY
         WaIU0F7A6umLw==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 11:24:14 +0100
Subject: [PATCH 2/2] drm/panel: ili9322: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-drm-sn65dsi83-maple-v1-2-5519799a55e5@kernel.org>
References: <20231001-drm-sn65dsi83-maple-v1-0-5519799a55e5@kernel.org>
In-Reply-To: <20231001-drm-sn65dsi83-maple-v1-0-5519799a55e5@kernel.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yoJaYufx0bDHukVriI2up9rpCoy/yNPOKsU2euT4nUs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGUjUbXAPIdcoIRaC7s5THEK47MDpYdRSIEfxh
 0NG/vkXOGCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRlI1AAKCRAk1otyXVSH
 0GZBB/sFh5p2w/DzoAd52ovSQCJ9Yk9dNho4/e/uF9fmrOQuWI1OiHPC18DjG1UYqn68tTH7N28
 NKQqEOahpkorLzercnkkhVj0j4FWnZqcoerfBVGiB2v7gnvW0bV6GLY9lkh35GM0aF5mCLIBQ0F
 Ccjpdu5q7bmkYLBYNAwIkK1dtmUGfbLNXUBY+4MQodxjDZMiIYx6yQbOfCOoxhFQ17tfuMa/FJN
 sCEoVh4MquIQvUporpy4eZ1WSgRbNS5zq+3uFt6Ty/vIbh/bizE4uE/6mdlynRrHUhcAbWhjOQ5
 IqPHS3ilhqu+9+0foiKHkUewvKmN7PFtwhd/ZT6/FaOw33fe
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
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
index 15b81e5228b5..4a6dcfd781e8 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
@@ -337,7 +337,7 @@ static const struct regmap_config ili9322_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0x44,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.writeable_reg = ili9322_writeable_reg,
 };
 

-- 
2.39.2

