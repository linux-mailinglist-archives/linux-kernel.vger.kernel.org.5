Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6153B7A6160
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjISLfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjISLfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:35:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F9CE3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:34:55 -0700 (PDT)
From:   Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695123293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K2A2PAUnE9j4r0bvfMULyyO54Q1ghBSOYLvBI7DnlD0=;
        b=yxqFG7Z+B++kL3d0+j8S6CBXJsy0Fl3Z3Qp3xVy1gcpHYB2A9czAOt8CMO4AlCCdAKrh2l
        JzXNWQqNYpHNmxHIrVgTzwwJmQY9rFJjRiuR8ZNX1KllzIealcP4re8xyD6va9bZuMy/Zx
        WGK8/pZH9fFWN7m9CAB0zMuNiPwlFG32FxRNQ7QFJe4uqcAKXCQO2rJ1Hq7WW1bPqWfdoy
        l2keHyrd0XwozNNW2LkunnQMeTX1Pkv/zQquGb6VhitkKv40R1plVr/Aut50IoJWVTGb9D
        vZy5SeRQXlY6FRTsarTT+v0c0MGjbe1GgmA2GklAMEWB2FBCTYN4rsP06HOwNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695123293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K2A2PAUnE9j4r0bvfMULyyO54Q1ghBSOYLvBI7DnlD0=;
        b=daifXY8/6UqNcZCv3usko3EDxMPUhJXqWDt7X5SoZ0tZU3zfH3rMkCCRLzX2svl0QMJF/f
        D+uEPfkmWr0szRDQ==
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org
Cc:     linus.walleij@linaro.org, b.spranger@linutronix.de,
        shivamurthy.shastri@linutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: map_ram: prevent use of point and unpoint when NO_XIP is set
Date:   Tue, 19 Sep 2023 13:33:20 +0200
Message-Id: <20230919113320.16953-1-shivamurthy.shastri@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the DT property no-unaligned-direct-access is set, map->phys is set
to NO_XIP. With this property set, the flash should not be exposed
directly to MTD users, since it cannot be mapped.

map_ram() exposes the flash direct access unconditionally which leads to
access errors (when the bus width does not match the RAM width).

Therefore do not set point and unpoint when NO_XIP is set.

Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>
---
 drivers/mtd/chips/map_ram.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/chips/map_ram.c b/drivers/mtd/chips/map_ram.c
index e8dd6496927e..f9d3e32ef8e9 100644
--- a/drivers/mtd/chips/map_ram.c
+++ b/drivers/mtd/chips/map_ram.c
@@ -70,12 +70,16 @@ static struct mtd_info *map_ram_probe(struct map_info *map)
 	mtd->_read = mapram_read;
 	mtd->_write = mapram_write;
 	mtd->_panic_write = mapram_write;
-	mtd->_point = mapram_point;
 	mtd->_sync = mapram_nop;
-	mtd->_unpoint = mapram_unpoint;
 	mtd->flags = MTD_CAP_RAM;
 	mtd->writesize = 1;
 
+	/* Disable direct access when NO_XIP is set */
+	if (map->phys != NO_XIP) {
+		mtd->_point = mapram_point;
+		mtd->_unpoint = mapram_unpoint;
+	}
+
 	mtd->erasesize = PAGE_SIZE;
  	while(mtd->size & (mtd->erasesize - 1))
 		mtd->erasesize >>= 1;
-- 
2.34.1

