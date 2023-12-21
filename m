Return-Path: <linux-kernel+bounces-8129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C455581B271
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF50B22B55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8024A99D;
	Thu, 21 Dec 2023 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CUvET9ed"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5185848CC2;
	Thu, 21 Dec 2023 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL6ILkU019367;
	Thu, 21 Dec 2023 01:29:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=OW4WgCS8lzrFrEdFvzyFJJRuP1ik/0GNiOwlTVEX0NE=; b=CUv
	ET9ed2z50POH7hkVvsAkn16kXvlJZHfQfsor63IqXsidX8dwW8oS+IGOScuh/Fdr
	VlmnV/f61q+lKYJYL6yv9stayjUGfzsGyJFYtfZfCj31BQ2htPKLuipV2jE7gqQT
	udjmAOLRx0f4+bmTiW+jGB/O+H0DkbIwdMthtaZTWDn1iFB5dFsVF59vcrvrjQFE
	EgBX8tep/G7ElD4hqGua8fMTqkQBOFcNjqNdaCEObHcCdzL/P3vvwIuKrL8WMpkz
	wmyu9kKbiSoltIYBo/jBDzah1xoBlyad7Kwd+SDFmb6WFgmT/7/vbmiYC8t+ih1M
	R08YmWgTg7hRWvdRKng==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3v4fyr1479-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 01:29:45 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Dec
 2023 01:29:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 21 Dec 2023 01:29:44 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id ABD033F7048;
	Thu, 21 Dec 2023 01:29:43 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
        <srasheed@marvell.com>, <egallen@redhat.com>, <mschmidt@redhat.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <horms@kernel.org>,
        <wizhao@redhat.com>, <kheib@redhat.com>, <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>
Subject: [PATCH net-next v1 3/8] octeon_ep_vf: add VF-PF mailbox communication.
Date: Thu, 21 Dec 2023 01:28:39 -0800
Message-ID: <20231221092844.2885872-4-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221092844.2885872-1-srasheed@marvell.com>
References: <20231221092844.2885872-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: FcW75qy1ughlOfp3AVOwzPuLU_w6JBzg
X-Proofpoint-ORIG-GUID: FcW75qy1ughlOfp3AVOwzPuLU_w6JBzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Implement VF-PF mailbox to send all control commands from VF to PF
and receive responses and notifications from PF to VF.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 103 ++++++
 .../marvell/octeon_ep_vf/octep_vf_main.h      |   1 +
 .../marvell/octeon_ep_vf/octep_vf_mbox.c      | 336 +++++++++++++++++-
 .../marvell/octeon_ep_vf/octep_vf_mbox.h      | 143 +++++++-
 4 files changed, 581 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index ebc8b785d5fd..1bb621de5165 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -188,6 +188,19 @@ static netdev_tx_t octep_vf_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+int octep_vf_get_link_info(struct octep_vf_device *oct)
