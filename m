Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B08785499
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjHWJun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjHWJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:49:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23E810B;
        Wed, 23 Aug 2023 02:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B73062A5D;
        Wed, 23 Aug 2023 09:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81AC4C433CB;
        Wed, 23 Aug 2023 09:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692784058;
        bh=BgJoy5WrNNunfZnzqn99cjCrMrRRSaZhBdRfquCyX+U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=hbOwMTX30a6QoY4/iBxfF/gRUOFRxyy3ybKtYSzn9U2JsVO+o3De8I/TQ+ElEoBXU
         lbp148Kb9bFkQ9KlnLFfZqQvBuYAI04LAnwRnslTA9RMOQzVEcMjwEhsvzvoclXeZQ
         CPSmSRZOk5v9sW1h4ZTlqQVVZJiWNyYXbtvlSWiDMOZOh7suIORflgdIQAnZ9gm01p
         fITuV1gi2SzipF9d6AZqLIZ0NEtTVuMtEb5bUen2ql2Zdsb1K1A2HtmvKIOZlc4NsP
         Tjk+4EOZ5tzIkNnC+0x34EJmkmRtsuMiYr+KhpXivW9x2XhmFWgV3x9Wc7d9SQeEMG
         PIj1t95/5NoQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 5709CEE49B5;
        Wed, 23 Aug 2023 09:47:38 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Wed, 23 Aug 2023 12:47:28 +0300
Subject: [PATCH 2/2] ata: pata_ep93xx: use soc_device_match for UDMA modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-ep93xx_pata_fixes-v1-2-d7e7229be148@maquefel.me>
References: <20230823-ep93xx_pata_fixes-v1-0-d7e7229be148@maquefel.me>
In-Reply-To: <20230823-ep93xx_pata_fixes-v1-0-d7e7229be148@maquefel.me>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692784059; l=1745;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=S/mHeNOqmdky76OBBe9mnLniUEhK/mD6hu3snL8cYnQ=; =?utf-8?q?b=3DZh3hEy1066mg?=
 =?utf-8?q?5eGLVabyipHBoWgKlB/mlIUlnn3UXSC5kJzVHxfeCrDPtloT6CVJEy6typOP/Xr/?=
 dVZGid7DB4vtZGfpF9FlFskH0r6PPnwSJwFO0y+J3BDXN2HhVqMM
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Replace ep93xx_chip_revision() with soc_device_match(), so
ep93xx_chip_revision() can be safetly dropped from exported functions.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/ata/pata_ep93xx.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index 4ce0f37c7a89..3f91b6cff353 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -40,6 +40,7 @@
 #include <linux/ata.h>
 #include <linux/libata.h>
 #include <linux/platform_device.h>
+#include <linux/sys_soc.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/ktime.h>
@@ -910,6 +911,12 @@ static struct ata_port_operations ep93xx_pata_port_ops = {
 	.port_start		= ep93xx_pata_port_start,
 };
 
+static const struct soc_device_attribute ep93xx_soc_table[] = {
+	{ .revision = "E1", .data = (void *)ATA_UDMA3 },
+	{ .revision = "E2", .data = (void *)ATA_UDMA4 },
+	{ /* sentinel */ }
+};
+
 static int ep93xx_pata_probe(struct platform_device *pdev)
 {
 	struct ep93xx_pata_data *drv_data;
@@ -976,12 +983,11 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 	 * so this driver supports only UDMA modes.
 	 */
 	if (drv_data->dma_rx_channel && drv_data->dma_tx_channel) {
-		int chip_rev = ep93xx_chip_revision();
+		const struct soc_device_attribute *match;
 
-		if (chip_rev == EP93XX_CHIP_REV_E1)
-			ap->udma_mask = ATA_UDMA3;
-		else if (chip_rev == EP93XX_CHIP_REV_E2)
-			ap->udma_mask = ATA_UDMA4;
+		match = soc_device_match(ep93xx_soc_table);
+		if (match)
+			ap->udma_mask = (unsigned int) match->data;
 		else
 			ap->udma_mask = ATA_UDMA2;
 	}

-- 
2.39.2

