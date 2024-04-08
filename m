Return-Path: <linux-kernel+bounces-135170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD0989BC21
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B844B283A61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE24C634;
	Mon,  8 Apr 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b="EqcydbrQ"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2134.outbound.protection.outlook.com [40.107.8.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E448CFC;
	Mon,  8 Apr 2024 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569334; cv=fail; b=QIbaFVXLX75aIm/jIq5Emk7yUTO7kLCYdbkuLn7A+A5fDgecZ8od0tOZH6Weohb0xEWfNgu2xsRVrR7a6r31HzBFcATMrTxpcwNp38vNrgBYsWZ9GnwsyITzh9wb2A5HZTjuikWbGl0AIkOhUaYBpT4fYjrgoJFsFG+K8oup/cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569334; c=relaxed/simple;
	bh=P39wapwnd0nF2lfl/ghQZ29y/uniaw3RlCGI6dY9v/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HIFCU+I1cyd9DZApDvpsqoHItmmXo/6Vx5Qp8rwy5LLCEaLNPy/3u3IPyRdp9s98F9XaRSzJCCIrxQjWNXX/iRB7GUyBXAG+2cuHGTyXkSyVM/14fFU36fs6fFGNL/qb1i6YIHJRSFqjjyVoinRkz2F7ufEWc+ruhUTjnH7ykLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net; spf=pass smtp.mailfrom=surban.net; dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b=EqcydbrQ; arc=fail smtp.client-ip=40.107.8.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surban.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a78D9clNiVVZB3kVHlYmQO1xsYzswIovTboaRuEHdtjORK/2QQDsdkU/jn47z8WqO67q3QOmQ/3GlhKlmrJlgBz41hcsONWmWMnczN6CZmkIhP8NHTeJLMsqAVu+Ex09FoU3wKPP90p5Zp+aQoyhGop1AlStn9i1wKiiyGl0QLn+SbTB1uNBpBLOKC84VBHsIc1y4a3aYhHSjS0MHvIo8TIWOKMCeicPIsreZey1wBhRrZv6ZEV+6WhQ0EjzciLU8dCUl2ZWNCDI4e5S7yMeGd68pxTIMeq76MTW2u6D4MSei93dh9fAdptL7mgIsdaGYrcyFrZi9UyRigbEeUfQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlB4tCKJYvukhLevB9WcB8uLtEBHFOD3C+/0QzfDEYA=;
 b=kp0Sv1xGiz9WIMS3SrklCpRO43nJGKUUTAjVrL100383gv8mUhE0UKpoPip6IsPR9Am658SuuR098/DmOtHGr6bDKGKA06gf5UYrb2q4JIu68mRO2yOyie2BR/W9WoHIRZ3uxxuGkQp4jaYALITCDLfQ3ta6dK0jVDZ9B3/Vy0cCQ82giobLFfEKGoObUOv4GVyaM3BA8Wr47Tmaffr4fnhz+sdmN51wwasN6fJMaW4Y1e8D9jzF6qVZ+12N+2n4tMkdBPFmHeD3BJvhXR4o7gJWzqoc3oSx7uha4+yNeCSDyPmBY1YXJqoI0gl+TyLHFSq8XLxBwtI6uRnkkxHUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlB4tCKJYvukhLevB9WcB8uLtEBHFOD3C+/0QzfDEYA=;
 b=EqcydbrQsBtPbVkCaaopzsZU9l8y1l6GnV9Vn1pCkaElNR7GSojvzySMSiWLFPY5+6kaWjtcKpP1Xz4iDxzn7tIIeAjebKMRAAnQgamgqsPFyNP+8vHclpoKUuOJHD/QnYsEIxTWdX+aDxxHrF4pYv2qHJg1l8oFi7FgOXK0DrE=
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:37d::18)
 by DB9P189MB2003.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:37e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 09:42:08 +0000
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1]) by DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 09:42:08 +0000
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
Subject: [PATCH v4] Bluetooth: compute LE flow credits based on recvbuf space
Date: Mon,  8 Apr 2024 11:41:41 +0200
Message-Id: <20240408094141.720096-1-surban@surban.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408005625.57115-1-surban@surban.net>
References: <20240408005625.57115-1-surban@surban.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::7) To DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:37d::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1978:EE_|DB9P189MB2003:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	viDrF12Lqpal08IdZlvSkoecCT8t3QZr6AARkHdlRYZoCpZKo8YQyFf+WuItQwSe2il/eGAWkXBHLjTw994gkgfooNcVzL4trANMjCZmIPrgGvMtVWDAAWROgH4CL1m+tiFc5NWzkoiI0PnuICtYGcvwrY13WB3EpT5wFMZ49XCsVK/V0WLHjOvn3/vAE+xCfz1S5ytpb4xsKjc4qwOALeCunEPleVcoRa6k4oFYz8tdhFBywEXyEnwqG3d6TtQK+SRE21vCscogZwmVbQeJQhj4PalrtR0Y3W4uOXXeoxf3gwqMhxCgD/zT78WbFeJq8bKViP0pNfRQVxGaU3OS3FOfJu3mmibtVnViXrcjVsP3rBkPTRi4sD3zgpvV+YUTcd9RGrUwC5b3np5lGyHCuWvka4859VvVUfIUh+5MS+8eN5FXxq3mwKvcn0PCwJIaMfxosyUeKSRiFjP83gxBqFHBnUuBy1cER0SLDs/BhkQNnb7fnF5jpuYr8KOYsl8GCI2kYA88GxAIG0f6iZs0SL/jjg8JRt2/muFth1Pu7mHXd5vXILwnR6LtHhiE51kFYzcPIe/wz7T1CWchb8YGwZPGNhf6Tkr8NIA151uq8Q5rAz7y0Pj+uCzIqGnPFvl3BZjZCguohUZ05fGrVWOOGBmZ0i482yJH3Wf2x7eC0qQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1978.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?scri8qN6WnlWQHJVHtuJlIc8H/J+nBCS9328RT2j3opc16wUnKvKRnTnBnfi?=
 =?us-ascii?Q?VEFV+FbHwgnF2JGPcdsAKf/Bk3B+qSyHkkC9md0P4Z21E1I2WQDBdEr2wlFk?=
 =?us-ascii?Q?d9mdo8p/UR+qwArgUPV787Ul15UwcMnP1s4roS7Si9WNyxTO54gVUyLr7X7y?=
 =?us-ascii?Q?Fx85p/TdW9aVosdHpk2Lygip5OPjIxeZXjLCh2/aYuTLPS0ITIKCxrm4AxxN?=
 =?us-ascii?Q?a0bay1ih3+OInJPACFHecFoVSq0rUOAdvHvhH0c+k0USNjWaiCoTBlbwy4EB?=
 =?us-ascii?Q?pIJtkUUtcULbsjwAxn1Mf4hgeld6j0+EVgdR3A8miLhMnr0EDL7R6VCzLbYJ?=
 =?us-ascii?Q?NHyqZHVp9Llvd5y66yvDdaz8d/+nTgoVYOTKaItwBdpt4U+8hVn30fnexCZg?=
 =?us-ascii?Q?nuCScrfZeLi+qX8mwI0/dwXTLZyxb6qF7l/dJQ4YpTmnfLNCJthFVZ7dWG2C?=
 =?us-ascii?Q?oUdvR+qNhtxD1rwzhxFTe8kyI9Fi0vJmxzljWIrwF3tvTsyTSzyVxfrbQu0U?=
 =?us-ascii?Q?V6tyhWjG+qAaVzlsDZ+M6vzco/jFGXICcieQwRMyWBFnMHQn4XF2BlIj0KY1?=
 =?us-ascii?Q?/4y17B7gCgJBnJ9X8Bhez1muJ07SvrjI+r55dt6rFRCw0DblPOoguYO47Dr+?=
 =?us-ascii?Q?Xn6LOq+guB3UJx0kurM3h40mnxSe6ykkZg9++7SREZWoQ3mXXdeZjWpnKmK2?=
 =?us-ascii?Q?Uvixld0ZgkCfCtp/Zn2ASYr8Av0Q3p96EW6u/NCvyk3a3G/Wxam7ZdwE/YOg?=
 =?us-ascii?Q?emOKHtXJRnQ4rovukj/nmWvfo2gzPDcNS/rzq+bN/tzKyhNZpyj9dZ7ojo1e?=
 =?us-ascii?Q?94EF6vzHnUesZC9Xi4Bp2/WYc851FbHb4RQz9iCBHHqU0o0dBbYtyZJ/9tcR?=
 =?us-ascii?Q?TRglwpkEBc/dIb6L7ADLaKoqb8anVjfQH9t3OnofrOwSIoS2euvXJI65juyF?=
 =?us-ascii?Q?r3jSR05XybG7xP8ZJ9fATURdVaNc3ZKadTAXIpAzT3ZJytBeRW7whvxmND9P?=
 =?us-ascii?Q?O4TdObN+VY5ztt7A9h69euTkmqNtgBehlNYsg3jgGVakRSFtlt2qzHpCxKSl?=
 =?us-ascii?Q?9jFp/JPK99S340x1SdBv6ZzeodKyhHR3Mh9SB/nKj2WIPUzRI+ENUl/50q5t?=
 =?us-ascii?Q?wbKBr5Cy5wf7A8z9xuDrx+Zk+Um19HJjqFNStNz3Funt/eg3cjodAKXaVeGn?=
 =?us-ascii?Q?QSnBi0koXviobLoHbR+skPHm+qLPFIZ/7kzrlKgD+comW1J44JBfIPOGH1QJ?=
 =?us-ascii?Q?Kh5O1/kjBVrxHc3NCojSiYMfS7N4rSXJGtpA7K1NDxxPo6nHibP4gmuJZtSv?=
 =?us-ascii?Q?sIQ6/wwmep0q6g+3VS33s+nsUpKn39MwgmlGRCjVz98FFPXum3lkTahLz67v?=
 =?us-ascii?Q?mnPpBZbk2CPsNfFG0wsI8LVCD+PRpmeoAYPTjPHoCIxqcYUIkVHltB+wXYMs?=
 =?us-ascii?Q?Rt5OyM2Wm+GifGBqei3J6o59H+u80FhURZLHU9uJlIZW0EQn+NsMYi7l8Ll6?=
 =?us-ascii?Q?6oBUsrIuniCKa7fakdBzAU72aNaJ64SRFuWXCPx+lF8VUreJ5/OMYlIXVeis?=
 =?us-ascii?Q?FI5QXkQG+6slDeFufzQIiUKGqrcm+O5waV3jh/nqhXkjMtciIi2db+2rG2AE?=
 =?us-ascii?Q?idCwOI6PsCIILxNLgt30ZF8pc729EbZ54TpAF3Tbzaac?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b25446af-62c3-4462-15c4-08dc57b02851
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 09:42:08.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIxgbukc6A6kJlP3MgzN+iuCdevkFbkTYxxHfx8E+gdi2Ab0UwM8SuqZzIi/IJXGwIpeinn5BpG5xHxRb7rNmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB2003

