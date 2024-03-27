Return-Path: <linux-kernel+bounces-120335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DE588D5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F491C22CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E8E175AA;
	Wed, 27 Mar 2024 05:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FTc0Ehpp"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A6FC18;
	Wed, 27 Mar 2024 05:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518173; cv=none; b=WGd4vSK97hesITAS3a9chw4D6dIYcNfm0dru2rgrs/W+cXKdxyKb3AAAFsLeaxd+7IOr6G+kcyDt62trnGUMwekBQHTZ/Cj016xH/LCyBDiYFluVpvDd6mEK6xNV2HQXV6KVoOd59+cIHBknKqBYBiM6whzWVkIy8FxohKTFzak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518173; c=relaxed/simple;
	bh=QQaHLtuCVDpufz/dWiNPqyz029e9Y48ZpXiYSb0Ohnc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dqDa0FXHqe+FHZZtIVDuoD2Goz3p6Y75t85x8uv+qO68AcrSZE7D1F+O5F0tReot5Rss3WFJxEFfarlPS2mgyF6ZOLN0xKfZvA3zYvS0LCRhIl5ITnubFNglkDApXUcOsF2JnCsyeWhxcHC7VKQaY96bVs7I8uiSbdqgTrPFAT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FTc0Ehpp; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42R5gaEQ081137;
	Wed, 27 Mar 2024 00:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711518156;
	bh=ErIA36PB/xIN23wrInJjOe4P3aBvVzJ24Brluvn2JoU=;
	h=From:To:CC:Subject:Date;
	b=FTc0Ehppng+kGcqn3OxGjuZrHKLWTmSvNii/CiQjQuuEyZAXEbrdCPbTHdaAhxy6n
	 FXXGLKPhVvug/npXMZnUee8OZu1dwZi/kyC+bBaBXy+Rg1X7y1MsMLruZq6/IrFSOG
	 zLCV2cTrkc+fxyMMDHnXBC1l8wh4OwTp+83RmD2A=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42R5gavO002199
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Mar 2024 00:42:36 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Mar 2024 00:42:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Mar 2024 00:42:36 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42R5gZE4092551;
	Wed, 27 Mar 2024 00:42:36 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Heiner
 Kallweit" <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Chintan Vankar <c-vankar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Roger Quadros
	<rogerq@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v4 1/3] net: ethernet: ti: am65-cpts: Enable PTP RX HW timestamp using CPTS FIFO
Date: Wed, 27 Mar 2024 11:12:32 +0530
Message-ID: <20240327054234.1906957-1-c-vankar@ti.com>
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

Changes from v3 to v4:
- No change in v4.

Link to v3:
https://lore.kernel.org/r/20240320102600.3418248-1-c-vankar@ti.com/

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