+{
+	int ret, size;
+
+	ret = octep_vf_mbox_bulk_read(oct, OCTEP_PFVF_MBOX_CMD_GET_LINK_INFO,
+				      (u8 *)&oct->link_info, &size);
+	if (ret) {
+		dev_err(&oct->pdev->dev, "Get VF link info failed via VF Mbox\n");
+		return ret;
+	}
+	return 0;
+}
+
 /**
  * octep_vf_tx_timeout_task - work queue task to Handle Tx queue timeout.
  *
@@ -226,11 +239,84 @@ static void octep_vf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	queue_work(octep_vf_wq, &oct->tx_timeout_task);
 }
 
+static int octep_vf_set_mac(struct net_device *netdev, void *p)
+{
+	struct octep_vf_device *oct = netdev_priv(netdev);
+	struct sockaddr *addr = (struct sockaddr *)p;
+	int err;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	err = octep_vf_mbox_set_mac_addr(oct, addr->sa_data);
+	if (err)
+		return err;
+
+	memcpy(oct->mac_addr, addr->sa_data, ETH_ALEN);
+	eth_hw_addr_set(netdev, addr->sa_data);
+
+	return 0;
+}
+
+static int octep_vf_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	struct octep_vf_device *oct = netdev_priv(netdev);
+	struct octep_vf_iface_link_info *link_info;
+	int err;
+
+	link_info = &oct->link_info;
+	if (link_info->mtu == new_mtu)
+		return 0;
+
+	err = octep_vf_mbox_set_mtu(oct, new_mtu);
+	if (!err) {
+		oct->link_info.mtu = new_mtu;
+		netdev->mtu = new_mtu;
+	}
+	return err;
+}
+
+static int octep_vf_set_features(struct net_device *netdev,
+				 netdev_features_t features)
+{
+	struct octep_vf_device *oct = netdev_priv(netdev);
+	u16 rx_offloads = 0, tx_offloads = 0;
+	int err;
+
+	/* We only support features received from firmware */
+	if ((features & netdev->hw_features) != features)
+		return -EINVAL;
+
+	if (features & NETIF_F_TSO)
+		tx_offloads |= OCTEP_VF_TX_OFFLOAD_TSO;
+
+	if (features & NETIF_F_TSO6)
+		tx_offloads |= OCTEP_VF_TX_OFFLOAD_TSO;
+
+	if (features & NETIF_F_IP_CSUM)
+		tx_offloads |= OCTEP_VF_TX_OFFLOAD_CKSUM;
+
+	if (features & NETIF_F_IPV6_CSUM)
+		tx_offloads |= OCTEP_VF_TX_OFFLOAD_CKSUM;
+
+	if (features & NETIF_F_RXCSUM)
+		rx_offloads |= OCTEP_VF_RX_OFFLOAD_CKSUM;
+
+	err = octep_vf_mbox_set_offloads(oct, tx_offloads, rx_offloads);
+	if (!err)
+		netdev->features = features;
+
+	return err;
+}
+
 static const struct net_device_ops octep_vf_netdev_ops = {
 	.ndo_open                = octep_vf_open,
 	.ndo_stop                = octep_vf_stop,
 	.ndo_start_xmit          = octep_vf_start_xmit,
 	.ndo_tx_timeout          = octep_vf_tx_timeout,
+	.ndo_set_mac_address     = octep_vf_set_mac,
+	.ndo_change_mtu          = octep_vf_change_mtu,
+	.ndo_set_features        = octep_vf_set_features,
 };
 
 static const char *octep_vf_devid_to_str(struct octep_vf_device *oct)
@@ -412,11 +498,28 @@ static int octep_vf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_mbox_version;
 	}
 
+	if (octep_vf_mbox_get_fw_info(octep_vf_dev)) {
+		dev_err(&pdev->dev, "unable to get fw info\n");
+		err = -EINVAL;
+		goto err_mbox_version;
+	}
+
 	netdev->hw_features = NETIF_F_SG;