Previously LE flow credits were returned to the
sender even if the socket's receive buffer was
full. This meant that no back-pressure
was applied to the sender, thus it continued to
send data, resulting in data loss without any
error being reported. Furthermore, the amount
of credits was essentially fixed to a small amount,
leading to reduced performance.

This is fixed by computing the number of returned
LE flow credits based on the available space in the
receive buffer of an L2CAP socket. Consequently,
if the receive buffer is full, no credits are returned
until the buffer is read and thus cleared by user-space.

Since the computation of available
receive buffer space can only be performed
approximately, i.e. sk_buff overhead is ignored,
and the receive buffer size may be changed by
user-space after flow credits have been sent,
superfluous received data is temporary stored within
l2cap_pinfo. This is necessary because Bluetooth LE
provides no retransmission mechanism once the
data has been acked by the physical layer.

Signed-off-by: Sebastian Urban <surban@surban.net>
---
 include/net/bluetooth/l2cap.h | 10 +++++-
 net/bluetooth/l2cap_core.c    | 50 ++++++++++++++++++++++----
 net/bluetooth/l2cap_sock.c    | 67 +++++++++++++++++++++++++----------
 3 files changed, 102 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3f4057ced971..bc6ff40ebc9f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -547,6 +547,8 @@ struct l2cap_chan {
 
 	__u16		tx_credits;
 	__u16		rx_credits;
+	int		rx_avail;
+	int		rx_staged;
 
 	__u8		tx_state;
 	__u8		rx_state;
@@ -682,10 +684,15 @@ struct l2cap_user {
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
@@ -944,6 +951,7 @@ int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 		    const struct sockcm_cookie *sockc);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
+void l2cap_chan_rx_avail(struct l2cap_chan *chan, int rx_avail);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b0970462a689..f3fc63992b00 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -454,6 +454,9 @@ struct l2cap_chan *l2cap_chan_create(void)
 	/* Set default lock nesting level */
 	atomic_set(&chan->nesting, L2CAP_NESTING_NORMAL);
 
+	/* Available receive buffer space is initially unknown */
+	chan->rx_avail = -1;
+
 	write_lock(&chan_list_lock);
 	list_add(&chan->global_l, &chan_list);
 	write_unlock(&chan_list_lock);
@@ -535,6 +538,26 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_set_defaults);
 
