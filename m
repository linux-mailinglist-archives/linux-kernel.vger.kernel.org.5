Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55777F436D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343778AbjKVKQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjKVKQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:16:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF97198
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700648164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95BwKVBjPXhwFWpJEoLnwR3trpkEEhRaSQYx6yQpkwA=;
        b=UfeC+Xu89m0+M42T6aJpvZL+IbFg7WK+SDp04sRMBusoNyzFWbN99AMKNLX2LoImYw7cik
        UPpkUnWrIotZMtmFUNOHCQBFw5qrMG+tZRuYMB8tdAhhxZAvK/DaCIco3kVZVfPVvSrUbp
        udd8d4amyWVvg1zazCkl4hyRkdypmAE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-bdK5vIg7OAqXApF77Bzhvw-1; Wed,
 22 Nov 2023 05:15:57 -0500
X-MC-Unique: bdK5vIg7OAqXApF77Bzhvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 384D03C027A8;
        Wed, 22 Nov 2023 10:15:57 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.226.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CEC710EA1;
        Wed, 22 Nov 2023 10:15:55 +0000 (UTC)
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
Subject: [PATCH v4 4/5] i40e: Fix broken support for floating VEBs
Date:   Wed, 22 Nov 2023 11:15:44 +0100
Message-ID: <20231122101545.28819-5-ivecera@redhat.com>
In-Reply-To: <20231122101545.28819-1-ivecera@redhat.com>
References: <20231122101545.28819-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the i40e supports so-called floating VEB (VEB without
an uplink connection to external network), this support is
broken. This functionality is currently unused (except debugfs)
but it will be used by subsequent series for switchdev mode
slow-path. Fix this by following:

1) Handle correctly floating VEB (VEB with uplink_seid == 0)
   in i40e_reconstitute_veb() and look for owner VSI and
   create it only for non-floating VEBs and also set bridge
   mode only for such VEBs as the floating ones are using
   always VEB mode.
2) Handle correctly floating VEB in i40e_veb_release() and
   disallow its release when there are some VSIs. This is
   different from regular VEB that have owner VSI that is
   connected to VEB's uplink after VEB deletion by FW.
3) Fix i40e_add_veb() to handle 'vsi' that is NULL for floating
   VEBs. For floating VEB use 0 for downlink SEID and 'true'
   for 'default_port' parameters as per datasheet.
4) Fix 'add relay' command in i40e_dbg_command_write() to allow
   to create floating VEB by 'add relay 0 0' or 'add relay'

Tested using debugfs:
1) Initial state
[root@host net-next]# echo dump switch > $CMD
[root@host net-next]# dmesg -c
[  173.701286] i40e 0000:02:00.0: header: 3 reported 3 total
[  173.706701] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  173.713241] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  173.719507] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

2) Add floating VEB
[root@host net-next]# CMD="/sys/kernel/debug/i40e/0000:02:00.0/command"
[root@host net-next]# echo add relay > $CMD
[root@host net-next]# dmesg -c
[  245.551720] i40e 0000:02:00.0: added relay 162
[root@host net-next]# echo dump switch > $CMD
[root@host net-next]# dmesg -c
[  276.984371] i40e 0000:02:00.0: header: 4 reported 4 total
[  276.989779] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  276.996302] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  277.002569] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
[  277.009091] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0

3) Add VMDQ2 VSI to this new VEB
[root@host net-next]# echo add vsi 162 > $CMD
[root@host net-next]# dmesg -c
[  332.314030] i40e 0000:02:00.0: added VSI 394 to relay 162
[  332.337486] enp2s0f0np0v0: NIC Link is Up, 40 Gbps Full Duplex, Flow Control: None
[root@host net-next]# echo dump switch > $CMD
[root@host net-next]# dmesg -c
[  387.284490] i40e 0000:02:00.0: header: 5 reported 5 total
[  387.289904] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
[  387.296446] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
[  387.302708] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  387.309234] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  387.315500] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

4) Try to delete the VEB
[root@host net-next]# echo del relay 162 > $CMD
[root@host net-next]# dmesg -c
[  428.749297] i40e 0000:02:00.0: deleting relay 162
[  428.754011] i40e 0000:02:00.0: can't remove VEB 162 with 1 VSIs left

5) Do PF reset and check switch status after rebuild
[root@host net-next]# echo pfr > $CMD
[root@host net-next]# echo dump switch > $CMD
[root@host net-next]# dmesg -c
[  738.056172] i40e 0000:02:00.0: header: 5 reported 5 total
[  738.061577] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
[  738.068104] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
[  738.074367] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[  738.080892] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[  738.087160] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

