Return-Path: <linux-kernel+bounces-102188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB8A87AF42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80611C2521F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE19C82D44;
	Wed, 13 Mar 2024 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E48LnsLJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC719A56A;
	Wed, 13 Mar 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349482; cv=none; b=TN+tTK9cVMuFsODa/p5708t+HPcl6JDDIDAM3BGtMX/vp1ZwiPBE912pvcldIkWeuXyenU+ewl+E9Zh1bQc4+Su1lN46PFFYnf2KqPiNMcpUQggn67Xr15vDQloAxcgwwOllA9irZs69HCS+5x70T/TMwYvNDktVcC6wcTm5F+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349482; c=relaxed/simple;
	bh=/5u+ePgq/DVOfpzFMkOqcePp5l6zS8rWnljN6RcAmkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJMq46dv5VUXnKnkk/NREHFJVDn0sco7gDeI7A0YgjTCLmfgY9uXHX+TBBpRf4IrQPgi/jBKTaeD7Q0Ia2TiivJIa21JzofvGen9ool9g58/taxCWDKgdv2pvHIHB0sOXOB76bMAZ1TjbMt+1dRL6qbd5isOOjGnJP1FHTD3Ykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E48LnsLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228E9C433A6;
	Wed, 13 Mar 2024 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349482;
	bh=/5u+ePgq/DVOfpzFMkOqcePp5l6zS8rWnljN6RcAmkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E48LnsLJ6iBNeKzAx2r5V1EgwIGQUdTuNaalV8qiX1e6FOdI/RvJaMKIWx/JAFbeG
	 jTUsk9TJ9GB2DNIDf5g7PckbN4RNV8k9VSkIhEUap0K2k9/429fNb1ZqqGUMUb93Jy
	 8oLsP3DMBXt3yjR4nYI+XzdU6Y5sBxzsQjqf0X0eU7WfpnI1Rv/ZtZgXI1hZUWRHXn
	 r+c7tetEZCgu02zZxZsG9MOXMq17ke0nNjLyNS/AN+YhAsdZCbKqlkZ691iYAdoHpR
	 i1muICd2cUg3nMeXQuKbDpdSYcKl5ZWfACphZFD4Am0TPOQmLaHKov5zTkedTv6C2u
	 HjBKsGIdV5QZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Efstathiades <john.efstathiades@pebblebay.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 03/41] lan78xx: Add missing return code checks
Date: Wed, 13 Mar 2024 13:03:57 -0400
Message-ID: <20240313170435.616724-4-sashal@kernel.org>
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

[ Upstream commit 3415f6baaddb9b39d7112247ab39ef3c700f882e ]

There are many places in the driver where the return code from a
function call is captured but without a subsequent test of the
return code and appropriate action taken.

This patch adds the missing return code tests and action. In most
cases the action is an early exit from the calling function.

The function lan78xx_set_suspend() was also updated to make it
consistent with lan78xx_suspend().

Signed-off-by: John Efstathiades <john.efstathiades@pebblebay.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1eecc7ab82c4 ("net: lan78xx: fix runtime PM count underflow on link stop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 399 +++++++++++++++++++++++++++++++-------
 1 file changed, 333 insertions(+), 66 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 2f4f85e03df2c..a20aff073b865 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1176,7 +1176,7 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 	/* clear LAN78xx interrupt status */
 	ret = lan78xx_write_reg(dev, INT_STS, INT_STS_PHY_INT_);
 	if (unlikely(ret < 0))
-		return -EIO;
+		return ret;
 
 	mutex_lock(&phydev->lock);
 	phy_read_status(phydev);
@@ -1189,11 +1189,11 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 		/* reset MAC */
 		ret = lan78xx_read_reg(dev, MAC_CR, &buf);
 		if (unlikely(ret < 0))
-			return -EIO;
+			return ret;
 		buf |= MAC_CR_RST_;
 		ret = lan78xx_write_reg(dev, MAC_CR, buf);
 		if (unlikely(ret < 0))
-			return -EIO;
+			return ret;
 
 		del_timer(&dev->stat_monitor);
 	} else if (link && !dev->link_on) {
@@ -1205,18 +1205,30 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 			if (ecmd.base.speed == 1000) {
 				/* disable U2 */
 				ret = lan78xx_read_reg(dev, USB_CFG1, &buf);
+				if (ret < 0)
+					return ret;
 				buf &= ~USB_CFG1_DEV_U2_INIT_EN_;
 				ret = lan78xx_write_reg(dev, USB_CFG1, buf);
+				if (ret < 0)
+					return ret;
 				/* enable U1 */
 				ret = lan78xx_read_reg(dev, USB_CFG1, &buf);
+				if (ret < 0)
+					return ret;
 				buf |= USB_CFG1_DEV_U1_INIT_EN_;
 				ret = lan78xx_write_reg(dev, USB_CFG1, buf);
+				if (ret < 0)
+					return ret;
 			} else {
 				/* enable U1 & U2 */
 				ret = lan78xx_read_reg(dev, USB_CFG1, &buf);
+				if (ret < 0)
+					return ret;
 				buf |= USB_CFG1_DEV_U2_INIT_EN_;
 				buf |= USB_CFG1_DEV_U1_INIT_EN_;
 				ret = lan78xx_write_reg(dev, USB_CFG1, buf);
+				if (ret < 0)
+					return ret;
 			}
 		}
 
