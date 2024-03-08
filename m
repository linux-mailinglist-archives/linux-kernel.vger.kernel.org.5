Return-Path: <linux-kernel+bounces-97228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6C7876757
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78DD2810EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A731B1EB56;
	Fri,  8 Mar 2024 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j1v1LSYV"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB91DDF1;
	Fri,  8 Mar 2024 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911636; cv=fail; b=DFjepaBCMoMy+DGsS7oze3vA+grH6X48I7Y5nwQ22rf9g9vevLAWlO7EvP7iIcRCBXlacQmQ1GKe604QnUtn/ErIZiALpFetuhOX8NZ3qRBtrzkkJz0YV63nq+Ql8pbwMrKZ6pve1zhUc3lGVWVSrPxVvcL6EXZVwZyW0u21vSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911636; c=relaxed/simple;
	bh=jE9D7BNwHzXxRHO2gXFQXmqnR3c2bB+vaqPdi1tRfu4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pjOoKcWyBss/3gTL5Se71zo9W8+rMhOqv0Q2GTAD2ZFGUG9lSAKVOltdpFnIWUXrDmkVOBztVK9QkWaVP+9lfpiF588wQ+7SiM84cuhNu9zrFsHp3OTUzuwxf6cw0hETaK8mNRiUTwqhvFDvc2C2qsnimm0S2urzb2uK2e2GlQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j1v1LSYV; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhSlnq2/AU0qRbLgmVpuwTNE4bCHl6dz3zRBct2DTA9CahgV5/u9xGzu0tFfDFtF9TDjPp/GRsHJHs/Z8r5IXo9GcnCff58/ZcCPHEedFpvSI3x0KrOToOBPv7JGXelN6or7dd3MvRhAiRXWqGJNcfoNBQgQmPGCvlTywUwD4ws/zElPJ1I349DOrc7dZpCSLk8/gy89wQsUXDrBKtV2M6FDba7WZ4+ScaKPPnGakp1Vw+8yiD3fD7piU9XL1s13dDNndDGtQu79uAx8BwB/mF7XPl7RRxlDSLLGsPuuqlF/hv2qk/4+iAuE9PBQaqF+y3Yc/ESwRdqJgR5nNCWqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlQjN75NJnLNDn1kMuX+jyxZqdkWN9GsnsMJFzo6Xqk=;
 b=oOe1QhKxbjWstz3Og2HhyJV+FbmSFVhK8/y/tPPpYI1OnP46ZXXAupsWA5TZrK7buNORH8qITJy3KEwYexSnYDuMb4a8rABiXkn/aCKljXE2da4OL4WGpLv7M8dYFYUXkJJwbKcNK6HVc1Zy2edjOdpvB2M6kc8YPCoBRqHSHVJriTw2/3I6huITpRHeo/3BmwcnhFliXUz8c+or/PpmoK5x2tElVFl9VY8l2DRnXIOibvrfn5xh49FRT1yclyrEr575hM3sctoBoVRkW/u61JYoBQDwAwUfWI1PS3RyfHe8OWx7kCWVb35S9UU2vpLmxnM4jkEhkN8I/F/rTOFAVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlQjN75NJnLNDn1kMuX+jyxZqdkWN9GsnsMJFzo6Xqk=;
 b=j1v1LSYVO9YDfMFvsvyF1tJsGI2xtzfHnhd1VP0yRWNHildEABXy2Hb3NlaDM7+Woxlz52KFzw4Ar1K3Hf0D0X+QnYx8boXp5E8iNAtdyR2L6cA7M65RIYlI6IVjjjpVvMY0uAbvO8S9qKDKbsmrEdquhXFdSBUxrv7s33V61538nVcM/dCCSML+R5lViNQuZFKxMoSg5GJx9Q0tSt+C6174ZfC6AiyFYMWDVOxj5Q9ZRa3/AdOXpnHs0alFPqmsM1baM0IlEMDQJpY3JlHRJ0KLGhI4CErvXgj3voIsTSSDq3+rnmGsov4Mzzafm+eYngG823E9n1VRAjkgfmpA/Q==