+	if (OCTEP_VF_TX_IP_CSUM(octep_vf_dev->fw_info.tx_ol_flags))
+		netdev->hw_features |= (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
+
+	if (OCTEP_VF_RX_IP_CSUM(octep_vf_dev->fw_info.rx_ol_flags))
+		netdev->hw_features |= NETIF_F_RXCSUM;
+
 	netdev->min_mtu = OCTEP_VF_MIN_MTU;
 	netdev->max_mtu = OCTEP_VF_MAX_MTU;
 	netdev->mtu = OCTEP_VF_DEFAULT_MTU;
 
+	if (OCTEP_VF_TX_TSO(octep_vf_dev->fw_info.tx_ol_flags)) {
+		netdev->hw_features |= NETIF_F_TSO;
+		netif_set_tso_max_size(netdev, netdev->max_mtu);
+	}
+
 	netdev->features |= netdev->hw_features;
 	octep_vf_get_mac_addr(octep_vf_dev, octep_vf_dev->mac_addr);
 	eth_hw_addr_set(netdev, octep_vf_dev->mac_addr);
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
index ad1dc0a49614..b3150f977a30 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
@@ -331,6 +331,7 @@ void octep_vf_device_setup_cn93(struct octep_vf_device *oct);
 void octep_vf_device_setup_cnxk(struct octep_vf_device *oct);
 int octep_vf_iq_process_completions(struct octep_vf_iq *iq, u16 budget);
 int octep_vf_oq_process_rx(struct octep_vf_oq *oq, int budget);
+int octep_vf_get_link_info(struct octep_vf_device *oct);
 int octep_vf_get_if_stats(struct octep_vf_device *oct);
 void octep_vf_mbox_work(struct work_struct *work);
 #endif /* _OCTEP_VF_MAIN_H_ */
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c
index 1c1fe293fc50..594bee15bd36 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c
@@ -10,6 +10,15 @@
 #include "octep_vf_config.h"
 #include "octep_vf_main.h"
 
+/* When a new command is implemented, the below table should be updated
+ * with new command and it's version info.
+ */
+static u32 pfvf_cmd_versions[OCTEP_PFVF_MBOX_CMD_MAX] = {
+	[0 ... OCTEP_PFVF_MBOX_CMD_DEV_REMOVE] = OCTEP_PFVF_MBOX_VERSION_V1,
+	[OCTEP_PFVF_MBOX_CMD_GET_FW_INFO ... OCTEP_PFVF_MBOX_NOTIF_LINK_STATUS] =
+		OCTEP_PFVF_MBOX_VERSION_V2
+};
+
 int octep_vf_setup_mbox(struct octep_vf_device *oct)
 {
 	int ring = 0;
@@ -23,6 +32,7 @@ int octep_vf_setup_mbox(struct octep_vf_device *oct)
 	oct->hw_ops.setup_mbox_regs(oct, ring);
 	INIT_WORK(&oct->mbox->wk.work, octep_vf_mbox_work);
 	oct->mbox->wk.ctxptr = oct;
+	oct->mbox_neg_ver = OCTEP_PFVF_MBOX_VERSION_CURRENT;
 	dev_info(&oct->pdev->dev, "setup vf mbox successfully\n");
 	return 0;
 }
@@ -42,55 +52,379 @@ void octep_vf_delete_mbox(struct octep_vf_device *oct)
 
 int octep_vf_mbox_version_check(struct octep_vf_device *oct)
 {
+	union octep_pfvf_mbox_word cmd;
+	union octep_pfvf_mbox_word rsp;
+	int ret;
+
+	cmd.u64 = 0;
+	cmd.s_version.opcode = OCTEP_PFVF_MBOX_CMD_VERSION;
+	cmd.s_version.version = OCTEP_PFVF_MBOX_VERSION_CURRENT;
+	ret = octep_vf_mbox_send_cmd(oct, cmd, &rsp);
+	if (ret == OCTEP_PFVF_MBOX_CMD_STATUS_NACK) {
+		dev_err(&oct->pdev->dev,
+			"VF Mbox version is incompatible with PF\n");
+		return -EINVAL;
+	}
+	oct->mbox_neg_ver = (u32)rsp.s_version.version;
+	dev_dbg(&oct->pdev->dev,
+		"VF Mbox version:%u Negotiated VF version with PF:%u\n",
+		 (u32)cmd.s_version.version,
+		 (u32)rsp.s_version.version);
 	return 0;
 }
 
 void octep_vf_mbox_work(struct work_struct *work)
 {
+	struct octep_vf_mbox_wk *wk = container_of(work, struct octep_vf_mbox_wk, work);
+	struct octep_vf_iface_link_info *link_info;
+	struct octep_vf_device *oct = NULL;
+	struct octep_vf_mbox *mbox = NULL;
+	union octep_pfvf_mbox_word *notif;
+	u64 pf_vf_data;
+
+	oct = (struct octep_vf_device *)wk->ctxptr;
+	link_info = &oct->link_info;
+	mbox = oct->mbox;
+	pf_vf_data = readq(mbox->mbox_read_reg);
+
+	notif = (union octep_pfvf_mbox_word *)&pf_vf_data;
+
+	switch (notif->s.opcode) {
+	case OCTEP_PFVF_MBOX_NOTIF_LINK_STATUS:
+		if (notif->s_link_status.status) {
+			link_info->oper_up = OCTEP_PFVF_LINK_STATUS_UP;
+			netif_carrier_on(oct->netdev);
+			dev_info(&oct->pdev->dev, "netif_carrier_on\n");
+		} else {
+			link_info->oper_up = OCTEP_PFVF_LINK_STATUS_DOWN;
+			netif_carrier_off(oct->netdev);
+			dev_info(&oct->pdev->dev, "netif_carrier_off\n");
+		}
+		break;
+	default:
+		dev_err(&oct->pdev->dev,
+			"Received unsupported notif %d\n", notif->s.opcode);
+		break;
+	}
+}
+
+static int __octep_vf_mbox_send_cmd(struct octep_vf_device *oct,
+				    union octep_pfvf_mbox_word cmd,
+				    union octep_pfvf_mbox_word *rsp)
+{
+	struct octep_vf_mbox *mbox = oct->mbox;
+	u64 reg_val = 0ull;
+	int count = 0;
+
+	if (!mbox)
+		return OCTEP_PFVF_MBOX_CMD_STATUS_NOT_SETUP;
+
+	cmd.s.type = OCTEP_PFVF_MBOX_TYPE_CMD;
+	writeq(cmd.u64, mbox->mbox_write_reg);
+
+	/* No response for notification messages */
+	if (!rsp)
+		return 0;
+
+	for (count = 0; count < OCTEP_PFVF_MBOX_TIMEOUT_WAIT_COUNT; count++) {
+		usleep_range(1000, 1500);
+		reg_val = readq(mbox->mbox_write_reg);
+		if (reg_val != cmd.u64) {
+			rsp->u64 = reg_val;
+			break;
+		}
+	}
+	if (count == OCTEP_PFVF_MBOX_TIMEOUT_WAIT_COUNT) {
+		dev_err(&oct->pdev->dev, "mbox send command timed out\n");
+		return OCTEP_PFVF_MBOX_CMD_STATUS_TIMEDOUT;
+	}
+	if (rsp->s.type != OCTEP_PFVF_MBOX_TYPE_RSP_ACK) {
+		dev_err(&oct->pdev->dev, "mbox_send: Received NACK\n");
+		return OCTEP_PFVF_MBOX_CMD_STATUS_NACK;
+	}
+	rsp->u64 = reg_val;
+	return 0;
+}
+
+int octep_vf_mbox_send_cmd(struct octep_vf_device *oct, union octep_pfvf_mbox_word cmd,
+			   union octep_pfvf_mbox_word *rsp)
+{
+	struct octep_vf_mbox *mbox = oct->mbox;
+	int ret;
+
+	if (!mbox)
+		return OCTEP_PFVF_MBOX_CMD_STATUS_NOT_SETUP;
+	mutex_lock(&mbox->lock);
+	if (pfvf_cmd_versions[cmd.s.opcode] > oct->mbox_neg_ver) {
+		dev_dbg(&oct->pdev->dev, "CMD:%d not supported in Version:%d\n",
+			cmd.s.opcode, oct->mbox_neg_ver);
+		mutex_unlock(&mbox->lock);
+		return -EOPNOTSUPP;
+	}
+	ret = __octep_vf_mbox_send_cmd(oct, cmd, rsp);
+	mutex_unlock(&mbox->lock);
+	return ret;
+}
+
+int octep_vf_mbox_bulk_read(struct octep_vf_device *oct, enum octep_pfvf_mbox_opcode opcode,
+			    u8 *data, int *size)
+{
+	struct octep_vf_mbox *mbox = oct->mbox;
+	union octep_pfvf_mbox_word cmd;
+	union octep_pfvf_mbox_word rsp;
+	int data_len = 0, tmp_len = 0;
+	int read_cnt, i = 0, ret;
+
+	if (!mbox)
+		return OCTEP_PFVF_MBOX_CMD_STATUS_NOT_SETUP;
+
+	mutex_lock(&mbox->lock);
+	cmd.u64 = 0;
+	cmd.s_data.opcode = opcode;
+	cmd.s_data.frag = 0;
+	/* Send cmd to read data from PF */
+	ret = __octep_vf_mbox_send_cmd(oct, cmd, &rsp);
+	if (ret) {
+		dev_err(&oct->pdev->dev, "send mbox cmd fail for data request\n");
+		mutex_unlock(&mbox->lock);
+		return ret;
+	}
+	/*  PF sends the data length of requested CMD
+	 *  in  ACK
+	 */
+	data_len = *((int32_t *)rsp.s_data.data);
+	tmp_len = data_len;
+	cmd.u64 = 0;
+	rsp.u64 = 0;
+	cmd.s_data.opcode = opcode;
+	cmd.s_data.frag = 1;
+	while (data_len) {
+		ret = __octep_vf_mbox_send_cmd(oct, cmd, &rsp);
+		if (ret) {
+			dev_err(&oct->pdev->dev, "send mbox cmd fail for data request\n");
+			mutex_unlock(&mbox->lock);
+			mbox->mbox_data.data_index = 0;
+			memset(mbox->mbox_data.recv_data, 0, OCTEP_PFVF_MBOX_MAX_DATA_BUF_SIZE);
+			return ret;
+		}
+		if (data_len > OCTEP_PFVF_MBOX_MAX_DATA_SIZE) {
+			data_len -= OCTEP_PFVF_MBOX_MAX_DATA_SIZE;
+			read_cnt = OCTEP_PFVF_MBOX_MAX_DATA_SIZE;
+		} else {
+			read_cnt = data_len;
+			data_len = 0;
+		}
+		for (i = 0; i < read_cnt; i++) {
+			mbox->mbox_data.recv_data[mbox->mbox_data.data_index] =
+				rsp.s_data.data[i];
+			mbox->mbox_data.data_index++;
+		}
+		cmd.u64 = 0;
+		rsp.u64 = 0;
+		cmd.s_data.opcode = opcode;
+		cmd.s_data.frag = 1;
+	}
+	memcpy(data, mbox->mbox_data.recv_data, tmp_len);
+	*size = tmp_len;
+	mbox->mbox_data.data_index = 0;
+	memset(mbox->mbox_data.recv_data, 0, OCTEP_PFVF_MBOX_MAX_DATA_BUF_SIZE);
+	mutex_unlock(&mbox->lock);
+	return 0;
 }
 
 int octep_vf_mbox_set_mtu(struct octep_vf_device *oct, int mtu)
 {
+	int frame_size = mtu + ETH_HLEN + ETH_FCS_LEN;
+	union octep_pfvf_mbox_word cmd;
+	union octep_pfvf_mbox_word rsp;
+	int ret = 0;
+
+	if (mtu < ETH_MIN_MTU || frame_size > ETH_MAX_MTU) {
+		dev_err(&oct->pdev->dev,
+			"Failed to set MTU to %d MIN MTU:%d MAX MTU:%d\n",
+			mtu, ETH_MIN_MTU, ETH_MAX_MTU);
+		return -EINVAL;
+	}
+
+	cmd.u64 = 0;
+	cmd.s_set_mtu.opcode = OCTEP_PFVF_MBOX_CMD_SET_MTU;
+	cmd.s_set_mtu.mtu = mtu;
+
+	ret = octep_vf_mbox_send_cmd(oct, cmd, &rsp);
+	if (ret) {
+		dev_err(&oct->pdev->dev, "Mbox send failed; err=%d\n", ret);
+		return ret;
+	}
+	if (rsp.s_set_mtu.type != OCTEP_PFVF_MBOX_TYPE_RSP_ACK) {
+		dev_err(&oct->pdev->dev, "Received Mbox NACK from PF for MTU:%d\n", mtu);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
 int octep_vf_mbox_set_mac_addr(struct octep_vf_device *oct, char *mac_addr)
 {
+	union octep_pfvf_mbox_word cmd;
+	union octep_pfvf_mbox_word rsp;
+	int i, ret;
+
+	cmd.u64 = 0;
+	cmd.s_set_mac.opcode = OCTEP_PFVF_MBOX_CMD_SET_MAC_ADDR;
+	for (i = 0; i < ETH_ALEN; i++)
+		cmd.s_set_mac.mac_addr[i] = mac_addr[i];
+	ret = octep_vf_mbox_send_cmd(oct, cmd, &rsp);
+	if (ret) {
+		dev_err(&oct->pdev->dev, "Mbox send failed; err = %d\n", ret);
+		return ret;
+	}
+	if (rsp.s_set_mac.type != OCTEP_PFVF_MBOX_TYPE_RSP_ACK) {
+		dev_err(&oct->pdev->dev, "received NACK\n");
+		return -EINVAL;
+	}
 	return 0;
 }
 
 int octep_vf_mbox_get_mac_addr(struct octep_vf_device *oct, char *mac_addr)
 {
+	union octep_pfvf_mbox_word cmd;
+	union octep_pfvf_mbox_word rsp;
+	int i, ret;
+
+	cmd.u64 = 0;
+	cmd.s_set_mac.opcode = OCTEP_PFVF_MBOX_CMD_GET_MAC_ADDR;
+	ret = octep_vf_mbox_send_cmd(oct, cmd, &rsp);
+	if (ret) {
+		dev_err(&oct->pdev->dev, "get_mac: mbox send failed; err = %d\n", ret);
+		return ret;
+	}
+	if (rsp.s_set_mac.type != OCTEP_PFVF_MBOX_TYPE_RSP_ACK) {
+		dev_err(&oct->pdev->dev, "get_mac: received NACK\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < ETH_ALEN; i++)
+		mac_addr[i] = rsp.s_set_mac.mac_addr[i];
 	return 0;
 }
 
 int octep_vf_mbox_set_rx_state(struct octep_vf_device *oct, bool state)
 {
+	union octep_pfvf_mbox_word cmd;
+	union octep_pfvf_mbox_word rsp;
+	int ret;
+
+	cmd.u64 = 0;
+	cmd.s_link_state.opcode = OCTEP_PFVF_MBOX_CMD_SET_RX_STATE;
+	cmd.s_link_state.state = state;
+	ret = octep_vf_mbox_send_cmd(oct, cmd, &rsp);
+	if (ret) {
+		dev_err(&oct->pdev->dev, "Set Rx state via VF Mbox send failed\n");
+		return ret;
+	}
+	if (rsp.s_link_state.type != OCTEP_PFVF_MBOX_TYPE_RSP_ACK) {
+		dev_err(&oct->pdev->dev, "Set Rx state received NACK\n");
+		return -EINVAL;
+	}
 	return 0;
 }
 
 int octep_vf_mbox_set_link_status(struct octep_vf_device *oct, bool status)
 {
+	union octep_pfvf_mbox_word cmd;
+	union octep_pfvf_mbox_word rsp;
+	int ret;
+
+	cmd.u64 = 0;
+	cmd.s_link_status.opcode = OCTEP_PFVF_MBOX_CMD_SET_LINK_STATUS;
+	cmd.s_link_status.status = status;
+	ret = octep_vf_mbox_send_cmd(oct, cmd, &rsp);
+	if (ret) {
+		dev_err(&oct->pdev->dev, "Set link status via VF Mbox send failed\n");
+		return ret;
+	}
+	if (rsp.s_link_status.type != OCTEP_PFVF_MBOX_TYPE_RSP_ACK) {
+		dev_err(&oct->pdev->dev, "Set link status received NACK\n");
+		return -EINVAL;
+	}
 	return 0;
 }
 
 int octep_vf_mbox_get_link_status(struct octep_vf_device *oct, u8 *oper_up)
 {
+	union octep_pfvf_mbox_word cmd;
+	union octep_pfvf_mbox_word rsp;
+	int ret;
+
+	cmd.u64 = 0;
+	cmd.s_link_status.opcode = OCTEP_PFVF_MBOX_CMD_GET_LINK_STATUS;
+	ret = octep_vf_mbox_send_cmd(oct, cmd, &rsp);
+	if (ret) {
+		dev_err(&oct->pdev->dev, "Get link status via VF Mbox send failed\n");
+		return ret;
+	}
+	if (rsp.s_link_status.type != OCTEP_PFVF_MBOX_TYPE_RSP_ACK) {
+		dev_err(&oct->pdev->dev, "Get link status received NACK\n");
+		return -EINVAL;
+	}
+	*oper_up = rsp.s_link_status.status;
 	return 0;
 }
 
 int octep_vf_mbox_dev_remove(struct octep_vf_device *oct)
 {
-	return 0;
+	union octep_pfvf_mbox_word cmd;
+	int ret;
+
+	cmd.u64 = 0;
+	cmd.s.opcode = OCTEP_PFVF_MBOX_CMD_DEV_REMOVE;
+	ret = octep_vf_mbox_send_cmd(oct, cmd, NULL);
+	return ret;
 }
 
 int octep_vf_mbox_get_fw_info(struct octep_vf_device *oct)
 {
+	union octep_pfvf_mbox_word cmd;
+	union octep_pfvf_mbox_word rsp;
+	int ret;
+
+	cmd.u64 = 0;
+	cmd.s_fw_info.opcode = OCTEP_PFVF_MBOX_CMD_GET_FW_INFO;
+	ret = octep_vf_mbox_send_cmd(oct, cmd, &rsp);
+	if (ret) {
+		dev_err(&oct->pdev->dev, "Get link status via VF Mbox send failed\n");
+		return ret;
+	}
+	if (rsp.s_fw_info.type != OCTEP_PFVF_MBOX_TYPE_RSP_ACK) {
+		dev_err(&oct->pdev->dev, "Get link status received NACK\n");
+		return -EINVAL;
+	}
+	oct->fw_info.pkind = rsp.s_fw_info.pkind;
+	oct->fw_info.fsz = rsp.s_fw_info.fsz;
+	oct->fw_info.rx_ol_flags = rsp.s_fw_info.rx_ol_flags;
+	oct->fw_info.tx_ol_flags = rsp.s_fw_info.tx_ol_flags;
+
 	return 0;
 }
 
 int octep_vf_mbox_set_offloads(struct octep_vf_device *oct, u16 tx_offloads,
 			       u16 rx_offloads)
 {
+	union octep_pfvf_mbox_word cmd;
+	union octep_pfvf_mbox_word rsp;
+	int ret;
+
+	cmd.u64 = 0;
+	cmd.s_offloads.opcode = OCTEP_PFVF_MBOX_CMD_SET_OFFLOADS;
+	cmd.s_offloads.rx_ol_flags = rx_offloads;
+	cmd.s_offloads.tx_ol_flags = tx_offloads;
+	ret = octep_vf_mbox_send_cmd(oct, cmd, &rsp);
+	if (ret) {
+		dev_err(&oct->pdev->dev, "Set offloads via VF Mbox send failed\n");
+		return ret;
+	}
+	if (rsp.s_link_state.type != OCTEP_PFVF_MBOX_TYPE_RSP_ACK) {
+		dev_err(&oct->pdev->dev, "Set offloads received NACK\n");
+		return -EINVAL;
+	}
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.h b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.h
index 14f4fb19445b..9b5efad37eab 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.h
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.h
@@ -7,10 +7,151 @@
 #ifndef _OCTEP_VF_MBOX_H_
 #define _OCTEP_VF_MBOX_H_
 
-#define OCTEP_PFVF_MBOX_MAX_DATA_BUF_SIZE 256
+/* When a new command is implemented, VF Mbox version should be bumped.
+ */
+enum octep_pfvf_mbox_version {
+	OCTEP_PFVF_MBOX_VERSION_V0,
+	OCTEP_PFVF_MBOX_VERSION_V1,
+	OCTEP_PFVF_MBOX_VERSION_V2
+};
+
+#define OCTEP_PFVF_MBOX_VERSION_CURRENT OCTEP_PFVF_MBOX_VERSION_V2
+
+enum octep_pfvf_mbox_opcode {
+	OCTEP_PFVF_MBOX_CMD_VERSION,
+	OCTEP_PFVF_MBOX_CMD_SET_MTU,
+	OCTEP_PFVF_MBOX_CMD_SET_MAC_ADDR,
+	OCTEP_PFVF_MBOX_CMD_GET_MAC_ADDR,
+	OCTEP_PFVF_MBOX_CMD_GET_LINK_INFO,
+	OCTEP_PFVF_MBOX_CMD_GET_STATS,
+	OCTEP_PFVF_MBOX_CMD_SET_RX_STATE,
+	OCTEP_PFVF_MBOX_CMD_SET_LINK_STATUS,
+	OCTEP_PFVF_MBOX_CMD_GET_LINK_STATUS,
+	OCTEP_PFVF_MBOX_CMD_GET_MTU,
+	OCTEP_PFVF_MBOX_CMD_DEV_REMOVE,
+	OCTEP_PFVF_MBOX_CMD_GET_FW_INFO,
+	OCTEP_PFVF_MBOX_CMD_SET_OFFLOADS,
+	OCTEP_PFVF_MBOX_NOTIF_LINK_STATUS,
+	OCTEP_PFVF_MBOX_CMD_MAX,
+};
+
+enum octep_pfvf_mbox_word_type {
+	OCTEP_PFVF_MBOX_TYPE_CMD,
+	OCTEP_PFVF_MBOX_TYPE_RSP_ACK,
+	OCTEP_PFVF_MBOX_TYPE_RSP_NACK,
+};
+
+enum octep_pfvf_mbox_cmd_status {
+	OCTEP_PFVF_MBOX_CMD_STATUS_NOT_SETUP = 1,
+	OCTEP_PFVF_MBOX_CMD_STATUS_TIMEDOUT = 2,
+	OCTEP_PFVF_MBOX_CMD_STATUS_NACK = 3,
+	OCTEP_PFVF_MBOX_CMD_STATUS_BUSY = 4,
+	OCTEP_PFVF_MBOX_CMD_STATUS_ERR = 5
+};
+
+enum octep_pfvf_link_status {
+	OCTEP_PFVF_LINK_STATUS_DOWN,
+	OCTEP_PFVF_LINK_STATUS_UP,
+};
+
+enum octep_pfvf_link_speed {
+	OCTEP_PFVF_LINK_SPEED_NONE,
+	OCTEP_PFVF_LINK_SPEED_1000,
+	OCTEP_PFVF_LINK_SPEED_10000,
+	OCTEP_PFVF_LINK_SPEED_25000,
+	OCTEP_PFVF_LINK_SPEED_40000,
+	OCTEP_PFVF_LINK_SPEED_50000,
+	OCTEP_PFVF_LINK_SPEED_100000,
+	OCTEP_PFVF_LINK_SPEED_LAST,
+};
+
+enum octep_pfvf_link_duplex {
+	OCTEP_PFVF_LINK_HALF_DUPLEX,
+	OCTEP_PFVF_LINK_FULL_DUPLEX,
+};
+
+enum octep_pfvf_link_autoneg {
+	OCTEP_PFVF_LINK_AUTONEG,
+	OCTEP_PFVF_LINK_FIXED,
+};
+
+#define OCTEP_PFVF_MBOX_TIMEOUT_WAIT_COUNT  8000
+#define OCTEP_PFVF_MBOX_TIMEOUT_WAIT_UDELAY 1000
+#define OCTEP_PFVF_MBOX_MAX_RETRIES    2
+#define OCTEP_PFVF_MBOX_VERSION        0
+#define OCTEP_PFVF_MBOX_MAX_DATA_SIZE  6
+#define OCTEP_PFVF_MBOX_MAX_DATA_BUF_SIZE 320
+#define OCTEP_PFVF_MBOX_MORE_FRAG_FLAG 1
+
+union octep_pfvf_mbox_word {
+	u64 u64;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 rsvd:6;
+		u64 data:48;
+	} s;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 frag:1;
+		u64 rsvd:5;
+		u8 data[6];
+	} s_data;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 rsvd:6;
+		u64 version:48;
+	} s_version;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 rsvd:6;
+		u8 mac_addr[6];
+	} s_set_mac;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 rsvd:6;
+		u64 mtu:48;
+	} s_set_mtu;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 state:1;
+		u64 rsvd:53;
+	} s_link_state;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 status:1;
+		u64 rsvd:53;
+	} s_link_status;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 pkind:8;
+		u64 fsz:8;
+		u64 rx_ol_flags:16;
+		u64 tx_ol_flags:16;
+		u64 rsvd:6;
+	} s_fw_info;
+	struct {
+		u64 opcode:8;
+		u64 type:2;
+		u64 rsvd:22;
+		u64 rx_ol_flags:16;
+		u64 tx_ol_flags:16;
+	} s_offloads;
+} __packed;
 
 int octep_vf_setup_mbox(struct octep_vf_device *oct);
 void octep_vf_delete_mbox(struct octep_vf_device *oct);
+int octep_vf_mbox_send_cmd(struct octep_vf_device *oct, union octep_pfvf_mbox_word cmd,
+			   union octep_pfvf_mbox_word *rsp);
+int octep_vf_mbox_bulk_read(struct octep_vf_device *oct, enum octep_pfvf_mbox_opcode opcode,
+			    u8 *data, int *size);
 int octep_vf_mbox_set_mtu(struct octep_vf_device *oct, int mtu);
 int octep_vf_mbox_set_mac_addr(struct octep_vf_device *oct, char *mac_addr);
 int octep_vf_mbox_get_mac_addr(struct octep_vf_device *oct, char *mac_addr);
-- 
2.25.1


