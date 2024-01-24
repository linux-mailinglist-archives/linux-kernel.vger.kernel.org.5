Return-Path: <linux-kernel+bounces-37403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E402E83AF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21EC71C2170D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CE97E58E;
	Wed, 24 Jan 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="QNluEfPs"
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A777E762;
	Wed, 24 Jan 2024 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116330; cv=none; b=IwBty8/niXW4sDwi1keTuAeMeMYGPubu+z8BgspPQ5iz7GsqrBokKgPx8vep/1by1zIilbCnf8h+drz9YXskXts/zpTM52/zskj/xXrTfPh3t0c/eBDIYvJ1OcDI/7i5O1CmZ6p45lKZabpa5M/aXVKEfVXv8LlsnKslSeIxjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116330; c=relaxed/simple;
	bh=5qz2F9Z7NYBi7ZTnYZWey+cuP9uUiWX83QGOe5SsFBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LdErJmIlEN/Yolw9C17Pkr8eueidvRivrTQKimEee1+/HhCVDjLR5EuwthjCXibxOluUn99aao7tnAgjUJUsmuaabrj5pyf5qXhSRYDXzAY3VwU9Tn7scF/Sg+U6r9hK0/6rx71RZquoDMrH75nUAO1thx0wppn5tOLA7Fv+73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=QNluEfPs; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1706115966; bh=5qz2F9Z7NYBi7ZTnYZWey+cuP9uUiWX83QGOe5SsFBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QNluEfPsizytP2tnYUMdOgBwVBeQGESRulGkuYWC/HVzkxWxG/RT2PEdUKegyRqZ2
	 MQdVzI70/J9t6+B0+0l01dlTBZMpnz8HdZP3Wg9URyDIvmSW/9tU7+rRhqafTEWT87
	 jVvGT9bv0QSi8VaF010SEcli4WGPYyoYaDa9S886kdtehoLtwnDG/K9m8XUzv9z/4H
	 3K9DDJIArw0k5wmGc0UE+E9RfAreEsWEpYmT5ZkbD++1LmXla8nkLWZqrfTrxGvvGi
	 NTpefIHxTO1P7uUndY4pZYKjVJxCxe6fZ9Rshov4Z6JkoXm4S3qMHDrce2o8WR3YqY
	 LO5bq88ADNV3g==
To: Ubisectech Sirius <bugreport@ubisectech.com>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Cc: johannes <johannes@sipsolutions.net>, kvalo <kvalo@kernel.org>
Subject: Re: general protection fault in ath9k_wmi_event_tasklet
In-Reply-To: <ed1d2c66-1193-4c81-9542-d514c29ba8b8.bugreport@ubisectech.com>
References: <ed1d2c66-1193-4c81-9542-d514c29ba8b8.bugreport@ubisectech.com>
Date: Wed, 24 Jan 2024 18:06:06 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <878r4e4q69.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ubisectech Sirius" <bugreport@ubisectech.com> writes:

> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.7.0-g9d1694dc91ce. Attached to the email were a POC file of the issue.
> Stack dump:
> general protection fault, probably for non-canonical address 0xdffffc0000000038: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
> CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.7.0-g9d1694dc91ce #20
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:__queue_work+0x9d/0x1160 kernel/workqueue.c:1727
> Call Trace:
> <TASK>
> queue_work_on+0xf2/0x110 kernel/workqueue.c:1837
> queue_work include/linux/workqueue.h:548 [inline]
> ieee80211_queue_work net/mac80211/util.c:898 [inline]
> ieee80211_queue_work+0x111/0x180 net/mac80211/util.c:891
> ath9k_wmi_event_tasklet+0x327/0x450 drivers/net/wireless/ath/ath9k/wmi.c:168
> tasklet_action_common.constprop.0+0x229/0x390 kernel/softirq.c:780
> __do_softirq+0x1d4/0x85e kernel/softirq.c:553
> run_ksoftirqd kernel/softirq.c:921 [inline]
> run_ksoftirqd+0x31/0x60 kernel/softirq.c:913
> smpboot_thread_fn+0x63c/0x9f0 kernel/smpboot.c:164
> kthread+0x2cc/0x3b0 kernel/kthread.c:388
> ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__queue_work+0x9d/0x1160 kernel/workqueue.c:1727
> Thank you for taking the time to read this email and we look forward
> to working with you further.

Hmm, so from eyeballing the code in question, this looks like it is
another initialisation race along the lines of the one fixed in commit:
8b3046abc99e ("ath9k_htc: fix NULL pointer dereference at ath9k_htc_tx_get_packet()")

Could you please test the patch below and see if you can still reproduce
this issue with that applied?

-Toke



diff --git a/drivers/net/wireless/ath/ath9k/htc.h b/drivers/net/wireless/ath/ath9k/htc.h
index 237f4ec2cffd..6c33e898b300 100644
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
index dae3d9c7b640..fc339079ee8c 100644
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
index 672789e3c55d..768ed8ea5c9f 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -814,10 +814,6 @@ int ath9k_tx_init(struct ath9k_htc_priv *priv)
 	skb_queue_head_init(&priv->tx.data_vo_queue);
 	skb_queue_head_init(&priv->tx.tx_failed);
 
-	/* Allow ath9k_wmi_event_tasklet(WMI_TXSTATUS_EVENTID) to operate. */
-	smp_wmb();
-	priv->tx.initialized = true;
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 1476b42b52a9..805ad31edba2 100644
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

