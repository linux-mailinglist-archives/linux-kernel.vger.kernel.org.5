Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185BF76711E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjG1Pxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjG1Pxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:53:44 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF7830CA;
        Fri, 28 Jul 2023 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690559621; x=1722095621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K8hnEpSO4NEmhv2B91ygqqg0vtM8shWny295zPJqMBw=;
  b=aA9ooUiRP66VvFVjvQV/CZBrHhVQ4EVSBIX9rKfMcsfsbBAHYWw6ccaH
   qtSkdlSQdc0PPY1EfvA7aX8Or7/IDxJmsrxjyWdTOJFKQ5useboLMBEvV
   UYiPgDEMgQDqoJ3La+zm0PqAr9ACV2fXWntFzMud6CDmOy0ypDLXYaOS+
   t5KsRqCogFc2C2JhTclMNtymaQ+5ir1yM5C1g2qaK6d3UFOwcqSc3uwWC
   rSIZRYjoBLe8+y9DCrFtsZh1Fzuu/xWYP2c4MUtKTHJ6/ta22lTg9V/XU
   W+bv4RWYerALO1oT0Pr6s30ARsH2C+KgGrFgbuuMLvOxGQFsQ/5U52cwe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="372246680"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="372246680"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 08:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="727512169"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="727512169"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga002.jf.intel.com with ESMTP; 28 Jul 2023 08:53:38 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] virtchnl: fix fake 1-elem arrays in structures allocated as `nents + 1`
Date:   Fri, 28 Jul 2023 17:52:06 +0200
Message-ID: <20230728155207.10042-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728155207.10042-1-aleksander.lobakin@intel.com>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are five virtchnl structures, which are allocated and checked in
the code as `nents + 1`, meaning that they always have memory for one
excessive element regardless of their actual number. This comes from
that their sizeof() includes space for 1 element and then they get
allocated via struct_size() or its open-coded equivalents, passing
the actual number of elements.
Expand virtchnl_struct_size() to handle such structures and replace
those 1-elem arrays with proper flex ones. Also fix several places
which open-code %IAVF_VIRTCHNL_VF_RESOURCE_SIZE. Finally, let the
virtchnl_ether_addr_list size be computed automatically when there's
no enough space for the whole list, otherwise we have to open-code
reverse struct_size() logics.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  2 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |  6 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 44 +++++++-------
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  2 +-
 include/linux/avf/virtchnl.h                  | 57 ++++++++++++-------
 5 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 398fb4854cbe..030738409f76 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2103,7 +2103,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	len = struct_size(vfres, vsi_res, num_vsis);