Received: from CYZPR05CA0043.namprd05.prod.outlook.com (2603:10b6:930:a3::25)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 15:27:10 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:a3:cafe::3) by CYZPR05CA0043.outlook.office365.com
 (2603:10b6:930:a3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11 via Frontend
 Transport; Fri, 8 Mar 2024 15:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 15:27:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 07:27:05 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 8 Mar 2024 07:27:05 -0800
Received: from c-237-113-200-209.mtl.labs.mlnx (10.127.8.14) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Fri, 8 Mar 2024 07:27:01 -0800
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Matteo Croce
	<mcroce@microsoft.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <leonro@nvidia.com>, <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, <stable@vger.kernel.org>, "Anatoli N . Chechelnickiy"
	<Anatoli.Chechelnickiy@m.interpipe.biz>, Ian Kumlien <ian.kumlien@gmail.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net v3] net: esp: fix bad handling of pages from page_pool
Date: Fri, 8 Mar 2024 17:26:00 +0200
Message-ID: <20240308152723.831620-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 674f358f-40ac-4aa3-735c-08dc3f8438c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k+HS/pbKOZtkIIIdk4XIUpx8qPjei3Xggfm40sAlHyB6EnrC/EKBppUTgMl1+XCKVo7WRFbl1PsFtukVkqDhoi0WLMcsEuRd1WHkQw6ekKKe13Tfi5FbNLzHa8KFG9lhAel5XvzOtAlqtPyn2x8K56gOq8xZNsw05jaAVx2qB3SJJD0l0sL/qifqlKGGkGE659skjMP0fEmEqQDFL6lylNUGWocitQP7tztQJHIm1tke/h/m7laeH7XXYp74BScjwmvTEbNNFdmE1NZifH5Gd3nCfQTCF1kiWESDWw3S2STXU6NT8Eta3PN6t2I2G8j9JDFgg2qR6DpbVwHKI2YDNgBlI31jg/bQeUcORg+B+8ATAUESBx5VWzfkJOeVp8fo1rJ3tVId3CnNObux1vYWnL2gJn1pLpjOv6qWV3ecSb/jVu/VX2dZ3esrfRgrI/0xEjb1utSvjOIOJdFgpclhF7JUhQcvKYLq0SkWQfCiVjqLlX7qv157XXf7ncG9oUcIvlfviSMBbdf7qyQL+MnDFJAeWeh//q60w9amSOmjUE8q6fU7KQEIm8rOrb8a0Do8drXq8p46eNteiua93wdmsi0lIVuPKR/prGNJ7ORea4YZUtJ5Xjg3TF6MJ/iMbhU8tUP3cynHk85Yuac/ZoVXoURRMw5kDQfhfRQTyB33TZFcO6l3R4YsQgAGIiK78YggslfSGPIGojf/DqQsZqRM5zNW5Qv5PFRu41eCN3JO2JttoziWCg9BHN4ot+v8pJUYTtC6EiJohybNx/eO7ga0Ug==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004)(7416005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:27:09.9230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 674f358f-40ac-4aa3-735c-08dc3f8438c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360

When the skb is reorganized during esp_output (!esp->inline), the pages
coming from the original skb fragments are supposed to be released back
to the system through put_page. But if the skb fragment pages are
originating from a page_pool, calling put_page on them will trigger a
page_pool leak which will eventually result in a crash.

