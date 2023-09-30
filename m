Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E377B44B1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjI3Xqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjI3Xqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:46:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5C9BC
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 16:46:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A23AC433C7;
        Sat, 30 Sep 2023 23:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696117606;
        bh=naZ2q9TcpVDyU3g9xJ/aULduq+CmltpgmFKv1yCFGIA=;
        h=From:Date:Subject:To:Cc:From;
        b=M9nY6SJPod7ayz+ilGfFa9BB19YMuXkkWULGO+TciDGh+GWDjJ6we+IUEm5lgC04g
         3R07vQOUlU/eJJg+1r99b2+EgVTg2C37ogmYC0HG7xPyFv1hJKJNTlAwcWEJSKuY88
         D1cMN6BMDg2f3Irm+IWZwMy3gOJ/ZkkhnB9z3DTmyUAIA6mlzfoDADFazU7v0UcST8
         AzLnyyhzgD43trSztxB6mXYtUrADyYakEQs1o8wGrVNK0D/73aiu66pF9+qrYW2pK9
         s3EljUvpXkk4nWsWu8mjYCtid2HWgbJtQVagd2yX7DbDtPab+bwE+CXJMHMheZGI1R
         Wbto1i/G9uaQg==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 00:46:38 +0100
Subject: [PATCH] drm/bridge: icn6211: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-drm-chipone-maple-v1-1-fb3ce5a53710@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF2zGGUC/x3MQQqAIBBG4avErBswI8KuEi1C/2ogTRQiCO+et
 PwW772UkQSZpualhFuyXKGiaxuyxxp2sLhq0kr3ymjDLnm2h8QrgP0aT3DnBvSjxQCnqHYxYZP
 nf85LKR+itdMTYwAAAA==
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=broonie@kernel.org;
 h=from:subject:message-id; bh=naZ2q9TcpVDyU3g9xJ/aULduq+CmltpgmFKv1yCFGIA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGLNhPqwqkDtYR95iPk4vE1lkhB3buvF4hr3LL
 mykF+mqFWeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRizYQAKCRAk1otyXVSH
 0KXlB/4+LDDBxjl7siW2vK2X1yQROcJJNkgcMovVFapGMcBiPGM7NYlVIVvEbFo+DJbISxPtRuI
 D6AI2GFqdj3fKCsfPTbK0S14iwLaVmk7xDfyTUvv/7RNH7rVWtGPhQrOOozw+Jpd4VjqUnuO6dQ
 MFGn8Au72bFQKWGf/I3821GCxBvBJ+m/SK98sFsO3jhtQvNc8E1fsRBoUEFeWsOJzilf5t3Kjwg
 9/iD+FjsrPfSYyBYQEzMQokKMuf7HmSF6eQw0Mvu0c3JaU9J2y/Vlujz7BrTWpgwoxWkACFu/An
 z+yjCGTtahfvwN5J1eWw6cLL9YJ4noCEAFnlfjp8IIUrS7JR
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
 drivers/gpu/drm/bridge/chipone-icn6211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index d205e755e524..82d23e4df09e 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -197,7 +197,7 @@ static const struct regmap_config chipone_regmap_config = {
 	.val_bits = 8,
 	.rd_table = &chipone_dsi_readable_table,
 	.wr_table = &chipone_dsi_writeable_table,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = MIPI_ATE_STATUS(1),
 };
 

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230929-drm-chipone-maple-1d5e37ce5ed0

Best regards,
-- 
Mark Brown <broonie@kernel.org>

