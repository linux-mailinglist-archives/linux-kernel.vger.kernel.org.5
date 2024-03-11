Return-Path: <linux-kernel+bounces-98755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C985F877EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7962820C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0753A1CD;
	Mon, 11 Mar 2024 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l4rU/42P"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5F3BB20;
	Mon, 11 Mar 2024 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156245; cv=fail; b=JaLTK+iw2CK5zUsahtP6zmoja6JCz0LRAnGzITC8jHEFmHjiM3uuFmgSTfE2MMDRrMZfCH098NKriStpeUo4GSFdxVwRyF0lb+y6d0jL7bDyT5qwRGx0neV3Zxe/tuZRkjQ4wOewOQat8z58X0hQcpA61hko5w57z3l3a8VxSss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156245; c=relaxed/simple;
	bh=0OKdNpyMTvE35glb7QWRVBmBody/4wtEJrDdJp6slBI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SDSHex55fMHfMEaYuYCBWI6m2j/jWCyumCySTdc/WHFJ9pZp+dc+rd3weCEAuMlRBmHW8o497o/17iJPOF6Apv1wLo/6D7bgIAkpxVHSHI7YFEN/IgHUm+UbOcSNI2RNu6b9E/XrSLDbB+kHDIu3/k0Llnlrk+tYGsS7oH+4Op4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l4rU/42P; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO+pADOhpRD+cBCtzF5KP5F0uZ6eG8MNVy5SPIqR2Z6uOTLTdY7kUccBcm1eBDj/TYeRgZPyJhJqqb/R7BZvX4wX7Hxkm9I7LbLs/E9lFsf2JT5/Z030prCUCMQMxRllzJ8wBcYZ4dNZHdf87BFGNKcndtwxPd72MPlCxqSgYFvpp/oJmHhACj+6AmTOvkBklWcfDgct0G7yOmuOPdz7hJGBvWPHItcGxpgj2Fw6ajL2QTOjyBSQTgeJ65dxMKvOil98C8RRFeUh1WRQhTdmgZJXxTR6Q7oPDLIhsrXqxK0KXSAGbFT2yHn8zmhP3sG3LwKNasrBKM+IwXZT5Oq2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCZ+oNcYdDnw7MRTGhDS4BmDzKPx2igFcE6vbn26Qlc=;
 b=MxjXyYw9w8/KHyX8SasGbhmGzFDHto1s3M+CASUflI/RaWCaApRtPoYcdR26RgwosMfLu9Tc1jBIU4VU4BDy9k08E04Eie1XvabIBVxI8NwcgoCWbQFHBVmtG5XNaY7al0um3ztY2YuNMjPewldLOD2K3QLo0lh7oOmpKsQxPxzdGZBbO2FRG/F/fpMJ5bj044RiJuJ2GLoXWI7h7epgE7venScsZL67Vnlz9LgieAxFg0WjVOdNYswfVIxXSlGukZvRIomdJzZtuR12UZUKtYWm6rYjBpVHWnCbj2YK6y55+wmtYyPsEA7OH9l7MO72hL8Fb/lSBdUMVgkBX+NBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCZ+oNcYdDnw7MRTGhDS4BmDzKPx2igFcE6vbn26Qlc=;
 b=l4rU/42PjbFRlMvhKJ6IksG4hfWHZOU+sqZcaUpBapVl2YnKi9wmxnUV7ew3QQdKKzaC6TDEcd0hAMeXi8UeyLhMmrpKMf6v9WpYVZgHpf6aIKNI1rw/7z6Nu+8ZfNrX4bsYb1uCBbaER/4YhC/e0kgsCb1Ww4/8gVaalz7ECz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 11:24:00 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7362.024; Mon, 11 Mar 2024
 11:24:00 +0000
