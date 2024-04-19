Return-Path: <linux-kernel+bounces-151909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FC18AB5A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B9D284C21
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7036413C91F;
	Fri, 19 Apr 2024 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="E8mxwxV5"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2093.outbound.protection.outlook.com [40.107.95.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F413B299;
	Fri, 19 Apr 2024 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713555370; cv=fail; b=o5CzjXNMuIpbJTttz4Ld5cocwwoP8x57UGl0ZHyt+kgikMv5ufdxiWHeGvM7xnOwGtZ1ehatYL4g7SJh2UFA5j4nbU8o5DmZiIY5Uxg+6629YieKLPDvy4H4OiU5Fwr+wtQ1ZOPnlsRWdFUuvsLHlJVhOaxmGUysiPKWD70As3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713555370; c=relaxed/simple;
	bh=/Bn2g/B4v5LwWP6K88jOFSH2snmbhHGnZS5il/1mUDk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TLCKAMlV2c2AruQVbhXQLVz/8pPzApIb5f0wi8pabuMAShDFXTjFuM0PAijlCGnpGXaSViHkq8ZRv3kJv4gVb7aiOEyNPX+Ppsv6/uXPtmBQ1srG0Lfd3G1AwrGGbhX8z1mpjycMXoORjahw70WEjksnbB7bdSU9CbYtUUmislw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=E8mxwxV5; arc=fail smtp.client-ip=40.107.95.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmMyIXSuKoNXry7h6k9WzfVYao0+rdU7sMYAi5kieVHC3KnbTvarhLkvpjfZ/YLK/1oUp6JVjh91HUHOOr6gqiIL5cma2NQhoWNLp4CP63tAqXZ1chVvQu9UtEJwb2g7ZsE00QA0fofCwE7H2w7mg5fpL1dhOsAuHngAt58DQUcMWOTyWFho9PvMFKbFzIVTgnqa9MDEMMJzU7cF8dzVEY861y303Lq1XAo6tjPldIl6G9kftBUwiK39fRvIxpZ8dzF4baHMGvM22TPj3JByfHN3PSL+Rzo9/sEvKzqIeVbwlSbpueRyBFkAEhOzAvWVazSXP5pzjtS6ji6So+YalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrVzXPets2A8SAAYpz+89rYo1zZwmKOnoBJydx2GLHg=;
 b=PsgKcv+MSLyVRcXVJTCNwElGqdvkNNEg6DV/3wR/vfaV05+U6yrVOStMMSTrs2ug5priX9RtW+uEgnU/a/JH9qMrij7Lb8M8EauPf2ykGdyL+QYybjltw4Udcw4hQF+OIt2/2LBVxStaCR6y556SJgqFbyuiT0Ch7H47bEYcBTxJozURHH1fJAKAj1FJbHsV6aOBKO1EG1gch0l1iTHM0I2VDtX60Y/PZGIEeYcDSSxYi3zMAgudO1Gkg1WKZWkfseQIUjmZiwAYopSB31IK+4vb9vlPorZbkSQgKsB60VyC8upROFkAofmT/6wxCJ8p8jDhCS9wzOMsBm6ndy717A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrVzXPets2A8SAAYpz+89rYo1zZwmKOnoBJydx2GLHg=;
 b=E8mxwxV5D3vojxGoEN8/3TiEPPC/nvXU8ZcSRUiiHtnpDArEAUwRLinceasjgFVtvRp+Ozl9JxKlExreQTabVs1zGxw5VDghw5ap5MO/gAasi6PJQ5Mhmh3T2boPeLfzDg7Fd/aUEti6hNym4+DvHHYWgiXi+8OQ1gQbOupNT8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from MN0PR22MB5638.namprd22.prod.outlook.com (2603:10b6:208:4a5::17)
 by CO6PR22MB2883.namprd22.prod.outlook.com (2603:10b6:303:14a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 19 Apr
 2024 19:36:03 +0000
Received: from MN0PR22MB5638.namprd22.prod.outlook.com
 ([fe80::2041:9d22:48c3:e667]) by MN0PR22MB5638.namprd22.prod.outlook.com
 ([fe80::2041:9d22:48c3:e667%6]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 19:36:03 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH] arm64: dts: ti: Enable overlays for the am625-phyboard-lyra
Date: Fri, 19 Apr 2024 12:35:52 -0700
Message-Id: <20240419193552.3090343-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:610:54::38) To MN0PR22MB5638.namprd22.prod.outlook.com
 (2603:10b6:208:4a5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR22MB5638:EE_|CO6PR22MB2883:EE_
X-MS-Office365-Filtering-Correlation-Id: 566886e9-807b-4f7d-0620-08dc60a7f2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TI2Foixbk/kjWqwWg2gedyGAAkr1OJkcZ8EVvhvpZf6rx7yNaMr/Jxx8DUEZ?=
 =?us-ascii?Q?acIpXY+tnBsz90byyZHYtItl04fTeKuO9zDua5Uw6h2YCyiS7VDVTbYyGuUy?=
 =?us-ascii?Q?osaWKKUkkOjUNN1FKwJnn45sw3uzTGoNUSvOD147Zoj1pTkcxO57net7bPB4?=
 =?us-ascii?Q?ZrpuvNjszN/ZG175UBBr0I0Xnf6z4+lDLH//zV8DO5DJI2uqMy0NVX2RlW4D?=
 =?us-ascii?Q?tmI+ujHGxSK0jfMJW2Zje4nokrURPMpoOiSTtBIw6Kl3yFI2mHcGO1n3OEVW?=
 =?us-ascii?Q?2+9em/exGzgoGd2fKndywFGLXGpq+HbH+Jrdsl1CKk8Yif4OeZB7hESZc4tr?=
 =?us-ascii?Q?HiGvI2byTpA0lsjm0kMmRI9Ma57F6d9NA0Odxdk3eQ9MKWMuIt0fYVFqKGug?=
 =?us-ascii?Q?GzjmGowsFGIzpsdcOchVTIaN6+XvVq72tokA5kQfikDbNwT0AfNXXUtPiDXY?=
 =?us-ascii?Q?cG7gkGxyoDEEvlZP4zewS+B6fdKf/E+DYfVqJiC4UIiYi93U1truDSe4aivk?=
 =?us-ascii?Q?MDpdY+NAjXJnDxjcspt8V9qLd3XQRqfdLXWA1s9zMOoceapeirJ3P4Qbb30d?=
 =?us-ascii?Q?M2yKwBwAqh3Biif5CLd+p0bXAiXHxdKX9/1J1ky3JjSerneOaoCtY0tZIt6t?=
 =?us-ascii?Q?LvoJFJG0rnVr/QqKjD5XXYv7WypQt6xTZZ6MyK/h2eKZ7eFDK1cPxT1F8gDB?=
 =?us-ascii?Q?u7C7/dl7uHb7lGSpJ9FjhlcYFNH+lUjGFGhSpJ5UNlL5HORVm0sgFJbang1c?=
 =?us-ascii?Q?g6S52+AVPWNTqnjQc9FngbEjZKSHXXyDYHSHXAoEPW7M0cBwwjVcTSCJhOSV?=
 =?us-ascii?Q?6/KzQpMp7XyiOZHxmncsLP+j8irg9eiZdOsDaLR9TWP7B06Kj7jjST0ITjCS?=
 =?us-ascii?Q?xnZPz4exIsZhaIlWiI7d+UuEN6lZNVYwsux0rIuG91Rdwxwa7CO3EUx+ufug?=
 =?us-ascii?Q?fu7+gE77BstfFuOIpRLNgu7D8VG960woQQc+5jGry4l3eyGSFdUqHNhP4+3R?=
 =?us-ascii?Q?KvBVnAjCw8x3iPQhwNc55V2F4ZeqTjV1mz7fnWufRVTIwLBKA821SDsyvMC9?=
 =?us-ascii?Q?DOP2KAEJKpH7hOy1rH92zw9mYr4RbeGS0LHjZgMPOo0BSxZScd2Mutg5+6ZA?=
 =?us-ascii?Q?BfnMVYI5zR3SQLkvctEoFaMos+eVSTfnHc1m96sBvlZP7KUf2+ly9sexGhO5?=
 =?us-ascii?Q?aBZ7s6j0d2rQ17WaSGYHMCxhHLh81fuoMa3nf3JbGb09gxOf8G+ZduGQXO3f?=
 =?us-ascii?Q?zcRCcmYtx7cujQUrgb1X1ajeI3H4lIvHx84zJ1jw6VB2eOpaE4xzaxkU9U4s?=
 =?us-ascii?Q?0Wdp4kFpkZOdLAv38xJCN+qCf3gX5IAv0CoOMmMMMVKBiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR22MB5638.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dyxEV+wZ6vsNHpw/mC9vt7D/L9cqNqnH1H2+icI2PwDOjJQNzCnT63K6pXDP?=
 =?us-ascii?Q?xC/hC+rqsUlInuXngL8di78zenkmfFT2MuCO8N7oULDoXYncJLHUTynlb+dP?=
 =?us-ascii?Q?Fon1xsZOpgtJk9XDJAhsg180mehvuz2h1hZpQ5sROxY0+H6mU8TDrbUQgxpi?=
 =?us-ascii?Q?a1H/VJGTbNpu1aujF+iYepeG8P2cciGIcLETRvjyPeSnA9ut4m1oBy/TzDnN?=
 =?us-ascii?Q?ddWZWM4FGQx9pw/qKo1R/xdqjP+0WdGnx8ssPAD3isJW4Q4qbyCUS1xwlxXA?=
 =?us-ascii?Q?fFGwDEXWt/Q8acbefak9PzADu7whWe90lW8QRh0uHuecFwgaJdHzGwZ4cyF3?=
 =?us-ascii?Q?R8Esq5Jo3gJUbHLhPtrQti7Q85Toybgp38pdHPjLR0JfJrZzmLGshGW5QiA2?=
 =?us-ascii?Q?gkVxPt2YscDeoSI7+lWAy9jJK2zhZzYSnZP/8HypfteJnFLM3Hmg51IOOekv?=
 =?us-ascii?Q?Un3R4EWHYFgtEF5dmTHpaNJLwtO/m6tccMP7OcM/EsUKv2Q0ESgA4uzIuL5S?=
 =?us-ascii?Q?vBqs8eq643EN9hBlS+Syv0KKi2mZNkilLA/4TA/sk91zDAjr4WSkhPaJxU3s?=
 =?us-ascii?Q?41ZsUyxYhrcWxm+IfmETP8WcSfB9/pByN5c8zvwTtPzkX23oICs5OC5K4zJO?=
 =?us-ascii?Q?C9cAA39uhaUVATEVbUm5KtvG9kF4UsmxR/FeZKOd0a963FqORhESLdhA+aQt?=
 =?us-ascii?Q?hmfOxMb66T3TJmqhh6cW/gUvRrAAsd7ljGsQsTsCCVbdZb/8BUiWp83IPXwZ?=
 =?us-ascii?Q?G78Eo2+54u0ZVOPbvMuzznmg2vbzTsPAUm02TB1z5ZHt/wijERRt+PwlYYLf?=
 =?us-ascii?Q?Rx117yIRaM9SzeLGs8mn7nYmhzAq9G4uWkCNetK1kJpd9hJyahMLpyA0SNko?=
 =?us-ascii?Q?68d4JJsRIy8zknyf4yhMfFXK0yhl3kD8hzia425jKo53R1pUp48/sAX0aHLm?=
 =?us-ascii?Q?7kmNCpve4P3BjBBagv+HwpRvmweAO2FyMtjqvqiamWU/c9lffaJyZpkNeiZv?=
 =?us-ascii?Q?Z/b4WLy1RZXSROvWoFEQVNWp5z3XWsAqAs+9tm960lJB8cdeJLKB9Fdzn5hk?=
 =?us-ascii?Q?5OLKPwXICVl/Rke5pCmPX0/tacQXL7Gex81a86YarqqezZvkA0UkEwvWUlgc?=
 =?us-ascii?Q?KQ1CzSoabfTyKe07vd9Gzx0AN8/B//mNeiV3L1oi/2J19+eWqafiLGg4uJrl?=
 =?us-ascii?Q?13E1km3IGuHfbt7UyHF3vtAGOSkVuJ9Qq6ys9hBO1sjmOpyDLU22luACWb+A?=
 =?us-ascii?Q?T6IQgkZLdiYdU62fdnQ+gTdl7Ekho3lO75+biEtZNpucx4eoueZH2hiY7JAu?=
 =?us-ascii?Q?rKdwsIqDH2CFwHsYYY9nw8z+MVOcCbMR4HzWxDI8YYMK/CuJVVljgEkD/VVe?=
 =?us-ascii?Q?iQ0/4reyFMw9o8MYSGeRzbRrtx57E+suS/1x6v3/idRj7yv5/SsMB6CyRQki?=
 =?us-ascii?Q?l9rZFIw6NJWLE5ESCumIwN91Nswo1DOG4AnFZkZyEi8OWhfVxEi2/qOdFu8I?=
 =?us-ascii?Q?dZ8kT33OqiI0uWVZMpjmxCHWWcdBzyftvv+uarmopvRhF72GkeyWDsOY60Dx?=
 =?us-ascii?Q?JR5cOLb9k90DsonIwC1Vph+yKD5yq5Y/XOuWNgXz?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566886e9-807b-4f7d-0620-08dc60a7f2d4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR22MB5638.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 19:36:03.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KXTnAyTXr3UAkwqis66iIYi52GjR3lGHOSnck5w9QNpKtZY1vF6dbgNpqBVZArmcq0jLABLCdUZfGrqKVG8Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR22MB2883

Add symbols when building the am625-phyboard-lyra-rdk DTB so
overlays can be applied.

Fixes: d8280f30a9cd ("arm64: dts: ti: am62-phyboard-lyra: Add overlay to enable a GPIO fan")
Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 9a722c2473fb..3fa1257efcd3 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -169,6 +169,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am625-beagleplay += -@
+DTC_FLAGS_k3-am625-phyboard-lyra-rdk += -@
 DTC_FLAGS_k3-am625-sk += -@
 DTC_FLAGS_k3-am62-lp-sk += -@
 DTC_FLAGS_k3-am62a7-sk += -@
-- 
2.25.1


