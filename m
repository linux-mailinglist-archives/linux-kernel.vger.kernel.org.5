Return-Path: <linux-kernel+bounces-85320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C279D86B423
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74561286B99
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2198E161B66;
	Wed, 28 Feb 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aoCYPUHg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40515F316;
	Wed, 28 Feb 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136266; cv=none; b=k23oYlnQ6VLkPtZ56vygT0N+VIHTMktz8kI/sBWmHBjzdIxZ9WAjYTGGOReV+c3SAf3rK+Ct+Mb4OT2kEsZGh8Hc6Nc+jGB146GUxTCz6CBWSTLvqL2DX+9u2V1yOlrg63zsaXA+tmOqRzroT701fl6Qx+XPnsK83QUiJxZrqR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136266; c=relaxed/simple;
	bh=Bjrp1tTlD6ezzWfPdYM+Tqz2X4qeW6q9D/krqY8Q3+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hq4p5Rv0eAxEuAQdD4ph+cgjhfAVpYjdzPKPkoZun0P/R3PxE1G2t8oIXkPdw7M3zPcCN6zZm6VxWTPwVZ7EvifiioP/A6YoUBpm1qXpPE5Wb1PIwZ0aBv+BDpDDRfFXMdMwEHCrE2pLpBwN+qaRkjs1qj1SHI84HGYfHczmQ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aoCYPUHg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709136264; x=1740672264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bjrp1tTlD6ezzWfPdYM+Tqz2X4qeW6q9D/krqY8Q3+k=;
  b=aoCYPUHgwnZd05PMTrhcI8yQ9mIdLjJsI6ae/CC9rk8IQ8vuSSXjp2qJ
   h9nTrctbQqVGZYkZBSiig4jKXwlO4uCFQolEJJrfnm/ssvKQYn8Wizqmd
   wlpVpojaNy9P1GOxwUSc9HjgRWsSCKQrS3xfGJ4ie7d2dGzF643maEafq
   G+rVJ0e0z4YgXqzNb7cQd7Z4TYMzrV5fYlrKuanSoqvdy4z19s4pf+kFM
   T+YGHD/Xk++4V1HN7gTKIUCdd2dLcOBFOeJuGC9ULvH5wfSpfBdFvbHwx
   Zj9IxzjqPWVLR7K30uu8bmBmBzGiJYZ3PUW6rsAq0I7U/Qt/ZUjEA4hdZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3706637"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3706637"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:04:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7527818"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 28 Feb 2024 08:04:18 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 87BD536825;
	Wed, 28 Feb 2024 16:04:15 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Plachno <lukasz.plachno@intel.com>,
	Jakub Buchocki <jakubx.buchocki@intel.com>,
	Pawel Kaminski <pawel.kaminski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-net 5/5] ice: Implement VF LLDP TX support for VF
Date: Wed, 28 Feb 2024 16:59:49 +0100
Message-ID: <20240228155957.408036-6-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228155957.408036-1-larysa.zaremba@intel.com>
References: <20240228155957.408036-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>

Add option to enable transmit LLDP on single trusted VF via a sysfs entry,
for example:

echo '1' > /sys/class/net/<PF_IFNAME>/device/virtfn0/transmit_lldp

Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Co-developed-by: Jakub Buchocki <jakubx.buchocki@intel.com>
Signed-off-by: Jakub Buchocki <jakubx.buchocki@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c    |   3 +
 drivers/net/ethernet/intel/ice/ice_sriov.c  |   4 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 163 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h |  14 ++
 4 files changed, 184 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 19f08f2e0139..32b1ed74bfa4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2062,6 +2062,9 @@ void ice_dis_sw_lldp(struct ice_pf *pf)
 
 		if (vsi && vsi->rx_lldp_ena)
 			ice_cfg_sw_lldp(vsi, false, false);
+
+		if (vf->transmit_lldp)
+			ice_handle_vf_tx_lldp(vf, false);
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index a94a1c48c3de..0fe07330cc1a 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -832,6 +832,10 @@ static int ice_create_vf_entries(struct ice_pf *pf, u16 num_vfs)
 		vf->vfdev = vfdev;
 		vf->vf_sw_id = pf->first_sw;
 
