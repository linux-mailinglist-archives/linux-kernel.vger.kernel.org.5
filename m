Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC88280EECE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376842AbjLLO3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376819AbjLLO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:29:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB46CE9;
        Tue, 12 Dec 2023 06:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702391395; x=1733927395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SmqwRqR+FjKFB/XPmsvj5POk5lK1K1Y9U4M2qqIxTQY=;
  b=mwAe+jQ9ILeujAPcKCZDKXIUhmGiNSQ61X8dNiQoJGsxJNgVHlXsSNqS
   SGvWIW7W4nmd6J57MY+5H6ZYcbHyhKxz1EE41YuJMtUms9r41Vr4KIkfu
   b692uq1o1of0aYniIwqT0JfTL5SRopDG9uS9QEU8qYoOyvQ8OchvdeZ5P
   2hIJeJieWhBuB4zlL/xrvL2LUDm7H9nUGwwPlzg9r3AGhuojmAta2sevj
   Q3u/diAh5t4m4SsgwBe6IE6QSgm8r2MlN7AGYxaXuOtGvXqYb00NWVNj9
   RbFUA+n+zrf2PcDQNycl6K8f7SmDXEFUKjYNDgSWHmH6SV0jMPQB5t1ZG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1887374"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1887374"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:29:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1104923763"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1104923763"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2023 06:29:51 -0800
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michal Kubecek <mkubecek@suse.cz>,
        Jiri Pirko <jiri@resnulli.us>,
        Paul Greenwalt <paul.greenwalt@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] idpf: add get/set for Ethtool's header split ringparam
Date:   Tue, 12 Dec 2023 15:27:52 +0100
Message-ID: <20231212142752.935000-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212142752.935000-1-aleksander.lobakin@intel.com>
References: <20231212142752.935000-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubiak <michal.kubiak@intel.com>

idpf supports the header split feature and that feature is always
enabled by default.
However, for flexibility reasons and to simplify some scenarios, it
would be useful to have the support for switching the header split
off (and on) from the userspace.

Address that need by adding the user config parameter, the functions
for disabling (or enabling) the header split feature, and calls to
them from the Ethtool ringparam callbacks.
It still is enabled by default if supported by the hardware.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  7 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 11 ++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 65 +++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 12 ++--
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  2 +
 5 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index bee73353b56a..0acc125decb3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -15,7 +15,7 @@ struct idpf_vport_max_q;
 #include <linux/pci.h>
 #include <linux/bitfield.h>
 #include <linux/sctp.h>
-#include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
 #include <net/gro.h>
 #include <linux/dim.h>
 
@@ -418,11 +418,13 @@ struct idpf_vport {
 
 /**
  * enum idpf_user_flags
+ * @__IDPF_USER_FLAG_HSPLIT: header split state
  * @__IDPF_PROMISC_UC: Unicast promiscuous mode
  * @__IDPF_PROMISC_MC: Multicast promiscuous mode
  * @__IDPF_USER_FLAGS_NBITS: Must be last
  */
 enum idpf_user_flags {
+	__IDPF_USER_FLAG_HSPLIT = 0U,
 	__IDPF_PROMISC_UC = 32,
 	__IDPF_PROMISC_MC,
 
@@ -965,4 +967,7 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map);
 int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
 int idpf_sriov_configure(struct pci_dev *pdev, int num_vfs);
 
+u8 idpf_vport_get_hsplit(const struct idpf_vport *vport);
+bool idpf_vport_set_hsplit(const struct idpf_vport *vport, u8 val);
+
 #endif /* !_IDPF_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index bf58989a573e..d549d3c5910d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -320,6 +320,8 @@ static void idpf_get_ringparam(struct net_device *netdev,
 	ring->rx_pending = vport->rxq_desc_count;
 	ring->tx_pending = vport->txq_desc_count;
 
+	kring->tcp_data_split = idpf_vport_get_hsplit(vport);
+
 	idpf_vport_ctrl_unlock(netdev);
 }
 
@@ -379,6 +381,14 @@ static int idpf_set_ringparam(struct net_device *netdev,
 	    new_rx_count == vport->rxq_desc_count)
 		goto unlock_mutex;
 
+	if (!idpf_vport_set_hsplit(vport, kring->tcp_data_split)) {
+		NL_SET_ERR_MSG_MOD(ext_ack,
+				   "setting TCP data split is not supported");
+		err = -EOPNOTSUPP;
+
+		goto unlock_mutex;
+	}
+
 	config_data = &vport->adapter->vport_config[idx]->user_config;
 	config_data->num_req_txq_desc = new_tx_count;
 	config_data->num_req_rxq_desc = new_rx_count;
@@ -1334,6 +1344,7 @@ static int idpf_get_link_ksettings(struct net_device *netdev,
 static const struct ethtool_ops idpf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE,
+	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
 	.get_msglevel		= idpf_get_msglevel,
 	.set_msglevel		= idpf_set_msglevel,
 	.get_link		= ethtool_op_get_link,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 19809b0ddcd9..5fea2fd957eb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1057,6 +1057,71 @@ static void idpf_vport_dealloc(struct idpf_vport *vport)
 	adapter->next_vport = idpf_get_free_slot(adapter);
 }
 
