Return-Path: <linux-kernel+bounces-102123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A14087AE9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D7FB23248
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ED06BFB7;
	Wed, 13 Mar 2024 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X55nqinv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073F6BB52;
	Wed, 13 Mar 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349339; cv=none; b=e3+DgBjPAyKTdq1Un7Hg/6SKPa5G0d/XVLex+69XGQnOYVbejwgE22Nm5dCT6IQIOkKKvUPWiMH61PZCeXPrMj1RrdbKpmyuJbI0t9UmHuEbsEHlAFHAafIpjWZq3QigTPxwrPF2HYWvEE6JtkNYU6Fknu7UsovzKN26MNPIwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349339; c=relaxed/simple;
	bh=YTvhuBwqajfZFXpY91A7qN1gJAbC5oSrVBEJU7cWqj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7zNOr8MN7ViXs/B2+Bj+gTAhoxuEaXCo+HwkYeo4sxy7jWHs9hZ+QJqaHhGMURUD+dMjzh5JR+D+A2MqY9/BZ1B2TMmPI9rWhVtPsFx2C9GY3dykrutaw1AOm0FqF+X3CEBiSbv9tpLKVDZ0IvyyXeCZNM7beuTNIjdVCZd8tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X55nqinv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BDAC43394;
	Wed, 13 Mar 2024 17:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349338;
	bh=YTvhuBwqajfZFXpY91A7qN1gJAbC5oSrVBEJU7cWqj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X55nqinvDY8AUQreN61n1UhkvXvog6fvgwUYrSj77Xolt+CgnAG7HANBmW8mwpqEZ
	 p+nWFa2DD9+jwNkke5bRQW+d4YgpLoDAo+m55nuTM9PzlOWutuLtkBHPAgIjNmBCTA
	 FNsvx0P5gvxxxjDEofI/pJcMu31CS3kaxqaPtWdnDpN8ewrmFjXzlAFJwKfkWbVjKf
	 aUCO0PKVL9Ahd5W3ZY4YZMPGKiJRhvru6ZZFHcMRl8gUGTi2xCl/d7o5cfRXjwinO5
	 BVHQkDCEPQiI5w94vb5XZDeATrdCbEQFKXEVZn7oQdNCkAv+vf+Iawlu7fvPNgYVsS
	 5UOC6pRW3zKdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Efstathiades <john.efstathiades@pebblebay.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 03/51] lan78xx: Fix partial packet errors on suspend/resume
Date: Wed, 13 Mar 2024 13:01:24 -0400
Message-ID: <20240313170212.616443-4-sashal@kernel.org>
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
index 372fca3bfc9a2..020ea7b960936 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -90,6 +90,12 @@
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
@@ -479,6 +485,26 @@ static int lan78xx_write_reg(struct lan78xx_net *dev, u32 index, u32 data)
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
@@ -2445,6 +2471,156 @@ static void lan78xx_init_ltm(struct lan78xx_net *dev)
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
@@ -2636,23 +2812,7 @@ static int lan78xx_reset(struct lan78xx_net *dev)
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
 
@@ -2661,27 +2821,9 @@ static int lan78xx_reset(struct lan78xx_net *dev)
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
@@ -3918,23 +4060,10 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
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
 
@@ -4111,17 +4240,9 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
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
@@ -4147,24 +4268,17 @@ static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
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
 
@@ -4182,23 +4296,11 @@ static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 
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
 
@@ -4250,13 +4352,7 @@ static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
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
@@ -4281,7 +4377,6 @@ static int lan78xx_resume(struct usb_interface *intf)
 	struct sk_buff *skb;
 	struct urb *res;
 	int ret;
-	u32 buf;
 
 	if (!timer_pending(&dev->stat_monitor)) {
 		dev->delta = 1;
@@ -4289,6 +4384,10 @@ static int lan78xx_resume(struct usb_interface *intf)
 			  jiffies + STAT_UPDATE_TIMER);
 	}
 
+	ret = lan78xx_flush_tx_fifo(dev);
+	if (ret < 0)
+		return ret;
+
 	if (!--dev->suspend_count) {
 		/* resume interrupt URBs */
 		if (dev->urb_intr && test_bit(EVENT_DEV_OPEN, &dev->flags)) {
@@ -4348,17 +4447,9 @@ static int lan78xx_resume(struct usb_interface *intf)
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