This leak can be easily observed when using CONFIG_DEBUG_VM and doing
ipsec + gre (non offloaded) forwarding:

  BUG: Bad page state in process ksoftirqd/16  pfn:1451b6
  page:00000000de2b8d32 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1451b6000 pfn:0x1451b6
  flags: 0x200000000000000(node=0|zone=2)
  page_type: 0xffffffff()
  raw: 0200000000000000 dead000000000040 ffff88810d23c000 0000000000000000
  raw: 00000001451b6000 0000000000000001 00000000ffffffff 0000000000000000
  page dumped because: page_pool leak
  Modules linked in: ip_gre gre mlx5_ib mlx5_core xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat xt_addrtype br_netfilter rpcrdma rdma_ucm ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm ib_uverbs ib_core overlay zram zsmalloc fuse [last unloaded: mlx5_core]
  CPU: 16 PID: 96 Comm: ksoftirqd/16 Not tainted 6.8.0-rc4+ #22
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x36/0x50
   bad_page+0x70/0xf0
   free_unref_page_prepare+0x27a/0x460
   free_unref_page+0x38/0x120
   esp_ssg_unref.isra.0+0x15f/0x200
   esp_output_tail+0x66d/0x780
   esp_xmit+0x2c5/0x360
   validate_xmit_xfrm+0x313/0x370
   ? validate_xmit_skb+0x1d/0x330
   validate_xmit_skb_list+0x4c/0x70
   sch_direct_xmit+0x23e/0x350
   __dev_queue_xmit+0x337/0xba0
   ? nf_hook_slow+0x3f/0xd0
   ip_finish_output2+0x25e/0x580
   iptunnel_xmit+0x19b/0x240
   ip_tunnel_xmit+0x5fb/0xb60
   ipgre_xmit+0x14d/0x280 [ip_gre]
   dev_hard_start_xmit+0xc3/0x1c0
   __dev_queue_xmit+0x208/0xba0
   ? nf_hook_slow+0x3f/0xd0
   ip_finish_output2+0x1ca/0x580
   ip_sublist_rcv_finish+0x32/0x40
   ip_sublist_rcv+0x1b2/0x1f0
   ? ip_rcv_finish_core.constprop.0+0x460/0x460
   ip_list_rcv+0x103/0x130
   __netif_receive_skb_list_core+0x181/0x1e0
   netif_receive_skb_list_internal+0x1b3/0x2c0
   napi_gro_receive+0xc8/0x200
   gro_cell_poll+0x52/0x90
   __napi_poll+0x25/0x1a0
   net_rx_action+0x28e/0x300
   __do_softirq+0xc3/0x276
   ? sort_range+0x20/0x20
   run_ksoftirqd+0x1e/0x30
   smpboot_thread_fn+0xa6/0x130
   kthread+0xcd/0x100
   ? kthread_complete_and_exit+0x20/0x20
   ret_from_fork+0x31/0x50
   ? kthread_complete_and_exit+0x20/0x20
   ret_from_fork_asm+0x11/0x20
   </TASK>

The suggested fix is to introduce a new wrapper (skb_page_unref) that
covers page refcounting for page_pool pages as well.

Cc: stable@vger.kernel.org
Fixes: 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling")
Reported-and-tested-by: Anatoli N.Chechelnickiy <Anatoli.Chechelnickiy@m.interpipe.biz>
Reported-by: Ian Kumlien <ian.kumlien@gmail.com>
Link: https://lore.kernel.org/netdev/CAA85sZvvHtrpTQRqdaOx6gd55zPAVsqMYk_Lwh4Md5knTq7AyA@mail.gmail.com
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
Changes in v2:
- Fixes in tags.

Changes in v3:
- Rebased to ipsec tree.
---
 include/linux/skbuff.h | 10 ++++++++++
 net/ipv4/esp4.c        |  8 ++++----
 net/ipv6/esp6.c        |  8 ++++----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2dde34c29203..d9a1ccfb5708 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3448,6 +3448,16 @@ static inline void skb_frag_ref(struct sk_buff *skb, int f)
 
 bool napi_pp_put_page(struct page *page, bool napi_safe);
 
+static inline void
+skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
+{
+#ifdef CONFIG_PAGE_POOL
+	if (skb->pp_recycle && napi_pp_put_page(page, napi_safe))
+		return;
+#endif
+	put_page(page);
+}
+
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 4dd9e5040672..d33d12421814 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -95,7 +95,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
-static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
+static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 {
 	struct crypto_aead *aead = x->data;
 	int extralen = 0;
@@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			put_page(sg_page(sg));
+			skb_page_unref(skb, sg_page(sg), false);
 }
 
 #ifdef CONFIG_INET_ESPINTCP
@@ -260,7 +260,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp);
+	esp_ssg_unref(x, tmp, skb);
 	kfree(tmp);
 
 	if (xo && (xo->flags & XFRM_DEV_RESUME)) {
@@ -639,7 +639,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp);
+		esp_ssg_unref(x, tmp, skb);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 6e6efe026cdc..7371886d4f9f 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -112,7 +112,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
-static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
+static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 {
 	struct crypto_aead *aead = x->data;
 	int extralen = 0;
@@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			put_page(sg_page(sg));
+			skb_page_unref(skb, sg_page(sg), false);
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
@@ -294,7 +294,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp);
+	esp_ssg_unref(x, tmp, skb);
 	kfree(tmp);
 
 	esp_output_encap_csum(skb);
@@ -677,7 +677,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp);
+		esp_ssg_unref(x, tmp, skb);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
-- 
2.42.0


