Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC1175890D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 01:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjGRXat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 19:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGRXar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:30:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DD4EC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBB5561519
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C230C433C7;
        Tue, 18 Jul 2023 23:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689723045;
        bh=q9GUBT/U895/mZRmm4QeBGzDtN92EtDp9NkceL0+W74=;
        h=From:Date:Subject:To:Cc:From;
        b=qWcFdOs23hRao8/SHNWaBQiebTmzsqCouudyLSypT5lUwCA+P5YaMSDu2HCP9yGKA
         XBOzlxNuBLnacjpIusYSZay7hABDXaCNZDg7T2sbyMl2/EaWkgLm2xAZ8xECYYUcPs
         ioR47n3S50W1DxPvoNg9zcg6zd6OpvHpmNUvGcRdstrbqQQufcIR75Jxwlc13xtJpf
         iF1TnN2dZjRfRxJa+P4hlKDcYxVtnMdibIUW1rqL07eQBI0yLAzFKLTohGRmnB7iN8
         Bqb3OduiiNl7XpupnomNWUUuyrk8TxTucgOtDLW+FblA9gTkbP+aOYTsSuXln/CbZo
         8rviutdZr2Jzw==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 19 Jul 2023 00:30:40 +0100
Subject: [PATCH] regcache: Push async I/O request down into the rbtree
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230719-regcache-async-rbtree-v1-1-b03d30cf1daf@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJ8gt2QC/x3MSwqDQBBF0a1IjVPQH1DJVsRBp3xqTdpQLRIR9
 57G4Rnce1GBKQq9m4sMhxbdcoV/NSRrygtYp2oKLkTX+Z4NiyRZwamcWdg+uwE8iSDE6KLvWqr
 t1zDr7/kO433/Aa9Yt6xnAAAA
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3005; i=broonie@kernel.org;
 h=from:subject:message-id; bh=q9GUBT/U895/mZRmm4QeBGzDtN92EtDp9NkceL0+W74=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktyCjVsce16IUnaWxanMU4iqhQ9VFPsZa1QdWghB4
 c/S1QDyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLcgowAKCRAk1otyXVSH0INCB/
 4lP0rYuM661Z7mFNGrowyB9BlXUiqEug2BvnU8mvicdVMkmYq0Cg/mocvnSis+kXfuglTEK3HrwHSs
 LTO0PyNcdDZE5/CEiBQzxzC93g9QPjcQrXhLAvVYut6zkwji+ElyUQJ5ennsc/D+W7Jd1r02tTGr2e
 G7wSsgATIE53D5RnDulpYHj+nk3BUTBXFPiLTkEOK6wBH+XqPY+X0yy2NWKwY7tX0BHEQ5XOAtnZtN
 Zj8F6u73Nll1ZwgbqP2EHRyriewf6Q51Dzolj/LMfHlW6LC/NZfbZdYaqv/2i4id9Fh6bK4NiOFmWO
 GyITukamBG0zcJ+l/BL8l43GZiGDl6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the regcache core unconditionally enables async I/O for all cache
types, causing problems for the maple tree cache which dynamically allocates
the buffers used to write registers to the device since async requires the
buffers to be kept around until the I/O has been completed.

This use of async I/O is mainly for the rbtree cache which stores data in
a format directly usable for regmap_raw_write(), though there is a special
case for single register writes which would also have allowed it to be used
with the flat cache. It is a bit of a landmine for other caches since it
implicitly converts sync operations to async, and with modern hardware it
is not clear that async I/O is actually a performance win as shown by the
performance work David Jander did with SPI. In multi core systems the cost
of managing concurrency ends up swamping the performance benefit and almost
all modern systems are multi core.

Address this by pushing the enablement of async I/O down into the rbtree
cache where it is actively used, avoiding surprises for other cache
implementations.

Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Fixes: bfa0b38c1483 ("regmap: maple: Implement block sync for the maple tree cache")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache-rbtree.c | 4 ++++
 drivers/base/regmap/regcache.c        | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index fabf87058d80..584bcc55f56e 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -471,6 +471,8 @@ static int regcache_rbtree_sync(struct regmap *map, unsigned int min,
 	unsigned int start, end;
 	int ret;
 
+	map->async = true;
+
 	rbtree_ctx = map->cache;
 	for (node = rb_first(&rbtree_ctx->root); node; node = rb_next(node)) {
 		rbnode = rb_entry(node, struct regcache_rbtree_node, node);
@@ -499,6 +501,8 @@ static int regcache_rbtree_sync(struct regmap *map, unsigned int min,
 			return ret;
 	}
 
+	map->async = false;
+
 	return regmap_async_complete(map);
 }
 
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 28bc3ae9458a..7d3e47436056 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -368,8 +368,6 @@ int regcache_sync(struct regmap *map)
 	if (!map->cache_dirty)
 		goto out;
 
-	map->async = true;
-
 	/* Apply any patch first */
 	map->cache_bypass = true;
 	for (i = 0; i < map->patch_regs; i++) {
@@ -392,7 +390,6 @@ int regcache_sync(struct regmap *map)
 
 out:
 	/* Restore the bypass state */
-	map->async = false;
 	map->cache_bypass = bypass;
 	map->no_sync_defaults = false;
 	map->unlock(map->lock_arg);

---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230718-regcache-async-rbtree-dcce23303176

Best regards,
-- 
Mark Brown <broonie@kernel.org>

