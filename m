Return-Path: <linux-kernel+bounces-90355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC4486FE05
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7094F1F21922
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E88225A6;
	Mon,  4 Mar 2024 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XYJypDTf"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7398222097;
	Mon,  4 Mar 2024 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545799; cv=fail; b=GC8I+aC9kVxPSbm2FTv42Zd/Nv2Go9hXNvfmSP0/lH2xIxwa6zmdFGw/Z9+e0IMSRR/QWrYM6Ec+hDNlPIwh9Yk/DkQjjzLPx5CSZ7tJJFekuVj7HwPYYpRoGQRIXuMdt//6UwC2CluOMzh01iLzsCqu9SEu28YUCHm0yCtjHuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545799; c=relaxed/simple;
	bh=dW7I15909uvL4JCjyK36yiLHQGv5DczZ5Y5kjQ1LA68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uk1MX0AAiZ3PRQIejn1yvUKeF4HlLDGMnf8bQ59Tf03QiMSLIUqVbt76pDLv0ogTEI1GoTgbmI0wzsBIjngIO03NrOxYukQs3vhEPbRItvRG6qVqzFvhMH8oxsEu3KPWrxlbn/M7NLN7unXFA1AjX8fW77069wcEH+0ANdP8BVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XYJypDTf; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbWDRfbai5vNukS3ArdbG1wvYATG6ImMof9+6oYTGRAZfO10FfB5uU8MtLB0+l48Gy91lJIHFjevSvCQ/B+yxKAPHVvWGZcOr/z2s2PAMR+ClAdzlQzxE1gdK6UQzGrb3OJ0gAREnI06cgh2RmMYpFHL4yW2iFycjDr94x20sLvVSWUCTqN5BVXDxucCUKndYY5D1HnzHzP0GPW1TIQonzq+k/m0e96JKao8w88YXAyE69m48e22uhbOCA+69ccQtmibrfzFf5ksMo5xP65KmK+yIWeTKQTfOjWP2rg+mZH/qIb9oi+2+BZ6hgR96kTAPRZn4HMPHVc/tUs+TVyFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALmn7F2BvGTpSrBoF1l8sh0oiICfdLtXPeNQUFN2XCA=;
 b=LTSTKs/hOx4HQM+4NOVTkzcjZ1X+5iZwedifwqHfZGy1W57oij8MTXQMGCALUgTFgznVcy5zTsIAR9EieHz3xOx8YwaTusd7TVqVyZT8Jvv1H58mduvd7Yb1O7bChQJVRmy5F7mlW1smrI6+Cw1OIh6Od3MPQ20CduaTvT1zjQI3AX5v5orivZ4d7RI0jIZa8nWZdbUxtFZ90nE+VTNi1QZXPJKkb468e0F/XSjMVPun2+SvLopgRBHFHiQTolN9RTfKxh0FKJpJHQv/CSb1VIk5TgIWhZV4QFmiMZsNyTRjYA8n7HpvBBLr2L/D21xPLoB5mVuTHQtQtJfh6JPwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=secunet.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALmn7F2BvGTpSrBoF1l8sh0oiICfdLtXPeNQUFN2XCA=;
 b=XYJypDTfjlaN2kV+6m59sAyzEez3faXNrz+kzp3Svc7UPoHkGLSAwRGjiYcU0Ix1vcSTpw77N/5z9fDmj9bKCSufKg2D2yxR+yra5K60Tw9onwmQo0R8cTzo/S8ITp3I1NRze/Qw+DdmlXZ9B4kfcagmvdScNrwJh3gFz3+LhzbD+B0kY4to819RPD8TiI++xs219yJVxKpqUMkNgxlwNORoC9OuG0QYpUzMqk0le19D2eJGObi3ltZwjNfYZX+SUd4mbtetXg6I7vr9niBjvjmx263+pFZ/ZewtFEDYy4i1Ctwp9qokni6U3vQqe/qpTdjSb4mCzWvBDzBXoX89dw==
