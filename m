Return-Path: <linux-kernel+bounces-151162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CA78AAA24
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFF0BB237B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B8862170;
	Fri, 19 Apr 2024 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oeZR6sC1"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35CB54FBD;
	Fri, 19 Apr 2024 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515240; cv=none; b=mcqIx/3fXNxoXQ9UZJXCJDKX256JEG+VOnqHabQQTPUxff0rXmS/00kNtjozKfuZY48U0EgbDWHguUUzENq83yWrvzQWQopjXMsN/0fBu/ROG/KTfymVFNKwVKVXyjHiykS/NGGUUoEgSp6upEr5d57XazkYMZbFikfDf8FY7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515240; c=relaxed/simple;
	bh=O5tQs4novDeQwjkIzyWouiD1aDxL113Xw6D6bYYklGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPypRHA60OthX1nd09pmTvDpL2StADr08eWnPM1JiZmPwOgN5m+n/tom0t33oa6cE3m5gsdNhMuFNlbVzP0I/M1MFPGVSSsjUNEJb14kWh8FP1Wl1JzBUgLlKcOrS768pYFupoFRxZNM1+lnK+uXvC3hZy4pmazM1rB3weiUGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oeZR6sC1; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43J8QqKv009915;
	Fri, 19 Apr 2024 03:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713515212;
	bh=kjSma6XBdexIaEUVY3kYEc7mOY7r1fs7A6zh6NkZJYE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=oeZR6sC1G8t6zq3DeFkjSVbSZ1pejPnra6wXWgX8B0Wf+ovisDMso1toU3sCUvB79
	 1CEyZUHzyFv0Da4MCq2fW/XYsXTQw2zjkKR3t9jpbAIO2kPbfbygf7G9X6TtzIYXeA
	 CQA405NSg3K3t6P/iaGq0TK5vfEOc4Z/0zxZ+Yxs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43J8Qqtm127418
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Apr 2024 03:26:52 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 03:26:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 03:26:52 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43J8QpKF036067;
	Fri, 19 Apr 2024 03:26:51 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Chintan Vankar <c-vankar@ti.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>, <s-vadapalli@ti.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v8 1/2] net: ethernet: ti: am65-cpts: Enable RX HW timestamp for PTP packets using CPTS FIFO
Date: Fri, 19 Apr 2024 13:56:25 +0530
Message-ID: <20240419082626.57225-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419082626.57225-1-c-vankar@ti.com>
References: <20240419082626.57225-1-c-vankar@ti.com>
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

Link to v7:
https://lore.kernel.org/r/20240417120913.3811519-2-c-vankar@ti.com/

Changes from v7 to v8:
- No changes.

 drivers/net/ethernet/ti/am65-cpts.c | 84 ++++++++++++++++++++++++++---
 drivers/net/ethernet/ti/am65-cpts.h |  6 +++
 2 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index c66618d91c28..599454c1d19f 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -275,15 +275,13 @@ static bool am65_cpts_fifo_pop_event(struct am65_cpts *cpts,
 	return true;
 }
 
-static int am65_cpts_fifo_read(struct am65_cpts *cpts)
+static int __am65_cpts_fifo_read(struct am65_cpts *cpts)
 {
 	struct ptp_clock_event pevent;
 	struct am65_cpts_event *event;
 	bool schedule = false;
 	int i, type, ret = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&cpts->lock, flags);
 	for (i = 0; i < AM65_CPTS_FIFO_DEPTH; i++) {
 		event = list_first_entry_or_null(&cpts->pool,
 						 struct am65_cpts_event, list);
@@ -312,8 +310,7 @@ static int am65_cpts_fifo_read(struct am65_cpts *cpts)
 			event->tmo = jiffies +
 				msecs_to_jiffies(AM65_CPTS_EVENT_RX_TX_TIMEOUT);
 
-			list_del_init(&event->list);
-			list_add_tail(&event->list, &cpts->events);
+			list_move_tail(&event->list, &cpts->events);
 
 			dev_dbg(cpts->dev,
 				"AM65_CPTS_EV_TX e1:%08x e2:%08x t:%lld\n",
@@ -356,14 +353,24 @@ static int am65_cpts_fifo_read(struct am65_cpts *cpts)
 	}
 
 out:
-	spin_unlock_irqrestore(&cpts->lock, flags);
-
 	if (schedule)
 		ptp_schedule_worker(cpts->ptp_clock, 0);
 
 	return ret;
 }
 
+static int am65_cpts_fifo_read(struct am65_cpts *cpts)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&cpts->lock, flags);
+	ret = __am65_cpts_fifo_read(cpts);
+	spin_unlock_irqrestore(&cpts->lock, flags);
+
+	return ret;
+}
+
 static u64 am65_cpts_gettime(struct am65_cpts *cpts,
 			     struct ptp_system_timestamp *sts)
 {
@@ -906,6 +913,69 @@ static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
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
+	spin_lock_irqsave(&cpts->lock, flags);
+	__am65_cpts_fifo_read(cpts);
+	list_for_each_safe(this, next, &cpts->events) {
+		event = list_entry(this, struct am65_cpts_event, list);
+		if (time_after(jiffies, event->tmo)) {
+			list_move(&event->list, &cpts->pool);
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


