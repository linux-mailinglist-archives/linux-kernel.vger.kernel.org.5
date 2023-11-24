Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E0F7F7721
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345559AbjKXPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345384AbjKXPDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:03:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5109199B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700838238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzT38EB5Vz7XmhOiADNWFVzR7hQPGPO4UzigtBxw1ew=;
        b=WQdPjpWX25SVoC0rjaw2qZBLhM/UgYNbnDn0ICnF9v0R1+8rjycfw/k7d82UXNeEylv3Pz
        hgdRJSUzZy1iX1bEGCoOZBUduOGKM2Ot+hvXp2tiYBYFDDwYhH/DnOhy8LTkJrbfBv4F4F
        jqGTJw+gImf3yAH+xy4TJWEdYPtpbws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-Kbqmusr9PQ-benKtCl4rZA-1; Fri, 24 Nov 2023 10:03:53 -0500
X-MC-Unique: Kbqmusr9PQ-benKtCl4rZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FBB783B822;
        Fri, 24 Nov 2023 15:03:53 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.226.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B0F140C6EB9;
        Fri, 24 Nov 2023 15:03:51 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Simon Horman <horms@kernel.org>, mschmidt@redhat.com,
        netdev@vger.kernel.org
Subject: [PATCH v5 3/5] i40e: Add helpers to find VSI and VEB by SEID and use them
Date:   Fri, 24 Nov 2023 16:03:41 +0100
Message-ID: <20231124150343.81520-4-ivecera@redhat.com>
In-Reply-To: <20231124150343.81520-1-ivecera@redhat.com>
References: <20231124150343.81520-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two helpers i40e_(veb|vsi)_get_by_seid() to find corresponding
VEB or VSI by their SEID value and use these helpers to replace
existing open-coded loops.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 36 +++++++++
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 38 ++-------
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 80 +++++++------------
 3 files changed, 68 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 08cea99150bc..000fd78cfa31 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1360,4 +1360,40 @@ static inline struct i40e_pf *i40e_hw_to_pf(struct i40e_hw *hw)
 
 struct device *i40e_hw_to_dev(struct i40e_hw *hw);
 
