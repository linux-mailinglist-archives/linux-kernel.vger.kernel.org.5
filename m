Return-Path: <linux-kernel+bounces-102189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E692287AF43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D16D28928E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A682D51;
	Wed, 13 Mar 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+ejeySY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CFF82D35;
	Wed, 13 Mar 2024 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349483; cv=none; b=cPjcGhsdXxhdk5rUmkc/R+dwyueslqRQQhLBpEHPEVb86U569+oCXQdrybI3ga/g+fj3Flt5IbGESIofgmoPbdblRnxIjuOwBk4l8x1u3tajmIAgQZD4Hlr/aF7j8y3ZMcwfh72XfAF4h+Oiw3oOhaLie0rlOCc0YWNCwH2PikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349483; c=relaxed/simple;
	bh=RaPHUakkFn5UQvvFtamKOIMEK/+a0IcQcmB68Nv9olI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWWc886sGhoYeIog1D5uIL+pC+xKWlCQAfwJ9SOT8hMdPIyOKZSbJGCPAZxeos3TdntUM0VJw2m12oYo5lGulU3+5SxV7BkirRgJmzdcaVtVY8uOua1hq1wfz8C4wXJTCS/WPP0dIYWkhxIgF1/e9mYm+AhUd/dO/2POUu8XeYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+ejeySY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7FFC433C7;
	Wed, 13 Mar 2024 17:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349483;
	bh=RaPHUakkFn5UQvvFtamKOIMEK/+a0IcQcmB68Nv9olI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+ejeySY48tqByOZTkcIew3TXlxQ4KIzUfKEk5e+l97Iz0o8hWBkMlO4eEQViE3/P
	 zluFv2jzQxKGgndEagvA7xhcpkp+BDCXA0K4by6uxKJ2KqciKIA8oxatsGdX5QAPUz
	 DoJJOWMypHm/1J2Wr9ZsBmeX0NcASh81KJyM8DRrzmmEO9evveAW3pMtb01IdAOkcq
	 7tGPAKhRuvAUU3qIqyrk2G7Z+o0O5vhzP0bdECuDyhpOXWlmyyR4lvvFIFLBGoMRiv
	 kej4rvD1C5GvNRitXBeF3jaoLsv75C/7Z1pqvbzKpkSJTGDVbsvhlzhm6NH82cmDLC
	 PBxAdNg/4ytyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Efstathiades <john.efstathiades@pebblebay.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 04/41] lan78xx: Fix partial packet errors on suspend/resume
Date: Wed, 13 Mar 2024 13:03:58 -0400
Message-ID: <20240313170435.616724-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: John Efstathiades <john.efstathiades@pebblebay.com>

[ Upstream commit e1210fe63bf8b080edd0805240e90b81b6b069c1 ]

The MAC can get out of step with the internal packet FIFOs if the
system goes to sleep when the link is active, especially at high
data rates. This can result in partial frames in the packet FIFOs
that in result in malformed frames being delivered to the host.
This occurs because the driver does not enable/disable the internal
packet FIFOs in step with the corresponding MAC data path. The
following changes fix this problem.

Update code that enables/disables the MAC receiver and transmitter
to the more general Rx and Tx data path, where the data path in each
direction consists of both the MAC function (Tx or Rx) and the
corresponding packet FIFO.

In the receive path the packet FIFO must be enabled before the MAC
receiver but disabled after the MAC receiver.

In the transmit path the opposite is true: the packet FIFO must be
enabled after the MAC transmitter but disabled before the MAC
transmitter.

The packet FIFOs can be flushed safely once the corresponding data
path is stopped.