From: Joy Zou <joy.zou@nxp.com>
To: ping.bai@nxp.com,
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
Subject: [PATCH v3 0/3] add pmic pca9451a support
Date: Mon, 11 Mar 2024 19:31:58 +0800
Message-Id: <20240311113201.664252-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB9377.eurprd04.prod.outlook.com
 (2603:10a6:10:36b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9377:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8f3e71-a12f-4a84-0d40-08dc41bdbfd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ypk57eja/GmjDWxyg3a17bAWtAQGtSNIErd+YMOUKa1F7ULPRt9o/zgZC765gIOz2SMc5muAXoQiKWjzlocLE602YKTW8nCTNkDw+LniPs6YW0VyRa4XB+YCfPPtiiGdPXePZYT83opreXalJFGZcYyKxGvKlrQlC9Y39qi6a7ou+0KpdTfjnofAKPphFCodfO8VawSuWeHeO45O22FMdqKdtUIoXk5QJyHAu089X/RrmSrY2GUj94MUUJOGGgRd+tAVo1e4l5svUT0nSaFE4vmO03B1bv2Zn3pxYyYiu0p6oMmmljbrrxVjG78r8uPZnffCcP0McJmEYn6CmC9eHfBf8AscCXY6xlztZofDlzIyEyiDBqim1zF3n0YW2tiJYXyAl/4rZhdc2ruOUlVVuh/Lei12mcAX9FxW0i8kL/Hkc+/gjkU2LdujVy3Kc14eTDRXiUPVTPJHq2eqk5Mr2ekIfv26cPZUNYqccrCTM411T+TeuAaWaSYMQsnsryFyzqtgo4j8Q3Kygv6VHJck4284iaSFu5vIWT/D5RIbG5sDE7dc4Q7AaZmVMREAk/vke3g4lRyUC+KnT4BSWWggWbOXZMnAquQKtTIRU7HiLg781eY5uDdBPZnuh+JOWhPO6aJdmny4zlcycRJfF5WwqBuaOl8Bq9Kuaeq6/UEZDIwV69qeezgGXcOSY4XeToyNWR/edxU6I5mLH/MrZll28PAkBRldF6KN6mvzxixE8aE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nCe6q8INEKUDunFXdqmvTXVeSJZJfD8MXfFHvyarYdEqZxmmtjqQQcVPaKVV?=
 =?us-ascii?Q?zZNeltEuczN7llpDpot093rV3qUbX5wPox8i+iovO0mH0oaU3AMBnuDbpZE2?=
 =?us-ascii?Q?K2xcY9SpECjmmRyIOtpQBPXwdiHgASAQIzGNCrz5ro3Vyn5pngVcQTI2U1V5?=
 =?us-ascii?Q?PMTKSp+/HREbUuFPI3TRX5Z9fVU7hkd7d7UPWqR9UXlsuxvF7NYAkjFbvvTu?=
 =?us-ascii?Q?8vEHiKRcg5TCC4lAY4PhCqMNbOzMhlVoiliEKmf6KOSkBQoUYHeO1N46i89H?=
 =?us-ascii?Q?mlpo+4R5w42dT9KPvpLuIkVLAe5ISSgUu706ggUYM9IA28vuFztf+OHPE9l2?=
 =?us-ascii?Q?+G8Zq1TWebTuArjmZLh3t0iBSNwlGhuuSc2pGZ889P2m+UXmg7wHr/izq/9l?=
 =?us-ascii?Q?4My8sIX48ouQhL5/frEexndqqJnChCoJvZxOX7fXYBnR2vLtY1TWczGtUzeJ?=
 =?us-ascii?Q?IYcrqaMRsbE7H/a4cvV4Jy5KnspagXBSryQoJZwqLwfbKC1T3qfyDmVyv2eI?=
 =?us-ascii?Q?AiH4NxFNliEroiwPd00QZz+mwtwFL4u0mIXPI71qP4B3yuMzLN7x7cEJiD4K?=
 =?us-ascii?Q?nYH7GXGhIZlfS6wxOOTpyvOIsxug7u91yjcSEYP8gRn94SfY3ajooyVW81Wg?=
 =?us-ascii?Q?PpkjyX19U1k0yBVAd93PcOdF86ij2Df3dEsQ/CD9rKUBjxC/zqE27aguwnQf?=
 =?us-ascii?Q?JW9WPlnz9CpvAxyZ1mUc86ThwWDToXkYYQKsLMytwDOJtYoa5GL6+U8C7RNr?=
 =?us-ascii?Q?slsC79X/+liuAaYUrvwnHcHxEsF9u4b4myMSSW4haNTf0z5oRQ+t8mNPMIm4?=
 =?us-ascii?Q?2Kx2rdXh/ghG5JC/TWApDnwK7TsT5Il4KR47UhGVpyGl+KE/yJUYoOCHsAWj?=
 =?us-ascii?Q?h7mXUThv+VbOpLEddMWbrsTd/NXkWzGY0ikJOLdhX/uUJHhZmzedZsdWar3r?=
 =?us-ascii?Q?aG8PH59JQwAogXn4uRthFJhkm3QtSfTvTYfZrfdOkmzddYfd+pYVqYrZ4sNh?=
 =?us-ascii?Q?Dz7WCqfKHupUD93YLCYG4hwLqJWcEcVpumo5tGSg0IzgH3nlO9botV2HCxsa?=
 =?us-ascii?Q?qjTPlzBgALi6+m7gd6J74khLhl0JlMeG51bqx9PGiugXCmewV1DhjMo0z0Jt?=
 =?us-ascii?Q?MPdjUSY59hQqFJS9cY22bvzblD3Wnzm+qVb/bzTZVEgZRbNYelIlT5qtwpp6?=
 =?us-ascii?Q?7rNqcQq6YlXoq7zzd6lEdt+OyjNqtjveKt6kLAE+DkAsLwdSuGbnktfhhuJ5?=
 =?us-ascii?Q?LNoovVbLy33WZpSqgY4ftTKbYJfRz9wdTJK6sHCVZnTjUavMAoCv6XNzZmZZ?=
 =?us-ascii?Q?QA9rPMuxObDESfWab0U/h5qpAj4NhJf95DB58o7jSULBC/HHML33yTKejuB0?=
 =?us-ascii?Q?Nmzo9ZahkctuSx8LxQ60iiWedg5y0qJ9IDamZGy2uecZS1xRVrxgN/WSNn7n?=
 =?us-ascii?Q?OAkJN7MmqQiPmn+iUcjKMXWZoJ+hQ6qaw4ooBqVkwSKdz3FsXuia1lCCmwNu?=
 =?us-ascii?Q?OlqpS8Yd7S1EFftfZv25oHu2RTmpfaoTuZizhNY2sedxz4vaxYL6470shAyK?=
 =?us-ascii?Q?Zc1Jl77t5u6kz40cdCnOZImyDTD6tyEr+u6H3q1j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8f3e71-a12f-4a84-0d40-08dc41bdbfd9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:24:00.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVJV33ICV7YfPkncVTTcyNNOAZvgTXdBW+1YXjetHuHpX7xDink0qY46J9vWIoEN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690

The patchset supports pmic pca9451a.
For the details, please check the patch commit log.

---
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
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 112 ++++++++++
 drivers/regulator/pca9450-regulator.c         | 194 +++++++++++++++++-
 include/linux/regulator/pca9450.h             |   1 +
 4 files changed, 306 insertions(+), 2 deletions(-)

-- 
2.37.1


