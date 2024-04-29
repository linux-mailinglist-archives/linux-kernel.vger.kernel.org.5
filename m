Return-Path: <linux-kernel+bounces-161804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5068B5177
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FB8B21767
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0DEEEB5;
	Mon, 29 Apr 2024 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IjzzQ2IO"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2057.outbound.protection.outlook.com [40.107.14.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D452564;
	Mon, 29 Apr 2024 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372291; cv=fail; b=TjCdyIoJfg3PUEbQJaITZk64Lm4oj50jFec1vBwGsy/h3WQTju7ulAM5T9NnC+4zaJV4r20vfxZpZzBAErE4XyrZ6ivK75udRw2BfZu/QRthBtwG11ovlSjst5INMD8lCRBw+wgvIsjYG+ZC8Hd+mNPuuBFZ8b8JAgnIwsZPIjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372291; c=relaxed/simple;
	bh=1SNdOcDtAyJ7YLSmVD5NXfBQnBCWbA8J/3E5xdbjgYg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JZGtkN4ec/HSeeyWuGh3/9Ba183ptw/Jy2yuqQ+rW99kJiIBo2ldY0hB1xPsSKwpFQPD3m4t2nGEwKAY0pdDKbGuSj1VTA3CMsJDEhWplL/5n80ddTyvc3vhO/dISf3gkIQuKVLrcDNCjzhZMPYg0pS38hVc+jh95E2aRZh/gdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IjzzQ2IO; arc=fail smtp.client-ip=40.107.14.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djzkbuATJDKey2eNFctSkeukR1wVfGGN8v7QZSFjogJ6JNzr4IdGHJgPiW1NiXXlotjWIS64ZehkPY2yK8PlUHTpiXhm7rqBkO5rzmnj3PWNC+J8AzExOVJ2p/1k6PHssD3W9OW91dC8TSBNiuTqNMpGH7NggJ90x4YTW+7VfW3KY/rPGFhjjtfBrnpTbF8AbFTzlzCaWc/jV2H66mmJep9SfzpY7vn/nSCRxepvx3HDy5iieg8YOG4ugVQ61Fg/6AYAF/nFFws9t/dHsD52Mm1UfuEHrWngWkK4aFMlykcXfEXnT57indj0yF5C8fFAPByMQsuz5yt+JHB8OGw4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilba0+wjvJEz+gOwt6MA86RvZdp3T1VrWIo2DzN9fvA=;
 b=lSy/ia0O4VIZtG5cPgMj+0OFKuDHuFO2HN5unmDuilXOERCt3hHGw/kHcsX5eKShDXYFtJYMmCm/sYV5hyjiPwvktXr2QNNrXoIhjiP63aVTwehplMcPFwsT1talsIiylSPRoSKWF9D5s5kYLiqEiVdpSTmFBUcxqDBkLla2GPBiMeLbgPQPR/AGzMf5WY06hjWr7aaOyt2Nhknac0bFJ8SR7ckYbm/7KaeZ7kSK4szwjemQIrmnZ17wInyt9XbyV+CVW/27FzsK4JUBdUjBy0AXcLW50xxlIW6YhEX0kB5sM5B2MzDo3bWoFHu3canqSC5WJ9k1Lld7lUrhb5QjNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilba0+wjvJEz+gOwt6MA86RvZdp3T1VrWIo2DzN9fvA=;
 b=IjzzQ2IO8xjidKbQ35Oxif/9vtTMD51S0c/5/hX8inSp7ahLumqOlBqtRD8qBRnzzpv5WgGG2jomCB5nZmpn+RpMTcI009Rg50fppxvGxENCxjNG2B3NKd5/wdZ3Ihhi4I6L/+xzkApvotsc96n/PbDcC0ROCdeFD4JOnVml//E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DUZPR04MB9919.eurprd04.prod.outlook.com (2603:10a6:10:4d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:31:25 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:31:25 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: gaurav.jain@nxp.com,
	horia.geanta@nxp.com,
	V.Sethi@nxp.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	iuliana.prodan@nxp.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v4 0/2] caam: init-clk based on caam-page0-access
