Return-Path: <linux-kernel+bounces-160939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEEE8B44D8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C231F21272
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DED346439;
	Sat, 27 Apr 2024 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBkdIQYA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ABF43AD4
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714202790; cv=none; b=V7oP1Dopg7ncBbEn1N1hmwiaBQyMcZLBzvjG8ctHPT9iZWFJ49bkpfDkHpg3Qp2/PtB/qHmsaciyCNso+NVPAsaxTfa8uPEaYK3jplQfjXmLo+Jl3OEqYDUUsdCvZvlin85JCsFUTc4SVV9DN/iTKxT0Zqy//iULnMS7jLggOsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714202790; c=relaxed/simple;
	bh=hcGrw5cZo3CJ6mE6tbTLq0OShRPGM/ZBTeWl8spEoqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5NCs+jXLeuUcqLEsGo6TNO6bahjtsazYc5/INY0zf5CJeRCwpGtuJBQ4iwz7Gw5xi++NILV7yELZcaH3ba19voslOL9BUBa1pEqu6liKnogsbVGKURwLp0x9q7nac2sFHGpnV7jLwLbk3C0giYOjiaa9C7yWCMXS4AirUrWyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBkdIQYA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714202787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bj9Wr6bJvBUA12ICZZ88R9dnEAsRSmHQe/2uWm86V4s=;
	b=PBkdIQYA9OyXCcfVp6pMe07lC8xPqDpvKZ5L6bFVa15hf5dzIkC35l62pX9BxgZGYWYVCv
	VBcx5/5bG5hiEpjRcw8VEaNkTeADveZlqcnK4m3aB5hS0W+qr6oJnfI8t0Uq/QYN0TcpKC
	Tue0bfQEKpuPqiST+g+w5dLRKtL8Y7I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-tKQiC7YzOhiPhSYqPgXYdw-1; Sat, 27 Apr 2024 03:26:24 -0400
X-MC-Unique: tKQiC7YzOhiPhSYqPgXYdw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EBC11005CF3;
	Sat, 27 Apr 2024 07:26:23 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C04C340F17B;
	Sat, 27 Apr 2024 07:26:21 +0000 (UTC)
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
Subject: [PATCH net-next v4 2/7] i40e: Refactor argument of several client notification functions
Date: Sat, 27 Apr 2024 09:26:03 +0200
Message-ID: <20240427072615.226151-3-ivecera@redhat.com>
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

Commit 0ef2d5afb12d ("i40e: KISS the client interface") simplified
the client interface so in practice it supports only one client
per i40e netdev. But we have still 2 notification functions that
uses as parameter a pointer to VSI of netdevice associated with
the client. After the mentioned commit only possible and used
VSI is the main (LAN) VSI.
So refactor these functions so they are called with PF pointer argument
and the associated VSI (LAN) is taken inside them.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_client.c | 20 +++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 12 +++++------
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 5248e78f7849..0792c7324527 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1236,8 +1236,8 @@ static inline void i40e_dbg_exit(void) {}
 int i40e_lan_add_device(struct i40e_pf *pf);
 int i40e_lan_del_device(struct i40e_pf *pf);
 void i40e_client_subtask(struct i40e_pf *pf);
