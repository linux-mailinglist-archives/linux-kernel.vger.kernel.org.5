Return-Path: <linux-kernel+bounces-112666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B5887CBB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BAB1C20CCA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD421802B;
	Sun, 24 Mar 2024 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U5ttUKYD"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC9B17BDD
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711282858; cv=fail; b=LJQdd7wH8K1yHKWuucICiKbgXQ8ATQpJls9Es21zFztE6IUItjG9j6AW5+LYaKqh+LXXi5h/au96RFN4N55dt66p1piSvfiqbKcFNEtY9iU58LHXYzsaCFsp2dU+Zwhdj6RT+knQADCeqMpFP40dWoR3YPZ5x5q6FmkHV09gt0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711282858; c=relaxed/simple;
	bh=A7T1u2T01nG2q/adGcGyZEDt6b3e+M5jdV/3GOO6M04=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oBDv14dagAYBNY9hgD0VbDavDk4aDt3kUi7YiuXrmky1e6Z8DqOsUyj6FBcx72d0z7o2bEzz9GuwNGnaLXEx994sQoZSKX4iLUmp38MRqzC0vo2/RwBSv0fPStv+98BJlnWeVJ1pWGIIPXsCxUN6uClSNv7RJEnZfcjh9lcHX1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=U5ttUKYD; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5L9oSyPkiKvwj+OTtW5qYGsoR0pJMRIYMpaBRKoyFuwW2pF/7WnfQtf0kvTxxX4i8KtKoZ0PaC9RrMzCKuJSj1Fuq9Pe5wMsTXjfRfkOy8dzEujPd3vIhSz2SXCb7QdBo0hS2/apfbkADbT7gA9vS9WQg6DtNYuN2eldJdjsX3gF/qIr7NmXjnOQU3VW0NQJiMfsklJNnRpNJer6ZJ7n4UHSVMbDaDrGKsm902YjUVJGazIXbJgqtL1HGk6LwR8gnpQaTG7Yhkqqnu4dH/TpTWiu2u0ga/GMk2OzWF/lM78TP3XdXzvkiPljAYRFrH5saENH5oPsZvHydtd+31EOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOwCuYkFF0fYO9+0nm0XCNTfTQzLrl7RfVsdE3jpL6E=;
 b=YsWZwxN4NlQTwee+PopFcRIzg1/61zo5jDbcrwtjK2JOoW8qWRvTCKZQEvxCTdgqVplDPqvkAkGPsf184XGWFV8dS3gSOI3AA7asq2doRrSmPV3PNYeCJKq3umV/F1128PXaw2y1vTooVBkKkY+kid42RC+qFi3/Vc9PoygQshhGx4lbaGKrXL4s/vGY+Qod+BLPXmSS507eRfgEZmdJu46/LZ/xqmSRxUR9er3NGWnwqOOBaZaDZnBioYjqrJtgBv3WVxhR14gFonN13ZosMxL/AWhIxGe9d5gRPfus73z1DtzSfQEWoTIi5c3a5ZoGY5z9C+7dQH0ArCagfqGv7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOwCuYkFF0fYO9+0nm0XCNTfTQzLrl7RfVsdE3jpL6E=;
 b=U5ttUKYDyaEIF3E55hAPjAMPGOId5X+6s1jeJDONUyAWyheTXtTy7lGxoXTB8KQfeCdXQyidEEdpefcQDpsMVbUlKlpf911yttpoFLOUCKufNGEpFa3Uhn7frqS3Ko+CK7NJygE0HskoKiRFUcLjd6xo1dkXQpNN7PdicGgIsrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB9901.eurprd04.prod.outlook.com (2603:10a6:150:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Sun, 24 Mar
 2024 12:20:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 24 Mar 2024
 12:20:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 24 Mar 2024 20:28:59 +0800
Subject: [PATCH 2/3] genirq/msi: cache the last msi msg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-smmu-v3-v1-2-11bc96e156a5@nxp.com>
References: <20240324-smmu-v3-v1-0-11bc96e156a5@nxp.com>
In-Reply-To: <20240324-smmu-v3-v1-0-11bc96e156a5@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Marc Zyngier <maz@kernel.org>
Cc: Bixuan Cui <cuibixuan@huawei.com>, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711283345; l=669;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Z30mdWFv6IBqp2Tk95bfFcpL7OYDH1rSMcqs7FsQUCo=;
 b=/wUm2gJPn0ot5bNtIIHlM/mCiO9O7bw953Zuap8UfaLYd8V+cxWY8ZrFyc4CvO0yGvPFqlm2Z
 Wug38brm/g+CFUcoJMS3ekFwldWnHBz2NN4KpUPnqkPdVewjiLdjS2u
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB9901:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2eb52b-d023-4e2e-ca2b-08dc4bfcd9f8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LvJMpD5XCs1pPYio9ip/73s5KS4LIxdDcs/HvI1uQI+hdxWcqHsEzdzHpE6HIGr9x6qV+fayTDoMrXENpzLqfi71/c4Jz/K9y7JLum1qxQqP+tx52TRups04UCe+ezSUCw3SWnrsgyArjqHiTXmfRiWBG4IR/0GViMyJjlRYt4yorOwAeempDTEShYxC57UV7LYSnjVJ2IbZRyBFR3Pcm4q2fKUfXx8gekUqDzGv5Ey8cxaJOXn0Lbn6ZX7dl3F9sGRgYGE2f0c81lJoUiXJNu2JMrP2cC4+u0s/0uyZsgZfIcpnbiS69IX/MJnLjDWiqB/GUXjM1PLtkbMUawftZbMa0KwnWoxGXs6J88Zgh1WmMAbce6JVou1KuJz12r0f762VEz7hBr0/pov981VCgquoXBq6Y/NFNWH0TdkzzNwb19L4qq03TmXusqcQnsV7LxZqFeLQ2dEavq9X4vFygK0C3MtDlI6Fxs60ieLPBEAk3BdzgdZ01k24IsInRHptwop7wHfKkdZA6sMdknR7NJxyv98JB3kmb16l5bvK/qKNuBSwzmmoG5TxMZENkidVriJrnWiG1FFVAjHKFwfD7XR6U+B5+J6yR66HNAp5P3ndAOlG+20VJPZjg4q+EQgch5k5sOqT11iH6xtkTzFBJmqwTx94NcgENZejF291zwqkSdUgh5EAoO9+8QRjv0ntDQwf8s/r4ZAvDYWWBKnA62PvNdsW4QUVX9SXojSTZbk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXdNYndwUHNsUzhQS1lSdDVOTGtNUjVTbHdVUU04dE4vMTlRUWg1UkE4ZlN3?=
 =?utf-8?B?M1NTRmlnMTFacWp0eUtmSzBLWkFvNS9PTXpQcHpwWElDdkJkQ3FoOXNpaXNk?=
 =?utf-8?B?azdHN2VpY29QZWhlaHJxZm05cDlBUHRuVGp4OHI1WG9oSWZreTFwMWV5VWhx?=
 =?utf-8?B?YmVPbG8raXMzU2k1SXNWVEVrT1Z2dUFQWFBQcWtQUDZHb2swOEJ3MmxYMUxr?=
 =?utf-8?B?MUVsd1BaTGR5am1ZTGxURnlUUFJLeDB0bllrd3FSVmVBdkN3S3d5dS9tTXUy?=
 =?utf-8?B?SWZYSGxGTVI0MW5VYUE1ZGI1MENraitlQVUwYkQ1dmFrRlBadGxtbVgvd2VD?=
 =?utf-8?B?b3I3bWhXSHExUjZ4VWxMOWJ5MkpHdlVzYUdENGExWnVyeEt3SEJEbmdtQlBI?=
 =?utf-8?B?dlk2ZGNEMlRKditwUFQycWowaklhRU44clBMWktJQWVvL1ArUFlDWXFsb3Mv?=
 =?utf-8?B?R3paS3YzUkZSK0xVekhDZkEzbTZORysxTE12bm5JVS9zWU9PYTZnMFR0QXJN?=
 =?utf-8?B?TjVMS0pRZ2ltUzZQY2s4a0NoUEJoaDlKK3JLVEVMZGFCTzRjSWVZTmFsOVNZ?=
 =?utf-8?B?WjFqeTg2WFZ5azBZSnNUbWxBUGUzZGRBaTd2K1JKOXpHeUtxbElkNGdISXRv?=
 =?utf-8?B?Q2FFcmRHcG5vWW5HMTY1VW9HbkR3MnU4SnZ5Z003TjhJOWFiRUlwYTRYOG9Y?=
 =?utf-8?B?RENmUFZQT0srYndJckZwVnRQTUhYSit5QmE3WDlpaG5rOXNUQ1oydEtVM3dx?=
 =?utf-8?B?Ymc5TXRSVnlqeFRxN2F5d0NMVU9yTFpRekZCMnh2dVVBMklENmljUW5IeXJL?=
 =?utf-8?B?aWFlQnpMSVNwSDNNWW1ISkx5eUhCNXY4RlViS20yT3VYem9zNXRtc04vbVVl?=
 =?utf-8?B?WFZwMUpsOU5uOElkQTh5Rno0T2UwTC8vVTJ1cUUyaHZkcDE2SDNJVFdab3VI?=
 =?utf-8?B?YkN3N3ZoUGRRSjNCRjNXVnQxRW9CeU9uc21UdVMvY3NVcklnV25Ybzh4V2R1?=
 =?utf-8?B?VVdXWVlVS0ZqL2VWR3NiLzZnTm8rUlFsSWFZR0xlN1VpTTNtVGM2am5kVGtF?=
 =?utf-8?B?WVFhOUZtM0hXVXhtY1FPR1lvazNyTi92VmFwdngxbkpmMm1nK1BjNnZYendX?=
 =?utf-8?B?c1YzU2RKWFFqeCtpS2k5NXd4QnE0MmNGcTBJUWlrZEtReEJvNCtDWStjTFBU?=
 =?utf-8?B?SS9CeFYzOVJsYXdNUFVWTy9LVGpOT1dWejJpS3JXWTRIOU0vRE85RmpnSnlX?=
 =?utf-8?B?YUdJbGN0elQrTzhPYWRIY3FjWW5nMWFNT3IrYzkrT2hyZVhZTDlTTjFtTXZw?=
 =?utf-8?B?bXZTWVpHVUlHRTZnMGFOQ1BOY05ZVnNiZ2FsNkhwZ1AxNGdoMERPWFN4eWxU?=
 =?utf-8?B?ckQ3bmFKbHRHUWtCc3hVd0ovS1FicGwzaWZHZi93OHluOHNpT3RMM043Z0tI?=
 =?utf-8?B?REpzcEJ3TlhoTHE0WGwwSjltaDdtcVdwU3pCYWUxN25MVHQyYUpIR2VjR2xO?=
 =?utf-8?B?eXNsNEFsS2tyNHlMc2RpWEJzZ0k5OGF2T2lEeWdVRHFkSWNyQi80ZjFtNFJp?=
 =?utf-8?B?M3QxWXVsOXdQMTZvSjdFb3NWaXdJa3VwdGRGQVliOENvTVBYR3M4ZWZYajFD?=
 =?utf-8?B?SVJ5UTUyUkVoOTJXODJON3B4NUE4TWU2YTFsdG5HT0o5Y3lEZEpIeHpMeXlX?=
 =?utf-8?B?SVhEUDBrUHNXNEZkR2xEa29aMUxTRXh3cDlzSGRLZjV5WnErUUg1djdIUGJn?=
 =?utf-8?B?Z0M3bklVeXhHRVpNYWpIaWFxQk1HTzZlMmE1TG5MTi9pMlF3eUxtTTlQSVAw?=
 =?utf-8?B?SElnUFQ5SjkxR3NpNzFjMCtpeUh0ajdLN0RPRFUraUJhVHFzWVp2SmVqdzdM?=
 =?utf-8?B?Z3dJSmpMZTFYbTZvckxFTjEvdzdXOUVBWEZHc0NmQWZtNzdzK01ZZHQ5alNT?=
 =?utf-8?B?SkJ3dkRlVWwwRGtLREdWVjNJemlBbjNYODJLOG81RXV3ME5ZVmFGK2loanBJ?=
 =?utf-8?B?SE1ZaXQ4RmcxQmtpT3B1aG5ROHh3VFBCdHlnN211SXI5WUQyS0VBejd4S0hP?=
 =?utf-8?B?NWZVOFRhZEV6U1U0U1BFQyszaG9WQVd4YjF4b2NGVTUrWFgrUGE0RmpWNFkv?=
 =?utf-8?Q?QwVVDsNjziMKKHBSJGMno6dZx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2eb52b-d023-4e2e-ca2b-08dc4bfcd9f8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 12:20:54.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEzt/NaWpsXtQQGSwBuqcmyz+QqrHu3GBV3kLBJi1pg4vXAK2A28sHlr8nr8NG5ovHBqs5P+vk/xub61Gsyecg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9901

From: Peng Fan <peng.fan@nxp.com>

Cache the last msi msg which will be used for ARM SMMU V3 resume

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 kernel/irq/msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index f90952ebc494..9d7e0a675089 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -617,6 +617,9 @@ static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+
+	desc->msg = *msg;
 	data->chip->irq_write_msi_msg(data, msg);
 }
 

-- 
2.37.1


