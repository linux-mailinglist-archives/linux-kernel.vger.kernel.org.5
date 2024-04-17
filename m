Return-Path: <linux-kernel+bounces-148032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6985C8A7CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2784F282718
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AFA6A8BE;
	Wed, 17 Apr 2024 07:13:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AED657D2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338022; cv=none; b=LyFSeV7Go4eOAWjjP7mggM0dD5obuiD0cIHe56Q+LdlWta2APCmK5955D84fyLbaK6bKDEcsZh1JQNWyPVq2gw5I7xakdLRkM2BahYcjJfXqe2ErsZgjBiUVUiv/kT436B5eNKfkxUgHA1yS80PT+duxUZo1No4QxMJF5Hlf2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338022; c=relaxed/simple;
	bh=82DWYcTra6labpUAf+RVk7PAgFqopENzHlzOJ60NyRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhPmoGT6pkArbEq29GtWlQ1HtyTCmAHwohzLJ6LhHrTkWx/AR+C4YTFYP922vHzA6G/m2rnlc5lePyQXSdLmp5phhQsxg04ymQYhYwLX2TOTjaPQH9HcvSb35O+wnyLlMerY8JWGmGW1hDDOWUTsfa7OMyNsY3eugNB1aZ2EOGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rwzUB-0003W6-EK; Wed, 17 Apr 2024 09:13:39 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rwzUA-00Ckap-BH; Wed, 17 Apr 2024 09:13:38 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rwzUA-004DbZ-0h;
	Wed, 17 Apr 2024 09:13:38 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 17 Apr 2024 09:13:30 +0200
Subject: [PATCH 3/4] mtd: nand: mxc_nand: support software ECC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-mtd-nand-mxc-nand-exec-op-v1-3-d12564fe54e9@pengutronix.de>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
In-Reply-To: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713338018; l=1720;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=82DWYcTra6labpUAf+RVk7PAgFqopENzHlzOJ60NyRo=;
 b=RhBSq9gE5i2OhwGVMjEfvV7a2S+BukuzKU9yBwRGjLdUlS8/4EXboS+I15HGJHSgTdBkiv7p5
 ZHUz+GCIQMTC+M/pAeX1zKLHPX1xb0/5pz12twibkoj/eQxC5tQvdVt
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

To support software ECC we still need the driver provided read_oob,
read_page_raw and write_page_raw ops, so set them unconditionally
no matter which engine_type we use. The OOB layout on the other hand
represents the layout the i.MX ECC hardware uses, so set this only
when NAND_ECC_ENGINE_TYPE_ON_HOST is in use.

With these changes the driver can be used with software BCH ECC which
is useful for NAND chips that require a stronger ECC than the i.MX
hardware supports.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/raw/mxc_nand.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index fc70c65dea268..f44c130dca18d 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1394,15 +1394,16 @@ static int mxcnd_attach_chip(struct nand_chip *chip)
 	chip->ecc.bytes = host->devtype_data->eccbytes;
 	host->eccsize = host->devtype_data->eccsize;
 	chip->ecc.size = 512;
-	mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
+
+	chip->ecc.read_oob = mxc_nand_read_oob;
+	chip->ecc.read_page_raw = mxc_nand_read_page_raw;
+	chip->ecc.write_page_raw = mxc_nand_write_page_raw;
 
 	switch (chip->ecc.engine_type) {
 	case NAND_ECC_ENGINE_TYPE_ON_HOST:
+		mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
 		chip->ecc.read_page = mxc_nand_read_page;
-		chip->ecc.read_page_raw = mxc_nand_read_page_raw;
-		chip->ecc.read_oob = mxc_nand_read_oob;
 		chip->ecc.write_page = mxc_nand_write_page_ecc;
-		chip->ecc.write_page_raw = mxc_nand_write_page_raw;
 		chip->ecc.write_oob = mxc_nand_write_oob;
 		break;
 

-- 
2.39.2