+/**
+ * i40e_pf_get_vsi_by_seid - find VSI by SEID
+ * @pf: pointer to a PF
+ * @seid: SEID of the VSI
+ **/
+static inline struct i40e_vsi *
+i40e_pf_get_vsi_by_seid(struct i40e_pf *pf, u16 seid)
+{
+	struct i40e_vsi *vsi;
+	int i;
+
+	i40e_pf_for_each_vsi(pf, i, vsi)
+		if (vsi->seid == seid)
+			return vsi;
+
+	return NULL;
+}
+
+/**
+ * i40e_pf_get_veb_by_seid - find VEB by SEID
+ * @pf: pointer to a PF
+ * @seid: SEID of the VSI
+ **/
+static inline struct i40e_veb *
+i40e_pf_get_veb_by_seid(struct i40e_pf *pf, u16 seid)
+{
+	struct i40e_veb *veb;
+	int i;
+
+	i40e_pf_for_each_veb(pf, i, veb)
+		if (veb->seid == seid)
+			return veb;
+
+	return NULL;
+}
+
 #endif /* _I40E_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index b236b0f93202..990a60889eef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -24,37 +24,13 @@ enum ring_type {
  **/
 static struct i40e_vsi *i40e_dbg_find_vsi(struct i40e_pf *pf, int seid)
 {
-	struct i40e_vsi *vsi;
-	int i;
-
 	if (seid < 0) {
 		dev_info(&pf->pdev->dev, "%d: bad seid\n", seid);
 
 		return NULL;
 	}
 
-	i40e_pf_for_each_vsi(pf, i, vsi)
-		if (vsi->seid == seid)
-			return vsi;
-
-	return NULL;
-}
-
-/**
- * i40e_dbg_find_veb - searches for the veb with the given seid
- * @pf: the PF structure to search for the veb
- * @seid: seid of the veb it is searching for
- **/
-static struct i40e_veb *i40e_dbg_find_veb(struct i40e_pf *pf, int seid)
-{
-	struct i40e_veb *veb;
-	int i;
-
-	i40e_pf_for_each_veb(pf, i, veb)
-		if (veb->seid == seid)
-			return veb;
-
-	return NULL;
+	return i40e_pf_get_vsi_by_seid(pf, seid);
 }
 
 /**************************************************************
@@ -701,7 +677,7 @@ static void i40e_dbg_dump_veb_seid(struct i40e_pf *pf, int seid)
 {
 	struct i40e_veb *veb;
 
-	veb = i40e_dbg_find_veb(pf, seid);
+	veb = i40e_pf_get_veb_by_seid(pf, seid);
 	if (!veb) {
 		dev_info(&pf->pdev->dev, "can't find veb %d\n", seid);
 		return;
@@ -853,7 +829,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 
 	} else if (strncmp(cmd_buf, "add relay", 9) == 0) {
 		struct i40e_veb *veb;
-		int uplink_seid, i;
+		int uplink_seid;
 
 		cnt = sscanf(&cmd_buf[9], "%i %i", &uplink_seid, &vsi_seid);
 		if (cnt != 2) {
@@ -875,12 +851,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			goto command_write_done;
 		}
 
-		i40e_pf_for_each_veb(pf, i, veb)
-			if (veb->seid == uplink_seid)
-				break;
-
-		if (i >= I40E_MAX_VEB && uplink_seid != 0 &&
-		    uplink_seid != pf->mac_seid) {
+		veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
+		if (!veb && uplink_seid != 0 && uplink_seid != pf->mac_seid) {
 			dev_info(&pf->pdev->dev,
 				 "add relay: relay uplink %d not found\n",
 				 uplink_seid);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3a973a92779f..245de0d41f45 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13120,18 +13120,14 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
 	struct i40e_pf *pf = vsi->back;
 	struct nlattr *attr, *br_spec;
 	struct i40e_veb *veb;
-	int i, rem;
+	int rem;
 
 	/* Only for PF VSI for now */
 	if (vsi->seid != pf->vsi[pf->lan_vsi]->seid)
 		return -EOPNOTSUPP;
 
 	/* Find the HW bridge for PF VSI */
-	i40e_pf_for_each_veb(pf, i, veb)
-		if (veb->seid == vsi->uplink_seid)
-			break;
-	if (i == I40E_MAX_VEB)
-		veb = NULL; /* No VEB found */
+	veb = i40e_pf_get_veb_by_seid(pf, vsi->uplink_seid);
 
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
 	if (!br_spec)
