Return-Path: <linux-kernel+bounces-102124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A236F87AEA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0B01F2B87E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918F56BFDE;
	Wed, 13 Mar 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCmwIiap"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2F6BFB6;
	Wed, 13 Mar 2024 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349340; cv=none; b=HwsskytEdUnjOCESj9Jmd9Gab0thHusl+bLt5A4zfM9FJWMm3k0gDnEzw/af55cpoL2CGHRFfAMIKkvKyTKa0rPvjcPX/jKjI4eFkRo8ADHN3c7F7Vk7CmGCMq8+xC6pWSvSk+ED9VJaHX52dPYpg5iZhOXXFoYnlF5iYysWnV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349340; c=relaxed/simple;
	bh=gBhKBuutN2Jcaq4cPMS5MnFU38N1vpCn+ppVklzChYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSwFWp4usXab1MGnGoqpUs9c+CcAnj/jLwvyFLbrEcP5CB+iKqDbrJV982ecH9qTxGnoZXKO+Jotx3zs7roJNgNw232wBJ+9fMQRBNIGGMmVqAj5fhLVx/IfzZSCAg++TFGm2IsGsSO90wvfqQpNEoZjnt5AlZTbeYDDrWwpX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCmwIiap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3533C433A6;
	Wed, 13 Mar 2024 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349339;
	bh=gBhKBuutN2Jcaq4cPMS5MnFU38N1vpCn+ppVklzChYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCmwIiapJqstUnLeBQQW0XuiSNBAzTXEatYfEtaQx/XmzuGOD1SFZaeFZgJp7jb5+
	 DXScdQw5tg7bAWWGRiHQrk/bHO1mlK+BV32+fZzLBwV6umUw29ueyEHK2sNIj5/bsq
	 Cn3yWIl0iYNbcj8lMr8KIsDTls6OPjtwdCna2YeY/zEO8LUn4RRXPSzf/fUCQol1WY
	 HaKN6UoYVKTzOTX1mL8xpCTkVs6wiKsM0yGG7Ji8rS3Gn+9MppnRu2ebXSlLRx9Idq
	 jWS7CVAft8XuKtfVkB88gEatcTuezBdeWisP2PyAbcLTy9wU+fG7utnv8EWblJ6Fiz
	 uHiznH4D0oZmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Efstathiades <john.efstathiades@pebblebay.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 04/51] lan78xx: Fix race conditions in suspend/resume handling
Date: Wed, 13 Mar 2024 13:01:25 -0400
Message-ID: <20240313170212.616443-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: John Efstathiades <john.efstathiades@pebblebay.com>

[ Upstream commit 5f4cc6e25148cc141f97afb41b4dfe9eb1cce613 ]

If the interface is given an IP address while the device is
suspended (as a result of an auto-suspend event) there is a race
between lan78xx_resume() and lan78xx_open() that can result in an
exception or failure to handle incoming packets. The following
changes fix this problem.

Introduce a mutex to serialise operations in the network interface
open and stop entry points with respect to the USB driver suspend
and resume entry points.

Move Tx and Rx data path start/stop to lan78xx_start() and
lan78xx_stop() respectively and flush the packet FIFOs before
starting the Tx and Rx data paths. This prevents the MAC and FIFOs
getting out of step and delivery of malformed packets to the network
stack.

Stop processing of received packets before disconnecting the
PHY from the MAC to prevent a kernel exception caused by handling
packets after the PHY device has been removed.

Refactor device auto-suspend code to make it consistent with the
the system suspend code and make the suspend handler easier to read.

Add new code to stop wake-on-lan packets or PHY events resuming the
host or device from suspend if the device has not been opened
(typically after an IP address is assigned).

This patch is dependent on changes to lan78xx_suspend() and
lan78xx_resume() introduced in the previous patch of this patch set.

