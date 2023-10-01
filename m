Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9188F7B46C3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjJAK1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjJAK1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:27:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30983BD
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 03:27:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9403CC433C7;
        Sun,  1 Oct 2023 10:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696156048;
        bh=lwbgWor7IdiVFd94JhzsfGtJZuDZgy8xLTZUxSMiFhA=;
        h=From:Date:Subject:To:Cc:From;
        b=bcFxDfiPyu4xsH1rIrSPDE6xggd7bLNd2YUYUzMr9pN64t0LDr5Exc/TWUSvNhSYn
         9q2yQCP9DJ9fkWRGjsgEnvNsTegfdaSooc/6p7METkcCNu4mDmMFi3Uq7Yk/D5goQh
         Il0riAZ68W3uVHahQBuJAyfmdwDg/Fgr/GBuTM7JKF1RaE+pPc/2yhfAhz4lGRG8U3
         YPHya/QmpBTE0AJxon8b88I/pX8Z1kA5GRKDnEz8htoBissBhi7ViFKZiz1H+wCKNf
         MfyrOtmEdZeGsdldQ2cnXYYOPG+mRDJ6qZy+m76ulRmKIszcrwfcLzUOEw9C/Jar4f
         KX1jmRbIlL1Rw==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 11:26:22 +0100
Subject: [PATCH] drm/bridge: sn65dsi83: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-drm-sn65dsi83-maple-v1-1-cf8ad22b6be0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE1JGWUC/x3MwQpAQBCA4VfRnE2tXWS9ihwwgymWdkpK3t3m+
 B3+/wHlKKzQZg9EvkTlCAlFnsG0DmFhFEoGa6wz3nqkuKOGuiKVxuE+nBvjXFSmtKN3NBGk8ow
 8y/1fu/59P5j5OyVlAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lwbgWor7IdiVFd94JhzsfGtJZuDZgy8xLTZUxSMiFhA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGUmNiGi5FE7RLki0kcrsFODIcqN3ZHI7Apnvx
 ojG20W/R5uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRlJjQAKCRAk1otyXVSH
 0BrAB/0WfEoluBngAWe5KYK1BxB/h/5IVp4Wh/23MhNHLcRxIfZs/NQR8cI/l/2GLcz4L3M8TPC
 sSHmvkch54ZAXDTXQPZKrk60RoJF/iomgvJsXhxHn0XdxTxJ2VlbTTDFsqV1xltRlak0QZHnxrS
 QcYu6hjM1f7hp9jWkcwsh7O1lIAnmT/Q2Oo1IYpTU8TOv0brdnjgjOKgFevQEwRIqUlCWj2gImH
 zkdbKYrduq945ij9ROL/+MMoWVyf1Bpe0YymZ0Zog3FJc4Jv+yoaNRo69RJE9JPkalsSV0r83gs
 dBDhzB1QWWTNGqtkwbv6PkuMTZsd1ITg67ytMKzPxlNyyGfx
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
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 061e8bd5915d..4814b7b6d1fd 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -233,7 +233,7 @@ static const struct regmap_config sn65dsi83_regmap_config = {
 	.rd_table = &sn65dsi83_readable_table,
 	.wr_table = &sn65dsi83_writeable_table,
 	.volatile_table = &sn65dsi83_volatile_table,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = REG_IRQ_STAT,
 };
 

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230929-drm-sn65dsi83-maple-f15042b93dcd

Best regards,
-- 
Mark Brown <broonie@kernel.org>

