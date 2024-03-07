Return-Path: <linux-kernel+bounces-95313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC3E874C16
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D037283FA3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B391A85270;
	Thu,  7 Mar 2024 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gwjmTJV8"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DDA82880;
	Thu,  7 Mar 2024 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806557; cv=fail; b=QJJ5a5OLXTxMyl5kvuenCKoSXQ1mgLnNTPIr4sTQJg/Tak8i0cSXesRVO4e4VkYrMiWbUt4vtxBL3VBFLdIBABgfdHo1iNggYEedL8Qd0PICCVo7le4gspqemEqX8L/U781+LC/2n5sfSapowkwTQjj4wkhxi5Uz5/9fm0ajSD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806557; c=relaxed/simple;
	bh=hvZwSROIQ5u9CpQnbaRTZ2sJ8CZbmtM437E9f0XBFiM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l1ABX2t2go11DdB47f7oV7ta2CqrOUOsCjDMHHVFlkxT/5h66LV4aDTmWd7mxuzw6OfWyOWU69lALcF9ZRY3G+WsOV6+/ZeZ+mlDLGiHiFnF+cdwmNIslunXGZMiSzB8FRek3Ukq0FS8XUTJLr5CHfzbRrZ2nP6BNgB9PfeACmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gwjmTJV8; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqNB3sL362JnYyWh0rFkSZwMb9IzdNGCmQk4hOTmG68So0J668/FBRW2C5r+W46BxkL6mseCd7X4USPIN46ww2Iv7vlWvBj/RA7mbWL8s1R4/D7AGf+AR/X+/GCKPId+A15iopCp29qjoyQNTbqsqE9D0VaPh5hFuK7pgjd2yF1EpFP5CE+h11SzXv84P0UEeolJPvgLDBYhQj8A3wzPh3RYheEdlY5TaJaeN2/qdbuNMq2GbVG88XOn7X3El2odEHWHXDdFaRXuqHrunoiVb4CF8Di4eXsftedj+bm5n5qc8ZdP2dEMudvdHzR9NlJmfVYrh89kek/aUpBm4ZwRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xvm8rPF2JAXFvg1pzZeYVXkTKxhhEBLTy/NpdSQO5Gg=;
 b=BQ+zMgsMrRcsFdsdfaCDXUxVFp8087/kBRzF+/zdGuKZOpjEcVIaAKJfiMBTPOU0rYS57OQ2Lae3crWq+WlRxxB+3J4SaOGjQLG6IP3R/eiOajf6ralyV4aZR0uHPHJUabwGCvfxydHvpTMMJt8r0C6LIvhhi/w0SvGWDVS3W9KCRtD54JGS8Eoykmfd5JwfMeg23u65Ueic8jJSxbk7kHxJarGTup6mAwTdrovtoe2GtRGdvY57+PzjiL6mIvO7HdJ00NtiPhr1Gy3SUhLD7lu7hG1T1hrux8r6Ic7V6ljIuR4SR83KycmnN5wd5nS4ooo3tS6zZVu25Gw21svlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvm8rPF2JAXFvg1pzZeYVXkTKxhhEBLTy/NpdSQO5Gg=;
 b=gwjmTJV8Pm7Q4Fs9mtNvSXH3VFM2bHA+9UfehQaG/VHiy4WwHG+itblmoyqrOtWylvudcDyouVmGI3jgtmOpneb0KtYBVD9beW2bVR9l5h5pPw4XYdy/9KA3fjMTutYjgzn64Shr2L4Ca656/5w7QdjkcQIabmpjS52NigaZpmP2BJBMKfYF3ba405OXiZcOvZCWvCJh3mWLTUpcwloIglWg6LfUTi8Cmf96EMf9Y5XTvCKGS+MsD7QKK9yBAexLB5tka5w1yo/OKFWunVbyO97AQlyu7HO3jV3b7wg669T37I4wNy3S0BXv0ZWRo4EcBmBX+dmogHahvs3krKPo8A==
Received: from CH0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:610:e6::16)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 10:15:50 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::a3) by CH0PR03CA0281.outlook.office365.com
 (2603:10b6:610:e6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Thu, 7 Mar 2024 10:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 10:15:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 7 Mar 2024
 02:15:32 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 7 Mar
 2024 02:15:32 -0800
Received: from c-237-113-200-209.mtl.labs.mlnx (10.127.8.14) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1258.12 via
 Frontend Transport; Thu, 7 Mar 2024 02:15:28 -0800
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <leonro@nvidia.com>, <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "Anatoli N . Chechelnickiy"
	<Anatoli.Chechelnickiy@m.interpipe.biz>, Ian Kumlien <ian.kumlien@gmail.com>,
	<stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: [PATCH net] net: esp: fix bad handling of pages from page_pool
Date: Thu, 7 Mar 2024 12:15:47 +0200
Message-ID: <20240307101548.815189-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: 03df9b8c-8e18-4afd-cf76-08dc3e8f8f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cB/hLgDOroMfWAuvfjPN4PVpt49tO8gEmnON03/t4bnfwjIPJDBxwro21NGtogu9q/A8wWBJ38lC64Dej1rJAmfg9XZPIdB4cB9OCljLWwjRFiIQCffNMss10Zew81GOOdNvS6BB/8b81iZioY6nb6RKW8m0UvVUyT/z61IGjhOE1Syhz85hPq1hpX2aSmVzbsJCB+F4wEBXtrKfqoXmUFTPnP9wgIj1zcNz5TFqdupqP+RsmoQ8R1knIqE2GrfCTkHJkGo0PMi0i6cIHZoJrFaiHc2iFsS2avewmEmX15OkH29TGujdiJZg682M/D1N9wRZiGlxhf6Nz3pEeYCfKUGqU7he861/cjC5R5pf3Dq8ECoDGnX+aL0SgyD7rJcJGB4Wp18YPyVvqI1F1KYSWarCp0tzsh7DnXwaYw+cLELMBZ3/NUK/ZlW6vk9NcjUai1fJYGuZTT5K3Kho3VOFJB2dLbw7okB4Knj4gPz76+mRzPRAFf/mC9MRR4WkwwgwPgbAljU8ugvFGoVkj7ZLiGRCT/OCqBWt8laSsWXgmiDRUSWsgktK1xMo082bNARHpkwocouCrK5m0tDdfQvrKPY8+69p94JLBkwEfiKimnDathQmF6NQ7tMZ9dD0DpU0+UL3eqgzshfCiXzaqMNsmMFQx6+zRMu0tLKYyaUFAODfXgpeiZ8U0CgaDpVAPwRRO1aAxH6xhzLRHJdkAkMny5FsPJAKw3UotqMCuqBDqplZRY2IG6ymrx1woC5G2kR6
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 10:15:48.4085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03df9b8c-8e18-4afd-cf76-08dc3e8f8f53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890

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

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reported-by: Anatoli N.Chechelnickiy <Anatoli.Chechelnickiy@m.interpipe.biz>
Tested-by: Anatoli N.Chechelnickiy <Anatoli.Chechelnickiy@m.interpipe.biz>
Reported-by: Ian Kumlien <ian.kumlien@gmail.com>
Closes: https: //lore.kernel.org/netdev/CAA85sZvvHtrpTQRqdaOx6gd55zPAVsqMYk_Lwh4Md5knTq7AyA@mail.gmail.com
Cc: stable@vger.kernel.org
Reviewed-by: Mina Almasry <almasrymina@google.com>
Change-Id: I3d2744e1abb33a694a8f49e07f913724a0f8871a
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