+static __u16 l2cap_le_rx_credits(struct l2cap_chan *chan)
+{
+	if (chan->mps == 0)
+		return 0;
+
+	/* If we don't know the available space in the receiver buffer, give
+	 * enough credits for a full packet.
+	 */
+	if (chan->rx_avail == -1)
+		return (chan->imtu / chan->mps) + 1;
+
+	/* If we know how much space is available in the receive buffer, give
+	 * out as many credits as would fill the buffer.
+	 */
+	if (chan->rx_avail <= chan->rx_staged)
+		return 0;
+	return min_t(int, U16_MAX,
+		     (chan->rx_avail - chan->rx_staged) / chan->mps);
+}
+
 static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credits)
 {
 	chan->sdu = NULL;
@@ -543,8 +566,7 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credits)
 	chan->tx_credits = tx_credits;
 	/* Derive MPS from connection MTU to stop HCI fragmentation */
 	chan->mps = min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
-	/* Give enough credits for a full packet */
-	chan->rx_credits = (chan->imtu / chan->mps) + 1;
+	chan->rx_credits = l2cap_le_rx_credits(chan);
 
 	skb_queue_head_init(&chan->tx_q);
 }
@@ -556,7 +578,7 @@ static void l2cap_ecred_init(struct l2cap_chan *chan, u16 tx_credits)
 	/* L2CAP implementations shall support a minimum MPS of 64 octets */
 	if (chan->mps < L2CAP_ECRED_MIN_MPS) {
 		chan->mps = L2CAP_ECRED_MIN_MPS;
-		chan->rx_credits = (chan->imtu / chan->mps) + 1;
+		chan->rx_credits = l2cap_le_rx_credits(chan);
 	}
 }
 
