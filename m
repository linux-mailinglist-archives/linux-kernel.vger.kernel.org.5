Return-Path: <linux-kernel+bounces-94459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A05B87401D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB491C22FC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6EB13E7FB;
	Wed,  6 Mar 2024 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fOYBr/Kq"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D414285;
	Wed,  6 Mar 2024 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752129; cv=fail; b=Um/xPeaUnqhrQgzBDUP9jWuQDGVp2JOuES250bBeQK6PMTj+VX9KFSz50l8CdyKN/McuL2MmoHkZpHMh9oTya8+Gqwj0+2fX08c27beZn7Ob4yfzy84fmZQyH15eUp6IWl26hkUr4n38dxj8XdyLDhOO/+PvsW/IYJ2bY4I9NYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752129; c=relaxed/simple;
	bh=77skaHVmdY7spF75jjkCCproh1Tk2c9hs+XDGOi1YAc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UTdSwX19D2oumtjvTcllGQyh6ZAgYAzsJ9FkwC3YQq2sHCSiojYI4f2px6GSLiREhNvIYJJ3Y1tNKk0NqzA6j1blWP/catxKZWGMtEr+lvpn+afDGRYHAGiHyC25ahZGz/av9yPf7xP9tG3CewaLv/pdQ4GkqFSDQ1Flz/6hAoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fOYBr/Kq; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUWQXWA3O7sGcw5lS+Mnq1KfCwsgEoZTStmS9iIka4JpmLgfLquq8nAoX3Q+QwIY9lu5lbPcCp1X09fsNkktsT3iLeEWnIEQb1YkB9kNYiBg3IlcRKKa4xbapmVwHkZ4+aiIMGKFLqQ5fXYUUybI8axiUpmwi6f36rk87QOYOS1Qt4nLkhjIAg/LbACDZkqzBE7PqQM9CG1RLONUW8meYxQacE996cYSI4EFdN8+ryS84Qvrf2cSDV69BgAuHK6Q5jOPAP67Xw4ScpZcdLHDGxFo9o995eFamYekIGUmN1NJDGF+i0pI+GO09wKgtO+8StFKcOHLxmAadaiEyE2n+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98eXEo2JP+ylw5g37eJ955obbfAsZ0aWo58uVZFMeSo=;
 b=R8AhlMTrWnsdSi0bsispazi8YCAq5Llp+xBCo7g1hs8Unn5jXzP+uLhOtZ/tlf5J6wLVcQqY6b1vsOOpcppzGm5JCu7s9IIKvl8iV3Hcwy4HmYUN5MbetzrNJFYzhMsnVSsHwDrZjmcdNuBC9YRMmAw1FCPn30Sp/V9TFZEIL9sBRe7wGrRYCuDlefLp2kctVqK/kL64JYo76elk1Hw2GXvIE6lkMu9spjwqoj98YszKjH4DWm3o2rzBuqncdO8xx8fXd8KvbkTeRhV07IBSWLUVDGniMVLM5fwuKfwm+GwRBUZuW1vkYPbctc8d9cWcQpOVIAFTqYxrSz/JJNYweg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98eXEo2JP+ylw5g37eJ955obbfAsZ0aWo58uVZFMeSo=;
 b=fOYBr/KqExgLayYYAnfkvoKdUurphC3zPoIGWAdxGea6uAOvgO2WogHmWD+vZxsrgCNfQTz9+tfijzUPqVQlglA0+U0P3SCe1OTXIZpEDzbw8ihKxUCtMwAdCEZn0T2Twc2lMisQQjXrcNxCZPyuq9csrLPu+i2szMwNK75COMvBAVXk6W/XCqH7sA7TuFStMijIOh+cXNTAjK+rdhFDZe/qp7XWvbZ/HWdX6lcVtnSZ9C5B1HlSsuB5XypC6YVL4BU4vJurIWguZFwNy+oREhTfxuFCuKsadRKzANrstU9MkQIMHBDeDYGj/xDFEFmWGueWdAgadQCHhFWKWO/txg==
