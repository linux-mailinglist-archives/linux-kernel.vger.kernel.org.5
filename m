Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE12D7F4AED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344646AbjKVPhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344432AbjKVPhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:37:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9E12121;
        Wed, 22 Nov 2023 07:33:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAD4C433C8;
        Wed, 22 Nov 2023 15:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667233;
        bh=Nd7niRJLK/Dc/ombTHxhGHMDuswzQzOViRz1EU1UyJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5fv3RQE8kIb8VGUU8AedKpKmS2yHwgTN9nK7Y6qp55NSNEFkDxWSLHNmcs4+ro/9
         aoAFFmsTT0S6pi/ClIMeZVO5Vfsoxo6g+lHtscYxmpN39OTgpTSLFRiqQbEBI0ASE7
         pqICs4riOq8wO5lI9pHqe4GXs5p+w9O15MZ4YoEmCs9WmDlGPQVCzFOC+glLz2f6mK
         IFjb0nDxm6+Ek+bv+qgP2Sb1Qp8KcvymcH70TEvogJPNb/5ljYEjEi2w5RBC/NmeDE
         WjLsgX2bnL9/uMZ0XdNdzMIunRSynR3Px+F19TMppBLhCMhT27oXrkqAdybePv0gNS
         /dKYXLPdCIV7w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Bottorff <janb@os.amperecomputing.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        andi.shyti@kernel.org, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 04/15] i2c: designware: Fix corrupted memory seen in the ISR
Date:   Wed, 22 Nov 2023 10:33:06 -0500
Message-ID: <20231122153340.852434-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153340.852434-1-sashal@kernel.org>
References: <20231122153340.852434-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Bottorff <janb@os.amperecomputing.com>

[ Upstream commit f726eaa787e9f9bc858c902d18a09af6bcbfcdaf ]

When running on a many core ARM64 server, errors were
happening in the ISR that looked like corrupted memory. These
corruptions would fix themselves if small delays were inserted
in the ISR. Errors reported by the driver included "i2c_designware
APMC0D0F:00: i2c_dw_xfer_msg: invalid target address" and
"i2c_designware APMC0D0F:00:controller timed out" during
in-band IPMI SSIF stress tests.

The problem was determined to be memory writes in the driver were not
becoming visible to all cores when execution rapidly shifted between
cores, like when a register write immediately triggers an ISR.
Processors with weak memory ordering, like ARM64, make no
guarantees about the order normal memory writes become globally
visible, unless barrier instructions are used to control ordering.

To solve this, regmap accessor functions configured by this driver
were changed to use non-relaxed forms of the low-level register
access functions, which include a barrier on platforms that require
it. This assures memory writes before a controller register access are
visible to all cores. The community concluded defaulting to correct
operation outweighed defaulting to the small performance gains from
using relaxed access functions. Being a low speed device added weight to
this choice of default register access behavior.

Signed-off-by: Jan Bottorff <janb@os.amperecomputing.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-designware-common.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index affcfb243f0f5..35f762872b8a5 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -63,7 +63,7 @@ static int dw_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	*val = readl_relaxed(dev->base + reg);
+	*val = readl(dev->base + reg);
 
 	return 0;
 }
@@ -72,7 +72,7 @@ static int dw_reg_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	writel_relaxed(val, dev->base + reg);
+	writel(val, dev->base + reg);
 
 	return 0;
 }
@@ -81,7 +81,7 @@ static int dw_reg_read_swab(void *context, unsigned int reg, unsigned int *val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	*val = swab32(readl_relaxed(dev->base + reg));
+	*val = swab32(readl(dev->base + reg));
 
 	return 0;
 }
@@ -90,7 +90,7 @@ static int dw_reg_write_swab(void *context, unsigned int reg, unsigned int val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	writel_relaxed(swab32(val), dev->base + reg);
+	writel(swab32(val), dev->base + reg);
 
 	return 0;
 }
@@ -99,8 +99,8 @@ static int dw_reg_read_word(void *context, unsigned int reg, unsigned int *val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	*val = readw_relaxed(dev->base + reg) |
-		(readw_relaxed(dev->base + reg + 2) << 16);
+	*val = readw(dev->base + reg) |
+		(readw(dev->base + reg + 2) << 16);
 
 	return 0;
 }
@@ -109,8 +109,8 @@ static int dw_reg_write_word(void *context, unsigned int reg, unsigned int val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	writew_relaxed(val, dev->base + reg);
-	writew_relaxed(val >> 16, dev->base + reg + 2);
+	writew(val, dev->base + reg);
+	writew(val >> 16, dev->base + reg + 2);
 
 	return 0;
 }
-- 
2.42.0

