Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EB17F534C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344649AbjKVWUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjKVWUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:20:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBAD1B5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:20:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B4DC433C7;
        Wed, 22 Nov 2023 22:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700691615;
        bh=u13b0z+tp/dZxRqpZv9t59kmK5DC5BMUsS/pUkeI2qs=;
        h=From:To:Cc:Subject:Date:From;
        b=ooPGsOvLIdQyfEAMzxU5AUDDT2dgbuOSg46vaCSzFAnxa36wUIPVF3WtkoXNnAeaN
         YdoU6LZdkYxhfbvjtcuLhNyWwoXytZde9SwDNdY1Tl4jmbeB43qZphfgSByJsUxg6F
         P42dILUa3xainFiGGpmMZiLsPLcEDJtYXJ/ilM2uH10l75uTYay6fTgHXEInAIBAG4
         xl/J2Gkfb9/Y4GskeTffJXv++AReoFw1IqyLIHEbuV3K3MIzH0TePiOljvcS0wZRrY
         uZ5v8zD7ziuBZelAzr6Xo3tqZ+1c5uFG/k5FHGSkkUSoF0lVfVgTQYw4reqGMKmeoV
         vdRr0+LrX7NVA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Richter <rric@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yeqi Fu <asuk4.q@gmail.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC, thunderx: fix possible out-of-bounds string access.
Date:   Wed, 22 Nov 2023 23:19:53 +0100
Message-Id: <20231122222007.3199885-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Commit 1b56c90018f0 ("Makefile: Enable -Wstringop-overflow globally") exposes a
warning for a common bug in the usage of strncat():

drivers/edac/thunderx_edac.c: In function 'thunderx_ocx_com_threaded_isr':
drivers/edac/thunderx_edac.c:1136:17: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
 1136 |                 strncat(msg, other, OCX_MESSAGE_SIZE);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/edac/thunderx_edac.c:1145:33: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
 1145 |                                 strncat(msg, other, OCX_MESSAGE_SIZE);
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/edac/thunderx_edac.c:1150:33: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
 1150 |                                 strncat(msg, other, OCX_MESSAGE_SIZE);
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/edac/thunderx_edac.c: In function 'thunderx_l2c_threaded_isr':
drivers/edac/thunderx_edac.c:1899:17: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
 1899 |                 strncat(msg, other, L2C_MESSAGE_SIZE);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/edac/thunderx_edac.c: In function 'thunderx_ocx_lnk_threaded_isr':
drivers/edac/thunderx_edac.c:1220:17: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
 1220 |                 strncat(msg, other, OCX_MESSAGE_SIZE);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Apparently the author of this driver expected strncat() to behave the
way that strlcat() does, which uses the size of the destination buffer
as its third argument rather than the length of the source buffer.
The result is that there is no check on the size of the allocated
buffer.

Change it to use strncat().

Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/edac/thunderx_edac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index b9c5772da959..90d46e5c4ff0 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -1133,7 +1133,7 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
 		decode_register(other, OCX_OTHER_SIZE,
 				ocx_com_errors, ctx->reg_com_int);
 
-		strncat(msg, other, OCX_MESSAGE_SIZE);
+		strlcat(msg, other, OCX_MESSAGE_SIZE);
 
 		for (lane = 0; lane < OCX_RX_LANES; lane++)
 			if (ctx->reg_com_int & BIT(lane)) {
@@ -1142,12 +1142,12 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
 					 lane, ctx->reg_lane_int[lane],
 					 lane, ctx->reg_lane_stat11[lane]);
 
-				strncat(msg, other, OCX_MESSAGE_SIZE);
+				strlcat(msg, other, OCX_MESSAGE_SIZE);
 
 				decode_register(other, OCX_OTHER_SIZE,
 						ocx_lane_errors,
 						ctx->reg_lane_int[lane]);
-				strncat(msg, other, OCX_MESSAGE_SIZE);
+				strlcat(msg, other, OCX_MESSAGE_SIZE);
 			}
 
 		if (ctx->reg_com_int & OCX_COM_INT_CE)
@@ -1217,7 +1217,7 @@ static irqreturn_t thunderx_ocx_lnk_threaded_isr(int irq, void *irq_id)
 		decode_register(other, OCX_OTHER_SIZE,
 				ocx_com_link_errors, ctx->reg_com_link_int);
 
-		strncat(msg, other, OCX_MESSAGE_SIZE);
+		strlcat(msg, other, OCX_MESSAGE_SIZE);
 
 		if (ctx->reg_com_link_int & OCX_COM_LINK_INT_UE)
 			edac_device_handle_ue(ocx->edac_dev, 0, 0, msg);
@@ -1896,7 +1896,7 @@ static irqreturn_t thunderx_l2c_threaded_isr(int irq, void *irq_id)
 
 		decode_register(other, L2C_OTHER_SIZE, l2_errors, ctx->reg_int);
 
-		strncat(msg, other, L2C_MESSAGE_SIZE);
+		strlcat(msg, other, L2C_MESSAGE_SIZE);
 
 		if (ctx->reg_int & mask_ue)
 			edac_device_handle_ue(l2c->edac_dev, 0, 0, msg);
-- 
2.39.2