-void i40e_notify_client_of_l2_param_changes(struct i40e_vsi *vsi);
-void i40e_notify_client_of_netdev_close(struct i40e_vsi *vsi, bool reset);
+void i40e_notify_client_of_l2_param_changes(struct i40e_pf *pf);
+void i40e_notify_client_of_netdev_close(struct i40e_pf *pf, bool reset);
 void i40e_notify_client_of_vf_enable(struct i40e_pf *pf, u32 num_vfs);
 void i40e_notify_client_of_vf_reset(struct i40e_pf *pf, u32 vf_id);
 void i40e_client_update_msix_info(struct i40e_pf *pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index b32071ee84af..93e52138826e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -101,25 +101,26 @@ i40e_notify_client_of_vf_msg(struct i40e_vsi *vsi, u32 vf_id, u8 *msg, u16 len)
 
 /**
  * i40e_notify_client_of_l2_param_changes - call the client notify callback
- * @vsi: the VSI with l2 param changes
+ * @pf: PF device pointer
  *
- * If there is a client to this VSI, call the client
+ * If there is a client, call its callback
  **/
-void i40e_notify_client_of_l2_param_changes(struct i40e_vsi *vsi)
+void i40e_notify_client_of_l2_param_changes(struct i40e_pf *pf)
 {
-	struct i40e_pf *pf = vsi->back;
 	struct i40e_client_instance *cdev = pf->cinst;
+	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 	struct i40e_params params;
 
 	if (!cdev || !cdev->client)
 		return;
 	if (!cdev->client->ops || !cdev->client->ops->l2_param_change) {
-		dev_dbg(&vsi->back->pdev->dev,
+		dev_dbg(&pf->pdev->dev,
 			"Cannot locate client instance l2_param_change routine\n");
 		return;
 	}
 	if (!test_bit(__I40E_CLIENT_INSTANCE_OPENED, &cdev->state)) {
-		dev_dbg(&vsi->back->pdev->dev, "Client is not open, abort l2 param change\n");
+		dev_dbg(&pf->pdev->dev,
+			"Client is not open, abort l2 param change\n");
 		return;
 	}
 	memset(&params, 0, sizeof(params));
@@ -157,20 +158,19 @@ static void i40e_client_release_qvlist(struct i40e_info *ldev)
 
 /**
  * i40e_notify_client_of_netdev_close - call the client close callback
- * @vsi: the VSI with netdev closed
+ * @pf: PF device pointer
  * @reset: true when close called due to a reset pending
  *
  * If there is a client to this netdev, call the client with close
  **/
-void i40e_notify_client_of_netdev_close(struct i40e_vsi *vsi, bool reset)
+void i40e_notify_client_of_netdev_close(struct i40e_pf *pf, bool reset)
 {
-	struct i40e_pf *pf = vsi->back;
 	struct i40e_client_instance *cdev = pf->cinst;
 
 	if (!cdev || !cdev->client)
 		return;
 	if (!cdev->client->ops || !cdev->client->ops->close) {
-		dev_dbg(&vsi->back->pdev->dev,
+		dev_dbg(&pf->pdev->dev,
 			"Cannot locate client instance close routine\n");
 		return;
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e27b2aa544b6..aa874d6ff8c3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11276,14 +11276,12 @@ static void i40e_service_task(struct work_struct *work)
 		i40e_fdir_reinit_subtask(pf);
 		if (test_and_clear_bit(__I40E_CLIENT_RESET, pf->state)) {
 			/* Client subtask will reopen next time through. */
-			i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi],
-							   true);
+			i40e_notify_client_of_netdev_close(pf, true);
 		} else {
 			i40e_client_subtask(pf);
 			if (test_and_clear_bit(__I40E_CLIENT_L2_CHANGE,
 					       pf->state))
-				i40e_notify_client_of_l2_param_changes(
-								pf->vsi[pf->lan_vsi]);
+				i40e_notify_client_of_l2_param_changes(pf);
 		}
 		i40e_sync_filters_subtask(pf);
 	} else {
@@ -16217,7 +16215,7 @@ static void i40e_remove(struct pci_dev *pdev)
 	/* Client close must be called explicitly here because the timer
 	 * has been stopped.
 	 */
-	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
+	i40e_notify_client_of_netdev_close(pf, false);
 
 	i40e_fdir_teardown(pf);
 
@@ -16476,7 +16474,7 @@ static void i40e_shutdown(struct pci_dev *pdev)
 	/* Client close must be called explicitly here because the timer
 	 * has been stopped.
 	 */
-	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
+	i40e_notify_client_of_netdev_close(pf, false);
 
 	if (test_bit(I40E_HW_CAP_WOL_MC_MAGIC_PKT_WAKE, pf->hw.caps) &&
 	    pf->wol_en)
@@ -16530,7 +16528,7 @@ static int i40e_suspend(struct device *dev)
 	/* Client close must be called explicitly here because the timer
 	 * has been stopped.
 	 */
-	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
+	i40e_notify_client_of_netdev_close(pf, false);
 
 	if (test_bit(I40E_HW_CAP_WOL_MC_MAGIC_PKT_WAKE, pf->hw.caps) &&
 	    pf->wol_en)
-- 
2.43.2