6) Delete VSI and delete VEB
[root@host net-next]# echo del vsi 394 > $CMD
[root@host net-next]# echo del relay 162 > $CMD
[root@host net-next]# echo dump switch > $CMD
[root@host net-next]# dmesg -c
[ 1233.081126] i40e 0000:02:00.0: deleting VSI 394
[ 1239.345139] i40e 0000:02:00.0: deleting relay 162
[ 1244.886920] i40e 0000:02:00.0: header: 3 reported 3 total
[ 1244.892328] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
[ 1244.898853] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
[ 1244.905119] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 29 ++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 87 ++++++++++---------
 2 files changed, 67 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 990a60889eef..921a97d5479e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -829,10 +829,14 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 
 	} else if (strncmp(cmd_buf, "add relay", 9) == 0) {
 		struct i40e_veb *veb;
+		u8 enabled_tc = 0x1;
 		int uplink_seid;
 
 		cnt = sscanf(&cmd_buf[9], "%i %i", &uplink_seid, &vsi_seid);
-		if (cnt != 2) {
+		if (cnt == 0) {
+			uplink_seid = 0;
+			vsi_seid = 0;
+		} else if (cnt != 2) {
 			dev_info(&pf->pdev->dev,
 				 "add relay: bad command string, cnt=%d\n",
 				 cnt);
@@ -844,23 +848,28 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			goto command_write_done;
 		}
 
-		vsi = i40e_dbg_find_vsi(pf, vsi_seid);
-		if (!vsi) {
-			dev_info(&pf->pdev->dev,
-				 "add relay: VSI %d not found\n", vsi_seid);
-			goto command_write_done;
-		}
-
 		veb = i40e_pf_get_veb_by_seid(pf, uplink_seid);
 		if (!veb && uplink_seid != 0 && uplink_seid != pf->mac_seid) {
 			dev_info(&pf->pdev->dev,
 				 "add relay: relay uplink %d not found\n",
 				 uplink_seid);
 			goto command_write_done;
+		} else if (uplink_seid) {
+			vsi = i40e_pf_get_vsi_by_seid(pf, vsi_seid);
+			if (!vsi) {
+				dev_info(&pf->pdev->dev,
+					 "add relay: VSI %d not found\n",
+					 vsi_seid);
+				goto command_write_done;
+			}
+			enabled_tc = vsi->tc_config.enabled_tc;
+		} else if (vsi_seid) {
+			dev_info(&pf->pdev->dev,
+				 "add relay: VSI must be 0 for floating relay\n");
+			goto command_write_done;
 		}
 
-		veb = i40e_veb_setup(pf, 0, uplink_seid, vsi_seid,
-				     vsi->tc_config.enabled_tc);
+		veb = i40e_veb_setup(pf, 0, uplink_seid, vsi_seid, enabled_tc);
 		if (veb)
 			dev_info(&pf->pdev->dev, "added relay %d\n", veb->seid);
 		else
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 935c2460f060..e0f860be51be 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10379,41 +10379,48 @@ static int i40e_reconstitute_veb(struct i40e_veb *veb)
 	struct i40e_vsi *vsi;
 	int v, ret;
 
-	/* build VSI that owns this VEB, temporarily attached to base VEB */
-	i40e_pf_for_each_vsi(pf, v, vsi)
-		if (vsi->veb_idx == veb->idx &&
-		    vsi->flags & I40E_VSI_FLAG_VEB_OWNER) {
-			ctl_vsi = vsi;
-			break;
+	if (veb->uplink_seid) {
+		/* Look for VSI that owns this VEB, temporarily attached to base VEB */
+		i40e_pf_for_each_vsi(pf, v, vsi)
+			if (vsi->veb_idx == veb->idx &&
+			    vsi->flags & I40E_VSI_FLAG_VEB_OWNER) {
+				ctl_vsi = vsi;
+				break;
+			}
+
+		if (!ctl_vsi) {
+			dev_info(&pf->pdev->dev,
+				 "missing owner VSI for veb_idx %d\n",
+				 veb->idx);
+			ret = -ENOENT;
+			goto end_reconstitute;
 		}
+		if (ctl_vsi != pf->vsi[pf->lan_vsi])
+			ctl_vsi->uplink_seid =
+				pf->vsi[pf->lan_vsi]->uplink_seid;
 
-	if (!ctl_vsi) {
-		dev_info(&pf->pdev->dev,
-			 "missing owner VSI for veb_idx %d\n", veb->idx);
-		ret = -ENOENT;
-		goto end_reconstitute;
-	}
-	if (ctl_vsi != pf->vsi[pf->lan_vsi])
-		ctl_vsi->uplink_seid = pf->vsi[pf->lan_vsi]->uplink_seid;
-	ret = i40e_add_vsi(ctl_vsi);
-	if (ret) {
-		dev_info(&pf->pdev->dev,
-			 "rebuild of veb_idx %d owner VSI failed: %d\n",
-			 veb->idx, ret);
-		goto end_reconstitute;
+		ret = i40e_add_vsi(ctl_vsi);
+		if (ret) {
+			dev_info(&pf->pdev->dev,
+				 "rebuild of veb_idx %d owner VSI failed: %d\n",
+				 veb->idx, ret);
+			goto end_reconstitute;
+		}
+		i40e_vsi_reset_stats(ctl_vsi);
 	}
-	i40e_vsi_reset_stats(ctl_vsi);
 
 	/* create the VEB in the switch and move the VSI onto the VEB */
 	ret = i40e_add_veb(veb, ctl_vsi);
 	if (ret)
 		goto end_reconstitute;
 
-	if (test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags))
-		veb->bridge_mode = BRIDGE_MODE_VEB;
-	else
-		veb->bridge_mode = BRIDGE_MODE_VEPA;
-	i40e_config_bridge_mode(veb);
+	if (veb->uplink_seid) {
+		if (test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags))
+			veb->bridge_mode = BRIDGE_MODE_VEB;
+		else
+			veb->bridge_mode = BRIDGE_MODE_VEPA;
+		i40e_config_bridge_mode(veb);
+	}
 
 	/* create the remaining VSIs attached to this VEB */
 	i40e_pf_for_each_vsi(pf, v, vsi) {
@@ -14716,29 +14723,29 @@ void i40e_veb_release(struct i40e_veb *veb)
 	/* find the remaining VSI and check for extras */
 	i40e_pf_for_each_vsi(pf, i, vsi_it)
 		if (vsi_it->uplink_seid == veb->seid) {
-			vsi = vsi_it;
+			if (vsi_it->flags & I40E_VSI_FLAG_VEB_OWNER)
+				vsi = vsi_it;
 			n++;
 		}
 
-	if (n != 1) {
+	/* Floating VEB has to be empty and regular one must have
+	 * single owner VSI.
+	 */
+	if ((veb->uplink_seid && n != 1) || (!veb->uplink_seid && n != 0)) {
 		dev_info(&pf->pdev->dev,
 			 "can't remove VEB %d with %d VSIs left\n",
 			 veb->seid, n);
 		return;
 	}
 
-	/* move the remaining VSI to uplink veb */
-	vsi->flags &= ~I40E_VSI_FLAG_VEB_OWNER;
+	/* For regular VEB move the owner VSI to uplink VEB */
 	if (veb->uplink_seid) {
+		vsi->flags &= ~I40E_VSI_FLAG_VEB_OWNER;
 		vsi->uplink_seid = veb->uplink_seid;
 		if (veb->uplink_seid == pf->mac_seid)
 			vsi->veb_idx = I40E_NO_VEB;
 		else
 			vsi->veb_idx = veb->veb_idx;
-	} else {
-		/* floating VEB */
-		vsi->uplink_seid = pf->vsi[pf->lan_vsi]->uplink_seid;
-		vsi->veb_idx = pf->vsi[pf->lan_vsi]->veb_idx;
 	}
 
 	i40e_aq_delete_element(&pf->hw, veb->seid, NULL);
@@ -14756,8 +14763,8 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
 	bool enable_stats = !!test_bit(I40E_FLAG_VEB_STATS_ENA, pf->flags);
 	int ret;
 
-	ret = i40e_aq_add_veb(&pf->hw, veb->uplink_seid, vsi->seid,
-			      veb->enabled_tc, false,
+	ret = i40e_aq_add_veb(&pf->hw, veb->uplink_seid, vsi ? vsi->seid : 0,
+			      veb->enabled_tc, vsi ? false : true,
 			      &veb->seid, enable_stats, NULL);
 
 	/* get a VEB from the hardware */
@@ -14789,9 +14796,11 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
 		return -ENOENT;
 	}
 
-	vsi->uplink_seid = veb->seid;
-	vsi->veb_idx = veb->idx;
-	vsi->flags |= I40E_VSI_FLAG_VEB_OWNER;
+	if (vsi) {
+		vsi->uplink_seid = veb->seid;
+		vsi->veb_idx = veb->idx;
+		vsi->flags |= I40E_VSI_FLAG_VEB_OWNER;
+	}
 
 	return 0;
 }
-- 
2.41.0

