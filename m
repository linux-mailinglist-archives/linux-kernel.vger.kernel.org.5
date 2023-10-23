Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2681A7D3D30
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjJWRPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjJWRO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:14:56 -0400
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E67EE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:14:53 -0700 (PDT)
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 331A8C004ECC;
        Mon, 23 Oct 2023 10:14:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 331A8C004ECC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1698081293;
        bh=a3Dt7syR5zhVX9KM9JkJeWq0PAXWyXzBW8y0XTgiNwU=;
        h=From:To:Subject:Date:From;
        b=DPVYds28HnXXIauHOisI/aEi8mllIbZTggVLW3bpsf3ReN6fF7twHLK+Is+jhgyrB
         n7mc65MfS1MinLEjZ3vHe9T29KM5ru70EXq+1c27gZYZcccW1R55VFMHL8+234GbSv
         jd+r3bhvzvUIIcnIkqs9WH41jajCiakGJ+0bR/Y8=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 2E2B018728D;
        Mon, 23 Oct 2023 10:14:53 -0700 (PDT)
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
Subject: [PATCH v4 1/4] mtd: rawnand: Add destructive operation
Date:   Mon, 23 Oct 2023 10:14:41 -0700
Message-Id: <20231023171444.322311-1-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
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

From: Boris Brezillon <bbrezillon@kernel.org>

Erase and program operations need the write protect (wp) pin to be
de-asserted to take effect. Add the concept of destructive
operation and pass the information to exec_op() so controllers know
when they should de-assert this pin without having to decode
the command opcode.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: David Regan <dregan@broadcom.com>
---
Changes in v4: none

Changes in v3: updated comments and email address

Changes in v2: gave credit to Boris Brezillon
---
 drivers/mtd/nand/raw/nand_base.c | 6 ++++--
 include/linux/mtd/rawnand.h      | 9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d4b55155aeae..47cc2c35153b 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1494,7 +1494,8 @@ static int nand_exec_prog_page_op(struct nand_chip *chip, unsigned int page,
 			    NAND_COMMON_TIMING_NS(conf, tWB_max)),
 		NAND_OP_WAIT_RDY(NAND_COMMON_TIMING_MS(conf, tPROG_max), 0),
 	};
-	struct nand_operation op = NAND_OPERATION(chip->cur_cs, instrs);
+	struct nand_operation op = NAND_DESTRUCTIVE_OPERATION(chip->cur_cs,
+							      instrs);
 	int naddrs = nand_fill_column_cycles(chip, addrs, offset_in_page);
 
 	if (naddrs < 0)
@@ -1917,7 +1918,8 @@ int nand_erase_op(struct nand_chip *chip, unsigned int eraseblock)
 			NAND_OP_WAIT_RDY(NAND_COMMON_TIMING_MS(conf, tBERS_max),
 					 0),
 		};
-		struct nand_operation op = NAND_OPERATION(chip->cur_cs, instrs);
+		struct nand_operation op = NAND_DESTRUCTIVE_OPERATION(chip->cur_cs,
+								      instrs);
 
 		if (chip->options & NAND_ROW_ADDR_3)
 			instrs[1].ctx.addr.naddrs++;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 90a141ba2a5a..31aceda8616c 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1008,6 +1008,7 @@ struct nand_op_parser {
  */
 struct nand_operation {
 	unsigned int cs;
+	bool deassert_wp;
 	const struct nand_op_instr *instrs;
 	unsigned int ninstrs;
 };
@@ -1019,6 +1020,14 @@ struct nand_operation {
 		.ninstrs = ARRAY_SIZE(_instrs),			\
 	}
 
+#define NAND_DESTRUCTIVE_OPERATION(_cs, _instrs)		\
+	{							\
+		.cs = _cs,					\
+		.deassert_wp = true,				\
+		.instrs = _instrs,				\
+		.ninstrs = ARRAY_SIZE(_instrs),			\
+	}
+
 int nand_op_parser_exec_op(struct nand_chip *chip,
 			   const struct nand_op_parser *parser,
 			   const struct nand_operation *op, bool check_only);
-- 
2.37.3

