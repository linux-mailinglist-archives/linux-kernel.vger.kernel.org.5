Return-Path: <linux-kernel+bounces-97020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D54B87647F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1D5B2228F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7FE1CD20;
	Fri,  8 Mar 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cWcP+B/T"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01olkn2028.outbound.protection.outlook.com [40.92.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFEE17551;
	Fri,  8 Mar 2024 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901829; cv=fail; b=dRxOegfXP+of9WC5MP+brX1+FePso2kmtORbxFHmNp6+jDyHtVwmh2VEHtDd8w8ytiivAg8eHlZrlVqqU/IxS2BDdOUiI0/M/0q3prjN7KJWsG3qN7bXWlpkNh5/OPGBTbizdMRUX51PTd2QxIjUdgMIQ88dqD6rc9BNSWrGfCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901829; c=relaxed/simple;
	bh=AzIlM70Wv6TrbziVfi3amKRwER+aWKF28c9+YIHI0bs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EnugOQD0PCI+egYpeEvZxPGoAlL2Yb7VyCfvtpwHfN5qhUQkIN4jXc5Tt+Huj5nXfUimUDoPzyyDq/dE93M/jwL0TGgJw5zzRlcD1J6bD84MeuopDtct11oLW6d8GSnGZZD6rf4IJ0OvmoHXikcRObjkMoUhHS0uV1UFgJ/EoPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cWcP+B/T; arc=fail smtp.client-ip=40.92.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+RTOjStO99zi+CkoDNiatiIJ/MYRWX6bGlqXgBfGsuhNAJn4iZlXkef2FyMw1HQe1ca027Axc9LWQlsYMoZrkZfGQAwkfoVr2rcdUNms1ZL6Zr9UBuD/n/bIHX4yObxzkjylyBZ4GbH2FosN0EN1BdqFjNubIq62ChlVAxvmS5tWvNvawaIWWXTOWgOkgAbrAzwrbJci8rR+4IMyY/wiKcl557pRNUlyvsOm48oSEa69ax9PknmUf8rqk99gFaexS/p/KDRrkO8M8yWFxVMVKTlFbutrW085mmUveOPqIpN7J9qjLLuSAfFLGJw6wLx9xFP3O2XwLh7Edpw7sAmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evtXpqswO+DZpWIsttoDetqGfnbj64w1HBtaPfbwl7o=;
 b=LI6AGjDJKxnpyhf7vCywwDMiDKN53GGgj7SQEnm+7pPvwl/9WpjYiHrZHIhCkUHKaNvnQ0kE2qbe98AIZWxBEt+1CdNNdBCjBtMhjqqzW/xMxxOIEO0EHUVgMuLr4E9jT/Jfo40LS2prbJ3JrbbQp+6GL2U2/JKcJ0ntDmsfOdaY6kmfq4hvQuS9u4qENn0pFMVU+zKoLzv+UN8qUIkm8y/VGiO+0N1vrwS8n8gDCBB2Qojd/JVxNrO6tOLyUqcUjt/hetpAdWSxyDwUyp2OG1kTiBCr58HSjXiKb/1IxUOWY+rEmes7pw8fW/9ziFqOBNuPiM00RbroGxa4Ah+L0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evtXpqswO+DZpWIsttoDetqGfnbj64w1HBtaPfbwl7o=;
 b=cWcP+B/TsqpIBDPd9BsUz0uZjuvzvlMv9H1RYIcqNIUdEN3pM7Hy/zCjDLBzbeMKWPODeuvXL726iG05evQmmb9Sz8DiBbzT7txCKugMTYox2uljTvu8zZQvK4s9soZLSouStbuZ59QOXS7UzedUMATbffX9vQLKJjLOGsPuZ2h14G3O+5z8ugu+iihEwYafgouIT4vbJORm9OQxaTfgYoibgW5p+aPrZn4dAdUurtPxdQQg64lY/BaQhT9FLKbdFolgHXiaFfdPSlO5T/k48+drrKRbITvzMKHVzM3//P3nryFkYjLYzWPQoC+Xe0WkHX2Vk+i2y3CIo9OVtOy++g==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DU0PR03MB9519.eurprd03.prod.outlook.com (2603:10a6:10:41e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Fri, 8 Mar
 2024 12:43:44 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18%7]) with mapi id 15.20.7362.028; Fri, 8 Mar 2024
 12:43:44 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net/packet: Add getsockopt support for PACKET_COPY_THRESH
Date: Fri,  8 Mar 2024 12:42:39 +0000
Message-ID:
 <AM6PR03MB58483266DF047DA017C540CD99272@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [pjSJtZvGXdZsrjILf5ad44iPIHe9F/bq]
