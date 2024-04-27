Return-Path: <linux-kernel+bounces-160943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF168B44DE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0FC1F21CEC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AD0446AF;
	Sat, 27 Apr 2024 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzL+7ewp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A399C4D5A0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714202803; cv=none; b=ZTvPx4XrrPqvGWyit6kAw05p2Yjz+MnDSMZFA3kprp1nY/ljq95UNgpVUaouUClWE76QxIVjCYZZp5UnGJr601d1WhrwlDD91q5Wj/0Rz1yCFhA37Wx3JuxIuVulFy+GOmI/PY3KEt3PA78BWidqCbY8yCZRWau+hs8oB+pcaxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714202803; c=relaxed/simple;
	bh=q10npWFP2jl9G5fBVuVSE2h5+bUAHqA2rA3v36ejHUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSs52n+P6UWfJkGKQDhqeDWr89V88r1UXQNd6fIYrQqL5sgR3YmJGjuBwWQLlx+2feZxacaeR3+A/N1wQtlGsNV6DQ5hrnXmtvgm57FoHGGApEjHU+7r89fyA+pwjdLhgOupKR1eqTkPWtDQmBrOr50G5/s8Zj+uVxTwyhWWK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzL+7ewp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714202800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FUqYcQlrnz+bZ9Y7P05MQ8VEB6aA3crAEfRxYtGSBcI=;
	b=CzL+7ewpNWSu6ateo5Ffg0suPqtZNtOAx6BFh1Nd8T9BfNl78Dwt9AZGkZ3fIdD2ZvHP99
	PFBCvznzs9mkTIn/iLBRsPa6aM1uzn0BctJczc/vwi9ACu5mUjjPvy9SaKnbzWlkJGGhqx
	TIde7z+9z/IU/cSRRY+zbEnWAg59QFI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-rPQ9ojvkOUG0PDznGkWa0A-1; Sat, 27 Apr 2024 03:26:34 -0400
X-MC-Unique: rPQ9ojvkOUG0PDznGkWa0A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 681E1803505;
	Sat, 27 Apr 2024 07:26:34 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D2A7492BC7;
	Sat, 27 Apr 2024 07:26:32 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 6/7] i40e: Add helper to access main VEB
Date: Sat, 27 Apr 2024 09:26:07 +0200
Message-ID: <20240427072615.226151-7-ivecera@redhat.com>
In-Reply-To: <20240427072615.226151-1-ivecera@redhat.com>
References: <20240427072615.226151-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Add a helper to access main VEB:

i40e_pf_get_main_veb(pf) replaces 'pf->veb[pf->lan_veb]'

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 11 ++++++++
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  9 +++----
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 27 ++++++++++++-------
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 58610a624a59..bca2084cc54b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1401,4 +1401,15 @@ i40e_pf_get_veb_by_seid(struct i40e_pf *pf, u16 seid)
 	return NULL;
 }
 
+/**
+ * i40e_pf_get_main_veb - get pointer to main VEB
+ * @pf: pointer to a PF
+ *
+ * Return: pointer to main VEB or NULL if it does not exist
+ **/
+static inline struct i40e_veb *i40e_pf_get_main_veb(struct i40e_pf *pf)
+{
+	return (pf->lan_veb != I40E_NO_VEB) ? pf->veb[pf->lan_veb] : NULL;
+}
+
 #endif /* _I40E_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 5cd0d1b45f01..4e28785c9fb2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2425,14 +2425,11 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	if (vsi->type != I40E_VSI_MAIN || pf->hw.partition_id != 1)
 		goto check_data_pointer;
 
-	veb_stats = ((pf->lan_veb != I40E_NO_VEB) &&
-		     (pf->lan_veb < I40E_MAX_VEB) &&
-		     test_bit(I40E_FLAG_VEB_STATS_ENA, pf->flags));
+	veb = i40e_pf_get_main_veb(pf);
+	veb_stats = veb && test_bit(I40E_FLAG_VEB_STATS_ENA, pf->flags);
 
-	if (veb_stats) {
-		veb = pf->veb[pf->lan_veb];
+	if (veb_stats)
 		i40e_update_veb_stats(veb);
-	}
 
 	/* If veb stats aren't enabled, pass NULL instead of the veb so that
 	 * we initialize stats to zero and update the data pointer
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 85d609ad81dc..26e5c21df19d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2481,7 +2481,7 @@ static int i40e_set_promiscuous(struct i40e_pf *pf, bool promisc)
 	int aq_ret;
 
 	if (vsi->type == I40E_VSI_MAIN &&
-	    pf->lan_veb != I40E_NO_VEB &&
+	    i40e_pf_get_main_veb(pf) &&
 	    !test_bit(I40E_FLAG_MFP_ENA, pf->flags)) {
 		/* set defport ON for Main VSI instead of true promisc
 		 * this way we will get all unicast/multicast and VLAN
@@ -9909,6 +9909,7 @@ static void i40e_veb_link_event(struct i40e_veb *veb, bool link_up)
 static void i40e_link_event(struct i40e_pf *pf)
 {
 	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
+	struct i40e_veb *veb = i40e_pf_get_main_veb(pf);
 	u8 new_link_speed, old_link_speed;
 	bool new_link, old_link;
 	int status;
@@ -9948,8 +9949,8 @@ static void i40e_link_event(struct i40e_pf *pf)
 	/* Notify the base of the switch tree connected to
 	 * the link.  Floating VEBs are not notified.
 	 */
-	if (pf->lan_veb < I40E_MAX_VEB && pf->veb[pf->lan_veb])
-		i40e_veb_link_event(pf->veb[pf->lan_veb], new_link);
+	if (veb)
+		i40e_veb_link_event(veb, new_link);
 	else
 		i40e_vsi_link_event(vsi, new_link);
 
@@ -14881,7 +14882,8 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
 		/* Main VEB? */
 		if (uplink_seid != pf->mac_seid)
 			break;
-		if (pf->lan_veb >= I40E_MAX_VEB) {
+		veb = i40e_pf_get_main_veb(pf);
+		if (!veb) {
 			int v;
 
 			/* find existing or else empty VEB */
@@ -14895,12 +14897,15 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
 				pf->lan_veb = v;
 			}
 		}
-		if (pf->lan_veb >= I40E_MAX_VEB)
+
+		/* Try to get again main VEB as pf->lan_veb may have changed */
+		veb = i40e_pf_get_main_veb(pf);
+		if (!veb)
 			break;
 
-		pf->veb[pf->lan_veb]->seid = seid;
-		pf->veb[pf->lan_veb]->uplink_seid = pf->mac_seid;
-		pf->veb[pf->lan_veb]->pf = pf;
+		veb->seid = seid;
+		veb->uplink_seid = pf->mac_seid;
+		veb->pf = pf;
 		break;
 	case I40E_SWITCH_ELEMENT_TYPE_VSI:
 		if (num_reported != 1)
@@ -15045,13 +15050,15 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 	/* first time setup */
 	main_vsi = i40e_pf_get_main_vsi(pf);
 	if (!main_vsi || reinit) {
+		struct i40e_veb *veb;
 		u16 uplink_seid;
 
 		/* Set up the PF VSI associated with the PF's main VSI
 		 * that is already in the HW switch
 		 */
-		if (pf->lan_veb < I40E_MAX_VEB && pf->veb[pf->lan_veb])
-			uplink_seid = pf->veb[pf->lan_veb]->seid;
+		veb = i40e_pf_get_main_veb(pf);
+		if (veb)
+			uplink_seid = veb->seid;
 		else
 			uplink_seid = pf->mac_seid;
 		if (!main_vsi)
-- 
2.43.2


