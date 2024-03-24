Return-Path: <linux-kernel+bounces-114131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABDB8888A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F5B289829
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E52C241067;
	Sun, 24 Mar 2024 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4gNUaPf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB3B202BA5;
	Sun, 24 Mar 2024 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321441; cv=none; b=ovpmqp0PLn0yMO0BfZxTDO03H7EV9xIl9z7gXDG5BiOLSc4w2cbGdWd+hidHPqrq1iLY3CqpXoOR/+sg7zGm5whWf1nERIXnogmEbiQUKx/eRtyqR+Uvm+QpBXSQVt9nfhRbeZdW3wB2za3Nh/By9ERKoLa4EDYqcZIA3f5tesQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321441; c=relaxed/simple;
	bh=1yO6Bm5QHbB+eG36tu0OfKUmHNWbARgzr8XKKHv106E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NfY1ULF+Qrfdy84lj0nC+T6cM2Gyjfc/FQYa0Ws6q/ZnDT5kYNCMO+j1JrgBejAQQLqgFEtYMjsI/mZV9n2SxQaEUmZOAQiqJOMOPmHhQOTMkc46YC3Z91HE8qk6vGblNWV6+5FGeNlhfd+SIzjIPv45dkD9/phR3UqZckLQYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4gNUaPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4321CC433F1;
	Sun, 24 Mar 2024 23:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321440;
	bh=1yO6Bm5QHbB+eG36tu0OfKUmHNWbARgzr8XKKHv106E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I4gNUaPfkXd8akkmshfZwwC3+yxKxBdt97t1dc8p+KzGuxbHb8cMeCdiR2ptrRSZ0
	 oCrF18jNEmE0jgctk59WtGF4vPfjq5NMu4rlLpDc/Uj9lqRUEM2V3sxWZFfqimrJRk
	 pwenXLUcNUe0FbyV6GyLD9xqAGibG+Xk+xFaqjUme/LsEK6OwbL4QjC4KEwLCIFnHw
	 +RbaWLmYYe8keDzPU3jt2IDySD58TLMp3zHwfdWWXurtDxaqCkwm2ZHsYBILtOUEdV
	 ef3oZFk8/Fpn+Q32MxwNsGXcu83xY2SMKc+koU8uyEmd69bPyESoR3KQIbtppjj4OF
	 0GTkRrw18l6kQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Ubisectech Sirius <bugreport@ubisectech.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 164/638] wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until init is complete
Date: Sun, 24 Mar 2024 18:53:21 -0400
Message-ID: <20240324230116.1348576-165-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index dae3d9c7b6408..fc339079ee8c9 100644
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


