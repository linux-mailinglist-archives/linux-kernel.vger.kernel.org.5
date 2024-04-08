Return-Path: <linux-kernel+bounces-135376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557EF89BFB0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C148D1F22198
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B807C0AB;
	Mon,  8 Apr 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b="T30I+gQH"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2109.outbound.protection.outlook.com [40.107.8.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F4D76EEA;
	Mon,  8 Apr 2024 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581108; cv=fail; b=O6LJtHC1gB4tf3Gn8G/zh9Apu2H4Exwruqe7Pirc0R14GJf1aKRD0H4I3QLGS4aVaoCYf4ksVk/Z/DubcyH4seumbiQMj3NP+JbmSMlmf7QWQO7OsuwTA0qj6Zygg3TmJe98jdfmjSIFm6TRNhdgGQUjPfTennOp1gv4SKif6Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581108; c=relaxed/simple;
	bh=mIQUmI0wSojhPgo+x2qcdTWCPz36+ikTT7cgQK7k6qE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LlnoP0rPuuDfhuwQhwyvQnNgSyqGNMnYyqfoExHj4XFhDLU9cxSwc5/OvJwryHaKUmnJ00GyZ1ioLVPEkqkrsi0SPFeZfb/42/9/g0v1JDErnyHr6MaKmOsOyYvKLresHmPWfkLxMHa+DaLbJTiLycpmpiVvjaTI+GIVuUHAbZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net; spf=pass smtp.mailfrom=surban.net; dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b=T30I+gQH; arc=fail smtp.client-ip=40.107.8.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surban.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zi8py+kM+aGiJzBhIDc8NASImXnTLZioW6ZgpzPxBzNDs8/EuRHv4ZoGXZMMrgjjyF0/2q8rwRP7D29HBoh5W+gukgViwmTf+8+ZHoeUkg5spjdKFK4KI5n03QTg9rMhkGa93fI/jaymwMC4yfRNE/kUWTNne/Kjdms44XsVdGoNsd/HTqUJhxbaJQtFSEgWhPRbwq7R6BES9klYiR5mf2UdzNvdWBHSC8V8ccvTJabrWwVTYeW3oAXmGG+LMz7HCYZ51PlWC/oUOnyP1D5eppiNtBjTU4iyDEU2wF0ke+fORxr+8jajpowi1iGMp4gY1YSBv22T5AGJdT6gElE6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvFUdtNk5Ck/mch5I2FCtXY+8mjsFjAZa4K0Njl9cgM=;
 b=Sp3vJJgSwH7qOpKCHp/B5qiAp6Rln8922vNtRphLqixqGH4EBDdxt+IscJyMUJZXBBD0AI/AWAERRS4Hy4bH4fLISimoLSEB79+tZvdQaJ3sLlvkhP2UGlhhhEDfA/Mc41B11LA0lB7a5KRhlvzeEVy2NOzOt+zXlTLhp1HSxZlFbyYC9NdUKANApNdYDpvQmQwcaGRi+s+TJrGfFDpOe2BA0gfVwpiug9KJxHEXynx+epcZTyDcVxKeqWoxp+/qnM6mQz43deQeH/H1mrdxxtxl06BxqDJlSL54RMhhE7E62JOolxdVkzNFuFRhjvn2duxjSr1Ck7vd91/kXpSASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvFUdtNk5Ck/mch5I2FCtXY+8mjsFjAZa4K0Njl9cgM=;
 b=T30I+gQHJHUAYWrEq9Cdw8OVfAjDN58/3lvDb0+1BHnUwsD4c6yCu9iLiTr32OMkw6oN5jkaI97NZdXBXORC7DQFk27IDXhtYlELgrj2bdIF+/IXhxETc9yMRkhxmt/u+e0m0V+feijx7Uwss6NH6ysatFqSrMikfDvMpbZY9bc=
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:37d::18)
 by DU0P189MB2091.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 12:58:19 +0000
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1]) by DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 12:58:19 +0000
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
Subject: [PATCH v5] Bluetooth: compute LE flow credits based on recvbuf space
Date: Mon,  8 Apr 2024 14:58:05 +0200
Message-Id: <20240408125806.12682-1-surban@surban.net>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:37d::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1978:EE_|DU0P189MB2091:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EJQsWCV6rO4gRQ3ERqUUcZPhTCBekMzJTKpMOr1O43ilWuKUAgYIYEHpTSU+SruKsptXkKHziCKV7kLlo+EpSIZz3wkJ7K5yL+KzTVd3TcMuGGqA+dUrhbQNt4xInsk/HHHQBPaIJp5CM8m13Zbd2PjU1Xt7n0Ht0/t0eWXEGj4SvtXDT8P6frSBJO1Fag9I54SK63T61LhBKNfQJaqD0G31/JN5rI8HFDd8ujsecto0Y+rKVTuL7NYqeoWKy+dG/m28Tsy5AoxV28ps6ltUUDCfg9/j33IrfOPlDDmtJIYW2qkoq9O99GV1pnjZidi+2Fd+lwVRbU63wYi0HAUr8GJYDpbeGJUlNsXS5fY6N2wx85S3j6eAQnpicDjMf58hH2T/9wKh5YSYh/+nqzpGZGSZg7t9Qtjs1FdR6nOpW0d4PX/9LqEzOK/I4lWiLG71KMUp7K9YyLeDScaHQv2iYiuqu5ttmZlQ+c+tt+lE88fXJciFEzinldFY+1L9LEOzvOAGPI4fZo4sB3uHntJUIiBZJlKvdjDaiqIhKU4LaP3i2R0PdTmKWuvGHiD781VDhASbRmF/7C/pu/usIGz/xOK1Qc81rEGulS1AXZUrfPbgG0B6ZDGwNEhuwsOhhr0p7xCXtqoBL4UPt6tvr+2+8d3OhBkOKEWQX6q0MA8AhGA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1978.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xmIcTC92vQAHLjG6ZKAjPLFHDzOfhlU2bvh/bxQvkOBFHGiUszIWY2sBSxcM?=
 =?us-ascii?Q?TK2NEexTav+O/MME7H5a2g474o14DoScjs4/SkML8izBu9oQBRdheaTKiZCN?=
 =?us-ascii?Q?HnjtouM8/mcNQ5EuMr+ESxPg6txioqA6gVO28BlgT715rJfzKFVSkUe97Ulv?=
 =?us-ascii?Q?4Pdd6tBeMFBCBdBnWtm3X8wWsvRHzWhZpyc+5EdyxOIxG10IhN0YIT8ZcWX+?=
 =?us-ascii?Q?y+qj/0pJ0k93tsgMfR62pT2Jb04AcFNUFHjvpgk3+5/si6btrou5oPzr5pjx?=
 =?us-ascii?Q?mdqm78Zmu31r5bm/3kcC8F9PxR7xHNVIqs88GkkCvRZnsWO0+qd+1ZPSQvaZ?=
 =?us-ascii?Q?AqN14T9eDItnCERJ2dMTlgGf5A7zWEtOU1XiarX+OMi+fuoZnS3ZNVd2af95?=
 =?us-ascii?Q?7lMIJNdsCZvtocE6pWihdOiuY0HpuihJLKbJYgIl46lfWwLE+orVyDVUvjzs?=
 =?us-ascii?Q?RC7x8trkYpTP0ht/WlfaQ5umYQRU5Fht9zyPzoUtrFdsWTaJSNNlfgYhWnc7?=
 =?us-ascii?Q?MOUUz3jOIQimpPnQjCsUoYqe3csHgPGo/kNXKOA239lRjfqu7yMZ8UVkbJlf?=
 =?us-ascii?Q?kV3CpJpcNul6GlIwOzYokiJrLMVU8hituoQvr0tmg2812YOVECs3QQooc9c8?=
 =?us-ascii?Q?sk08sz6TI7vj1+h/fZtCeBEqh4dDeZ8aYdnWmOnawquDdVXOyDE59u+bMjtR?=
 =?us-ascii?Q?65zU2zzRdS19AG3g8Agtw3j9CPmBZYbcBWI2UiWoV5oCyJXTS5IAomIndDYI?=
 =?us-ascii?Q?rvud/NO/i4lcG/bTq05kQcHv+WVxFC7b5OoDiV799+4CnGBhRXT5/RfQBiaB?=
 =?us-ascii?Q?69AUZ1NZ14E2HSmsJPBAVZzzfkwuvBcM3wnsN1b0RNR0yAnf7tvoWytssnKR?=
 =?us-ascii?Q?1Cv9sizX0Be9tZuDcQvjCzjFp2x7ltP8CcC0bi8hSgjpgr+6zIekkS9UwauS?=
 =?us-ascii?Q?NvKW5N2o5wwzzWqfCuQxMRIwKjkGkrB5acG+mrwvFnRPv4Acavp+b8stmKeI?=
 =?us-ascii?Q?L6gmK3NlZH8sr7YOYkGKYni6IAKEFbHldWPAR3nirYGQpyU6ICa3q40RwBMI?=
 =?us-ascii?Q?woQbpNtFDhHl1EPypMUbytO332Rbg5Djj8ah6Gw7LpPCYh2/hwlgJ/mmAIGI?=
 =?us-ascii?Q?iPVG1vdC5a6jx+I1Zl6Ht8N0fMLNhK8Gmwco+v2HLJwMqBFBajJ5XEtoXx/q?=
 =?us-ascii?Q?gBz9cVZ/D1TCnbMVafc/Ca+NdC3n62XCIJQphcjAtHd4bQJpP5tN8x9ybgEq?=
 =?us-ascii?Q?boiEwlTMvPHE473ijEPAiVh4LJOPwc25IA2eZ2iyeiSPrOODUmApT1gGBlzL?=
 =?us-ascii?Q?F+bklWgKaNLs3B9RgW5Zh0TW6p97YZbmaWGAW7wafAU40kzpzmO4hxgdk8XH?=
 =?us-ascii?Q?6Jptel7AfMT9MnxanxbFxkCqKkhDRkoYPFiyxWo9yuDToWPviE9g9WIQFLrI?=
 =?us-ascii?Q?ae08AiWGDqzITKIaZzA4wfd9i4CFbyFf9uCfVGjxi8nmaPtTcJdpIRBQFARY?=
 =?us-ascii?Q?t9IcUb0gm3H3HIO+Qbva1PHAR17oSN293BrXGhr9hl6MnZE5mezRuv9BohlS?=
 =?us-ascii?Q?Gz7M/yhYCbM9XG4Em+a2qL6mGkYxiysqagbY3A+cGzLuwvQc/kIc0dDLa6uJ?=
 =?us-ascii?Q?1TnEIZ3ScENXLKZKmskKIHnZpT5n4xDfBJUTjiSmkSbZ?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd3dfc1-06bc-475a-e317-08dc57cb9055
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:58:19.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10GaW6bGZctFmnZk307iWPb/uEpTtCS+raH9ML1UMcaC8ypvpuq3K4V733mBQE4oTgehg3ZDjPs4mijqxR313A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB2091

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
 net/bluetooth/l2cap_core.c    | 51 ++++++++++++++++++++++----
 net/bluetooth/l2cap_sock.c    | 67 +++++++++++++++++++++++++----------
 3 files changed, 103 insertions(+), 25 deletions(-)

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
index b0970462a689..7bad232d40ba 100644
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
@@ -6541,6 +6561,16 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
 }
 
+void l2cap_chan_rx_avail(struct l2cap_chan *chan, int rx_avail)
+{
+	BT_DBG("chan %p has %d bytes avail for rx", chan, rx_avail);
+
+	chan->rx_avail = rx_avail;
+
+	if (chan->state == BT_CONNECTED)
+		l2cap_chan_le_send_credits(chan);
+}
+
 static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	int err;
@@ -6550,6 +6580,14 @@ static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb)
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
 
@@ -6571,6 +6609,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
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


