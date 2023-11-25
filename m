Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED15B7F8782
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 02:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjKYBZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 20:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKYBZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 20:25:01 -0500
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA4219A8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 17:25:08 -0800 (PST)
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D881EC0000E3;
        Fri, 24 Nov 2023 17:25:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D881EC0000E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1700875506;
        bh=t0jIslGuygI39duh2X6/Zyxs22iol4D9s5tcwU8c4G8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kqxgm/DOE5n4ZIsOdwq6yBevk9A8gfsyTHsAKV+lva+I6dXQgomAhvNFYNwLXfsPX
         N2Eq/hsGWcWippIUsARapcI2QN1Kj2Wrt53Jz7n7S4A1Uhqn4+L98qPAAJK5NJD8AD
         UiniffjoUR2x8aNHlFssFyHCPgkGrOFJ5990pJFw=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 90E6118728D;
        Fri, 24 Nov 2023 17:25:06 -0800 (PST)
From:   dregan@broadcom.com
To:     dregan@broadcom.com, miquel.raynal@bootlin.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH v5 2/4] mtd: rawnand: NAND controller write protect
Date:   Fri, 24 Nov 2023 17:24:36 -0800
Message-Id: <20231125012438.15191-2-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231125012438.15191-1-dregan@broadcom.com>
References: <20231125012438.15191-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Regan <dregan@broadcom.com>

Allow NAND controller to be responsible for write protect pin
handling during fast path and exec_op destructive operation
when controller_wp flag is set.

Signed-off-by: David Regan <dregan@broadcom.com>
---
Changes in v5: none

Changes in v4: none

Changes in v3: update comments

Changes in v2: none
---
 drivers/mtd/nand/raw/nand_base.c | 4 ++++
 include/linux/mtd/rawnand.h      | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 47cc2c35153b..38ed0ced5b8e 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -367,6 +367,10 @@ static int nand_check_wp(struct nand_chip *chip)
 	if (chip->options & NAND_BROKEN_XD)
 		return 0;
 
+	/* controller responsible for NAND write protect */
+	if (chip->controller->controller_wp)
+		return 0;
+
 	/* Check the WP bit */
 	ret = nand_status_op(chip, &status);
 	if (ret)
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 31aceda8616c..fcad94aa0515 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1111,6 +1111,7 @@ struct nand_controller_ops {
  *			the bus without restarting an entire read operation nor
  *			changing the column.
  * @supported_op.cont_read: The controller supports sequential cache reads.
+ * @controller_wp:	the controller is in charge of handling the WP pin.
  */
 struct nand_controller {
 	struct mutex lock;
@@ -1119,6 +1120,7 @@ struct nand_controller {
 		unsigned int data_only_read: 1;
 		unsigned int cont_read: 1;
 	} supported_op;
+	bool controller_wp;
 };
 
 static inline void nand_controller_init(struct nand_controller *nfc)
-- 
2.37.3

