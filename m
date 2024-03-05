Return-Path: <linux-kernel+bounces-93063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 416D1872A59
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BDC1F26BB6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EEB12BF0B;
	Tue,  5 Mar 2024 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cszXFKsT"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2053.outbound.protection.outlook.com [40.92.75.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB891DFC6;
	Tue,  5 Mar 2024 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678597; cv=fail; b=HlOoDMfuO8RFS+hCYq75g0mw8l7bYjbKCX/rAzCJ1p/MtUBFuAoR2V/zWZzxXf/VnxXlG7NHUoCA2wbTAzm6KOTOz1koEK+fzzUfrk2IxZBeyASlM8AYZdbyGbLMeeslOLjzSSr962UxVPAMT6Ccqw1VTdS+XNO1uldOPB0jmG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678597; c=relaxed/simple;
	bh=+N2at5TkHLzL0qp6uQ0bREV7+Us2L/MdIXkGePFeeEs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Or3L5nWSbP2LcRql6ORYWntbt3TWLKfrbpuaScMKwsssqR/OFanGUshwlAiGGGcQQniMqa40fElXnr2rMQeIHzkpSQVSFhMmgs7UPPxWtkgng4gH8L29wXkHTOCOFcv2Dey2skD6nnUSnGJyZXf75Wh1KxPD7oka53KCGCNuFPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cszXFKsT; arc=fail smtp.client-ip=40.92.75.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmcZtoZPoWZCUFGR6Iropvtda4w4VBwbEMMTBXKTGQNt4vh0J1OIX+jKqSdyBdpJwEWC9rZJ6YnaAnxWHCRPOeBOBZrGf9Mvk6I8v62YSvSMxKemLiD2XxnYkIPMLrCXBh//a1csnM+0+Erq5qwFq6Q/SksqGX7VIgFSL2lrqtNEgbhsosC0BW3rCAJAr7/vbYydcgb26SRrTUZFexICtWAYCk+SD45fzjj+1nk0qIOL7ptH/sAZL6dq21S8ND4+0NxER78WWEBydGS8rGDng6BSkOQZ4Lwf49/KkrcMEyzAGAXRj94I7b/SfrD5JSy9Did2piMiidoYXTLB7HFBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yZ+caKFlgX/wNpFZkf8AuOASyr/PTKZ6E9Nqi+9QY8=;
 b=gpkgK/savzkEZ3aXijCA1aCI6FSpM+/eX/zbJ96yi2yOe7gcXQuMAL4B8r+NQQu+8jbCLX/08NvieMfaqKAV1xpp67cO3VGiQNhiKnh8uw77l4YM4pUCUW0CP1q85f20cCpX66ckQTNymOgSwcVUHKhzRmHLEwxQwaCFLJRV4gCj/oEIyWwOymaiQHH5iqlHK/FpXiy3/z/BnoiQfQ7uObRTw7AByHljAcENFGl8bc7MT1l/XgTtmU04ZGIsOg4nc3EusRlFMKMDUn4U0K64qEfiLnVmp9CszTdlEEpyioYRhALGZVufUod5Dmzfpb0aYAjHhSILAE+V26KhNk7VdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yZ+caKFlgX/wNpFZkf8AuOASyr/PTKZ6E9Nqi+9QY8=;
 b=cszXFKsTAOo6TuE4YxxAWg4f9Rt7OLL7TOWa4AQwK5tMDJuEAgRk23XIChDaHmMyjCKmm9268+kpcuj2F7EuYDgm0fcKXx7jjOSQUeKqT5XSzOlRhWRgGP0Zyflojzp44ffDmxRymSO5HFTwquDVvEkeGFZ1g1FtGwZ86jFxKfWJ+wcbqes5ZQ/k4J0E/Y8QDYghdU/3aMYOmrJduxiXeHFIVr2EPRgEXR1FwupgIJ2dPC0s9iG9istvoCeUeBYGSstAoEUsU5Tu8fjqRjOrpAveUkZM8PhDMPU1kgVCB8rvalJhrhs/4xTEH7xSpVopx2vT7ABlULhbQndnNt4n5A==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by PAWPR03MB9058.eurprd03.prod.outlook.com (2603:10a6:102:33b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 22:43:12 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 22:43:12 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ipv4, ipv6: Fix incorrect skb->data_len caused by __ip_append_data
Date: Tue,  5 Mar 2024 22:42:05 +0000
Message-ID:
 <AM6PR03MB5848A1EE8F0EBA45D440F8EA99222@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [CaqLcFQP80ss/fX3rk8+s330xUY1iVvU]
X-ClientProxiedBy: LO4P123CA0113.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::10) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240305224205.16204-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|PAWPR03MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: f52c0248-58eb-4df3-3fb9-08dc3d65a30f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fEhgVwzTs2PnMfZ3a7obYwngurAIYe33ISh6ECi3tLm730tNF03ri4gKiMqlAbDt/46FV5OppaG5/AJAip1iii7iYTPfUHMaiOsQYbsqP1aM59BGyzUl+i3evr/NiZozF66rr+ujRAVvGZA30wYHULjFCJ6YPgYA0vDTIwgWd5X0rsIQQN8uQglYQRCVu8/r/3Kf6faSxP7EMKgEa9y0T6nNy/mHs+OViLaYnQAZ0I8PVYRFab3jgcXOJItQUpofVpGhMHRH3x2/f2RbskTum5S067QDZHjZNVV6NZXxQOlToTXZ9sQKT6p0FDRDFKth3F6DAbNLfymofD3jx5nCcrbN00uxeY7moIia2PHFeKZyPk/0YHaPiHf/afTEViVBvslHtqxVicbdaGAPDZpUUCsVKRhmFNvJtEwrreB8ypPiQT3dkFCGzOGHWPDEX6TFaP57ozG4a1/HAEbyjBeGw60RIRs6OPAfHQAnnYrOVxqc6dfAJ1mJnhIUkTopy9fzdA8eqR4rNIYH7eJUjqEePyJXstBUlF8ladZ6SEfApI4Cm6bVSHO7cYjNTHdFxj0W
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K2HBZ/PTJhiYhGWyVQg/EtBmqPvbHlQI8DAGEK8ApQmP5nWnDXp1O0lvavvW?=
 =?us-ascii?Q?edIiwsU77Js3+VDc2DA0C8aupYT9Mz7FYQVLkNcUK2XUobQp2mOBJkZM1up4?=
 =?us-ascii?Q?r0CkrbsLqBZwnZmehMtP5/oZasZ6HrGrU3Y/0oIk4hZ94EiVU5MYmjoJtal7?=
 =?us-ascii?Q?cY5vEH6oeulgg68/ZMLeFXOt2Ivd/pn68ZVSAU+0tx9YazfL9E12ftr0V0JJ?=
 =?us-ascii?Q?jvz1r69/X3X4R/1741oFz2K6ICRThUjdelp9tloSAcP86MkKkXOP49+DbP7y?=
 =?us-ascii?Q?vorv3LvhVGuv3d57Sokv6vhv+3HVOjJepiMiIIlNlToLL9IbURXr2AxlJKpG?=
 =?us-ascii?Q?TcE/9HKvYxk6qUbR2p+ZaY1kLKg2olXqISo6MisadDEyFc/O0HUUHgKn3gzs?=
 =?us-ascii?Q?bJ72IYv5s8yyAZbbCeOy5ytwEX5v7D75KJ9sOIzc+Iswe2A1CdqA1WX8ldUD?=
 =?us-ascii?Q?V9hbV4Q1Zuaz2QnWWmFV016EBtKOwlsfhLUEHPTtzG6DJHcq5uKbdSZSDhDM?=
 =?us-ascii?Q?5wRqOjWeV04bKgAsDKbmvt2th4uWuLR3N/qHTAmlbGf5hTWUyXNQm6o7pkgR?=
 =?us-ascii?Q?RbLTirrsHKO8GCwPxzXdMyFfCdCfmsFV68KRiUEPGfN/mb/mNojCjvdMnrO0?=
 =?us-ascii?Q?hVXlqbQo0N4ljNfzQEiqj67uWumaco5P6e831kIORepkb35wpt7+b9GiDigt?=
 =?us-ascii?Q?Lnj/ky7BDbkIdvaK2CO1xolj+ai+NouJGlyFNnxLgpEZcBKsNAWmWtm56422?=
 =?us-ascii?Q?lzT/dZ8QiJToO/UtCYYMRP0Yz3/enG7HNNARtczcfFn0uREvNiqSLzG1tAwS?=
 =?us-ascii?Q?hpO6b+VU4W57gkjkDfLCGn8L4OjIIeCQ+Lat4J9NCaNhG5WuR/iVXRw51P5A?=
 =?us-ascii?Q?i/iFo0H67uT9xHLQdBb2KnPwqJE0bSQ+iVtl+xLFSgRgfo8Z0t07oICfsC+D?=
 =?us-ascii?Q?lIrvJ+MiY4aMeouqT2bVY/QrwsPaS9no88DgadCk14nMm/XOQWD+FKPZdJ09?=
 =?us-ascii?Q?X2qCaUYtNPtzcnQGskGRpXp4K4ellfQHoX42N01gbuWWQBxJyYt0zdj2/4gP?=
 =?us-ascii?Q?09lLiOx13dMs92LU1g3LLnC3Og+x5whwc4gB9+2AZx4gFsLATpbdi5Qn0t2X?=
 =?us-ascii?Q?B+aAdyQ1OOKe47C3kl2HdQzo0JI9KWxWp/xs7fMchLJNkMW3yIBZUDm/vUav?=
 =?us-ascii?Q?KncIzn0ikZPXDp6iKIIzZytw86oskHZeCCzstarTKy2ErHgtvNDcTQSWLhKu?=
 =?us-ascii?Q?EomdTvL94SFv02guTDXb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52c0248-58eb-4df3-3fb9-08dc3d65a30f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 22:43:11.9212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9058

