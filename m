Return-Path: <linux-kernel+bounces-4226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE814817958
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48807285D57
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1B35D735;
	Mon, 18 Dec 2023 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="arMMbyd/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FFC1DFDE;
	Mon, 18 Dec 2023 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIFAJWx011943;
	Mon, 18 Dec 2023 10:03:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=ltnbOgbv
	1rFAKiQQb0O/LdKhSjcYgvW52nepTPzv6Ow=; b=arMMbyd/ZPMCwBnIl8v7FTTq
	hQe1QgIbs9rMi1Hf+co5ACpUjPkg0bnt+jy9XKoRx3eMufYy5q5sCIzXnHneHWzG
	GTZgstJAoKDGs3LzoN68Pb0CoL5ZJnZ/3WLOjHcojbHEl4Oha6xgh81olmufD5Cm
	YHDpXXOXuDmciteks1dPdZWAx0ceUdJ+xQdPUelSmPhZT27yVVcRCTHNsjx7L+PE
	i+21yvXPsYl9BA2bJ+PpBJXdWDHXpmrAIbW36iQjyv+DJxqcqD85BAK+UXYJ0CFV
	CrkdLlZiyl1tEwuO85RNUB2gQzZUDuilcFBknT26Zb77/M765yoW51a1+p0aPA==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3v2rg58mrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 10:03:07 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Dec
 2023 10:03:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 18 Dec 2023 10:03:06 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 234483F707D;
	Mon, 18 Dec 2023 10:03:01 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH] octeontx2-af: Fix a double free issue
Date: Mon, 18 Dec 2023 23:32:58 +0530
Message-ID: <20231218180258.303468-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZWYpnapBLHaUTHG7NQo_YBPoUe7AgMLZ
X-Proofpoint-GUID: ZWYpnapBLHaUTHG7NQo_YBPoUe7AgMLZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

There was a memory leak during error handling in function
npc_mcam_rsrcs_init().

Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
This is a follow-up of
https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_netdev_net-2Dnext_c_dd7842878633&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=7si3Xn9Ly-Se1a655kvEPIYU0nQ9HPeN280sEUv5ROU&m=60aBCTsbI2Wra6po5SgIjqyAuIFqF5EhovKncvmmGaMwU94GDPEB2f_wC_piT9AE&s=7z2Gk48pbPhPqKU-pUu2xd2k6Ze5niLKk3P0iBiD9F8&e=

 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 513c4fe86967..7f30e08b580f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1990,7 +1990,7 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 free_bmap_reverse:
 	kfree(mcam->bmap_reverse);
 free_bmap:
-	kfree(mcam->counters.bmap);
+	kfree(mcam->bmap);
 
 	return -ENOMEM;
 }
-- 
2.25.1


