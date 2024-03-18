Return-Path: <linux-kernel+bounces-106227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A71F87EB07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897A71C20404
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC4A50A73;
	Mon, 18 Mar 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrUpENqy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A634F618
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772281; cv=none; b=s9X6jqUufaJWmzoyJflCmhH6WyJ5EKpLuIbofU65eI6/Piofz+FmNstEFOUmyTZLglk5N5kyh45dWX17dWtToesI4iyjC9SU1TflgHT3pCsCBLiIP7qr6n85+JQzYvr7/sR+xi4dALwRk1p1f9YA904VnQbMMvXneXUlv+Ikv3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772281; c=relaxed/simple;
	bh=MtBHu+UOt+ZCPg+vHX7Mt20fqZQ6/IhK8AO4sryuZU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyNECfeI3a7+JnbnmfwpV0mQahmKw7NUox2LZHRPVdwUlDgBuWaopYUHjxYR+geGQpBDgtMPGmJZz57GjHjvu8piXOS6c9SIAMdwEoXqv4Ma0iZSLgfk3Ws3VlV9RweGiDQV+sVi5GhPgnYe4l/CAjR46HGXX+U0NPBZjFhkbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TrUpENqy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710772278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0e0lo0ew3R6NNXhLHenp0w8n/PoyZNFueS8BT8yheg=;
	b=TrUpENqy2iqbqLl1iNoUmyPFTMJRUnI+I+01NNutihEQxo7Zp0QTDrzbh2q3RzsSiAfH0/
	aeRAHqFwAo2PKha4yZDjAP3XiClBnGHKzkWr8WVWCRdUnI9DBeqUo2HomGv4VWc1Qu1ka7
	C1Ac/4SRGAm+NPyELAA5SlmPkCNdJjI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-MF2FQNlOMTC8ilijBtqnCw-1; Mon, 18 Mar 2024 10:31:14 -0400
X-MC-Unique: MF2FQNlOMTC8ilijBtqnCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB79A101A526;
	Mon, 18 Mar 2024 14:31:13 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.33])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1BCDA112132A;
	Mon, 18 Mar 2024 14:31:12 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-next 4/7] i40e: Add helper to access main VSI
Date: Mon, 18 Mar 2024 15:30:48 +0100
Message-ID: <20240318143058.287014-5-ivecera@redhat.com>
In-Reply-To: <20240318143058.287014-1-ivecera@redhat.com>
References: <20240318143058.287014-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Add simple helper i40e_pf_get_main_vsi(pf) to access main VSI
that replaces pattern 'pf->vsi[pf->lan_vsi]'

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  11 ++
 drivers/net/ethernet/intel/i40e/i40e_client.c |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   3 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  32 +++---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 107 ++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   8 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  14 ++-
 9 files changed, 116 insertions(+), 83 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 0792c7324527..fb0b913692e1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1372,6 +1372,17 @@ i40e_pf_get_vsi_by_seid(struct i40e_pf *pf, u16 seid)
 	return NULL;
 }
 
