Return-Path: <linux-kernel+bounces-104227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D6787CAEE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C5D1C202C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A45E18AED;
	Fri, 15 Mar 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jEfyroPD"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18711AAB1;
	Fri, 15 Mar 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496575; cv=fail; b=SBbTBNgQ/4Bjxo9vJsJ+Ni8cdVCMuQy2xL7seBHY/dXDVQ0LEM6ZhCa8LUVVcN1Fs1+Hq78fO1vtyskwW9dBDj6ppN80OhSmUNmG45OzGiOom1U4BfqWhra4Jc8g8HmNrKempLrxswEP46pX3XekOQ5ja3LJ2yGZSsv+hKRTofE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496575; c=relaxed/simple;
	bh=sh2Px9OFhd5ddO42Cf+CMYCmybaPQ/4wSgmRjROIH74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WeMWLW8rUYND1FrcgwJnTDAZWIlkuQA2Hg+UD7T6HI/6bkgmftj98Qsw1dMyjRQ2vrOIzLWr2H/fC+EeKy24sytXd630DE0eRXmAUMEEnx9dFhOZ9MnXTxF78wxKYJLSBnFH1qS2f7Uqt2LEblgyRT1PBDCLvuHADt+oemKkWmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jEfyroPD; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTX2RGj/bDewt3NzPnqM7IxqnmN9MBAy69gEk4ZHbl/pz9Sts8ushth43jc+l4/xMcdLeorPbYmHXa0zJx6HjlxQLPag66Hw0tuopuQlXACWsS34dPLbvBpcgBRgi6Sf5vnWHhmX86prrDns8Qkp+XBegn8ylseQJBd9S1I3yTD4Tj+0y7r8Ir5CDHWV4Vd8CL2jm2fEvFXR77/L/yWJ9yBsP+Ug9jwrs9BZHfmbORtnBd9+eqe5bBRBYFES7n8rWXiJ2rLyNPUBUUpH0Oaa0Em+e+B+nwvehhnugSD2LuVw8BbLzcREQVtLe2FCrt16H5KxU9S0AOTD1/hL12kZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yL6RRzoOpjMPWZWxX+J9jbiV3rDuEHCpScBVuM4mkUk=;
 b=kFdXC+FLqfse8Qjhf3U9IX92E14z7mGnIiD48w0CluRD/xd3vgYVHHpOiED3jm2IWLEXQulp7Z9aDaTPC6odA//yU2LZFKME7H+1ldCR0JHCWtGEkNXYbLb5WHhxuwxjCIQNqQDxpGX500yYGEaL4e8+5s7SkmLnoCJgyLuQdGoYRnQ4mFuzD6mkBUrmsuakY9WxSwbf8W/SdPXATNdXFv8rMjw5Dumg2+LG2RI267bbaujoQNpWHPinpTGPwokAAUvsDUc7MwqgZGL/CEuYpNbhyFpVwCW+ClMY4MgaL51dgWsf4wL8dhxCAn0CnaVtv5gvDWD7DGi6pjl8RBRMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yL6RRzoOpjMPWZWxX+J9jbiV3rDuEHCpScBVuM4mkUk=;
 b=jEfyroPDZzd0G3jqC8+lKGdH+CEdVT2znm2OsA6S0T8L36u2w6xlKqpzy6taDnwrQJGl85MeRwbL/u14OmL+IvZPipMnQaK3NluUqK2TBeswGFDE9WVar9F4v8uhJJ+t8apuM9zvouU14l//6SSBEVssZTcDIEch7DVaqa1j+l0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Fri, 15 Mar
 2024 09:56:11 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 09:56:11 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 5/8] perf: imx_perf: fix counter start and config sequence
