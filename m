Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9B77D1E84
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjJUROE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjJUROD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:14:03 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A4A135
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:13:57 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id uFXtq9F17aUVkuFXtqtgWE; Sat, 21 Oct 2023 19:13:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1697908436;
        bh=pK3MzADyg7f3DHS0ePJyTiMBz9RdsBY2+tKOv52dh6g=;
        h=From:To:Cc:Subject:Date;
        b=gz/EL4aNvcCjwQ5+Uze1yQqxPlVj4WXVbvhNdIbGIBtw/+WMMHNn6imM8F2cjeYbP
         a+JiD10A6i//W4w7ZAixd/Zd89WrW+3qqV71LeCtLV6e77k4+6CmS+feIysr9cd+4V
         KKh3frWd3e7P6EZIGr7POvRZeaqyavFxafNjjnXuFZWn34Uv970dzHWnwC+E+5ba8d
         Ce6idAeg+S+CzMCxAJqJQVqER6Ar2FJcqjJFGnI8pVJ3T5hcQC6sTYCl4z49/T2ZJq
         9jv9F5Q0f7bbqPFGsxYcmXALLhN8+IOkMSvAtw8iGRg1iaTal7hdoDzkflsfwvj3Rf
         GxVnVS2qwRcFg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Oct 2023 19:13:56 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     keescook@chromium.org, Robert Richter <rric@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Borislav Petkov <bp@suse.de>, linux-edac@vger.kernel.org
Subject: [PATCH v2] EDAC/thunderx: Fix some potential buffer overflow in thunderx_ocx_com_threaded_isr()
Date:   Sat, 21 Oct 2023 19:13:51 +0200
Message-Id: <91ec35cd8e2e86fa3d24c2e8ea6970e0437cdfd2.1697908406.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncat() usage in thunderx_ocx_com_threaded_isr() is wrong.
The size given to strncat() is the maximum number of bytes that can be
written, excluding the trailing NULL.

Here, the size of the 'msg' buffer is used (i.e. OCX_MESSAGE_SIZE), not
the space that is remaining.
The space for the ending NULL is also not taken into account.

in order to fix it:
   - call decode_register() before the snprintf() calls
   - use scnprintf() instead of snprintf() and compute, in the 'remaining'
     variable, the space that is still available in the 'msg' buffer
   - add a %s at the end of the format strings and append directly the
     result of decode_register() stored in 'other'
   - write directly at the right position in the 'msg' buffer when
     appending some data in the for loop.

Doing so, all usages of strncat() are removed.

Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is cross-compile tested only.
Review with care.

v2: remove some other erroneous usage of strncat()
---
 drivers/edac/thunderx_edac.c | 44 ++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index b9c5772da959..62e1e120178b 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -1111,6 +1111,7 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
 
 	unsigned long tail;
 	struct ocx_com_err_ctx *ctx;
+	size_t remaining;
 	int lane;
 	char *msg;
 	char *other;
@@ -1127,27 +1128,26 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
 				ARRAY_SIZE(ocx->com_err_ctx));
 		ctx = &ocx->com_err_ctx[tail];
 
-		snprintf(msg, OCX_MESSAGE_SIZE, "%s: OCX_COM_INT: %016llx",
-			ocx->edac_dev->ctl_name, ctx->reg_com_int);
-
 		decode_register(other, OCX_OTHER_SIZE,
 				ocx_com_errors, ctx->reg_com_int);
 
-		strncat(msg, other, OCX_MESSAGE_SIZE);
+		remaining = OCX_MESSAGE_SIZE;
+		remaining -= scnprintf(msg, remaining, "%s: OCX_COM_INT: %016llx%s",
+				       ocx->edac_dev->ctl_name, ctx->reg_com_int,
+				       other);
 
 		for (lane = 0; lane < OCX_RX_LANES; lane++)
 			if (ctx->reg_com_int & BIT(lane)) {
-				snprintf(other, OCX_OTHER_SIZE,
-					 "\n\tOCX_LNE_INT[%02d]: %016llx OCX_LNE_STAT11[%02d]: %016llx",
-					 lane, ctx->reg_lane_int[lane],
-					 lane, ctx->reg_lane_stat11[lane]);
-
-				strncat(msg, other, OCX_MESSAGE_SIZE);
-
 				decode_register(other, OCX_OTHER_SIZE,
 						ocx_lane_errors,
 						ctx->reg_lane_int[lane]);
-				strncat(msg, other, OCX_MESSAGE_SIZE);
+
+				remaining -= scnprintf(msg + (OCX_MESSAGE_SIZE - remaining),
+						       remaining,
+						       "\n\tOCX_LNE_INT[%02d]: %016llx OCX_LNE_STAT11[%02d]: %016llx%s",
+						       lane, ctx->reg_lane_int[lane],
+						       lane, ctx->reg_lane_stat11[lane],
+						       other);
 			}
 
 		if (ctx->reg_com_int & OCX_COM_INT_CE)
@@ -1209,15 +1209,13 @@ static irqreturn_t thunderx_ocx_lnk_threaded_isr(int irq, void *irq_id)
 
 		ctx = &ocx->link_err_ctx[tail];
 
-		snprintf(msg, OCX_MESSAGE_SIZE,
-			 "%s: OCX_COM_LINK_INT[%d]: %016llx",
-			 ocx->edac_dev->ctl_name,
-			 ctx->link, ctx->reg_com_link_int);
-
 		decode_register(other, OCX_OTHER_SIZE,
 				ocx_com_link_errors, ctx->reg_com_link_int);
 
-		strncat(msg, other, OCX_MESSAGE_SIZE);
+		snprintf(msg, OCX_MESSAGE_SIZE,
+			 "%s: OCX_COM_LINK_INT[%d]: %016llx%s",
+			 ocx->edac_dev->ctl_name,
+			 ctx->link, ctx->reg_com_link_int, other);
 
 		if (ctx->reg_com_link_int & OCX_COM_LINK_INT_UE)
 			edac_device_handle_ue(ocx->edac_dev, 0, 0, msg);
@@ -1889,14 +1887,12 @@ static irqreturn_t thunderx_l2c_threaded_isr(int irq, void *irq_id)
 
 	while (CIRC_CNT(l2c->ring_head, l2c->ring_tail,
 			ARRAY_SIZE(l2c->err_ctx))) {
-		snprintf(msg, L2C_MESSAGE_SIZE,
-			 "%s: %s: %016llx, %s: %016llx",
-			 l2c->edac_dev->ctl_name, reg_int_name, ctx->reg_int,
-			 ctx->reg_ext_name, ctx->reg_ext);
-
 		decode_register(other, L2C_OTHER_SIZE, l2_errors, ctx->reg_int);
 
-		strncat(msg, other, L2C_MESSAGE_SIZE);
+		snprintf(msg, L2C_MESSAGE_SIZE,
+			 "%s: %s: %016llx, %s: %016llx%s",
+			 l2c->edac_dev->ctl_name, reg_int_name, ctx->reg_int,
+			 ctx->reg_ext_name, ctx->reg_ext, other);
 
 		if (ctx->reg_int & mask_ue)
 			edac_device_handle_ue(l2c->edac_dev, 0, 0, msg);
-- 
2.34.1

