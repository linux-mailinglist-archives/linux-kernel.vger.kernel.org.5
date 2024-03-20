Return-Path: <linux-kernel+bounces-108491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29421880B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35583B222FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53D718C19;
	Wed, 20 Mar 2024 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="evgEgxSo"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E901EA7D;
	Wed, 20 Mar 2024 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915805; cv=fail; b=oToAjG8hq1L8EA31ZMs2qkJ3SOj9tLJKLMr5IapprgXD4GxWFsKHdrClbwl5dFKZSIEnCyEviA8iFts+PY7bO1whYoTWVhFd1igUQuLoBDAR7S4CYL09VlX8AC/z2jUVW+vZuLHtodJrNqY1QqXym89I8d/gojhEBDCiW9sVfog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915805; c=relaxed/simple;
	bh=jeGz9QqPd/1SIAjBR0ZjToqj/seaqc6GJlgC4vJzxyg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Tsmm3cNlXeM5kHbHLOnTIEWx7AEooBMj4Z5bu0dhPADNxsdx8LY7jteCZIDEPFaGfD9d4xFZlxZSU45fHfIvwmmHUQkBA9JXdKepSO4aGaXaI5shUQ7FXtd3b29lWsztQFwVhfWGpnakIC5g1FlQjTAJnrWXKt01AqLOAqP/7w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=evgEgxSo; arc=fail smtp.client-ip=40.107.6.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqAGh5057LYEL9LkZqsc7QOexrpXQYloHOkIJuaIx1+pwIBGgcMQ4hUaxv5KKBm8b/nhVrVg2wfwRKUHxPyMo6ZguxW62VHuP3YuX3DoEwg9MHS95b82E/nHI3f/eSWTQ6EQHcIxdKOFmY/0O38tNgEWKU+sHfLlVQEBYsoboeJaAAAdlHZlaCUSWNM+FpZB3EzKp5aiCvzWDbQyVSIp2493DJdVvE0LWUvf+7k+VhhGWqDG3EQzqwcInyy55yHbqKuBkQROipSa25ffUfYvdXnjMtF2xXLZnKOgS6Fw27LrNFOTFqPDWRq8KAJwdCxkEgvBrpMcQ62vroXy3mal0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TR/vdAfnQ+7hOo4vt5YmuzW5X1zYHP+uqAPYT5nfv8I=;
 b=RrQ/JkCt43XsSrCSUhdG07zMsPPjAod41TlbIulKLpDjeRcB2ArFur5bNDNi31sdvZnrgfDRgooCbt1d02FJQU9I8wFuIYHwM5YzxorJaXYozpQJEVEui5eq6W7e6NDo0kSxRSaeymDI9oZRr+H5nBPnAyl4RFpAGoubSrvbr2eLYEv68CZtJxmdxTTzlKWDIHA26fa604iEKh7S18LV+4GVRO2SKRHPGBiJqGY5AlXOXyjDC4UDzixyHcvhyK23I4i4kGeRTsFQTsE7XmVuMr1YQiA5go5LcPfdjqUjMZ+mQrWoKUbvU87KMZXssdiuNoyLS7UKnPP1/jmAMSGqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR/vdAfnQ+7hOo4vt5YmuzW5X1zYHP+uqAPYT5nfv8I=;
 b=evgEgxSoLinS8ComS6l07L/Z9WSxL69f9Th3CGYVyXGnFJcuKkWUHXTOqMM9wUmDwTjtqj1v7eQw34c1WhtBR+JzR/9Ogn/Uvenei26AOLbAerNu6d4JN1wnQSLwhyyZ6KBZJJM9WeesTTTjdn3xXZSSZprG+3NbkJ0KybCy9JY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 06:23:20 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 06:23:19 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	ping.bai@nxp.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 0/3] add pmic pca9451a support
