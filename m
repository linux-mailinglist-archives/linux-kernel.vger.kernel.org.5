Return-Path: <linux-kernel+bounces-160520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C8B8B3EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F31285E34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F78D17166B;
	Fri, 26 Apr 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qm+RA5BX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CFD171079
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714153816; cv=none; b=HUJAeTbtOqXmtRw6p1+hCywzu5GnWh3Mqn+y39Qx+GZnQXEhPGHiU+V63c6XIF31hKruoZwydWYWwHnYXTWe53JSYL3hTXbExQCpe/73oAmEgAQGAdUfRlD0g6ZHFAvLgqrIDSUHZuzakP8loo+ceUjn0qTApAKBgu7CzSoPHsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714153816; c=relaxed/simple;
	bh=llqEhU+rZ1LxX+6SVaOvTH9xxyZj7sRcjgbjguSQ2Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Or8zi8QrplcpBNdA6J9b9y3xgQXzJuk7RO3affvJCTwCgwUgH+rZE2KbANQd04g354Ynlc24ktXmdvyaXGBql1dXjSb1e59N1kgxZaRO01eujOtcYdbcLf/ad7ys5dgtrPtRhWv8ZNiCC3PKe8WEDWBeklFAF7Ko6jnqHDVwvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qm+RA5BX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714153814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bghi3SWpMQDkb7jckmCakXlu9WkRjj6yXQqF9UcpqI=;
	b=Qm+RA5BX2E5NcIl4iYGjqbV6lo/vELBkTDjG/FLp/BRg8gDlJlJ4JwtQhRf3+97z8KGAiV
	+zcMotWIl8ZAYQSwlmPi4t6AAnh4iYR58Cz+fvhEFOkukIoyj7J7VZMvVileyo9lCwI6pU
	WPENoJJy7GfeHpa8ab3ZP0Cr51EpO6I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-PENLqB-_NVyLGBUa6NJ3Jw-1; Fri,
 26 Apr 2024 13:50:09 -0400
X-MC-Unique: PENLqB-_NVyLGBUa6NJ3Jw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E0F23803900;
	Fri, 26 Apr 2024 17:50:09 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 59E69C13FA3;
	Fri, 26 Apr 2024 17:50:07 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 5/7] i40e: Consolidate checks whether given VSI is main
Date: Fri, 26 Apr 2024 19:49:44 +0200
Message-ID: <20240426174953.208591-6-ivecera@redhat.com>
In-Reply-To: <20240426174953.208591-1-ivecera@redhat.com>
References: <20240426174953.208591-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

In the driver code there are 3 types of checks whether given
VSI is main or not:
1. vsi->type ==/!= I40E_VSI_MAIN
2. vsi ==/!= pf->vsi[pf->lan_vsi]
3. vsi->seid ==/!= pf->vsi[pf->lan_vsi]->seid

All of them are equivalent and can be consolidated. Convert cases
2 and 3 to case 1.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  2 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 12 ++++++------
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 19 +++++++++----------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 09db46de2994..abf624d770e6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -129,7 +129,7 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 		dev_info(&pf->pdev->dev,
 			 "    state[%d] = %08lx\n",
 			 i, vsi->state[i]);
-	if (vsi == pf->vsi[pf->lan_vsi])
+	if (vsi->type == I40E_VSI_MAIN)
 		dev_info(&pf->pdev->dev, "    MAC address: %pM Port MAC: %pM\n",
 			 pf->hw.mac.addr,
 			 pf->hw.mac.port_addr);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 0905c1fb2337..5cd0d1b45f01 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1241,7 +1241,7 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 		i40e_partition_setting_complaint(pf);
 		return -EOPNOTSUPP;
 	}
-	if (vsi != pf->vsi[pf->lan_vsi])
+	if (vsi->type != I40E_VSI_MAIN)
 		return -EOPNOTSUPP;
 	if (hw->phy.media_type != I40E_MEDIA_TYPE_BASET &&
 	    hw->phy.media_type != I40E_MEDIA_TYPE_FIBER &&
@@ -1710,7 +1710,7 @@ static int i40e_set_pauseparam(struct net_device *netdev,
 		return -EOPNOTSUPP;
 	}
 
-	if (vsi != pf->vsi[pf->lan_vsi])
+	if (vsi->type != I40E_VSI_MAIN)
 		return -EOPNOTSUPP;
 
 	is_an = hw_link_info->an_info & I40E_AQ_AN_COMPLETED;
@@ -2292,7 +2292,7 @@ static int i40e_get_stats_count(struct net_device *netdev)
 	struct i40e_pf *pf = vsi->back;
 	int stats_len;
 
-	if (vsi == pf->vsi[pf->lan_vsi] && pf->hw.partition_id == 1)
+	if (vsi->type == I40E_VSI_MAIN && pf->hw.partition_id == 1)
 		stats_len = I40E_PF_STATS_LEN;
 	else
 		stats_len = I40E_VSI_STATS_LEN;
@@ -2422,7 +2422,7 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	}
 	rcu_read_unlock();
 
