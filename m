Return-Path: <linux-kernel+bounces-134683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1754289B4F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA938281419
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 00:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BA617CD;
	Mon,  8 Apr 2024 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b="tgofnaBV"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2107.outbound.protection.outlook.com [40.107.13.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6E7EB;
	Mon,  8 Apr 2024 00:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712537811; cv=fail; b=L8vsdecLuuAg0LMw86ullwC6b3sEEDWbQDiLsDH/iBKhKZUur3z/e0/bgGxvvqFWn2WmfKnNy2jM6UrmQ66UtI2s64tToz4EM2zu+kGTpz4cpmJ7CjWB7QrFQtFJJaVkD1ae0Tdev+AZtmDOILR1TjwGMME0E9mqWh7Rw889GBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712537811; c=relaxed/simple;
	bh=/L5gzQmio6UtTArhEiAMDlSZ/qqNyi0dPMIx23xuqKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q33GyipLnEPUUo2LVFYDJMqyEFxce6XlMGRGmco1+FwRTWj5r8wBoUGeQSRKHrr8tKgw+TP+7XaCBDqf1iz3gIhHrvved3mElPwcEAQXh1pHBZiF8/B819ccwgmz2gnZJoXaYUWSL5Q/X1FfDFItxjvYYpVmodEH4SxHLnfmDEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net; spf=pass smtp.mailfrom=surban.net; dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b=tgofnaBV; arc=fail smtp.client-ip=40.107.13.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surban.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkZvn6PreODug5cK4vLJeOtmrYsV1hhpIwMJMkp0Uz7c0TRc6h0U3gqC+Z/5Hvx+c9IFKBqpl0GMetpmweclwD2wSKyWwYGhSjkgzu7pqkwulthfCgGghnJvtMlAzSp8QA/ZKb6vwK+B1XPRWKpDVkb/ArgYEo49WeTQX29dCuF5wmrrkZC/r28bJORT+maK3fBAuybeZFbZ5/kI5u3JOUjoMtvkuDb8+U+F8felGU1IPzb7hsgQbpUtb8w7DZTwaZpldjKfTfm7IBYSrDmtS3o92JJFLgDiW2tD5/zLHeB7ZnUe+cHAqRPDr3Bb5uKgM295dSHdncxdFyef3f4Z4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7GxFnwvip51DhGBVsDt1dbJQTp0DN4IMzw/GMos/vg=;
 b=BGHwo/fzMJ7LXRMN4r+G/Avt4wpygl4ORQjrfiTemGnV8iUhEyWFzH07JelQXY36NHSZANrOjaQatjFgLY8N5I11+Pa2hYsZUYlJNGsD0FvLZrbULJwVLkA8XaPX8ANUP4+ZK2dJ2FCxXVlF3b0qlV4wV5YRqMMh7SDmvvBWMacYTZVlSBNT/aCkr3PGd7AK3OhDWO1XbNEZ3ARra5aWcvWa0miRMmfRBvc9ae2bFKZAwkL+TLHRdcC+NrWNrx/glHzeh/zO318+UsYGk1G8V4Tbef40E7EzmuSxtzsHiM5eWMBvqcIMUY60AbQ177cS29/wTU3MGIVAKsevSsrYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7GxFnwvip51DhGBVsDt1dbJQTp0DN4IMzw/GMos/vg=;
 b=tgofnaBVl7vjeN2mif3ybzQhVPk1ZEyy7/nlcXkxRhyUjac0hC3wk1wF2uTRcQ0Lhc2MnoTIv3MBjArRyP4ggs3jmg3wVbPyaEOBDupF6B5UMz+0VKx7PzzjpeDNJcblarU+YUxdPH9E9IF3/+p0AbLycLjtmA4S/H5us/2wHYk=
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:37d::18)
 by DB4P189MB2311.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 00:56:45 +0000
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1]) by DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 00:56:45 +0000
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
Subject: [PATCH v3] Bluetooth: compute LE flow credits based on recvbuf space
Date: Mon,  8 Apr 2024 02:56:25 +0200
Message-Id: <20240408005625.57115-1-surban@surban.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405093834.63666-1-surban@surban.net>
References: <20240405093834.63666-1-surban@surban.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0032.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::19) To DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:37d::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1978:EE_|DB4P189MB2311:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NSTB21apLzth1aaFSnzLNzke3EKGOnaA8DCUvQ08lCM8ofF5pPnfaSMJKd44ZPGbeQiaOFHa0voN2kHmt+GCvzTAW469cbJOlUcvI/22jksViA2tTwaz6sx7CChYzE+OzcjqHFZClLd6n9rn0MzkduxR5jJ+I0TCMr2SCcmcnWPV0JP6IcPmSL+M5DoU1/b3P08z/Wq6Z+22MJlzXEjt7JXjXlyMSgYmcSGH79IoBtC4Jftu2VgnDnJGCNxoWYmDlqcskTcHA4RZRcx5uyD9yGMWpwouixsmb+a2qwXMoD2tb1foEnqaCHixowzI2t/uha/M2nHdEGoZ1lWUfFgPQ1vq4YMYeXC8SstJhY6twS/dtASa/FXGr3cGBTa7l7gAX05NLNDqboKeCoLu49/0BHZsuPvSxDrlKaUCJD4J3gh9sSGomOjdM9ULBynUsGUT8MTte9fnUnl48VIzrR1dByfT4VoD6FZKDQ8PTusa8m/NJoRFBWcQwNUPUSggRsnnNS0PXJXkzgN4/Ch3Fdn5gq0BWwBEWdN6eOAgoP+Yx+SICNiHEHDshp2zZqWbHTUKKfUgrVcf7PgZxkcVELLezRx3mfentHU31IxSbZFv9wyeDf30oeT9TxTCyK6u8F7Vygjd9sAbYlA0WSNM2UnHaJTZmLeEM3gWTQVaQN95iPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1978.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KVNJptB6FcthYaMuwoyJYMDjoQwGGzo5GNZXKoiW2eajVuXPP6ADh32bNL+O?=
 =?us-ascii?Q?nyqcCvz74beZe841MR37xMnrtgFhYYzrDeoMUDGLbXfxE8TFn7qbCqg6oB+z?=
 =?us-ascii?Q?iQpZl95lQYRyHI8n3zu9yjHHVrZsL76BbzSdORMFLkV8wr9jhAJaZuSrCcf+?=
 =?us-ascii?Q?rQqFOM1zVeTk5JLFKhuactnr97Loe4YXAhi9sLDs/6rmJdQkR73PN/d3XNHg?=
 =?us-ascii?Q?4cpaQy4QPaN1QMqRP5wH+02tQaIb3mTSNK8U0A3oLqloXWpzWvx/xR0vf5HO?=
 =?us-ascii?Q?ibt+hjlYtZznYaAoKuwo2NJTrq9qPNAqNVN07PwjzEVUTnarjLYcxBsAkJjO?=
 =?us-ascii?Q?4z/znfrRM2ZW+sTulGtjUq7FpT8jPPbuHp7DUNcBS6uYcvb7C0eBDATwNJSI?=
 =?us-ascii?Q?AoK43i8SpPNWMkFcC/7iMNQnQYZvKj3YZ4thFzkh3TYwnal1RCQDREAEDfwc?=
 =?us-ascii?Q?a0t00GeaGtoc039VDTkO3DYgyt3yO4u7I0AOXGEm8kx6New72bfKzKeeG9GE?=
 =?us-ascii?Q?UR41p+SRkLstzbMa1d0EYzKmy5fbj/P74PMjdtSFNOAr4wwTQnMaoO87IgjO?=
 =?us-ascii?Q?1O2vAKXpg4VUg1/zwvk5+wnqL4XRhyoHU+5Q5lYjI9ORfnjEWVWrqNQD5ufk?=
 =?us-ascii?Q?/x8BY+GtXHhG8HFouRhm+vZMXpLCPOuvyHiOLxYhzLW5Fy5rjSTjOlqWwDge?=
 =?us-ascii?Q?yqAGNWjZyZ1mOAh3mImRo1a7Py3pxzl4z8Uhpw7F0ERxRR3Tl1CGDJDzBf14?=
 =?us-ascii?Q?hittUTp5+C5d3yVFWOooA0SQHbLc/5IY7S6AYodRPUeYbCOb/15O9xFppupZ?=
 =?us-ascii?Q?MtjJG5EiehyDE2iT818BIdXaie1bfY2AC4lERyDBhUO4fj5Fjszzuh1MvH7/?=
 =?us-ascii?Q?//5jVOqgI4EN+H8zlpAlD0XhErlwx0fghNT4VO7FrnhWM373Hq6Oc2t9/+PS?=
 =?us-ascii?Q?hLJFvvJFtNZlbyWuboSyddys+ot9xsIHibXqGBzPD15z4XDUH+YW+UUJTIVJ?=
 =?us-ascii?Q?9kVmtCKpVB+WzelcKlwVZ71VzPLr59TDqXS1VyodgR0G9WIYJpHkMirg/vPK?=
 =?us-ascii?Q?bCclpqV3mCnodmpSO1iJfBM+xEpOvOF4vtZtniqJKUcgs1m1uLw1jHSNKRm1?=
 =?us-ascii?Q?j+J84jXilJ3QG7XHmbFlWPpZBhGFr9XMO9FuQpQ7s8O4IfoM/gLbijMRTboh?=
 =?us-ascii?Q?N9jn7BDlKCTiYcbf2i/hOUQ00oueVOsqnDL7kGbLqyMArSyvCg1nP7ttU23F?=
 =?us-ascii?Q?vJkBfnaokHhMv38Rl+E8WxBnOii+/RrWVgwDvT3IWR5+4c1+d3JGDBFOjrBe?=
 =?us-ascii?Q?BQOcNzzu4jwRq/HGNo8mWmTR0L8pwCXjIkgreRflkcbJxQLfjR3eLMeC7c4J?=
 =?us-ascii?Q?eKM6VYwnIyeH8S0yzuvmbjfoe9z1psP1aKxaWHwj7S+ykAjVdcG+jELX77ws?=
 =?us-ascii?Q?sA8OCsoy+5MNTl6f3/V/egP6DhdfD7QPwzU23tbIt8HgjgSa0O9Qs0v6Hh0m?=
 =?us-ascii?Q?rtAByxoWzubmZV/373GfoVTk/cmZ/Juwh96nmWMFc/5KXMk2sGnw2lvupZet?=
 =?us-ascii?Q?OHepvU6UpDA3OBnOxiQLdDhBovcv+o8edYb72Ft5n/Z2r0scev9UJ+F6qUCW?=
 =?us-ascii?Q?bYC9n7NO2EKJP/bwLDxUqfbevqXidX3/wFURXUyyv3X2?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c4d5d8-0621-433c-b969-08dc5766c322
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 00:56:45.3352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEm8aOLn2WmY/E/lh1owwRragEaxAsUMlcv/0VeXHLV3CsvriWjHt741BWZga/ZPb6pSlxli1sABtFsoinbK3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P189MB2311

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
index 92d7197f9a56..8368463ada72 100644
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
@@ -943,6 +950,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
+void l2cap_chan_rx_avail(struct l2cap_chan *chan, int rx_avail);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ab5a9d42fae7..1b5f5c3c2b41 100644
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
 
