Return-Path: <linux-kernel+bounces-92606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A48722CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507CA1C21E57
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0621F127B6A;
	Tue,  5 Mar 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZNkScEF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFC1127B63
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652423; cv=none; b=VHfuzmwBrhvAEWeM0QN/D8PQX8iTNoVkphlMDx7MaBEX8antX36XOTADRRUL9Do3IxfhwQhZKWhjHbeVI6gjZskLqWsyEoOREHXGyuu2NheZZHpF7DxB2AhKU0IVvaGpbUGc4KYGPDTEur0lCpkAVF9OVhzyte1ekpB4vEW340s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652423; c=relaxed/simple;
	bh=kfxr13VdkOyL2ROU4/qMPEQNEmz/VT+DlXa4gwnGCwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IPXx2TMepgIzNQK8S1ffUV0oWDuVCzncqQRKM3LJYeSlXJPbz0nrxp/SbXXoL0VYmug0x90HO/CMULO4UOqfPranIJP9soSd5Bx5ntoJ90gK/NQEu/ZkgZ/pRjp5iZfOzNqIb84hjvVP392ALaUY0TPCOkQMtPbKmGvT+zrBWzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZNkScEF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709652420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XlORlZ1q3eFv+NMcNqENcw6ahsCa1EEVIyv8mEPpDE0=;
	b=gZNkScEFgU3M1rG8zhSFk8mEzVj4dQkBtQKlkJFmw9VwXXRf8eBjKxvk/fsG/+GoyPjyNn
	71pLJxvN7+pdt+KMd//6XCAh3ydUo/vCLTwkn79K/bX1s0KM0JN9sxxTZf9w350oUu3Yq6
	qD7EopHYc4zcgMnEaNWl7rTPZHGYM3c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-QcK503W_MzaqyBw3dYpMVg-1; Tue,
 05 Mar 2024 10:26:53 -0500
X-MC-Unique: QcK503W_MzaqyBw3dYpMVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F7EB29AA3B9;
	Tue,  5 Mar 2024 15:26:53 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.16.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 415791121306;
	Tue,  5 Mar 2024 15:26:46 +0000 (UTC)
From: Karthik Sundaravel <ksundara@redhat.com>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pmenzel@molgen.mpg.de,
	jiri@resnulli.us,
	michal.swiatkowski@linux.intel.com,
	rjarry@redhat.com,
	aharivel@redhat.com,
	vchundur@redhat.com,
	ksundara@redhat.com,
	cfontain@redhat.com
Subject: [PATCH v5] ice: Add get/set hw address for VFs using devlink commands
Date: Tue,  5 Mar 2024 20:56:41 +0530
Message-Id: <20240305152641.53489-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Changing the MAC address of the VFs are not available
via devlink. Add the function handlers to set and get
the HW address for the VFs.

Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 78 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_sriov.c   | 62 ++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_sriov.h   |  8 ++
 3 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 80dc5445b50d..39d4d79ac731 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -1576,6 +1576,81 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
 	devlink_port_unregister(&pf->devlink_port);
 }
 
