Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B847CCDD8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJQUZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQUZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:25:06 -0400
X-Greylist: delayed 638 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 13:25:04 PDT
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C711092
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:25:04 -0700 (PDT)
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 0BD47C0000EC;
        Tue, 17 Oct 2023 13:14:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 0BD47C0000EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1697573667;
        bh=oW0lQ3mYZRJIZP8XWJKIYdybmuCVAGqC6zfftB7GtOY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bLOui97vVPIIAoyBiNvaNPSDGKX4vJPCpU6gKWtKhyke5YskrVqDIHOch+H92sqWw
         1yFn8P/zuTiA8Yvnl/JNCY/UxZx+Qowgecy+EGNeyA0GurDlL91iySkiS9cD1Dop8V
         kkNxGalHPTrHw7sZUJyNUkCL2HVHJpUig5f0ozgk=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id BB8AE18728C;
        Tue, 17 Oct 2023 13:14:26 -0700 (PDT)
From:   dregan@broadcom.com
To:     dregan@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH v3 2/4] mtd: rawnand: NAND controller write protect
Date:   Tue, 17 Oct 2023 13:14:15 -0700
Message-Id: <20231017201417.129872-2-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231017201417.129872-1-dregan@broadcom.com>
References: <20231017201417.129872-1-dregan@broadcom.com>
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

Allow NAND controller to be responsible for write protect pin
handling during fast path and exec_op destructive operation
when controller_wp flag is set.

Signed-off-by: David Regan <dregan@broadcom.com>
---
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

