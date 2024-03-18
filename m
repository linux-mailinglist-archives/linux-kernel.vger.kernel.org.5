Return-Path: <linux-kernel+bounces-106229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B715C87EB0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C40928262F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE17951C55;
	Mon, 18 Mar 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4SWTOSQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F54D9FF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772285; cv=none; b=MlM7PBVzYTlB+kmR3UGw5yAuL0ptriVVW7ZwfxrK3eG1FZUXqs0GE58ZoLt3Y26K/Gh0KQ9F3H+Py17JEF9CiFYAxAlMqRV+0QGMOCIzyW5rxP8oSaUfcd3gZxq+7UGdvVCqeApKx8XR6QdhqV/T51dmnNLeHAaCvIZ+YfXtj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772285; c=relaxed/simple;
	bh=iLd9U6gpY1+6RwIZWl0ds6p1AGDKEf+OubND5Y9URq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2JvQENnwFYTSxxqprt0mJgfajRPwHaQKEjhVWN69wxV98UTOshTCSYSxYIGxRVK5yF5n513yuAd56WCDPClEjF1kVlEx69xtzOel0yaebCGgt6m6DwOg2fCT72jSdXoTdHhsB4q+zfHawZel/ZrVkSVxV2/T/eWDlPF8M/JjsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4SWTOSQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710772283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQZXNVyZu0WSGh4NASypClU3bS3FTyECK464OaQui/8=;
	b=T4SWTOSQTRQFQPYziJq7TVKCCjhbVrzSiSb2n7kCIfob0jUvpXnJ4jHymbq+VgG6AwwGxY
	sOR47nW4D+gQRrpDJbN/9XVQbZiL/W9ZrIa39/9u6i7kWbxycX5OKLswX1x53HJ4ti3W+B
	KPqaGVEfPe9ax+vFX7yo563hlgZ6ULM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-wRCjYqtSNuawUApmu45OJg-1; Mon,
 18 Mar 2024 10:31:19 -0400
X-MC-Unique: wRCjYqtSNuawUApmu45OJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 916BA1C04196;
	Mon, 18 Mar 2024 14:31:17 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.33])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 38670112131D;
	Mon, 18 Mar 2024 14:31:16 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-next 6/7] i40e: Add helper to access main VEB
Date: Mon, 18 Mar 2024 15:30:50 +0100
Message-ID: <20240318143058.287014-7-ivecera@redhat.com>
In-Reply-To: <20240318143058.287014-1-ivecera@redhat.com>
References: <20240318143058.287014-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Add a helper to access main VEB:

i40e_pf_get_main_veb(pf) replaces 'pf->veb[pf->lan_veb]'

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 11 ++++++++
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  9 +++----
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 27 ++++++++++++-------
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index fb0b913692e1..2f135db416cf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1401,4 +1401,15 @@ i40e_pf_get_veb_by_seid(struct i40e_pf *pf, u16 seid)
 	return NULL;
 }
 
+/**
+ * i40e_pf_get_main_veb - get pointer to main VEB
+ * @pf: pointer to a PF
+ *
+ * Return pointer to main VEB or NULL if it does not exist
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
index d6dbd0fd79eb..2e1955064abb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2480,7 +2480,7 @@ static int i40e_set_promiscuous(struct i40e_pf *pf, bool promisc)
 	int aq_ret;
 
 	if (vsi->type == I40E_VSI_MAIN &&
-	    pf->lan_veb != I40E_NO_VEB &&
+	    i40e_pf_get_main_veb(pf) &&
 	    !test_bit(I40E_FLAG_MFP_ENA, pf->flags)) {
 		/* set defport ON for Main VSI instead of true promisc
 		 * this way we will get all unicast/multicast and VLAN
@@ -9916,6 +9916,7 @@ static void i40e_veb_link_event(struct i40e_veb *veb, bool link_up)
 static void i40e_link_event(struct i40e_pf *pf)
 {
 	struct i40e_vsi *vsi = i40e_pf_get_main_vsi(pf);
+	struct i40e_veb *veb = i40e_pf_get_main_veb(pf);
 	u8 new_link_speed, old_link_speed;
 	bool new_link, old_link;
 	int status;
@@ -9955,8 +9956,8 @@ static void i40e_link_event(struct i40e_pf *pf)
 	/* Notify the base of the switch tree connected to
 	 * the link.  Floating VEBs are not notified.
 	 */
-	if (pf->lan_veb < I40E_MAX_VEB && pf->veb[pf->lan_veb])
-		i40e_veb_link_event(pf->veb[pf->lan_veb], new_link);
+	if (veb)
+		i40e_veb_link_event(veb, new_link);
 	else
 		i40e_vsi_link_event(vsi, new_link);
 
@@ -14892,7 +14893,8 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
 		/* Main VEB? */
 		if (uplink_seid != pf->mac_seid)
 			break;
-		if (pf->lan_veb >= I40E_MAX_VEB) {
+		veb = i40e_pf_get_main_veb(pf);
+		if (!veb) {
 			int v;
 
 			/* find existing or else empty VEB */
@@ -14906,12 +14908,15 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
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
@@ -15056,13 +15061,15 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
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
2.43.0