Received: from PH8PR07CA0010.namprd07.prod.outlook.com (2603:10b6:510:2cd::22)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 19:08:40 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::9e) by PH8PR07CA0010.outlook.office365.com
 (2603:10b6:510:2cd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 19:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 19:08:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 11:08:26 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 11:08:26 -0800
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.1258.12 via
 Frontend Transport; Wed, 6 Mar 2024 11:08:22 -0800
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <leonro@nvidia.com>, <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "Anatoli N . Chechelnickiy"
	<Anatoli.Chechelnickiy@m.interpipe.biz>, Ian Kumlien <ian.kumlien@gmail.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [RFC PATCH v2] net: esp: fix bad handling of pages from page_pool
Date: Wed, 6 Mar 2024 21:08:15 +0200
Message-ID: <20240306190822.390086-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 882ee4ff-ae00-4f49-28ca-08dc3e10d5a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UJmnb2dSwpi/mnu3qohPvItuAffzk4YYISjtuHab/Q4LUez2pZK4Vz86LSZm0cXiGjQKZygd/ZDvYTdJN03KyQaf/X+Fd6HiV6v4FPtqXT8IYhTkmFaeTbdeN/WMFIDj7P3hTPVVwWA6QTvi53SiAoAhiVpDYAGzZUXadMeO1msMeisvypSJjHhY29oL7fq5jlTCOGOG65ru6271al8K7OCCjh/GkyoWMQQpHABp36fPNEnumnSPMFKpPAhsOxvi5tKWaa4DmnkGWAm7hLkdaoZRejBaNODCf2IHEUU3aCXEyhW+M5M7lRKRS5sHtFhLaVivpozjxoez70dWNYXx9XjYQhrMtJmtqvpRAFilK1bS9Fk0YmLyca/5flBsTotr6sXwbqhNp5Pme/gXbsRPWtVL8vSQ8WAgachp1XOvXWlpXIORzZLY7p7zkDqQwelfrYGkfpOOOe3JJ/5J2CceRcNf9XiBeyp1zRoRIjFO6RJI44DQGoRnJffcfJRJbBfip1GLyf6uOu2zpd0XwAnXC6sWNYM+a8AH7Pn4AdBPDH7e0yi/zYhNmgckVcEpgl1EuJsZM54UZih64OXEKj6ZqZFH6pjFm18yTrMW0rcgG5OvdRv18//11TmKI+Ik4+7cjoRxVFR5ps/wQCshQrEvuINfi0frJ+VTPtHid0ZUVcTe8z1WHEEPCofd0gfUYkkW4iJWsmjjyVgyz9afnb6lbb1+XmY81/SapZsjaMCIqiWluI1EVJh9/iVL3Fi+bxWO
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 19:08:40.2803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 882ee4ff-ae00-4f49-28ca-08dc3e10d5a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086

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

The suggested fix is to use a new wrapper that covers page refcounting
for page_pool pages as well.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reported-by: Anatoli N.Chechelnickiy <Anatoli.Chechelnickiy@m.interpipe.biz>
Reported-by: Ian Kumlien <ian.kumlien@gmail.com>
---

Changes in v2:
- Added napi_page_unref api based on discussion in v1 [0].

[0]https://lore.kernel.org/netdev/CAHS8izOoO-EovwMwAm9tLYetwikNPxC0FKyVGu1TPJWSz4bGoA@mail.gmail.com/T/#t

---
 include/linux/skbuff.h | 10 +++++++---
 net/ipv4/esp4.c        | 16 ++++++++++------
 net/ipv6/esp6.c        | 16 ++++++++++------
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 696e7680656f..009603db2a43 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3453,10 +3453,8 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 bool napi_pp_put_page(struct page *page, bool napi_safe);
 
 static inline void
-napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
+napi_page_unref(struct page *page, bool recycle, bool napi_safe)
 {
-	struct page *page = skb_frag_page(frag);
-
 #ifdef CONFIG_PAGE_POOL
 	if (recycle && napi_pp_put_page(page, napi_safe))
 		return;
@@ -3464,6 +3462,12 @@ napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 	put_page(page);
 }
 
+static inline void
+napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
+{
+	napi_page_unref(skb_frag_page(frag), recycle, napi_safe);
+}
+
 /**
  * __skb_frag_unref - release a reference on a paged fragment.
  * @frag: the paged fragment
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 4dd9e5040672..3126aeb0588d 100644
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
@@ -112,9 +112,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
 	/* Unref skb_frag_pages in the src scatterlist if necessary.
 	 * Skip the first sg which comes from skb->data.
 	 */
-	if (req->src != req->dst)
-		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			put_page(sg_page(sg));
+	if (req->src != req->dst) {
+		for (sg = sg_next(req->src); sg; sg = sg_next(sg)) {
+			struct page *page = sg_page(sg);
+
+			napi_page_unref(page, skb->pp_recycle, false);
+		}
+	}
 }
 
 #ifdef CONFIG_INET_ESPINTCP
@@ -260,7 +264,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp);
+	esp_ssg_unref(x, tmp, skb);
 	kfree(tmp);
 
 	if (xo && (xo->flags & XFRM_DEV_RESUME)) {
@@ -639,7 +643,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp);
+		esp_ssg_unref(x, tmp, skb);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 6e6efe026cdc..7bbe19e74cf0 100644
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
@@ -129,9 +129,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
 	/* Unref skb_frag_pages in the src scatterlist if necessary.
 	 * Skip the first sg which comes from skb->data.
 	 */
-	if (req->src != req->dst)
-		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			put_page(sg_page(sg));
+	if (req->src != req->dst) {
+		for (sg = sg_next(req->src); sg; sg = sg_next(sg)) {
+			struct page *page = sg_page(sg);
+
+			napi_page_unref(page, skb->pp_recycle, false);
+		}
+	}
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
@@ -294,7 +298,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp);
+	esp_ssg_unref(x, tmp, skb);
 	kfree(tmp);
 
 	esp_output_encap_csum(skb);
@@ -677,7 +681,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp);
+		esp_ssg_unref(x, tmp, skb);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
-- 
2.42.0


