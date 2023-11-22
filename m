Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F7E7F436C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343861AbjKVKQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjKVKQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:16:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171E3D54
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700648167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oySq5XVgxsv/HsqFILiBXdMj2mdTFkEjEA43I45DQM0=;
        b=E4+wCXGP/RLfHSxbSjYlr0KrkkSdiJVQX6BbVwH7GId9wWD6RgkXMd4tj3jmCnfz5/aDaH
        r6QJUh/ymBdjiLwFs67Twh8eFLl/8yC9/86GEO59eWnaKTdqtLTDJ1RE4296jcvO6MYPog
        deFYetdAx7tSeJ+1vUfWQMh4ewFLi9w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-QRxljK-6Nfy1DP6R_ya-_A-1; Wed,
 22 Nov 2023 05:16:00 -0500
X-MC-Unique: QRxljK-6Nfy1DP6R_ya-_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B6A03804513;
        Wed, 22 Nov 2023 10:15:59 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.226.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F56310EA1;
        Wed, 22 Nov 2023 10:15:57 +0000 (UTC)
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
Subject: [PATCH v4 5/5] i40e: Remove VEB recursion
Date:   Wed, 22 Nov 2023 11:15:45 +0100
Message-ID: <20231122101545.28819-6-ivecera@redhat.com>
In-Reply-To: <20231122101545.28819-1-ivecera@redhat.com>
References: <20231122101545.28819-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VEB (virtual embedded switch) as a switch element can be
connected according datasheet though its uplink to:
- Physical port
- Port Virtualizer (not used directly by i40e driver but can
  be present in MFP mode where the physical port is shared
  between PFs)
- No uplink (aka floating VEB)

But VEB uplink cannot be connected to another VEB and any attempt
to do so results in:

"i40e 0000:02:00.0: couldn't add VEB, err -EIO aq_err I40E_AQ_RC_ENOENT"

that indicates "the uplink SEID does not point to valid element".

Remove this logic from the driver code this way:

1) For debugfs only allow to build floating VEB (uplink_seid == 0)
   or main VEB (uplink_seid == mac_seid)
2) Do not recurse in i40e_veb_link_event() as no VEB cannot have
   sub-VEBs
3) Ditto for i40e_veb_rebuild() + simplify the function as we know
   that the VEB for rebuild can be only the main LAN VEB or some
   of the floating VEBs
4) In i40e_rebuild() there is no need to check veb->uplink_seid
   as the possible ones are 0 and MAC SEID
5) In i40e_vsi_release() do not take into account VEBs whose
   uplink is another VEB as this is not possible
6) Remove veb_idx field from i40e_veb as a VEB cannot have
   sub-VEBs

Tested using i40e debugfs interface:
1) Initial state
[root@cnb-03 net-next]# CMD="/sys/kernel/debug/i40e/0000:02:00.0/command"
[root@cnb-03 net-next]# echo dump switch > $CMD
[root@cnb-03 net-next]# dmesg -c
[   98.440641] i40e 0000:02:00.0: header: 3 reported 3 total
[   98.446053] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[   98.452593] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[   98.458856] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

2) Add floating VEB
[root@cnb-03 net-next]# echo add relay > $CMD
[root@cnb-03 net-next]# dmesg -c
[  122.745630] i40e 0000:02:00.0: added relay 162
[root@cnb-03 net-next]# echo dump switch > $CMD
[root@cnb-03 net-next]# dmesg -c
[  136.650049] i40e 0000:02:00.0: header: 4 reported 4 total
[  136.655466] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  136.661994] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  136.668264] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
[  136.674787] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0

3) Add VMDQ2 VSI to this new VEB
[root@cnb-03 net-next]# dmesg -c
[  168.351763] i40e 0000:02:00.0: added VSI 394 to relay 162
[  168.374652] enp2s0f0np0v0: NIC Link is Up, 40 Gbps Full Duplex, Flow Control: None
[root@cnb-03 net-next]# echo dump switch > $CMD
[root@cnb-03 net-next]# dmesg -c
[  195.683204] i40e 0000:02:00.0: header: 5 reported 5 total
[  195.688611] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
[  195.695143] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
[  195.701410] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  195.707935] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  195.714201] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

4) Try to delete the VEB
[root@cnb-03 net-next]# echo del relay 162 > $CMD
[root@cnb-03 net-next]# dmesg -c
[  239.260901] i40e 0000:02:00.0: deleting relay 162
[  239.265621] i40e 0000:02:00.0: can't remove VEB 162 with 1 VSIs left

5) Do PF reset and check switch status after rebuild
[root@cnb-03 net-next]# echo pfr > $CMD
[root@cnb-03 net-next]# echo dump switch > $CMD
[root@cnb-03 net-next]# dmesg -c
...
[  272.333655] i40e 0000:02:00.0: header: 5 reported 5 total
[  272.339066] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
[  272.345599] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
[  272.351862] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  272.358387] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  272.364654] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

