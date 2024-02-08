Return-Path: <linux-kernel+bounces-57615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6985884DB68
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBBC0B25953
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D4F6BB47;
	Thu,  8 Feb 2024 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoSVrYLZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6267C71
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380719; cv=none; b=XoDsmYmNqF8DnJiENInuZyES/6B3SLfJO4joaXo14h5FoQ4xqTNxclJyhZh0wez7c1A0KR9DS2SVfyi2uzf2LZKjRiJdgc/XvZGv0hdAkKpv/xY3Dfu0PaL5Y5HDZPH2e4G5UFoxm9rX3jHWBO8k55M4rWl5a870XnA2l9NrKa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380719; c=relaxed/simple;
	bh=IEidakVDTZ8Ejt2cZ7lVVYaAg1F/lqJZ86OjIL9IDlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lb2DSFbJRsD3R6DCp53tc+qyRK/B2ZwkampqgD2FduKR0JHHRgQ+BocjM4Ciavg6CtMO1NvIGPOootlo0g6dIvcHrjdnbKxWypu+8uBthJ5xqrJILAcj26jO5BRwiAVtTJXmJo38zIHY6LlykkF/zEx+aEeWIc2AtSGSwSSZlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoSVrYLZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707380716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m2b1cGoGE6O9wuUG9B9+7/YSXWO8H0LBstm+bY//wdM=;
	b=hoSVrYLZrEEEc9G6pk+N2R+hcTpajJvHmVPZEAy5T/SjzWOmwme8ckqNBwOTOLWzceVAIw
	AJVMGwR4r1pVCOL6pwCSZK3jBaw0Ig4AROWOqiFRHxw92yZjoiSiFjfcm6rmxfqquw4XnT
	a1tcLywGnldghrhjfi3T6V0zMZdPhYQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-8Ve1q2OOOySylLJQVxvjlw-1; Thu,
 08 Feb 2024 03:25:12 -0500
X-MC-Unique: 8Ve1q2OOOySylLJQVxvjlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C6D229AA2D2;
	Thu,  8 Feb 2024 08:25:12 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.17.171])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB8BA111F9;
	Thu,  8 Feb 2024 08:25:06 +0000 (UTC)
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
Subject: [PATCH v2] ice: Add get/set hw address for VFs using devlink commands
Date: Thu,  8 Feb 2024 13:54:55 +0530
Message-Id: <20240208082455.66726-2-ksundara@redhat.com>
In-Reply-To: <20240208082455.66726-1-ksundara@redhat.com>
References: <20240208082455.66726-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Changing the MAC address of the VF ports are not available
via devlink. Add the function handlers to set and get
the HW address for the VF ports.

Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 89 +++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 80dc5445b50d..8455fa94a687 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -1576,6 +1576,92 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
 	devlink_port_unregister(&pf->devlink_port);
 }
 
+/**
+ * ice_devlink_port_get_vf_mac_address - .port_fn_hw_addr_get devlink handler
+ * @port: devlink port structure
+ * @hw_addr: MAC address of the port
+ * @hw_addr_len: length of MAC address
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
+	struct devlink *devlink = port->devlink;
+	struct ice_pf *pf = devlink_priv(devlink);
+	struct device *dev = ice_pf_to_dev(pf);
+	struct devlink_port_attrs *attrs = &port->attrs;
+	struct devlink_port_pci_vf_attrs *pci_vf;
+	int vf_id;
+	struct ice_vf *vf;
+
+	if (attrs->flavour == DEVLINK_PORT_FLAVOUR_PCI_VF) {
+		pci_vf = &attrs->pci_vf;
+		vf_id = pci_vf->vf;
+	} else {
+		dev_err(dev, "Unable to get the vf id for PF %d\n", pf->hw.pf_id);
+		return -EADDRNOTAVAIL;
+	}
+	vf = ice_get_vf_by_id(pf, vf_id);
+	if (!vf) {
+		dev_err(dev, "Unable to get the vf for PF %d\n", pf->hw.pf_id);
+		return -EINVAL;
+	}
+	ether_addr_copy(hw_addr, vf->dev_lan_addr);
+	*hw_addr_len = ETH_ALEN;
+	return 0;
+}
+
+/**
+ * ice_devlink_port_set_vf_mac_address - .port_fn_hw_addr_set devlink handler
+ * @port: devlink port structure
+ * @hw_addr: MAC address of the port
+ * @hw_addr_len: length of MAC address
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
+	struct ice_pf *pf = devlink_priv(devlink);
+	struct device *dev = ice_pf_to_dev(pf);
+	struct net_device *netdev = port->type_eth.netdev;
+	struct devlink_port_attrs *attrs = &port->attrs;
+	struct devlink_port_pci_vf_attrs *pci_vf;
+	int vf_id;
+	u8 mac[ETH_ALEN];
+
+	if (attrs->flavour == DEVLINK_PORT_FLAVOUR_PCI_VF) {
+		pci_vf = &attrs->pci_vf;
+		vf_id = pci_vf->vf;
+	} else {
+		dev_err(dev, "Unable to get the vf id for PF %d\n", pf->hw.pf_id);
+		return -EADDRNOTAVAIL;
+	}
+
+	if (!netdev) {
+		dev_err(dev, "Unable to get the netdev for PF %d\n", pf->hw.pf_id);
+		return -EADDRNOTAVAIL;
+	}
+	ether_addr_copy(mac, hw_addr);
+
+	return ice_set_vf_mac(netdev, vf_id, mac);
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
@@ -1611,7 +1697,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
 	devlink_port_attrs_set(devlink_port, &attrs);
 	devlink = priv_to_devlink(pf);
 
-	err = devlink_port_register(devlink, devlink_port, vsi->idx);
+	err = devlink_port_register_with_ops(devlink, devlink_port,
+					     vsi->idx, &ice_devlink_vf_port_ops);
 	if (err) {
 		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
 			vf->vf_id, err);
-- 
2.39.3 (Apple Git-145)


