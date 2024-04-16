Return-Path: <linux-kernel+bounces-146269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056B18A630A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299351C22BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303213B796;
	Tue, 16 Apr 2024 05:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lkJsdc+z"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE011720;
	Tue, 16 Apr 2024 05:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713245729; cv=fail; b=RUy9xN8wL0RB7dxvPvA2wdczztE9Es7ga1Lv6jmnL1baFckDyumcE24CQo6VAF3+npsZ/ztqh+BHFoKfoWPEEcQInH55SRFBQTpeeZM9PaJ2GIDQ2V3bKUHIIerhmaphw/Z/4ixZpgjN66RI8yzt5wT8p4fEqUcjugc6kqh3114=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713245729; c=relaxed/simple;
	bh=teSWS2Sw/lKCY6iF5KayhpVlKPr7417/2wSDGbXJ3uE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=V5GxBvrHYJHuPmC56gwbvfCuOE8ZkpKohP/6TApeyEXwcNYA8HphkpOy9hkboWgNtxF6pV4/l1ajlD6YB2zSYZ/eFpNT8xQpYiFvyzR0BRIvg97Pk3xzMZf9YwZOhD1MGzcqQoP1TtTKbE1bwHec+0EsteT2HgVY4ninKrvMhTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lkJsdc+z; arc=fail smtp.client-ip=40.107.105.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+ctYxZF4LKAVwbaJRjRkEfnE7YCR1Z3cdLtWXowtwagxRwr5dxinnbqY8clYnzILq6LZ10awLQl0ofUbIlSoyZTSQOSZMqTZBXnvU1j0n7qmxfoMToLSOD/u/BRFlwk/nz6roR3UIMbfoIAOqxUeRt0bShSAkO3gdXnuj1aChGoxYGWaAjBnJnpe6zGEsOw9rtoRQI7OH/ATZFV2XxzLj9AQyneSJxY3+w3BuLW69n3qdI2YGCTxxg5f1ODNzet3dyvP8/qCQ539iBeCQG4rVyUoUK52SHHwM/8SfpP6JRlCLkKbNLJ/q5AH0qEQ2u9fk4IEBy+nKVttizk+Zed0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cutG6buAv+n0xDD0IPuC9N6dUaXTB9KW8DYMc/ZOG40=;
 b=NHCSBpB+W7XWvF3+XQa9ynlFThSQqAYAgqCVkA1DmEDoRLrd3QsNEjRDPOJ0u8KturoLHBqJzA8GimftUexGGDoF1JikzZxIz9VkPIdpZCr/sW0ZiGI0djw+GGZ3Yr6XPHvklvtf3T9a45Zq3Wd6YYWNL8m84jy9H3iog7/+toFG48/9rXJIzfraC+xb24+wByyN4c/ZfZAE7Ji6caQlErr7Q86f1JZla+/Rc4RGtTmnX0N1gsIy3dCAq88XiLuUHHYIo1RK/x+9i/aOSWdeMySQRLRq4NWQvysjr2Wz2iNJeUNsC6GACtf42D830hicwc4dXLcEsUv7qQYJUkPgLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cutG6buAv+n0xDD0IPuC9N6dUaXTB9KW8DYMc/ZOG40=;
 b=lkJsdc+zlAsCCzPlV2rWg/ZR/XSkh4ur9GzJUtRfEqK2IDzQdY3h6Xu+Xycj+O4++axmrkl/3YLs8rxU2QaxAM1HUWlarJjSizAgKAYeSCr4VN9Ojg1w3mtJU6oYa4S4X0ZTFJAPYcKaYcYYk9xaCQAmLXe795jVTs62xIdrpOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB8122.eurprd04.prod.outlook.com (2603:10a6:10:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 05:35:24 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7409.042; Tue, 16 Apr 2024
 05:35:24 +0000
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
Subject: [PATCH v3 0/2] caam: init-clk based on caam-page0-access
Date: Tue, 16 Apr 2024 11:03:01 +0530
Message-Id: <20240416053303.421259-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB9PR04MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: c0928ae3-9e62-47b4-7de1-08dc5dd70384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VJxA3i+Pt3BZOSDrYB4HP/DmDUJww2LhO/g2y3aN9IK21FQtBLFErYgDZkPJ4xR2iktRN/SWAFbgREZCfDpKF97pYP7yK/L8nJguX6AGDdRMTs4/o1ylWjR9CSmnuuPmPFK3qzTPkvGmpi2C/NiYn1zv1d5CbVvAhD1+usXD2LmQqeu7Oe4/IiHlKGuuZIfKpim4iJ7bCx+OZuROOp/BJW0aoJYZzPzoB99biTK7NQeqngi9JIraj6dKYBUG/9V85XwhOEo/Zp6BoBgS5FSmTqSrfacyGS8hiInk2SGtDZX5tC3rBDiJLFeMbqvW500M4QcX8eyZpCSIpNJ/G4XJ5qWLkcGtdoukunfcmFMRWzgosH/nMuprUaZnCKLBKDaYzYSOzoEJCiARJZ+2G+f8Qpu3+S/FMI/NF1RStezfn23pYbV8cQJz6Vl2vvZtfJCWon4yPtJTL4NiSIF8Zelxiref0rWnHd8M8txBCG0iZeLtGnRyLlhN0nFWpAbRGCvvYcq6DmuLYyvBtA/OZwhMaruIrK7OVs+7DK1LbojQOlp9SiAvyK8EI44YRAxtquokOgB0tRZDzB66CCPDQmV9PXrynsHEfWTBGeriHq9IRJWkdNBNPis5DqJByuBZtpq8dquXqqo8GJtjhXaXbUnbfmit5up8+2YEOEXC8QhoO5l//f/M5phGL8xiRUr/p7dgLx263i2ViCbxuPYfG7oEKOhHlouhnVbUhVp6ft7DyN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?45q76R0XBJzmTgcQGPsdLhsUsHeFjGgRroX72qwdNI/nhFx2SGVyELc5fe7h?=
 =?us-ascii?Q?zjJgijwFlGWS6QPWwAVVuHXVHJnCvyU+Wv4beMddeqr1dYvMJ4AuY7eFzl9u?=
 =?us-ascii?Q?8FEzid+z0En0CccJWxBqIFclC7IdyZNyMmQ1jx/P2knGs8AKNlnvH4UKj7in?=
 =?us-ascii?Q?pIYcmSwHzecQ6KN7GP5VTKgdkVeNvg4vO8AVN63mIt0/xMxKfD/7/uGv30Ay?=
 =?us-ascii?Q?0xwANlZZUO7kMS6XYQtDvcGiq2XQhzTNdItSIxhHLEG2h4jAinXlRqgc5xii?=
 =?us-ascii?Q?bEZQ5qH+WmDqOR91SqqUNTodMR/EOLlfSBbC23yZCdOEqDFU3Fe7HuOMOLM4?=
 =?us-ascii?Q?HRptqjx9viVO1Qk8egazJRCv5oMcb59NxqqvKMs9WawBhklWNWDxQewZB7KZ?=
 =?us-ascii?Q?GY7uVG7vq8hhq2qN8Y4rqa4bPT7uiCdDpnqxJO2+DTZxwm7s4SzS56oMCT5L?=
 =?us-ascii?Q?PLaGJLwkWcB8les3Lai4GX3PUultk6HGIya+Hl9lSWQll3PTtChq605cn9ZA?=
 =?us-ascii?Q?CtAgcsiSofP56UviE6eYzpNZ0CfNq4euhW5ZG7aX7tvj2bw76+GYmqe0XB46?=
 =?us-ascii?Q?vyk5YzhKsw6+KcdQ07uN47z2pVjtv3tT6RinkXDEoiyHdfOERcF84AQ0OHYx?=
 =?us-ascii?Q?OYgIm+v+AwAQsZOJ3LIWVgmYD/L1G9FJ7kom0542TgCuf7FF3T8EKEeFUljC?=
 =?us-ascii?Q?HPbPo53OQrrUn8EgEcDQV1oaDvVVjexoEtQUNhvAaoaSQ8HZq3atq1I+DGV0?=
 =?us-ascii?Q?ZtlB8ECjoFIpsQ8tsQliM6IKKMgYbPp/ThvN41l0HTAlT5OyOtu+BgMgqUOi?=
 =?us-ascii?Q?Aa+LdS8E8nwF9OiGAoENqUjnAw76tH7jGWjkNAUQW+9Hm06e3cN6rV79LpuJ?=
 =?us-ascii?Q?18p4RNf/UE5AQ9qSSB5XiFStKnWxthFYW8KWVRBPL2eo/1jahsQY8Dl6higd?=
 =?us-ascii?Q?5zRwU9lBVBOvBY6Rn8dBFeAXY2nuBA81qjCS2xZ7G47NWL74FFLxonj6Vs1E?=
 =?us-ascii?Q?QhT4b59LmbdEpi+f8kC4oxSWoVE6aJRrdIiHqtte4kzhG0BReum74yzSZrLi?=
 =?us-ascii?Q?Xvqxl1SbVTfCHJ4C8aLoSbHRLHtxAUUtVfuk6aJUvRnTwcfV36E8kzh3qEFl?=
 =?us-ascii?Q?E8tr4c4fiCimMZ9DC17nwgAKih/sY5DTrDYPTYUj9c+K3icnbALdNiBtFdKG?=
 =?us-ascii?Q?WJUxawqNPw7vWpV2K2UH7C614PM95UtjStPJL+/TvMyU1KKJV4Dk7CtZM/BG?=
 =?us-ascii?Q?SW3kaGq8ApX1W8YntOZitVNACG/N0z8VTVLSk5blNAulKeW0PLwKFI/CfMHi?=
 =?us-ascii?Q?A/VGlBXc0Wp+cXdX1xc22RbJDpJzxj+kp4ofpCFx26/b08iiodbM37Grzyds?=
 =?us-ascii?Q?X78wJg7aZ+YXywOnO9CHLxhQpCs50TiXr0yQ7j6A8Ki424FWB4eXof5+0nbI?=
 =?us-ascii?Q?LG4og2iuVsTTxociOFcHi87JLAxrHQSuN0tQgbR3g5/jz35t6d+zgIT87Xzw?=
 =?us-ascii?Q?92c2hoc+7pvRDZ6sT78AljawyBaDY5BiBYkJMeX1qxK2zgX7rECZCMl+Pqdc?=
 =?us-ascii?Q?l0s1v+dZkcseo11aYOf5myU6n/+cXtOGLokI7cLt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0928ae3-9e62-47b4-7de1-08dc5dd70384
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 05:35:24.1262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a51N1e+WUjBaTXLjnlEZXDGhF7xJNyBkSo9RuCp6SiSINinflIpZHWB5bBiG2EBfzAQV54navb23HYmj4d5xuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8122

v3:
 - Splitting the patch into two.
 - Disposed-off comments received on v2.

v2:
 - Considering the OPTEE enablement check too, for setting the
   variable 'reg_access'.

Pankaj Gupta (2):
  caam: init-clk based on caam-page0-access
  drivers: crypto: caam: i.MX8ULP donot have CAAM page0 access

 drivers/crypto/caam/ctrl.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

-- 
2.34.1


