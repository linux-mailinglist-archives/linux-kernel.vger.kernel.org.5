Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535E47690F7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjGaJAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjGaJAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACB6B7;
        Mon, 31 Jul 2023 02:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E75660F94;
        Mon, 31 Jul 2023 09:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF5FC433C7;
        Mon, 31 Jul 2023 09:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690794006;
        bh=Ae5cwFiKpnoFn/0C354AUzKQGPHUNIO2/eAg222GTVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVLeMKnhpi6dglyr2Mpxhzj7fUyZI9TqiLI4iOVRhFvIjgUyOXpfVSapas+oXGyfG
         CPOiU2NxqAUZE03BtRmYMkk5yS2QSDDTp9PmzYs/6I1+/7glkbW0GBaE+Lm6K58tRq
         ommegD8nFdBbUEnHU0WxX6dTS+q4btrFydwmn0gRkCfBAK8qy5M7TNVYbfrXJWcmqf
         NMFUq1DXu/WBq86PBbwJVEpn5cn7t893EEcFMpKZXAxXM9cFaRo5tY74P9zLkh4zeP
         YY4CgYbzo3RqvRJCxkpma/p4JF6WqnoPc86nRNvEuD9J8uaYHdi7VHFOwc0jBQbEuk
         gxq2pJdd1LJWA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 1/7] tty: synclink_gt: convert CALC_REGADDR() macro to an inline
Date:   Mon, 31 Jul 2023 10:59:56 +0200
Message-ID: <20230731090002.15680-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731090002.15680-1-jirislaby@kernel.org>
References: <20230731090002.15680-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes the code more readable and less error-prone as the result is
returned and not stored in a variable newly defined inside the macro.

Note that cast to 'unsigned long' and back to 'void *' was eliminated as
info->reg_addr is 'char *' already (so the addition is per bytes
already).

This nicely cleans up the callers too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/synclink_gt.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 16e469e581ec..00efed2c139e 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -3734,47 +3734,47 @@ module_exit(slgt_exit);
  * register access routines
  */
 
-#define CALC_REGADDR() \
-	unsigned long reg_addr = ((unsigned long)info->reg_addr) + addr; \
-	if (addr >= 0x80) \
-		reg_addr += (info->port_num) * 32; \
-	else if (addr >= 0x40)	\
-		reg_addr += (info->port_num) * 16;
+static inline void __iomem *calc_regaddr(struct slgt_info *info,
+					 unsigned int addr)
+{
+	void __iomem *reg_addr = info->reg_addr + addr;
+
+	if (addr >= 0x80)
+		reg_addr += info->port_num * 32;
+	else if (addr >= 0x40)
+		reg_addr += info->port_num * 16;
+
+	return reg_addr;
+}
 
 static __u8 rd_reg8(struct slgt_info *info, unsigned int addr)
 {
-	CALC_REGADDR();
-	return readb((void __iomem *)reg_addr);
+	return readb(calc_regaddr(info, addr));
 }
 
 static void wr_reg8(struct slgt_info *info, unsigned int addr, __u8 value)
 {
-	CALC_REGADDR();
-	writeb(value, (void __iomem *)reg_addr);
+	writeb(value, calc_regaddr(info, addr));
 }
 
 static __u16 rd_reg16(struct slgt_info *info, unsigned int addr)
 {
-	CALC_REGADDR();
-	return readw((void __iomem *)reg_addr);
+	return readw(calc_regaddr(info, addr));
 }
 
 static void wr_reg16(struct slgt_info *info, unsigned int addr, __u16 value)
 {
-	CALC_REGADDR();
-	writew(value, (void __iomem *)reg_addr);
+	writew(value, calc_regaddr(info, addr));
 }
 
 static __u32 rd_reg32(struct slgt_info *info, unsigned int addr)
 {
-	CALC_REGADDR();
-	return readl((void __iomem *)reg_addr);
+	return readl(calc_regaddr(info, addr));
 }
 
 static void wr_reg32(struct slgt_info *info, unsigned int addr, __u32 value)
 {
-	CALC_REGADDR();
-	writel(value, (void __iomem *)reg_addr);
+	writel(value, calc_regaddr(info, addr));
 }
 
 static void rdma_reset(struct slgt_info *info)
-- 
2.41.0

