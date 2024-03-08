Return-Path: <linux-kernel+bounces-97038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423AD8764BC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB26E284C60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0187D1F944;
	Fri,  8 Mar 2024 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Yh3pZan2"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2020.outbound.protection.outlook.com [40.92.74.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492481CD06;
	Fri,  8 Mar 2024 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903295; cv=fail; b=JG6vgMcLN2jUkvu9tjeVX4DqbT84jOQS547JkuDG70ZxigONC04xMVU9A/yzxmvI9/2ruyWZ0hhxm6mf+5xrRmQ+TQz+zf9Jk2cnSSXHWz8m5R71VlzPlhRuFxHKjjbS973OzjvjYNzZzp3UcE3VuDLUDTEK3JCXL5tO/alLW2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903295; c=relaxed/simple;
	bh=JeQwoqLYiVeyV+3baROZxz/Sk+j2fgc8ITTbDLMBCrc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Rn+4fYM5wWch+5/0T23MtopQ0lCpB4TIYVHG4J26a10n4ZdrWuvWuQI7fFEdghDgvR4jcnhwH9NWWdMQ4VC2F89QTuZWjbO8jcJC5ET56l8F7h1a7nCgJrROU7E/P/eSCmLOVm+0zUG3JeMuOhqFHhkE4gUQ35tV0Rt8IAx9DeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Yh3pZan2; arc=fail smtp.client-ip=40.92.74.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChEYlC0Fbc6CCeKn/DyIGKYv9DxWV3aainKHjNCJDLIBt3OhgNIqcbjCnBHnymggDm1J/EywvmRth2pBq9GxhX0Oezo06KaX/Plhn9/HAcJi1XCOEdf9BGaVcbe3x/w56KP+/20Z/Mlild6jCt290/iQvcRYaWLlRa2bcrJzbGmQhfdXE7k7oNZN4HsinatEniWs98/dB+14ApLl6dYN0bvztdQ/mpTAxDrNWHDg+R8SwHbhjzUH3tQXweOqlMxL3Rk57Wr0mt1qVdjajK1XGO47gVuj6d0LOTsAjqTOSTiWHUJnG5J3WnrPRWNQMMDw6R4glJyAcV9N7TVTHB1cQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiYA2Xas9rmR6UR6ocGlQ9axajmHXjBn4fc6kz0dHXw=;
 b=hS9SbHpzENDL9LnqPO1o8JJuhfsXbNFzHrSvYbh/9DalY4ju6jG21lzHaxxh5BOrRLshjFJ0VWC+5AXl+9heEhCJgrrEwdOXnGOVHMzmVhlE/GAJ/qvGIMx4AvTd8r2MACXeCE5sy6U/9HSRvlX42XBId3OSMA8kOozVAQbvoLPUy8WXy2Ff8TiOtsjPraNjGT1ZsJTZ3sZgLLxflaBDiT2lPw+V8I4EBcpifsXPM9ObU3jRz+zdNSvrC6MN7G7udYyAzntQfyubkL36O44QTwgkVcTEa7Ir6t+YHlcq3eI/gDILXPvY6lrevvtRHl3e7IYbn2P1ELC5ZPkIFq3WYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiYA2Xas9rmR6UR6ocGlQ9axajmHXjBn4fc6kz0dHXw=;
 b=Yh3pZan2OvhqbXBSbveTT5TY3TU089TAHoP4Bqe3Vx/sWdFtoWHo7SEwfiSlJe1RMXLx8iN6xQKpQlTQ2+doyiwjBJTRUfCHdArJFQyxUDqI8ERigBDe2pRqP7Fi5CREfflzi4xYRjjWacvHOEcs08bu6uVteljb7lNEBt6CH9qAD3hPXv8AIVWFjkEud335y0DCoWrSJ1slheLehBLvuk44kvYkiCKEjx21QRINbfwIws0XfKIm2X4a2zlfa7OrqSla8QAOBOwqmXROXGszDosvNmTpWUljuCn+TInF4Dl6DDDP4Lk/dI5XpZLP7ylGJ4PUP5BmVuIiV/iydsZYdw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by PAVPR03MB10177.eurprd03.prod.outlook.com (2603:10a6:102:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 13:08:10 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18%7]) with mapi id 15.20.7362.028; Fri, 8 Mar 2024
 13:08:10 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net/packet: Add getsockopt support for PACKET_COPY_THRESH
