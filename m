Return-Path: <linux-kernel+bounces-15603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A87822EB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D86282A6C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAB71A28A;
	Wed,  3 Jan 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kLhrPyd4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E68E199B6;
	Wed,  3 Jan 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4032T7WG005087;
	Wed, 3 Jan 2024 05:37:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=zh+AyINX
	Tu/Vu+J5ZWs/mnBjeWFhJ2utrKdUpD3dDh8=; b=kLhrPyd4G7oi/JGNrMbhn/Ue
	b25wiCm4ozjXAFfD8PoY7I1QyXbe1S5Xa70gmaScrintawXW6QpDa5NTWSR4fr/K
	ktEDcsrmLL5XxgozDrIKSoH67aK9xIWjq4eMJh12CCXrkPiW+IhZ7lETFeHOCmk7
	UsqAud5oLXK3dJy+MjF9+OnuyjQoJO81I+tMWabuZUiROz61YQ9iTo8xLbz/PSvd
	deGeUwq+a4POknU0j/jKyXBa6/idh9X2BAoHQ2yIXo3AdvTdsI4MAqDMOHpnFh0e
	z69rtQk25+8ECP5/LhjBLq8sKgc9x/P5QUnAdIExfQyJxNM3bPiR7gcxKukQxg==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vcxu5tqst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 05:37:52 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 3 Jan
 2024 05:37:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 3 Jan 2024 05:37:51 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 109093F708E;
	Wed,  3 Jan 2024 05:37:47 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <vadym.kochan@plvision.eu>, <aviramd@marvell.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] mtd: rawnand: marvell: fix layouts
Date: Wed, 3 Jan 2024 15:37:40 +0200
Message-ID: <20240103133740.1233405-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: v1EW8NBQjlMtvzdifc8-WQV5sv3PL5qF
X-Proofpoint-GUID: v1EW8NBQjlMtvzdifc8-WQV5sv3PL5qF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

The check in nand_base.c, nand_scan_tail() : has the following code:
(ecc->steps * ecc->size != mtd->writesize) which fails for some NAND chips.
Remove ECC entries in this driver which are not integral multiplications,
and adjust the number of chunks for entries which fails the above
calculation so it will calculate correctly (this was previously done
automatically before the check and was removed in a later commit).

Fixes: 68c18dae6888 ("mtd: rawnand: marvell: add missing layouts")
Cc: stable@vger.kernel.org
Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/mtd/nand/raw/marvell_nand.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index a46698744850..5b0f5a9cef81 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -290,16 +290,13 @@ static const struct marvell_hw_ecc_layout marvell_nfc_layouts[] = {
 	MARVELL_LAYOUT( 2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
 	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,32, 30),
 	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,64, 30),
-	MARVELL_LAYOUT( 2048,   512,  12, 3,  2, 704,   0, 30,640,  0, 30),
-	MARVELL_LAYOUT( 2048,   512,  16, 5,  4, 512,   0, 30,  0, 32, 30),
+	MARVELL_LAYOUT( 2048,   512,  16, 4,  4, 512,   0, 30,  0, 32, 30),
 	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
-	MARVELL_LAYOUT( 4096,   512,  12, 6,  5, 704,   0, 30,576, 32, 30),
-	MARVELL_LAYOUT( 4096,   512,  16, 9,  8, 512,   0, 30,  0, 32, 30),
+	MARVELL_LAYOUT( 4096,   512,  8,  4,  4, 1024,  0, 30,  0, 64, 30),
+	MARVELL_LAYOUT( 4096,   512,  16, 8,  8, 512,   0, 30,  0, 32, 30),
 	MARVELL_LAYOUT( 8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
-	MARVELL_LAYOUT( 8192,   512,  8,  9,  8, 1024,  0, 30,  0, 160, 30),
-	MARVELL_LAYOUT( 8192,   512,  12, 12, 11, 704,  0, 30,448,  64, 30),
-	MARVELL_LAYOUT( 8192,   512,  16, 17, 16, 512,  0, 30,  0,  32, 30),
+	MARVELL_LAYOUT( 8192,   512,  8,  8,  8, 1024,  0, 30,  0, 160, 30),
+	MARVELL_LAYOUT( 8192,   512,  16, 16, 16, 512,  0, 30,  0,  32, 30),
 };
 
 /**
-- 
2.25.1