+/**
+ * idpf_is_hsplit_supported - check whether the header split is supported
+ * @vport: virtual port to check the capability for
+ *
+ * Return: true if it's supported by the HW/FW, false if not.
+ */
+static bool idpf_is_hsplit_supported(const struct idpf_vport *vport)
+{
+	return idpf_is_queue_model_split(vport->rxq_model) &&
+	       idpf_is_cap_ena_all(vport->adapter, IDPF_HSPLIT_CAPS,
+				   IDPF_CAP_HSPLIT);
+}
+
+/**
+ * idpf_vport_get_hsplit - get the current header split feature state
+ * @vport: virtual port to query the state for
+ *
+ * Return: ``ETHTOOL_TCP_DATA_SPLIT_UNKNOWN`` if not supported,
+ *         ``ETHTOOL_TCP_DATA_SPLIT_DISABLED`` if disabled,
+ *         ``ETHTOOL_TCP_DATA_SPLIT_ENABLED`` if active.
+ */
+u8 idpf_vport_get_hsplit(const struct idpf_vport *vport)
+{
+	const struct idpf_vport_user_config_data *config;
+
+	if (!idpf_is_hsplit_supported(vport))
+		return ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
+
+	config = &vport->adapter->vport_config[vport->idx]->user_config;
+
+	return test_bit(__IDPF_USER_FLAG_HSPLIT, config->user_flags) ?
+	       ETHTOOL_TCP_DATA_SPLIT_ENABLED :
+	       ETHTOOL_TCP_DATA_SPLIT_DISABLED;
+}
+
+/**
+ * idpf_vport_set_hsplit - enable or disable header split on a given vport
+ * @vport: virtual port to configure
+ * @val: Ethtool flag controlling the header split state
+ *
+ * Return: true on success, false if not supported by the HW.
+ */
+bool idpf_vport_set_hsplit(const struct idpf_vport *vport, u8 val)
+{
+	struct idpf_vport_user_config_data *config;
+
+	if (!idpf_is_hsplit_supported(vport))
+		return val == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
+
+	config = &vport->adapter->vport_config[vport->idx]->user_config;
+
+	switch (val) {
+	case ETHTOOL_TCP_DATA_SPLIT_UNKNOWN:
+		/* Default is to enable */
+	case ETHTOOL_TCP_DATA_SPLIT_ENABLED:
+		__set_bit(__IDPF_USER_FLAG_HSPLIT, config->user_flags);
+		return true;
+	case ETHTOOL_TCP_DATA_SPLIT_DISABLED:
+		__clear_bit(__IDPF_USER_FLAG_HSPLIT, config->user_flags);
+		return true;
+	default:
+		return false;
+	}
+}
+
 /**
  * idpf_vport_alloc - Allocates the next available struct vport in the adapter
  * @adapter: board private structure
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 29d2191737d5..c01fdfd41d98 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1240,12 +1240,15 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_queue *q;
 	int i, k, err = 0;
+	bool hs;
 
 	vport->rxq_grps = kcalloc(vport->num_rxq_grp,
 				  sizeof(struct idpf_rxq_group), GFP_KERNEL);
 	if (!vport->rxq_grps)
 		return -ENOMEM;
 
+	hs = idpf_vport_get_hsplit(vport) == ETHTOOL_TCP_DATA_SPLIT_ENABLED;
+
 	for (i = 0; i < vport->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
 		int j;
@@ -1298,9 +1301,8 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 			q->rx_buf_size = vport->bufq_size[j];
 			q->rx_buffer_low_watermark = IDPF_LOW_WATERMARK;
 			q->rx_buf_stride = IDPF_RX_BUF_STRIDE;
-			if (idpf_is_cap_ena_all(adapter, IDPF_HSPLIT_CAPS,
-						IDPF_CAP_HSPLIT) &&
-			    idpf_is_queue_model_split(vport->rxq_model)) {
+
+			if (hs) {
 				q->rx_hsplit_en = true;
 				q->rx_hbuf_size = IDPF_HDR_BUF_SIZE;
 			}
@@ -1344,9 +1346,7 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 				rx_qgrp->splitq.rxq_sets[j]->refillq1 =
 				      &rx_qgrp->splitq.bufq_sets[1].refillqs[j];
 
-			if (idpf_is_cap_ena_all(adapter, IDPF_HSPLIT_CAPS,
-						IDPF_CAP_HSPLIT) &&
-			    idpf_is_queue_model_split(vport->rxq_model)) {
+			if (hs) {
 				q->rx_hsplit_en = true;
 				q->rx_hbuf_size = IDPF_HDR_BUF_SIZE;
 			}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 2c1b051fdc0d..d0cdd63b3d5b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3285,6 +3285,8 @@ void idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
 	memcpy(vport->rx_itr_profile, rx_itr, IDPF_DIM_PROFILE_SLOTS);
 	memcpy(vport->tx_itr_profile, tx_itr, IDPF_DIM_PROFILE_SLOTS);
 
+	idpf_vport_set_hsplit(vport, ETHTOOL_TCP_DATA_SPLIT_ENABLED);
+
 	idpf_vport_init_num_qs(vport, vport_msg);
 	idpf_vport_calc_num_q_desc(vport);
 	idpf_vport_calc_num_q_groups(vport);
-- 
2.43.0

