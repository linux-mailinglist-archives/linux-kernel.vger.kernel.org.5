Return-Path: <linux-kernel+bounces-96014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB1C87561C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A1F284B1A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F50913342C;
	Thu,  7 Mar 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fastm103"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211CF1AACA;
	Thu,  7 Mar 2024 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836206; cv=fail; b=tx87feeYyrkS9d5D9yV6ISq9De2JgrFr4W7QY+9kwmtYeMcoVJcFoNwFu75rOGDUca1obPRQ1b1aFrlVAeSpofq6VldP9nBy+d+gDDNYFHPXZbiDrr+aWzOIKatFh28NUHtfRF6qH8a5nuXnLnXmVY9D9qw871+hxXmlz/MYvw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836206; c=relaxed/simple;
	bh=bq8iVyezdKd/iGGOWKWUlOUwxLg0DtPafsz0Uqao9lk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OVjEc1drT3a8clK3c8NF1ePsyaHUypjAFa2qgZNamCWuG1TtIeMzKc3tJzyQ3U+5Ycev6eRhts7Tbk8foKW4tAeig2YYsbDRmFRf2qWTPG+3/XLwORcnSLIdBEsF3JaHuMAzTAmnWQyHBbFcdkKH0qIZ2ubt7Hx8leMA1r+uWGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fastm103; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKqY006trHAD/FGtMHiiKqSjXSC78PEkQTTuCBRa+sdjDMcdaDBLnEqy09pd6VvB4JrbtsYvkmW11xhoE8eklvOQ0Z992G7uoSJ+8RLCD07zOVHYAI+hFxPnTZwCaOkl8fcqD19MhLKPD9qSf4t1KgTB8uVswzZ2nscJZFY4nN5yKZ4Mh6noJCNIrK6E8vz6ba8lkTa9kpmh4IN2x7LTpGAOTKc0nBYMXhNb1kv2YUlwBOXUHIOnqNk0x7FtWHmuM43fD7IYgKlgyPWIRfze6/QIvsJOZ7FBPuGEYMy9T/yySGMMSb0TSaNR+FufVtdsgYzPxJiLNtzwixtNz8/lAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujmjI25+kK8BMFfSDd7ZHRqENIGTYSnb7bwy/dITCOM=;
 b=gtEsdy3IXwIyghWcVagGsH7kN+ScS2RfJmYSFC084OxI9Sp7T1mtiDQJkFIh/tvHDhXc6BxYlTK9FDObsfIGeaIdVLWQUkZV2Zwfvi9qcLxcZ417FlkGvy7+v7EgtirJkdvAFYV/gBRh465dZrQUJKYobQo3IPRDQSE/CZr1/eWpxMvgBBjUhheu+yrgCZHacBGSlKKPo2Sub2zQBed+GPfZAY9WIPHOXv+aJHgBx6n1ufaOk6keSoVGg47BNW7vgpf8uHp/0J6HvD5d70YSuT1r2wqOQUKkijPf5CnbccCLb6Fd8MSPS+r4uVmZ2DrdEGVexH22w8StVLFk0LXVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujmjI25+kK8BMFfSDd7ZHRqENIGTYSnb7bwy/dITCOM=;
 b=Fastm103sS0vFUQ7CuRNrk19xxCwBROrrTn+zWY/4rOHjeC7sCU2mIWm9JTwrcF57RC4UCs73vW3JL4gr8MH9KWQGm5zkw1w6W9PbNsqsnNHnbXdOoTbMnqzE/My4L+ifFB4VZvsE4NVHyHxV6zDddIslIZcxiFbUkFCrwy8HMk0m4vnpd2dTzaGscszoa8UMxXZNRKSlLChxrEhGR8irhVq/g82m4dgsOCZXpb+ENiIeWu/KMdjiZTbzVRllOX3iNmW+JXzHULLaZQfbC6AiUyaBT6d1aMOZF7hWUvjXgkCcsAucntTd+OAMOYyHFMFvx0lVxEv/2lAA71s7GDdNA==
Received: from MW4PR04CA0121.namprd04.prod.outlook.com (2603:10b6:303:84::6)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.41; Thu, 7 Mar
 2024 18:29:58 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:84:cafe::6f) by MW4PR04CA0121.outlook.office365.com
 (2603:10b6:303:84::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Thu, 7 Mar 2024 18:29:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.0 via Frontend Transport; Thu, 7 Mar 2024 18:29:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 7 Mar 2024
 10:29:41 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 7 Mar
 2024 10:29:40 -0800
Received: from c-237-113-200-209.mtl.labs.mlnx (10.127.8.14) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1258.12 via
 Frontend Transport; Thu, 7 Mar 2024 10:29:36 -0800
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Matteo
 Croce" <mcroce@microsoft.com>, Jesper Dangaard Brouer <brouer@redhat.com>
CC: <leonro@nvidia.com>, <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, <stable@vger.kernel.org>, "Anatoli N . Chechelnickiy"
	<Anatoli.Chechelnickiy@m.interpipe.biz>, Ian Kumlien <ian.kumlien@gmail.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net v2] net: esp: fix bad handling of pages from page_pool
Date: Thu, 7 Mar 2024 20:28:58 +0200
Message-ID: <20240307182946.821568-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dbdf8cd-4a1f-439a-3b27-08dc3ed49538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QaY5RCSrR2I+FJSvSyzzmVod5wbNJsr4+DUebxovZlUe5NcMJSwxyU3lu15UtpbQ+VRQjUn6yUdtl4ovtI49so3oaMcZ7dVr6NPV7kmXAd47mWwdkybKK8gUH9Uqul9NN2j/puLuo9+Aogq70AHmL4OGX7JCnWUhUf95TWC9E50M6cjjZ7fGtAI5RfmNbhO8QCcMQSOul0RTMYtmoQKVOGZwMv8IaA4Dib2O+LG1j2oP4gSGG8VVTejoorWb71rrsdEou6eFUnAbNZq1jqRL5O8u2ZTDCipUikt5Wp/WKpln7oKT9OF/NtkamQTxTpW8MPtdYDv70I7AikX2iV04iff4WgxSGHh+ufQcUFclW7mQLB+cFdrzMQCTGdTJQDjPudNsirY68uGA3C0x3/paFQEuYQnN01SJQ1jd0m+RTH/lBAcFU0AQkBD5iTrOFMXImq1GPTrBRtO6lBn8ODQvjafXX67KjeozZRVQbm8JqpmXRvQruTL/lYYMgZmAThjYzr5Y2J8MDH0MMiLVgvaTbY6i/PSFMns9UPSVDafnEfXJ+X+q9sNFF1YE6ljmLi0lYkgubhX2oDFAqkdl9V+AYd0JI0WC72lWXhOXcoGACkh+9v425MuP70xKgDbiWwoETk3+yhZxMLSudQ7yMCQaZo2kTpZmdMTCea4Zlam+XeO5DrC2kMHKmlSUYieCCOHW0wVnoyK6vf3wIZhW9LoXfBcS2nZzxl5pb2KWnKlHstnGOODjcd1VEgXxN8tLz6EG0KUsQszfoqlFToXRT5tJvQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 18:29:53.6309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbdf8cd-4a1f-439a-3b27-08dc3ed49538
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594

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
---
 include/linux/skbuff.h | 10 ++++++++++
 net/ipv4/esp4.c        |  8 ++++----
 net/ipv6/esp6.c        |  8 ++++----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 696e7680656f..6126fc8e4a89 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3452,6 +3452,16 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 			 struct bpf_prog *prog);
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


