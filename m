Return-Path: <linux-kernel+bounces-82745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1B18688F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0273FB221C0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75AF5339F;
	Tue, 27 Feb 2024 06:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="niz9uMWf"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2126.outbound.protection.outlook.com [40.107.93.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB6C5336F;
	Tue, 27 Feb 2024 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015357; cv=fail; b=pBjpnMa/fJnXSAmdxVMGjR13zGR4VCerHsuOps5Wun4B0IG8qqX39I/4UCyV6MUOGsIdRwrWvl9Xrqsc78sFOtz90K+G+uEM2bb6NmXZqms93Lh63DbbH+cmb2JD8K9pv3dOQI9BpSKjQk99dnPFTOZ2qXHPMwxfDYmR5gRTk7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015357; c=relaxed/simple;
	bh=fqYCtsSsZk/MGcEz9WjUR8TZFULim2ZHZGCw6omxD8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aDiXLYsPA4iUpKHExwnvycmG7Q5R7i9InPkBXEs7poCr3St2W2LvhFm+P8Yry2o4dTF6Kr6Th4tfShcDoyDoWJ4qYK0UUzssVoGdRXaCsxR+XFp5WStKR3f4IEo5I579sOhReXoo83YJYQeVUUf8O5GifNtHhruJsAhvycWAcHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=niz9uMWf; arc=fail smtp.client-ip=40.107.93.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTdMrDD1fNOycqJw0mlnLgJHLmYCaglmYsTd+XcA9i4tYTf+LtpE5KHQI6cmcxT4XPkxc6dfk8TL24Hn/hDl1mnwUrAIBpkHPOWAlehs3vZ9dQUzZeq/seBeQJ8I6ZYzGNylQmjI8gckJ1TsNQ2hwOGrMbd1LmaapJWFoCRp1XJSjFlKv3IoJuvX8CY4yCD1pKSmFIgV3folkJovXfSfRo4eYCcOr/tO3u1I/RJcGYtwBt8GgBKkstSge82Dsk1F9TKLMJCS4xeZVap5uDdYlv/jxUhwTfbPpSrbVQepUggYZAbKQiiG47a4euC08u2Y+0eaFRMj+hdSQY3gJec/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9D/ByiUYB9Nmz29bMpCmqOTAa4W6ItsbRyMEzRnE76k=;
 b=WuwRQzJdncrehHn2pn4y+BZE+kZ01XeitBwLBcue1QDw7VvIrY2OMkqlluLIf3kU6mY8g2OUTb8h1NJUcfX/xJBBK+h+52V1J5FfyjjAdAmhYaPZwHLnKdsKl89OPyWXejjgUkUcnAR9A7Iinlk0SOpVw4AOZyi00UuctH/R9zuXrCipsRm3DR5aOXD0oBCXs2JtAJks9eWR4/fptXaQr7FegbbNwGPQ8dFSHY2YAhSJR2aSrLcFtFqNwyr+MB+Q3kSK2X8RABVLKsWgsuh0Mob7K0Q+59xnSOF/IELpJ9gGhmTFYqP1iNklut1eF0fWVIMsHaiC+3ScZH9BEN5m1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D/ByiUYB9Nmz29bMpCmqOTAa4W6ItsbRyMEzRnE76k=;
 b=niz9uMWffNeY2PNnFh+CbPDJQo9E1SSF3VkLYzZxL2dtZdDroOBfW07W1G3VZFFwdjwMfFA5I1ZHjyGpezVC/jZ96Id0v8TQdSRqSOjzyG7Y+ebXhypSZ8lxi782n+x90+mchYLfVmsQ9dR0PM8NVSVdTWGCBujZGsicb1U01c4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SA0PR01MB6172.prod.exchangelabs.com (2603:10b6:806:ef::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Tue, 27 Feb 2024 06:29:12 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a])
 by PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a%6]) with
 mapi id 15.20.7316.018; Tue, 27 Feb 2024 06:29:12 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: kuba@kernel.org
Cc: patches@amperecomputing.com,
	davem@davemloft.net,
	horms@kernel.org,
	edumazet@google.com,
	ast@kernel.org,
	dhowells@redhat.com,
	linyunsheng@huawei.com,
	aleksander.lobakin@intel.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cl@os.amperecomputing.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v2] net: skbuff: set FLAG_SKB_NO_MERGE for skbuff_fclone_cache