+	len = virtchnl_struct_size(vfres, vsi_res, num_vsis);
 	vfres = kzalloc(len, GFP_KERNEL);
 	if (!vfres) {
 		aq_ret = I40E_ERR_NO_MEMORY;
diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 8cbdebc5b698..85fba85fbb23 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -92,9 +92,9 @@ struct iavf_vsi {
 #define IAVF_MBPS_DIVISOR	125000 /* divisor to convert to Mbps */
 #define IAVF_MBPS_QUANTA	50
 
-#define IAVF_VIRTCHNL_VF_RESOURCE_SIZE (sizeof(struct virtchnl_vf_resource) + \
-					(IAVF_MAX_VF_VSI * \
-					 sizeof(struct virtchnl_vsi_resource)))
+#define IAVF_VIRTCHNL_VF_RESOURCE_SIZE					\
+	virtchnl_struct_size((struct virtchnl_vf_resource *)NULL,	\
+			     vsi_res, IAVF_MAX_VF_VSI)
 
 /* MAX_MSIX_Q_VECTORS of these are allocated,
  * but we only use one per queue-specific vector.
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 10f03054a603..4fdac698eb38 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -215,8 +215,7 @@ int iavf_get_vf_config(struct iavf_adapter *adapter)
 	u16 len;
 	int err;
 
-	len = sizeof(struct virtchnl_vf_resource) +
-		IAVF_MAX_VF_VSI * sizeof(struct virtchnl_vsi_resource);
+	len = IAVF_VIRTCHNL_VF_RESOURCE_SIZE;
 	event.buf_len = len;
 	event.msg_buf = kzalloc(len, GFP_KERNEL);
 	if (!event.msg_buf)
@@ -284,7 +283,7 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 		return;
 	}
 	adapter->current_op = VIRTCHNL_OP_CONFIG_VSI_QUEUES;
-	len = struct_size(vqci, qpair, pairs);
+	len = virtchnl_struct_size(vqci, qpair, pairs);
 	vqci = kzalloc(len, GFP_KERNEL);
 	if (!vqci)
 		return;
@@ -397,7 +396,7 @@ void iavf_map_queues(struct iavf_adapter *adapter)
 
 	q_vectors = adapter->num_msix_vectors - NONQ_VECS;
 
-	len = struct_size(vimi, vecmap, adapter->num_msix_vectors);
+	len = virtchnl_struct_size(vimi, vecmap, adapter->num_msix_vectors);
 	vimi = kzalloc(len, GFP_KERNEL);
 	if (!vimi)
 		return;
@@ -476,13 +475,11 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
 	}
 	adapter->current_op = VIRTCHNL_OP_ADD_ETH_ADDR;
 
-	len = struct_size(veal, list, count);
+	len = virtchnl_struct_size(veal, list, count);
 	if (len > IAVF_MAX_AQ_BUF_SIZE) {
 		dev_warn(&adapter->pdev->dev, "Too many add MAC changes in one request\n");
-		count = (IAVF_MAX_AQ_BUF_SIZE -
-			 sizeof(struct virtchnl_ether_addr_list)) /
-			sizeof(struct virtchnl_ether_addr);
-		len = struct_size(veal, list, count);
+		while (len > IAVF_MAX_AQ_BUF_SIZE)
+			len = virtchnl_struct_size(veal, list, --count);
 		more = true;
 	}
 
@@ -547,13 +544,11 @@ void iavf_del_ether_addrs(struct iavf_adapter *adapter)
 	}
 	adapter->current_op = VIRTCHNL_OP_DEL_ETH_ADDR;
 
-	len = struct_size(veal, list, count);
+	len = virtchnl_struct_size(veal, list, count);
 	if (len > IAVF_MAX_AQ_BUF_SIZE) {
 		dev_warn(&adapter->pdev->dev, "Too many delete MAC changes in one request\n");
-		count = (IAVF_MAX_AQ_BUF_SIZE -
-			 sizeof(struct virtchnl_ether_addr_list)) /
-			sizeof(struct virtchnl_ether_addr);
-		len = struct_size(veal, list, count);
+		while (len > IAVF_MAX_AQ_BUF_SIZE)
+			len = virtchnl_struct_size(veal, list, --count);
 		more = true;
 	}
 	veal = kzalloc(len, GFP_ATOMIC);
@@ -687,12 +682,12 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 
 		adapter->current_op = VIRTCHNL_OP_ADD_VLAN;
 
-		len = sizeof(*vvfl) + (count * sizeof(u16));
+		len = virtchnl_struct_size(vvfl, vlan_id, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
 			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
-			count = (IAVF_MAX_AQ_BUF_SIZE - sizeof(*vvfl)) /
-				sizeof(u16);
-			len = sizeof(*vvfl) + (count * sizeof(u16));
+			while (len > IAVF_MAX_AQ_BUF_SIZE)
+				len = virtchnl_struct_size(vvfl, vlan_id,
+							   --count);
 			more = true;
 		}
 		vvfl = kzalloc(len, GFP_ATOMIC);
@@ -838,12 +833,12 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		adapter->current_op = VIRTCHNL_OP_DEL_VLAN;
 
-		len = sizeof(*vvfl) + (count * sizeof(u16));
+		len = virtchnl_struct_size(vvfl, vlan_id, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
 			dev_warn(&adapter->pdev->dev, "Too many delete VLAN changes in one request\n");
-			count = (IAVF_MAX_AQ_BUF_SIZE - sizeof(*vvfl)) /
-				sizeof(u16);
-			len = sizeof(*vvfl) + (count * sizeof(u16));
+			while (len > IAVF_MAX_AQ_BUF_SIZE)
+				len = virtchnl_struct_size(vvfl, vlan_id,
+							   --count);
 			more = true;
 		}
 		vvfl = kzalloc(len, GFP_ATOMIC);
@@ -2173,9 +2168,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		}
 		break;
 	case VIRTCHNL_OP_GET_VF_RESOURCES: {
-		u16 len = sizeof(struct virtchnl_vf_resource) +
-			  IAVF_MAX_VF_VSI *
-			  sizeof(struct virtchnl_vsi_resource);
+		u16 len = IAVF_VIRTCHNL_VF_RESOURCE_SIZE;
+
 		memcpy(adapter->vf_res, msg, min(msglen, len));
 		iavf_validate_num_queues(adapter);
 		iavf_vf_parse_hw_config(&adapter->hw, adapter->vf_res);
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 625da88e7965..a5a82833cdc6 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -428,7 +428,7 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	len = sizeof(struct virtchnl_vf_resource);
+	len = virtchnl_struct_size(vfres, vsi_res, 0);
 
 	vfres = kzalloc(len, GFP_KERNEL);
 	if (!vfres) {
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 3ab207c14809..c1a20b533fc0 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -268,10 +268,11 @@ struct virtchnl_vf_resource {
 	u32 rss_key_size;
 	u32 rss_lut_size;
 
-	struct virtchnl_vsi_resource vsi_res[1];
+	struct virtchnl_vsi_resource vsi_res[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(36, virtchnl_vf_resource);
+VIRTCHNL_CHECK_STRUCT_LEN(20, virtchnl_vf_resource);
+#define virtchnl_vf_resource_LEGACY_SIZEOF	36
 
 /* VIRTCHNL_OP_CONFIG_TX_QUEUE
  * VF sends this message to set up parameters for one TX queue.
@@ -340,10 +341,11 @@ struct virtchnl_vsi_queue_config_info {
 	u16 vsi_id;
 	u16 num_queue_pairs;
 	u32 pad;
-	struct virtchnl_queue_pair_info qpair[1];
+	struct virtchnl_queue_pair_info qpair[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_vsi_queue_config_info);
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_vsi_queue_config_info);
+#define virtchnl_vsi_queue_config_info_LEGACY_SIZEOF	72
 
 /* VIRTCHNL_OP_REQUEST_QUEUES
  * VF sends this message to request the PF to allocate additional queues to
@@ -385,10 +387,11 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_vector_map);
 
 struct virtchnl_irq_map_info {
 	u16 num_vectors;
-	struct virtchnl_vector_map vecmap[1];
+	struct virtchnl_vector_map vecmap[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
+VIRTCHNL_CHECK_STRUCT_LEN(2, virtchnl_irq_map_info);
+#define virtchnl_irq_map_info_LEGACY_SIZEOF	14
 
 /* VIRTCHNL_OP_ENABLE_QUEUES
  * VIRTCHNL_OP_DISABLE_QUEUES
@@ -459,10 +462,11 @@ VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_ether_addr);
 struct virtchnl_ether_addr_list {
 	u16 vsi_id;
 	u16 num_elements;
-	struct virtchnl_ether_addr list[1];
+	struct virtchnl_ether_addr list[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_ether_addr_list);
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_ether_addr_list);
+#define virtchnl_ether_addr_list_LEGACY_SIZEOF	12
 
 /* VIRTCHNL_OP_ADD_VLAN
  * VF sends this message to add one or more VLAN tag filters for receives.
@@ -481,10 +485,11 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_ether_addr_list);
 struct virtchnl_vlan_filter_list {
 	u16 vsi_id;
 	u16 num_elements;
-	u16 vlan_id[1];
+	u16 vlan_id[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vlan_filter_list);
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_vlan_filter_list);
+#define virtchnl_vlan_filter_list_LEGACY_SIZEOF	6
 
 /* This enum is used for all of the VIRTCHNL_VF_OFFLOAD_VLAN_V2_CAPS related
  * structures and opcodes.
@@ -1372,11 +1377,19 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_fdir_del);
 #define __vss_byone(p, member, count, old)				      \
 	(struct_size(p, member, count) + (old - 1 - struct_size(p, member, 0)))
 
+#define __vss_full(p, member, count, old)				      \
+	(struct_size(p, member, count) + (old - struct_size(p, member, 0)))
+
 #define __vss(type, func, p, member, count)		\
 	struct type: func(p, member, count, type##_LEGACY_SIZEOF)
 
 #define virtchnl_struct_size(p, m, c)					      \
 	_Generic(*p,							      \
+		 __vss(virtchnl_vf_resource, __vss_full, p, m, c),	      \
+		 __vss(virtchnl_vsi_queue_config_info, __vss_full, p, m, c),  \
+		 __vss(virtchnl_irq_map_info, __vss_full, p, m, c),	      \
+		 __vss(virtchnl_ether_addr_list, __vss_full, p, m, c),	      \
+		 __vss(virtchnl_vlan_filter_list, __vss_full, p, m, c),	      \
 		 __vss(virtchnl_rss_key, __vss_byone, p, m, c),		      \
 		 __vss(virtchnl_rss_lut, __vss_byone, p, m, c))
 
@@ -1414,24 +1427,23 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		valid_len = sizeof(struct virtchnl_rxq_info);
 		break;
 	case VIRTCHNL_OP_CONFIG_VSI_QUEUES:
-		valid_len = sizeof(struct virtchnl_vsi_queue_config_info);
+		valid_len = virtchnl_vsi_queue_config_info_LEGACY_SIZEOF;
 		if (msglen >= valid_len) {
 			struct virtchnl_vsi_queue_config_info *vqc =
 			    (struct virtchnl_vsi_queue_config_info *)msg;
-			valid_len += (vqc->num_queue_pairs *
-				      sizeof(struct
-					     virtchnl_queue_pair_info));
+			valid_len = virtchnl_struct_size(vqc, qpair,
+							 vqc->num_queue_pairs);
 			if (vqc->num_queue_pairs == 0)
 				err_msg_format = true;
 		}
 		break;
 	case VIRTCHNL_OP_CONFIG_IRQ_MAP:
-		valid_len = sizeof(struct virtchnl_irq_map_info);
+		valid_len = virtchnl_irq_map_info_LEGACY_SIZEOF;
 		if (msglen >= valid_len) {
 			struct virtchnl_irq_map_info *vimi =
 			    (struct virtchnl_irq_map_info *)msg;
-			valid_len += (vimi->num_vectors *
-				      sizeof(struct virtchnl_vector_map));
+			valid_len = virtchnl_struct_size(vimi, vecmap,
+							 vimi->num_vectors);
 			if (vimi->num_vectors == 0)
 				err_msg_format = true;
 		}
@@ -1442,23 +1454,24 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		break;
 	case VIRTCHNL_OP_ADD_ETH_ADDR:
 	case VIRTCHNL_OP_DEL_ETH_ADDR:
-		valid_len = sizeof(struct virtchnl_ether_addr_list);
+		valid_len = virtchnl_ether_addr_list_LEGACY_SIZEOF;
 		if (msglen >= valid_len) {
 			struct virtchnl_ether_addr_list *veal =
 			    (struct virtchnl_ether_addr_list *)msg;
-			valid_len += veal->num_elements *
-			    sizeof(struct virtchnl_ether_addr);
+			valid_len = virtchnl_struct_size(veal, list,
+							 veal->num_elements);
 			if (veal->num_elements == 0)
 				err_msg_format = true;
 		}
 		break;
 	case VIRTCHNL_OP_ADD_VLAN:
 	case VIRTCHNL_OP_DEL_VLAN:
-		valid_len = sizeof(struct virtchnl_vlan_filter_list);
+		valid_len = virtchnl_vlan_filter_list_LEGACY_SIZEOF;
 		if (msglen >= valid_len) {
 			struct virtchnl_vlan_filter_list *vfl =
 			    (struct virtchnl_vlan_filter_list *)msg;
-			valid_len += vfl->num_elements * sizeof(u16);
+			valid_len = virtchnl_struct_size(vfl, vlan_id,
+							 vfl->num_elements);
 			if (vfl->num_elements == 0)
 				err_msg_format = true;
 		}
-- 
2.41.0