X-ClientProxiedBy: LO2P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::25) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240308124239.25147-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DU0PR03MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd3085e-f47e-4d37-16a6-08dc3f6d63e8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZUz+3gqNR0MRghj5XQFHuDsH6aeaQa91g2mNGD3mtkRSmK5/lWLCBJosxKs7PUJMha62Vza4+ToehkrydaeT7lNKXjnrpTuhptRpR3bh85lN09EnmK6wxl3gukmfu765h7Kd5QqjsLh2lQ98VpOX4okLkEmrmwR3dJ3yPKneO3med/NzzN1ddBSYifIbsKh5A4JWJVZmH+0QaxfIPNhg0+Rt/mlHtpPyxPKjUMHHl5KbjtlQvxv4nCpwkVrbNyFkGJEG6AYqxl/NBkatdBlrsCaEReHjiwUWTXhDFDkS75BalfI+4reCCFvO5vOnxav2aHB3FC6AZtV0bs0sLEDeonfIhn1bTpci5syIByp8ODdESYmYcNo8rha4Kq5xJMUBClwZlXNx9PLlNp0euFQzcfTsdoSoOPQGiXd46jPqD5F5rqwu+OurKldmOZbviAKU9t/qpsYG+M65YV2VvS2H3WgH+RcHwPpFs4g1HnLkHjvFeiw53rtMGY0YGqiGzWC6FAj4FLdcWVuoShebjYzanhsjH+AbtOL/BsCD3hWKg4UPNBV4c43a3BNWgZXs/1QQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0SASB5ag/fRlH09INkmINEmjuavBIsvKZyB2Zlxk+bM494CS0wrVq8hVLKn+?=
 =?us-ascii?Q?gzw5WuXfMz1i3Ug0LdI/m/L+drMOtxInEoJcf1VqQJOYO6AdjSMARtGUyA1M?=
 =?us-ascii?Q?5ZkO0qX8bufrbN2Q+tHJZB6ToPqX4A0ylGXjxAFCLoFIfJa8so91ixzFGstb?=
 =?us-ascii?Q?uTk4syOKPYqHTQGzuky8EPQt0SZLSGAJw9d8uHio0U88xL27bzsWJsADeazT?=
 =?us-ascii?Q?MV9mRZlJn7pNdhGdhW27Lp7qlLihkk+u5W9Hfu639Ri8lZT/PJXRjodohsvh?=
 =?us-ascii?Q?sPNu8xtLdRTZoh3el29peC4EeaDH+TdgYebpEGicZKoS6WPg5n+B84glZwmS?=
 =?us-ascii?Q?aBb0zejvmCyYIGtssntKfBXZ/lWxgu9o7gGmrbBXx5S1aJAJhvR7XL3pzVqf?=
 =?us-ascii?Q?bH4pdZtzYGjq+oIFwSkCMzRDOB0C2gz2yM3m2OOyxJ0fmYOVdD3KLnya3M51?=
 =?us-ascii?Q?GkxbU99qp4Q6wcXIsYACnLA6uCj/uNWNXYwxH8Y6hzyoQYCDb2Mds/AOmYA5?=
 =?us-ascii?Q?lfiyCBmc04Nkw39J4amsRA/c7sYDLQlHz8vrIj8GT9cyiavMYUitX77qfBb+?=
 =?us-ascii?Q?5cMQxNpw7OtcpDIzmEK9sfXv0EylhTdWeNlPNCRb+93yrPhVGm2krmfR1Ns4?=
 =?us-ascii?Q?IX6JHo2CFLrdT5kpGUc431uOnCXxX8bGi2QzwQzp3h3aMEOZYGgOEp4FIxGR?=
 =?us-ascii?Q?RH5iSO88N9r95PpnfNoFVMdpXBvDvi5VA9a5Fu0sc3AU1c/82lKePYo45hxw?=
 =?us-ascii?Q?0ZDBTFGrhKQSEtKD4SINQDsks63nFX3WLyaFLj0Ka+PV8jHq+G2NVRCkuqwn?=
 =?us-ascii?Q?PQBPCvrGeQe1iZfGQ7DP1L+f2UuzO6frQdfFEz6kztA+/mlxOiE+o76uOWyS?=
 =?us-ascii?Q?d9UewJCpMiK4RkH4RgCSCQLuZLOMNXacHD7BALQJJnm+iynnO8H1DU+cv0tz?=
 =?us-ascii?Q?fI9phMj80cbzLUUoMSdAn1+H2hCZ4rNEKXD54swRPHQgfDElLevHno9Uuwlf?=
 =?us-ascii?Q?V0KD+/XLbKiYkMo0Wq0lmj+qk/E09d728sm9/+c3Ec2QkeCKsUDIwJ6poID5?=
 =?us-ascii?Q?ZdlX3zovoK5HzekN8R1PNRQx83llwg3nToPfILgn5JhaOMyYCJ3si2FDws3V?=
 =?us-ascii?Q?EmUukjKYp+KxcceTw08i+m7nIFgULKD16gZg+SiXJSuLTM81jIbQ2OV3+6o1?=
 =?us-ascii?Q?G32Ew6pvl9ktNveYMDyS81grB4SlfzF8/nhIaFG9ACLncIxCGLACjNnapE/5?=
 =?us-ascii?Q?p/cm5v4xQeZAKLJNwU7R?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd3085e-f47e-4d37-16a6-08dc3f6d63e8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 12:43:44.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9519

Currently getsockopt does not support PACKET_COPY_THRESH,
and we are unable to get the value of PACKET_COPY_THRESH
socket option through getsockopt.

This patch adds getsockopt support for PACKET_COPY_THRESH.

In addition, this patch converts access to copy_thresh to
READ_ONCE/WRITE_ONCE.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
V1 -> V2: Use READ_ONCE/WRITE_ONCE.

 net/packet/af_packet.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

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
-- 
2.39.2