Date: Tue, 27 Feb 2024 14:28:33 +0800
Message-Id: <20240227062833.7404-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
References: <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::25) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SA0PR01MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bebe46-5258-4e70-7d89-08dc375d692a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6+iHwamwwk+dAH8WRpgbFPm02DFLs2yEON1JsW5p6Fup8PauWe26115xPaytP+VMMy4GUvY8XVHTb5+T3MA0sebPRjrdY9kkvM1eeyokdAiRrzdz+ox7F6eTpkFjE3eierLf8F3w4RTK+++sOTlBdY+DKh0e+BpbAn2eowECbrEzZWdR1H1rIarlcQT1F4BFwL5UtuH8AQz6cNbZWPlvY8FuE4QWZyG+wqN5IUWypUfI74Iv8Uptsd4aKOMGh4/Co1jWiVeinKVBuWEhOxXWP2oPvIJcU7NObPGLkX3NJEB6yq8dQuHRzT523JVa7p9icmBF9d7d1MAgfhVu+RrRBMRGVHcaX90w2DR+cwJ7cpsgmyNEyuHXfXM/wxlymfLFUhGBRESjd1Q420yIFs8P3AnMP8WwLT2Xv3yKxnzWb4KgjpIOrxnwq7zl3pqyAGQKE5CUuT3TXSHkQOyJ6/uX67VxfvSOm3lWeQ6syuB2+7QyGRJ/cDiAs9JDWs/DdN34wov8jqtb1J/wpzsYyRFshq6EjWKwmkdjBPq4OIoXYoaFfEwlQd+0T7ciEgXe9SoftOLRsIEezZOYmw5sc422QwONGkWtrHtq2VF+oEozIyjld1gF7Xzf4rN1avtVM0OWw0VyQlB/376h78bTBvBNRoGesF/6xrgS3YaSi5Mv1tLG+ecJP5ZVRBDJY1VVRKb/qdznGkXqsw3pTaaQWX5i4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ab3DLWXeLqikx9aXFqx31ShbKio8+ibLrXFNcJJNNlZG7CtbAMsXSciYMAIS?=
 =?us-ascii?Q?ZwKs3Y+DxMifG9jJ49aMR3GSNpTqXGME+C8B+TmVsywMWx3Zoba2R9Np5C/s?=
 =?us-ascii?Q?1N78iutJNouURoCV29ICY98K+6Rl44V658e2IqE3srOUfYKObRMVTcWxqgb/?=
 =?us-ascii?Q?J+TgEbWDb48RouMIwOOv3ZLVLgMY6m2ualny7LK4PhRCAxtDHmeB1lpAxuKP?=
 =?us-ascii?Q?19Gun1DY/fXgj/IESEQLo+pcnOsf8cW8VUGBGZzpSmT27VEN+BNT4KE4D/7w?=
 =?us-ascii?Q?sCVbrq4+2AY3pgepcR32tKhv3piSaxpkGk+FNY2ONraYEAs5QzXLzw9qEzVv?=
 =?us-ascii?Q?eFXwbbdrQ9d+edw55T0Rf0BfgZPl/kZyqTM90g7QUFf9iAItjrvWIvMMV37u?=
 =?us-ascii?Q?RrKq9XKMwJuDG5/eEoZjoJyHIJt1YcfbEZ1hdZZWV+Cwj2DslXzjPZgHzqm/?=
 =?us-ascii?Q?xs7hyAuEYZV1UQjq1eaJxvivhkIcw5VLSqGpB5FKhvavyd05We7IogFj0Feb?=
 =?us-ascii?Q?6EsAl3xh1Y0qZR7Pf9GNP5z171RlhK85k4t9nCTrEtMvHq+S35hVZyiZuu37?=
 =?us-ascii?Q?ltxPTCmcXzjBEUKzKx1S9inro9fMHXmflX15yJpNkoGR26/dTtgAf0kbIV3s?=
 =?us-ascii?Q?9UHIJaduYP2vAeHPr8KsPacdJyStelnC2aWeDNsUHG4n/FmjH0JqdtyDEArz?=
 =?us-ascii?Q?vr5/9+jlZKZ+6er+ukLMc5/lvyxHudlqEDiC89DM8mNcRfUPsoX81hAB37ix?=
 =?us-ascii?Q?LC2s1F/J9DMPiuki6BweVZJq7tU54uqZSDcNvvrBnQMikteNohZrVuSgs14R?=
 =?us-ascii?Q?mq3SogxEPK5ZIjYpmrpipQbxcKE4k4+ot5i8ozwFwWVkUKZexSgf2CCDgiWo?=
 =?us-ascii?Q?Ec7VYvy76KwSMZw4dDcr46r2HJtuZbBPKkRXwrTjVIAc6qcawd5MUpxKQicf?=
 =?us-ascii?Q?zdkeXWKxBiPIJ2UhBH6Gk45mLX7QCnf7by4oQVv99ubGPdYJDRI3AAARU1aI?=
 =?us-ascii?Q?LC0c3hLk/1OsOYMZrNd8L3JCA3o1Iz/LnFmqFrWodr8dTbjlyteJN3Yp4zEe?=
 =?us-ascii?Q?q9vHI+f23C6FVIrl/bG8RFEv7nHGuODek0AeIzQyqlWofMYFsmfj4770lQT7?=
 =?us-ascii?Q?qGZLpiRhpWYaS/AiqZi43yqWR1dlHCYALI+m20y3xyoKPqykrgg2IYPE/UQX?=
 =?us-ascii?Q?cfoA5z5bFt5RjrUyZkeEXX3PqabebPDqnUFhP6HRwDSkMlis4IoDS/7uJTFg?=
 =?us-ascii?Q?6MSJjaFT6Lz+NebKHtPa7P8H/FASh07RG7Z3GDevU8mMrUHRdppuzA0Do7+u?=
 =?us-ascii?Q?3P4w84Z4k1iFerKSTmIWoWpyo1nD5Uj0T5mEtr6mmCnd63K6A5aHz//FEApK?=
 =?us-ascii?Q?VKhiMlihfkn8bkvOS4nSDWF45U+wirj8hgmVZEaGCJh+V3ixSyjOnujcjnrF?=
 =?us-ascii?Q?p+1ITDLeoWfND7jQIGrtZtXGX8w7Hv3F1FpOEetsdFTK7GpzpCmS/WIaM7eR?=
 =?us-ascii?Q?jIMZO6exk3txvnlteoO15bVpCBpmCdpvaLQZrnIpeL8quI+5f8dip/2u+DTo?=
 =?us-ascii?Q?9EzMuWFERg/AKR3CTQa510p6lOZNqgUBeQFk4QtbioGPTbhLpz049gfdZBx3?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bebe46-5258-4e70-7d89-08dc375d692a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 06:29:11.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoipA8JqLKQ9ldPD4SfO4kW9SVlM3+bgmP+QHbg4gIRk/w9z2aDSuVuFAUZRPGhsFgQpyrw0ejtAWC+r/pgeTIA97hbzakXekHbMPNaiZtMGhw7CqzIXIYxJ5iS89kBi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6172

Since we do not set FLAG_SKB_NO_MERGE for skbuff_fclone_cache,
the current skbuff_fclone_cache maybe not really allocated, it maybe
used an exist old kmem_cache. In NUMA, the fclone allocated by
alloc_skb_fclone() maybe in remote node.

So set FLAG_SKB_NO_MERGE for skbuff_fclone_cache to fix it.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
v1 --> v2:
       set FLAG_SKB_NO_MERGE for skbuff_fclone_cache in initialization.

v1: https://lkml.org/lkml/2024/2/20/121	
---
 net/core/skbuff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1f918e602bc4..5e3e130fb57a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5013,7 +5013,8 @@ void __init skb_init(void)
 	skbuff_fclone_cache = kmem_cache_create("skbuff_fclone_cache",
 						sizeof(struct sk_buff_fclones),
 						0,
-						SLAB_HWCACHE_ALIGN|SLAB_PANIC,
+						SLAB_HWCACHE_ALIGN|SLAB_PANIC|
+						FLAG_SKB_NO_MERGE,
 						NULL);
 	/* usercopy should only access first SKB_SMALL_HEAD_HEADROOM bytes.
 	 * struct skb_shared_info is located at the end of skb->head,
-- 
2.40.1


