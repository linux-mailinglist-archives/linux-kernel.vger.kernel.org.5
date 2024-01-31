Return-Path: <linux-kernel+bounces-45974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D036C84388B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860C32860F8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493875BAD1;
	Wed, 31 Jan 2024 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NS/Ixz+G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5176E56763
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688556; cv=none; b=t0VlamT06KR80L2qax8c83fl7292UFDobBjGS+hXGeGyHjz1eFWh4z41hN0Io0+EqjWl67URQ5MuIQhU72c5zeqzCS2P+a1xe2q0zHephd+BU2/hGGEjj7R33/qCLeSBr90vzp/N1ygdfdxdE3nIygQj21TchrAMoAqjhmp8zt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688556; c=relaxed/simple;
	bh=R9LlMZ9OVWWJPyIrRhrpFomBiwws4epkFDcHeYI6bsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VW//NAlFaq/wgq9Oy2ux4tS4/7i3UuRgoHSjn90DGdzzQEMOgCQj9lQ4s4B32GEmwYfWG6ADLq6a+rSV72gpA5DmWOyfGLZJh5I0GUwMCLebmpnOgVxV097pMHngDt+udUZmGaeKmOK+mIMCgUP6cEtisP58H0uVz/7+uxDzryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NS/Ixz+G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706688553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BVJpQ3A3nkI35HUkwufhzOS8ITMBUW4wMCPcw1yqp/w=;
	b=NS/Ixz+G2A6WtgyoTzqTUNfUrjMz6d4sq/MQIAi0nPPtp9+sNTi5zFPnBneEylIhRpOHFK
	4JYvgxl2GUnAgZtGAFzbypD1ARul6aweTtdq0z/ZZHWRBxUr3jXF9cOFuDuE773NrA6/NJ
	fFgsctCfYC69OLc8Mkdmhw3Ce1fqSVM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-OCFcN1uQN3SCvHaOASgiuQ-1; Wed,
 31 Jan 2024 03:09:09 -0500
X-MC-Unique: OCFcN1uQN3SCvHaOASgiuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42B3B2825BA5;
	Wed, 31 Jan 2024 08:09:09 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.17.170])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CC22F1C060AF;
	Wed, 31 Jan 2024 08:09:03 +0000 (UTC)
From: karthiksundaravel <ksundara@redhat.com>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rjarry@redhat.com,
	aharivel@redhat.com,
	vchundur@redhat.com,
	ksundara@redhat.com,
	cfontain@redhat.com
Subject: [PATCH] ice: Add get/set hw address for VF representor ports
Date: Wed, 31 Jan 2024 13:38:47 +0530
Message-Id: <20240131080847.30614-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Changing the mac address of the VF representor ports are not
available via devlink. Add the function handlers to set and get
the HW address for the VF representor ports.

Signed-off-by: karthiksundaravel <ksundara@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 134 ++++++++++++++++++-
 1 file changed, 132 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 80dc5445b50d..56d81836c469 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -9,6 +9,8 @@
 #include "ice_eswitch.h"
 #include "ice_fw_update.h"
 #include "ice_dcb_lib.h"
+#include "ice_fltr.h"
+#include "ice_tc_lib.h"
 
 static int ice_active_port_option = -1;
 
@@ -1576,6 +1578,134 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
 	devlink_port_unregister(&pf->devlink_port);
 }
 
