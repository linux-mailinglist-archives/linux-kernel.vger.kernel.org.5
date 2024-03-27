Return-Path: <linux-kernel+bounces-120481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA56F88D82E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E1E1F2ABA3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1E9364A0;
	Wed, 27 Mar 2024 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUgO7nn1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B22E646
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526272; cv=none; b=ftk/cb5vRlbpFk/O2tR47F53ouLpbVQAt8aZnCbexLWwzihHnhUrgL6fJbi7Dg0b8LtWPCaRKDzWiIwq9zNvg9vuOjDufrHZ3Gg/IdL4Xp9GgFAAiugyA/YHs71bj6VMWRoFuyRv8VU9M//e5pJNCuskEv0SXBzfGfuSnPsFYkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526272; c=relaxed/simple;
	bh=UAj9mOrHldGMNF6b5OZucaB+VIu7f+R8agO4ObYYVPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivm4L/pjmrYG6QZqMOEMi50Q3jkfojrr3vdFKAVEUdNJrr+x6oULArKVLQrqSH3qo3NPqs8Ak1CJgPWl2vNSJaqtk/R0BLbdKBJlJWQyypyufNqyOikPxednUaWxrBI2Bp+TaZBrjdzooBEWzVQxgBjCFNlHImPaYk8r2AkRLtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUgO7nn1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711526270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3GuWJMRUMe/QbVe0UreQo9XJlbu0fgVV+FGGOcs9ng=;
	b=OUgO7nn1+LnEsaUuwZgMhRJEZlWbemJp3EKdUKU0ajyKr6kO5eS4cSLC0jNGD+op1sdeW+
	D7DCJeJ/1ONZYExvNyYhanHAhMihwLDD9uNT5Rp/sqE2V4InyBqVcNBHmBDjwtu2yHngL+
	F0Jyy037f4rPC17HpeSBhg0RBZ7smmQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-9wEsPOBWNs2t3-Dr-IXcGw-1; Wed, 27 Mar 2024 03:57:45 -0400
X-MC-Unique: 9wEsPOBWNs2t3-Dr-IXcGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3033C8F564D;
	Wed, 27 Mar 2024 07:57:45 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D201C15776;
	Wed, 27 Mar 2024 07:57:43 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mschmidt@redhat.com,
	aleksandr.loktionov@intel.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH iwl-next v2 3/7] i40e: Refactor argument of i40e_detect_recover_hung()
Date: Wed, 27 Mar 2024 08:57:29 +0100
Message-ID: <20240327075733.8967-4-ivecera@redhat.com>
In-Reply-To: <20240327075733.8967-1-ivecera@redhat.com>
References: <20240327075733.8967-1-ivecera@redhat.com>
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
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 10 ++++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7fed7fb69d4e..1ba28893f49e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11274,7 +11274,7 @@ static void i40e_service_task(struct work_struct *work)
 		return;
 
 	if (!test_bit(__I40E_RECOVERY_MODE, pf->state)) {
-		i40e_detect_recover_hung(pf->vsi[pf->lan_vsi]);
+		i40e_detect_recover_hung(pf);
 		i40e_sync_filters_subtask(pf);
 		i40e_reset_subtask(pf);
 		i40e_handle_mdd_event(pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 1a12b732818e..e35a08de16b2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -860,13 +860,15 @@ u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw)
 
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
2.43.0