@@ -1234,6 +1246,8 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 
 		ret = lan78xx_update_flowcontrol(dev, ecmd.base.duplex, ladv,
 						 radv);
+		if (ret < 0)
+			return ret;
 
 		if (!timer_pending(&dev->stat_monitor)) {
 			dev->delta = 1;
@@ -1244,7 +1258,7 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 		tasklet_schedule(&dev->bh);
 	}
 
-	return ret;
+	return 0;
 }
 
 /* some work can't be done in tasklets, so we use keventd
@@ -2469,23 +2483,33 @@ static void lan78xx_init_ltm(struct lan78xx_net *dev)
 static int lan78xx_reset(struct lan78xx_net *dev)
 {
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
-	u32 buf;
-	int ret = 0;
 	unsigned long timeout;
+	int ret;
+	u32 buf;
 	u8 sig;
 
 	ret = lan78xx_read_reg(dev, HW_CFG, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= HW_CFG_LRST_;
+
 	ret = lan78xx_write_reg(dev, HW_CFG, buf);
+	if (ret < 0)
+		return ret;
 
 	timeout = jiffies + HZ;
 	do {
 		mdelay(1);
 		ret = lan78xx_read_reg(dev, HW_CFG, &buf);
+		if (ret < 0)
+			return ret;
+
 		if (time_after(jiffies, timeout)) {
 			netdev_warn(dev->net,
 				    "timeout on completion of LiteReset");
-			return -EIO;
+			ret = -ETIMEDOUT;
+			return ret;
 		}
 	} while (buf & HW_CFG_LRST_);
 
@@ -2493,13 +2517,22 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 
 	/* save DEVID for later usage */
 	ret = lan78xx_read_reg(dev, ID_REV, &buf);
+	if (ret < 0)
+		return ret;
+
 	dev->chipid = (buf & ID_REV_CHIP_ID_MASK_) >> 16;
 	dev->chiprev = buf & ID_REV_CHIP_REV_MASK_;
 
 	/* Respond to the IN token with a NAK */
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= USB_CFG_BIR_;
+
 	ret = lan78xx_write_reg(dev, USB_CFG0, buf);
+	if (ret < 0)
+		return ret;
 
 	/* Init LTM */
 	lan78xx_init_ltm(dev);
@@ -2522,53 +2555,105 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	}
 
 	ret = lan78xx_write_reg(dev, BURST_CAP, buf);
