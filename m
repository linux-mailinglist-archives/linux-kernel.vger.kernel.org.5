Return-Path: <linux-kernel+bounces-5371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D0E8189FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2544A2861D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6150C37898;
	Tue, 19 Dec 2023 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KqioOt5P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27DA374C7;
	Tue, 19 Dec 2023 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJA5YMC028899;
	Tue, 19 Dec 2023 06:26:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=pOc3zEmt
	dXvtjqUGegYJG6m9oMBfHS1dS80hvWec7Qo=; b=KqioOt5PDHb4CnXSkK8Jmftn
	jQTV7nFVHii/ZxOI9UiUZxKop4gKESCrjg/0PuOnfBBOflYrXwXkIlUjIbij6Phd
	nM0X/dKxtVOGsJmvAMkC5vfHZDX2k63+ubK+c89d031kI+W1EDBjusjnjUB9kApg
	PrLy7FtaP0l9jok/D9VEdcTj6iqGxIBtrBaBuUdB/PUybJy8T6b5HXZphfoH1VZW
	pVnFKXKxvRP+frUpbhYLJzfztZW1/Mdj4v2xdcg7uesoGL6omh0n3VxGQsKOTy3b
	UIZf1dzvGOuiVMiOHJrTqL3FZXh9+HGSm4nGDX9Q1688GxjchP5hgr/GKfNGDw==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3v39490x2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 06:26:54 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 19 Dec
 2023 06:26:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 19 Dec 2023 06:26:40 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id A4B363F708C;
	Tue, 19 Dec 2023 06:26:36 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>, Jacob Keller <jacob.e.keller@intel.com>
Subject: [net PATCH v2] octeontx2-af: Fix marking couple of structure as __packed
Date: Tue, 19 Dec 2023 19:56:33 +0530
Message-ID: <20231219142633.321507-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VUw93W7YUSfDrZkw_cADilJyTmUcNxgv
X-Proofpoint-ORIG-GUID: VUw93W7YUSfDrZkw_cADilJyTmUcNxgv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Couple of structures was not marked as __packed. This patch
fixes the same and mark them as __packed.

Fixes: 42006910b5ea ("octeontx2-af: cleanup KPU config data")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
v2 changes:
- Updated commit description.

 drivers/net/ethernet/marvell/octeontx2/af/npc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index ab3e39eef2eb..8c0732c9a7ee 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -528,7 +528,7 @@ struct npc_lt_def {
 	u8	ltype_mask;
 	u8	ltype_match;
 	u8	lid;
-};
+} __packed;
 
 struct npc_lt_def_ipsec {
 	u8	ltype_mask;
@@ -536,7 +536,7 @@ struct npc_lt_def_ipsec {
 	u8	lid;
 	u8	spi_offset;
 	u8	spi_nz;
-};
+} __packed;
 
 struct npc_lt_def_apad {
 	u8	ltype_mask;
-- 
2.25.1


