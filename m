Return-Path: <linux-kernel+bounces-14470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FCE821D75
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086F11C222A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1E910A14;
	Tue,  2 Jan 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BteRHztq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF77101FB;
	Tue,  2 Jan 2024 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4025L8iG007659;
	Tue, 2 Jan 2024 06:14:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=IJrNYQI7
	phJ6uwSfJv0x5Z/YeHktXMqPrJXQdOxB+rY=; b=BteRHztqd2F9JGzX1vlP+wfy
	pz64m873KkPMNh5ZeqhTPW8qxY6Im1i3zxgWzh4esxSCBQlVkEpcow0NqM1S9Qnl
	dVkBPPlEyiO1cNqiCdqS98K98LBKZuA7DI6gAYDioIfcrvhKEQzYxEo38qmZu7ID
	nPx5KtKpf/VhlWy/KfA6JDiIwO2DbwrstzH0jzkWtx3TXc6D05jvb3AXYU717Tmp
	CJ9VILgJyaj9k1bTaJxdqgZpwp0BMqxuQuZLUdEfDT0kCmr3CR/i7+bH45Ko7CKk
	qqlLUtzr3/0cbefVZ+/nxLhcAafAM+PdAdX+1jFcs3/twDhbBcUC+YvORlHM1w==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vcc9097w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 06:14:06 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 2 Jan
 2024 06:14:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 2 Jan 2024 06:14:04 -0800
Received: from #hyd1583.marvell.com (unknown [10.29.37.44])
	by maili.marvell.com (Postfix) with ESMTP id 4E1733F708E;
	Tue,  2 Jan 2024 06:14:02 -0800 (PST)
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Naveen Mamindlapalli <naveenm@marvell.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>
Subject: [net PATCH] octeontx2-af: Re-enable MAC TX in otx2_stop processing
Date: Tue, 2 Jan 2024 19:44:00 +0530
Message-ID: <20240102141400.9146-1-naveenm@marvell.com>
X-Mailer: git-send-email 2.39.0.198.ga38d39a4c5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YvGNEMQHfA9NH_Gu-FleO_Q1ZaY3z2jg
X-Proofpoint-GUID: YvGNEMQHfA9NH_Gu-FleO_Q1ZaY3z2jg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

During QoS scheduling testing with multiple strict priority flows, the
netdev tx watchdog timeout routine is invoked when a low priority QoS
queue doesn't get a chance to transmit the packets because other high
priority flows are completely subscribing the transmit link. The netdev
tx watchdog timeout routine will stop MAC RX and TX functionality in
otx2_stop() routine before cleanup of HW TX queues which results in SMQ
flush errors because the packets belonging to low priority queues will
never gets flushed since MAC TX is disabled. This patch fixes the issue
by re-enabling MAC TX to ensure the packets in HW pipeline gets flushed
properly.

Fixes: a7faa68b4e7f ("octeontx2-af: Start/Stop traffic in CGX along with NPC")
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 17 +++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c |  8 +++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index cce2806aaa50..8802961b8889 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -905,6 +905,7 @@ u32  rvu_cgx_get_fifolen(struct rvu *rvu);
 void *rvu_first_cgx_pdata(struct rvu *rvu);
 int cgxlmac_to_pf(struct rvu *rvu, int cgx_id, int lmac_id);
 int rvu_cgx_config_tx(void *cgxd, int lmac_id, bool enable);
+int rvu_cgx_tx_enable(struct rvu *rvu, u16 pcifunc, bool enable);
 int rvu_cgx_prio_flow_ctrl_cfg(struct rvu *rvu, u16 pcifunc, u8 tx_pause, u8 rx_pause,
 			       u16 pfc_en);
 int rvu_cgx_cfg_pause_frm(struct rvu *rvu, u16 pcifunc, u8 tx_pause, u8 rx_pause);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 15a319684ed3..38acdc7a73bb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -465,6 +465,23 @@ int rvu_cgx_config_rxtx(struct rvu *rvu, u16 pcifunc, bool start)
 	return mac_ops->mac_rx_tx_enable(cgxd, lmac_id, start);
 }
 
+int rvu_cgx_tx_enable(struct rvu *rvu, u16 pcifunc, bool enable)
+{
+	int pf = rvu_get_pf(pcifunc);
+	struct mac_ops *mac_ops;
+	u8 cgx_id, lmac_id;
+	void *cgxd;
+
+	if (!is_cgx_config_permitted(rvu, pcifunc))
+		return LMAC_AF_ERR_PERM_DENIED;
+
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+	cgxd = rvu_cgx_pdata(cgx_id, rvu);
+	mac_ops = get_mac_ops(cgxd);
+
+	return mac_ops->mac_tx_enable(cgxd, lmac_id, enable);
+}
+
 int rvu_cgx_config_tx(void *cgxd, int lmac_id, bool enable)
 {
 	struct mac_ops *mac_ops;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 2b6ab748ce25..58744313f0eb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4737,7 +4737,13 @@ int rvu_mbox_handler_nix_lf_stop_rx(struct rvu *rvu, struct msg_req *req,
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	clear_bit(NIXLF_INITIALIZED, &pfvf->flags);
 
-	return rvu_cgx_start_stop_io(rvu, pcifunc, false);
+	err = rvu_cgx_start_stop_io(rvu, pcifunc, false);
+	if (err)
+		return err;
+
+	rvu_cgx_tx_enable(rvu, pcifunc, true);
+
+	return 0;
 }
 
 #define RX_SA_BASE  GENMASK_ULL(52, 7)
-- 
2.39.0.198.ga38d39a4c5