Date: Wed, 20 Mar 2024 14:28:46 +0800
Message-Id: <20240320062849.1321423-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9367:EE_|GVXPR04MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: c175d111-18d3-40dd-b7f8-08dc48a63c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oeZaNmxnDbbTHW9lEtDoWBbezVjHniBEscKoTbfxdDsaul2PrhJsp7sb5RD1HtVcfagkiDpQBUM50NP0E1+dyCDsxL86b85q7XIgmW2rOzFv1WRp67Gn0sm45NS52SZvccCDiVqk4YA5vhr2/NyTJeI4iydH+w6iuONFyrBM7WXGmCNTTBfcMIdPn3rr6cmEvC7rRHfNPsR5Odp2XDBVSF45YsrJt8Qxv1mm0OjfSkUu3KxLPwIpUIN08z+wGbkylukKbOHm7b0+mtGvKwuNs1/6sbuLAoZeHhismLEnfQ52VK7thJ8Jr4K14IJPhOd7cn7saEu2YGe8/VgMbmOTgOWj4X6/s13B5HwkrceLEIk3Re7DAwGYv+Ak1Lhj+zXyva1W/8ycbUaecT7C53hFpY1Exn+XB9VbnAX8bgrdWh0sSBI3e12pHQaLrag9h+vQfSK5SumqpMcplTbhXJK9W1Kp8cAkYta8RxxAchZpOiLjorpHyxCuBQ8TI1D19w8iwNPqru52Cvc3zjYEVqS4g3AIKnVtsG8qTrqY7lyBR/2YkwKImJ1L8C0LrP3EugBZGAhXy/FSmTEqDJ9pTRoCzS7kZKjDk/BJOeWcym5m88wjybfsjPhXNZ4Pn/6J9HbVAHJDJDyepGjrfKmqFXs5s8ZVf+FO46EvlPmuQshmKeO1QG5fmnxGfrHpDMvkhrs11sASmZ2RFMr+6C9NdGUK/3Z+0TCVebMSjT+jebmDvtU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kaYwXx/x7bvbxV7p7UTcA1gRBr3eCj9k9iOguhMOh2AZKlPUK34btX59DzJJ?=
 =?us-ascii?Q?lbHOV+RJkNsEfHWzDXEYVeoGGiSfp8w8np6t8phfRs+Elh1yJqJFeDSNKRmg?=
 =?us-ascii?Q?1F44FHVFaRAPWzs9ozWphX5YaQLVboujJWVeK9wkfgRU0/azv7mnK2tR2K8G?=
 =?us-ascii?Q?vDtuUHXrogW8ekoPvdDrZYnt62gWEoAxu4itG6BeRw/BgQEzvASYj2V7h5lG?=
 =?us-ascii?Q?aL19seAjZB1TsmSczj8BjyjcD9Cl4/BUnOxwzIvU9vvFXEfhidYSiTy5HkAF?=
 =?us-ascii?Q?5F6tnc/3tDxzHMS8VEXngFDnVrYmEzdRCe3gH2hBYZF1RNtDyWk3MsGOjfOE?=
 =?us-ascii?Q?qST/qCvw10okDTZdQnXSOqQAfFKWI21ntwJdjd1+I07i0lImVYvVQtzsAMLm?=
 =?us-ascii?Q?GWtIN0JTfE7JXsdq+UwVyKXNrelO2lMAl6whWwtUnlPmaJv5uF8KRHQwdD+7?=
 =?us-ascii?Q?CoFn/gzhUqDiP+ah0I2T58bV9bmLzQ9NAE9QVE5JW4Nt0eqtpdjYANvSouDw?=
 =?us-ascii?Q?7nCmsq4pZ8qHijq6kMIpsBqdD0DR+f17r0tk6Ab8J2hHOXq4bhohrnPSQ0Dc?=
 =?us-ascii?Q?0YHVo4pAMrjo+zOA4PBZOX9cGWKEhL/SzG5WGEclL5rFZH4rD12wCj0aJP9N?=
 =?us-ascii?Q?3Ub4+bfqUaSj19dH0oC5ypOo6M+uWKb0JUuxhd/tJBc70+wa7RmCcqjRUL+o?=
 =?us-ascii?Q?pjfgMZSNYVukCjACGRB/3P56nVEmi3UIRO2U+J66KTez+Blu+PrtIjsVQEHu?=
 =?us-ascii?Q?wjS3rO6HrIErg2i8jqtYVITWgVYKLAtvPLHsZHYX9GBt0jPEb/djk3/RLpIY?=
 =?us-ascii?Q?mmMrhZ3bHgBno8IVwi3CxNjtpkMUlpnReT8a9VFnhmzayNcoznUnhjz+4vUD?=
 =?us-ascii?Q?07WhvQ65jZVx3qxCjGu5/tvBkg7SZRh/qLyKldOBL8Uj2mJqaoYXKRmdZU4Q?=
 =?us-ascii?Q?ULRZsujQDOiayk+fZCtcZWohKRfD1BX+TJQC2qum4lThMqbPNdJd+fjrgtYQ?=
 =?us-ascii?Q?g5WEnJeAp5rKt3kJrBHXcUZ1y1MyB4t6uI9ERBoJ277HNI+9X3JL0Fllcy4M?=
 =?us-ascii?Q?aQG8A1g6fiYKtZpEcNvIVNQ4ld6yi3y8pAoHkLebvaCeyAvRk5M9ZzteIDOM?=
 =?us-ascii?Q?u/7qStPsHCCt+8ED2kG2wp2Ve3sUxYtc8Snfk/8IsN4i4yzwOejduJhbWG7u?=
 =?us-ascii?Q?HXyWHw8EwvmJYZN5xH7xokoty5cZdGXJLtFiIOJUOcuHSFnTRnzUk+4yDzaa?=
 =?us-ascii?Q?h7pjjVm/XO7SuwYDLzS8xm8v5kKxjVuUvpRZF3eVWIWT3c+noWRQTviYJkho?=
 =?us-ascii?Q?LV5p9ovsCQpkl/jQncnxvxX1veUAWVmY0VKwnuwop4zysJKvmp7omJJn6cv/?=
 =?us-ascii?Q?02vNBnjpwGIhNcFrbtuI6AUNtCWFvzdb/dcYikivL4+LcDszotTsDypsVvhv?=
 =?us-ascii?Q?JMfuG/dmBfEt+aeC4BmgU3FcF9Vd0p35lKytd0GOmnJ2J2/Lb6c39rrGbzlS?=
 =?us-ascii?Q?qbbZVtWjiHOk6w5umfzOm86gMOcoPoJqKwNx8Ln4lYYijCSAF/7lDDE/kxn8?=
 =?us-ascii?Q?TmIYb7350NnSsDz3KvKAriXgYPRpvoooi/ZMY//H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c175d111-18d3-40dd-b7f8-08dc48a63c76
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:23:19.9282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3F43ltkAe4s9Wep4ECJAwY4M2GT44jnw0aWbswqP4PIDNnMtYFkoo9lOhdWP3ROc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879

The patchset supports pmic pca9451a.
For the details, please check the patch commit log.

---
Changes in v6:
- Change the reg to the second property.

Changes in v5:
- adjust gpio@22 to the front of pmic@25.

Changes in v4:
- modify the comment for uSDHC but not i2c.

Changes in v3:
- modify the dts voltags constraints.
- remove unnecessary changes in driver code.
- modify commit message.
- add tag for dt-bindings.

Changes in v2:
- drop old part support.

Joy Zou (3):
  regulator: dt-bindings: pca9450: add pca9451a support
  regulator: pca9450: add pca9451a support
  arm64: dts: imx93-11x11-evk: add pca9451a support

 .../regulator/nxp,pca9450-regulator.yaml      |   1 +
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 111 ++++++++++
 drivers/regulator/pca9450-regulator.c         | 194 +++++++++++++++++-
 include/linux/regulator/pca9450.h             |   1 +
 4 files changed, 305 insertions(+), 2 deletions(-)

--
2.37.1


