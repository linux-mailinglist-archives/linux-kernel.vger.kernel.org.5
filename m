Return-Path: <linux-kernel+bounces-108764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E67C880FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCCA1C22EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6214A4315B;
	Wed, 20 Mar 2024 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cw3KvZyV"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53313FBBD;
	Wed, 20 Mar 2024 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930385; cv=none; b=Fpft5F8Q0DamVtjRyTZyVUrQ0Sr/5YSP2b5oS1/TaDF2i8Z9Ak9v5c6J2xf/3EiSLNcTGDvhHL5GbTSPvzmRckdg4ltFIjDiaFu0iKWwqwW80I2LrCPlK3gOxgYMI8uUih228h3rnc2+oz7qzLKJYCaRR+Z1FRVcstwekzfa+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930385; c=relaxed/simple;
	bh=S8bzl/MQ5n2SlKIYxmVXTQUrEGkVsyoNaNQTpYUoR/U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H8Iobjhwh1U4mPYwhsHvTumYoKpgsaVTfEcgdj/y/KWnijBDugD+difeMRyK1Ot99DuHsoAhHYLVJ1xrkEb1yh2cxZrFiEp4kN2MfDN5KM09jqxMxmqTYYOC1O/z5zW3pKc9M/vTXPT879D+mCgV4A4u6+dtALYVw/QaaXP1W1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cw3KvZyV; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42KAQ3Yv027449;
	Wed, 20 Mar 2024 05:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710930363;
	bh=+dlByXerH0MDlkGZ92z12sZjnGAVCmNzQrHw/gbQNJo=;
	h=From:To:CC:Subject:Date;
	b=cw3KvZyV3AMUhTB2plI79z+AOel4DQvaEXWLWRQHlyg4N2OD/HHvW28U0o5MLAGGj
	 VlgtSvFLfbJQr9Gdq4IM6Zb+RW0bwqchZlALnDoNPamCdyJgfV4pkzIBCm4BQoZzEG
	 PliCpThc+dnhAC9JDBcfAfoZChSiDiliuA78wWLk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42KAQ3Ii032423
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Mar 2024 05:26:03 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Mar 2024 05:26:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Mar 2024 05:26:03 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42KAQ28a036653;
	Wed, 20 Mar 2024 05:26:03 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Heiner
 Kallweit" <hkallweit1@gmail.com>,
        Chintan Vankar <c-vankar@ti.com>,
        "Vladimir
 Oltean" <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, Roger
 Quadros <rogerq@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v3 1/3] net: ethernet: ti: am65-cpts: Enable PTP RX HW timestamp using CPTS FIFO
Date: Wed, 20 Mar 2024 15:55:58 +0530
Message-ID: <20240320102600.3418248-1-c-vankar@ti.com>
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
add a new function named "am65_cpts_find_rx_ts()" to get the timestamp
of received packets from CPTS FIFO.

Add another function named "am65_cpts_rx_timestamp()" which internally
calls "am65_cpts_find_rx_ts()" function and timestamps the received
PTP packets.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Changes from v2 to v3:
- Updated the patch by moving removal of "am65_cpts_rx_enable" function
  part to the next patch to avoid transient build break.

Link to v2:
https://lore.kernel.org/r/20240312100233.941763-1-c-vankar@ti.com/

 drivers/net/ethernet/ti/am65-cpts.c | 65 +++++++++++++++++++++++++++++
 drivers/net/ethernet/ti/am65-cpts.h |  6 +++
 2 files changed, 71 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index c66618d91c28..040953ea8cc2 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -906,6 +906,71 @@ static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqid)
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


