Return-Path: <linux-kernel+bounces-114286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C71888993
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC731C28166
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1490125ED74;
	Sun, 24 Mar 2024 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRvMl9PK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812820DD4B;
	Sun, 24 Mar 2024 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321656; cv=none; b=X0WSO5UzoMu3IYoKr486G+rYE9oP4bo6qwhqMEV5ACOKBkPT25HI+RzckcFgYZ439o2GSOLrC/oiLjCxTSdmTKrGkEcdQIXuxZHVjNEa3ghZLnUzIC4Ofl2aqyXJ2mYMXyHMrWEiHaBBCDZXDmZBvQlI6lK9c2GC6Uo+SxOS5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321656; c=relaxed/simple;
	bh=YZPj3TCyeuHzFbALh1S/QKMJWCXWAsaZ839msyp0NqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTHWGhYjcSpjoyhqgEOWn6NHFV3qnJ/VjNBA3Zu9sWCgc4Ee7dJadanQ1NHIS6U78LRmAQ/0dBAC6GE7i1d7xEd19Bk0bb1AeHEnFww/0EFUjs5jlq1PvzPo9ZNKRVPLu+kaSVfXR8/jQSPj/qg1ArU/jQdDvBt4pr9bibywtQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRvMl9PK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D121C43399;
	Sun, 24 Mar 2024 23:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321655;
	bh=YZPj3TCyeuHzFbALh1S/QKMJWCXWAsaZ839msyp0NqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRvMl9PKgal/1AVMR5RAm8azdWf8O4LAl2ciwmlCtoCXDGYZ8zwo9fs/neFrD4Dk7
	 rNp5bVCxMAMt6vQcLewpj7fEDKYLPOH2adoi2FZjQVdFN0wzPwO6NMgrAuOB3rt9nv
	 YrIzTndzk7pWj7LdqrOSKuNqbWKjxGawSTUJEDQUuAPHk8QOUvgR1qIaJsdql7viJN
	 dQtXJg+fONK8F+3JcysB+U6Wv+HfsmcpasIpOcGZlWviYBmDm3bjoXNCU/z9XRUaK4
	 67gWYD2eGyEucelT2saD1pWLNPRU3jpVgvZJtZbh107DLJ9hzWiax65SoGvKE2W2FV
	 eK7+0v0nxJ1lQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ezra Buehler <ezra.buehler@husqvarnagroup.com>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 384/638] mtd: spinand: esmt: Extend IDs to 5 bytes
Date: Sun, 24 Mar 2024 18:57:01 -0400
Message-ID: <20240324230116.1348576-385-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

[ Upstream commit 4bd14b2fd8a83a2f5220ba4ef323f741e11bfdfd ]

According to the datasheets, the ESMT chips in question will return a 5
byte long identification code where the last 3 bytes are the JEDEC
continuation codes (7Fh). Although, I would have expected 4 continuation
codes as Powerchip Semiconductor (C8h, corresponding to the parameter
page data) is located in bank 5 of the JEDEC database.

By matching the full 5 bytes we can avoid clashes with GigaDevice NAND
flashes.

This fix allows the MT7688-based GARDENA smart Gateway to boot again.

Fixes: aa08bf187f32 ("mtd: spinand: esmt: add support for F50D2G41KA")
Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Reviewed-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
Tested-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240125200108.24374-3-ezra@easyb.ch
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/esmt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 31c439a557b18..4597a82de23a4 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -104,7 +104,8 @@ static const struct mtd_ooblayout_ops f50l1g41lb_ooblayout = {
 
 static const struct spinand_info esmt_c8_spinand_table[] = {
 	SPINAND_INFO("F50L1G41LB",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01, 0x7f,
+				0x7f, 0x7f),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -113,7 +114,8 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
 	SPINAND_INFO("F50D1G41LB",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11, 0x7f,
+				0x7f, 0x7f),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -122,7 +124,8 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
 	SPINAND_INFO("F50D2G41KA",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51, 0x7f,
+				0x7f, 0x7f),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-- 
2.43.0