Signed-off-by: John Efstathiades <john.efstathiades@pebblebay.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1eecc7ab82c4 ("net: lan78xx: fix runtime PM count underflow on link stop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 419 ++++++++++++++++++++++++++------------
 1 file changed, 284 insertions(+), 135 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 020ea7b960936..42fe7753ff76d 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -390,6 +390,7 @@ struct lan78xx_net {
 	struct urb		*urb_intr;
 	struct usb_anchor	deferred;
 
+	struct mutex		dev_mutex; /* serialise open/stop wrt suspend/resume */
 	struct mutex		phy_mutex; /* for phy access */
 	unsigned int		pipe_in, pipe_out, pipe_intr;
 
@@ -2295,11 +2296,16 @@ static int lan78xx_change_mtu(struct net_device *netdev, int new_mtu)
 	int ll_mtu = new_mtu + netdev->hard_header_len;
 	int old_hard_mtu = dev->hard_mtu;
 	int old_rx_urb_size = dev->rx_urb_size;
+	int ret;
 
 	/* no second zero-length packet read wanted after mtu-sized packets */
 	if ((ll_mtu % dev->maxpacket) == 0)
 		return -EDOM;
 
+	ret = usb_autopm_get_interface(dev->intf);
+	if (ret < 0)
+		return ret;
+
 	lan78xx_set_rx_max_frame_length(dev, new_mtu + VLAN_ETH_HLEN);
 
 	netdev->mtu = new_mtu;
@@ -2315,6 +2321,8 @@ static int lan78xx_change_mtu(struct net_device *netdev, int new_mtu)
 		}
 	}
 
+	usb_autopm_put_interface(dev->intf);
+
 	return 0;
 }
 
@@ -2812,16 +2820,8 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = lan78xx_start_tx_path(dev);
-	if (ret < 0)
-		return ret;
-
 	ret = lan78xx_set_rx_max_frame_length(dev,
 					      dev->net->mtu + VLAN_ETH_HLEN);
-	if (ret < 0)
-		return ret;
-
-	ret = lan78xx_start_rx_path(dev);
 
 	return ret;
 }
@@ -2857,10 +2857,14 @@ static int lan78xx_open(struct net_device *net)
 	struct lan78xx_net *dev = netdev_priv(net);
 	int ret;
 
+	netif_dbg(dev, ifup, dev->net, "open device");
+
 	ret = usb_autopm_get_interface(dev->intf);
 	if (ret < 0)
 		return ret;
 
+	mutex_lock(&dev->dev_mutex);
+
 	phy_start(net->phydev);
 
 	netif_dbg(dev, ifup, dev->net, "phy initialised successfully");
@@ -2875,6 +2879,20 @@ static int lan78xx_open(struct net_device *net)
 		}
 	}
 
+	ret = lan78xx_flush_rx_fifo(dev);
+	if (ret < 0)
+		goto done;
+	ret = lan78xx_flush_tx_fifo(dev);
+	if (ret < 0)
+		goto done;
+
+	ret = lan78xx_start_tx_path(dev);
+	if (ret < 0)
+		goto done;
+	ret = lan78xx_start_rx_path(dev);
+	if (ret < 0)
+		goto done;
+
 	lan78xx_init_stats(dev);
 
 	set_bit(EVENT_DEV_OPEN, &dev->flags);
@@ -2885,6 +2903,8 @@ static int lan78xx_open(struct net_device *net)
 
 	lan78xx_defer_kevent(dev, EVENT_LINK_RESET);
 done:
+	mutex_unlock(&dev->dev_mutex);
+
 	usb_autopm_put_interface(dev->intf);
 
 	return ret;
@@ -2903,38 +2923,56 @@ static void lan78xx_terminate_urbs(struct lan78xx_net *dev)
 	temp = unlink_urbs(dev, &dev->txq) + unlink_urbs(dev, &dev->rxq);
 
 	/* maybe wait for deletions to finish. */
-	while (!skb_queue_empty(&dev->rxq) &&
-	       !skb_queue_empty(&dev->txq) &&
-	       !skb_queue_empty(&dev->done)) {
+	while (!skb_queue_empty(&dev->rxq) ||
+	       !skb_queue_empty(&dev->txq)) {
 		schedule_timeout(msecs_to_jiffies(UNLINK_TIMEOUT_MS));
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		netif_dbg(dev, ifdown, dev->net,
-			  "waited for %d urb completions\n", temp);
+			  "waited for %d urb completions", temp);
 	}
 	set_current_state(TASK_RUNNING);
 	dev->wait = NULL;
 	remove_wait_queue(&unlink_wakeup, &wait);
