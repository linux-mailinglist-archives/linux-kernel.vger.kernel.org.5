Return-Path: <linux-kernel+bounces-126066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A4D8931A8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6975AB2131C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BD9144D04;
	Sun, 31 Mar 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="b9cadDmm"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33338762DF;
	Sun, 31 Mar 2024 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711891079; cv=none; b=ADuzUhTjVNvAFFpOay9U0DuVk1mLEoX6Q2J7cqZfV3rzIf0euFMlafh6MRL6oTaB0ofTKXEcWzzA0NY8OGXEZaGTw+mJChZN6Mw1fsmv2NoD5MNzQK6F9HQY9B/6ZVXJ/WDaFvKlJ9xpjuXIZsQcIGLz0Gyr4nD+teMk3nLLXlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711891079; c=relaxed/simple;
	bh=HQ2LXoIEVmp8/qP0MN2mwzqsAKAVtORpWqbh4y7LyM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cflu+/hVyD5aBj2PSY1zpFDRTmjmX0fNPYIrlk4grWDkoYsSXsIo06Z7DN1zauhVRRG/PoWyHfs6rzJnjklqHEFMhMTmHo5jrsxyPln255dQ2v/yHbZxz+n1HRMNZzxqFogQek26JCE5/GQpyAXrah4gTpEIkZKJLvudAk5KweQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=b9cadDmm; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42VBmDs9009610;
	Sun, 31 Mar 2024 05:48:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=5DTBjzcq
	xh4wTG4VBBYScUn4HvM5rt+lsvC8uKlOytU=; b=b9cadDmmvtIsodHUtrQdoEp7
	Y91qa8rbzEBdRV6P9NYrekXQfeWCpS3uy4l2B8+b4AWcLl+B1sxt5aJ6BS6kAazv
	IRSaHBA2DRpRgRQseoryEkGGYuLr9G+qgd4CNxgQ7qBUv7XgdYNIcGmYO+x+lBZj
	3yCW+COgaGMGpxUYdsCsCktCntJZlYuX8jzS255jXlcDicFaVMUUWs7iZERudkIh
	YvVHkU7/Cc3Lcep79haY4EipETllZt3GxYjETwOIRAkEK/gLg6MKGJKK51xqwJss
	Lufm/cy+SMUMQ3yTT5KhdiXT/9FBnPGb6r+zEg6eO0zn4Vg7+7DBCLuAS6wkRA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x6g3kadqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Mar 2024 05:48:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 31 Mar 2024 05:48:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 31 Mar 2024 05:48:32 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.83])
	by maili.marvell.com (Postfix) with ESMTP id 9CE335C68E3;
	Sun, 31 Mar 2024 05:48:28 -0700 (PDT)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v4] octeontx2-pf: Reset MAC stats during probe
Date: Sun, 31 Mar 2024 18:18:19 +0530
Message-ID: <20240331124819.425930-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: XCDHxE5j0hxD45BxxlrouD4RVTop-N0P
X-Proofpoint-ORIG-GUID: XCDHxE5j0hxD45BxxlrouD4RVTop-N0P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_09,2024-03-28_01,2023-05-22_02

Reset CGX/RPM MAC HW statistics at the time of driver probe()

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
v4:
    - Addresses review comments given by Jakub Kicinski
        1. Moved MAC stats reset before netdev/devlink register.
v3:
    - Addressed review comments given by Jakub Kicinski
        1. Removed un-necessary EXPORT_SYMBOL 
v2:
    - Addressed review comments given by Jakub Kicinski
	1. Removed devlink option to reset MAC stats, 
           will implement stats reset with debugfs in later patches.

 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 27 +++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  1 +
 .../marvell/octeontx2/af/lmac_common.h        |  1 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
 .../net/ethernet/marvell/octeontx2/af/rpm.c   | 17 +++++++++++
 .../net/ethernet/marvell/octeontx2/af/rpm.h   |  3 ++
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 29 +++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_common.h       |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 20 +++++++++++++
 9 files changed, 100 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index b86f3224f0b7..27935c54b91b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -24,6 +24,8 @@
 #define DRV_NAME	"Marvell-CGX/RPM"
 #define DRV_STRING      "Marvell CGX/RPM Driver"
 
+#define CGX_RX_STAT_GLOBAL_INDEX	9
+
 static LIST_HEAD(cgx_list);
 
 /* Convert firmware speed encoding to user format(Mbps) */
@@ -701,6 +703,30 @@ u64 cgx_features_get(void *cgxd)
 	return ((struct cgx *)cgxd)->hw_features;
 }
 