Received: from BN6PR17CA0042.namprd17.prod.outlook.com (2603:10b6:405:75::31)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 09:49:53 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::2b) by BN6PR17CA0042.outlook.office365.com
 (2603:10b6:405:75::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 09:49:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 09:49:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 01:49:36 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 4 Mar
 2024 01:49:35 -0800
Received: from c-237-113-200-209.mtl.labs.mlnx (10.127.8.14) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1258.12 via
 Frontend Transport; Mon, 4 Mar 2024 01:49:32 -0800
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	"David Ahern" <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <leonro@nvidia.com>, <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "Anatoli N . Chechelnickiy"
	<Anatoli.Chechelnickiy@m.interpipe.biz>, Ian Kumlien <ian.kumlien@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC] net: esp: fix bad handling of pages from page_pool
Date: Mon, 4 Mar 2024 11:48:52 +0200
Message-ID: <20240304094950.761233-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: ad13d58e-a77a-4cae-78f2-08dc3c30709a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b9b3FOnViBiE1pJu3drpoZmc2QsVYhy7cEfXmxfZTqLQyQDFS7GcoB6sIzSxqiZm6G/fWAXlawpVJYoZzUdacUDz0E70hS2qL6bfYGg8DQN+m4VlIUllc13ApGFPhxkX2zfYM/b59eFXs7MiDlHai0OZgqGGo1u/H7mjE+/r2NHWu6NZYvbp/rUMlMAZr/GZaf99dsofvjRlKcPGaj2f1QAvni7aHr4U/LkudAerb3wGCkVxM91lGCWDoiwkwt46y1wEfzZRu7LrKvyA5RHIvBhX/plopl4tm7U6s9ZZ5Do/vzqQrUbcrxwLhiKayed7r2KznrmY9LtXIA6rf/pFC+CllLzj27gAz9oRBNtYbz1MUS4TdyaaePeLdyjRkfOfkV6yqawYdhqwT7G+PgxbJ729PgGPFL4ccZk7zeTZsAltJWoL3RhfpY1t29N+nj6jEa1CmbHEjxQ8jw8cu9GR0hf26hkxx9/KdhAwmDKzzr1m+qIQKEkZbTzK6YHllODcwp7IZ0nXxcnBnSuVjR7a7grCOU+6maBQHnEDDSLa0aQKXWbJmjKOmnxiDPTcjVGzXECeN2fc5cq5Ef7WlsVNRjIMBWWs/NT+TMEc3m3k4DfbWNLR5Nqoh3fMCMWCjO1n/RK+yKSrjcB02qVbyXqQXbdE9JeBSl9TcQU/OUalKRSzgQd7rLWk4f0izYybt+N0aKSj232wz8WGrv85NiiHAO68NT74Z8ln4ihN3Hp5kB/Ql8SKVgs/nBgVPFUdJwqj
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 09:49:52.3005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad13d58e-a77a-4cae-78f2-08dc3c30709a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654

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

The suggested fix is to use the page_pool release API first and then fallback
to put_page.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reported-by: Anatoli N.Chechelnickiy <Anatoli.Chechelnickiy@m.interpipe.biz>
Reported-by: Ian Kumlien <ian.kumlien@gmail.com>
Change-Id: I263cf91c1d13c2736a58927e8e0fc51296759450
---
 net/ipv4/esp4.c | 11 ++++++++---
 net/ipv6/esp6.c | 11 ++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 4dd9e5040672..3e07d78c887d 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -112,9 +112,14 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
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
+			if (!napi_pp_put_page(page, false))
+				put_page(page);
+		}
+	}
 }
 
 #ifdef CONFIG_INET_ESPINTCP
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 6e6efe026cdc..b73f5773139d 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -129,9 +129,14 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
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
+			if (!napi_pp_put_page(page, false))
+				put_page(page);
+		}
+	}
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
-- 
2.42.0