+
+	while (!skb_queue_empty(&dev->done)) {
+		struct skb_data *entry;
+		struct sk_buff *skb;
+
+		skb = skb_dequeue(&dev->done);
+		entry = (struct skb_data *)(skb->cb);
+		usb_free_urb(entry->urb);
+		dev_kfree_skb(skb);
+	}
 }
 
 static int lan78xx_stop(struct net_device *net)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
 
+	netif_dbg(dev, ifup, dev->net, "stop device");
+
+	mutex_lock(&dev->dev_mutex);
+
 	if (timer_pending(&dev->stat_monitor))
 		del_timer_sync(&dev->stat_monitor);
 
-	if (net->phydev)
-		phy_stop(net->phydev);
-
 	clear_bit(EVENT_DEV_OPEN, &dev->flags);
 	netif_stop_queue(net);
+	tasklet_kill(&dev->bh);
+
+	lan78xx_terminate_urbs(dev);
 
 	netif_info(dev, ifdown, dev->net,
 		   "stop stats: rx/tx %lu/%lu, errs %lu/%lu\n",
 		   net->stats.rx_packets, net->stats.tx_packets,
 		   net->stats.rx_errors, net->stats.tx_errors);
 
-	lan78xx_terminate_urbs(dev);
+	/* ignore errors that occur stopping the Tx and Rx data paths */
+	lan78xx_stop_tx_path(dev);
+	lan78xx_stop_rx_path(dev);
+
+	if (net->phydev)
+		phy_stop(net->phydev);
 
 	usb_kill_urb(dev->urb_intr);
 
@@ -2944,12 +2982,17 @@ static int lan78xx_stop(struct net_device *net)
 	 * can't flush_scheduled_work() until we drop rtnl (later),
 	 * else workers could deadlock; so make workers a NOP.
 	 */
-	dev->flags = 0;
+	clear_bit(EVENT_TX_HALT, &dev->flags);
+	clear_bit(EVENT_RX_HALT, &dev->flags);
+	clear_bit(EVENT_LINK_RESET, &dev->flags);
+	clear_bit(EVENT_STAT_UPDATE, &dev->flags);
+
 	cancel_delayed_work_sync(&dev->wq);
-	tasklet_kill(&dev->bh);
 
 	usb_autopm_put_interface(dev->intf);
 
+	mutex_unlock(&dev->dev_mutex);
+
 	return 0;
 }
 
@@ -3072,6 +3115,9 @@ lan78xx_start_xmit(struct sk_buff *skb, struct net_device *net)
 	struct lan78xx_net *dev = netdev_priv(net);
 	struct sk_buff *skb2 = NULL;
 
