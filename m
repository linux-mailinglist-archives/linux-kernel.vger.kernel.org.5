Return-Path: <linux-kernel+bounces-77728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C644860986
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABDBCB246D6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE2F10A2A;
	Fri, 23 Feb 2024 03:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="qqtBWCGK"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A542BDDAA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660110; cv=none; b=HybRhCPcA5Sa7hEmtcY9yOuFhCNII6p6Vh/Np1FcXOVWQRvuMaJR9pbYMjWKInQDc6zaFEOryT4IeWaZyzGwFiMKGd342OlojApTpPClKRhvAza9snR3pc96qKIZmXGuGBk2emRR/BlByPEW/KD4kf0HYJRdsr3ClysPERbkG1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660110; c=relaxed/simple;
	bh=zTYFtRXVflXc15lp67aZg9HB9tF9WCLgh2W0BrCZeUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ezB9E93aFDGabUS7isoD4KBf+j3JN3bB5MgeVSQ3kuBznzrznopy953sgoydz6oGVdDJK6j1cz8ErBzNvGNTaqvsUmYs9ao3aiNQFA2mV3FcVs6gzmRbXiFk/qh/Gl3wNT7r6iFyrnZ0Q6h+ATymo8xf+SHJZU/cCZ21TIDKCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=qqtBWCGK; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 54EC2C0019B2;
	Thu, 22 Feb 2024 19:48:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 54EC2C0019B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1708660102;
	bh=zTYFtRXVflXc15lp67aZg9HB9tF9WCLgh2W0BrCZeUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqtBWCGK0+UEuZoIETnIEjVaEXP1DFFMp61JUNeA0OH2Jiu5TB/YHnVSTdhSOBUIh
	 0N36ajlspw0YROIddO7Y/WDc0kLU4WxXXBxVbxllwrhoyuxg+7xspZG2EidFltxp56
	 cpSbJ8+zLSiWDaTemb1zVpEoiIP/d4B0sz8jQgVw=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id CDA7718041CAC4;
	Thu, 22 Feb 2024 19:48:20 -0800 (PST)
From: William Zhang <william.zhang@broadcom.com>
To: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: f.fainelli@gmail.com,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	William Zhang <william.zhang@broadcom.com>,
	David Regan <dregan@broadcom.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v6 02/13] mtd: rawnand: brcmnand: fix style issues
Date: Thu, 22 Feb 2024 19:47:47 -0800
Message-Id: <20240223034758.13753-3-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240223034758.13753-1-william.zhang@broadcom.com>
References: <20240223034758.13753-1-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various style issues.

Signed-off-by: David Regan <dregan@broadcom.com>
Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v6:
- Added to patch series

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index b8e70fc64348..5f34e5a51d25 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2339,7 +2339,7 @@ static int brcmnand_write_oob_raw(struct nand_chip *chip, int page)
 }
 
 static int brcmnand_exec_instr(struct brcmnand_host *host, int i,
-				const struct nand_operation *op)
+		const struct nand_operation *op)
 {
 	const struct nand_op_instr *instr = &op->instrs[i];
 	struct brcmnand_controller *ctrl = host->ctrl;
@@ -2353,7 +2353,7 @@ static int brcmnand_exec_instr(struct brcmnand_host *host, int i,
 	 * (WAITRDY excepted).
 	 */
 	last_op = ((i == (op->ninstrs - 1)) && (instr->type != NAND_OP_WAITRDY_INSTR)) ||
-		  ((i == (op->ninstrs - 2)) && (op->instrs[i+1].type == NAND_OP_WAITRDY_INSTR));
+		  ((i == (op->ninstrs - 2)) && (op->instrs[i + 1].type == NAND_OP_WAITRDY_INSTR));
 
 	switch (instr->type) {
 	case NAND_OP_CMD_INSTR:
@@ -2398,10 +2398,10 @@ static int brcmnand_exec_instr(struct brcmnand_host *host, int i,
 
 static int brcmnand_op_is_status(const struct nand_operation *op)
 {
-	if ((op->ninstrs == 2) &&
-	    (op->instrs[0].type == NAND_OP_CMD_INSTR) &&
-	    (op->instrs[0].ctx.cmd.opcode == NAND_CMD_STATUS) &&
-	    (op->instrs[1].type == NAND_OP_DATA_IN_INSTR))
+	if (op->ninstrs == 2 &&
+	    op->instrs[0].type == NAND_OP_CMD_INSTR &&
+	    op->instrs[0].ctx.cmd.opcode == NAND_CMD_STATUS &&
+	    op->instrs[1].type == NAND_OP_DATA_IN_INSTR)
 		return 1;
 
 	return 0;
@@ -2409,10 +2409,10 @@ static int brcmnand_op_is_status(const struct nand_operation *op)
 
 static int brcmnand_op_is_reset(const struct nand_operation *op)
 {
-	if ((op->ninstrs == 2) &&
-	    (op->instrs[0].type == NAND_OP_CMD_INSTR) &&
-	    (op->instrs[0].ctx.cmd.opcode == NAND_CMD_RESET) &&
-	    (op->instrs[1].type == NAND_OP_WAITRDY_INSTR))
+	if (op->ninstrs == 2 &&
+	    op->instrs[0].type == NAND_OP_CMD_INSTR &&
+	    op->instrs[0].ctx.cmd.opcode == NAND_CMD_RESET &&
+	    op->instrs[1].type == NAND_OP_WAITRDY_INSTR)
 		return 1;
 
 	return 0;
@@ -2440,8 +2440,7 @@ static int brcmnand_exec_op(struct nand_chip *chip,
 		*status = ret & 0xFF;
 
 		return 0;
-	}
-	else if (brcmnand_op_is_reset(op)) {
+	} else if (brcmnand_op_is_reset(op)) {
 		ret = brcmnand_reset(host);
 		if (ret < 0)
 			return ret;
-- 
2.37.3