6) Delete VSI and delete VEB
[  297.199116] i40e 0000:02:00.0: deleting VSI 394
[  299.807580] i40e 0000:02:00.0: deleting relay 162
[  309.767905] i40e 0000:02:00.0: header: 3 reported 3 total
[  309.773318] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  309.779845] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  309.786111] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |   1 -
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 176 ++++++++----------
 3 files changed, 76 insertions(+), 109 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index c129e86d4f8b..cc7d92f1170d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -783,7 +783,6 @@ struct i40e_new_mac_filter {
 struct i40e_veb {
 	struct i40e_pf *pf;
 	u16 idx;
-	u16 veb_idx;		/* index of VEB parent */
 	u16 seid;
 	u16 uplink_seid;
 	u16 stats_idx;		/* index of VEB parent */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 921a97d5479e..f9ba45f596c9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -683,9 +683,8 @@ static void i40e_dbg_dump_veb_seid(struct i40e_pf *pf, int seid)
 		return;
 	}
 	dev_info(&pf->pdev->dev,
-		 "veb idx=%d,%d stats_ic=%d  seid=%d uplink=%d mode=%s\n",
-		 veb->idx, veb->veb_idx, veb->stats_idx, veb->seid,
-		 veb->uplink_seid,
+		 "veb idx=%d stats_ic=%d  seid=%d uplink=%d mode=%s\n",
+		 veb->idx, veb->stats_idx, veb->seid, veb->uplink_seid,
 		 veb->bridge_mode == BRIDGE_MODE_VEPA ? "VEPA" : "VEB");
 	i40e_dbg_dump_eth_stats(pf, &veb->stats);
 }
@@ -848,8 +847,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			goto command_write_done;
 		}
 