+	if (test_bit(EVENT_DEV_ASLEEP, &dev->flags))
+		schedule_delayed_work(&dev->wq, 0);
+
 	if (skb) {
 		skb_tx_timestamp(skb);
 		skb2 = lan78xx_tx_prep(dev, skb, GFP_ATOMIC);
@@ -3678,18 +3724,17 @@ static void lan78xx_delayedwork(struct work_struct *work)
 
 	dev = container_of(work, struct lan78xx_net, wq.work);
 
+	if (usb_autopm_get_interface(dev->intf) < 0)
+		return;
+
 	if (test_bit(EVENT_TX_HALT, &dev->flags)) {
 		unlink_urbs(dev, &dev->txq);
-		status = usb_autopm_get_interface(dev->intf);
-		if (status < 0)
-			goto fail_pipe;
+
 		status = usb_clear_halt(dev->udev, dev->pipe_out);
-		usb_autopm_put_interface(dev->intf);
 		if (status < 0 &&
 		    status != -EPIPE &&
 		    status != -ESHUTDOWN) {
 			if (netif_msg_tx_err(dev))
-fail_pipe:
 				netdev_err(dev->net,
 					   "can't clear tx halt, status %d\n",
 					   status);
@@ -3699,18 +3744,14 @@ static void lan78xx_delayedwork(struct work_struct *work)
 				netif_wake_queue(dev->net);
 		}
 	}
+
 	if (test_bit(EVENT_RX_HALT, &dev->flags)) {
 		unlink_urbs(dev, &dev->rxq);
-		status = usb_autopm_get_interface(dev->intf);
-		if (status < 0)
-			goto fail_halt;
 		status = usb_clear_halt(dev->udev, dev->pipe_in);
-		usb_autopm_put_interface(dev->intf);
 		if (status < 0 &&
 		    status != -EPIPE &&
 		    status != -ESHUTDOWN) {
 			if (netif_msg_rx_err(dev))
-fail_halt:
 				netdev_err(dev->net,
 					   "can't clear rx halt, status %d\n",
 					   status);
@@ -3724,16 +3765,9 @@ static void lan78xx_delayedwork(struct work_struct *work)
 		int ret = 0;
 
 		clear_bit(EVENT_LINK_RESET, &dev->flags);
-		status = usb_autopm_get_interface(dev->intf);
-		if (status < 0)
-			goto skip_reset;
 		if (lan78xx_link_reset(dev) < 0) {
-			usb_autopm_put_interface(dev->intf);
-skip_reset:
 			netdev_info(dev->net, "link reset failed (%d)\n",
 				    ret);
-		} else {
-			usb_autopm_put_interface(dev->intf);
 		}
 	}
 
@@ -3747,6 +3781,8 @@ static void lan78xx_delayedwork(struct work_struct *work)
 
 		dev->delta = min((dev->delta * 2), 50);
 	}
+
+	usb_autopm_put_interface(dev->intf);
 }
 
 static void intr_complete(struct urb *urb)
@@ -3906,6 +3942,7 @@ static int lan78xx_probe(struct usb_interface *intf,
 	skb_queue_head_init(&dev->rxq_pause);
 	skb_queue_head_init(&dev->txq_pend);
 	mutex_init(&dev->phy_mutex);
+	mutex_init(&dev->dev_mutex);
 
 	tasklet_init(&dev->bh, lan78xx_bh, (unsigned long)dev);
 	INIT_DELAYED_WORK(&dev->wq, lan78xx_delayedwork);
@@ -4048,6 +4085,74 @@ static u16 lan78xx_wakeframe_crc16(const u8 *buf, int len)
 	return crc;
 }
 