@@ -6520,9 +6542,7 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_le_credits pkt;
-	u16 return_credits;
-
-	return_credits = (chan->imtu / chan->mps) + 1;
+	u16 return_credits = l2cap_le_rx_credits(chan);
 
 	if (chan->rx_credits >= return_credits)
 		return;
@@ -6541,6 +6561,15 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
 }
 
+void l2cap_chan_rx_avail(struct l2cap_chan *chan, int rx_avail)
+{
+	BT_DBG("chan %p has %d bytes avail for rx", chan, rx_avail);
+
+	chan->rx_avail = rx_avail;
+
+	l2cap_chan_le_send_credits(chan);
+}
+
 static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	int err;
@@ -6550,6 +6579,14 @@ static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb)
 	/* Wait recv to confirm reception before updating the credits */
 	err = chan->ops->recv(chan, skb);
 
+	chan->rx_staged = 0;
+
+	if (err < 0 && chan->rx_avail != -1) {
+		BT_ERR("Queueing received LE L2CAP data failed");
+		l2cap_send_disconn_req(chan, ECONNRESET);
+		return err;
+	}
+
 	/* Update credits whenever an SDU is received */
 	l2cap_chan_le_send_credits(chan);
 
@@ -6571,6 +6608,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		return -ENOBUFS;
 	}
 
