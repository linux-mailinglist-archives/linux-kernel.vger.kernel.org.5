Return-Path: <linux-kernel+bounces-138598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8578C89F435
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A922B1C2562A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019AB15ECF4;
	Wed, 10 Apr 2024 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="H00M0j8v"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3415CD4B;
	Wed, 10 Apr 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755566; cv=none; b=TXhlEegt6cHMPDj2hynE+dwOpE55Jxha7yxuXCLm2wbsjcN3R6AtZbo8T/07K5heyzKTNx49QM8mg/2xr/kEhB3nYLYFzJi6e94flB5CbUZ9ww/+QDJ9FEWAQoNrphrkXU7FQ+pMJ7HNGucNptbpDS4jo9ypjxoO55Xm/2HiWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755566; c=relaxed/simple;
	bh=brNg8ofcrj5O3U+cLXDIyxsMcvxFUyO1BEFHPk9RRMs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kH+X54ElsWnDD/l2WI0pJoW4I4CfZhJIpaA3MVSjKIN3NZpg7x2KFoqY+kvceVHlctBcVUoFquxWWGyDTPSX6ZtU5B1mRaCCZSIwQjMqVCMawwb709LmIDNKi+I/paFF+yejy6S+z7clwIfSzEGOt39Iz6pdxkzRwj/c6cmtk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=H00M0j8v; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A8XcJE022602;
	Wed, 10 Apr 2024 06:25:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=RRkwBEE8Zpq+ymv4uQ9hqryhYJ2lfarH1FbeDd0cP4Y=; b=H00
	M0j8vzo5xtYsPs3nYmDKOB/cKKRSmfY7Mb1I7Ihr3VLZq5HvNg1ySMFfcb08wduR
	I7sll6XG4lURpxwwwCXeIcvJwSRGQZNJnTO15LrY2DdIvZakvGP20qBL81rgnSrg
	FTM2hr/XLFgoGJV0KKA1XJUhDhtzaG907jZUGh0nzjobNGhmGMzYb4oLyiukewsb
	qlYpU9YRt651TB07kde9DZmJR0J9Pif8WYPFXcsLUDwdg49BhA8jzsaEigj8pHy7
	VAhWTHr4QbbwI5djeE9vxpy/UjG9ztdrU5LPgxc9j5068Hi16oaNL30w1WvDYPx4
	1fw58ThkpkER6C2yWUg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xdqc2k184-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 06:25:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Apr 2024 06:25:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 10 Apr 2024 06:25:43 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 5ED0E3F7081;
	Wed, 10 Apr 2024 06:25:39 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next PatchV2] octeontx2-af: map management port always to first PF
Date: Wed, 10 Apr 2024 18:55:38 +0530
Message-ID: <20240410132538.20158-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3-vYbEfnWhOld4n8k9OKVI0paNsK8kjR
X-Proofpoint-GUID: 3-vYbEfnWhOld4n8k9OKVI0paNsK8kjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02

The user can enable or disable any MAC block or a few ports of the
block. The management port's interface name varies depending on the
setup of the user if its not mapped to the first pf.

The management port mapping is now configured to always connect to the
first PF. This patch implements this change.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
v2 * Refactor code to avoid code duplication.

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  5 +-
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 84 +++++++++++++------
 2 files changed, 63 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 4a77f6fe2622..88cced83bf23 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -639,7 +639,10 @@ struct cgx_lmac_fwdata_s {
 	/* Only applicable if SFP/QSFP slot is present */
 	struct sfp_eeprom_s sfp_eeprom;
 	struct phy_s phy;
-#define LMAC_FWDATA_RESERVED_MEM 1021
+	u32 lmac_type;
+	u32 portm_idx;
+	u64 mgmt_port:1;
+#define LMAC_FWDATA_RESERVED_MEM 1019
 	u64 reserved[LMAC_FWDATA_RESERVED_MEM];
 };

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 266ecbc1b97a..8cc17d7e368d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -118,15 +118,67 @@ static void rvu_map_cgx_nix_block(struct rvu *rvu, int pf,
 		pfvf->nix_blkaddr = BLKADDR_NIX1;
 }

