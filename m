Return-Path: <linux-kernel+bounces-67563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE40856D82
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEA81F228B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B30F13958A;
	Thu, 15 Feb 2024 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="D3+5OjrM"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2105.outbound.protection.outlook.com [40.92.73.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38D12BEAF;
	Thu, 15 Feb 2024 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.73.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024680; cv=fail; b=ZN12qxSnCosLsaB7eNDI2QRd95uECYcBKlz7fFtN/iB3VNKufJpvPvFPXLZRdsKBga4i/XG6WlZDMQJaEs3NEUaJx3SVwhwh/KCuP+pGMrT0DNJNchtcRUTtii40Krm1q6TH+1fjWuk8GYgKv7gOTsOuMZ/VSii9sHNJcMig1k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024680; c=relaxed/simple;
	bh=BUTp6l1OPP1f5Jngx5k43OXgqF4bQ2AvRAEboSnXzHw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nsDRic7EOSmoU0TPTouiWRSH0bDkBL7/APGyIyHbxy9nd1nG7vZxmI2eoLTODdcAJV4zLPatiMlHIvMcSLpHBJD3iX8uAqBDn18bvqqB/IWZWCPIlVitvJEjN2HOhzxujblREGG7j2UiSbYh7WX/oClaCGEYABQD4pKMgqrNa9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=D3+5OjrM; arc=fail smtp.client-ip=40.92.73.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So/jpOxhMeScO/KXLoov5jwTmvJbhylZlZB9ngcCE9VCwQcrA37sBii+C9Hk2GRPsXY38YV8ZeOjblNzra/0y/y5+32GW9zUZxrBC4/a654fUDP1GIa0zw/jJOy6B3yDZzPHq/RH2zI2TlYwyCgabLWsM+Yl1NVa7SAMyt9EcsLL1ovvmEz9p3+grXeH+lZTRvCX8V80DpVa9Q57H4kKKoo4nF6A167l7K+xgLhiqQIY0CZ6bSUHa+gVJyLoVZQ2/bHOyKLt51/7r77/ZtwNc6ONncdHTWP0n+nJMCE53W5xC3u8yJGLgOiCHSt94mYlhBuJ+dmyC2lvBc+BXfsCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clT4qt/TkJCdoqftxMl/h4sVvqEPAyVqVotivf4wvKU=;
 b=DZU50yl+2GfvXdUBZ3IJJxpC6qQwHAo5nGPG4PFfbyQYoOUS7zvDLAMrbl953MD8T6SoU9dXMXjEMv0R0VOGcRiLFvDFsTuHm/a8bcT39zJLPAevZF8btD5oQIRoMcl/g2IQ+B5G6LwiusiuLlNoO4zW1j2Wfz6E3Xb3+cCp/2lQE46p4NzhfIsrwWAuWJ3TnP33EswRzaSWRTUw5m5gZq9EZNeEo6vEpFWEM/lf7WC+FSZpEqUlqmpQrANuQ4KzCy9seB2hbZrDrvdGI1dEYYH9LkE8bQn1PCHUYgPosYSKbYmLY9Ch1UUGuBif6yyzI1WtLsDnwE1ys2iyqvjevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clT4qt/TkJCdoqftxMl/h4sVvqEPAyVqVotivf4wvKU=;
 b=D3+5OjrMqGQcFzM/WUvlE9+IXRsMCMQ36SYxUUPgAPYU7eH2fu97jpIPMVLPxliox9/Ridd8/P6SEq1yT/tnOvLvwzrgEzEeSgOsMLJ5tBr6M6WkrV/GKUZJDdi+U/6U1bB+/PTi1iz5B3v7yNn5i9R8os8wxdN4At9s5RsBwAnDVAiuGLNHAVQyTFUPU3zQrnvljNDXP+nNWf0ydVIF1svA+mocf6yqfrhoxhVv736adKqDhNMTQEJKZHb/Ka5cflOUdl7KJalerflKMUu5/CAaML3MYN9fQu4KMRmsPA+9QYdA5lHlpMlxO4CvwkXUO+hwP60jMbL+brNdKSc4nQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB7064.eurprd03.prod.outlook.com (2603:10a6:20b:29e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 19:17:55 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18%7]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 19:17:55 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	corbet@lwn.net
Cc: kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kasan: Add documentation for CONFIG_KASAN_EXTRA_INFO
Date: Thu, 15 Feb 2024 19:17:23 +0000
Message-ID:
 <AM6PR03MB5848C52B871DA67455F0B2F2994D2@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [7syb3p4o9NNOOt1pBPNJaw1LkI/E6JzT]
X-ClientProxiedBy: LO4P123CA0627.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::15) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240215191723.35167-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: b05df645-6d42-4c76-dd4e-08dc2e5ad044
X-MS-Exchange-SLBlob-MailProps:
	AlkLxVwsndmQJIsjirGokQVJ/lfvIDvZhrdTXLfBIxJFaJ+fkGENmPRMB/mYs8cowYRFp059SXgeymq7Ik6IUT4lbkOPrdRgOSqODAdpsDcWKhe5Fh5aRCPhY/icX48ePMLqki3vSrRuyH28r1mO0e/4SPzYJQL5TJt8vwxUnGg1oczeL6R8RkO7JjY2OODFEFtCJQO+m6eVl0sg6nf/gUBiYReETGebCEvJHQA1khRmIXSIFFq6qxPhsDU0oWhMAbFkLwa6c4X45YZRDSWALQfysRUlUZ306c1qSVaPslyz2u8YVJlH2C8oqXkXgKiPj3UgwwoZW0T8/k2SsqVNpF6vRXNRthgXcB4IR8AteQO7/jBqHFkSHf9ozfyD24RmeFBhOxMc7QWC3oGoiEFMiusHnuuEzGaEix9EsC08GMoaCZnWO9IAVOahWYqZ5jCBjEieBx9wwa7AlGl3a1F5ura5+l1JcA0csW3A3xXY5v7tNwXNlnw32+bJm5tvnuQh45brPfIOuRrsWgmNbPiEtUIrarDvAxte4NaegSHyysyywIz8WiqCPkmBFSXBy89Yw6zA8dJxTJFHOgj/a9zD17gdJkORm7HhrF+NVe9eJ+dtPfPvJU2zv8fHPI3l+61CNzrbIAjvQ6RdFq3qiLUQLubNDKfM+rqmfnjGYOr7ngl8CxSz0/F2v4eECIa6e19TCljpkYVDubSi+GM0Q3XNoiu5yTpRHdenj1ybn7RMMJ31ftccoDleDY04O+++YE2ofmgLG+r5US3NM87J+brTKCTT7QlAplEB
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YlTMErR6FDS9R1TOkNZ05GXB5XPOMaA/aDbNITeg+lqN1FnXf/HolqilEcUmoGedWhmbWYVNUI+yH83t8qaBXI/9x7frtGPuRqr6pp4Ppx/yCSRgMSBqWupGXV9ygQ89rlM+fcNqvhVFnKSXm0xB3sxcEfmT4yy9ufV/jYz+is2SyAVO8O75xoQOdjG4eMRJpq+SffaRIGRfMcCuqgYQMp9WWDuTp2yc2k0aza0sOE3WN8Oy+coTDCZ5RNd36EqMNft8eGXjpRiO2M7i6597WfgT31unf1HUbDeUoE1fe0pavvkTNsVvhDRl5F/czGcEYtWTDJFor4viOat67UtdqIBdRLXnT7fTEes8xAzZj9Bz4PFPO+4pE0UZavxmwLZBOfKxj1etyVqaNkAH45XuSs3DsdqfsEQ3tfgId9jmcFfeh7KQ5hNyboOTpQnPxZyY9sqf+IvNoEuCd7wvl+9QXh+PVgJ29boPTTyfzXcTD5PJVdYG68RtvAc8BPrYWoDSOsGFZD3PLknbZVcY4MJq0Qb2npLnFIIwI81Rpo8waX2VnS//lGa38GRkq0/WKf6v
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9OzFaSswNo9G2D9txM7B7QtFuiUyLmwpsarR9TUcZ5sWYm4k0c8E4Ei9rd9S?=
 =?us-ascii?Q?nImPZ6P8zyKMykAG82p6NUnVmXfYhLzjElaU4swMWXkvCi8Pqpi9H5zJiqCJ?=
 =?us-ascii?Q?kAEU8pHQewJAsYWGf23YM9muhjt4DybOkrNSlev3WhUlR7YtnxV3yZ+JHI4B?=
 =?us-ascii?Q?XkQevuTjSz8zlvYw37Y518rAc345YrhLdn6si+W2atzRPPFSdcl0EqnEwqm5?=
 =?us-ascii?Q?JLs5QL1s27YoQvxDVGGvcj69Z4a2luZwmbXAcohAulmBtphQF881geD76VfD?=
 =?us-ascii?Q?Jqan/qQIuyOgRwvHboi03QddzQIt9eaC8t38eVTcaRZqZlPB1VgfDiKQrkoI?=
 =?us-ascii?Q?GEGrvV/E8XtKms+9gf12hf+6Z6wtma50m1fYJUZ7yjT++aVmuV/YQ1KAeG3A?=
 =?us-ascii?Q?s2AxAoX08OpQTn8K1WZmdKEIh6qVI0RT7oAfeS60iCGkcoLSOMoGPfbcza28?=
 =?us-ascii?Q?FK7HPI2W3oJqMnNYFHpFD/BUv/yUGTyFUz0UI+2p7NtOuSff8aH/I80OD9Ja?=
 =?us-ascii?Q?5GmEJLITPj3/wKnrrV3lylQ8mP089Ty0fVCBlLhrl83FXg/bP5egvyStYVkU?=
 =?us-ascii?Q?/SevW3p3hGA8Lf3Ew5eZU+nBu5i/JGIDmXtYGTbb3mjKbNvqezZyUQvwT4Z/?=
 =?us-ascii?Q?+fomMAiG+2pBfEJTZHw6D/bgnQHvK/AqB6RgCMgT6T+vLAGhHrEEfObmy+Px?=
 =?us-ascii?Q?yiw3q4uVMp0Uo9DcK4dpyrJSfGZO9Ztyedpovi/NSYtt7xUyRG+MiaDGKwa5?=
 =?us-ascii?Q?N6MQk+3n8tW2hyCrzcOdswZQWoexkPZ6Vh7KRG1WY8//jQMD6IydITBKsbCi?=
 =?us-ascii?Q?wYY24wcfalMZiIEplYD/WRcBQyqHefGvpOtAO9hSlet6qdAbo8zHAcnLlds7?=
 =?us-ascii?Q?FxmQ51YHqiMbbitH3ZRcLSOG2yy6TBEhUC6tfyvjjjN+spckjgbT2N4EJShL?=
 =?us-ascii?Q?fHw7yicnfBBkuZy/51/mPs7e7vE8VPbTqCEzplMOrZanxGs2FNs430Brmy3U?=
 =?us-ascii?Q?KJuURtKXNLSnmOgeQqUl5vD4eQEdA0AuMChjaipcO+qFXcwCOQ04IWRTCfHb?=
 =?us-ascii?Q?cblMck3Z3dPwAojTFXaIaSsc3GbF+RTQR9kQJc54hMJxq+9pERofF5PYXf2w?=
 =?us-ascii?Q?/1wqCaCaI9yMHqxajTiNSh2g0iXX0F5MTQrzhFbYVzrqvXRe1dGAPzEomtt9?=
 =?us-ascii?Q?FWygJWoM1+NRXu90FoasO9m4R/R9bpSyCs9MsXuuCZnsvGgW7CwJwgGCgZwA?=
 =?us-ascii?Q?DDmiEQl2X9o2qp96r2ko?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05df645-6d42-4c76-dd4e-08dc2e5ad044
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:17:55.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7064

This patch adds CONFIG_KASAN_EXTRA_INFO introduction information to
KASAN documentation.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
V1 -> V2: Fix run-on sentence.

 Documentation/dev-tools/kasan.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index a5a6dbe9029f..d7de44f5339d 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -277,6 +277,27 @@ traces point to places in code that interacted with the object but that are not
 directly present in the bad access stack trace. Currently, this includes
 call_rcu() and workqueue queuing.
 
+CONFIG_KASAN_EXTRA_INFO
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Enabling CONFIG_KASAN_EXTRA_INFO allows KASAN to record and report more
+information. The extra information currently supported is the CPU number and
+timestamp at allocation and free. More information can help find the cause of
+the bug and correlate the error with other system events, at the cost of using
+extra memory to record more information (more cost details in the help text of
+CONFIG_KASAN_EXTRA_INFO).
+
+Here is the report with CONFIG_KASAN_EXTRA_INFO enabled (only the
+different parts are shown)::
+
+    ==================================================================
+    ...
+    Allocated by task 134 on cpu 5 at 229.133855s:
+    ...
+    Freed by task 136 on cpu 3 at 230.199335s:
+    ...
+    ==================================================================
+
 Implementation details
 ----------------------
 
-- 
2.39.2


