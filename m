Return-Path: <linux-kernel+bounces-132753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D873B8999B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0897D1C21499
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F013816087B;
	Fri,  5 Apr 2024 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b="YIpQS+ou"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2110.outbound.protection.outlook.com [40.107.247.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E191FDD;
	Fri,  5 Apr 2024 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309932; cv=fail; b=iXFcmvn3Ojn+0aWk6ZYUHuBeWiIlyLkcHi+L3xFpi5TICsZcJWZ4D/GGtAUTbzpyhE8Hr7hM1vy4Na8HFo1g0OfZTvfqJRjjqZzI9TDOTF3T1MMsk9IRBzBBZf47R0RwTOe6QfNsg5z4pAQBcH+Q9O3ghuU5eJRMAJZOjcxqeNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309932; c=relaxed/simple;
	bh=aEyL+MPQYt5dq+gW5C9V2wJPUcM+yHqaRLEpbo3aAow=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l0cSYlaYaiyPL1lSB6hBzUdwyi0Zqy9cc0kzgQHlPWQNh3b1VSvscdTvzDCQML4WZH478ANkTnbrTTe2lztV6f9vSJX43X3+yN7NtUYKendIajTKIK1rMDwtMC0RIkUO9ReTZyyhiZs3DhTzCm42cmn2ZbnRXq2kIVCeIvyvmdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net; spf=pass smtp.mailfrom=surban.net; dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b=YIpQS+ou; arc=fail smtp.client-ip=40.107.247.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surban.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5RTADfowayQV0OFiWuZLqMfuGJmoUPzVYpo84SxlH3nwEqA6YjFX0XA4gAR6OIul1OimGBok/BhSJqlSxFuxpjkWN7oGLBd1ZJzOxjI8S76E7Dq+WwVoT8G83fJJf0JT9p2wXA//9J7r8npesTU4jPvVISbVgfC9UtAYf4Vdur8vaMjBkqPnx1N3zTPHhbBSZSQ57lzyU0+/e5MVObAL6ZHrrCOqgyEp7LArDaGBY9xD3KrFW7d4iIC6lw7MRHP1q/x+BA+M81rJ9S6VX+nRYk0eEA+ET28y9VQHa099qt1fDje/xxjmJweiKK6wMT7BmLIvIrC/+fWxuYZ6Y/7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyhKCcFWctkqTiIwqcoZipH5kke9qN4WRefSX0gMqhg=;
 b=nOmfDSA+0LSGMUiK/m0RizRTBwmQtLl8kkvUaumx79tjz7eNx25EWtlhcwMO01Z2Fv1UNqCJyXNuAp1Wo+v2vK+MH1shNnOd9KcECQdk+317AqGhg3fAvjLZGKPGSA6bSV+NvMmecMhIpYoKwM88kKuRjG2OlU7mWLjOH1HOxxkN6ZznqW1yd5bkLke06m96OmspjObQWqGMn6G1IPIzqd6xb71007iYsc5z8qzKUti3cUwl0SXovJFSh6/0chLGQEf2XjPZw4JHZeqg5Xl6pMqjbJP31SEQe/n9CuzSRq3qG8U7cOg09jvckVjhxrffdkvLJOn1VYBaMeQM/TvhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyhKCcFWctkqTiIwqcoZipH5kke9qN4WRefSX0gMqhg=;
 b=YIpQS+ouIVF6loTT2QeVoHFvh36wGGJQoDPFRiVUymlmrid3LcjM2naw4Amxjys3jsXgDt5YyYx3u4YfFebz0ndQNCq8N61fJAco6V4isSI4IJEgNK7t9VObuzf0KuSiT8PSwi8QQ2li+ZvnRiIaa6zwQ5YBjfORzKMgmGEXT0g=
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:37d::18)
 by GV2P189MB2405.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 09:38:44 +0000
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1]) by DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1%3]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 09:38:44 +0000
From: Sebastian Urban <surban@surban.net>
To:
Cc: Sebastian Urban <surban@surban.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] l2cap: do not return LE flow credits when buf full
Date: Fri,  5 Apr 2024 11:38:34 +0200
Message-Id: <20240405093834.63666-1-surban@surban.net>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0152.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::10) To DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:37d::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1978:EE_|GV2P189MB2405:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6PSZuLMc+Epxr+jF4xO7OHHc7PokcRad/ZszGr0DRlUwCE6Xs66ba2YTCMwmSjZbz630M43eR/IaK8NaA9CqJSZTABfMo5QnqUuUCmVFMLxvfKzL+nWBaR++LodrXVPcCIpgMcNahTVE3ee3hLnGmkvd9FnmaUjfv5Sf1uYY5lIFKM9uGRFkvZKrm0FTRnyJvWSU5Vcb74mKhZkKK61ThwajirAJO6g4PWWIHZc1WK9PtE6rvcvJTw4Olvgv9XGLXEwYQ8bZ9dzWid4aNTO1ygGhgeqXYpvXnSgNQGhmZ4rTA4glbREwPOjTm0Or7h79N9sLOkXEEXErk+/qCCn81SEtgt+/VJwKafJ38VaD7/hEulYt8vM+Ce6jJrRLJPVOR5+1uaRLXXkcVCUGhkH4lnxtCGnmHW971XP7uT1BQ/6ugpL5z628VmaSaXsW3ZPq3d7dHoBWdWXE6VJJXKGuGA64gIy+mZEjlxvR3UibaXsHzPdzF/hBKsjKLpv2EY7LIZdXuryaADRnvf5tnXZuZjYWG6isYylf1nRrpyhPxvHRvYMp8C8qPkrIxNpodzBL6ERP2FvpenOeuoy7lhrI0Zk7mosoRJzZS7aTlO4inah9+qdpGLmkqGTNLSlkkdJ92ZfYw/tTo/F0Hes4Og7AzIajiT5Zs3AFIDcQdMr6zNk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1978.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(52116005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8/IHAOh3yvQGgvHOxiefgUMevjv8zXMPn05FAulIBU+NvknRJ0uWBjeuaKXj?=
 =?us-ascii?Q?MhsSktITJD7KkdTJOMABgw7+GmFOSU/FAGTNCYd+213EPTAo5ZuiBYDDrccu?=
 =?us-ascii?Q?ipPRjfY1gI3CNoqtaC2SZbjSQ5vuo2dzqTLJqp+gW026vOpn9cjd0FJZVAlf?=
 =?us-ascii?Q?RJgsQIuSLAm96lhn4KEZACX2jm1XGoYDq/XTumEV1GLL6UuuRvQeE6qShUnt?=
 =?us-ascii?Q?U8rGPr3/+Y8QT5WWp7RhmP5AoOo2G06MxfsAg/jxgDAsMzHJpB15Xefe0HBm?=
 =?us-ascii?Q?ucPARqBX46n5DY8Z0KceiD7QNFQxG82550EtetFImOMaQYSfso2gmJQ0TiQ/?=
 =?us-ascii?Q?hyDz6ym16C4Gkodwx8lV21uXbilr+mNfAyQZsDTw7mhpGg/G0u0UMPNwJbng?=
 =?us-ascii?Q?EuGY5gJ8h8M/xSiXKjbpP0ml09bQIwpbScoqbyYQ9Ftmi3K0nz9R3rYx0Evk?=
 =?us-ascii?Q?ireL5IjUeBfWiLm+6o019JD56se0RG9UoOf6CGx0XarmBR8imteXEEAcLCB2?=
 =?us-ascii?Q?BX79S0m0fBQaYxtQS2nk4s7rY8dQKBXpJR4Hvxe9gUHY6kc6u1EtgZT5uHL4?=
 =?us-ascii?Q?qegHNs4rw9SVJWKe19bS8pr/cfPnEh1HU9hbAWEDEenEMKXH5t+NrGoQhoSa?=
 =?us-ascii?Q?IT6F/oh9c2ynT31ed/TnXm9UWILIPS9lE8ENQbbkVvCsvbxB4461JUoBsjvu?=
 =?us-ascii?Q?8QqHlrh8tSalQ4gLO05xWAqWu4iQOjBXIeJYl/OK3O4dzho4OeMt931aerF8?=
 =?us-ascii?Q?6LrGDvDdly47L1ZROrCCrIY2DzQrnXJlvCUOPVQFzsAa6Njbkl9GKFbrUizJ?=
 =?us-ascii?Q?w3G1DXU3DBfUMgpcrDYM5ItxDvDp4iAfwu4xHg29q591ghRNre0gG3KrRwu0?=
 =?us-ascii?Q?T00yoo9YLvpFnOLZHVyvqSIdB+MvVG0NcTxe71VdgSbOju9XbZUFkPNyx3Di?=
 =?us-ascii?Q?B9RstdwBVM+lugXl1oaFWxmjrVGB+xuvatSqE9v1dRYYZ9RxZDD+vENzyIBM?=
 =?us-ascii?Q?c74BVL4W718WtUGkXT1vPPjkjAAF0jr9IKVKuK4ywrGhdHvqllpVI24sniUn?=
 =?us-ascii?Q?7QLxpkVFHdN0n4xYQyAIf4a813f5ytxV3wQ3onQyq2INqjpFjDexxB1jO1OM?=
 =?us-ascii?Q?hewHrlCg+v5DyFByUWL2hmdNSQKQ9L5DVut6FSmQ3X/Oan14TTGphV7o9laI?=
 =?us-ascii?Q?Xme78qPBrb7WA4P3g/nmxM9dAPv0C9LvOudabg9sEwbM/G4r9/Kmq/ZqSsIl?=
 =?us-ascii?Q?bGi3xQblcvOJItCPCU2apU2GQRn1+5Gc4HvHpjbi7pQFMJl2ih272ua23N2S?=
 =?us-ascii?Q?JflsyV5dSd/AOZq0GHmU5BTTzNS53cluTiGUrm841/zFepPuH4Qn0+e1zpMz?=
 =?us-ascii?Q?qVKQ6bpfb3i2MizgAxN4WNHuuLWL2NQSp0yhTHyCow4rQ53CKfDoHmie5v8r?=
 =?us-ascii?Q?XZBbagu39XRWjiJMZT/412qvzzyR6yukjn2gnlPFBWtht5Bza8evNU9MbP87?=
 =?us-ascii?Q?b3+2IlUPr0DaMZ9KaGyf2q7hGuSaFNsppmm+03s4+fPMCjn7aHVqsCV5gJ3j?=
 =?us-ascii?Q?NRoz/qKZzeWO8lgfsGQxbaJ+psPl5ABng9gTpl4g4n72WD3ztNlPnd5C06pd?=
 =?us-ascii?Q?5sWU2Ls8FlMwwLM815ouzlwEql833Qrj4gA1XCs0NLAW?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 347a6022-776a-4abe-1b4a-08dc55542f63
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 09:38:44.1905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXYvx+kjHvK4FESGpOMczk0SS9Yfs3LapyZvWC2wl2nv2MW1oFIkp+PpCU3+5smTqhiFv6V/6uOb8WugXbH9Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P189MB2405

Previously LE flow credits were returned to the
sender even if the socket's receive buffer was
full. This meant that no back-pressure
was applied to the sender, thus it continued to
send data, resulting in data loss without any
error being reported.

This is fixed by stopping the return of LE flow
credits when the receive buffer of an L2CAP socket
is full. Returning of the credits is resumed, once
the receive buffer is half-empty.

Already received data is temporary stored within
l2cap_pinfo, since Bluetooth LE provides no
retransmission mechanism once the data has been
acked by the physical layer.

Signed-off-by: Sebastian Urban <surban@surban.net>
---
 include/net/bluetooth/l2cap.h |  7 ++++-
 net/bluetooth/l2cap_core.c    | 38 ++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c    | 53 ++++++++++++++++++++++++++---------
 3 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 92d7197f9a56..230c14ea944c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -682,10 +682,15 @@ struct l2cap_user {
 /* ----- L2CAP socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
 
+struct l2cap_rx_busy {
+	struct list_head	list;
+	struct sk_buff		*skb;
+};
+
 struct l2cap_pinfo {
 	struct bt_sock		bt;
 	struct l2cap_chan	*chan;
-	struct sk_buff		*rx_busy_skb;
+	struct list_head	rx_busy;
 };
 
 enum {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ab5a9d42fae7..c78af7fad255 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -63,6 +63,8 @@ static void l2cap_retrans_timeout(struct work_struct *work);
 static void l2cap_monitor_timeout(struct work_struct *work);
 static void l2cap_ack_timeout(struct work_struct *work);
 
+static void l2cap_chan_le_send_credits(struct l2cap_chan *chan);
+
 static inline u8 bdaddr_type(u8 link_type, u8 bdaddr_type)
 {
 	if (link_type == LE_LINK) {
@@ -5714,17 +5716,34 @@ static int l2cap_resegment(struct l2cap_chan *chan)
 	return 0;
 }
 
-void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
+static void l2cap_chan_busy_ertm(struct l2cap_chan *chan, int busy)
 {
 	u8 event;
 
-	if (chan->mode != L2CAP_MODE_ERTM)
-		return;
-
 	event = busy ? L2CAP_EV_LOCAL_BUSY_DETECTED : L2CAP_EV_LOCAL_BUSY_CLEAR;
 	l2cap_tx(chan, NULL, NULL, event);
 }
 
+static void l2cap_chan_busy_le(struct l2cap_chan *chan, int busy)
+{
+	if (busy) {
+		set_bit(CONN_LOCAL_BUSY, &chan->conn_state);
+	} else {
+		clear_bit(CONN_LOCAL_BUSY, &chan->conn_state);
+		l2cap_chan_le_send_credits(chan);
+	}
+}
+
+void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
+{
+	if (chan->mode == L2CAP_MODE_ERTM) {
+		l2cap_chan_busy_ertm(chan, busy);
+	} else if (chan->mode == L2CAP_MODE_LE_FLOWCTL ||
+		   chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
+		l2cap_chan_busy_le(chan, busy);
+	}
+}
+
 static int l2cap_rx_queued_iframes(struct l2cap_chan *chan)
 {
 	int err = 0;
@@ -6514,6 +6533,11 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	struct l2cap_le_credits pkt;
 	u16 return_credits;
 
+	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
+		BT_DBG("busy chan %p not returning credits to sender", chan);
+		return;
+	}
+
 	return_credits = (chan->imtu / chan->mps) + 1;
 
 	if (chan->rx_credits >= return_credits)
@@ -6542,6 +6566,12 @@ static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb)
 	/* Wait recv to confirm reception before updating the credits */
 	err = chan->ops->recv(chan, skb);
 
+	if (err < 0) {
+		BT_ERR("Queueing received LE L2CAP data failed");
+		l2cap_send_disconn_req(chan, ECONNRESET);
+		return err;
+	}
+
 	/* Update credits whenever an SDU is received */
 	l2cap_chan_le_send_credits(chan);
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ee7a41d6994f..3b0fb6e0b61b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1177,7 +1177,9 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	else
 		err = bt_sock_recvmsg(sock, msg, len, flags);
 
-	if (pi->chan->mode != L2CAP_MODE_ERTM)
+	if (pi->chan->mode != L2CAP_MODE_ERTM &&
+	    pi->chan->mode != L2CAP_MODE_LE_FLOWCTL &&
+	    pi->chan->mode != L2CAP_MODE_EXT_FLOWCTL)
 		return err;
 
 	/* Attempt to put pending rx data in the socket buffer */
@@ -1187,11 +1189,15 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	if (!test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state))
 		goto done;
 
-	if (pi->rx_busy_skb) {
-		if (!__sock_queue_rcv_skb(sk, pi->rx_busy_skb))
-			pi->rx_busy_skb = NULL;
-		else
+	while (!list_empty(&pi->rx_busy)) {
+		struct l2cap_rx_busy *rx_busy =
+			list_first_entry(&pi->rx_busy,
+					 struct l2cap_rx_busy,
+					 list);
+		if (__sock_queue_rcv_skb(sk, rx_busy->skb) < 0)
 			goto done;
+		list_del(&rx_busy->list);
+		kfree(rx_busy);
 	}
 
 	/* Restore data flow when half of the receive buffer is
@@ -1459,17 +1465,20 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	struct sock *sk = chan->data;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	int err;
 
 	lock_sock(sk);
 
-	if (l2cap_pi(sk)->rx_busy_skb) {
+	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
 		goto done;
 	}
 
 	if (chan->mode != L2CAP_MODE_ERTM &&
-	    chan->mode != L2CAP_MODE_STREAMING) {
+	    chan->mode != L2CAP_MODE_STREAMING &&
+	    chan->mode != L2CAP_MODE_LE_FLOWCTL &&
+	    chan->mode != L2CAP_MODE_EXT_FLOWCTL) {
 		/* Even if no filter is attached, we could potentially
 		 * get errors from security modules, etc.
 		 */
@@ -1480,17 +1489,28 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	err = __sock_queue_rcv_skb(sk, skb);
 
-	/* For ERTM, handle one skb that doesn't fit into the recv
+	/* For ERTM and LE, handle a skb that doesn't fit into the recv
 	 * buffer.  This is important to do because the data frames
 	 * have already been acked, so the skb cannot be discarded.
 	 *
 	 * Notify the l2cap core that the buffer is full, so the
 	 * LOCAL_BUSY state is entered and no more frames are
 	 * acked and reassembled until there is buffer space
-	 * available.
+	 * available. In the case of LE this blocks returning of flow
+	 * credits.
 	 */
-	if (err < 0 && chan->mode == L2CAP_MODE_ERTM) {
-		l2cap_pi(sk)->rx_busy_skb = skb;
+	if (err < 0 &&
+	    (chan->mode == L2CAP_MODE_ERTM ||
+	     chan->mode == L2CAP_MODE_LE_FLOWCTL ||
+	     chan->mode == L2CAP_MODE_EXT_FLOWCTL)) {
+		struct l2cap_rx_busy *rx_busy =
+			kmalloc(sizeof(*rx_busy), GFP_KERNEL);
+		if (!rx_busy) {
+			err = -ENOMEM;
+			goto done;
+		}
+		rx_busy->skb = skb;
+		list_add_tail(&rx_busy->list, &pi->rx_busy);
 		l2cap_chan_busy(chan, 1);
 		err = 0;
 	}
@@ -1716,6 +1736,8 @@ static const struct l2cap_ops l2cap_chan_ops = {
 
 static void l2cap_sock_destruct(struct sock *sk)
 {
+	struct l2cap_rx_busy *rx_busy, *next;
+
 	BT_DBG("sk %p", sk);
 
 	if (l2cap_pi(sk)->chan) {
@@ -1723,9 +1745,10 @@ static void l2cap_sock_destruct(struct sock *sk)
 		l2cap_chan_put(l2cap_pi(sk)->chan);
 	}
 
-	if (l2cap_pi(sk)->rx_busy_skb) {
-		kfree_skb(l2cap_pi(sk)->rx_busy_skb);
-		l2cap_pi(sk)->rx_busy_skb = NULL;
+	list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_busy, list) {
+		kfree_skb(rx_busy->skb);
+		list_del(&rx_busy->list);
+		kfree(rx_busy);
 	}
 
 	skb_queue_purge(&sk->sk_receive_queue);
@@ -1830,6 +1853,8 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_destruct = l2cap_sock_destruct;
 	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
 
+	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
+
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
-- 
2.34.1


