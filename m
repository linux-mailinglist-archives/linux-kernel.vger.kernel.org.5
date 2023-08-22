Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECC4783ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjHVLba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbjHVLb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:31:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956E5E5D;
        Tue, 22 Aug 2023 04:31:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 256156523F;
        Tue, 22 Aug 2023 11:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19D8C433CD;
        Tue, 22 Aug 2023 11:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692703874;
        bh=O7EU2ygF8bB2iSmUGLVvkbjQuavFC5FaeEnw1j4f5xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xfpvc3AbmHYJNHQrVEd4oV4x3qOXgYqHwLN1gVidMdPEa44CBZ721cCR9/z0/wkrO
         bP4GvN5kSmnk5knnWyQTrKP6wxxMYnvRtkXL6eA6cYP60E0ddJygrSorIqpTwn2ICu
         fMRkc2tVFw46IuKV/pNylxf0vb9VIV6ezwM35pFFXdIjY1H4eb2RpwFcZSgF6D32I9
         nX2QCUzMiwzIy0c2tRueGqru5CRJf26iE32yRCN7tqxoJCMjiVoU4jZbDNZaabNqRB
         OIqDRXNx7eHWq/NafVrphqRocpQ5isUnMN4o44Xc7UXYhwoY28BUWcoM4howX/n7nu
         rJ5Rzk2IrsPzA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lukasz Majewski <lukma@denx.de>, Simon Horman <horms@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, woojung.huh@microchip.com,
        UNGLinuxDriver@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 05/10] net: dsa: microchip: KSZ9477 register regmap alignment to 32 bit boundaries
Date:   Tue, 22 Aug 2023 07:30:55 -0400
Message-Id: <20230822113101.3549915-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113101.3549915-1-sashal@kernel.org>
References: <20230822113101.3549915-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukasz Majewski <lukma@denx.de>

[ Upstream commit 8d7ae22ae9f8c8a4407f8e993df64440bdbd0cee ]

The commit (SHA1: 5c844d57aa7894154e49cf2fc648bfe2f1aefc1c) provided code
to apply "Module 6: Certain PHY registers must be written as pairs instead
of singly" errata for KSZ9477 as this chip for certain PHY registers
(0xN120 to 0xN13F, N=1,2,3,4,5) must be accesses as 32 bit words instead
of 16 or 8 bit access.
Otherwise, adjacent registers (no matter if reserved or not) are
overwritten with 0x0.

Without this patch some registers (e.g. 0x113c or 0x1134) required for 32
bit access are out of valid regmap ranges.

As a result, following error is observed and KSZ9477 is not properly
configured:

ksz-switch spi1.0: can't rmw 32bit reg 0x113c: -EIO
ksz-switch spi1.0: can't rmw 32bit reg 0x1134: -EIO
ksz-switch spi1.0 lan1 (uninitialized): failed to connect to PHY: -EIO
ksz-switch spi1.0 lan1 (uninitialized): error -5 setting up PHY for tree 0, switch 0, port 0

The solution is to modify regmap_reg_range to allow accesses with 4 bytes
boundaries.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz_common.c | 35 +++++++++++---------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index a0ba2605bb620..f87ed14fa2ab2 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -635,10 +635,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x1030, 0x1030),
 	regmap_reg_range(0x1100, 0x1115),
 	regmap_reg_range(0x111a, 0x111f),
-	regmap_reg_range(0x1122, 0x1127),
-	regmap_reg_range(0x112a, 0x112b),
-	regmap_reg_range(0x1136, 0x1139),
-	regmap_reg_range(0x113e, 0x113f),
+	regmap_reg_range(0x1120, 0x112b),
+	regmap_reg_range(0x1134, 0x113b),
+	regmap_reg_range(0x113c, 0x113f),
 	regmap_reg_range(0x1400, 0x1401),
 	regmap_reg_range(0x1403, 0x1403),
 	regmap_reg_range(0x1410, 0x1417),
@@ -669,10 +668,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x2030, 0x2030),
 	regmap_reg_range(0x2100, 0x2115),
 	regmap_reg_range(0x211a, 0x211f),
-	regmap_reg_range(0x2122, 0x2127),
-	regmap_reg_range(0x212a, 0x212b),
-	regmap_reg_range(0x2136, 0x2139),
-	regmap_reg_range(0x213e, 0x213f),
+	regmap_reg_range(0x2120, 0x212b),
+	regmap_reg_range(0x2134, 0x213b),
+	regmap_reg_range(0x213c, 0x213f),
 	regmap_reg_range(0x2400, 0x2401),
 	regmap_reg_range(0x2403, 0x2403),
 	regmap_reg_range(0x2410, 0x2417),
@@ -703,10 +701,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x3030, 0x3030),
 	regmap_reg_range(0x3100, 0x3115),
 	regmap_reg_range(0x311a, 0x311f),
-	regmap_reg_range(0x3122, 0x3127),
-	regmap_reg_range(0x312a, 0x312b),
-	regmap_reg_range(0x3136, 0x3139),
-	regmap_reg_range(0x313e, 0x313f),
+	regmap_reg_range(0x3120, 0x312b),
+	regmap_reg_range(0x3134, 0x313b),
+	regmap_reg_range(0x313c, 0x313f),
 	regmap_reg_range(0x3400, 0x3401),
 	regmap_reg_range(0x3403, 0x3403),
 	regmap_reg_range(0x3410, 0x3417),
@@ -737,10 +734,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x4030, 0x4030),
 	regmap_reg_range(0x4100, 0x4115),
 	regmap_reg_range(0x411a, 0x411f),
-	regmap_reg_range(0x4122, 0x4127),
-	regmap_reg_range(0x412a, 0x412b),
-	regmap_reg_range(0x4136, 0x4139),
-	regmap_reg_range(0x413e, 0x413f),
+	regmap_reg_range(0x4120, 0x412b),
+	regmap_reg_range(0x4134, 0x413b),
+	regmap_reg_range(0x413c, 0x413f),
 	regmap_reg_range(0x4400, 0x4401),
 	regmap_reg_range(0x4403, 0x4403),
 	regmap_reg_range(0x4410, 0x4417),
@@ -771,10 +767,9 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x5030, 0x5030),
 	regmap_reg_range(0x5100, 0x5115),
 	regmap_reg_range(0x511a, 0x511f),
-	regmap_reg_range(0x5122, 0x5127),
-	regmap_reg_range(0x512a, 0x512b),
-	regmap_reg_range(0x5136, 0x5139),
-	regmap_reg_range(0x513e, 0x513f),
+	regmap_reg_range(0x5120, 0x512b),
+	regmap_reg_range(0x5134, 0x513b),
+	regmap_reg_range(0x513c, 0x513f),
 	regmap_reg_range(0x5400, 0x5401),
 	regmap_reg_range(0x5403, 0x5403),
 	regmap_reg_range(0x5410, 0x5417),
-- 
2.40.1