Date: Fri, 15 Mar 2024 17:55:52 +0800
Message-Id: <20240315095555.2628684-5-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315095555.2628684-1-xu.yang_2@nxp.com>
References: <20240315095555.2628684-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM8PR04MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: a3dea5f9-a52a-4bee-7f58-08dc44d6249d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QcjS/BJ7eAUCZmbEgGjPdbO9kOJpbeMX/FfVt63vf5NumjMQ1j/gvUapYBkAQ2jw/oh+mVd0Hi25f0r/B8wOMfruXnllVJ+kQZVDdBIiqP6+4Q53MRwRQO3TfO1rHahe691UQxSo1E445FKVEyfAzk16l3pBaKEArcQf+en4pT5/FZoP0IzbvV825vH4m19bdIvqEkhSnJgTX3tmaVjd1ke2obiRLtjtsL9dusUbXRqbrnzMrHCikAJI7sk3FEOdlvzfCAHP8k2snkGuynR8nWoLlNwijdytWHYjM70In+lh684V7UyiNAKxmuHuPsnOPweMsOZnupzE91HgWb6qckDPSOspC+qYeD57GM3uTU40MPfYJKBXzheHioMXYoWH/DLY2LjtjXE0zLPs26Bs9te6wMvOJ8h+ePvgk9bDdC8BQtjgwvvwgYC5zaGnx6XSh/FQa7FL2lvN9th3IqDQtjwgjRneFZFnTshlgMGsn9603vZLrTb9B6vIFqrEWZom227LrVYxLMcfkJSKyrhCcN3xSgs2AQ7lcEiYsdGhe5AdWvMJxm9CqqaK7kDcsgBZ5nrU2fCqc88MbyoW38Cw88iIHM+SwjD3VlR8qxYtFCaLwbmhEfp5TxFit9l1uS7bdCkhwpgwZktwua9iE+rOCOGuQdi7f/SNRGEZuGjpPZa2/FRsOByMUU0f5PVQhV6lT1R0im0bC0dHk21myMuaPwsDu7oU/ATANnrZPNGBs5o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?or0MEic+zaLUwPBTk9ypcJTEg+jIusZMoTY6cnivkSHfOlll8jWn+SEbzFCV?=
 =?us-ascii?Q?WBzJl3H4Zrh5b8QndPdD00OEBnOwh5e06L+uz8+AtG5FvU6QOIbwoFXVgsD5?=
 =?us-ascii?Q?/tBZN74Zj4b41SxkBxbYsMVE7KFm53AqANtevxSnB0hF4yU5MTH2GdBAsplI?=
 =?us-ascii?Q?CZuP3ddpjoZVwXy0Bjb3Kh76166Ak9kJjvpr2Xa+pSGDEEdhVmLbDsU4O7r4?=
 =?us-ascii?Q?/njwj64xAijkGOsoq8ob0RMY9+z9QrWGmEGPIjNdQdLiQBvUgwFbKgneU5T9?=
 =?us-ascii?Q?uRiSl0+9u3qEZ6zmyWqoeLaPA7NVD1vfeCyXEqhQtEF4weRJvNVCCbncDijY?=
 =?us-ascii?Q?IRBs4ZL6OSG/wPA1ptFDnaKf/CMB0QyR+dePS16Iw/5Lh+xcgbsf0eEFmWXQ?=
 =?us-ascii?Q?Y+4L+SC/j/zV15dcdIALFhLG/l2sK7C7hBVb4ozL/EDLxgftsnWN5UKg30Hg?=
 =?us-ascii?Q?CaT9PHrCS1eA8AOjSOQz6qT5sMkkUvjvSEZZzLHhWqbgBKAf7EQHZKoQ+5kr?=
 =?us-ascii?Q?IJ3msgZK9COtWo77LJy/onX9jIEA/kRIMph5yeWtnphxw9AijkALYWELhs1Q?=
 =?us-ascii?Q?Fc6fHSAy7+9s+bJXKUztpJ/9xp+cyvXkUeMpCTPJDlpd0g51/ZqSLgXozYOE?=
 =?us-ascii?Q?7Ywexu8etsXJvyatF7Lr1lmSCtFivLtuVW9bzT1NZ90pns2DXlkYeZoPsu5o?=
 =?us-ascii?Q?6iyHFeh10S5eqWYO6DiCyWwuCpj83beIkvwpzqQYHh6iiLxef63PmgTfUVh9?=
 =?us-ascii?Q?3f3KZWOHgawrnuJA43/0REG/Fk31vRdRFO4R5TEp4hLSsu+f+MGrVClyErqF?=
 =?us-ascii?Q?5R/lVh017lV4TQAXfvW7VADq/LXVgVBgD4FeMtvipt1Cq9OSaebmtRpF6OlQ?=
 =?us-ascii?Q?LhX5CSR2sr+yze8D0Vr9qyd+v/JlGGeuilvKgqDEMEJWrim7/9D77a+Hplqy?=
 =?us-ascii?Q?8n5oJf2um41J9EjdmRYkBTW+/zpsMUtAAsPHkZle/YLVtwX8eBhseeHdWhUj?=
 =?us-ascii?Q?dXQdYhkOWRsuIbF7nANeuTCddW1Nol2sBcT7bI5X8rdC3lA76jAJl9jqvnxi?=
 =?us-ascii?Q?SgWqcPPARHNeFbsJWDRrvcHcrZvmAqghaRUbesACNGwCciyW3pq4PzMC9u7V?=
 =?us-ascii?Q?hLtd4/FuRU5ZWlnVxjKjswTjxbB5LS0/3rDV0WoY7cI99VXlhrPepyFHnt/9?=
 =?us-ascii?Q?mF6CdbCJVIaaWqkIo4k9HtkZhr5jcj6wRWneYn/J0L2sVbJezG9RSFNo5Q3G?=
 =?us-ascii?Q?1LJ7CXuCQ4BPIS99/aVW3AypGY1+42hVsh7FVGZCWCupDIcb348+sM5F5FIR?=
 =?us-ascii?Q?yQNpYZMbnaATQTYVWkJ3OUzHIGKgd6VokT4GkXVMErbtrCbdxEJJzQye8jxX?=
 =?us-ascii?Q?c4fXBuLnDLEyMu5S0SvoxEsL5h9mOWdW0zr5tfwSLz+Bm9/pEmrUsnY3fO8P?=
 =?us-ascii?Q?CruDlXKj5Yi/1KVapXi36BH6YsPIi1mWXlQsoxS4k5fzCc6Ye+gdYIls51YZ?=
 =?us-ascii?Q?AVX2yNFimqLLqO/S3UyiArMhK2iaNxMje/+zWIGKZ1gIujnIrJ0QuF3Kn0h3?=
 =?us-ascii?Q?50PoAz8cbMbo8MuUT4GeK4pZYQZZcvsWyJY0188w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3dea5f9-a52a-4bee-7f58-08dc44d6249d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 09:56:11.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDyDUqf9MU9HPj82dB3t8p3B0EbAUSQDOE85hg57FLhjkNj2PbrI5fYhg0ftxrt+LteNQDgzuPPKunRYt0hUpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7444

In current driver, the counter will start firstly and then be configured.
This sequence is not correct for AXI filter events since the correct
AXI_MASK and AXI_ID are not set yet. Then the results may be inaccurate.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - new patch
Changes in v6:
 - no changes
Changes in v7:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 5537f4e07852..c99c43b214cb 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -523,12 +523,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
-	if (flags & PERF_EF_START)
-		ddr_perf_event_start(event, flags);
-
 	/* read trans, write trans, read beat */
 	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
+	if (flags & PERF_EF_START)
+		ddr_perf_event_start(event, flags);
+
 	return 0;
 }
 
-- 
2.34.1


