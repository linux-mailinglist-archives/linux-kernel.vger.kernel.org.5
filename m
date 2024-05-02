Return-Path: <linux-kernel+bounces-166203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3BC8B9785
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96B628791F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBB058ACC;
	Thu,  2 May 2024 09:20:37 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0643A58228;
	Thu,  2 May 2024 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641636; cv=none; b=ErUt6m83RXvVuX+tkNCocFAi2n1//QIK3+kxihJbxXl+LJ7LEaGqx7j7L96pBzpaAMmMKCs/CMiqhz4KG4hVPqY7Cr4hi/t3VXYVDplrWh/7o7iPkG27qn05o9MN1Dsi9kMips0iKyuvAboDkUgsLf2t7ILALrQk8GpzFKe61TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641636; c=relaxed/simple;
	bh=ux8A61W4NYUYqc75gqtSy+WlkhW6+TPKbbLpywy10zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIRuNDHnjwsGSrRXNc6Pmny/XIirxkczHt1UO5NyeELOby4u3e/ffOSRTFOewmpUe/0qvLiRf6lL6M90kN31220GPuhpZV5D1m2TaCJRizHkDleeArm27LZ0eP8HvQkjmjTKB+9fItnHmGMazzINVgX4x+bFLvpaCKDBNFs8xBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4429KCMj82331157, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4429KCMj82331157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 17:20:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 17:20:12 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 17:20:11 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v17 04/13] rtase: Implement the interrupt routine and rtase_poll
Date: Thu, 2 May 2024 17:18:38 +0800
Message-ID: <20240502091847.65181-5-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502091847.65181-1-justinlai0215@realtek.com>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

1. Implement rtase_interrupt to handle txQ0/rxQ0, txQ4~txQ7 interrupts,
and implement rtase_q_interrupt to handle txQ1/rxQ1, txQ2/rxQ2 and
txQ3/rxQ3 interrupts.
2. Implement rtase_poll to call ring_handler to process the tx or
rx packet of each ring. If the returned value is budget,it means that
there is still work of a certain ring that has not yet been completed.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 709c0bb6d2e7..ab00811e1415 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -584,6 +584,76 @@ static void rtase_hw_start(const struct net_device *dev)
 	rtase_enable_hw_interrupt(tp);
 }
 
+/*  the interrupt handler does RXQ0 and TXQ0, TXQ4~7 interrutp status
+ */
+static irqreturn_t rtase_interrupt(int irq, void *dev_instance)
+{
+	const struct rtase_private *tp;
+	struct rtase_int_vector *ivec;
+	u32 status;
+
+	ivec = dev_instance;
+	tp = ivec->tp;
+	status = rtase_r32(tp, ivec->isr_addr);
+
+	rtase_w32(tp, ivec->imr_addr, 0x0);
+	rtase_w32(tp, ivec->isr_addr, status & ~RTASE_FOVW);
+
+	if (napi_schedule_prep(&ivec->napi))
+		__napi_schedule(&ivec->napi);
+
+	return IRQ_HANDLED;
+}
+
+/*  the interrupt handler does RXQ1&TXQ1 or RXQ2&TXQ2 or RXQ3&TXQ3 interrupt
+ *  status according to interrupt vector
+ */
+static irqreturn_t rtase_q_interrupt(int irq, void *dev_instance)
+{
+	const struct rtase_private *tp;
+	struct rtase_int_vector *ivec;
+	u16 status;
+
+	ivec = dev_instance;
+	tp = ivec->tp;
+	status = rtase_r16(tp, ivec->isr_addr);
+
+	rtase_w16(tp, ivec->imr_addr, 0x0);
+	rtase_w16(tp, ivec->isr_addr, status);
+
+	if (napi_schedule_prep(&ivec->napi))
+		__napi_schedule(&ivec->napi);
+
+	return IRQ_HANDLED;
+}
+
+static int rtase_poll(struct napi_struct *napi, int budget)
+{
+	const struct rtase_int_vector *ivec;
+	const struct rtase_private *tp;
+	struct rtase_ring *ring;
+	int total_workdone = 0;
+
+	ivec = container_of(napi, struct rtase_int_vector, napi);
+	tp = ivec->tp;
+
+	list_for_each_entry(ring, &ivec->ring_list, ring_entry) {
+		total_workdone += ring->ring_handler(ring, budget);
+	}
+
+	if (total_workdone >= budget)
+		return budget;
+
+	if (napi_complete_done(napi, total_workdone)) {
+		if (!ivec->index)
+			rtase_w32(tp, ivec->imr_addr, ivec->imr);
+		else
+			rtase_w16(tp, ivec->imr_addr, ivec->imr);
+	}
+
+	return total_workdone;
+}
+
 static int rtase_open(struct net_device *dev)
 {
 	struct rtase_private *tp = netdev_priv(dev);
@@ -727,9 +797,28 @@ static void rtase_rar_set(const struct rtase_private *tp, const u8 *addr)
 	rtase_w16(tp, RTASE_LBK_CTRL, RTASE_LBK_ATLD | RTASE_LBK_CLR);
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/* Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+static void rtase_netpoll(struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	const struct pci_dev *pdev = tp->pdev;
+
+	disable_irq(pdev->irq);
+	rtase_interrupt(pdev->irq, dev);
+	enable_irq(pdev->irq);
+}
+#endif
+
 static const struct net_device_ops rtase_netdev_ops = {
 	.ndo_open = rtase_open,
 	.ndo_stop = rtase_close,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller = rtase_netpoll,
+#endif
 };
 
 static void rtase_get_mac_address(struct net_device *dev)
-- 
2.34.1