+/**
+ * ice_devlink_port_get_vf_mac_address - .port_fn_hw_addr_get devlink handler
+ * @port: devlink port structure
+ * @hw_addr: Mac address of the port
+ * @hw_addr_len: length of mac address
+ * @extack: extended netdev ack structure
+ *
+ * Callback for the devlink .port_fn_hw_addr_get operation
+ * Return: zero on success or an error code on failure.
+ */
+
+static int ice_devlink_port_get_vf_mac_address(struct devlink_port *port,
+					       u8 *hw_addr, int *hw_addr_len,
+					       struct netlink_ext_ack *extack)
+{
+	struct net_device *netdev = port->type_eth.netdev;
+
+	if (!netdev || !netdev->dev_addr)
+		return -EADDRNOTAVAIL;
+
+	ether_addr_copy(hw_addr, netdev->dev_addr);
+	*hw_addr_len = ETH_ALEN;
+	return 0;
+}
+
+/**
+ * ice_devlink_port_set_vf_mac_address - .port_fn_hw_addr_set devlink handler
+ * @port: devlink port structure
+ * @hw_addr: Mac address of the port
+ * @hw_addr_len: length of mac address
+ * @extack: extended netdev ack structure
+ *
+ * Callback for the devlink .port_fn_hw_addr_set operation
+ * Return: zero on success or an error code on failure.
+ */
+static int ice_devlink_port_set_vf_mac_address(struct devlink_port *port,
+					       const u8 *hw_addr,
+					       int hw_addr_len,
+					       struct netlink_ext_ack *extack)
+{
+	struct devlink *devlink = port->devlink;
+	struct net_device *netdev = port->type_eth.netdev;
+	struct ice_pf *pf = devlink_priv(devlink);
+	struct ice_vsi *vsi = *pf->vsi;
+	struct ice_hw *hw = &pf->hw;
+	struct device *dev = ice_pf_to_dev(pf);
+	u8 old_mac[ETH_ALEN];
+	u8 flags = 0;
+	const u8 *mac = hw_addr;
+	int err;
+
+	if (!netdev)
+		return -EADDRNOTAVAIL;
+
+	if (!is_valid_ether_addr(mac))
+		return -EADDRNOTAVAIL;
+
+	if (ether_addr_equal(netdev->dev_addr, mac)) {
+		dev_dbg(dev, "already using mac %pM\n", mac);
+		return 0;
+	}
+
+	if (test_bit(ICE_DOWN, pf->state) ||
+	    ice_is_reset_in_progress(pf->state)) {
+		dev_err(dev, "can't set mac %pM. device not ready\n", mac);
+		return -EBUSY;
+	}
+
+	if (ice_chnl_dmac_fltr_cnt(pf)) {
+		dev_err(dev, "can't set mac %pM. Device has tc-flower filters, delete all of them and try again\n",
+			mac);
+		return -EAGAIN;
+	}
+
+	netif_addr_lock_bh(netdev);
+	ether_addr_copy(old_mac, netdev->dev_addr);
+	/* change the netdev's MAC address */
+	eth_hw_addr_set(netdev, mac);
+	netif_addr_unlock_bh(netdev);
+
+	/* Clean up old MAC filter. Not an error if old filter doesn't exist */
+	err = ice_fltr_remove_mac(vsi, old_mac, ICE_FWD_TO_VSI);
+	if (err && err != -ENOENT) {
+		err = -EADDRNOTAVAIL;
+		goto err_update_filters;
+	}
+
+	/* Add filter for new MAC. If filter exists, return success */
+	err = ice_fltr_add_mac(vsi, mac, ICE_FWD_TO_VSI);
+	if (err == -EEXIST) {
+		/* Although this MAC filter is already present in hardware it's
+		 * possible in some cases (e.g. bonding) that dev_addr was
+		 * modified outside of the driver and needs to be restored back
+		 * to this value.
+		 */
+		dev_dbg(dev, "filter for MAC %pM already exists\n", mac);
+		return 0;
+	} else if (err) {
+		/* error if the new filter addition failed */
+		err = -EADDRNOTAVAIL;
+	}
+
+err_update_filters:
+	if (err) {
+		dev_err(dev, "can't set MAC %pM. filter update failed\n", mac);
+		netif_addr_lock_bh(netdev);
+		eth_hw_addr_set(netdev, old_mac);
+		netif_addr_unlock_bh(netdev);
+		return err;
+	}
+
+	dev_dbg(dev, "updated MAC address to %pM\n", netdev->dev_addr);
+
+	/* write new MAC address to the firmware */
+	flags = ICE_AQC_MAN_MAC_UPDATE_LAA_WOL;
+	err = ice_aq_manage_mac_write(hw, mac, flags, NULL);
+	if (err) {
+		dev_err(dev, "can't set MAC %pM. write to firmware failed error %d\n",
+			mac, err);
+	}
+	return 0;
+}
+
+static const struct devlink_port_ops ice_devlink_vf_port_ops = {
+	.port_fn_hw_addr_get = ice_devlink_port_get_vf_mac_address,
+	.port_fn_hw_addr_set = ice_devlink_port_set_vf_mac_address,
+};
+
 /**
  * ice_devlink_create_vf_port - Create a devlink port for this VF
  * @vf: the VF to create a port for
@@ -1611,7 +1741,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
 	devlink_port_attrs_set(devlink_port, &attrs);
 	devlink = priv_to_devlink(pf);
 
-	err = devlink_port_register(devlink, devlink_port, vsi->idx);
+	err = devlink_port_register_with_ops(devlink, devlink_port,
+					     vsi->idx, &ice_devlink_vf_port_ops);
 	if (err) {
 		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
 			vf->vf_id, err);
@@ -1620,7 +1751,6 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
 
 	return 0;
 }
-
 /**
  * ice_devlink_destroy_vf_port - Destroy the devlink_port for this VF
  * @vf: the VF to cleanup
-- 
2.39.3 (Apple Git-145)


