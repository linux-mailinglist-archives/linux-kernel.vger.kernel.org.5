Return-Path: <linux-kernel+bounces-27020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C130582E946
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E762C1C22C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B464F9CD;
	Tue, 16 Jan 2024 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HbBmnQeu"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303C79F6;
	Tue, 16 Jan 2024 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G2RIBU023505;
	Mon, 15 Jan 2024 21:57:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=c4fyR23j
	INK7GjvY0sE+jgHH/I2Qe4PuJT+pvmXxyMY=; b=HbBmnQeuiwzZPOpsgwfeqF7t
	K8eFhA3seL0zPHAL7uOuPI+ljkxG/eAi4uhkyy8W8TZvRSBXCR3NzUHGuVJ6IXID
	H+S4P/oo5dCtf/1wa7Lxjg1jsHLLLBu4jGD0Qe1EIfwLslHUJipq+au7Zb47i0JH
	EtZSx9yntnH2zRt+ekk191vx/qRP8rjVezDqnP9ik/4qch3E6A8X6cpPPxfgjrXy
	E0TEg4ziSN59vSt8U4WfeXmzWf2u2dFviFHY26aN79ut3y2pPSqkxNUYFVXYdUxc
	LsvL66CuccgH9ZU2sJ5E4fLZdwoM7cVUm17ox5MuBKf1fjQS/rgI+QjZ9RcdtQ==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vnh1e8ex9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 21:57:58 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 15 Jan
 2024 21:57:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 15 Jan 2024 21:57:56 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id 7DB9E3F704F;
	Mon, 15 Jan 2024 21:57:56 -0800 (PST)
From: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
To: <marcin.s.wojtas@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Subject: [PATCH 1/1] net: mvpp2: clear BM pool before initialization
Date: Mon, 15 Jan 2024 21:57:54 -0800
Message-ID: <20240116055754.279560-1-jpatel2@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KjhZX0HiiR33q8KWJCS2visk0UNU2jtm
X-Proofpoint-ORIG-GUID: KjhZX0HiiR33q8KWJCS2visk0UNU2jtm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Register value persisted after booting the kernel using
kexec which resulted in kernel panic. Thus cleared the
BM pool registers before initialisation to fix the issue.

Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 820b1fabe297..8223c00d1f91 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -614,12 +614,40 @@ static void mvpp23_bm_set_8pool_mode(struct mvpp2 *priv)
 	mvpp2_write(priv, MVPP22_BM_POOL_BASE_ADDR_HIGH_REG, val);
 }
 
+/* Cleanup pool before actual initialization in the OS */
+static void mvpp2_bm_pool_cleanup(struct mvpp2 *priv, int pool_id)
+{
+	u32 val;
+	int i;
+	/* Drain the BM from all possible residues left by firmware */
+	for (i = 0; i < MVPP2_BM_POOL_SIZE_MAX; i++)
+		mvpp2_read(priv, MVPP2_BM_PHY_ALLOC_REG(pool_id));
+	/* Stop the BM pool */
+	val = mvpp2_read(priv, MVPP2_BM_POOL_CTRL_REG(pool_id));
+	val |= MVPP2_BM_STOP_MASK;
+	mvpp2_write(priv, MVPP2_BM_POOL_CTRL_REG(pool_id), val);
+	/* Mask BM all interrupts */
+	mvpp2_write(priv, MVPP2_BM_INTR_MASK_REG(pool_id), 0);
+	/* Clear BM cause register */
+	mvpp2_write(priv, MVPP2_BM_INTR_CAUSE_REG(pool_id), 0);
+}
+
 static int mvpp2_bm_init(struct device *dev, struct mvpp2 *priv)
 {
 	enum dma_data_direction dma_dir = DMA_FROM_DEVICE;
 	int i, err, poolnum = MVPP2_BM_POOLS_NUM;
 	struct mvpp2_port *port;
 
+	if (priv->percpu_pools)
+		poolnum = mvpp2_get_nrxqs(priv) * 2;
+
+	for (i = 0; i < poolnum; i++) {
+		/* Make sure about the pool state in case it was
+		 * used by firmware.
+		 */
+		mvpp2_bm_pool_cleanup(priv, i);
+	}
+
 	if (priv->percpu_pools) {
 		for (i = 0; i < priv->port_count; i++) {
 			port = priv->port_list[i];
-- 
2.25.1