+	if (ret < 0)
+		return ret;
+
 	ret = lan78xx_write_reg(dev, BULK_IN_DLY, DEFAULT_BULK_IN_DELAY);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_read_reg(dev, HW_CFG, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= HW_CFG_MEF_;
+
 	ret = lan78xx_write_reg(dev, HW_CFG, buf);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= USB_CFG_BCE_;
+
 	ret = lan78xx_write_reg(dev, USB_CFG0, buf);
+	if (ret < 0)
+		return ret;
 
 	/* set FIFO sizes */
 	buf = (MAX_RX_FIFO_SIZE - 512) / 512;
+
 	ret = lan78xx_write_reg(dev, FCT_RX_FIFO_END, buf);
+	if (ret < 0)
+		return ret;
 
 	buf = (MAX_TX_FIFO_SIZE - 512) / 512;
+
 	ret = lan78xx_write_reg(dev, FCT_TX_FIFO_END, buf);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_write_reg(dev, INT_STS, INT_STS_CLEAR_ALL_);
+	if (ret < 0)
+		return ret;
+
 	ret = lan78xx_write_reg(dev, FLOW, 0);
+	if (ret < 0)
+		return ret;
+
 	ret = lan78xx_write_reg(dev, FCT_FLOW, 0);
+	if (ret < 0)
+		return ret;
 
 	/* Don't need rfe_ctl_lock during initialisation */
 	ret = lan78xx_read_reg(dev, RFE_CTL, &pdata->rfe_ctl);
+	if (ret < 0)
+		return ret;
+
 	pdata->rfe_ctl |= RFE_CTL_BCAST_EN_ | RFE_CTL_DA_PERFECT_;
+
 	ret = lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
+	if (ret < 0)
+		return ret;
 
 	/* Enable or disable checksum offload engines */
-	lan78xx_set_features(dev->net, dev->net->features);
+	ret = lan78xx_set_features(dev->net, dev->net->features);
+	if (ret < 0)
+		return ret;
 
 	lan78xx_set_multicast(dev->net);
 
 	/* reset PHY */
 	ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= PMT_CTL_PHY_RST_;
+
 	ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+	if (ret < 0)
+		return ret;
 
 	timeout = jiffies + HZ;
 	do {
 		mdelay(1);
 		ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+		if (ret < 0)
+			return ret;
+
 		if (time_after(jiffies, timeout)) {
 			netdev_warn(dev->net, "timeout waiting for PHY Reset");
-			return -EIO;
+			ret = -ETIMEDOUT;
+			return ret;
 		}
 	} while ((buf & PMT_CTL_PHY_RST_) || !(buf & PMT_CTL_READY_));
 
 	ret = lan78xx_read_reg(dev, MAC_CR, &buf);
+	if (ret < 0)
+		return ret;
+
 	/* LAN7801 only has RGMII mode */
 	if (dev->chipid == ID_REV_CHIP_ID_7801_)
 		buf &= ~MAC_CR_GMII_EN_;
@@ -2583,25 +2668,53 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		}
 	}
 	ret = lan78xx_write_reg(dev, MAC_CR, buf);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_read_reg(dev, MAC_TX, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= MAC_TX_TXEN_;
+
 	ret = lan78xx_write_reg(dev, MAC_TX, buf);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_read_reg(dev, FCT_TX_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= FCT_TX_CTL_EN_;
+
 	ret = lan78xx_write_reg(dev, FCT_TX_CTL, buf);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_set_rx_max_frame_length(dev,
 					      dev->net->mtu + VLAN_ETH_HLEN);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_read_reg(dev, MAC_RX, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= MAC_RX_RXEN_;
+
 	ret = lan78xx_write_reg(dev, MAC_RX, buf);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_read_reg(dev, FCT_RX_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= FCT_RX_CTL_EN_;
+
 	ret = lan78xx_write_reg(dev, FCT_RX_CTL, buf);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -2639,7 +2752,7 @@ static int lan78xx_open(struct net_device *net)
 
 	ret = usb_autopm_get_interface(dev->intf);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	phy_start(net->phydev);
 
@@ -2667,7 +2780,6 @@ static int lan78xx_open(struct net_device *net)
 done:
 	usb_autopm_put_interface(dev->intf);
 
-out:
 	return ret;
 }
 
@@ -3838,35 +3950,62 @@ static u16 lan78xx_wakeframe_crc16(const u8 *buf, int len)
 
 static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 {
-	u32 buf;
-	int mask_index;
-	u16 crc;
-	u32 temp_wucsr;
-	u32 temp_pmt_ctl;
 	const u8 ipv4_multicast[3] = { 0x01, 0x00, 0x5E };
 	const u8 ipv6_multicast[3] = { 0x33, 0x33 };
 	const u8 arp_type[2] = { 0x08, 0x06 };
+	u32 temp_pmt_ctl;
+	int mask_index;
+	u32 temp_wucsr;
+	u32 buf;
+	u16 crc;
+	int ret;
+
+	ret = lan78xx_read_reg(dev, MAC_TX, &buf);
+	if (ret < 0)
+		return ret;
 
-	lan78xx_read_reg(dev, MAC_TX, &buf);
 	buf &= ~MAC_TX_TXEN_;
-	lan78xx_write_reg(dev, MAC_TX, buf);
-	lan78xx_read_reg(dev, MAC_RX, &buf);
+
+	ret = lan78xx_write_reg(dev, MAC_TX, buf);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_read_reg(dev, MAC_RX, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf &= ~MAC_RX_RXEN_;
-	lan78xx_write_reg(dev, MAC_RX, buf);
 
-	lan78xx_write_reg(dev, WUCSR, 0);
-	lan78xx_write_reg(dev, WUCSR2, 0);
-	lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
+	ret = lan78xx_write_reg(dev, MAC_RX, buf);
+	if (ret < 0)
+		return ret;
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
 
 	temp_wucsr = 0;
 
 	temp_pmt_ctl = 0;
-	lan78xx_read_reg(dev, PMT_CTL, &temp_pmt_ctl);
+
+	ret = lan78xx_read_reg(dev, PMT_CTL, &temp_pmt_ctl);
+	if (ret < 0)
+		return ret;
+
 	temp_pmt_ctl &= ~PMT_CTL_RES_CLR_WKP_EN_;
 	temp_pmt_ctl |= PMT_CTL_RES_CLR_WKP_STS_;
 
-	for (mask_index = 0; mask_index < NUM_OF_WUF_CFG; mask_index++)
-		lan78xx_write_reg(dev, WUF_CFG(mask_index), 0);
+	for (mask_index = 0; mask_index < NUM_OF_WUF_CFG; mask_index++) {
+		ret = lan78xx_write_reg(dev, WUF_CFG(mask_index), 0);
+		if (ret < 0)
+			return ret;
+	}
 
 	mask_index = 0;
 	if (wol & WAKE_PHY) {
@@ -3895,30 +4034,52 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 
 		/* set WUF_CFG & WUF_MASK for IPv4 Multicast */
 		crc = lan78xx_wakeframe_crc16(ipv4_multicast, 3);
-		lan78xx_write_reg(dev, WUF_CFG(mask_index),
-				  WUF_CFGX_EN_ |
-				  WUF_CFGX_TYPE_MCAST_ |
-				  (0 << WUF_CFGX_OFFSET_SHIFT_) |
-				  (crc & WUF_CFGX_CRC16_MASK_));
-
-		lan78xx_write_reg(dev, WUF_MASK0(mask_index), 7);
-		lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
-		lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
-		lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
+		ret = lan78xx_write_reg(dev, WUF_CFG(mask_index),
+					WUF_CFGX_EN_ |
+					WUF_CFGX_TYPE_MCAST_ |
+					(0 << WUF_CFGX_OFFSET_SHIFT_) |
+					(crc & WUF_CFGX_CRC16_MASK_));
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, WUF_MASK0(mask_index), 7);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
+		if (ret < 0)
+			return ret;
+
 		mask_index++;
 
 		/* for IPv6 Multicast */
 		crc = lan78xx_wakeframe_crc16(ipv6_multicast, 2);
-		lan78xx_write_reg(dev, WUF_CFG(mask_index),
-				  WUF_CFGX_EN_ |
-				  WUF_CFGX_TYPE_MCAST_ |
-				  (0 << WUF_CFGX_OFFSET_SHIFT_) |
-				  (crc & WUF_CFGX_CRC16_MASK_));
-
-		lan78xx_write_reg(dev, WUF_MASK0(mask_index), 3);
-		lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
-		lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
-		lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
+		ret = lan78xx_write_reg(dev, WUF_CFG(mask_index),
+					WUF_CFGX_EN_ |
+					WUF_CFGX_TYPE_MCAST_ |
+					(0 << WUF_CFGX_OFFSET_SHIFT_) |
+					(crc & WUF_CFGX_CRC16_MASK_));
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, WUF_MASK0(mask_index), 3);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
+		if (ret < 0)
+			return ret;
+
 		mask_index++;
 
 		temp_pmt_ctl |= PMT_CTL_WOL_EN_;
@@ -3939,16 +4100,27 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 		 * for packettype (offset 12,13) = ARP (0x0806)
 		 */
 		crc = lan78xx_wakeframe_crc16(arp_type, 2);
-		lan78xx_write_reg(dev, WUF_CFG(mask_index),
-				  WUF_CFGX_EN_ |
-				  WUF_CFGX_TYPE_ALL_ |
-				  (0 << WUF_CFGX_OFFSET_SHIFT_) |
-				  (crc & WUF_CFGX_CRC16_MASK_));
-
-		lan78xx_write_reg(dev, WUF_MASK0(mask_index), 0x3000);
-		lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
-		lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
-		lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
+		ret = lan78xx_write_reg(dev, WUF_CFG(mask_index),
+					WUF_CFGX_EN_ |
+					WUF_CFGX_TYPE_ALL_ |
+					(0 << WUF_CFGX_OFFSET_SHIFT_) |
+					(crc & WUF_CFGX_CRC16_MASK_));
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, WUF_MASK0(mask_index), 0x3000);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK1(mask_index), 0);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK2(mask_index), 0);
+		if (ret < 0)
+			return ret;
+		ret = lan78xx_write_reg(dev, WUF_MASK3(mask_index), 0);
+		if (ret < 0)
+			return ret;
+
 		mask_index++;
 
 		temp_pmt_ctl |= PMT_CTL_WOL_EN_;
@@ -3956,7 +4128,9 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 		temp_pmt_ctl |= PMT_CTL_SUS_MODE_0_;
 	}
 
