Return-Path: <linux-kernel+bounces-66747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C37085610A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C7A2918EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1549128837;
	Thu, 15 Feb 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GrswMLsi"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63885129A91;
	Thu, 15 Feb 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995411; cv=none; b=Aw4cQhBJlNtOR56sKy7d3H/lyiieE0K5sOxzvcYRzGOTxqa3qal2RzSbCJ6H0auLeFeu0/fTXIEXONKigCycJWsZfqn9dmfIGHOjP6OBZS1aiiBEFrJZJunJjjyRAlgrNnNMxQojzk0ghmx/5rlUFOm8YJhQ6M3qKmPCOsUQC1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995411; c=relaxed/simple;
	bh=jvC+lMRGc6c7n5MUk7PAjVtPBj27Vmls03WU2plIzsI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mxQ279pujBT6t0NWYHUw1j5vOBGlmtteXG0+wYLObXJSbl+mEoOIwrE6ihDG7GADoZpinaVgW0xuYG62oD53dlPcxPzY2G4Zsw7qxByjLk7/E4zIx5CWvkiVbYhd/c+7kY9/krFgLzzUmmgbU4I5koaBfJL594Un0THamiPrZbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GrswMLsi; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41FB9xXm081717;
	Thu, 15 Feb 2024 05:09:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707995399;
	bh=HedDIvMLYfuWkKr9N3wYCvW8OcWi6ejb9YfzXb/Bzvg=;
	h=From:To:CC:Subject:Date;
	b=GrswMLsiwU/cAv2jsnm3AfqhIVIP17EMF1M72cPxVQVJtlm3Nj+e4QE8wJLZhZ9cw
	 7QJLXM7t/Te8T5ZAs5X4Co3f6vmMolSzG0bD50+a78CKThU3XlJ1ZOQ6UxmvMXgnfy
	 yVBTliURsNRIgYqzRzvrEwkqpMRVc6+1lE1Vc6lg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41FB9xDx046597
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 05:09:59 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 05:09:58 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 05:09:58 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41FB9wix069245;
	Thu, 15 Feb 2024 05:09:58 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 1/2] net: ethernet: ti: am65-cpts: Enable PTP RX HW timestamp using CPTS FIFO
Date: Thu, 15 Feb 2024 16:39:52 +0530
Message-ID: <20240215110953.3225099-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

CPTS module supports capturing timestamp for every packet it receives,
add a new function named "am65_cpts_rx_find_ts()" to get the timestamp
of received packets from CPTS FIFO.

Add another function named "am65_cpts_rx_timestamp()" which internally
calls "am65_cpts_rx_find_ts()" function and timestamps the received
PTP packets.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 drivers/net/ethernet/ti/am65-cpts.c | 84 +++++++++++++++++++++--------
 drivers/net/ethernet/ti/am65-cpts.h | 11 ++--
 2 files changed, 67 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index c66618d91c28..92a3b40e60d6 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -859,29 +859,6 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp)
 	return delay;
 }
 
-/**
- * am65_cpts_rx_enable - enable rx timestamping
- * @cpts: cpts handle
- * @en: enable
- *
- * This functions enables rx packets timestamping. The CPTS can timestamp all
- * rx packets.
- */
-void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
-{
-	u32 val;
-
-	mutex_lock(&cpts->ptp_clk_lock);
-	val = am65_cpts_read32(cpts, control);
-	if (en)
-		val |= AM65_CPTS_CONTROL_TSTAMP_EN;
-	else
-		val &= ~AM65_CPTS_CONTROL_TSTAMP_EN;
-	am65_cpts_write32(cpts, val, control);
-	mutex_unlock(&cpts->ptp_clk_lock);
-}
-EXPORT_SYMBOL_GPL(am65_cpts_rx_enable);
-
 static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
 {
 	unsigned int ptp_class = ptp_classify_raw(skb);
@@ -906,6 +883,67 @@ static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
 	return 1;
 }
 
+static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, struct sk_buff *skb,
+				int ev_type, u32 skb_mtype_seqid)
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
+			list_del_init(&event->list);
+			list_add(&event->list, &cpts->pool);
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
+	ret = am65_skb_get_mtype_seqid(skb, &skb_cb->skb_mtype_seqid);
+	if (!ret)
+		return; /* if not PTP class packet */
+
+	skb_cb->skb_mtype_seqid |= (AM65_CPTS_EV_RX << AM65_CPTS_EVENT_1_EVENT_TYPE_SHIFT);
+
+	dev_dbg(cpts->dev, "%s mtype seqid %08x\n", __func__, skb_cb->skb_mtype_seqid);
+
+	ns = am65_cpts_find_rx_ts(cpts, skb, AM65_CPTS_EV_RX, skb_cb->skb_mtype_seqid);
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
index 6e14df0be113..6099d772799d 100644
--- a/drivers/net/ethernet/ti/am65-cpts.h
+++ b/drivers/net/ethernet/ti/am65-cpts.h
@@ -22,9 +22,9 @@ void am65_cpts_release(struct am65_cpts *cpts);
 struct am65_cpts *am65_cpts_create(struct device *dev, void __iomem *regs,
 				   struct device_node *node);
 int am65_cpts_phc_index(struct am65_cpts *cpts);
+void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
 void am65_cpts_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
 void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
-void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en);
 u64 am65_cpts_ns_gettime(struct am65_cpts *cpts);
 int am65_cpts_estf_enable(struct am65_cpts *cpts, int idx,
 			  struct am65_cpts_estf_cfg *cfg);
@@ -48,17 +48,18 @@ static inline int am65_cpts_phc_index(struct am65_cpts *cpts)
 	return -1;
 }
 
-static inline void am65_cpts_tx_timestamp(struct am65_cpts *cpts,
+static inline void am65_cpts_rx_timestamp(struct am65_cpts *cpts,
 					  struct sk_buff *skb)
 {
 }
 
-static inline void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts,
-					       struct sk_buff *skb)
+static inline void am65_cpts_tx_timestamp(struct am65_cpts *cpts,
+					  struct sk_buff *skb)
 {
 }
 
-static inline void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
+static inline void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts,
+					       struct sk_buff *skb)
 {
 }
 
-- 
2.34.1


