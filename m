Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C6B78DFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239319AbjH3TXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245271AbjH3PAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:00:43 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F9AC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:00:40 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6c13:6b1b:7366:87c0])
        by albert.telenet-ops.be with bizsmtp
        id fr0c2A0063874jb06r0cMN; Wed, 30 Aug 2023 17:00:38 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qbMgC-0023nG-5c;
        Wed, 30 Aug 2023 17:00:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qbMgO-005Lno-0I;
        Wed, 30 Aug 2023 17:00:36 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>
Cc:     linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mtd: physmap-core: Restore map_rom fallback
Date:   Wed, 30 Aug 2023 17:00:34 +0200
Message-Id: <550e8c8c1da4c4baeb3d71ff79b14a18d4194f9e.1693407371.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the exact mapping type driver was not available, the old
physmap_of_core driver fell back to mapping the region as ROM.
Unfortunately this feature was lost when the DT and pdata cases were
merged.  Revive this useful feature.

Fixes: 642b1e8dbed7bbbf ("mtd: maps: Merge physmap_of.c into physmap-core.c")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mtd/maps/physmap-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index 78710fbc8e7f638c..fc872133928247de 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -551,6 +551,17 @@ static int physmap_flash_probe(struct platform_device *dev)
 		if (info->probe_type) {
 			info->mtds[i] = do_map_probe(info->probe_type,
 						     &info->maps[i]);
+
+			/* Fall back to mapping region as ROM */
+			if (!info->mtds[i] && IS_ENABLED(CONFIG_MTD_ROM) &&
+			    strcmp(info->probe_type, "map_rom")) {
+				dev_warn(&dev->dev,
+					 "map_probe() failed for type %s\n",
+					 info->probe_type);
+
+				info->mtds[i] = do_map_probe("map_rom",
+							     &info->maps[i]);
+			}
 		} else {
 			int j;
 
-- 
2.34.1