+		err = ice_init_vf_sysfs(vf);
+		if (err)
+			goto err_free_entries;
+
 		pci_dev_get(vfdev);
 
 		/* set default number of MSI-X */
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 2de6ef3661cf..244d0ac7c9c4 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -577,6 +577,165 @@ void ice_ena_all_vfs_rx_lldp(struct ice_pf *pf)
 	}
 }
 
+static bool ice_is_transmit_lldp_enabled(struct ice_pf *pf)
+{
+	struct ice_vf *vf;
+	unsigned int bkt;
+
+	ice_for_each_vf(pf, bkt, vf) {
+		if (vf->transmit_lldp)
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * ice_handle_vf_tx_lldp - enable/disable LLDP TX on VF
+ * @vf: VF to configure Tx LLDP for
+ * @ena: Enable or disable Tx LLDP switch rule
+ *
+ * Configure Tx filters for VF to transmit LLDP
+ */
+int ice_handle_vf_tx_lldp(struct ice_vf *vf, bool ena)
+{
+	void (*allow_override)(struct ice_vsi_ctx *ctx);
+	struct ice_vsi *vsi, *main_vsi;
+	struct ice_pf *pf = vf->pf;
+	struct device *dev;
+	bool prev_ena;
+
+	dev = ice_pf_to_dev(pf);
+	vsi = ice_get_vf_vsi(vf);
+	main_vsi = ice_get_main_vsi(pf);
+	if (!vsi || !main_vsi)
+		return -ENOENT;
+
+	if (ena && test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags)) {
+		dev_err(dev, "Transmit LLDP VF is only allowed when FW LLDP Agent is disabled");
+		return -EPERM;
+	}
+
+	if (ena && ice_is_transmit_lldp_enabled(pf)) {
+		dev_err(dev, "Only a single VF per port is allowed to transmit LLDP packets, ignoring the settings");
+		return -EPERM;
+	}
+
+	allow_override = ena ? ice_vsi_ctx_set_allow_override
+			     : ice_vsi_ctx_clear_allow_override;
+	prev_ena = vsi->info.sec_flags & ICE_AQ_VSI_SEC_FLAG_ALLOW_DEST_OVRD;
+
+	if (ice_vsi_update_security(vsi, allow_override))
+		return -ENOENT;
+
+	/* If VF can transmit LLDP, then PF cannot and vice versa */
+	allow_override = ena ? ice_vsi_ctx_clear_allow_override
+			     : ice_vsi_ctx_set_allow_override;
+
+	if (ice_vsi_update_security(main_vsi, allow_override)) {
+		allow_override = prev_ena  ? ice_vsi_ctx_set_allow_override
+					   : ice_vsi_ctx_clear_allow_override;
+		ice_vsi_update_security(vsi, allow_override);
+		return -ENOENT;
+	}
+
+	vf->transmit_lldp = ena;
+	return 0;
+}
+
+static ssize_t ice_transmit_lldp_vf_attr_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct ice_vf *vf = ice_get_vf_by_dev(dev);
+
+	if (!vf)
+		return -ENOENT;
+
+	return sysfs_emit(buf, "%u\n", vf->transmit_lldp);
+}
+
+static ssize_t ice_transmit_lldp_vf_attr_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct pci_dev *vfdev = container_of(dev, struct pci_dev, dev);
+	struct ice_vf *vf = ice_get_vf_by_dev(dev);
+	struct pci_dev *pdev = vfdev->physfn;
+	struct ice_pf *pf;
+	bool ena;
+	int err;
+
+	if (!vf)
+		return -ENOENT;
+
+	pf = pci_get_drvdata(pdev);
+	if (!pf)
+		return -ENOENT;
+
+	err = kstrtobool(buf, &ena);
+	if (err)
+		return -EINVAL;
+
+	if (ena == vf->transmit_lldp) {
+		dev_dbg(dev, "Transmit LLDP value already set for VF %d",
+			vf->vf_id);
+		return count;
+	}
+
+	err = ice_handle_vf_tx_lldp(vf, ena);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static int ice_init_vf_transmit_lldp_sysfs(struct ice_vf *vf)
+{
+	struct device_attribute tmp = __ATTR(transmit_lldp, 0644,
+					     ice_transmit_lldp_vf_attr_show,
+					     ice_transmit_lldp_vf_attr_store);
+
+	vf->transmit_lldp_attr = tmp;
+
+	return device_create_file(&vf->vfdev->dev, &vf->transmit_lldp_attr);
+}
+
+/**
+ * ice_init_vf_sysfs - Initialize sysfs entries for a VF
+ * @vf: VF to init sysfs for
+ *
+ * Initialize sysfs entries (accessible from the host) for a VF
+ */
+int ice_init_vf_sysfs(struct ice_vf *vf)
+{
+	struct device *dev = ice_pf_to_dev(vf->pf);
+	int err = 0;
+
+	if (!vf->vfdev) {
+		dev_err(dev, "%s: no vfdev", __func__);
+		return -ENOENT;
+	}
+
+	err = ice_init_vf_transmit_lldp_sysfs(vf);
+	if (err)
+		dev_err(dev, "could not init transmit_lldp sysfs entry, err: %d",
+			err);
+
+	return err;
+}
+
+static int ice_vf_apply_tx_lldp(struct ice_vf *vf)
+{
+	if (!vf->transmit_lldp)
+		return 0;
+
+	/* Disable it so it can be applied again. */
+	vf->transmit_lldp = false;
+
+	return ice_handle_vf_tx_lldp(vf, true);
+}
+
 /**
  * ice_vf_rebuild_host_cfg - host admin configuration is persistent across reset
  * @vf: VF to rebuild host configuration on
@@ -607,6 +766,10 @@ static void ice_vf_rebuild_host_cfg(struct ice_vf *vf)
 		dev_err(dev, "failed to rebuild spoofchk configuration for VF %d\n",
 			vf->vf_id);
 
+	if (ice_vf_apply_tx_lldp(vf))
+		dev_err(dev, "failed to rebuild transmit LLDP configuration for VF %d\n",
+			vf->vf_id);
+
 	/* rebuild aggregator node config for main VF VSI */
 	ice_vf_rebuild_aggregator_node_cfg(vsi);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 81f734f2ae41..63e53591541e 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -104,9 +104,11 @@ struct ice_vf {
 	struct ice_vlan port_vlan_info;	/* Port VLAN ID, QoS, and TPID */
 	struct virtchnl_vlan_caps vlan_v2_caps;
 	struct ice_mbx_vf_info mbx_info;
+	struct device_attribute transmit_lldp_attr;
 	u8 pf_set_mac:1;		/* VF MAC address set by VMM admin */
 	u8 trusted:1;
 	u8 spoofchk:1;
+	u8 transmit_lldp:1;
 	u8 link_forced:1;
 	u8 link_up:1;			/* only valid if VF link is forced */
 	/* VSI indices - actual VSI pointers are maintained in the PF structure
@@ -234,6 +236,8 @@ void ice_reset_all_vfs(struct ice_pf *pf);
 struct ice_vsi *ice_get_vf_ctrl_vsi(struct ice_pf *pf, struct ice_vsi *vsi);
 void ice_ena_all_vfs_rx_lldp(struct ice_pf *pf);
 int ice_ena_vf_rx_lldp(struct ice_vf *vf);
+int ice_init_vf_sysfs(struct ice_vf *vf);
+int ice_handle_vf_tx_lldp(struct ice_vf *vf, bool ena);
 #else /* CONFIG_PCI_IOV */
 static inline struct ice_vf *ice_get_vf_by_id(struct ice_pf *pf, u16 vf_id)
 {
@@ -313,6 +317,16 @@ ice_get_vf_ctrl_vsi(struct ice_pf *pf, struct ice_vsi *vsi)
 static inline void ice_ena_all_vfs_rx_lldp(struct ice_pf *pf)
 {
 }
+
+static inline int ice_handle_vf_tx_lldp(struct ice_vf *vf, bool ena)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int ice_init_vf_sysfs(struct ice_vf *vf)
+{
+	return 0;
+}
 #endif /* !CONFIG_PCI_IOV */
 
 #endif /* _ICE_VF_LIB_H_ */
-- 
2.43.0