Date: Mon, 29 Apr 2024 11:58:50 +0530
Message-Id: <20240429062855.923595-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DUZPR04MB9919:EE_
X-MS-Office365-Filtering-Correlation-Id: 02814461-1fb3-431d-3efe-08dc6815fe5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wAgC+9kqRe1LE3MFZdfAlNpnkO0J8WOS4W8l/03m4+uiaDmG7jwYGTeRCX3w?=
 =?us-ascii?Q?V+30lDTyJtHCGiAiISi17eKo6HpZcv5yM7XOjGzrz6V66boBwgbgICFeWidz?=
 =?us-ascii?Q?STpESdhSwqdyFW4ikKYa0CQmpada7kehUWAaxi1KW0nRTkzAouV8Oqflq6hB?=
 =?us-ascii?Q?quQtsXVx9ZyQNqgFTq/T1HUP8CLuiyV45MOORZ0sWU0a4unQN84ADuggpWFI?=
 =?us-ascii?Q?SwIQ7s75ypwjm6JVbWLTlCHUf3SYp7GKY6bQtig4Fr4jNtcWbUuX2etxmWRl?=
 =?us-ascii?Q?tdDK/dPDCcNl2Tr0/pzjzerXZX0JNy2Ania66QiPY+VWbbeuqj5uJo+lMd3b?=
 =?us-ascii?Q?Qj3uFpBj62PRfD3PK9HL5uQ7X1/u9Hrtc4bZsyR5Qe+v9DJnZfBsdVnAtigj?=
 =?us-ascii?Q?lDuoQq9ShhxyH2/sB4zHIfqOMByZUV2hdzSNlqZOIPsYhYbYmymIXmMtptSv?=
 =?us-ascii?Q?ZgDYNoR5s1DG2qUii/jgBbzG3YQE1JfXbs8q7HTULCQS2IUSnVAjov730pRJ?=
 =?us-ascii?Q?3oZr/UOk2UqL1whpnY6c8L+dpKW1Ivrf6zKoFOU0RxlQL6AzNFA5edcj3Weu?=
 =?us-ascii?Q?NbXg89KSdKZRbDroWlfHc92BGi0juWNymapgYs474xKi0zswK7+NaDPn/BGu?=
 =?us-ascii?Q?7n2gf73ukHLy3XlfTDPRQHqacoSOd/2vrRLT052THGeBCc9L91Czfo6PRQ1T?=
 =?us-ascii?Q?9IJyoDpFNHEPOkn0sS9AmT4ucAAwjtKR1T59DLr2PU/QoCz+tZ0iLSx0j6o8?=
 =?us-ascii?Q?2fdTfYY9R0u9H6Ymh7KzjN18VqYaH8b1GB1q6eX7p6WHIbD9wM5UFz4cuXeD?=
 =?us-ascii?Q?UYSmFJCP/aZOv7lyFPVMKQlSYiauDTucmMl6GecbLK6mLSlMGkicBb7jeXbB?=
 =?us-ascii?Q?j+iPwZAMqqcCZiwoP+2VI1o5eqcW9++0UMpWtzNbweqH5WRxUq+gnTsy5lW8?=
 =?us-ascii?Q?fnChZNrqBY73wbN9CLDcQcJUGn3SHkwtYyzXL0GUbzByLgajjbbSGI/hKuI/?=
 =?us-ascii?Q?7KhrzgR1ttF4ZJILNARVt9oTBq8ZlGXdGqnM03mOMeOjwUL0EoofRMf5qHyb?=
 =?us-ascii?Q?/Pg0NYvarjboy97DkLU990C0mgovUpn7/0MGtZw3iMhWDj9Sy3mgCUTzNXPE?=
 =?us-ascii?Q?1OdYnzQ1DCslaBIGO814poGFhbejzE3S2lNC0wuAduDfiTU3dWh4IR1p5VaX?=
 =?us-ascii?Q?pCr8bH5jx2rQOP/qyOLFZVI+g0eNh6nicG1y+f4/1Yr8dzNA1IeurBA8HznG?=
 =?us-ascii?Q?p1Usnldrx/hPGYLrrajj0zofqb/qLdxaLmQRIWV+F9GfVAAmhJsB8x08AaM3?=
 =?us-ascii?Q?DRa/8Llsqiq408VEYkBuiSZwvBKVkacrF4gXRGUONuoHMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KV5bHbpDvJib1oeG8JuTMIiPCIEzvlII40qcP9qm+s7oUNuLa10srEaKCpBI?=
 =?us-ascii?Q?73hejcFHVkZQ/cu9BKhFAQgZfGVzuvBM0AFVZcht1l5/d4hDQCCeG5XtqR4w?=
 =?us-ascii?Q?Kd4om+jwPSV7LK+RuHsu5nmbnohrvX8I9tfgJMcAiLz2hCb61m9UJSa87egE?=
 =?us-ascii?Q?0uVIIVORQTW3hG7qNB6ghvLN2/sPtQ/XBStUKiW0EmN+ySDb4BgV/9RO036F?=
 =?us-ascii?Q?hFSQF1F/5Z6cNBklNed/ZrYq2nMg7ow/cpGFySxZrM4C1HJXPjBXvLl+Mn89?=
 =?us-ascii?Q?NzJ4NKIlZsRjyQmJYwXIBu//pKzMYaMep8ERUTHYcGDNZ7tZ4gxkJeBwXNj5?=
 =?us-ascii?Q?ETmKwmMZirQUY4ca5udSoVsoIXg7QnIJ12p772d0WWpvonBgdJGwkMTWvV1M?=
 =?us-ascii?Q?JkdBObIBlnx7bMo+ve6NjWiAksocGh19HVa62LN16hKewT4oNBfMF6GFECM1?=
 =?us-ascii?Q?3J3p5+2PjmXLt8rGMTb7sBU/d77PukXFqX55wl9IkQljv1WT3A5EfR4xcoIG?=
 =?us-ascii?Q?G7+7bUzR0SrD5M7bvNPeUik5c6vGCqUHU6vl+o7jx49LrfYGTsKSLc4xyT9s?=
 =?us-ascii?Q?fpVEb1EHoBji6+j4JAZ8WZ9WRqo4lvW3vYwf25rRr5qC7FodID347qqsnvbZ?=
 =?us-ascii?Q?hIxWxftQQO3MPMIXWHp3FE3tfX9tFcbpA5U5bEwhMruEwfdVKOQPIRdUngl0?=
 =?us-ascii?Q?zsadeWXAS1eAm9TuSAEMbtrqcYfGqf+EPDWE/DQ2D6NHhT7kIVnZeo9csbsW?=
 =?us-ascii?Q?5ra+7CDgxgdzWulCrHF54Ptgwp/RL7h2aJ6r8xoMw8qwnQhShtVcNYz6qJ4X?=
 =?us-ascii?Q?iNY2o8T8O7+Q5VV1BI8jSjzVlQr2UrOyuXWkNBeifQrsdFEWLtwaoDPwmnPJ?=
 =?us-ascii?Q?KuSN1LoEKO07UhAW+let2M8JhGRAgH+RIkLUAbu8sXvN3S5yzvddbF+Q7/Cq?=
 =?us-ascii?Q?DxLTns8cvs6WAWDn7F9o8X5A+i/cGSDSrblnN8Aw6zW2eF48p9k/g4AZfYOR?=
 =?us-ascii?Q?JjJVTLJ7S7cEOK16pHZ4+lBK3TaCSPwreo5oDyjgVrlKgaiAa2yQzY17WnYn?=
 =?us-ascii?Q?oU9odOMdsAeJ5Q6WX1g3IfVXhJ69N7SntwGGngP7mnI6YfKZPRhWfrwjj0D8?=
 =?us-ascii?Q?KSZe23CLoXbMyyhkYcvkVjXvUu7V7P0LyNKN0TAvf3Y7A3Ae/F0xwJHEOp9G?=
 =?us-ascii?Q?HzNUN0hJq7TJRf7/aL6gSlRS6qSHr+8s6alNWRVgSwVJmuagYSqLJ1D7ZJLI?=
 =?us-ascii?Q?qiMEeeoArEJtZRoBgxGV/t3QMsLzzLosmt/aIbNudo0KilsBp4Ujl8s4Dvz3?=
 =?us-ascii?Q?qswhOZ7Pt4UXBzoVT6r3Mi14EuKu7tmJ//g+TQmHwCs/LHlZGIqRC0KxLj/U?=
 =?us-ascii?Q?gJQNFSt7DXXXb2M2sf/EB+rdIwzWgdHSfdywApknOST9sGgGJmDddMG+ZUGx?=
 =?us-ascii?Q?3z7JwklFPeLm/haKRp0I1fZ2+ouUBHY0N/Rva4lkNYIPyiiS7i9WDCu7jN7K?=
 =?us-ascii?Q?F7rUHtA+FBbJylO5tK90HxGxyzmX59/IKbg8NcX0kzrfGnrS8aDCu4cpAKAc?=
 =?us-ascii?Q?yyunLAuvBEC218dCUi8aV1qQIRaawBMqMJG0oVKo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02814461-1fb3-431d-3efe-08dc6815fe5b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:31:25.6048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dc2XBULi4fNRie00TK/bl9oWr7e4LJZCHOfvtxJBatLt9WEEtjXgb5ov8rfB+WImy4af0bbi4soalPxuVzyi6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9919

v4:
 - Correct the null pointer checking

v3:
 - Splitting the patch into two.
 - Disposed-off comments received on v2.

v2:
 - Considering the OPTEE enablement check too, for setting the
   variable 'reg_access'.

Pankaj Gupta (2):
  caam: init-clk based on caam-page0-access
  drivers: crypto: caam: i.MX8ULP donot have CAAM page0 access

 drivers/crypto/caam/ctrl.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

-- 
2.34.1