+	chan->rx_staged += skb->len;
 	chan->rx_credits--;
 	BT_DBG("rx_credits %u -> %u", chan->rx_credits + 1, chan->rx_credits);
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7846a068bf60..46603605cb69 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1157,6 +1157,7 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	int avail;
 	int err;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
@@ -1192,28 +1193,34 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	else
 		err = bt_sock_recvmsg(sock, msg, len, flags);
 
-	if (pi->chan->mode != L2CAP_MODE_ERTM)
+	if (pi->chan->mode != L2CAP_MODE_ERTM &&
+	    pi->chan->mode != L2CAP_MODE_LE_FLOWCTL &&
+	    pi->chan->mode != L2CAP_MODE_EXT_FLOWCTL)
 		return err;
 
-	/* Attempt to put pending rx data in the socket buffer */
-
 	lock_sock(sk);
 
-	if (!test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state))
-		goto done;
+	avail = max(0, sk->sk_rcvbuf - atomic_read(&sk->sk_rmem_alloc));
+	l2cap_chan_rx_avail(pi->chan, avail);
 
-	if (pi->rx_busy_skb) {
-		if (!__sock_queue_rcv_skb(sk, pi->rx_busy_skb))
-			pi->rx_busy_skb = NULL;
-		else
+	/* Attempt to put pending rx data in the socket buffer */
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
 	 * available.  This avoids resending large numbers of
 	 * frames.
 	 */
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf >> 1)
+	if (test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state) &&
+	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf >> 1)
 		l2cap_chan_busy(pi->chan, 0);
 
 done:
@@ -1474,17 +1481,21 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	struct sock *sk = chan->data;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	int avail;
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
@@ -1495,7 +1506,10 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	err = __sock_queue_rcv_skb(sk, skb);
 
-	/* For ERTM, handle one skb that doesn't fit into the recv
+	avail = max(0, sk->sk_rcvbuf - atomic_read(&sk->sk_rmem_alloc));
+	l2cap_chan_rx_avail(chan, avail);
+
+	/* For ERTM and LE, handle a skb that doesn't fit into the recv
 	 * buffer.  This is important to do because the data frames
 	 * have already been acked, so the skb cannot be discarded.
 	 *
@@ -1504,8 +1518,18 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	 * acked and reassembled until there is buffer space
 	 * available.
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
@@ -1731,6 +1755,8 @@ static const struct l2cap_ops l2cap_chan_ops = {
 
 static void l2cap_sock_destruct(struct sock *sk)
 {
+	struct l2cap_rx_busy *rx_busy, *next;
+
 	BT_DBG("sk %p", sk);
 
 	if (l2cap_pi(sk)->chan) {
@@ -1738,9 +1764,10 @@ static void l2cap_sock_destruct(struct sock *sk)
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
@@ -1845,6 +1872,8 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_destruct = l2cap_sock_destruct;
 	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
 
+	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
+
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
@@ -1853,6 +1882,8 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 
 	l2cap_chan_hold(chan);
 
+	l2cap_chan_rx_avail(chan, sk->sk_rcvbuf);
+
 	l2cap_pi(sk)->chan = chan;
 
 	return sk;
-- 
2.34.1