-static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
+static bool rvu_cgx_is_mgmt_port(struct rvu *rvu, int cgx_id, int lmac_id)
+{
+	struct cgx_lmac_fwdata_s *fwdata;
+
+	fwdata =  &rvu->fwdata->cgx_fw_data_usx[cgx_id][lmac_id];
+	return !!fwdata->mgmt_port;
+}
+
+static void __rvu_map_cgx_lmac_pf(struct rvu *rvu, unsigned int pf,
+				  int cgx, int lmac)
 {
 	struct npc_pkind *pkind = &rvu->hw->pkind;
-	int cgx_cnt_max = rvu->cgx_cnt_max;
-	int pf = PF_CGXMAP_BASE;
+	int numvfs, hwvfs;
+	int free_pkind;
+
+	rvu->pf2cgxlmac_map[pf] = cgxlmac_id_to_bmap(cgx, lmac);
+	rvu->cgxlmac2pf_map[CGX_OFFSET(cgx) + lmac] = 1 << pf;
+	free_pkind = rvu_alloc_rsrc(&pkind->rsrc);
+	pkind->pfchan_map[free_pkind] = ((pf) & 0x3F) << 16;
+	rvu_map_cgx_nix_block(rvu, pf, cgx, lmac);
+	rvu->cgx_mapped_pfs++;
+	rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvfs);
+	rvu->cgx_mapped_vfs += numvfs;
+}
+
+static void rvu_cgx_map_mgmt_port(struct rvu *rvu, int cgx_cnt_max,
+				  unsigned int *pf, bool req_map_mgmt)
+{
 	unsigned long lmac_bmap;
-	int size, free_pkind;
 	int cgx, lmac, iter;
-	int numvfs, hwvfs;
+
+	for (cgx = 0; cgx < cgx_cnt_max; cgx++) {
+		if (!rvu_cgx_pdata(cgx, rvu))
+			continue;
+		lmac_bmap = cgx_get_lmac_bmap(rvu_cgx_pdata(cgx, rvu));
+		for_each_set_bit(iter, &lmac_bmap, rvu->hw->lmac_per_cgx) {
+			if (iter >= MAX_LMAC_COUNT)
+				continue;
+			lmac = cgx_get_lmacid(rvu_cgx_pdata(cgx, rvu), iter);
+			/* Map management port always to first PF */
+			if (req_map_mgmt &&
+			    rvu_cgx_is_mgmt_port(rvu, cgx, lmac)) {
+				__rvu_map_cgx_lmac_pf(rvu, *pf, cgx, lmac);
+				(*pf)++;
+				return;
+			}
+			/* Non management port mapping */
+			if (!req_map_mgmt &&
+			    !rvu_cgx_is_mgmt_port(rvu, cgx, lmac)) {
+				__rvu_map_cgx_lmac_pf(rvu, *pf, cgx, lmac);
+				(*pf)++;
+			}
+		}
+	}
+}
+
+static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
+{
+	int cgx_cnt_max = rvu->cgx_cnt_max;
+	unsigned int pf = PF_CGXMAP_BASE;
+	int size;

 	if (!cgx_cnt_max)
 		return 0;
@@ -155,26 +207,8 @@ static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
 		return -ENOMEM;

 	rvu->cgx_mapped_pfs = 0;
-	for (cgx = 0; cgx < cgx_cnt_max; cgx++) {
-		if (!rvu_cgx_pdata(cgx, rvu))
-			continue;
-		lmac_bmap = cgx_get_lmac_bmap(rvu_cgx_pdata(cgx, rvu));
-		for_each_set_bit(iter, &lmac_bmap, rvu->hw->lmac_per_cgx) {
-			if (iter >= MAX_LMAC_COUNT)
-				continue;
-			lmac = cgx_get_lmacid(rvu_cgx_pdata(cgx, rvu),
-					      iter);
-			rvu->pf2cgxlmac_map[pf] = cgxlmac_id_to_bmap(cgx, lmac);
-			rvu->cgxlmac2pf_map[CGX_OFFSET(cgx) + lmac] = 1 << pf;
-			free_pkind = rvu_alloc_rsrc(&pkind->rsrc);
-			pkind->pfchan_map[free_pkind] = ((pf) & 0x3F) << 16;
-			rvu_map_cgx_nix_block(rvu, pf, cgx, lmac);
-			rvu->cgx_mapped_pfs++;
-			rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvfs);
-			rvu->cgx_mapped_vfs += numvfs;
-			pf++;
-		}
-	}
+	rvu_cgx_map_mgmt_port(rvu, cgx_cnt_max, &pf, true);
+	rvu_cgx_map_mgmt_port(rvu, cgx_cnt_max, &pf, false);
 	return 0;
 }

--
2.17.1