Signed-off-by: John Efstathiades <john.efstathiades@pebblebay.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1eecc7ab82c4 ("net: lan78xx: fix runtime PM count underflow on link stop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 303 +++++++++++++++++++++++++-------------
 1 file changed, 197 insertions(+), 106 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a20aff073b865..4f80f672f3184 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -101,6 +101,12 @@
 /* statistic update interval (mSec) */
 #define STAT_UPDATE_TIMER		(1 * 1000)
 
+/* time to wait for MAC or FCT to stop (jiffies) */
+#define HW_DISABLE_TIMEOUT		(HZ / 10)
+
+/* time to wait between polling MAC or FCT state (ms) */
+#define HW_DISABLE_DELAY_MS		1
+
 /* defines interrupts from interrupt EP */
 #define MAX_INT_EP			(32)
 #define INT_EP_INTEP			(31)
@@ -490,6 +496,26 @@ static int lan78xx_write_reg(struct lan78xx_net *dev, u32 index, u32 data)
 	return ret;
 }
 
+static int lan78xx_update_reg(struct lan78xx_net *dev, u32 reg, u32 mask,
+			      u32 data)
+{
+	int ret;
+	u32 buf;
+
+	ret = lan78xx_read_reg(dev, reg, &buf);
+	if (ret < 0)
+		return ret;
+
+	buf &= ~mask;
+	buf |= (mask & data);
+
+	ret = lan78xx_write_reg(dev, reg, buf);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int lan78xx_read_stats(struct lan78xx_net *dev,
 			      struct lan78xx_statstage *data)
 {
@@ -2480,6 +2506,156 @@ static void lan78xx_init_ltm(struct lan78xx_net *dev)
 	lan78xx_write_reg(dev, LTM_INACTIVE1, regs[5]);
 }
 
+static int lan78xx_start_hw(struct lan78xx_net *dev, u32 reg, u32 hw_enable)
+{
+	return lan78xx_update_reg(dev, reg, hw_enable, hw_enable);
+}
+
+static int lan78xx_stop_hw(struct lan78xx_net *dev, u32 reg, u32 hw_enabled,
+			   u32 hw_disabled)
+{
+	unsigned long timeout;
+	bool stopped = true;
+	int ret;
+	u32 buf;
+
+	/* Stop the h/w block (if not already stopped) */
+
+	ret = lan78xx_read_reg(dev, reg, &buf);
+	if (ret < 0)
+		return ret;
+
+	if (buf & hw_enabled) {
+		buf &= ~hw_enabled;
+
+		ret = lan78xx_write_reg(dev, reg, buf);
+		if (ret < 0)
+			return ret;
+
+		stopped = false;
+		timeout = jiffies + HW_DISABLE_TIMEOUT;
+		do  {
+			ret = lan78xx_read_reg(dev, reg, &buf);
+			if (ret < 0)
+				return ret;
+
+			if (buf & hw_disabled)
+				stopped = true;
+			else
+				msleep(HW_DISABLE_DELAY_MS);
+		} while (!stopped && !time_after(jiffies, timeout));
+	}
+
+	ret = stopped ? 0 : -ETIME;
+
+	return ret;
+}
+
+static int lan78xx_flush_fifo(struct lan78xx_net *dev, u32 reg, u32 fifo_flush)
+{
+	return lan78xx_update_reg(dev, reg, fifo_flush, fifo_flush);
+}
+
+static int lan78xx_start_tx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "start tx path");
+
+	/* Start the MAC transmitter */
+
+	ret = lan78xx_start_hw(dev, MAC_TX, MAC_TX_TXEN_);
+	if (ret < 0)
+		return ret;
+
+	/* Start the Tx FIFO */
+
+	ret = lan78xx_start_hw(dev, FCT_TX_CTL, FCT_TX_CTL_EN_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int lan78xx_stop_tx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "stop tx path");
+
+	/* Stop the Tx FIFO */
+
+	ret = lan78xx_stop_hw(dev, FCT_TX_CTL, FCT_TX_CTL_EN_, FCT_TX_CTL_DIS_);
+	if (ret < 0)
+		return ret;
+
+	/* Stop the MAC transmitter */
+
+	ret = lan78xx_stop_hw(dev, MAC_TX, MAC_TX_TXEN_, MAC_TX_TXD_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/* The caller must ensure the Tx path is stopped before calling
+ * lan78xx_flush_tx_fifo().
+ */
+static int lan78xx_flush_tx_fifo(struct lan78xx_net *dev)
+{
+	return lan78xx_flush_fifo(dev, FCT_TX_CTL, FCT_TX_CTL_RST_);
+}
+
+static int lan78xx_start_rx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "start rx path");
+
+	/* Start the Rx FIFO */
+
+	ret = lan78xx_start_hw(dev, FCT_RX_CTL, FCT_RX_CTL_EN_);
+	if (ret < 0)
+		return ret;
+
+	/* Start the MAC receiver*/
+
+	ret = lan78xx_start_hw(dev, MAC_RX, MAC_RX_RXEN_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int lan78xx_stop_rx_path(struct lan78xx_net *dev)
+{
+	int ret;
+
+	netif_dbg(dev, drv, dev->net, "stop rx path");
+
+	/* Stop the MAC receiver */
+
+	ret = lan78xx_stop_hw(dev, MAC_RX, MAC_RX_RXEN_, MAC_RX_RXD_);
+	if (ret < 0)
+		return ret;
+
+	/* Stop the Rx FIFO */
+
+	ret = lan78xx_stop_hw(dev, FCT_RX_CTL, FCT_RX_CTL_EN_, FCT_RX_CTL_DIS_);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/* The caller must ensure the Rx path is stopped before calling
+ * lan78xx_flush_rx_fifo().
+ */
+static int lan78xx_flush_rx_fifo(struct lan78xx_net *dev)
+{
+	return lan78xx_flush_fifo(dev, FCT_RX_CTL, FCT_RX_CTL_RST_);
+}
+
 static int lan78xx_reset(struct lan78xx_net *dev)
 {
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
@@ -2671,23 +2847,7 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = lan78xx_read_reg(dev, MAC_TX, &buf);
-	if (ret < 0)
-		return ret;
-
-	buf |= MAC_TX_TXEN_;
-
-	ret = lan78xx_write_reg(dev, MAC_TX, buf);
-	if (ret < 0)
-		return ret;
-
-	ret = lan78xx_read_reg(dev, FCT_TX_CTL, &buf);
-	if (ret < 0)
-		return ret;
-
-	buf |= FCT_TX_CTL_EN_;
-
-	ret = lan78xx_write_reg(dev, FCT_TX_CTL, buf);
+	ret = lan78xx_start_tx_path(dev);
 	if (ret < 0)
 		return ret;
 
@@ -2696,27 +2856,9 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = lan78xx_read_reg(dev, MAC_RX, &buf);
-	if (ret < 0)
-		return ret;
-
-	buf |= MAC_RX_RXEN_;
-
-	ret = lan78xx_write_reg(dev, MAC_RX, buf);
-	if (ret < 0)
-		return ret;
+	ret = lan78xx_start_rx_path(dev);
 
-	ret = lan78xx_read_reg(dev, FCT_RX_CTL, &buf);
-	if (ret < 0)
-		return ret;
-
-	buf |= FCT_RX_CTL_EN_;
-
-	ret = lan78xx_write_reg(dev, FCT_RX_CTL, buf);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ret;
 }
 
 static void lan78xx_init_stats(struct lan78xx_net *dev)
@@ -3960,23 +4102,10 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 	u16 crc;
 	int ret;
 
-	ret = lan78xx_read_reg(dev, MAC_TX, &buf);
+	ret = lan78xx_stop_tx_path(dev);
 	if (ret < 0)
 		return ret;
-
-	buf &= ~MAC_TX_TXEN_;
-
-	ret = lan78xx_write_reg(dev, MAC_TX, buf);
-	if (ret < 0)
-		return ret;
-
-	ret = lan78xx_read_reg(dev, MAC_RX, &buf);
-	if (ret < 0)
-		return ret;
-
-	buf &= ~MAC_RX_RXEN_;
-
-	ret = lan78xx_write_reg(dev, MAC_RX, buf);
+	ret = lan78xx_stop_rx_path(dev);
 	if (ret < 0)
 		return ret;
 
@@ -4153,17 +4282,9 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 	if (ret < 0)
 		return ret;
 
-	lan78xx_read_reg(dev, MAC_RX, &buf);
-	if (ret < 0)
-		return ret;
+	ret = lan78xx_start_rx_path(dev);
 
-	buf |= MAC_RX_RXEN_;
-
-	lan78xx_write_reg(dev, MAC_RX, buf);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ret;
 }
 
 static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
@@ -4189,24 +4310,17 @@ static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 			spin_unlock_irq(&dev->txq.lock);
 		}
 