+/**
+ * i40e_pf_get_main_vsi - get pointer to main VSI
+ * @pf: pointer to a PF
+ *
+ * Return pointer to main VSI or NULL if it does not exist
+ **/
+static inline struct i40e_vsi *i40e_pf_get_main_vsi(struct i40e_pf *pf)
+{
+	return (pf->lan_vsi != I40E_NO_VSI) ? pf->vsi[pf->lan_vsi] : NULL;
+}
+
 /**
  * i40e_pf_get_veb_by_seid - find VEB by SEID
  * @pf: pointer to a PF
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 93e52138826e..59263551c383 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -107,8 +107,8 @@ i40e_notify_client_of_vf_msg(struct i40e_vsi *vsi, u32 vf_id, u8 *msg, u16 len)
  **/
 void i40e_notify_client_of_l2_param_changes(struct i40e_pf *pf)
 {
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
 	struct i40e_client_instance *cdev = pf->cinst;
-	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 	struct i40e_params params;
 
 	if (!cdev || !cdev->client)
@@ -333,9 +333,9 @@ static int i40e_register_auxiliary_dev(struct i40e_info *ldev, const char *name)
  **/
 static void i40e_client_add_instance(struct i40e_pf *pf)
 {
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
 	struct i40e_client_instance *cdev = NULL;
 	struct netdev_hw_addr *mac = NULL;
-	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 
 	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
@@ -399,9 +399,9 @@ void i40e_client_del_instance(struct i40e_pf *pf)
  **/
 void i40e_client_subtask(struct i40e_pf *pf)
 {
-	struct i40e_client *client;
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
 	struct i40e_client_instance *cdev;
-	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
+	struct i40e_client *client;
 	int ret = 0;
 
 	if (!test_and_clear_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf->state))
@@ -665,8 +665,8 @@ static int i40e_client_update_vsi_ctxt(struct i40e_info *ldev,
 				       bool is_vf, u32 vf_id,
 				       u32 flag, u32 valid_flag)
 {
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(ldev->pf);
 	struct i40e_pf *pf = ldev->pf;
-	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 	struct i40e_vsi_context ctxt;
 	bool update = true;
 	int err;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index 2f53f0f53bc3..daa9f2c42f70 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -407,8 +407,9 @@ static int i40e_ddp_load(struct net_device *netdev, const u8 *data, size_t size,
  **/
 static int i40e_ddp_restore(struct i40e_pf *pf)
 {
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
+	struct net_device *netdev = vsi->netdev;
 	struct i40e_ddp_old_profile_list *entry;
-	struct net_device *netdev = pf->vsi[pf->lan_vsi]->netdev;
 	int status = 0;
 
 	if (!list_empty(&pf->ddp_old_prof)) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 6147c5f128e8..09db46de2994 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -53,6 +53,7 @@ static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
 				     size_t count, loff_t *ppos)
 {
 	struct i40e_pf *pf = filp->private_data;
+	struct i40e_vsi *main_vsi;
 	int bytes_not_copied;
 	int buf_size = 256;
 	char *buf;
@@ -68,8 +69,8 @@ static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
 	if (!buf)
 		return -ENOSPC;
 
-	len = snprintf(buf, buf_size, "%s: %s\n",
-		       pf->vsi[pf->lan_vsi]->netdev->name,
+	main_vsi = i40e_pf_get_main_vsi(pf);
+	len = snprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
 		       i40e_dbg_command_buf);
 
 	bytes_not_copied = copy_to_user(buffer, buf, len);
@@ -786,7 +787,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		cnt = sscanf(&cmd_buf[7], "%i", &vsi_seid);
 		if (cnt == 0) {
 			/* default to PF VSI */
-			vsi_seid = pf->vsi[pf->lan_vsi]->seid;
+			vsi = i40e_pf_get_main_vsi(pf);
+			vsi_seid = vsi->seid;
 		} else if (vsi_seid < 0) {
 			dev_info(&pf->pdev->dev, "add VSI %d: bad vsi seid\n",
 				 vsi_seid);
@@ -1030,7 +1032,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 				goto command_write_done;
 			}
 
-			vsi = pf->vsi[pf->lan_vsi];
+			vsi = i40e_pf_get_main_vsi(pf);
 			switch_id =
 				le16_to_cpu(vsi->info.switch_id) &
 					    I40E_AQ_VSI_SW_ID_MASK;
@@ -1380,6 +1382,9 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		dev_info(&pf->pdev->dev, "FD current total filter count for this interface: %d\n",
 			 i40e_get_current_fd_count(pf));
 	} else if (strncmp(cmd_buf, "lldp", 4) == 0) {
+		/* Get main VSI */
+		struct i40e_vsi *main_vsi = i40e_pf_get_main_vsi(pf);
+
 		if (strncmp(&cmd_buf[5], "stop", 4) == 0) {
 			int ret;
 
@@ -1391,10 +1396,9 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 				goto command_write_done;
 			}
 			ret = i40e_aq_add_rem_control_packet_filter(&pf->hw,
-						pf->hw.mac.addr,
-						ETH_P_LLDP, 0,
-						pf->vsi[pf->lan_vsi]->seid,
-						0, true, NULL, NULL);
+						pf->hw.mac.addr, ETH_P_LLDP, 0,
+						main_vsi->seid, 0, true, NULL,
+						NULL);
 			if (ret) {
 				dev_info(&pf->pdev->dev,
 					"%s: Add Control Packet Filter AQ command failed =0x%x\n",
@@ -1409,10 +1413,9 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			int ret;
 
 			ret = i40e_aq_add_rem_control_packet_filter(&pf->hw,
-						pf->hw.mac.addr,
-						ETH_P_LLDP, 0,
-						pf->vsi[pf->lan_vsi]->seid,
-						0, false, NULL, NULL);
+						pf->hw.mac.addr, ETH_P_LLDP, 0,
+						main_vsi->seid, 0, false, NULL,
+						NULL);
 			if (ret) {
 				dev_info(&pf->pdev->dev,
 					"%s: Remove Control Packet Filter AQ command failed =0x%x\n",
@@ -1639,6 +1642,7 @@ static ssize_t i40e_dbg_netdev_ops_read(struct file *filp, char __user *buffer,
 					size_t count, loff_t *ppos)
 {
 	struct i40e_pf *pf = filp->private_data;
+	struct i40e_vsi *main_vsi;
 	int bytes_not_copied;
 	int buf_size = 256;
 	char *buf;
@@ -1654,8 +1658,8 @@ static ssize_t i40e_dbg_netdev_ops_read(struct file *filp, char __user *buffer,
 	if (!buf)
 		return -ENOSPC;
 
-	len = snprintf(buf, buf_size, "%s: %s\n",
-		       pf->vsi[pf->lan_vsi]->netdev->name,
+	main_vsi = i40e_pf_get_main_vsi(pf);
+	len = snprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
 		       i40e_dbg_netdev_ops_buf);
 
 	bytes_not_copied = copy_to_user(buffer, buf, len);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 42e7e6cdaa6d..0905c1fb2337 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2029,7 +2029,7 @@ static void i40e_get_ringparam(struct net_device *netdev,
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_pf *pf = np->vsi->back;
-	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
 
 	ring->rx_max_pending = i40e_get_max_num_descriptors(pf);
 	ring->tx_max_pending = i40e_get_max_num_descriptors(pf);
@@ -3370,6 +3370,7 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_pf *pf,
 	struct i40e_rx_flow_userdef userdef = {0};
 	struct i40e_fdir_filter *rule = NULL;
 	struct hlist_node *node2;
+	struct i40e_vsi *vsi;
 	u64 input_set;
 	u16 index;
 
@@ -3493,9 +3494,8 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_pf *pf,
 		fsp->flow_type |= FLOW_EXT;
 	}
 
-	if (rule->dest_vsi != pf->vsi[pf->lan_vsi]->id) {
-		struct i40e_vsi *vsi;
-
+	vsi = i40e_pf_get_main_vsi(pf);
+	if (rule->dest_vsi != vsi->id) {
 		vsi = i40e_find_vsi_from_id(pf, rule->dest_vsi);
 		if (vsi && vsi->type == I40E_VSI_SRIOV) {
 			/* VFs are zero-indexed by the driver, but ethtool
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1ba28893f49e..86bc3fc0579b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2475,7 +2475,7 @@ i40e_aqc_broadcast_filter(struct i40e_vsi *vsi, const char *vsi_name,
  **/
 static int i40e_set_promiscuous(struct i40e_pf *pf, bool promisc)
 {
-	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
 	struct i40e_hw *hw = &pf->hw;
 	int aq_ret;
 
@@ -4330,7 +4330,7 @@ static irqreturn_t i40e_intr(int irq, void *data)
 
 	/* only q0 is used in MSI/Legacy mode, and none are used in MSIX */
 	if (icr0 & I40E_PFINT_ICR0_QUEUE_0_MASK) {
-		struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
+		struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
 		struct i40e_q_vector *q_vector = vsi->q_vectors[0];
 
 		/* We do not have a way to disarm Queue causes while leaving
@@ -5480,7 +5480,7 @@ static u8 i40e_dcb_get_enabled_tc(struct i40e_dcbx_config *dcbcfg)
  **/
 static u8 i40e_mqprio_get_enabled_tc(struct i40e_pf *pf)
 {
-	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
 	u8 num_tc = vsi->mqprio_qopt.qopt.num_tc;
 	u8 enabled_tc = 1, i;
 
@@ -5497,13 +5497,14 @@ static u8 i40e_mqprio_get_enabled_tc(struct i40e_pf *pf)
  **/
 static u8 i40e_pf_get_num_tc(struct i40e_pf *pf)
 {
-	struct i40e_hw *hw = &pf->hw;
 	u8 i, enabled_tc = 1;
 	u8 num_tc = 0;
-	struct i40e_dcbx_config *dcbcfg = &hw->local_dcbx_config;
 
-	if (i40e_is_tc_mqprio_enabled(pf))
-		return pf->vsi[pf->lan_vsi]->mqprio_qopt.qopt.num_tc;
+	if (i40e_is_tc_mqprio_enabled(pf)) {
+		struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
+
+		return vsi->mqprio_qopt.qopt.num_tc;
+	}
 
 	/* If neither MQPRIO nor DCB is enabled, then always use single TC */
 	if (!test_bit(I40E_FLAG_DCB_ENA, pf->flags))
@@ -5511,7 +5512,7 @@ static u8 i40e_pf_get_num_tc(struct i40e_pf *pf)
 
 	/* SFP mode will be enabled for all TCs on port */
 	if (!test_bit(I40E_FLAG_MFP_ENA, pf->flags))
-		return i40e_dcb_get_num_tc(dcbcfg);
+		return i40e_dcb_get_num_tc(&pf->hw.local_dcbx_config);
 
 	/* MFP mode return count of enabled TCs for this PF */
 	if (pf->hw.func_caps.iscsi)
@@ -6485,6 +6486,7 @@ static inline int i40e_setup_hw_channel(struct i40e_pf *pf,
 static bool i40e_setup_channel(struct i40e_pf *pf, struct i40e_vsi *vsi,
 			       struct i40e_channel *ch)
 {
+	struct i40e_vsi *main_vsi;
 	u8 vsi_type;
 	u16 seid;
 	int ret;
@@ -6498,7 +6500,8 @@ static bool i40e_setup_channel(struct i40e_pf *pf, struct i40e_vsi *vsi,
 	}
 
 	/* underlying switching element */
-	seid = pf->vsi[pf->lan_vsi]->uplink_seid;
+	main_vsi = i40e_pf_get_main_vsi(pf);
+	seid = main_vsi->uplink_seid;
 
 	/* create channel (VSI), configure TX rings */
 	ret = i40e_setup_hw_channel(pf, vsi, ch, seid, vsi_type);
@@ -7055,7 +7058,9 @@ int i40e_hw_dcb_config(struct i40e_pf *pf, struct i40e_dcbx_config *new_cfg)
 
 	/* Configure Rx Packet Buffers in HW */
 	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
-		mfs_tc[i] = pf->vsi[pf->lan_vsi]->netdev->mtu;
+		struct i40e_vsi *main_vsi = i40e_pf_get_main_vsi(pf);
+
+		mfs_tc[i] = main_vsi->netdev->mtu;
 		mfs_tc[i] += I40E_PACKET_HDR_PAD;
 	}
 
@@ -9812,7 +9817,7 @@ static void i40e_fdir_flush_and_replay(struct i40e_pf *pf)
 		dev_warn(&pf->pdev->dev, "FD table did not flush, needs more time\n");
 	} else {
 		/* replay sideband filters */
-		i40e_fdir_filter_restore(pf->vsi[pf->lan_vsi]);
+		i40e_fdir_filter_restore(i40e_pf_get_main_vsi(pf));
 		if (!disable_atr && !pf->fd_tcp4_filter_cnt)
 			clear_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
 		clear_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
@@ -9910,7 +9915,7 @@ static void i40e_veb_link_event(struct i40e_veb *veb, bool link_up)
  **/
 static void i40e_link_event(struct i40e_pf *pf)
 {
-	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
 	u8 new_link_speed, old_link_speed;
 	bool new_link, old_link;
 	int status;
@@ -10281,7 +10286,7 @@ static void i40e_verify_eeprom(struct i40e_pf *pf)
  **/
 static void i40e_enable_pf_switch_lb(struct i40e_pf *pf)
 {
-	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
 	struct i40e_vsi_context ctxt;
 	int ret;
 
@@ -10317,7 +10322,7 @@ static void i40e_enable_pf_switch_lb(struct i40e_pf *pf)
  **/
 static void i40e_disable_pf_switch_lb(struct i40e_pf *pf)
 {
-	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
 	struct i40e_vsi_context ctxt;
 	int ret;
 
@@ -10393,7 +10398,7 @@ static int i40e_reconstitute_veb(struct i40e_veb *veb)
 
 	if (veb->uplink_seid == pf->mac_seid) {
 		/* Check that the LAN VSI has VEB owning flag set */
-		ctl_vsi = pf->vsi[pf->lan_vsi];
+		ctl_vsi = i40e_pf_get_main_vsi(pf);
 
 		if (WARN_ON(ctl_vsi->veb_idx != veb->idx ||
 			    !(ctl_vsi->flags & I40E_VSI_FLAG_VEB_OWNER))) {
@@ -10536,7 +10541,7 @@ static int i40e_vsi_clear(struct i40e_vsi *vsi);
  **/
 static void i40e_fdir_sb_setup(struct i40e_pf *pf)
 {
-	struct i40e_vsi *vsi;
+	struct i40e_vsi *main_vsi, *vsi;
 
 	/* quick workaround for an NVM issue that leaves a critical register
 	 * uninitialized
@@ -10561,8 +10566,8 @@ static void i40e_fdir_sb_setup(struct i40e_pf *pf)
 
 	/* create a new VSI if none exists */
 	if (!vsi) {
-		vsi = i40e_vsi_setup(pf, I40E_VSI_FDIR,
-				     pf->vsi[pf->lan_vsi]->seid, 0);
+		main_vsi = i40e_pf_get_main_vsi(pf);
+		vsi = i40e_vsi_setup(pf, I40E_VSI_FDIR, main_vsi->seid, 0);
 		if (!vsi) {
 			dev_info(&pf->pdev->dev, "Couldn't create FDir VSI\n");
 			clear_bit(I40E_FLAG_FD_SB_ENA, pf->flags);
@@ -10841,7 +10846,7 @@ static int i40e_reset(struct i40e_pf *pf)
 static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 {
 	const bool is_recovery_mode_reported = i40e_check_recovery_mode(pf);
-	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
 	struct i40e_hw *hw = &pf->hw;
 	struct i40e_veb *veb;
 	int ret;
@@ -10850,7 +10855,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 
 	if (test_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state) &&
 	    is_recovery_mode_reported)
-		i40e_set_ethtool_ops(pf->vsi[pf->lan_vsi]->netdev);
+		i40e_set_ethtool_ops(vsi->netdev);
 
 	if (test_bit(__I40E_DOWN, pf->state) &&
 	    !test_bit(__I40E_RECOVERY_MODE, pf->state))
@@ -12402,7 +12407,7 @@ void i40e_fill_rss_lut(struct i40e_pf *pf, u8 *lut,
  **/
 static int i40e_pf_config_rss(struct i40e_pf *pf)
 {
-	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
 	u8 seed[I40E_HKEY_ARRAY_SIZE];
 	u8 *lut;
 	struct i40e_hw *hw = &pf->hw;
@@ -12474,7 +12479,7 @@ static int i40e_pf_config_rss(struct i40e_pf *pf)
  **/
 int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count)
 {
-	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
 	int new_rss_size;
 
 	if (!test_bit(I40E_FLAG_RSS_ENA, pf->flags))
@@ -13767,9 +13772,10 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 		 * the end, which is 4 bytes long, so force truncation of the
 		 * original name by IFNAMSIZ - 4
 		 */
-		snprintf(netdev->name, IFNAMSIZ, "%.*sv%%d",
-			 IFNAMSIZ - 4,
-			 pf->vsi[pf->lan_vsi]->netdev->name);
+		struct i40e_vsi *main_vsi = i40e_pf_get_main_vsi(pf);
+
+		snprintf(netdev->name, IFNAMSIZ, "%.*sv%%d", IFNAMSIZ - 4,
+			 main_vsi->netdev->name);
 		eth_random_addr(mac_addr);
 
 		spin_lock_bh(&vsi->mac_filter_hash_lock);
@@ -14281,6 +14287,7 @@ static int i40e_vsi_setup_vectors(struct i40e_vsi *vsi)
  **/
 static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 {
+	struct i40e_vsi *main_vsi;
 	u16 alloc_queue_pairs;
 	struct i40e_pf *pf;
 	u8 enabled_tc;
@@ -14315,10 +14322,12 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	/* Update the FW view of the VSI. Force a reset of TC and queue
 	 * layout configurations.
 	 */
-	enabled_tc = pf->vsi[pf->lan_vsi]->tc_config.enabled_tc;
-	pf->vsi[pf->lan_vsi]->tc_config.enabled_tc = 0;
-	pf->vsi[pf->lan_vsi]->seid = pf->main_vsi_seid;
-	i40e_vsi_config_tc(pf->vsi[pf->lan_vsi], enabled_tc);
+	main_vsi = i40e_pf_get_main_vsi(pf);
+	enabled_tc = main_vsi->tc_config.enabled_tc;
+	main_vsi->tc_config.enabled_tc = 0;
+	main_vsi->seid = pf->main_vsi_seid;
+	i40e_vsi_config_tc(main_vsi, enabled_tc);
+
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_rm_default_mac_filter(vsi, pf->hw.mac.perm_addr);
 
@@ -15001,6 +15010,7 @@ int i40e_fetch_switch_configuration(struct i40e_pf *pf, bool printconfig)
  **/
 static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 {
+	struct i40e_vsi *main_vsi;
 	u16 flags = 0;
 	int ret;
 
@@ -15045,8 +15055,8 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 	}
 
 	/* first time setup */
-	if (pf->lan_vsi == I40E_NO_VSI || reinit) {
-		struct i40e_vsi *vsi = NULL;
+	main_vsi = i40e_pf_get_main_vsi(pf);
+	if (!main_vsi || reinit) {
 		u16 uplink_seid;
 
 		/* Set up the PF VSI associated with the PF's main VSI
@@ -15056,11 +15066,12 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 			uplink_seid = pf->veb[pf->lan_veb]->seid;
 		else
 			uplink_seid = pf->mac_seid;
-		if (pf->lan_vsi == I40E_NO_VSI)
-			vsi = i40e_vsi_setup(pf, I40E_VSI_MAIN, uplink_seid, 0);
+		if (!main_vsi)
+			main_vsi = i40e_vsi_setup(pf, I40E_VSI_MAIN,
+						  uplink_seid, 0);
 		else if (reinit)
-			vsi = i40e_vsi_reinit_setup(pf->vsi[pf->lan_vsi]);
-		if (!vsi) {
+			main_vsi = i40e_vsi_reinit_setup(main_vsi);
+		if (!main_vsi) {
 			dev_info(&pf->pdev->dev, "setup of MAIN VSI failed\n");
 			i40e_cloud_filter_exit(pf);
 			i40e_fdir_teardown(pf);
@@ -15068,13 +15079,13 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 		}
 	} else {
 		/* force a reset of TC and queue layout configurations */
-		u8 enabled_tc = pf->vsi[pf->lan_vsi]->tc_config.enabled_tc;
+		u8 enabled_tc = main_vsi->tc_config.enabled_tc;
 
-		pf->vsi[pf->lan_vsi]->tc_config.enabled_tc = 0;
-		pf->vsi[pf->lan_vsi]->seid = pf->main_vsi_seid;
-		i40e_vsi_config_tc(pf->vsi[pf->lan_vsi], enabled_tc);
+		main_vsi->tc_config.enabled_tc = 0;
+		main_vsi->seid = pf->main_vsi_seid;
+		i40e_vsi_config_tc(main_vsi, enabled_tc);
 	}
-	i40e_vlan_stripping_disable(pf->vsi[pf->lan_vsi]);
+	i40e_vlan_stripping_disable(main_vsi);
 
 	i40e_fdir_sb_setup(pf);
 
@@ -15101,7 +15112,7 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 		rtnl_lock();
 
 	/* repopulate tunnel port filters */
-	udp_tunnel_nic_reset_ntf(pf->vsi[pf->lan_vsi]->netdev);
+	udp_tunnel_nic_reset_ntf(main_vsi->netdev);
 
 	if (!lock_acquired)
 		rtnl_unlock();
@@ -15245,6 +15256,7 @@ static int i40e_setup_pf_filter_control(struct i40e_pf *pf)
 #define REMAIN(__x) (INFO_STRING_LEN - (__x))
 static void i40e_print_features(struct i40e_pf *pf)
 {
+	struct i40e_vsi *main_vsi = i40e_pf_get_main_vsi(pf);
 	struct i40e_hw *hw = &pf->hw;
 	char *buf;
 	int i;
@@ -15258,8 +15270,7 @@ static void i40e_print_features(struct i40e_pf *pf)
 	i += scnprintf(&buf[i], REMAIN(i), " VFs: %d", pf->num_req_vfs);
 #endif
 	i += scnprintf(&buf[i], REMAIN(i), " VSIs: %d QP: %d",
-		      pf->hw.func_caps.num_vsis,
-		      pf->vsi[pf->lan_vsi]->num_queue_pairs);
+		       pf->hw.func_caps.num_vsis, main_vsi->num_queue_pairs);
 	if (test_bit(I40E_FLAG_RSS_ENA, pf->flags))
 		i += scnprintf(&buf[i], REMAIN(i), " RSS");
 	if (test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags))
@@ -15923,7 +15934,9 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_info(&pdev->dev, "setup_pf_switch failed: %d\n", err);
 		goto err_vsis;
 	}
-	INIT_LIST_HEAD(&pf->vsi[pf->lan_vsi]->ch_list);
+
+	vsi = i40e_pf_get_main_vsi(pf);
+	INIT_LIST_HEAD(&vsi->ch_list);
 
 	/* if FDIR VSI was set up, start it now */
 	vsi = i40e_find_vsi_by_type(pf, I40E_VSI_FDIR);
@@ -16425,15 +16438,15 @@ static void i40e_pci_error_resume(struct pci_dev *pdev)
  **/
 static void i40e_enable_mc_magic_wake(struct i40e_pf *pf)
 {
+	struct i40e_vsi *main_vsi = i40e_pf_get_main_vsi(pf);
 	struct i40e_hw *hw = &pf->hw;
 	u8 mac_addr[6];
 	u16 flags = 0;
 	int ret;
 
 	/* Get current MAC address in case it's an LAA */
-	if (pf->vsi[pf->lan_vsi] && pf->vsi[pf->lan_vsi]->netdev) {
-		ether_addr_copy(mac_addr,
-				pf->vsi[pf->lan_vsi]->netdev->dev_addr);
+	if (main_vsi && main_vsi->netdev) {
+		ether_addr_copy(mac_addr, main_vsi->netdev->dev_addr);
 	} else {
 		dev_err(&pf->pdev->dev,
 			"Failed to retrieve MAC address; using default\n");
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index e7ebcb09f23c..b72a4b5d76b9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -1472,7 +1472,8 @@ void i40e_ptp_restore_hw_time(struct i40e_pf *pf)
  **/
 void i40e_ptp_init(struct i40e_pf *pf)
 {
-	struct net_device *netdev = pf->vsi[pf->lan_vsi]->netdev;
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
+	struct net_device *netdev = vsi->netdev;
 	struct i40e_hw *hw = &pf->hw;
 	u32 pf_id;
 	long err;
@@ -1536,6 +1537,7 @@ void i40e_ptp_init(struct i40e_pf *pf)
  **/
 void i40e_ptp_stop(struct i40e_pf *pf)
 {
+	struct i40e_vsi *main_vsi = i40e_pf_get_main_vsi(pf);
 	struct i40e_hw *hw = &pf->hw;
 	u32 regval;
 
@@ -1555,7 +1557,7 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 		ptp_clock_unregister(pf->ptp_clock);
 		pf->ptp_clock = NULL;
 		dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
-			 pf->vsi[pf->lan_vsi]->netdev->name);
+			 main_vsi->netdev->name);
 	}
 
 	if (i40e_is_ptp_pin_dev(&pf->hw)) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index e35a08de16b2..8f38a969e20e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -23,7 +23,7 @@ static void i40e_fdir(struct i40e_ring *tx_ring,
 {
 	struct i40e_filter_program_desc *fdir_desc;
 	struct i40e_pf *pf = tx_ring->vsi->back;
-	u32 flex_ptype, dtype_cmd;
+	u32 flex_ptype, dtype_cmd, vsi_id;
 	u16 i;
 
 	/* grab the next descriptor */
@@ -41,8 +41,8 @@ static void i40e_fdir(struct i40e_ring *tx_ring,
 	flex_ptype |= FIELD_PREP(I40E_TXD_FLTR_QW0_PCTYPE_MASK, fdata->pctype);
 
 	/* Use LAN VSI Id if not programmed by user */
-	flex_ptype |= FIELD_PREP(I40E_TXD_FLTR_QW0_DEST_VSI_MASK,
-				 fdata->dest_vsi ? : pf->vsi[pf->lan_vsi]->id);
+	vsi_id = fdata->dest_vsi ? : i40e_pf_get_main_vsi(pf)->id;
+	flex_ptype |= FIELD_PREP(I40E_TXD_FLTR_QW0_DEST_VSI_MASK, vsi_id);
 
 	dtype_cmd = I40E_TX_DESC_DTYPE_FILTER_PROG;
 
@@ -868,7 +868,7 @@ u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw)
  **/
 void i40e_detect_recover_hung(struct i40e_pf *pf)
 {
-	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
+	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
 	struct i40e_ring *tx_ring = NULL;
 	struct net_device *netdev;
 	unsigned int i;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 232b65b9c8ea..662622f01e31 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -795,13 +795,13 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 static int i40e_alloc_vsi_res(struct i40e_vf *vf, u8 idx)
 {
 	struct i40e_mac_filter *f = NULL;
+	struct i40e_vsi *main_vsi, *vsi;
 	struct i40e_pf *pf = vf->pf;
-	struct i40e_vsi *vsi;
 	u64 max_tx_rate = 0;
 	int ret = 0;
 
-	vsi = i40e_vsi_setup(pf, I40E_VSI_SRIOV, pf->vsi[pf->lan_vsi]->seid,
-			     vf->vf_id);
+	main_vsi = i40e_pf_get_main_vsi(pf);
+	vsi = i40e_vsi_setup(pf, I40E_VSI_SRIOV, main_vsi->seid, vf->vf_id);
 
 	if (!vsi) {
 		dev_err(&pf->pdev->dev,
@@ -3322,8 +3322,9 @@ static int i40e_vc_remove_vlan_msg(struct i40e_vf *vf, u8 *msg)
 static int i40e_vc_rdma_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 {
 	struct i40e_pf *pf = vf->pf;
-	int abs_vf_id = vf->vf_id + pf->hw.func_caps.vf_base_id;
+	struct i40e_vsi *main_vsi;
 	int aq_ret = 0;
+	int abs_vf_id;
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states) ||
 	    !test_bit(I40E_VF_STATE_RDMAENA, &vf->vf_states)) {
@@ -3331,8 +3332,9 @@ static int i40e_vc_rdma_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 		goto error_param;
 	}
 
-	i40e_notify_client_of_vf_msg(pf->vsi[pf->lan_vsi], abs_vf_id,
-				     msg, msglen);
+	main_vsi = i40e_pf_get_main_vsi(pf);
+	abs_vf_id = vf->vf_id + pf->hw.func_caps.vf_base_id;
+	i40e_notify_client_of_vf_msg(main_vsi, abs_vf_id, msg, msglen);
 
 error_param:
 	/* send the response to the VF */
-- 
2.43.0