-	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
+	if (vsi->type != I40E_VSI_MAIN || pf->hw.partition_id != 1)
 		goto check_data_pointer;
 
 	veb_stats = ((pf->lan_veb != I40E_NO_VEB) &&
@@ -2495,7 +2495,7 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 				      "rx", i);
 	}
 
-	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
+	if (vsi->type != I40E_VSI_MAIN || pf->hw.partition_id != 1)
 		goto check_data_pointer;
 
 	i40e_add_stat_strings(&data, i40e_gstrings_veb_stats);
@@ -2792,7 +2792,7 @@ static int i40e_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 		return -EOPNOTSUPP;
 	}
 
-	if (vsi != pf->vsi[pf->lan_vsi])
+	if (vsi->type != I40E_VSI_MAIN)
 		return -EOPNOTSUPP;
 
 	/* NVM bit on means WoL disabled for the port */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e45a556b19bb..85d609ad81dc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -990,7 +990,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	ns->tx_dropped = es->tx_discards;
 
 	/* pull in a couple PF stats if this is the main vsi */
-	if (vsi == pf->vsi[pf->lan_vsi]) {
+	if (vsi->type == I40E_VSI_MAIN) {
 		ns->rx_crc_errors = pf->stats.crc_errors;
 		ns->rx_errors = pf->stats.crc_errors + pf->stats.illegal_bytes;
 		ns->rx_length_errors = pf->stats.rx_length_errors;
@@ -1235,7 +1235,7 @@ void i40e_update_stats(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = vsi->back;
 
-	if (vsi == pf->vsi[pf->lan_vsi])
+	if (vsi->type == I40E_VSI_MAIN)
 		i40e_update_pf_stats(pf);
 
 	i40e_update_vsi_stats(vsi);
@@ -6812,7 +6812,7 @@ static void i40e_dcb_reconfigure(struct i40e_pf *pf)
 		/* - Enable all TCs for the LAN VSI
 		 * - For all others keep them at TC0 for now
 		 */
-		if (v == pf->lan_vsi)
+		if (vsi->type == I40E_VSI_MAIN)
 			tc_map = i40e_pf_get_tc_map(pf);
 		else
 			tc_map = I40E_DEFAULT_TRAFFIC_CLASS;
@@ -9119,7 +9119,7 @@ int i40e_vsi_open(struct i40e_vsi *vsi)
 	i40e_vsi_free_rx_resources(vsi);
 err_setup_tx:
 	i40e_vsi_free_tx_resources(vsi);
-	if (vsi == pf->vsi[pf->lan_vsi])
+	if (vsi->type == I40E_VSI_MAIN)
 		i40e_do_reset(pf, I40E_PF_RESET_FLAG, true);
 
 	return err;
@@ -11994,7 +11994,7 @@ static int i40e_vsi_alloc_q_vectors(struct i40e_vsi *vsi)
 	/* if not MSIX, give the one vector only to the LAN VSI */
 	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
 		num_q_vectors = vsi->num_q_vectors;
-	else if (vsi == pf->vsi[pf->lan_vsi])
+	else if (vsi->type == I40E_VSI_MAIN)
 		num_q_vectors = 1;
 	else
 		return -EINVAL;
@@ -13111,7 +13111,7 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
 	int rem;
 
 	/* Only for PF VSI for now */
-	if (vsi->seid != pf->vsi[pf->lan_vsi]->seid)
+	if (vsi->type != I40E_VSI_MAIN)
 		return -EOPNOTSUPP;
 
 	/* Find the HW bridge for PF VSI */
@@ -13179,7 +13179,7 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	struct i40e_veb *veb;
 
 	/* Only for PF VSI for now */
-	if (vsi->seid != pf->vsi[pf->lan_vsi]->seid)
+	if (vsi->type != I40E_VSI_MAIN)
 		return -EOPNOTSUPP;
 
 	/* Find the HW bridge for the PF VSI */
@@ -14131,8 +14131,7 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 			 vsi->seid, vsi->uplink_seid);
 		return -ENODEV;
 	}
-	if (vsi == pf->vsi[pf->lan_vsi] &&
-	    !test_bit(__I40E_DOWN, pf->state)) {
+	if (vsi->type == I40E_VSI_MAIN && !test_bit(__I40E_DOWN, pf->state)) {
 		dev_info(&pf->pdev->dev, "Can't remove PF VSI\n");
 		return -ENODEV;
 	}
@@ -14396,7 +14395,7 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 			veb = i40e_veb_setup(pf, vsi->uplink_seid, vsi->seid,
 					     vsi->tc_config.enabled_tc);
 		if (veb) {
-			if (vsi->seid != pf->vsi[pf->lan_vsi]->seid) {
+			if (vsi->type != I40E_VSI_MAIN) {
 				dev_info(&vsi->back->pdev->dev,
 					 "New VSI creation error, uplink seid of LAN VSI expected.\n");
 				return NULL;
-- 
2.43.2