Date: Fri,  8 Mar 2024 13:06:36 +0000
Message-ID:
 <AM6PR03MB58487A9704FD150CF76F542899272@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [rWDDBPyATA4xNMx1o8BEcMZ6S+Mi8TKU]
X-ClientProxiedBy: LO4P123CA0676.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240308130636.34343-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|PAVPR03MB10177:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ecd0c6-bbba-4c2b-637e-08dc3f70ce28
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UZDLL53z8/5XrTn4yMR73G0TwEtSfKYn3cVHozuoM1gbh8FmPOKhY3Q86kU15fxPJS8zktaiGU+NxY2YQOwCHiY0zMn1Qrlqo6XdCo5z/4ofL2hGPSis0/Cl0GXP+DsIzP5nECLwGvviVHU2D1E9x2NK5x6CHTYA3D0g7lphKDdKr+yemoyVhMSv6hn7PI9GEbtRQ5TudNy+yMGCcX7lQUT9ZJNDza20mUYf3m1bibpicv/lTxLzzKLo56Jeg6WoWPzBQBB+isU40u3X5OJb7q+m+ho41WlXKoudNrx3/8UFZZKGo7CcVGNCAavJWsqDVRWfgJ5lj4rul8t/53N2d6izb8d2gOIvmu2r7/+L0as5xiucvJISiuxPryO2CSFQyw80zVT98EqZON/qzeiocH8CzaDmdfj48TX2xjcpoFe3OChcne+f/QEW2US/qWKMvIxBaZE/Tq9YlSWWkuT2NhHkSs3xSFxierPUwUo6sJYh7BFoxFEZ00PLMrftEUHJ0FtHHpkigpdECnLEUIec4qAtfisqFMnFVyny3R5SUmWQxeKAn3JXJNpNvvXu3OU9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tiwq55SIoAr8TtzlTT1CeH5+51K+Pz4gIboz+4Zn64GQGyZ+53JHdINbex+T?=
 =?us-ascii?Q?UwOL63SR3UnNu6Kvi5kDPwC5ZmnVA6GVNMgNTazPmhnA5F0e8tppH9WDOQdw?=
 =?us-ascii?Q?LsBFOH9fwZIy3B1s9iIg/08Xci4nK2Up6ULNPYI96AhwnsBXwAoGAtA6njXj?=
 =?us-ascii?Q?2/Ucw9BLW+KNUNF5YvXUevjvN+HrIHC/BwuQovnwx7VnBeUxyX6EtDicTKi+?=
 =?us-ascii?Q?VPcX624wvtSaDBwthJOJkEc5FHAEvZGSWsssGhr/3poYhnkphewE7o4LAq7E?=
 =?us-ascii?Q?SDtcPYyw3t5VXte/81BvlPEz0T8CjqQzC338fw9S5ceqK/b/77XZT+kR0408?=
 =?us-ascii?Q?drtEJUo3G9dWYR2LYF9QJFgs+eqNvEfn3xmnSHFeXTt/x59Y948xgh+DniVj?=
 =?us-ascii?Q?p2LQqiLhz7dsnF4LB4ow0Evp4QeHrHdhk5nKRMLstcJDUHOLY2j/LiLecV/+?=
 =?us-ascii?Q?qCZiKv3gbPMXvxHFrqxTOmiU94RWZVX9Jnzne91CayNbJPA1qh6ePf3XJ/xk?=
 =?us-ascii?Q?+JceQfaHMvOTZ2XGSZO81m3VyG9W81SfiZjnreTbbdAcSCWrVrsv2mg0e8Kl?=
 =?us-ascii?Q?T65el7xhiJEVPSLL++Q8zbRH5qklanjfOYnhhS1psGL8YxkJPneHUIdzRvUR?=
 =?us-ascii?Q?gw3HnC0YxtPxCTcnlY5YRYo0qgkd/GoGZMeniLgpX4Rke/wCUVtq0kfv5lJh?=
 =?us-ascii?Q?ybaQLv14FrtcpiTUxlDAp4mXC8gPQyJKBNI9x6ozn/sFdJegCHoTLeoaN2Lh?=
 =?us-ascii?Q?/9u9vYaDvj0uo0Uoxgmr+gyt4CXveoVTbqXW1abWXezK/eVmqpixkN0DkLFo?=
 =?us-ascii?Q?gzmUI7dO7Z37aB766EO/LqQLwSuXVtggOIGId4HMmeLJRatMk2n734wkqbL9?=
 =?us-ascii?Q?HLRo8BFvJJNwoeN8mQOhAHXa62vu+eQrWqXgV4y9ZGUus7vRlZQoCHo81Jib?=
 =?us-ascii?Q?xviz74cg9+9fAFRFEKyyrlLiWsjOsa2codRW2e0FEtjs63boMYibJStIHyI9?=
 =?us-ascii?Q?TgW5jvymo+3FHKWCKENbezOKK/XnNkTjiFI1VybZdqsyU//XdGCBPF8SwpSr?=
 =?us-ascii?Q?oSrLl01U5j19RB3f6C9ZuJeZCCgp87E3wG9hB/n8PYNZ9/9ltdPSR4HBxAgw?=
 =?us-ascii?Q?7+pfnzuDITVT8BVTDxzAvj0XJf3Leoq9vE8BO7egO3fnpklI133NZrjJz4Rq?=
 =?us-ascii?Q?6zY8JMeUhvcTyRwGjWkehnnmOUJu9VnrRsROGqiVTxxyv2n79L/vznQ22AZ1?=
 =?us-ascii?Q?2QvEt+MYeRtxxDmD5iHR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ecd0c6-bbba-4c2b-637e-08dc3f70ce28
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:08:10.8914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB10177

