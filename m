Return-Path: <linux-kernel+bounces-115853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3245889C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368A1B31DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F2937E97D;
	Mon, 25 Mar 2024 03:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6mzXgKk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E5535BF;
	Sun, 24 Mar 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322043; cv=none; b=hi004HrMM21KSrd/7/arkVlP/FUFQXTNWo8yyuRBBojHWaCgHIW6Ga+embf76kEpkk8Af03RvnVQbdO2gVmLK7Y8fsNRZsOmJ9Z2ZdwheHJDx6QecMIlQACm+9ICj5OUqaqrbJ3QqL9bNa4oy77TXm0EApilvmDg74ApaC55Hw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322043; c=relaxed/simple;
	bh=WCMElm0FEksMpnIVlx+GauY2XrT0KIduJ3+8VE2+36Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qa6nEqcPqIlzUSfx1GQsmJyZI3YoOZPWwfAr8nLqDhepo0TKbf7Uj4FWefsYalPnf+9zpvp28GX5CdZA0HM23vkA7jgBiWFpiWbhaoVXMO6IsDAnPH/D6p0bXYku6au5qJ+H0rBdkRBwqentp6bHLi0YywIisRWcFX6YMBqqWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6mzXgKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4568DC433C7;
	Sun, 24 Mar 2024 23:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322043;
	bh=WCMElm0FEksMpnIVlx+GauY2XrT0KIduJ3+8VE2+36Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6mzXgKkaKHzkELMcJ/BzF37Q3eBkr/eCnG16RDC6OHv20V6Qy/vLC3UmHzr/4fYX
	 ys3FIG95gcPexVS5X/mC27SZvzKT48vQC8fBOxiaT9He92BhAqebhbA8gpD5r92og1
	 Q2MI/7LQnJh7x5XuFUkJEDVQ5DLSLkJ8UeNWLIZUPHwdMsBQbkQ0hLQR7NMoI17dG4
	 y1nFdJEV7TN75tClINBs9qjIm+1+/hEZRc+02rYIFZb8O1uBUrNOkhKWhr+i7dj5hW
	 +dzTAJ70hNkqFkuNkrElzfi/lqd+gacaWHKOlZdVTGwVUjRLPo1Ee4mpFty8wv2mpI
	 Wze+IaeBZDT6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Ubisectech Sirius <bugreport@ubisectech.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 115/451] wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until init is complete
Date: Sun, 24 Mar 2024 19:06:31 -0400
Message-ID: <20240324231207.1351418-116-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 24355fcb0d4cbcb6ddda262596558e8cfba70f11 ]

The ath9k_wmi_event_tasklet() used in ath9k_htc assumes that all the data
structures have been fully initialised by the time it runs. However, because of
the order in which things are initialised, this is not guaranteed to be the
case, because the device is exposed to the USB subsystem before the ath9k driver
initialisation is completed.

We already committed a partial fix for this in commit:
8b3046abc99e ("ath9k_htc: fix NULL pointer dereference at ath9k_htc_tx_get_packet()")

However, that commit only aborted the WMI_TXSTATUS_EVENTID command in the event
tasklet, pairing it with an "initialisation complete" bit in the TX struct. It
seems syzbot managed to trigger the race for one of the other commands as well,
so let's just move the existing synchronisation bit to cover the whole
tasklet (setting it at the end of ath9k_htc_probe_device() instead of inside
ath9k_tx_init()).

Link: https://lore.kernel.org/r/ed1d2c66-1193-4c81-9542-d514c29ba8b8.bugreport@ubisectech.com
Fixes: 8b3046abc99e ("ath9k_htc: fix NULL pointer dereference at ath9k_htc_tx_get_packet()")
Reported-by: Ubisectech Sirius <bugreport@ubisectech.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240126140218.1033443-1-toke@toke.dk
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/htc.h          |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c |  4 ++++
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c |  4 ----
 drivers/net/wireless/ath/ath9k/wmi.c          | 10 ++++++----
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc.h b/drivers/net/wireless/ath/ath9k/htc.h
index 237f4ec2cffd7..6c33e898b3000 100644
--- a/drivers/net/wireless/ath/ath9k/htc.h
+++ b/drivers/net/wireless/ath/ath9k/htc.h
@@ -306,7 +306,6 @@ struct ath9k_htc_tx {
 	DECLARE_BITMAP(tx_slot, MAX_TX_BUF_NUM);
 	struct timer_list cleanup_timer;
 	spinlock_t tx_lock;
-	bool initialized;
 };
 
 struct ath9k_htc_tx_ctl {
@@ -515,6 +514,7 @@ struct ath9k_htc_priv {
 	unsigned long ps_usecount;
 	bool ps_enabled;
 	bool ps_idle;
+	bool initialized;
 
 #ifdef CONFIG_MAC80211_LEDS
 	enum led_brightness brightness;
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index 96a3185a96d75..b014185373f34 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -966,6 +966,10 @@ int ath9k_htc_probe_device(struct htc_target *htc_handle, struct device *dev,
 
 	htc_handle->drv_priv = priv;
 
+	/* Allow ath9k_wmi_event_tasklet() to operate. */
+	smp_wmb();
+	priv->initialized = true;
+
 	return 0;
 
 err_init:
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index d6a3f001dacb9..2fdd27885f543 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -815,10 +815,6 @@ int ath9k_tx_init(struct ath9k_htc_priv *priv)
 	skb_queue_head_init(&priv->tx.data_vo_queue);
 	skb_queue_head_init(&priv->tx.tx_failed);
 
-	/* Allow ath9k_wmi_event_tasklet(WMI_TXSTATUS_EVENTID) to operate. */
-	smp_wmb();
-	priv->tx.initialized = true;
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 1476b42b52a91..805ad31edba2b 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -155,6 +155,12 @@ void ath9k_wmi_event_tasklet(struct tasklet_struct *t)
 		}
 		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
+		/* Check if ath9k_htc_probe_device() completed. */
+		if (!data_race(priv->initialized)) {
+			kfree_skb(skb);
+			continue;
+		}
+
 		hdr = (struct wmi_cmd_hdr *) skb->data;
 		cmd_id = be16_to_cpu(hdr->command_id);
 		wmi_event = skb_pull(skb, sizeof(struct wmi_cmd_hdr));
@@ -169,10 +175,6 @@ void ath9k_wmi_event_tasklet(struct tasklet_struct *t)
 					     &wmi->drv_priv->fatal_work);
 			break;
 		case WMI_TXSTATUS_EVENTID:
-			/* Check if ath9k_tx_init() completed. */
-			if (!data_race(priv->tx.initialized))
-				break;
-
 			spin_lock_bh(&priv->tx.tx_lock);
 			if (priv->tx.flags & ATH9K_HTC_OP_TX_DRAIN) {
 				spin_unlock_bh(&priv->tx.tx_lock);
-- 
2.43.0


