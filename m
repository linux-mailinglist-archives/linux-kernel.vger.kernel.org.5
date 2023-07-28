Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8021767120
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjG1Px4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbjG1Pxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:53:52 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937E430E3;
        Fri, 28 Jul 2023 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690559628; x=1722095628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sp90x8Aympfbhv6YX45jce6ztvd6ep9AwsU6mORg0Yo=;
  b=IIcglDO8xE/sJv4JXEH9e1deDsCuLlqMrCASabe3pAVO8GQ7QGYX4aC6
   jY51zotS2aF8w5xVUmsmUrf0Nufu4HuKDYcgmubZVKfg+DuF0wb2dGK/b
   db841wP4PjZKmHTGSCRQILKXnc9WJuOiyVEhEqqwki3eiikSnH46ID/Xz
   Sz/qqC0TTtixZbba+dxu/Bv7CRj9uy4aO8L7DNIPqCxN9mOYFUw3LPW1p
   hg79gvEEF651YnEK5X4yS/9lN+5abYdS9hV38zYzYSIgFyZ/ozDMmQbfM
   hfEIJkwYmOm9p5/DZM5qw4VVdsPSNAqjgjp/W6C8BoKJvWjxpY+POX4lt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="372246706"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="372246706"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 08:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="727512175"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="727512175"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga002.jf.intel.com with ESMTP; 28 Jul 2023 08:53:41 -0700
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
Subject: [PATCH net-next 3/3] virtchnl: fix fake 1-elem arrays for structures allocated as `nents`
Date:   Fri, 28 Jul 2023 17:52:07 +0200
Message-ID: <20230728155207.10042-4-aleksander.lobakin@intel.com>
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