Currently getsockopt does not support PACKET_COPY_THRESH,
and we are unable to get the value of PACKET_COPY_THRESH
socket option through getsockopt.

This patch adds getsockopt support for PACKET_COPY_THRESH.

In addition, this patch converts access to copy_thresh to
READ_ONCE/WRITE_ONCE.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
V2 -> V3: Fix pdiag_put_info().

V1 -> V2: Use READ_ONCE/WRITE_ONCE.

 net/packet/af_packet.c | 7 +++++--
 net/packet/diag.c      | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 0db31ca4982d..61270826b9ac 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2318,7 +2318,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	}
 	if (po->tp_version <= TPACKET_V2) {
 		if (macoff + snaplen > po->rx_ring.frame_size) {
-			if (po->copy_thresh &&
+			if (READ_ONCE(po->copy_thresh) &&
 			    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf) {
 				if (skb_shared(skb)) {
 					copy_skb = skb_clone(skb, GFP_ATOMIC);
@@ -3836,7 +3836,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		pkt_sk(sk)->copy_thresh = val;
+		WRITE_ONCE(pkt_sk(sk)->copy_thresh, val);
 		return 0;
 	}
 	case PACKET_VERSION:
@@ -4090,6 +4090,9 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 	case PACKET_VNET_HDR_SZ:
 		val = READ_ONCE(po->vnet_hdr_sz);
 		break;
+	case PACKET_COPY_THRESH:
+		val = READ_ONCE(pkt_sk(sk)->copy_thresh);
+		break;
 	case PACKET_VERSION:
 		val = po->tp_version;
 		break;
diff --git a/net/packet/diag.c b/net/packet/diag.c
index b3bd2f6c2bf7..47f69f3dbf73 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -17,7 +17,7 @@ static int pdiag_put_info(const struct packet_sock *po, struct sk_buff *nlskb)
 	pinfo.pdi_index = po->ifindex;
 	pinfo.pdi_version = po->tp_version;
 	pinfo.pdi_reserve = po->tp_reserve;
-	pinfo.pdi_copy_thresh = po->copy_thresh;
+	pinfo.pdi_copy_thresh = READ_ONCE(po->copy_thresh);
 	pinfo.pdi_tstamp = READ_ONCE(po->tp_tstamp);
 
 	pinfo.pdi_flags = 0;
-- 
2.39.2