+static int lan78xx_set_auto_suspend(struct lan78xx_net *dev)
+{
+	u32 buf;
+	int ret;
+
+	ret = lan78xx_stop_tx_path(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_stop_rx_path(dev);
+	if (ret < 0)
+		return ret;
+
+	/* auto suspend (selective suspend) */
+
+	ret = lan78xx_write_reg(dev, WUCSR, 0);
+	if (ret < 0)
+		return ret;
+	ret = lan78xx_write_reg(dev, WUCSR2, 0);
+	if (ret < 0)
+		return ret;
+	ret = lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
+	if (ret < 0)
+		return ret;
+
+	/* set goodframe wakeup */
+
+	ret = lan78xx_read_reg(dev, WUCSR, &buf);
+	if (ret < 0)
+		return ret;
+
+	buf |= WUCSR_RFE_WAKE_EN_;
+	buf |= WUCSR_STORE_WAKE_;
+
+	ret = lan78xx_write_reg(dev, WUCSR, buf);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
+	buf &= ~PMT_CTL_RES_CLR_WKP_EN_;
+	buf |= PMT_CTL_RES_CLR_WKP_STS_;
+	buf |= PMT_CTL_PHY_WAKE_EN_;
+	buf |= PMT_CTL_WOL_EN_;
+	buf &= ~PMT_CTL_SUS_MODE_MASK_;
+	buf |= PMT_CTL_SUS_MODE_3_;
+
+	ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
+	buf |= PMT_CTL_WUPS_MASK_;
+
+	ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_start_rx_path(dev);
+
+	return ret;
+}
+
 static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 {
 	const u8 ipv4_multicast[3] = { 0x01, 0x00, 0x5E };
@@ -4248,18 +4353,25 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct lan78xx_net *dev = usb_get_intfdata(intf);
-	u32 buf;
+	bool dev_open;
 	int ret;
 	int event;
 
 	event = message.event;
 
-	if (!dev->suspend_count++) {
+	mutex_lock(&dev->dev_mutex);
+
+	netif_dbg(dev, ifdown, dev->net,
+		  "suspending: pm event %#x", message.event);
+
+	dev_open = test_bit(EVENT_DEV_OPEN, &dev->flags);
+
+	if (dev_open) {
 		spin_lock_irq(&dev->txq.lock);
 		/* don't autosuspend while transmitting */
 		if ((skb_queue_len(&dev->txq) ||
 		     skb_queue_len(&dev->txq_pend)) &&
-			PMSG_IS_AUTO(message)) {
+		    PMSG_IS_AUTO(message)) {
 			spin_unlock_irq(&dev->txq.lock);
 			ret = -EBUSY;
 			goto out;
@@ -4271,171 +4383,204 @@ static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 		/* stop RX */
 		ret = lan78xx_stop_rx_path(dev);
 		if (ret < 0)
-			return ret;
+			goto out;
 
 		ret = lan78xx_flush_rx_fifo(dev);
 		if (ret < 0)
-			return ret;
+			goto out;
 
 		/* stop Tx */
 		ret = lan78xx_stop_tx_path(dev);
 		if (ret < 0)
-			return ret;
+			goto out;
 
-		/* empty out the rx and queues */
+		/* empty out the Rx and Tx queues */
 		netif_device_detach(dev->net);
 		lan78xx_terminate_urbs(dev);
 		usb_kill_urb(dev->urb_intr);
 
 		/* reattach */
 		netif_device_attach(dev->net);
-	}
 
-	if (test_bit(EVENT_DEV_ASLEEP, &dev->flags)) {
 		del_timer(&dev->stat_monitor);
 
 		if (PMSG_IS_AUTO(message)) {
-			/* auto suspend (selective suspend) */
-			ret = lan78xx_stop_tx_path(dev);
+			ret = lan78xx_set_auto_suspend(dev);
 			if (ret < 0)
-				return ret;
+				goto out;
+		} else {
+			struct lan78xx_priv *pdata;
 
-			ret = lan78xx_stop_rx_path(dev);
+			pdata = (struct lan78xx_priv *)(dev->data[0]);
+			netif_carrier_off(dev->net);
+			ret = lan78xx_set_suspend(dev, pdata->wol);
 			if (ret < 0)
-				return ret;
+				goto out;
+		}
+	} else {
+		/* Interface is down; don't allow WOL and PHY
+		 * events to wake up the host
+		 */
+		u32 buf;
 
-			ret = lan78xx_write_reg(dev, WUCSR, 0);
-			if (ret < 0)
-				return ret;
-			ret = lan78xx_write_reg(dev, WUCSR2, 0);
-			if (ret < 0)
-				return ret;
-			ret = lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
-			if (ret < 0)
-				return ret;
+		set_bit(EVENT_DEV_ASLEEP, &dev->flags);
 
-			/* set goodframe wakeup */
-			ret = lan78xx_read_reg(dev, WUCSR, &buf);
-			if (ret < 0)
-				return ret;
+		ret = lan78xx_write_reg(dev, WUCSR, 0);
+		if (ret < 0)
+			goto out;
+		ret = lan78xx_write_reg(dev, WUCSR2, 0);
+		if (ret < 0)
+			goto out;
 
-			buf |= WUCSR_RFE_WAKE_EN_;
-			buf |= WUCSR_STORE_WAKE_;
+		ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+		if (ret < 0)
+			goto out;
 
-			ret = lan78xx_write_reg(dev, WUCSR, buf);
-			if (ret < 0)
-				return ret;
+		buf &= ~PMT_CTL_RES_CLR_WKP_EN_;
+		buf |= PMT_CTL_RES_CLR_WKP_STS_;
+		buf &= ~PMT_CTL_SUS_MODE_MASK_;
+		buf |= PMT_CTL_SUS_MODE_3_;
 
-			ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
-			if (ret < 0)
-				return ret;
+		ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+		if (ret < 0)
+			goto out;
 
-			buf &= ~PMT_CTL_RES_CLR_WKP_EN_;
-			buf |= PMT_CTL_RES_CLR_WKP_STS_;
+		ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+		if (ret < 0)
+			goto out;
 
-			buf |= PMT_CTL_PHY_WAKE_EN_;
-			buf |= PMT_CTL_WOL_EN_;
-			buf &= ~PMT_CTL_SUS_MODE_MASK_;
-			buf |= PMT_CTL_SUS_MODE_3_;
+		buf |= PMT_CTL_WUPS_MASK_;
 
-			ret = lan78xx_write_reg(dev, PMT_CTL, buf);
-			if (ret < 0)
-				return ret;
+		ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+		if (ret < 0)
+			goto out;
+	}
 
-			ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
-			if (ret < 0)
-				return ret;
+	ret = 0;
+out:
+	mutex_unlock(&dev->dev_mutex);
 
-			buf |= PMT_CTL_WUPS_MASK_;
+	return ret;
+}
 
-			ret = lan78xx_write_reg(dev, PMT_CTL, buf);
-			if (ret < 0)
-				return ret;
+static bool lan78xx_submit_deferred_urbs(struct lan78xx_net *dev)
+{
+	bool pipe_halted = false;
+	struct urb *urb;
 
-			ret = lan78xx_start_rx_path(dev);
-			if (ret < 0)
-				return ret;
-		} else {
-			struct lan78xx_priv *pdata;
+	while ((urb = usb_get_from_anchor(&dev->deferred))) {
+		struct sk_buff *skb = urb->context;
+		int ret;
 
-			pdata = (struct lan78xx_priv *)(dev->data[0]);
+		if (!netif_device_present(dev->net) ||
+		    !netif_carrier_ok(dev->net) ||
+		    pipe_halted) {
+			usb_free_urb(urb);
+			dev_kfree_skb(skb);
+			continue;
+		}
 
-			ret = lan78xx_set_suspend(dev, pdata->wol);
-			if (ret < 0)
-				return ret;
+		ret = usb_submit_urb(urb, GFP_ATOMIC);
+
+		if (ret == 0) {
+			netif_trans_update(dev->net);
+			lan78xx_queue_skb(&dev->txq, skb, tx_start);
+		} else {
+			usb_free_urb(urb);
+			dev_kfree_skb(skb);
+
+			if (ret == -EPIPE) {
+				netif_stop_queue(dev->net);
+				pipe_halted = true;
+			} else if (ret == -ENODEV) {
+				netif_device_detach(dev->net);
+			}
 		}
 	}
 
-	ret = 0;
-out:
-	return ret;
+	return pipe_halted;
 }
 
 static int lan78xx_resume(struct usb_interface *intf)
 {
 	struct lan78xx_net *dev = usb_get_intfdata(intf);
-	struct sk_buff *skb;
-	struct urb *res;
+	bool dev_open;
 	int ret;
 
-	if (!timer_pending(&dev->stat_monitor)) {
-		dev->delta = 1;
-		mod_timer(&dev->stat_monitor,
-			  jiffies + STAT_UPDATE_TIMER);
-	}
+	mutex_lock(&dev->dev_mutex);
 
-	ret = lan78xx_flush_tx_fifo(dev);
-	if (ret < 0)
-		return ret;
+	netif_dbg(dev, ifup, dev->net, "resuming device");
 
-	if (!--dev->suspend_count) {
-		/* resume interrupt URBs */
-		if (dev->urb_intr && test_bit(EVENT_DEV_OPEN, &dev->flags)) {
-			ret = usb_submit_urb(dev->urb_intr, GFP_NOIO);
-			if (ret < 0)
-				return ret;
-		}
+	dev_open = test_bit(EVENT_DEV_OPEN, &dev->flags);
+
+	if (dev_open) {
+		bool pipe_halted = false;
+
+		ret = lan78xx_flush_tx_fifo(dev);
+		if (ret < 0)
+			goto out;
+
+		if (dev->urb_intr) {
+			int ret = usb_submit_urb(dev->urb_intr, GFP_KERNEL);
 
-		spin_lock_irq(&dev->txq.lock);
-		while ((res = usb_get_from_anchor(&dev->deferred))) {
-			skb = (struct sk_buff *)res->context;
-			ret = usb_submit_urb(res, GFP_ATOMIC);
 			if (ret < 0) {
-				dev_kfree_skb_any(skb);
-				usb_free_urb(res);
-				usb_autopm_put_interface_async(dev->intf);
-			} else {
-				netif_trans_update(dev->net);
-				lan78xx_queue_skb(&dev->txq, skb, tx_start);
+				if (ret == -ENODEV)
+					netif_device_detach(dev->net);
+
+			netdev_warn(dev->net, "Failed to submit intr URB");
 			}
 		}
 
+		spin_lock_irq(&dev->txq.lock);
+
+		if (netif_device_present(dev->net)) {
+			pipe_halted = lan78xx_submit_deferred_urbs(dev);
+
+			if (pipe_halted)
+				lan78xx_defer_kevent(dev, EVENT_TX_HALT);
+		}
+
 		clear_bit(EVENT_DEV_ASLEEP, &dev->flags);
+
 		spin_unlock_irq(&dev->txq.lock);
 
-		if (test_bit(EVENT_DEV_OPEN, &dev->flags)) {
-			if (!(skb_queue_len(&dev->txq) >= dev->tx_qlen))
-				netif_start_queue(dev->net);
-			tasklet_schedule(&dev->bh);
+		if (!pipe_halted &&
+		    netif_device_present(dev->net) &&
+		    (skb_queue_len(&dev->txq) < dev->tx_qlen))
+			netif_start_queue(dev->net);
+
+		ret = lan78xx_start_tx_path(dev);
+		if (ret < 0)
+			goto out;
+
+		tasklet_schedule(&dev->bh);
+
+		if (!timer_pending(&dev->stat_monitor)) {
+			dev->delta = 1;
+			mod_timer(&dev->stat_monitor,
+				  jiffies + STAT_UPDATE_TIMER);
 		}
+
+	} else {
+		clear_bit(EVENT_DEV_ASLEEP, &dev->flags);
 	}
 
 	ret = lan78xx_write_reg(dev, WUCSR2, 0);
 	if (ret < 0)
-		return ret;
+		goto out;
 	ret = lan78xx_write_reg(dev, WUCSR, 0);
 	if (ret < 0)
-		return ret;
+		goto out;
 	ret = lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = lan78xx_write_reg(dev, WUCSR2, WUCSR2_NS_RCD_ |
 					     WUCSR2_ARP_RCD_ |
 					     WUCSR2_IPV6_TCPSYN_RCD_ |
 					     WUCSR2_IPV4_TCPSYN_RCD_);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = lan78xx_write_reg(dev, WUCSR, WUCSR_EEE_TX_WAKE_ |
 					    WUCSR_EEE_RX_WAKE_ |
@@ -4445,9 +4590,11 @@ static int lan78xx_resume(struct usb_interface *intf)
 					    WUCSR_MPR_ |
 					    WUCSR_BCST_FR_);
 	if (ret < 0)
-		return ret;
+		goto out;
 
-	ret = lan78xx_start_tx_path(dev);
+	ret = 0;
+out:
+	mutex_unlock(&dev->dev_mutex);
 
 	return ret;
 }
@@ -4457,6 +4604,8 @@ static int lan78xx_reset_resume(struct usb_interface *intf)
 	struct lan78xx_net *dev = usb_get_intfdata(intf);
 	int ret;
 
+	netif_dbg(dev, ifup, dev->net, "(reset) resuming device");
+
 	ret = lan78xx_reset(dev);
 	if (ret < 0)
 		return ret;
-- 
2.43.0