+int cgx_stats_reset(void *cgxd, int lmac_id)
+{
+	struct cgx *cgx = cgxd;
+	int stat_id;
+
+	if (!is_lmac_valid(cgx, lmac_id))
+		return -ENODEV;
+
+	for (stat_id = 0 ; stat_id < CGX_RX_STATS_COUNT; stat_id++) {
+		if (stat_id >= CGX_RX_STAT_GLOBAL_INDEX)
+		/* pass lmac as 0 for CGX_CMR_RX_STAT9-12 */
+			cgx_write(cgx, 0,
+				  (CGXX_CMRX_RX_STAT0 + (stat_id * 8)), 0);
+		else
+			cgx_write(cgx, lmac_id,
+				  (CGXX_CMRX_RX_STAT0 + (stat_id * 8)), 0);
+	}
+
+	for (stat_id = 0 ; stat_id < CGX_TX_STATS_COUNT; stat_id++)
+		cgx_write(cgx, lmac_id, CGXX_CMRX_TX_STAT0 + (stat_id * 8), 0);
+
+	return 0;
+}
+
 static int cgx_set_fec_stats_count(struct cgx_link_user_info *linfo)
 {
 	if (!linfo->fec)
@@ -1788,6 +1814,7 @@ static struct mac_ops	cgx_mac_ops    = {
 	.pfc_config =                   cgx_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        cgx_lmac_get_pfc_frm_cfg,
 	.mac_reset   =			cgx_lmac_reset,
+	.mac_stats_reset       =	cgx_stats_reset,
 };
 
 static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 6f7d1dee5830..dc9ace30554a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -141,6 +141,7 @@ int cgx_lmac_evh_register(struct cgx_event_cb *cb, void *cgxd, int lmac_id);
 int cgx_lmac_evh_unregister(void *cgxd, int lmac_id);
 int cgx_get_tx_stats(void *cgxd, int lmac_id, int idx, u64 *tx_stat);
 int cgx_get_rx_stats(void *cgxd, int lmac_id, int idx, u64 *rx_stat);
+int cgx_stats_reset(void *cgxd, int lmac_id);
 int cgx_lmac_rx_tx_enable(void *cgxd, int lmac_id, bool enable);
 int cgx_lmac_tx_enable(void *cgxd, int lmac_id, bool enable);
 int cgx_lmac_addr_set(u8 cgx_id, u8 lmac_id, u8 *mac_addr);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
index 0b4cba03f2e8..9ffc6790c513 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
@@ -132,6 +132,7 @@ struct mac_ops {
 	/* FEC stats */
 	int			(*get_fec_stats)(void *cgxd, int lmac_id,
 						 struct cgx_fec_stats_rsp *rsp);
+	int			(*mac_stats_reset)(void *cgxd, int lmac_id);
 };
 
 struct cgx {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 3d801a1a4f70..4a77f6fe2622 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -174,6 +174,7 @@ M(CGX_FEC_STATS,	0x217, cgx_fec_stats, msg_req, cgx_fec_stats_rsp) \
 M(CGX_SET_LINK_MODE,	0x218, cgx_set_link_mode, cgx_set_link_mode_req,\
 			       cgx_set_link_mode_rsp)	\
 M(CGX_GET_PHY_FEC_STATS, 0x219, cgx_get_phy_fec_stats, msg_req, msg_rsp) \
+M(CGX_STATS_RST,	0x21A, cgx_stats_rst, msg_req, msg_rsp)		\
 M(CGX_FEATURES_GET,	0x21B, cgx_features_get, msg_req,		\
 			       cgx_features_info_msg)			\
 M(RPM_STATS,		0x21C, rpm_stats, msg_req, rpm_stats_rsp)	\
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index 76218f1cb459..1b34cf9c9703 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -38,6 +38,7 @@ static struct mac_ops		rpm_mac_ops   = {
 	.pfc_config =                   rpm_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        rpm_lmac_get_pfc_frm_cfg,
 	.mac_reset   =			rpm_lmac_reset,
+	.mac_stats_reset		 =	  rpm_stats_reset,
 };
 
 static struct mac_ops		rpm2_mac_ops   = {
@@ -70,6 +71,7 @@ static struct mac_ops		rpm2_mac_ops   = {
 	.pfc_config =                   rpm_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        rpm_lmac_get_pfc_frm_cfg,
 	.mac_reset   =			rpm_lmac_reset,
+	.mac_stats_reset	    =	rpm_stats_reset,
 };
 
 bool is_dev_rpm2(void *rpmd)
@@ -443,6 +445,21 @@ int rpm_get_tx_stats(void *rpmd, int lmac_id, int idx, u64 *tx_stat)
 	return 0;
 }
 
+int rpm_stats_reset(void *rpmd, int lmac_id)
+{
+	rpm_t *rpm = rpmd;
+	u64 cfg;
+
+	if (!is_lmac_valid(rpm, lmac_id))
+		return -ENODEV;
+
+	cfg = rpm_read(rpm, 0, RPMX_MTI_STAT_STATN_CONTROL);
+	cfg |= RPMX_CMD_CLEAR_TX | RPMX_CMD_CLEAR_RX | BIT_ULL(lmac_id);
+	rpm_write(rpm, 0, RPMX_MTI_STAT_STATN_CONTROL, cfg);
+
+	return 0;
+}
+
 u8 rpm_get_lmac_type(void *rpmd, int lmac_id)
 {
 	rpm_t *rpm = rpmd;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
index b79cfbc6f877..34b11deb0f3c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
@@ -85,6 +85,8 @@
 #define RPMX_MTI_STAT_STATN_CONTROL			0x10018
 #define RPMX_MTI_STAT_DATA_HI_CDC			0x10038
 #define RPMX_RSFEC_RX_CAPTURE				BIT_ULL(27)
+#define RPMX_CMD_CLEAR_RX				BIT_ULL(30)
+#define RPMX_CMD_CLEAR_TX				BIT_ULL(31)
 #define RPMX_MTI_RSFEC_STAT_COUNTER_CAPTURE_2		0x40050
 #define RPMX_MTI_RSFEC_STAT_COUNTER_CAPTURE_3		0x40058
 #define RPMX_MTI_FCFECX_VL0_CCW_LO			0x38618
@@ -134,4 +136,5 @@ int rpm2_get_nr_lmacs(void *rpmd);
 bool is_dev_rpm2(void *rpmd);
 int rpm_get_fec_stats(void *cgxd, int lmac_id, struct cgx_fec_stats_rsp *rsp);
 int rpm_lmac_reset(void *rpmd, int lmac_id, u8 pf_req_flr);
+int rpm_stats_reset(void *rpmd, int lmac_id);
 #endif /* RPM_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 72e060cf6b61..9d2836077d9f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -602,6 +602,35 @@ int rvu_mbox_handler_rpm_stats(struct rvu *rvu, struct msg_req *req,
 	return rvu_lmac_get_stats(rvu, req, (void *)rsp);
 }
 
+int rvu_mbox_handler_cgx_stats_rst(struct rvu *rvu, struct msg_req *req,
+				   struct msg_rsp *rsp)
+{
+	int pf = rvu_get_pf(req->hdr.pcifunc);
+	struct rvu_pfvf	*parent_pf;
+	struct mac_ops *mac_ops;
+	u8 cgx_idx, lmac;
+	void *cgxd;
+
+	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
+		return LMAC_AF_ERR_PERM_DENIED;
+
+	parent_pf = &rvu->pf[pf];
+	/* To ensure reset cgx stats won't affect VF stats,
+	 *  check if it used by only PF interface.
+	 *  If not, return
+	 */
+	if (parent_pf->cgx_users > 1) {
+		dev_info(rvu->dev, "CGX busy, could not reset statistics\n");
+		return 0;
+	}
+
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_idx, &lmac);
+	cgxd = rvu_cgx_pdata(cgx_idx, rvu);
+	mac_ops = get_mac_ops(cgxd);
+
+	return mac_ops->mac_stats_reset(cgxd, lmac);
+}
+
 int rvu_mbox_handler_cgx_fec_stats(struct rvu *rvu,
 				   struct msg_req *req,
 				   struct cgx_fec_stats_rsp *rsp)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 7e16a341ec58..c5de3ba33e2f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -961,6 +961,7 @@ void otx2_get_mac_from_af(struct net_device *netdev);
 void otx2_config_irq_coalescing(struct otx2_nic *pfvf, int qidx);
 int otx2_config_pause_frm(struct otx2_nic *pfvf);
 void otx2_setup_segmentation(struct otx2_nic *pfvf);
+int otx2_reset_mac_stats(struct otx2_nic *pfvf);
 
 /* RVU block related APIs */
 int otx2_attach_npa_nix(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 5d8359b54098..9afeefea3b65 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1146,6 +1146,23 @@ static int otx2_cgx_config_linkevents(struct otx2_nic *pf, bool enable)
 	return err;
 }
 
+int otx2_reset_mac_stats(struct otx2_nic *pfvf)
+{
+	struct msg_req *req;
+	int err;
+
+	mutex_lock(&pfvf->mbox.lock);
+	req = otx2_mbox_alloc_msg_cgx_stats_rst(&pfvf->mbox);
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	err = otx2_sync_mbox_msg(&pfvf->mbox);
+	mutex_unlock(&pfvf->mbox.lock);
+	return err;
+}
+
 static int otx2_cgx_config_loopback(struct otx2_nic *pf, bool enable)
 {
 	struct msg_req *msg;
@@ -3034,6 +3051,9 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	netdev->min_mtu = OTX2_MIN_MTU;
 	netdev->max_mtu = otx2_get_max_mtu(pf);
 
+	/* reset CGX/RPM MAC stats */
+	otx2_reset_mac_stats(pf);
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(dev, "Failed to register netdevice\n");
-- 
2.25.1