When __ip_append_data allocate the first skb in the queue, or when the
size of the data in the skb exceed the MTU and require a new fragment
and allocate a new skb, both cause the size of the data increased by
this __ip_append_data to not be added to skb->data_len.

This is because in the current __ip_append_data, skb_put is used when
putting in the data for the new skb, but skb_put only increase skb->len,
but not skb->data_len, resulting in skb->data_len missing this part of
the data size.

All skb processed by __ip_append_data are unable to obtain the accurate
data size based on skb->data_len for the above reason.

Also __ip6_append_data has the same problem.

This patch fixes the bug.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 net/ipv4/ip_output.c  | 3 +++
 net/ipv6/ip6_output.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 1fe794967211..42686be0a843 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1171,6 +1171,9 @@ static int __ip_append_data(struct sock *sk,
 				copy = 0;
 			}
 
+			if (copy >= 0)
+				skb->data_len += copy;
+
 			offset += copy;
 			length -= copy + transhdrlen;
 			transhdrlen = 0;
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 31b86fe661aa..2091b91513f0 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1689,6 +1689,9 @@ static int __ip6_append_data(struct sock *sk,
 				copy = 0;
 			}
 
+			if (copy >= 0)
+				skb->data_len += copy;
+
 			offset += copy;
 			length -= copy + transhdrlen;
 			transhdrlen = 0;
-- 
2.39.2