-		/* stop TX & RX */
-		ret = lan78xx_read_reg(dev, MAC_TX, &buf);
+		/* stop RX */
+		ret = lan78xx_stop_rx_path(dev);
 		if (ret < 0)
 			return ret;
 
-		buf &= ~MAC_TX_TXEN_;
-
-		ret = lan78xx_write_reg(dev, MAC_TX, buf);
+		ret = lan78xx_flush_rx_fifo(dev);
 		if (ret < 0)
 			return ret;
 
-		ret = lan78xx_read_reg(dev, MAC_RX, &buf);
-		if (ret < 0)
-			return ret;
-
-		buf &= ~MAC_RX_RXEN_;
-
-		ret = lan78xx_write_reg(dev, MAC_RX, buf);
+		/* stop Tx */
+		ret = lan78xx_stop_tx_path(dev);
 		if (ret < 0)
 			return ret;
 
@@ -4224,23 +4338,11 @@ static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 
 		if (PMSG_IS_AUTO(message)) {
 			/* auto suspend (selective suspend) */
-			ret = lan78xx_read_reg(dev, MAC_TX, &buf);
-			if (ret < 0)
-				return ret;
-
-			buf &= ~MAC_TX_TXEN_;
-
-			ret = lan78xx_write_reg(dev, MAC_TX, buf);
-			if (ret < 0)
-				return ret;
-
-			ret = lan78xx_read_reg(dev, MAC_RX, &buf);
+			ret = lan78xx_stop_tx_path(dev);
 			if (ret < 0)
 				return ret;
 
-			buf &= ~MAC_RX_RXEN_;
-
-			ret = lan78xx_write_reg(dev, MAC_RX, buf);
+			ret = lan78xx_stop_rx_path(dev);
 			if (ret < 0)
 				return ret;
 
@@ -4292,13 +4394,7 @@ static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 			if (ret < 0)
 				return ret;
 
-			ret = lan78xx_read_reg(dev, MAC_RX, &buf);
-			if (ret < 0)
-				return ret;
-
-			buf |= MAC_RX_RXEN_;
-
-			ret = lan78xx_write_reg(dev, MAC_RX, buf);
+			ret = lan78xx_start_rx_path(dev);
 			if (ret < 0)
 				return ret;
 		} else {
@@ -4323,7 +4419,6 @@ static int lan78xx_resume(struct usb_interface *intf)
 	struct sk_buff *skb;
 	struct urb *res;
 	int ret;
-	u32 buf;
 
 	if (!timer_pending(&dev->stat_monitor)) {
 		dev->delta = 1;
@@ -4331,6 +4426,10 @@ static int lan78xx_resume(struct usb_interface *intf)
 			  jiffies + STAT_UPDATE_TIMER);
 	}
 
+	ret = lan78xx_flush_tx_fifo(dev);
+	if (ret < 0)
+		return ret;
+
 	if (!--dev->suspend_count) {
 		/* resume interrupt URBs */
 		if (dev->urb_intr && test_bit(EVENT_DEV_OPEN, &dev->flags)) {
@@ -4390,17 +4489,9 @@ static int lan78xx_resume(struct usb_interface *intf)
 	if (ret < 0)
 		return ret;
 
-	ret = lan78xx_read_reg(dev, MAC_TX, &buf);
-	if (ret < 0)
-		return ret;
-
-	buf |= MAC_TX_TXEN_;
+	ret = lan78xx_start_tx_path(dev);
 
-	ret = lan78xx_write_reg(dev, MAC_TX, buf);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ret;
 }
 
 static int lan78xx_reset_resume(struct usb_interface *intf)
-- 
2.43.0


