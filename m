Return-Path: <linux-kernel+bounces-39641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8603D83D41E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0034B1F2579E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14010C153;
	Fri, 26 Jan 2024 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZRrwRFmE"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2033.outbound.protection.outlook.com [40.92.18.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8DBA94F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706249098; cv=fail; b=pJ7A6QDoZSfl5Z79gKgUu7so4WfDenHezCEgXWY/1ke2wqWk00nDSDgFuGAZmeYpArbpxy9vUtetYHLMN41uxh3iwGImbT0BPiPJqz9v5l4yafh2eJVNHamIGzfZ7gyfbP+vxT/tHWzL3iduSfXzMyHplhvk3urQkZ5Xjg4rX1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706249098; c=relaxed/simple;
	bh=Krbj/oF1oDeq6aM+Zt10oxaC9rLQd4fy5A1r/Exjg6A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DW/b0kiSZiD38q4/hc1SurZRKikYZvFvgTK26nLnL47zZ7DzA9UIs2xI3zJiHmra9LMohmasx3Syj6gq3a7S5EZfbURu6HVskSZCSclzAYMSaK7i3Rj7iWk1yT1bzLb3vNGWCoErRtRNQmQy5b1eLRxwnLjGtENODMd5szi+L6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZRrwRFmE; arc=fail smtp.client-ip=40.92.18.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fScpDtVuGPTekKP3BNW2iSjPIDC1OC9/i8mOt9jDgFawwdE2HnBhbenYZS4SCRzROJu1FxNJzEw+VprcUV9PcGQarYdpfyW3AuaSUTPay07g9HyqLcaSrVQEbOKYNT7dHGWx20EpkEvEzbxBRQFqMM25UO64723sdZ3VYUb577zFWAehnfLfwoHeUVUTZ9AX8CO0JY+owZiUpAPcfJ2ihTQYm1n/vD7/zW+3oZ6FKHRep6yscv+YYHkTySaHeFw17xD2YbwCVy68vZ3qXvxoi+OX9oAoqZZT/3JADO2jqv8H8rkP4ljxlAInNTWPDmr1g3PYGjD+bXxFhVPlmmDTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4iGzy+pKbSiCwJbGqtOiGtUg6a7k9dgF+Xk9Y1IZ68=;
 b=XplUj5GSNBhfSfUgp8epGFStUrG0HJ0YLf7rdw8bTGr720hqi6CtGe246Lcga5p2lzL88bZhVlCy6CpcCW6mB1T6gd9k6skogg0WmK/b7uGNpIrUP5Ll89Zl6RIYf3k+vz+h82nRvx+a51gR1u3xj3AtfX6RuPZq2WosMHrybZdGGuDJW80vI6YkGXYQL8n691Q90j4wwPiwGFnB1j9mjwlpI5URggOgnuhh5ZaC+iE98+fQACMdj4EP+1/cmciLC7/0Jeui5oYo+NIQv6VxOQA4zukHaXWUdtIHRC/y5E69Gg/S2wNlmyVqzNLBujWgWz7UcNYIfQoGlfN2R4i8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4iGzy+pKbSiCwJbGqtOiGtUg6a7k9dgF+Xk9Y1IZ68=;
 b=ZRrwRFmEoz125qPcUHKgCJPiBG4C58ZoJXjeamPpjWHaw0WWwHdb6FfkcGcTBcuwauRkrZ3fBv8WUvnDvId6UiVTuAimZEDrrMGj/ASzuGC0vw0VZsEhIhtPjFBsWQ4kKDVgrgdHxPQOsv4fH0C/pJOflvPYf7UNJJRR3S+u105rHmEaSLGCsYLwFA403zhpZ+Yp5QcPyJUbz8KnShPNA4BQ8Ij8tCSdbzabwYZizBb3sPUfC6znQxp5EHXfqO5XGPv4uY+iZIv7/prh+Fmg14shRnKAwxuXKEsrfc4J0YFV1AIZIA94XPvkVZAAKRPj8ap4/btHzY8yHoHgwbQHaQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB4448.namprd20.prod.outlook.com (2603:10b6:510:148::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 06:04:54 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 06:04:54 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] MAINTAINERS: Setup proper info for SOPHGO vendor support
