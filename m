Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BE97D3D32
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjJWRPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjJWRPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:15:07 -0400
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA8AD7F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:15:03 -0700 (PDT)
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 39FC8C007598;
        Mon, 23 Oct 2023 10:15:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 39FC8C007598
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1698081303;
        bh=GqmnpEMfWio14hWw5HE21rvGs1KEhArEROd+g4C5LJQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fPWjOQnXMgc7FnhgtU6PcVX6xnuWAr2bRDbqpCrJn2llOiuXduQ/BrXixEd+xRZzG
         PO6qaDYSVoBGiJiSaCXf0GdgV6s6Hn7wa9Cp+K9tdAhUZQlDY2i5ramaIp+PDc2D3k
         TvoexMkZsijjs4/aEVO3LOmORqdOMcy13NqrAYJY=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 2DA8B18728D;
        Mon, 23 Oct 2023 10:15:03 -0700 (PDT)
From:   dregan@broadcom.com
To:     dregan@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH v4 3/4] mtd: rawnand: brcmnand: pass host struct to bcmnand_ctrl_poll_status
Date:   Mon, 23 Oct 2023 10:14:43 -0700
Message-Id: <20231023171444.322311-3-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231023171444.322311-1-dregan@broadcom.com>
References: <20231023171444.322311-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Regan <dregan@broadcom.com>

Pass host struct to bcmnand_ctrl_poll_status instead of ctrl struct
since real time status requires host, and ctrl is a member of host.
Real time status is required for low level commands vs cached status
since the NAND controller will not do an automatic status read at the
end of a low level command as it would with a high level command.

Signed-off-by: David Regan <dregan@broadcom.com>
---
Changes in v4: none

Changes in v3: none

Changes in v2: added this patch in series
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 440bef477930..8d429eb3b72a 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1061,10 +1061,11 @@ enum {
 	CS_SELECT_AUTO_DEVICE_ID_CFG		= BIT(30),
 };
 
-static int bcmnand_ctrl_poll_status(struct brcmnand_controller *ctrl,
+static int bcmnand_ctrl_poll_status(struct brcmnand_host *host,
 				    u32 mask, u32 expected_val,
 				    unsigned long timeout_ms)
 {
+	struct brcmnand_controller *ctrl = host->ctrl;
 	unsigned long limit;
 	u32 val;
 
@@ -1379,7 +1380,7 @@ static void brcmnand_wp(struct mtd_info *mtd, int wp)
 		 * make sure ctrl/flash ready before and after
 		 * changing state of #WP pin
 		 */
-		ret = bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY |
+		ret = bcmnand_ctrl_poll_status(host, NAND_CTRL_RDY |
 					       NAND_STATUS_READY,
 					       NAND_CTRL_RDY |
 					       NAND_STATUS_READY, 0);
@@ -1389,7 +1390,7 @@ static void brcmnand_wp(struct mtd_info *mtd, int wp)
 		brcmnand_set_wp(ctrl, wp);
 		nand_status_op(chip, NULL);
 		/* NAND_STATUS_WP 0x00 = protected, 0x80 = not protected */
-		ret = bcmnand_ctrl_poll_status(ctrl,
+		ret = bcmnand_ctrl_poll_status(host,
 					       NAND_CTRL_RDY |
 					       NAND_STATUS_READY |
 					       NAND_STATUS_WP,
@@ -1629,13 +1630,13 @@ static void brcmnand_send_cmd(struct brcmnand_host *host, int cmd)
 	 */
 	if (oops_in_progress) {
 		if (ctrl->cmd_pending &&
-			bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY, NAND_CTRL_RDY, 0))
+			bcmnand_ctrl_poll_status(host, NAND_CTRL_RDY, NAND_CTRL_RDY, 0))
 			return;
 	} else
 		BUG_ON(ctrl->cmd_pending != 0);
 	ctrl->cmd_pending = cmd;
 
-	ret = bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY, NAND_CTRL_RDY, 0);
+	ret = bcmnand_ctrl_poll_status(host, NAND_CTRL_RDY, NAND_CTRL_RDY, 0);
 	WARN_ON(ret);
 
 	mb(); /* flush previous writes */
@@ -1664,7 +1665,7 @@ static bool brcmstb_nand_wait_for_completion(struct nand_chip *chip)
 	if (mtd->oops_panic_write || ctrl->irq < 0) {
 		/* switch to interrupt polling and PIO mode */
 		disable_ctrl_irqs(ctrl);
-		sts = bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY,
+		sts = bcmnand_ctrl_poll_status(host, NAND_CTRL_RDY,
 					       NAND_CTRL_RDY, 0);
 		err = sts < 0;
 	} else {
-- 
2.37.3

