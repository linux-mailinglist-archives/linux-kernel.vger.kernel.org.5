Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35887DB14A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjJ2X3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjJ2X3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:29:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7613244BF;
        Sun, 29 Oct 2023 15:59:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D5CC4160E;
        Sun, 29 Oct 2023 22:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620371;
        bh=sBDIHq+0hLK1ueiIEOPxcxCoKOrigSC15i7yeQqHbo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZPl7Gbc5RFgtYjKYK7t8ZRH/HqqSLpYnOsm2qtmeHmgku4FNK/OPpj5x5NKRGKD8
         3t6eAlASpvbo7ZmAFYf89JNL7m9d779kYk49sRb9mEVFLUf9FTb6gq2J+bpsrRmP8Q
         LSl/v/3EppO8PhHYwuDUkDPV3xZ0SnJ1mMgyyiWXe98GDUdHmx86WtovwVUxaVNRi0
         YEy3rPjgjx1DRu6zOrWTszjzcOr2TfpeG1VZjTmo6E+LuJ5MCG/PBYGea6ESVW6BIk
         f+2iYSkKlsb6SD/oG2z27V+ciQmJQ7VYUnXjd4h+uqyKNm3EOms+q0e43RU87Gxc8E
         d/YbRQ4sF1Ijw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "William A. Kennington III" <william@wkennington.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com,
        openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 11/28] spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0
Date:   Sun, 29 Oct 2023 18:58:46 -0400
Message-ID: <20231029225916.791798-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225916.791798-1-sashal@kernel.org>
References: <20231029225916.791798-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index b62471ab6d7f2..1edaf22e265bf 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -334,8 +334,9 @@ static int npcm_fiu_uma_read(struct spi_mem *mem,
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