+/**
+ * ice_devlink_port_get_vf_fn_mac - .port_fn_hw_addr_get devlink handler
+ * @port: devlink port structure
+ * @hw_addr: MAC address of the port
+ * @hw_addr_len: length of MAC address
+ * @extack: extended netdev ack structure
+ *
+ * Callback for the devlink .port_fn_hw_addr_get operation
+ * Return: zero on success or an error code on failure.
+ */
+
+static int ice_devlink_port_get_vf_fn_mac(struct devlink_port *port,
+					  u8 *hw_addr, int *hw_addr_len,
+					  struct netlink_ext_ack *extack)
+{
+	struct devlink_port_attrs *attrs = &port->attrs;
+	struct devlink_port_pci_vf_attrs *pci_vf;
+	struct devlink *devlink = port->devlink;
+	struct ice_pf *pf;
+	struct ice_vf *vf;
+	int vf_id;
+
+	pf = devlink_priv(devlink);
+	pci_vf = &attrs->pci_vf;
+	vf_id = pci_vf->vf;
+
+	vf = ice_get_vf_by_id(pf, vf_id);
+	if (!vf) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf");
+		return -EINVAL;
+	}
+	ether_addr_copy(hw_addr, vf->dev_lan_addr);
+	*hw_addr_len = ETH_ALEN;
+
+	ice_put_vf(vf);
+	return 0;
+}
+
+/**
+ * ice_devlink_port_set_vf_fn_mac - .port_fn_hw_addr_set devlink handler
+ * @port: devlink port structure
+ * @hw_addr: MAC address of the port
+ * @hw_addr_len: length of MAC address
+ * @extack: extended netdev ack structure
+ *
+ * Callback for the devlink .port_fn_hw_addr_set operation
+ * Return: zero on success or an error code on failure.
+ */
+static int ice_devlink_port_set_vf_fn_mac(struct devlink_port *port,
+					  const u8 *hw_addr,
+					  int hw_addr_len,
+					  struct netlink_ext_ack *extack)
+
+{
+	struct devlink_port_attrs *attrs = &port->attrs;
+	struct devlink_port_pci_vf_attrs *pci_vf;
+	struct devlink *devlink = port->devlink;
+	struct ice_pf *pf;
+	u8 mac[ETH_ALEN];
+	int vf_id;
+
+	pf = devlink_priv(devlink);
+	pci_vf = &attrs->pci_vf;
+	vf_id = pci_vf->vf;
+
+	ether_addr_copy(mac, hw_addr);
+
+	return ice_set_vf_fn_mac(pf, vf_id, mac);
+}
+
+static const struct devlink_port_ops ice_devlink_vf_port_ops = {
+	.port_fn_hw_addr_get = ice_devlink_port_get_vf_fn_mac,
+	.port_fn_hw_addr_set = ice_devlink_port_set_vf_fn_mac,
+};
+
 /**
  * ice_devlink_create_vf_port - Create a devlink port for this VF
  * @vf: the VF to create a port for
@@ -1611,7 +1686,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
 	devlink_port_attrs_set(devlink_port, &attrs);
 	devlink = priv_to_devlink(pf);
 
-	err = devlink_port_register(devlink, devlink_port, vsi->idx);
+	err = devlink_port_register_with_ops(devlink, devlink_port,
+					     vsi->idx, &ice_devlink_vf_port_ops);
 	if (err) {
 		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
 			vf->vf_id, err);
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 31314e7540f8..73cf1d9e9daa 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1216,6 +1216,68 @@ ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
 	return ret;
 }
 
+/**
+ * ice_set_vf_fn_mac
+ * @pf: PF to be configure
+ * @vf_id: VF identifier
+ * @mac: MAC address
+ *
+ * program VF MAC address
+ */
+int ice_set_vf_fn_mac(struct ice_pf *pf, int vf_id, u8 *mac)
+{
+	struct device *dev;
+	struct ice_vf *vf;
+	int ret;
+
+	dev = ice_pf_to_dev(pf);
+	if (is_multicast_ether_addr(mac)) {
+		dev_err(dev, "%pM not a valid unicast address\n", mac);
+		return -EINVAL;
+	}
+
+	vf = ice_get_vf_by_id(pf, vf_id);
+	if (!vf)
+		return -EINVAL;
+
+	/* nothing left to do, unicast MAC already set */
+	if (ether_addr_equal(vf->dev_lan_addr, mac) &&
+	    ether_addr_equal(vf->hw_lan_addr, mac)) {
+		ret = 0;
+		goto out_put_vf;
+	}
+
+	ret = ice_check_vf_ready_for_cfg(vf);
+	if (ret)
+		goto out_put_vf;
+
+	mutex_lock(&vf->cfg_lock);
+
+	/* VF is notified of its new MAC via the PF's response to the
+	 * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been reset
+	 */
+	ether_addr_copy(vf->dev_lan_addr, mac);
+	ether_addr_copy(vf->hw_lan_addr, mac);
+	if (is_zero_ether_addr(mac)) {
+		/* VF will send VIRTCHNL_OP_ADD_ETH_ADDR message with its MAC */
+		vf->pf_set_mac = false;
+		dev_info(dev, "Removing MAC on VF %d. VF driver will be reinitialized\n",
+			 vf->vf_id);
+	} else {
+		/* PF will add MAC rule for the VF */
+		vf->pf_set_mac = true;
+		dev_info(dev, "Setting MAC %pM on VF %d. VF driver will be reinitialized\n",
+			 mac, vf_id);
+	}
+
+	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+	mutex_unlock(&vf->cfg_lock);
+
+out_put_vf:
+	ice_put_vf(vf);
+	return ret;
+}
+
 /**
  * ice_set_vf_mac
  * @netdev: network interface device structure
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
index 346cb2666f3a..a03be184a806 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
@@ -28,6 +28,7 @@
 #ifdef CONFIG_PCI_IOV
 void ice_process_vflr_event(struct ice_pf *pf);
 int ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
+int ice_set_vf_fn_mac(struct ice_pf *pf, int vf_id, u8 *mac);
 int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);
 int
 ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi);
@@ -76,6 +77,13 @@ ice_sriov_configure(struct pci_dev __always_unused *pdev,
 	return -EOPNOTSUPP;
 }
 
+static inline int
+ice_set_vf_fn_mac(struct ice_pf __always_unused *pf,
+		  int __always_unused vf_id, u8 __always_unused *mac)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int
 ice_set_vf_mac(struct net_device __always_unused *netdev,
 	       int __always_unused vf_id, u8 __always_unused *mac)
-- 
2.39.3 (Apple Git-145)