@@ -13196,18 +13192,15 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	struct i40e_netdev_priv *np = netdev_priv(dev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	struct i40e_veb *veb = NULL;
-	int i;
+	struct i40e_veb *veb;
 
 	/* Only for PF VSI for now */
 	if (vsi->seid != pf->vsi[pf->lan_vsi]->seid)
 		return -EOPNOTSUPP;
 
 	/* Find the HW bridge for the PF VSI */
-	i40e_pf_for_each_veb(pf, i, veb)
-		if (veb->seid == vsi->uplink_seid)
-			break;
-	if (i == I40E_MAX_VEB)
+	veb = i40e_pf_get_veb_by_seid(pf, vsi->uplink_seid);
+	if (!veb)
 		return 0;
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, veb->bridge_mode,
@@ -14382,8 +14375,8 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	struct i40e_vsi *vsi = NULL;
 	struct i40e_veb *veb = NULL;
 	u16 alloc_queue_pairs;
-	int ret, i;
 	int v_idx;
+	int ret;
 
 	/* The requested uplink_seid must be either
 	 *     - the PF's port seid
@@ -14398,18 +14391,10 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	 *
 	 * Find which uplink_seid we were given and create a new VEB if needed
 	 */
-	i40e_pf_for_each_veb(pf, i, veb)
-		if (veb->seid == uplink_seid)
-			break;
-	if (i == I40E_MAX_VEB)
-		veb = NULL;
-
+	veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
 	if (!veb && uplink_seid != pf->mac_seid) {
-		i40e_pf_for_each_vsi(pf, i, vsi)
-			if (vsi->seid == uplink_seid)
-				break;
-
-		if (i == pf->num_alloc_vsi) {
+		vsi = i40e_pf_get_vsi_by_seid(pf, uplink_seid);
+		if (!vsi) {
 			dev_info(&pf->pdev->dev, "no such uplink_seid %d\n",
 				 uplink_seid);
 			return NULL;
@@ -14437,10 +14422,8 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 			}
 			i40e_config_bridge_mode(veb);
 		}
-		i40e_pf_for_each_veb(pf, i, veb)
-			if (veb->seid == vsi->uplink_seid)
-				break;
-		if (i == I40E_MAX_VEB) {
+		veb = i40e_pf_get_veb_by_seid(pf, vsi->uplink_seid);
+		if (!veb) {
 			dev_info(&pf->pdev->dev, "couldn't add VEB\n");
 			return NULL;
 		}
@@ -14834,8 +14817,8 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 				u8 enabled_tc)
 {
 	struct i40e_veb *veb, *uplink_veb = NULL;
-	struct i40e_vsi *vsi;
-	int vsi_idx, veb_idx;
+	struct i40e_vsi *vsi = NULL;
+	int veb_idx;
 	int ret;
 
 	/* if one seid is 0, the other must be 0 to create a floating relay */
@@ -14848,23 +14831,16 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 	}
 
 	/* make sure there is such a vsi and uplink */
-	i40e_pf_for_each_vsi(pf, vsi_idx, vsi)
-		if (vsi->seid == vsi_seid)
-			break;
-
-	if (vsi_idx == pf->num_alloc_vsi && vsi_seid != 0) {
-		dev_info(&pf->pdev->dev, "vsi seid %d not found\n",
-			 vsi_seid);
-		return NULL;
+	if (vsi_seid) {
+		vsi = i40e_pf_get_vsi_by_seid(pf, vsi_seid);
+		if (!vsi) {
+			dev_err(&pf->pdev->dev, "vsi seid %d not found\n",
+				vsi_seid);
+			return NULL;
+		}
 	}
-
 	if (uplink_seid && uplink_seid != pf->mac_seid) {
-		i40e_pf_for_each_veb(pf, veb_idx, veb) {
-			if (veb->seid == uplink_seid) {
-				uplink_veb = veb;
-				break;
-			}
-		}
+		uplink_veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
 		if (!uplink_veb) {
 			dev_info(&pf->pdev->dev,
 				 "uplink seid %d not found\n", uplink_seid);
@@ -14886,7 +14862,8 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 	ret = i40e_add_veb(veb, vsi);
 	if (ret)
 		goto err_veb;
-	if (vsi_idx == pf->lan_vsi)
+
+	if (vsi && vsi->idx == pf->lan_vsi)
 		pf->lan_veb = veb->idx;
 
 	return veb;
@@ -14933,13 +14910,10 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
 			int v;
 
 			/* find existing or else empty VEB */
-			i40e_pf_for_each_veb(pf, v, veb)
-				if (veb->seid == seid) {
-					pf->lan_veb = v;
-					break;
-				}
-
-			if (pf->lan_veb >= I40E_MAX_VEB) {
+			veb = i40e_pf_get_veb_by_seid(pf, seid);
+			if (veb) {
+				pf->lan_veb = veb->idx;
+			} else {
 				v = i40e_veb_mem_alloc(pf);
 				if (v < 0)
 					break;
-- 
2.41.0