Date: Fri, 26 Jan 2024 14:04:50 +0800
Message-ID:
 <IA1PR20MB49534A5DE79A6CEE57301737BB792@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [rgmLm1hHdwYRKBcEL0IZnR0KIpkLIUaOM2gLdf1FoylFvxHzKlN8DmhJV7EXNfqp]
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240126060451.459103-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: c33b945c-4ed6-4e75-a999-08dc1e34b70a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sBgIYStjHCJS5da5AZAhOihNcxw0ZfgSlWMd4FxQrkZcauoINOV0fb8MqT+MLxxg3MV2hyHCQS6hLZOlMbeLXudO5pj8oON1wbjc6E5vuPtaC1k3rdkhHUEuh6x0kfSPWr6EEJgmMdQ+BJDdmL2weaW7c7vIle2x/7pZb9cKiLEwc27vGKg2sGJwHOd49QUVDtK46dgJNxoKcNF4r+j14Kdig/tr1eGKPC4016yy/SsPOl4o1PRjkdRaeXv+vw9p053UEp0MiGZ542XScUYCGapXhUxL/B2b+yXGRiEFAC3W+70n/+ViveYXMrfogLbKLqeTLnSk7+y/FfS4Ui8E3y9iED3XJkX5B7gFsKdGtJHKeHu8P5fEFL8ylUAFsdtBE8Q4zGRS5gPzriA7pwDNMFN5hudt1tingsrol5syh5pPL1xKZK7mL6N9QDGOQQTAk2wkzJcNZY5r01gUenEovfQxVhYzqbwMAaJJ19TShtrBiVv3A+Eb3ceCTx/uuDBQIxyy6U+wHTHnenw5liJwaN9U+7TPA2bs/kmF8Lcs6I2KiaFr+DIlSNAIyOX3OnZ6CYAlZHSwhqqvkxOY5EoQdns8V4Mb+hvphf1Ep55NI+fQAT7zuuvr0CHtaawomYY2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RoBIpVyPw5Cs+RLKZnJDnmKSizfYDrx8ydduRv3N4hQygLMkxlHuc79Sh9+l?=
 =?us-ascii?Q?Gjovk4GHqW5iu+agECqGH1yXY+vtGP7Gqhib729ycRlggGhsAllDIFwKrr/0?=
 =?us-ascii?Q?106eC4TOUei+YQGZKItaNHS4essm5j/FONPxrdvtbi2UzR47P+n7AS+8+IJq?=
 =?us-ascii?Q?EnvPcFdEMJwK0h6OEL+LWxPMBy8ri//qE3ClbTw+ECknwvBIhYYLh1YphCpW?=
 =?us-ascii?Q?+/hocjIByNlzsLkeCjcN9phdGG7R0ZgGFSjacNM+3MUzIqCW4Gp0uJj8YmXL?=
 =?us-ascii?Q?Jr4m+2w3jQhDU67u5e7WllcWdqXXZ1/kz/ksLU04ylZbKpu9LsAe2SsQtzCJ?=
 =?us-ascii?Q?HOE/yjH3qY5DxY/b9c9aASIZfTpRmoVWL6j4jUKd3Eu774TQlITBtEHnTSWM?=
 =?us-ascii?Q?yZWeHz1ea3HpGH+dL696ufJzejluRAoi9YfRVmy/dIYGjz4qqhN0/noDsrIO?=
 =?us-ascii?Q?qNgccUv8edmnQn9HvU09s39ir0MPtbvtS6NX0fsBHf5xojX6+C+76M2Nqj8s?=
 =?us-ascii?Q?syKPytpmvqLGHhSmgbbu6AJqDZtcljIb2ngAkEt4z3q9OvT5LqX1TIXyKlUP?=
 =?us-ascii?Q?yU5b8K2+/UZfUZULkrQAFXAc+hZWI9KJDUFoM+KI+l7U+64P5+xXNtpR5z8G?=
 =?us-ascii?Q?vGqgtjdTxGmy3xBv4S5x2mfu890ZUTwb7NUtTMpFK9FFiDjlPHy2YHQWkM+4?=
 =?us-ascii?Q?8WBBPoyu/dSUDx8qnZYeAhNvMRi3gq1zVobcdow5jm/xAipW0q4Eb6VGER13?=
 =?us-ascii?Q?+ECoDxl9LiYN9gmxXIdNqxa4I3QbrQULj22jRxHRl6sABX6FvrFzuASISaEQ?=
 =?us-ascii?Q?cqT5ltm176aF/oMcyHbbd/H5xaiVff8CkAH/GexyugUxx3kun5RxrocxdFcH?=
 =?us-ascii?Q?bqNvWFpYUWgpjBUPSz4wI742BNSwUwu6IonNBUiyH+OXk8l4rR+6TZmRRs0s?=
 =?us-ascii?Q?sKX4rZ4hGZJvKuMEWhjsC5qdVOQq0gy2b+we5hlo9E3Y86UVx0gYuEsnknQF?=
 =?us-ascii?Q?RjqHbVxlZDvvFGnWd1XpSyc1IPP0QRdDjAo5zKwbzxJHsqOg+qkgjd/W6kTv?=
 =?us-ascii?Q?5cGlk89gysyDgl2FtakqDMWH/EtY4Q6d1xkV56+isOOIivFqIChgJKz8bE8N?=
 =?us-ascii?Q?6YOUjT30fTdIFT+fiTLM7CEfmfLQHsV37aIdvCbXeLp6JYPinCjpkFyWAhwz?=
 =?us-ascii?Q?9zW75jm/lF5/bdz5qKqAuXaYYsOc+cDN5uBcB3HeyWXnjIe0SxrVLLbGZbpP?=
 =?us-ascii?Q?VuAaUj13i3iNyaELfCt2iFoaRpPxtbw/yeCmPbjeLw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33b945c-4ed6-4e75-a999-08dc1e34b70a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 06:04:54.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4448

Add git tree that maintaines sophgo vendor code.
Also replace Chao Wei with myself, since he does not have enough time.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 MAINTAINERS | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 39219b144c23..0dbf2882afbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20446,12 +20446,13 @@ F:	drivers/char/sonypi.c
 F:	drivers/platform/x86/sony-laptop.c
 F:	include/linux/sony-laptop.h

-SOPHGO DEVICETREES
-M:	Chao Wei <chao.wei@sophgo.com>
+SOPHGO DEVICETREES and DRIVERS
 M:	Chen Wang <unicorn_wang@outlook.com>
+M:	Inochi Amaoto <inochiama@outlook.com>
+T:	git https://github.com/sophgo/linux.git
 S:	Maintained
-F:	arch/riscv/boot/dts/sophgo/
-F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
+N:	sophgo
+K:	[^@]sophgo

 SOUND
 M:	Jaroslav Kysela <perex@perex.cz>
--
2.43.0