Finally, fix 3 structures which are allocated technically correctly,
i.e. the calculated size equals to the one that struct_size() would
return, except for sizeof(). For &virtchnl_vlan_filter_list_v2, use
the same approach when there are no enough space as taken previously
for &virtchnl_vlan_filter_list, i.e. let the maximum size be calculated
automatically instead of trying to guestimate it using maths.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  7 ++--
 drivers/net/ethernet/intel/iavf/iavf_client.c |  4 +-
 drivers/net/ethernet/intel/iavf/iavf_client.h |  2 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 25 +++++-------
 include/linux/avf/virtchnl.h                  | 39 ++++++++++++-------
 5 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 030738409f76..90a76e927fab 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -506,6 +506,7 @@ i40e_config_rdma_qvlist(struct i40e_vf *vf,
 	struct virtchnl_rdma_qv_info *qv_info;
 	u32 v_idx, i, reg_idx, reg;
 	u32 next_q_idx, next_q_type;
+	size_t size;
 	u32 msix_vf;
 	int ret = 0;
 
@@ -521,9 +522,9 @@ i40e_config_rdma_qvlist(struct i40e_vf *vf,
 	}
 
 	kfree(vf->qvlist_info);
-	vf->qvlist_info = kzalloc(struct_size(vf->qvlist_info, qv_info,
-					      qvlist_info->num_vectors - 1),
-				  GFP_KERNEL);
+	size = virtchnl_struct_size(vf->qvlist_info, qv_info,
+				    qvlist_info->num_vectors);
+	vf->qvlist_info = kzalloc(size, GFP_KERNEL);
 	if (!vf->qvlist_info) {
 		ret = -ENOMEM;
 		goto err_out;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_client.c b/drivers/net/ethernet/intel/iavf/iavf_client.c
index 93c903c02c64..e6051b6355aa 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_client.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_client.c
@@ -469,8 +469,8 @@ static int iavf_client_setup_qvlist(struct iavf_info *ldev,
 	}
 
 	v_qvlist_info = (struct virtchnl_rdma_qvlist_info *)qvlist_info;
-	msg_size = struct_size(v_qvlist_info, qv_info,
-			       v_qvlist_info->num_vectors - 1);
+	msg_size = virtchnl_struct_size(v_qvlist_info, qv_info,
+					v_qvlist_info->num_vectors);
 
 	adapter->client_pending |= BIT(VIRTCHNL_OP_CONFIG_RDMA_IRQ_MAP);
 	err = iavf_aq_send_msg_to_pf(&adapter->hw,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_client.h b/drivers/net/ethernet/intel/iavf/iavf_client.h
index c5d51d7dc7cc..500269bc0f5b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_client.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_client.h
@@ -53,7 +53,7 @@ struct iavf_qv_info {
 
 struct iavf_qvlist_info {
 	u32 num_vectors;
-	struct iavf_qv_info qv_info[1];
+	struct iavf_qv_info qv_info[];
 };
 
 #define IAVF_CLIENT_MSIX_ALL 0xFFFFFFFF
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 4fdac698eb38..f9727e9c3d63 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -727,15 +727,12 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 			more = true;
 		}
 
-		len = sizeof(*vvfl_v2) + ((count - 1) *
-					  sizeof(struct virtchnl_vlan_filter));
+		len = virtchnl_struct_size(vvfl_v2, filters, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
 			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
-			count = (IAVF_MAX_AQ_BUF_SIZE - sizeof(*vvfl_v2)) /
-				sizeof(struct virtchnl_vlan_filter);
-			len = sizeof(*vvfl_v2) +
-				((count - 1) *
-				 sizeof(struct virtchnl_vlan_filter));
+			while (len > IAVF_MAX_AQ_BUF_SIZE)
+				len = virtchnl_struct_size(vvfl_v2, filters,
+							   --count);
 			more = true;
 		}
 
@@ -879,16 +876,12 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		adapter->current_op = VIRTCHNL_OP_DEL_VLAN_V2;
 
-		len = sizeof(*vvfl_v2) +
-			((count - 1) * sizeof(struct virtchnl_vlan_filter));
+		len = virtchnl_struct_size(vvfl_v2, filters, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
 			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
-			count = (IAVF_MAX_AQ_BUF_SIZE -
-				 sizeof(*vvfl_v2)) /
-				sizeof(struct virtchnl_vlan_filter);
-			len = sizeof(*vvfl_v2) +
-				((count - 1) *
-				 sizeof(struct virtchnl_vlan_filter));
+			while (len > IAVF_MAX_AQ_BUF_SIZE)
+				len = virtchnl_struct_size(vvfl_v2, filters,
+							   --count);
 			more = true;
 		}
 
@@ -1492,7 +1485,7 @@ void iavf_enable_channels(struct iavf_adapter *adapter)
 		return;
 	}
 
-	len = struct_size(vti, list, adapter->num_tc - 1);
+	len = virtchnl_struct_size(vti, list, adapter->num_tc);
 	vti = kzalloc(len, GFP_KERNEL);
 	if (!vti)
 		return;
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index c1a20b533fc0..d0807ad43f93 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -716,10 +716,11 @@ struct virtchnl_vlan_filter_list_v2 {
 	u16 vport_id;
 	u16 num_elements;
 	u8 pad[4];
-	struct virtchnl_vlan_filter filters[1];
+	struct virtchnl_vlan_filter filters[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_vlan_filter_list_v2);
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_vlan_filter_list_v2);
+#define virtchnl_vlan_filter_list_v2_LEGACY_SIZEOF	40
 
 /* VIRTCHNL_OP_ENABLE_VLAN_STRIPPING_V2
  * VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2
@@ -918,10 +919,11 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_channel_info);
 struct virtchnl_tc_info {
 	u32	num_tc;
 	u32	pad;
-	struct	virtchnl_channel_info list[1];
+	struct virtchnl_channel_info list[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_tc_info);
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_tc_info);
+#define virtchnl_tc_info_LEGACY_SIZEOF	24
 
 /* VIRTCHNL_ADD_CLOUD_FILTER
  * VIRTCHNL_DEL_CLOUD_FILTER
@@ -1059,10 +1061,11 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_rdma_qv_info);
 
 struct virtchnl_rdma_qvlist_info {
 	u32 num_vectors;
-	struct virtchnl_rdma_qv_info qv_info[1];
+	struct virtchnl_rdma_qv_info qv_info[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_rdma_qvlist_info);
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_rdma_qvlist_info);
+#define virtchnl_rdma_qvlist_info_LEGACY_SIZEOF	16
 
 /* VF reset states - these are written into the RSTAT register:
  * VFGEN_RSTAT on the VF
@@ -1377,6 +1380,9 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_fdir_del);
 #define __vss_byone(p, member, count, old)				      \
 	(struct_size(p, member, count) + (old - 1 - struct_size(p, member, 0)))
 
+#define __vss_byelem(p, member, count, old)				      \
+	(struct_size(p, member, count - 1) + (old - struct_size(p, member, 0)))
+
 #define __vss_full(p, member, count, old)				      \
 	(struct_size(p, member, count) + (old - struct_size(p, member, 0)))
 
@@ -1390,6 +1396,9 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_fdir_del);
 		 __vss(virtchnl_irq_map_info, __vss_full, p, m, c),	      \
 		 __vss(virtchnl_ether_addr_list, __vss_full, p, m, c),	      \
 		 __vss(virtchnl_vlan_filter_list, __vss_full, p, m, c),	      \
+		 __vss(virtchnl_vlan_filter_list_v2, __vss_byelem, p, m, c),  \
+		 __vss(virtchnl_tc_info, __vss_byelem, p, m, c),	      \
+		 __vss(virtchnl_rdma_qvlist_info, __vss_byelem, p, m, c),     \
 		 __vss(virtchnl_rss_key, __vss_byone, p, m, c),		      \
 		 __vss(virtchnl_rss_lut, __vss_byone, p, m, c))
 
@@ -1495,13 +1504,13 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 	case VIRTCHNL_OP_RELEASE_RDMA_IRQ_MAP:
 		break;
 	case VIRTCHNL_OP_CONFIG_RDMA_IRQ_MAP:
-		valid_len = sizeof(struct virtchnl_rdma_qvlist_info);
+		valid_len = virtchnl_rdma_qvlist_info_LEGACY_SIZEOF;
 		if (msglen >= valid_len) {
 			struct virtchnl_rdma_qvlist_info *qv =
 				(struct virtchnl_rdma_qvlist_info *)msg;
 
-			valid_len += ((qv->num_vectors - 1) *
-				sizeof(struct virtchnl_rdma_qv_info));
+			valid_len = virtchnl_struct_size(qv, qv_info,
+							 qv->num_vectors);
 		}
 		break;
 	case VIRTCHNL_OP_CONFIG_RSS_KEY:
@@ -1534,12 +1543,12 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		valid_len = sizeof(struct virtchnl_vf_res_request);
 		break;
 	case VIRTCHNL_OP_ENABLE_CHANNELS:
-		valid_len = sizeof(struct virtchnl_tc_info);
+		valid_len = virtchnl_tc_info_LEGACY_SIZEOF;
 		if (msglen >= valid_len) {
 			struct virtchnl_tc_info *vti =
 				(struct virtchnl_tc_info *)msg;
-			valid_len += (vti->num_tc - 1) *
-				     sizeof(struct virtchnl_channel_info);
+			valid_len = virtchnl_struct_size(vti, list,
+							 vti->num_tc);
 			if (vti->num_tc == 0)
 				err_msg_format = true;
 		}
@@ -1566,13 +1575,13 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		break;
 	case VIRTCHNL_OP_ADD_VLAN_V2:
 	case VIRTCHNL_OP_DEL_VLAN_V2:
-		valid_len = sizeof(struct virtchnl_vlan_filter_list_v2);
+		valid_len = virtchnl_vlan_filter_list_v2_LEGACY_SIZEOF;
 		if (msglen >= valid_len) {
 			struct virtchnl_vlan_filter_list_v2 *vfl =
 			    (struct virtchnl_vlan_filter_list_v2 *)msg;
 
-			valid_len += (vfl->num_elements - 1) *
-				sizeof(struct virtchnl_vlan_filter);
+			valid_len = virtchnl_struct_size(vfl, filters,
+							 vfl->num_elements);
 
 			if (vfl->num_elements == 0) {
 				err_msg_format = true;
-- 
2.41.0

