Return-Path: <linux-kernel+bounces-127878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F60895227
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BCD28709E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE876410;
	Tue,  2 Apr 2024 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NXQ8dNS3"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1DE1EA8D;
	Tue,  2 Apr 2024 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058264; cv=none; b=ly6VXfW73Bxzi3HWUSnZw0yHHUu/26Dx0ySRZv0qe7mZouTVG9PPPk1qjFH+EBlcLrcb5iFO0Z007Kotc6NoU1P3qeJcSFVrUvTZHL2rdbuBWYCvEQTb29DpW5jxpOewmL8F23xc44k1eEbxQAUBQrgqGrypfDC7X1Amn1NfoMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058264; c=relaxed/simple;
	bh=ILrB+6cz6HZFHUW7pA1V7BBA5dKWSCPCbqLKdvup/hY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILDwGojlWa/jOvyrJOciN8Ke4KDgSQcXOKgV3F5IaiZuxgQT4Yg0p/M/PtfDBpmtS71GQo3ExNUsGEmn4YJB1mlLs8jlW4J/kkfopjhiLWo4usbj563U72vt9MeC48jKHAXVKP2b+TcCmEAsm6TqDYAvj7QackNRh8xbew8mztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NXQ8dNS3; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 432Bi9G4106111;
	Tue, 2 Apr 2024 06:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712058249;
	bh=X1oB/j3d+75cWGMAk7/UR4+QxjPZ19nCKrN63qf/K+8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NXQ8dNS31WX4G2oraq4RBp59Yyealfi5cqx9Jjf4BBXIuHBMd7i1FqvG9/hQ0tEpj
	 uSttSD7CQ8cbs2JAncNxH1Dg/fK2rhqsFnM4v+ISheGzI3P7fLGE1LIGLcKozdGbbw
	 g6NPxohSGZAhdxq4swDGdpDU0j57mFVh5sG3fRGM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 432Bi9w5019638
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 06:44:09 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 06:44:09 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 06:44:09 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 432Bi8Zl126388;
	Tue, 2 Apr 2024 06:44:09 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Chintan Vankar
	<c-vankar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Roger Quadros
	<rogerq@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v5 1/2] net: ethernet: ti: am65-cpts: Enable RX HW timestamp for PTP packets using CPTS FIFO
Date: Tue, 2 Apr 2024 17:14:04 +0530
Message-ID: <20240402114405.219100-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402114405.219100-1-c-vankar@ti.com>
References: <20240402114405.219100-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add a new function "am65_cpts_rx_timestamp()" which checks for PTP
packets from header and timestamps them.

Add another function "am65_cpts_find_rx_ts()" which finds CPTS FIFO
Event to get the timestamp of received PTP packet.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v4:
https://lore.kernel.org/r/20240327054234.1906957-1-c-vankar@ti.com/

Changes from v4 to v5:
- Updated commit message.
- Replaced "list_del_entry()" and "list_add()" functions with equivalent
  "list_move()" function.

 drivers/net/ethernet/ti/am65-cpts.c | 64 +++++++++++++++++++++++++++++
 drivers/net/ethernet/ti/am65-cpts.h |  6 +++
 2 files changed, 70 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index c66618d91c28..bc0bfda1db12 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -906,6 +906,70 @@ static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
 	return 1;
 }
 
+static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_seqid)
+{
+	struct list_head *this, *next;
+	struct am65_cpts_event *event;
+	unsigned long flags;
+	u32 mtype_seqid;
+	u64 ns = 0;
+
+	am65_cpts_fifo_read(cpts);
+	spin_lock_irqsave(&cpts->lock, flags);
+	list_for_each_safe(this, next, &cpts->events) {
+		event = list_entry(this, struct am65_cpts_event, list);
+		if (time_after(jiffies, event->tmo)) {
+			list_del_init(&event->list);
+			list_add(&event->list, &cpts->pool);
+			continue;
+		}
+
+		mtype_seqid = event->event1 &
+			      (AM65_CPTS_EVENT_1_MESSAGE_TYPE_MASK |
+			       AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK |
+			       AM65_CPTS_EVENT_1_EVENT_TYPE_MASK);
+
+		if (mtype_seqid == skb_mtype_seqid) {
+			ns = event->timestamp;
+			list_move(&event->list, &cpts->pool);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&cpts->lock, flags);
+
+	return ns;
+}
+
+void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb)
+{
+	struct am65_cpts_skb_cb_data *skb_cb = (struct am65_cpts_skb_cb_data *)skb->cb;
+	struct skb_shared_hwtstamps *ssh;
+	int ret;
+	u64 ns;
+
+	/* am65_cpts_rx_timestamp() is called before eth_type_trans(), so
+	 * skb MAC Hdr properties are not configured yet. Hence need to
+	 * reset skb MAC header here
+	 */
+	skb_reset_mac_header(skb);
+	ret = am65_skb_get_mtype_seqid(skb, &skb_cb->skb_mtype_seqid);
+	if (!ret)
+		return; /* if not PTP class packet */
+
+	skb_cb->skb_mtype_seqid |= (AM65_CPTS_EV_RX << AM65_CPTS_EVENT_1_EVENT_TYPE_SHIFT);
+
+	dev_dbg(cpts->dev, "%s mtype seqid %08x\n", __func__, skb_cb->skb_mtype_seqid);
+
+	ns = am65_cpts_find_rx_ts(cpts, skb_cb->skb_mtype_seqid);
+	if (!ns)
+		return;
+
+	ssh = skb_hwtstamps(skb);
+	memset(ssh, 0, sizeof(*ssh));
+	ssh->hwtstamp = ns_to_ktime(ns);
+}
+EXPORT_SYMBOL_GPL(am65_cpts_rx_timestamp);
+
 /**
  * am65_cpts_tx_timestamp - save tx packet for timestamping
  * @cpts: cpts handle
diff --git a/drivers/net/ethernet/ti/am65-cpts.h b/drivers/net/ethernet/ti/am65-cpts.h
index 6e14df0be113..90296968a75c 100644
--- a/drivers/net/ethernet/ti/am65-cpts.h
+++ b/drivers/net/ethernet/ti/am65-cpts.h
@@ -22,6 +22,7 @@ void am65_cpts_release(struct am65_cpts *cpts);
 struct am65_cpts *am65_cpts_create(struct device *dev, void __iomem *regs,
 				   struct device_node *node);
 int am65_cpts_phc_index(struct am65_cpts *cpts);
+void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
 void am65_cpts_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
 void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
 void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en);
@@ -48,6 +49,11 @@ static inline int am65_cpts_phc_index(struct am65_cpts *cpts)
 	return -1;
 }
 
+static inline void am65_cpts_rx_timestamp(struct am65_cpts *cpts,
+					  struct sk_buff *skb)
+{
+}
+
 static inline void am65_cpts_tx_timestamp(struct am65_cpts *cpts,
 					  struct sk_buff *skb)
 {
-- 
2.34.1


