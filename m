Return-Path: <linux-kernel+bounces-160518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A488B3E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CB41C22296
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0434016FF49;
	Fri, 26 Apr 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9pL57oU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17416F29C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714153810; cv=none; b=Vdnx4r4YSY5WSnHPBrGTEMD9MPhMR4pmO6LB1kxwcRA6H1ixBQnjhLHFu7qh09McMyM8Vg0Uwz0EjFPr2El2QGHZKKPGJuyKUOGi4at6TnGYD75D34ZwWaQ9leauvjHYi4OcR9QaJWCpaS864pPbF2uTVril3eHpblAG7zWi8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714153810; c=relaxed/simple;
	bh=qiY2hlTGyOxiwxVTtNlPshBl7QKx1czprCJM15jCIQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwDbWPEr+cQlKMuumerSRLwwUxLuOfS5tt2wR5gTA+70IL5vTzDTwOmYAvViW3hN/DucCSrN8VqGOs40F8X7B8s8Y26cZktmjox1MdHisMwE+OVKptPCf0EdJQAclOaO+WiE2/pv/R7b7OznzL7TIBqNx9wM3b7iwBV9/Nkn2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9pL57oU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714153807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWCAnD1jZ3nDtPosCAWW0dfALxgzSh64Qpv1vVnvFZM=;
	b=C9pL57oUyzrd/sFyp3grDp1TX47syb7TD0FDKiHTadvUXUzu0ydq+PVrKB1Iiv7Md/cLEc
	Uo6+gxx2eghCndUHJZSGkUK17P60ANBkMR8xOQFx4FePF3Zl5IcfLylPa6ISwdLayTSPQ0
	y+1aVfdqUaP44ynKinUMDBjs1A8BAuY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-tweEpJqKM-GtjA-uQfgguQ-1; Fri, 26 Apr 2024 13:50:04 -0400
X-MC-Unique: tweEpJqKM-GtjA-uQfgguQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90ACF802E4D;
	Fri, 26 Apr 2024 17:50:03 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CB8B9C01595;
	Fri, 26 Apr 2024 17:50:01 +0000 (UTC)
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
Subject: [PATCH net-next v3 3/7] i40e: Refactor argument of i40e_detect_recover_hung()
Date: Fri, 26 Apr 2024 19:49:42 +0200
Message-ID: <20240426174953.208591-4-ivecera@redhat.com>
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

Commit 07d44190a389 ("i40e/i40evf: Detect and recover hung queue
scenario") changes i40e_detect_recover_hung() argument type from
i40e_pf* to i40e_vsi* to be shareable by both i40e and i40evf.
Because the i40evf does not exist anymore and the function is
exclusively used by i40e we can revert this change.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 10 ++++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index aa874d6ff8c3..4291001d0053 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11267,7 +11267,7 @@ static void i40e_service_task(struct work_struct *work)
 		return;
 
 	if (!test_bit(__I40E_RECOVERY_MODE, pf->state)) {
-		i40e_detect_recover_hung(pf->vsi[pf->lan_vsi]);
+		i40e_detect_recover_hung(pf);
 		i40e_sync_filters_subtask(pf);
 		i40e_reset_subtask(pf);
 		i40e_handle_mdd_event(pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index bc9e766d88cb..fa08b0297925 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -861,13 +861,15 @@ u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw)
 
 /**
  * i40e_detect_recover_hung - Function to detect and recover hung_queues
- * @vsi:  pointer to vsi struct with tx queues
+ * @pf: pointer to PF struct
  *
- * VSI has netdev and netdev has TX queues. This function is to check each of
- * those TX queues if they are hung, trigger recovery by issuing SW interrupt.
+ * LAN VSI has netdev and netdev has TX queues. This function is to check
+ * each of those TX queues if they are hung, trigger recovery by issuing
+ * SW interrupt.
  **/
-void i40e_detect_recover_hung(struct i40e_vsi *vsi)
+void i40e_detect_recover_hung(struct i40e_pf *pf)
 {
+	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 	struct i40e_ring *tx_ring = NULL;
 	struct net_device *netdev;
 	unsigned int i;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 2cdc7de6301c..7c26c9a2bf65 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -470,7 +470,7 @@ void i40e_free_rx_resources(struct i40e_ring *rx_ring);
 int i40e_napi_poll(struct napi_struct *napi, int budget);
 void i40e_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector);
 u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw);
-void i40e_detect_recover_hung(struct i40e_vsi *vsi);
+void i40e_detect_recover_hung(struct i40e_pf *pf);
 int __i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size);
 bool __i40e_chk_linearize(struct sk_buff *skb);
 int i40e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
-- 
2.43.2