-		veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
-		if (!veb && uplink_seid != 0 && uplink_seid != pf->mac_seid) {
+		if (uplink_seid != 0 && uplink_seid != pf->mac_seid) {
 			dev_info(&pf->pdev->dev,
 				 "add relay: relay uplink %d not found\n",
 				 uplink_seid);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e0f860be51be..1ae205c9a8f6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9871,7 +9871,6 @@ static void i40e_vsi_link_event(struct i40e_vsi *vsi, bool link_up)
  **/
 static void i40e_veb_link_event(struct i40e_veb *veb, bool link_up)
 {
-	struct i40e_veb *veb_it;
 	struct i40e_vsi *vsi;
 	struct i40e_pf *pf;
 	int i;
@@ -9880,12 +9879,7 @@ static void i40e_veb_link_event(struct i40e_veb *veb, bool link_up)
 		return;
 	pf = veb->pf;
 
-	/* depth first... */
-	i40e_pf_for_each_veb(pf, i, veb_it)
-		if (veb_it->uplink_seid == veb->seid)
-			i40e_veb_link_event(veb_it, link_up);
-
-	/* ... now the local VSIs */
+	/* Send link event to contained VSIs */
 	i40e_pf_for_each_vsi(pf, i, vsi)
 		if (vsi->uplink_seid == veb->seid)
 			i40e_vsi_link_event(vsi, link_up);
@@ -10363,56 +10357,57 @@ static void i40e_config_bridge_mode(struct i40e_veb *veb)
 }
 
 /**
- * i40e_reconstitute_veb - rebuild the VEB and anything connected to it
+ * i40e_reconstitute_veb - rebuild the VEB and VSIs connected to it
  * @veb: pointer to the VEB instance
  *
- * This is a recursive function that first builds the attached VSIs then
- * recurses in to build the next layer of VEB.  We track the connections
- * through our own index numbers because the seid's from the HW could
- * change across the reset.
+ * This is a function that builds the attached VSIs. We track the connections
+ * through our own index numbers because the seid's from the HW could change
+ * across the reset.
  **/
 static int i40e_reconstitute_veb(struct i40e_veb *veb)
 {
 	struct i40e_vsi *ctl_vsi = NULL;
 	struct i40e_pf *pf = veb->pf;
-	struct i40e_veb *veb_it;
 	struct i40e_vsi *vsi;
 	int v, ret;
 
-	if (veb->uplink_seid) {
-		/* Look for VSI that owns this VEB, temporarily attached to base VEB */
-		i40e_pf_for_each_vsi(pf, v, vsi)
-			if (vsi->veb_idx == veb->idx &&
-			    vsi->flags & I40E_VSI_FLAG_VEB_OWNER) {
-				ctl_vsi = vsi;
-				break;
-			}
+	/* As we do not maintain PV (port virtualizer) switch element then
+	 * there can be only one non-floating VEB that have uplink to MAC SEID
+	 * and its control VSI is the main one.
+	 */
+	if (WARN_ON(veb->uplink_seid && veb->uplink_seid != pf->mac_seid)) {
+		dev_err(&pf->pdev->dev,
+			"Invalid uplink SEID for VEB %d\n", veb->idx);
+		return -ENOENT;
+	}
 
-		if (!ctl_vsi) {
-			dev_info(&pf->pdev->dev,
-				 "missing owner VSI for veb_idx %d\n",
-				 veb->idx);
-			ret = -ENOENT;
-			goto end_reconstitute;
+	if (veb->uplink_seid == pf->mac_seid) {
+		/* Check that the LAN VSI has VEB owning flag set */
+		ctl_vsi = pf->vsi[pf->lan_vsi];
+
+		if (WARN_ON(ctl_vsi->veb_idx != veb->idx ||
+			    !(ctl_vsi->flags & I40E_VSI_FLAG_VEB_OWNER))) {
+			dev_err(&pf->pdev->dev,
+				"Invalid control VSI for VEB %d\n", veb->idx);
+			return -ENOENT;
 		}
-		if (ctl_vsi != pf->vsi[pf->lan_vsi])
-			ctl_vsi->uplink_seid =
-				pf->vsi[pf->lan_vsi]->uplink_seid;
 
+		/* Add the control VSI to switch */
 		ret = i40e_add_vsi(ctl_vsi);
 		if (ret) {
-			dev_info(&pf->pdev->dev,
-				 "rebuild of veb_idx %d owner VSI failed: %d\n",
-				 veb->idx, ret);
-			goto end_reconstitute;
+			dev_err(&pf->pdev->dev,
+				"Rebuild of owner VSI for VEB %d failed: %d\n",
+				veb->idx, ret);
+			return ret;
 		}
+
 		i40e_vsi_reset_stats(ctl_vsi);
 	}
 
 	/* create the VEB in the switch and move the VSI onto the VEB */
 	ret = i40e_add_veb(veb, ctl_vsi);
 	if (ret)
-		goto end_reconstitute;
+		return ret;
 
 	if (veb->uplink_seid) {
 		if (test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags))
@@ -10434,23 +10429,12 @@ static int i40e_reconstitute_veb(struct i40e_veb *veb)
 				dev_info(&pf->pdev->dev,
 					 "rebuild of vsi_idx %d failed: %d\n",
 					 v, ret);
-				goto end_reconstitute;
+				return ret;
 			}
 			i40e_vsi_reset_stats(vsi);
 		}
 	}
 
-	/* create any VEBs attached to this VEB - RECURSION */
-	i40e_pf_for_each_veb(pf, v, veb_it) {
-		if (veb_it->veb_idx == veb->idx) {
-			veb_it->uplink_seid = veb->seid;
-			ret = i40e_reconstitute_veb(veb_it);
-			if (ret)
-				break;
-		}
-	}
-
-end_reconstitute:
 	return ret;
 }
 
@@ -10990,31 +10974,29 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	 */
 	if (vsi->uplink_seid != pf->mac_seid) {
 		dev_dbg(&pf->pdev->dev, "attempting to rebuild switch\n");
-		/* find the one VEB connected to the MAC, and find orphans */
+
+		/* Rebuild VEBs */
 		i40e_pf_for_each_veb(pf, v, veb) {
-			if (veb->uplink_seid == pf->mac_seid ||
-			    veb->uplink_seid == 0) {
-				ret = i40e_reconstitute_veb(veb);
-				if (!ret)
-					continue;
-
-				/* If Main VEB failed, we're in deep doodoo,
-				 * so give up rebuilding the switch and set up
-				 * for minimal rebuild of PF VSI.
-				 * If orphan failed, we'll report the error
-				 * but try to keep going.
-				 */
-				if (veb->uplink_seid == pf->mac_seid) {
-					dev_info(&pf->pdev->dev,
-						 "rebuild of switch failed: %d, will try to set up simple PF connection\n",
-						 ret);
-					vsi->uplink_seid = pf->mac_seid;
-					break;
-				} else if (veb->uplink_seid == 0) {
-					dev_info(&pf->pdev->dev,
-						 "rebuild of orphan VEB failed: %d\n",
-						 ret);
-				}
+			ret = i40e_reconstitute_veb(veb);
+			if (!ret)
+				continue;
+
+			/* If Main VEB failed, we're in deep doodoo,
+			 * so give up rebuilding the switch and set up
+			 * for minimal rebuild of PF VSI.
+			 * If orphan failed, we'll report the error
+			 * but try to keep going.
+			 */
+			if (veb->uplink_seid == pf->mac_seid) {
+				dev_info(&pf->pdev->dev,
+					 "rebuild of switch failed: %d, will try to set up simple PF connection\n",
+					 ret);
+				vsi->uplink_seid = pf->mac_seid;
+				break;
+			} else if (veb->uplink_seid == 0) {
+				dev_info(&pf->pdev->dev,
+					 "rebuild of orphan VEB failed: %d\n",
+					 ret);
 			}
 		}
 	}
@@ -14138,9 +14120,9 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
  **/
 int i40e_vsi_release(struct i40e_vsi *vsi)
 {
-	struct i40e_veb *veb, *veb_it;
 	struct i40e_mac_filter *f;
 	struct hlist_node *h;
+	struct i40e_veb *veb;
 	struct i40e_pf *pf;
 	u16 uplink_seid;
 	int i, n, bkt;
@@ -14204,27 +14186,28 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 
 	/* If this was the last thing on the VEB, except for the
 	 * controlling VSI, remove the VEB, which puts the controlling
-	 * VSI onto the next level down in the switch.
+	 * VSI onto the uplink port.
 	 *
 	 * Well, okay, there's one more exception here: don't remove
-	 * the orphan VEBs yet.  We'll wait for an explicit remove request
+	 * the floating VEBs yet.  We'll wait for an explicit remove request
 	 * from up the network stack.
 	 */
-	n = 0;
-	i40e_pf_for_each_vsi(pf, i, vsi)
-		if (vsi->uplink_seid == uplink_seid &&
-		    (vsi->flags & I40E_VSI_FLAG_VEB_OWNER) == 0)
-			n++;      /* count the VSIs */
+	veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
+	if (veb && veb->uplink_seid) {
+		n = 0;
+
+		/* Count non-controlling VSIs present on  the VEB */
+		i40e_pf_for_each_vsi(pf, i, vsi)
+			if (vsi->uplink_seid == uplink_seid &&
+			    (vsi->flags & I40E_VSI_FLAG_VEB_OWNER) == 0)
+				n++;
 
-	veb = NULL;
-	i40e_pf_for_each_veb(pf, i, veb_it) {
-		if (veb_it->uplink_seid == uplink_seid)
-			n++;     /* count the VEBs */
-		if (veb_it->seid == uplink_seid)
-			veb = veb_it;
+		/* If there is no VSI except the control one then release
+		 * the VEB and put the control VSI onto VEB uplink.
+		 */
+		if (!n)
+			i40e_veb_release(veb);
 	}
-	if (n == 0 && veb && veb->uplink_seid != 0)
-		i40e_veb_release(veb);
 
 	return 0;
 }
@@ -14738,14 +14721,11 @@ void i40e_veb_release(struct i40e_veb *veb)
 		return;
 	}
 
-	/* For regular VEB move the owner VSI to uplink VEB */
+	/* For regular VEB move the owner VSI to uplink port */
 	if (veb->uplink_seid) {
 		vsi->flags &= ~I40E_VSI_FLAG_VEB_OWNER;
 		vsi->uplink_seid = veb->uplink_seid;
-		if (veb->uplink_seid == pf->mac_seid)
-			vsi->veb_idx = I40E_NO_VEB;
-		else
-			vsi->veb_idx = veb->veb_idx;
+		vsi->veb_idx = I40E_NO_VEB;
 	}
 
 	i40e_aq_delete_element(&pf->hw, veb->seid, NULL);
@@ -14825,8 +14805,8 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 				u16 uplink_seid, u16 vsi_seid,
 				u8 enabled_tc)
 {
-	struct i40e_veb *veb, *uplink_veb = NULL;
 	struct i40e_vsi *vsi = NULL;
+	struct i40e_veb *veb;
 	int veb_idx;
 	int ret;
 
@@ -14848,14 +14828,6 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 			return NULL;
 		}
 	}
-	if (uplink_seid && uplink_seid != pf->mac_seid) {
-		uplink_veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
-		if (!uplink_veb) {
-			dev_info(&pf->pdev->dev,
-				 "uplink seid %d not found\n", uplink_seid);
-			return NULL;
-		}
-	}
 
 	/* get veb sw struct */
 	veb_idx = i40e_veb_mem_alloc(pf);
@@ -14864,7 +14836,6 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 	veb = pf->veb[veb_idx];
 	veb->flags = flags;
 	veb->uplink_seid = uplink_seid;
-	veb->veb_idx = (uplink_veb ? uplink_veb->idx : I40E_NO_VEB);
 	veb->enabled_tc = (enabled_tc ? enabled_tc : 0x1);
 
 	/* create the VEB in the switch */
@@ -14935,7 +14906,6 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
 		pf->veb[pf->lan_veb]->seid = seid;
 		pf->veb[pf->lan_veb]->uplink_seid = pf->mac_seid;
 		pf->veb[pf->lan_veb]->pf = pf;
-		pf->veb[pf->lan_veb]->veb_idx = I40E_NO_VEB;
 		break;
 	case I40E_SWITCH_ELEMENT_TYPE_VSI:
 		if (num_reported != 1)
-- 
2.41.0

