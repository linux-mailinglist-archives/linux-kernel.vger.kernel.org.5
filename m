Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F87DB147
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjJ2Xae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjJ2XaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:30:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99573C18;
        Sun, 29 Oct 2023 15:57:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EB8C433BF;
        Sun, 29 Oct 2023 22:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620275;
        bh=J15CKCpTTnka+7umIa5xlIDLzHuzH1H8dgYsNpX86dE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKyOjE829D3nPkfi4V7+VWVMotirwnwN/FgprSC5dPC5TmlOFz0H4is4uNOvcfMAy
         7izn1RMV9HGQ1DAuwmIE6A9EhAEXP51jMyaZG8gXdSwz21nYoVAwnpb6ZgDTmmPSWr
         awPHVesnJScIk4Q9dvt5PkE6eTZXAXrXiIuJbp2EUWx+vihu5hCV4aq1u1S16b4+GV
         XJoiKfikLoZDjDp5HbCzNe9DRgve+hVhY4smxcV5mnTHdO4HwSeDLdXNuAtaGTErmY
         KV95lV+Kpxyd20cgVuVpBcjCS0B4RC0KDw7gy/CuCHFjpQgNIigmHFdk5vYSRZkm+A
         RFSKLVcwUuCtQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "William A. Kennington III" <william@wkennington.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com,
        openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/39] spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0
Date:   Sun, 29 Oct 2023 18:56:43 -0400
Message-ID: <20231029225740.790936-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225740.790936-1-sashal@kernel.org>
References: <20231029225740.790936-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "William A. Kennington III" <william@wkennington.com>

[ Upstream commit 2ec8b010979036c2fe79a64adb6ecc0bd11e91d1 ]

We don't want to use the value of ilog2(0) as dummy.buswidth is 0 when
dummy.nbytes is 0. Since we have no dummy bytes, we don't need to
configure the dummy byte bits per clock register value anyway.

Signed-off-by: "William A. Kennington III" <william@wkennington.com>
Link: https://lore.kernel.org/r/20230922182812.2728066-1-william@wkennington.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-npcm-fiu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 49f6424e35af0..0624f52880705 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -353,8 +353,9 @@ static int npcm_fiu_uma_read(struct spi_mem *mem,
 		uma_cfg |= ilog2(op->cmd.buswidth);
 		uma_cfg |= ilog2(op->addr.buswidth)
 			<< NPCM_FIU_UMA_CFG_ADBPCK_SHIFT;
-		uma_cfg |= ilog2(op->dummy.buswidth)
-			<< NPCM_FIU_UMA_CFG_DBPCK_SHIFT;
+		if (op->dummy.nbytes)
+			uma_cfg |= ilog2(op->dummy.buswidth)
+				<< NPCM_FIU_UMA_CFG_DBPCK_SHIFT;
 		uma_cfg |= ilog2(op->data.buswidth)
 			<< NPCM_FIU_UMA_CFG_RDBPCK_SHIFT;
 		uma_cfg |= op->dummy.nbytes << NPCM_FIU_UMA_CFG_DBSIZ_SHIFT;
-- 
2.42.0

