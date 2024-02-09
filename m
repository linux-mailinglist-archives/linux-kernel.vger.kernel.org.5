Return-Path: <linux-kernel+bounces-59192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1DC84F2F0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638C91C2269B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FDD692F3;
	Fri,  9 Feb 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkoDxMF3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D6467C4D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473379; cv=none; b=gXCtKRjlAATzRZf3VlnZpVf7mARXqLOI85i/HykiFXfQBv5MriEWF7BWO7qaI7hDi1yqEM3nK1fWF/NFVF90hRupkxTdkuyCs9ThJVHVaVkjXS5buFzrTmVucRRWGgY3068JLasuE/ztTe48yU0e2MhTjaYCncNfGur6kWJXM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473379; c=relaxed/simple;
	bh=uEq14SmNfh9e6AvTpkK1VirafM0cDpxRZMf85VWBefw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b7OZ5bor323JWiPUkf/xZse8KO3kZIzcv7ZsfW0J8G2wtawPuQfJwUlPORPn1LLvlUZvH9nfWkLrEG30ppaalI5FKFeBEn5HdT+AkjUNP6L3bV6O1+sC3cS7P/yZ+ZO3n3jrY757cE2EPNWiLHkvQlaVygtxMM+VSK8BpkHGnDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkoDxMF3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707473375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3/PA/qAm80LBIpCSUidwpWKHTU/hcwXN20sP5Blmh3g=;
	b=CkoDxMF3WMCkMx2KWGzmMQbpHtB1c0kDC9CEgVeOMZxdqKNL0N+LBtlA8nttx3YT7zj5mS
	NX8fcL8PeWZdMvjQYUrzj976knBFnfCM6DCP00VZcGSqd+AG/MPHU94ke9jvHDzy7BcwRR
	ORblgv+SJJo4BZ1dh+hJ50qoyb1twls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-x_rBRvy0Pdm3W43COY-s4w-1; Fri, 09 Feb 2024 05:09:30 -0500
X-MC-Unique: x_rBRvy0Pdm3W43COY-s4w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85E00831070;
	Fri,  9 Feb 2024 10:09:29 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.16.209])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BCD1B492BE3;
	Fri,  9 Feb 2024 10:09:23 +0000 (UTC)
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
Subject: [PATCH v3] ice: Add get/set hw address for VFs using devlink commands
Date: Fri,  9 Feb 2024 15:39:12 +0530
Message-Id: <20240209100912.82473-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Changing the MAC address of the VFs are not available
via devlink. Add the function handlers to set and get
the HW address for the VFs.

Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 86 +++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 80dc5445b50d..7ed61b10312c 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -1576,6 +1576,89 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
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
+	struct devlink_port_attrs *attrs = &port->attrs;
+	struct devlink_port_pci_vf_attrs *pci_vf;
+	struct devlink *devlink = port->devlink;
+	struct ice_pf *pf;
+	struct ice_vf *vf;
+	int vf_id;
+
+	pf = devlink_priv(devlink);
+	if (attrs->flavour == DEVLINK_PORT_FLAVOUR_PCI_VF) {
+		pci_vf = &attrs->pci_vf;
+		vf_id = pci_vf->vf;
+	} else {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf id");
+		return -EADDRNOTAVAIL;
+	}
+	vf = ice_get_vf_by_id(pf, vf_id);
+	if (!vf) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf");
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
+	struct net_device *netdev = port->type_eth.netdev;
+	struct devlink_port_attrs *attrs = &port->attrs;
+	struct devlink_port_pci_vf_attrs *pci_vf;
+	u8 mac[ETH_ALEN];
+	int vf_id;
+
+	if (attrs->flavour == DEVLINK_PORT_FLAVOUR_PCI_VF) {
+		pci_vf = &attrs->pci_vf;
+		vf_id = pci_vf->vf;
+	} else {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf id");
+		return -EADDRNOTAVAIL;
+	}
+
+	if (!netdev) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the netdev");
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
@@ -1611,7 +1694,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
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


