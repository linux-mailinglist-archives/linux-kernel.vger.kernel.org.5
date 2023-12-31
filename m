Return-Path: <linux-kernel+bounces-13774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A4820C5B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 19:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099891C21801
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE0AB65D;
	Sun, 31 Dec 2023 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VA1ix7i0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF0CB64C
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BVHrrKY018660;
	Sun, 31 Dec 2023 09:55:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=jMKL8CK5
	TAF5lqK76hJDPrOMYORfitD8HX9CBiNZ/iA=; b=VA1ix7i0PvuM6t0kgsyIREPG
	P9m4SKs8e5uS5bprXpSibVif/jHxmgyQC3RFzRmGTkqFg65z8KlFRt6rJb7czvAQ
	rbSg/AgbiwSbtSCOyzNP5E+2+oVbrV9kguAhJalqbj8sevkel9HLK8z+YaVvxPTc
	/VIX+ClMIyAnS3/09/0thrNAzybtUrDIAVVr8tMYyjecuBd9F7uaK64ziav0KEjr
	7lEKwBtaVyD7N03eOMco+guhMW47s2vB7O1z9HbuF4HzeF5IsXbviriZkxawB9kI
	RABc4NnXDssHgL7zb+ttN6uUyYPdH4aPuofGIhM1rYbx07dt+FJLxjE0gQu1qw==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vb5c30q82-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 31 Dec 2023 09:55:07 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 31 Dec
 2023 09:49:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 31 Dec 2023 09:49:57 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 596263F7044;
	Sun, 31 Dec 2023 09:49:55 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <vadym.kochan@plvision.eu>, <aviramd@marvell.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH] mtd: rawnand: marvell: fix layouts
Date: Sun, 31 Dec 2023 19:49:50 +0200
Message-ID: <20231231174950.3272727-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ImuojkOln7ya8hhiUhi0YtIKC_Di7ZAo
X-Proofpoint-ORIG-GUID: ImuojkOln7ya8hhiUhi0YtIKC_Di7ZAo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Check in nand_base.c, nand_scan_tail() :
if (ecc->steps * ecc->size != mtd->writesize)
Fails for some NAND chips.
Remove entries which cannot create integral
multiplications, and adjust the number of chunks
for entries which fails the above calculation to
calculate correctly (this was previously done
automatically before the check).
Also fix spacing of the said table.

Fixes: 68c18dae6888 ("mtd: rawnand: marvell: add missing layouts")
Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/mtd/nand/raw/marvell_nand.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index a46698744850..21f4469b5cda 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -285,21 +285,18 @@ struct marvell_hw_ecc_layout {
 
 /* Layouts explained in AN-379_Marvell_SoC_NFC_ECC */
 static const struct marvell_hw_ecc_layout marvell_nfc_layouts[] = {
-	MARVELL_LAYOUT(  512,   512,  1,  1,  1,  512,  8,  8,  0,  0,  0),
-	MARVELL_LAYOUT( 2048,   512,  1,  1,  1, 2048, 40, 24,  0,  0,  0),
-	MARVELL_LAYOUT( 2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,32, 30),
-	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,64, 30),
-	MARVELL_LAYOUT( 2048,   512,  12, 3,  2, 704,   0, 30,640,  0, 30),
-	MARVELL_LAYOUT( 2048,   512,  16, 5,  4, 512,   0, 30,  0, 32, 30),
-	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
-	MARVELL_LAYOUT( 4096,   512,  12, 6,  5, 704,   0, 30,576, 32, 30),
-	MARVELL_LAYOUT( 4096,   512,  16, 9,  8, 512,   0, 30,  0, 32, 30),
-	MARVELL_LAYOUT( 8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 8192,   512,  8,  9,  8, 1024,  0, 30,  0, 160, 30),
-	MARVELL_LAYOUT( 8192,   512,  12, 12, 11, 704,  0, 30,448,  64, 30),
-	MARVELL_LAYOUT( 8192,   512,  16, 17, 16, 512,  0, 30,  0,  32, 30),
+	MARVELL_LAYOUT(512,   512,  1,  1,  1,  512,  8,  8,  0,  0,  0),
+	MARVELL_LAYOUT(2048,   512,  1,  1,  1, 2048, 40, 24,  0,  0,  0),
+	MARVELL_LAYOUT(2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
+	MARVELL_LAYOUT(2048,   512,  8,  2,  1, 1024,  0, 30, 1024, 32, 30),
+	MARVELL_LAYOUT(2048,   512,  8,  2,  1, 1024,  0, 30, 1024, 64, 30),
+	MARVELL_LAYOUT(2048,   512,  16, 4,  4, 512,   0, 30,  0, 32, 30),
+	MARVELL_LAYOUT(4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
+	MARVELL_LAYOUT(4096,   512,  8,  4,  4, 1024,  0, 30,  0, 64, 30),
+	MARVELL_LAYOUT(4096,   512,  16, 8,  8, 512,   0, 30,  0, 32, 30),
+	MARVELL_LAYOUT(8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
+	MARVELL_LAYOUT(8192,   512,  8,  8,  8, 1024,  0, 30,  0, 160, 30),
+	MARVELL_LAYOUT(8192,   512,  16, 16, 16, 512,  0, 30,  0,  32, 30),
 };
 
 /**
-- 
2.25.1