@@ -6512,9 +6534,7 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_le_credits pkt;
-	u16 return_credits;
-
-	return_credits = (chan->imtu / chan->mps) + 1;
+	u16 return_credits = l2cap_le_rx_credits(chan);
 
 	if (chan->rx_credits >= return_credits)
 		return;
@@ -6533,6 +6553,15 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
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
@@ -6542,6 +6571,14 @@ static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb)
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
 
@@ -6563,6 +6600,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		return -ENOBUFS;
 	}
 
+	chan->rx_staged += skb->len;
 	chan->rx_credits--;
 	BT_DBG("rx_credits %u -> %u", chan->rx_credits + 1, chan->rx_credits);
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ee7a41d6994f..8781f67f9c84 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1146,6 +1146,7 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	int avail;
 	int err;
 
 	lock_sock(sk);
@@ -1177,28 +1178,34 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
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
@@ -1459,17 +1466,21 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
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
@@ -1480,7 +1491,10 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	err = __sock_queue_rcv_skb(sk, skb);
 
-	/* For ERTM, handle one skb that doesn't fit into the recv
+	avail = max(0, sk->sk_rcvbuf - atomic_read(&sk->sk_rmem_alloc));
+	l2cap_chan_rx_avail(chan, avail);
+
+	/* For ERTM and LE, handle a skb that doesn't fit into the recv
 	 * buffer.  This is important to do because the data frames
 	 * have already been acked, so the skb cannot be discarded.
 	 *
@@ -1489,8 +1503,18 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
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
@@ -1716,6 +1740,8 @@ static const struct l2cap_ops l2cap_chan_ops = {
 
 static void l2cap_sock_destruct(struct sock *sk)
 {
+	struct l2cap_rx_busy *rx_busy, *next;
+
 	BT_DBG("sk %p", sk);
 
 	if (l2cap_pi(sk)->chan) {
@@ -1723,9 +1749,10 @@ static void l2cap_sock_destruct(struct sock *sk)
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
@@ -1830,6 +1857,8 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_destruct = l2cap_sock_destruct;
 	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
 
+	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
+
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
@@ -1838,6 +1867,8 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 
 	l2cap_chan_hold(chan);
 
+	l2cap_chan_rx_avail(chan, sk->sk_rcvbuf);
+
 	l2cap_pi(sk)->chan = chan;
 
 	return sk;
-- 
2.34.1


