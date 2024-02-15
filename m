Return-Path: <linux-kernel+bounces-67206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17933856805
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4634283103
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78064134CD7;
	Thu, 15 Feb 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PeIHrISH"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E711332B1;
	Thu, 15 Feb 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011409; cv=none; b=ec9I8P8Csj/AjvlBjy8D2He1HHbavPlg1CMUxyztMToZDqHzdsiPu21HGvPj4orr11mTasaOtrFNFvYN5xUWo37tgSiB4cc1vk0uzfCDtD5zEbMbwq9FBh5yf8eGZ17raMLq5k6QVOwxYZGvZNh/k/KPzletjmxuu0tZkD4wfX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011409; c=relaxed/simple;
	bh=ZQgdL3IC4nxkrcDN6Ec7D5CV9fMRJObe5XK8re/GRyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZxJQuDPx4FQ3McuSMYVqNi8hmJGBJnbt0R+JE3JZLywX02GfmydqavVSDfyV+avqDKcpZSx3nG8pJEXq8Wa7W1iADHl+b7TauyBkO64ywVq7iFt/KeguMuB+P9KqtIoGnfLcn4OCFhpRLMLUCW1LlvtCQf9hLLTXycObHX4upn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PeIHrISH; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 96B0CC876B;
	Thu, 15 Feb 2024 15:36:39 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 290D3FF80E;
	Thu, 15 Feb 2024 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708011392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcD8+r7IbXbWMnW4VdFvkFJiY+m6SJ3b82KLtl6OoVg=;
	b=PeIHrISHalbiiMxK5RaA6Ya6FbWR01j848eJLFAiXuNw/PsVPu4jNSPAdtwtjWAdN3vWTi
	c+Ql98nuAwh9Dc90pVVsXjaUC6XtlcHY8zztlrMYQA/TcjtiBGDyHWCDGzDMfFtE7ebALw
	p1crL/H0EKKRizLq1GM7Rto05EKwAcHMA4ILVMh3lFlhnFiPiUo110OBKbmq8BKR/gvpEJ
	oayS9gbsubvfapCv5dyhryXJS12ebLJfyFdR/w1K9Scntm7hwQjJdOoNd19vpOsoU6OG2G
	v98SeYn82RFns2I1qQ1mtZ5CKnVnLDjxwZgWnOUtPdm/G9nn3bh8+uUzpDkfaA==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Thu, 15 Feb 2024 16:36:21 +0100
Subject: [PATCH 4/4] wifi: wilc1000: add missing read critical sections
 around vif list traversal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240215-wilc_fix_rcu_usage-v1-4-f610e46c6f82@bootlin.com>
References: <20240215-wilc_fix_rcu_usage-v1-0-f610e46c6f82@bootlin.com>
In-Reply-To: <20240215-wilc_fix_rcu_usage-v1-0-f610e46c6f82@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

From: Ajay Singh <ajay.kathat@microchip.com>

Some code manipulating the vif list is still missing some srcu_read_lock /
srcu_read_unlock, and so can trigger RCU warnings:

=============================
WARNING: suspicious RCU usage
6.8.0-rc1+ #37 Not tainted
-----------------------------
drivers/net/wireless/microchip/wilc1000/hif.c:110 RCU-list traversed without holding the required lock!!
[...]
stack backtrace:
CPU: 0 PID: 6 Comm: kworker/0:0 Not tainted 6.8.0-rc1+ #37
Hardware name: Atmel SAMA5
Workqueue: events sdio_irq_work
 unwind_backtrace from show_stack+0x18/0x1c
 show_stack from dump_stack_lvl+0x34/0x58
 dump_stack_lvl from wilc_get_vif_from_idx+0x158/0x180
 wilc_get_vif_from_idx from wilc_network_info_received+0x80/0x48c
 wilc_network_info_received from wilc_handle_isr+0xa10/0xd30
 wilc_handle_isr from wilc_sdio_interrupt+0x44/0x58
 wilc_sdio_interrupt from process_sdio_pending_irqs+0x1c8/0x60c
 process_sdio_pending_irqs from sdio_irq_work+0x6c/0x14c
 sdio_irq_work from process_one_work+0x8d4/0x169c
 process_one_work from worker_thread+0x8cc/0x1340
 worker_thread from kthread+0x448/0x510
 kthread from ret_from_fork+0x14/0x28

Fix those warnings by adding the needed lock around the corresponding
critical sections

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Co-developed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.c    | 52 +++++++++++++-----------
 drivers/net/wireless/microchip/wilc1000/netdev.c |  8 +++-
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index c42859a727c3..f1085ccb7eed 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1570,23 +1570,25 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 	struct host_if_drv *hif_drv;
 	struct host_if_msg *msg;
 	struct wilc_vif *vif;
+	int srcu_idx;
 	int result;
 	int id;
 
 	id = get_unaligned_le32(&buffer[length - 4]);
+	srcu_idx = srcu_read_lock(&wilc->srcu);
 	vif = wilc_get_vif_from_idx(wilc, id);
 	if (!vif)
