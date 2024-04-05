Return-Path: <linux-kernel+bounces-132824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1129899AC1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC5C2839A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD2B16ABE8;
	Fri,  5 Apr 2024 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b="JVKrHQep"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2134.outbound.protection.outlook.com [40.107.104.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C7716ABC2;
	Fri,  5 Apr 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312813; cv=fail; b=MrRoXKBua1Xtl7lU++b0T7gq8LJm3ZDwpyv1zSetl+WT4DddSSQKhmDtQdyj0U22ebuEs8tT422T2kJnLcFFh+BnJ9B6oJ8vmVhSKEaTwYyJ6oZ3igzgWvhY9EMV3l/h85aXDNp7PF4svr7yxzIkvEc3oWm4Kg2Plh7CG8YogW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312813; c=relaxed/simple;
	bh=aEyL+MPQYt5dq+gW5C9V2wJPUcM+yHqaRLEpbo3aAow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n6F7Otlr+yjrfKNUzgYPn+mPy80TL8LfxTCGVrQgRsRLxxIsgWKyuNUfPPXretY0ZRlZfVC3Rp6oSHPIJneNeD8Yu39g5rmEqDygwMpDwaGcaCQd+dN+Eo3293XlY/a7Xsptu82xatiKx8XQKwMOJzASvlGCuSQ8+3P6oAN7eIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net; spf=pass smtp.mailfrom=surban.net; dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b=JVKrHQep; arc=fail smtp.client-ip=40.107.104.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surban.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeetF/pupzK8r8UKF78cvLGzJ/pYMCLmguu+DhXH/+L3EoDlWzGBlOC+frYjEtR1NLshCjKEu7PGnrbeaUfSnPFEFGe2wQFZxrV0l/+CQ9AZ3gp5X90A2dETcxr2yTvVje/KND6rOqtNW/cT2Z8Wjv3JSXi8WXSO/teDEddfL17a4mILf9+O24vORDrpPK2jDl6sRjidXbk38JdBNlblwJKY8P/CAGezxQ0iAtVOD0bmS+0kCM1mGLAQxSZUo1msGjBXOt4kTMRykSEvbroz0nMMetX+ojpd13xEjy3b2ZGOLrPZPT/TTyenQUmS5BilwKOcgQj0YkMVtLZ+h4V12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyhKCcFWctkqTiIwqcoZipH5kke9qN4WRefSX0gMqhg=;
 b=TeEBP7tVYaXV8DvYAQGZJoOGc402lZqEhZR65KCto105SjSDBDoYe4wDUYHvoo2eaAqoigj/ThKyURbPONAFm5r8mZ50+hJXGKmatNZLtJt4QA1iDJtRfuvumC03oJAjpkv6h65kI8CXFX9fAJzS+Dz5MOYuc7VhUIhn/WcrhILlzg6R5YfTGETfb4lpFYf7qdbeQHoQtf5YF8RAAmNw6jr6aQKljxtPNQfjVMsCuLByX94yhVNSrOrCSzAeSaObO6LyHGlHH/AXDHM0pkWMPPBMaKF9oP9lMWdPxhbQuvz70IEZbJoXk3k0oUFChBu6614lfyDAIeaT6H3mxzL+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyhKCcFWctkqTiIwqcoZipH5kke9qN4WRefSX0gMqhg=;
 b=JVKrHQepQGTAnzdrIJXmDdqiZoYFVxr9lbANa17PxvIXixTyAV96RWdrTa0YYBaMqb/jDXPb4HS2rf407Y82CjEAsFjHQrysLbgIKsw11YH1BiS2zVE3uaDqBB6P3BRBbwl5vF2mzjJMaFQ8YeVWSwdxMEmF4GkGTHiqW0sR2jU=
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:37d::18)
 by AM7P189MB0712.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 10:26:47 +0000
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1]) by DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1%3]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 10:26:47 +0000
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
Subject: [PATCH v2] Bluetooth: keep LE flow credits when recvbuf full
Date: Fri,  5 Apr 2024 12:25:51 +0200
Message-Id: <20240405102551.114999-1-surban@surban.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405093834.63666-1-surban@surban.net>
References: <20240405093834.63666-1-surban@surban.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0107.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::22) To DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:37d::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1978:EE_|AM7P189MB0712:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cSejCZTz1NWcSxfq8n0BZXeSJzmcg+RC2H/WsmKjH2BhAKEUvQxhdgd4SWVS04JB/Oa1IrUf6Hayd5Cp1/4UKVjC7JDcVIhXz90HHvqMQpVu5i4JAEJv2jpO+8M+BrtyT0Jpt0sIrUABKnYR9sigVNI45QXJXIIxvEX4twRolmlPuNUPuIccQ3iiE50uT9NHeLIZo0p+b8AhNAv1NvlUcsmdovad7y/m87BVKA4hShyKyWePAbEXuKfH6KIlwN3NLsiOLFg2L2ZRDNYahJgVIARwVJizB0XHaAEB+XV3pszcJFa9cXqg/l5UNAGe9c8TrHePGwOoqgKNAlpqYBla50pWv26qgXGiPFXi0H80JtV2XOFyopE5MNTJKF0dHtyNWTVnlIhVd9T+L2cXjRXAPJmowuurmBU0iUqi8d1OfzXxUXmdbglQQM6X4wc4vIT3NPwTSYLA6+GENTaxvoWMUVs9qooeeZXCYVMET2mHqHhoNp4hxCYPJiN/UEXwsg+78d01oKQTiLz6bpVAbuZ/VYqSH195uRTKyVp/i3FAqihmulns78qSbjWjgR1ZddkgT5xWxDbnJ36hDKLTU9QRoXJQB2c9oQLtQGxGT+KcDZGQjd0xeVOKrsuCFI7YvM4IDv+ER+yDxj+eYyW/BwrxMLrVRRnY2twTo3nH1bUvu7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1978.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(52116005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zL1PEnkEX/efLkg6FHLuZGab8txzpjQIePCj5JLy0DduYxuNykk6+ch01VJk?=
 =?us-ascii?Q?ZGQe/jdvbfvOKa9RghZLjzLqVNJ9PdAHOXAxV4PvWXl7Nw7Hx/YpWhWZW2K6?=
 =?us-ascii?Q?NFLje+2Omtno9SRlJtt5fbxH8PXx9daYbG2zgi5/+P310ltUZDdKhJIYRFo2?=
 =?us-ascii?Q?FN1XAVzH/SHH2C+v6M2By6ARZ6G8pD6T+MGRmTAldcdbglsGZpAD97ocTGhs?=
 =?us-ascii?Q?JMpnMN8jOTND8a3QmlS8kQQfa8SqMF1Gyy7CIcXi514P4Nth1gGesZEwM4eN?=
 =?us-ascii?Q?4HQmotnDCj7uR93z23kaSofzWsw+reSC5d/wAFvmrTq2DdSJ8bpHFQPC6v2a?=
 =?us-ascii?Q?baUNG3W5eQOOY1fc2Cm3u+TbKjw1w6H1T73ABNFJufT7EuKge6DJmEtTTzSK?=
 =?us-ascii?Q?QKKAa/6FSN4fKRmZ1gPaJza4LHxgHEg9LtiBEXV06PjbEovUbUVAbajT5gzs?=
 =?us-ascii?Q?AMKqUkiOVAUd6wGEOv7kL53//D3h6uUUXgaTEbL58uiE/9B4QsmMopgqzva7?=
 =?us-ascii?Q?9XhD8VOLrgdsEC2+COK2L8qn+sld63p05leJuxdg6zVEtO0qeJlTbOLnvk63?=
 =?us-ascii?Q?tS2RthXRkjiG5llD3z+Mt7zeCtXctzdsCt+hKPE9bVwZlGom3PKp69wFqKSj?=
 =?us-ascii?Q?eqvcS/X0vvI9A4H0gxhe2g75JXU6hIgR6kjFppfjvWl+d1KVVNQmzsJv3h1F?=
 =?us-ascii?Q?hJ3ywyIKdtq5tEMYtbvCuTmkGDNo7mmnILKhRQqA6xB+KVu9NntMzxVSVxvk?=
 =?us-ascii?Q?zeeQ2+xFNQJB57PJwkBa/iXVURWNigBZhxoBMnkZgTNdi0qbqRSUXSWCKDe3?=
 =?us-ascii?Q?5B3d4OHrXtnOpDSsWJRUDwzZbqP8qEad2CpKdl8uxnWnpFD6UT202Nxna7bt?=
 =?us-ascii?Q?KDfxmEtP9iYijaMv+jq+1zgHdVSNWzbtOg8gBXIkrcQ9LtLzj3VzUe44TtIb?=
 =?us-ascii?Q?0EKB+M/H2spsoPg/da85fULWQ/+KKldcaO8Lbg/hxOHRhNb41w60Kq0IbV9b?=
 =?us-ascii?Q?harJOVsSsw+/lhT9SCMmX+VI/GWxD++wjhzk0NIB9VkuF//OBmUYRp1KAzxW?=
 =?us-ascii?Q?pKTVnP3DsXYjMgezR65M3cydaVBlMDWiQ6MkzCXF8gAQFIuxoMJJPdPm0Jy1?=
 =?us-ascii?Q?LPZfXGEGejsTr6f+G2EqtAj3pFXIAA+7IRTjb5yLz6FAPm+Pf92lWjbqOhSw?=
 =?us-ascii?Q?0l83h/QV3hGqe+BWrH5eTk1TNSTuQxdz5jr+oWItbX2Px+ZVIlfSGbuus31E?=
 =?us-ascii?Q?R08FN6C1AJxaazkYdq+uE1Qrj9FB26Lu2xIZ3NQEkHOFIE5IIlAQPx6E63oA?=
 =?us-ascii?Q?g/aY4NMtZzWrfAbsi5SxXCFnEtZoeX4sv0xZp6m0Hm/G/D/Vos4B2HDI9l9v?=
 =?us-ascii?Q?6QbIli8yVV0Xa0fTdARZzVgsZdg7e3daZLG75cYzsHW+BwDUV7SjtUTRbFNi?=
 =?us-ascii?Q?UaCDQJmLkPYtfFbofN4J7rJTNlarAPcFC21JI8U9Uv1itxFaITPtw6OZnmxT?=
 =?us-ascii?Q?F+KGDvvHMXuS6zHquDZpT93VoTdf5JLYU6P4CFyBtuVuAA/OM0zbozEESWWV?=
 =?us-ascii?Q?s8b6x8c7L/t/UAKoG1ezgS96kLlsPE8tgwjkpiQ7wRfz4dqwq4EUwP3Mzhgd?=
 =?us-ascii?Q?/hpzYzJTOz3j0qcQxvpzLRe1HIiByVLe+dnKMADX+zAO?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 355912fb-fbc8-4744-a550-08dc555ae5b3
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 10:26:47.0700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5ukR+LD1dZuoP5sWu2YAzqbqVow/0AUb9Ij8xzjtSo23okTk0h86sJCTcdUY5Z8du26cxv3g1uLu/C7ow4rIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0712

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