-	lan78xx_write_reg(dev, WUCSR, temp_wucsr);
+	ret = lan78xx_write_reg(dev, WUCSR, temp_wucsr);
+	if (ret < 0)
+		return ret;
 
 	/* when multiple WOL bits are set */
 	if (hweight_long((unsigned long)wol) > 1) {
@@ -3964,16 +4138,30 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 		temp_pmt_ctl &= ~PMT_CTL_SUS_MODE_MASK_;
 		temp_pmt_ctl |= PMT_CTL_SUS_MODE_0_;
 	}
-	lan78xx_write_reg(dev, PMT_CTL, temp_pmt_ctl);
+	ret = lan78xx_write_reg(dev, PMT_CTL, temp_pmt_ctl);
+	if (ret < 0)
+		return ret;
 
 	/* clear WUPS */
-	lan78xx_read_reg(dev, PMT_CTL, &buf);
+	ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= PMT_CTL_WUPS_MASK_;
-	lan78xx_write_reg(dev, PMT_CTL, buf);
+
+	ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+	if (ret < 0)
+		return ret;
 
 	lan78xx_read_reg(dev, MAC_RX, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= MAC_RX_RXEN_;
+
 	lan78xx_write_reg(dev, MAC_RX, buf);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -3981,7 +4169,6 @@ static int lan78xx_set_suspend(struct lan78xx_net *dev, u32 wol)
 static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct lan78xx_net *dev = usb_get_intfdata(intf);
-	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
 	u32 buf;
 	int ret;
 	int event;
@@ -4004,11 +4191,24 @@ static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 
 		/* stop TX & RX */
 		ret = lan78xx_read_reg(dev, MAC_TX, &buf);
+		if (ret < 0)
+			return ret;
+
 		buf &= ~MAC_TX_TXEN_;
+
 		ret = lan78xx_write_reg(dev, MAC_TX, buf);
+		if (ret < 0)
+			return ret;
+
 		ret = lan78xx_read_reg(dev, MAC_RX, &buf);
+		if (ret < 0)
+			return ret;
+
 		buf &= ~MAC_RX_RXEN_;
+
 		ret = lan78xx_write_reg(dev, MAC_RX, buf);
+		if (ret < 0)
+			return ret;
 
 		/* empty out the rx and queues */
 		netif_device_detach(dev->net);
@@ -4025,25 +4225,50 @@ static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 		if (PMSG_IS_AUTO(message)) {
 			/* auto suspend (selective suspend) */
 			ret = lan78xx_read_reg(dev, MAC_TX, &buf);
+			if (ret < 0)
+				return ret;
+
 			buf &= ~MAC_TX_TXEN_;
+
 			ret = lan78xx_write_reg(dev, MAC_TX, buf);
+			if (ret < 0)
+				return ret;
+
 			ret = lan78xx_read_reg(dev, MAC_RX, &buf);
+			if (ret < 0)
+				return ret;
+
 			buf &= ~MAC_RX_RXEN_;
+
 			ret = lan78xx_write_reg(dev, MAC_RX, buf);
+			if (ret < 0)
+				return ret;
 
 			ret = lan78xx_write_reg(dev, WUCSR, 0);
+			if (ret < 0)
+				return ret;
 			ret = lan78xx_write_reg(dev, WUCSR2, 0);
+			if (ret < 0)
+				return ret;
 			ret = lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
+			if (ret < 0)
+				return ret;
 
 			/* set goodframe wakeup */
 			ret = lan78xx_read_reg(dev, WUCSR, &buf);
+			if (ret < 0)
+				return ret;
 
 			buf |= WUCSR_RFE_WAKE_EN_;
 			buf |= WUCSR_STORE_WAKE_;
 
 			ret = lan78xx_write_reg(dev, WUCSR, buf);
+			if (ret < 0)
+				return ret;
 
 			ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+			if (ret < 0)
+				return ret;
 
 			buf &= ~PMT_CTL_RES_CLR_WKP_EN_;
 			buf |= PMT_CTL_RES_CLR_WKP_STS_;
@@ -4054,18 +4279,36 @@ static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 			buf |= PMT_CTL_SUS_MODE_3_;
 
 			ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+			if (ret < 0)
+				return ret;
 
 			ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
+			if (ret < 0)
+				return ret;
 
 			buf |= PMT_CTL_WUPS_MASK_;
 
 			ret = lan78xx_write_reg(dev, PMT_CTL, buf);
+			if (ret < 0)
+				return ret;
 
 			ret = lan78xx_read_reg(dev, MAC_RX, &buf);
+			if (ret < 0)
+				return ret;
+
 			buf |= MAC_RX_RXEN_;
+
 			ret = lan78xx_write_reg(dev, MAC_RX, buf);
+			if (ret < 0)
+				return ret;
 		} else {
-			lan78xx_set_suspend(dev, pdata->wol);
+			struct lan78xx_priv *pdata;
+
+			pdata = (struct lan78xx_priv *)(dev->data[0]);
+
+			ret = lan78xx_set_suspend(dev, pdata->wol);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
@@ -4090,8 +4333,11 @@ static int lan78xx_resume(struct usb_interface *intf)
 
 	if (!--dev->suspend_count) {
 		/* resume interrupt URBs */
-		if (dev->urb_intr && test_bit(EVENT_DEV_OPEN, &dev->flags))
-			usb_submit_urb(dev->urb_intr, GFP_NOIO);
+		if (dev->urb_intr && test_bit(EVENT_DEV_OPEN, &dev->flags)) {
+			ret = usb_submit_urb(dev->urb_intr, GFP_NOIO);
+			if (ret < 0)
+				return ret;
+		}
 
 		spin_lock_irq(&dev->txq.lock);
 		while ((res = usb_get_from_anchor(&dev->deferred))) {
@@ -4118,13 +4364,21 @@ static int lan78xx_resume(struct usb_interface *intf)
 	}
 
 	ret = lan78xx_write_reg(dev, WUCSR2, 0);
+	if (ret < 0)
+		return ret;
 	ret = lan78xx_write_reg(dev, WUCSR, 0);
+	if (ret < 0)
+		return ret;
 	ret = lan78xx_write_reg(dev, WK_SRC, 0xFFF1FF1FUL);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_write_reg(dev, WUCSR2, WUCSR2_NS_RCD_ |
 					     WUCSR2_ARP_RCD_ |
 					     WUCSR2_IPV6_TCPSYN_RCD_ |
 					     WUCSR2_IPV4_TCPSYN_RCD_);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_write_reg(dev, WUCSR, WUCSR_EEE_TX_WAKE_ |
 					    WUCSR_EEE_RX_WAKE_ |
@@ -4133,10 +4387,18 @@ static int lan78xx_resume(struct usb_interface *intf)
 					    WUCSR_WUFR_ |
 					    WUCSR_MPR_ |
 					    WUCSR_BCST_FR_);
+	if (ret < 0)
+		return ret;
 
 	ret = lan78xx_read_reg(dev, MAC_TX, &buf);
+	if (ret < 0)
+		return ret;
+
 	buf |= MAC_TX_TXEN_;
+
 	ret = lan78xx_write_reg(dev, MAC_TX, buf);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -4144,12 +4406,17 @@ static int lan78xx_resume(struct usb_interface *intf)
 static int lan78xx_reset_resume(struct usb_interface *intf)
 {
 	struct lan78xx_net *dev = usb_get_intfdata(intf);
+	int ret;
 
-	lan78xx_reset(dev);
+	ret = lan78xx_reset(dev);
+	if (ret < 0)
+		return ret;
 
 	phy_start(dev->net->phydev);
 
-	return lan78xx_resume(intf);
+	ret = lan78xx_resume(intf);
+
+	return ret;
 }
 
 static const struct usb_device_id products[] = {
-- 
2.43.0