-		return;
-	hif_drv = vif->hif_drv;
+		goto out;
 
+	hif_drv = vif->hif_drv;
 	if (!hif_drv) {
 		netdev_err(vif->ndev, "driver not init[%p]\n", hif_drv);
-		return;
+		goto out;
 	}
 
 	msg = wilc_alloc_work(vif, handle_rcvd_ntwrk_info, false);
 	if (IS_ERR(msg))
-		return;
+		goto out;
 
 	msg->body.net_info.frame_len = get_unaligned_le16(&buffer[6]) - 1;
 	msg->body.net_info.rssi = buffer[8];
@@ -1595,7 +1597,7 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 					  GFP_KERNEL);
 	if (!msg->body.net_info.mgmt) {
 		kfree(msg);
-		return;
+		goto out;
 	}
 
 	result = wilc_enqueue_work(msg);
@@ -1604,6 +1606,8 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 		kfree(msg->body.net_info.mgmt);
 		kfree(msg);
 	}
+out:
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
 }
 
 void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 length)
@@ -1611,36 +1615,32 @@ void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 	struct host_if_drv *hif_drv;
 	struct host_if_msg *msg;
 	struct wilc_vif *vif;
+	int srcu_idx;
 	int result;
 	int id;
 
 	mutex_lock(&wilc->deinit_lock);
 
 	id = get_unaligned_le32(&buffer[length - 4]);
+	srcu_idx = srcu_read_lock(&wilc->srcu);
 	vif = wilc_get_vif_from_idx(wilc, id);
-	if (!vif) {
-		mutex_unlock(&wilc->deinit_lock);
-		return;
-	}
+	if (!vif)
+		goto out;
 
 	hif_drv = vif->hif_drv;
 
 	if (!hif_drv) {
-		mutex_unlock(&wilc->deinit_lock);
-		return;
+		goto out;
 	}
 
 	if (!hif_drv->conn_info.conn_result) {
 		netdev_err(vif->ndev, "%s: conn_result is NULL\n", __func__);
-		mutex_unlock(&wilc->deinit_lock);
-		return;
+		goto out;
 	}
 
 	msg = wilc_alloc_work(vif, handle_rcvd_gnrl_async_info, false);
-	if (IS_ERR(msg)) {
-		mutex_unlock(&wilc->deinit_lock);
-		return;
-	}
+	if (IS_ERR(msg))
+		goto out;
 
 	msg->body.mac_info.status = buffer[7];
 	result = wilc_enqueue_work(msg);
@@ -1648,7 +1648,8 @@ void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 		netdev_err(vif->ndev, "%s: enqueue work failed\n", __func__);
 		kfree(msg);
 	}
-
+out:
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
 	mutex_unlock(&wilc->deinit_lock);
 }
 
@@ -1656,24 +1657,27 @@ void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length)
 {
 	struct host_if_drv *hif_drv;
 	struct wilc_vif *vif;
+	int srcu_idx;
 	int result;
 	int id;
 
 	id = get_unaligned_le32(&buffer[length - 4]);
+	srcu_idx = srcu_read_lock(&wilc->srcu);
 	vif = wilc_get_vif_from_idx(wilc, id);
 	if (!vif)
-		return;
-	hif_drv = vif->hif_drv;
+		goto out;
 
-	if (!hif_drv)
-		return;
+	hif_drv = vif->hif_drv;
+	if (!hif_drv) {
+		goto out;
+	}
 
 	if (hif_drv->usr_scan_req.scan_result) {
 		struct host_if_msg *msg;
 
 		msg = wilc_alloc_work(vif, handle_scan_complete, false);
 		if (IS_ERR(msg))
-			return;
+			goto out;
 
 		result = wilc_enqueue_work(msg);
 		if (result) {
@@ -1682,6 +1686,8 @@ void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length)
 			kfree(msg);
 		}
 	}
+out:
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
 }
 
 int wilc_remain_on_channel(struct wilc_vif *vif, u64 cookie, u16 chan,
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 092801d33915..710e29bea560 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -819,14 +819,16 @@ void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size,
 	unsigned int frame_len = 0;
 	struct wilc_vif *vif;
 	struct sk_buff *skb;
+	int srcu_idx;
 	int stats;
 
 	if (!wilc)
 		return;
 
+	srcu_idx = srcu_read_lock(&wilc->srcu);
 	wilc_netdev = get_if_handler(wilc, buff);
 	if (!wilc_netdev)
-		return;
+		goto out;
 
 	buff += pkt_offset;
 	vif = netdev_priv(wilc_netdev);
@@ -837,7 +839,7 @@ void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size,
 
 		skb = dev_alloc_skb(frame_len);
 		if (!skb)
-			return;
+			goto out;
 
 		skb->dev = wilc_netdev;
 
@@ -850,6 +852,8 @@ void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size,
 		stats = netif_rx(skb);
 		netdev_dbg(wilc_netdev, "netif_rx ret value is: %d\n", stats);
 	}
+out:
+	srcu_read_unlock(&wilc->srcu, srcu_idx);
 }
 
 void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size, bool is_auth)

-- 
2.43.0


