Return-Path: <linux-kernel+bounces-98543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B75877BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472B41F216BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4B12E59;
	Mon, 11 Mar 2024 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZjQNn69y"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455810A3D;
	Mon, 11 Mar 2024 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146406; cv=fail; b=O/gCOvjuBw+Pd++yMmG8YQsRkt6S/KH5UUnWauLUDFMvgbcvFdOSwbIoXjjYgorbNNCRjdahL9KUcpQwI2LLSX/1J3fPZ+e21iPJihdUN35eeQjXc2uCLQ7b5jJzXqP3NdqhOyLp1T+hBvPR+CetyU23hR+l0zO/3do+5kLdg80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146406; c=relaxed/simple;
	bh=68W2mU3xWkGujtb9GJW2pZh2QaQ5zHO2DcZYaHEOR8w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dlepnxekXMxZdgz1ue9zOlThbO4gAiYxrGijkG0MQeOsqxrCy2NursHFZkV2I0sCC4Hqq5LPHgTcw0ItvZUjBBPE7dGR/+0QQWwBJVNQJUQC9e1WmNmLmeFtEwGBHtZb7QOvdacv3c7S/WETq/KQteQ6TK7DX/OltrMIMQzYQXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZjQNn69y; arc=fail smtp.client-ip=40.107.7.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0Jib2jRbjKf8rmE4EZyYgGYgj1cvXxZdzoSo0eeWj5vhrVqskZtwX2dWKbyLlauhelWjPMqxVLqQtkpU1UpdfmIFboPBOWEkwRH/K5kZ43ZeO8qOdTLHn2FvnuqmLNSDfqaqzUDiVNNYy+KP3Kbw4hADdi/3PFdZafipCtp7m9E3BkakjZ4PlRJD/6vbPeGKUVVK5jsdEiTXuYrE/GB2q1NA3oOwKihHreQnY7SAnDAGlBwgCfxUllwoUzNIuAZncIqMRXtdirmDrByAEC+WwdY4lzcuuqun97U5oe3bDpW82JNt6a6xR9xGxZF0V16HqGokAQy6jt/2wO33gr8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7+p+y5VNeTilIPJk5AAzBBMxBHfwXozUav5YwKfsFE=;
 b=Si4f9wRpJW0X2PVO40oxTOrLS0twmGYQJIyLP5VWWkucckYh6GU781ikUbwTnrk2I1eypz5g00/rdZ6+ztVlF1hxb5UCzYg7AQoEAGBDquzf1awFuMPc719R39cHeQDJ5eX/cQtNi7JZRLjOt6jAV6owu+uOkjg1AKWj0fna+4sXIj9uPTzOzISZVB22yS7CRVhGYUUt4stLaIbQAxK+9+XdB5q+OrBqLQm14IIjQuapRqptJusQ2t2/i4L8S3j/gV2Sy3y1kdlz+O0U+bCSBpP7rXAOJ4W9cmhex1JQvBxV1dX9Mp4ZVyXLg+B1Ov9MB56FfUTAXxMbBH16iaB12A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7+p+y5VNeTilIPJk5AAzBBMxBHfwXozUav5YwKfsFE=;
 b=ZjQNn69yPagy8kZ940hcZK0nsT6HJzpVaJZW0ORwLEIQpzcG/O3hj2zTlu4cE7CWX8b1G+dYv2OQNcv6ZanQOIRpnM7rMZGbwipqzohnRrUTlNji7EWsmg0EZbzlRgIIYGywzBD+Y8DnPYQP5Bcklf0yPD3UBuL8wHodASkuKwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by AM9PR04MB7602.eurprd04.prod.outlook.com (2603:10a6:20b:2db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Mon, 11 Mar
 2024 08:40:00 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7362.024; Mon, 11 Mar 2024
 08:40:00 +0000
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
Subject: [PATCH v2 0/3] add pmic pca9451a support
Date: Mon, 11 Mar 2024 16:47:54 +0800
Message-Id: <20240311084758.377889-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To DB9PR04MB9377.eurprd04.prod.outlook.com
 (2603:10a6:10:36b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9377:EE_|AM9PR04MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 14fe3f0d-d6bd-41be-5c53-08dc41a6d65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C2OWclM9gYM2B32nc9p0nkN/XHdT46C4IHLXXAgsIi4YLmyopV4OAmhnHEE0ZEHOjEfkf2WwC/bFT8ARcEA7G5MnwJ0un6DGMM90iTN+evNOHuR/svWY2qUfkTTb+Q4WBVV7VFaVpaoUWzW3yWStrkOOWNPjnsIOy3itK3sswbRDzHq515GMAwPl+06Eq6yrhGqTEUZMaXztlJ16IiBJ7EQk2d0sI1RLWbGyKyVH/9wwRes4UpMWP//OXdRvRcgLy1ZCRxOyFb6LssPjy0ggbfjUShNN6curgISyEbrL3bzlO25fx6zn9UMqUrq7yVAv+9Wc+r8JTv2lL/C8XfxcpMTl7vS+IERYn85+OnvD88YU3ZNIIIFSB0s9GTN+RcRrfXGxc9OC2LreXhHDbjoAO5x+VlIs7riur1cxdMWzoMSlqURrR3HTgMmvSe7BwzkupbGOG5OV1kfn7OQT4emkAcnzkipeNw1UCll/J7D3hygxTBXKS0et0oQcbUf2VMLB2DjWO7i38SoCWb9uPKIc52fu53HbsU0mRyg7gHmg0hgBohNSH4iWoQEw21q8XofGoBgIjqK6yMmBQdbmvSA3/cNDiASsHkulNKZIOyZAI/msM+9PRhmxm8QYD6n/YxxyEwZYu2fVEDUQGNQ6Ytb9MGEfBrK4PYokoQz/Txk6hlh7ymhV7D6p4Nz7F2Vy8o3eyLYnMvITNlZkwscUTfHui6eSOYTeUx/hBgWk9Xdtw6M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ma36JLwEEex7vX5X132vafaw8SrwJp2c1TsOuM5MhRaDWlCIEbFRDUDT6V+O?=
 =?us-ascii?Q?x6eg4jaBeZpPdOjASvZN0JVYJbAPWDyDLvT3iywc5OsWSh4oGvLraSYWgRil?=
 =?us-ascii?Q?23eR5YfBfIckgS3dxeqz0CbsynKmCj7skMhQKV87P66moGfTTRrxhnR6ZTGc?=
 =?us-ascii?Q?s/SsM4uqZaOmu5fBfrq3eftU/453589M8A96rnUZFSvoydalzGPPvUe/dvE+?=
 =?us-ascii?Q?XHjua1MfzgoInMDfJegCeP8AVCfpcJC51mbwTpM4nvofw7G20LoN7YuORMW8?=
 =?us-ascii?Q?KM+B7+v5Nl+qsJIShXn8CYVmQBdRANlVPIAEQ4lfqhuxjINKAtwrABGtK/8S?=
 =?us-ascii?Q?uS0VXwo26tOP1PyUTdSXqqAQlMqhuWOvZdiwZrl/3poi1owQdFq6rNHPxxAV?=
 =?us-ascii?Q?EfHWdh24d4/xN7/Mv1Q8g388Q3jE6yu2IVsj6gs33DP4jylyWmEs/suxjAuB?=
 =?us-ascii?Q?uwtyXSn1Go4yhcSjoyf+Oj6eJ0jGYnfV+mhfOdg9cvua9kpgLjuOWsfuA7Cf?=
 =?us-ascii?Q?RUGyYGC0yavyZaxkovUymgNSRHKiCLUrBuHN1jEtnYq75Va70SKuYgJhNouV?=
 =?us-ascii?Q?1tBQNWyiIepMRBZoXzKVVnPDzaodEscTP4+DR1OJ+3gabJ7eb8FoyKylxZS7?=
 =?us-ascii?Q?PmEGZjV/5nixywcexldFI66ywqgj/bAUpKOor5ejipVpyZSBDmphWTgB3lAi?=
 =?us-ascii?Q?z8R39UuokJUTYcf25rch+lZrucvAFJa67KEcgpLl8Qlhj9eiTD8Yb4Szgn3Q?=
 =?us-ascii?Q?Fs4juwDfix46eboKfnm6DJ13jXNZMy1SwAHiRyaupgEFWK3HICeGvBV3ohXg?=
 =?us-ascii?Q?tdTbGpfurEN/7CPTfE46+rq2yHZUyMHwiMzWH/278IxTrOXygG9NwqUiQsle?=
 =?us-ascii?Q?Mt+rIdzhAVZEYrnmiJnSK2EPC7MfA5iLkiMpeNwNFyb7IcIJRANp9AUS8GT1?=
 =?us-ascii?Q?LZ0qfRBYRsbICPnaW7MqyhMI2X5A6tqx1LTDJjZNKc0uiMKJOkyT2lDK2AX5?=
 =?us-ascii?Q?7TGlzdNpdujPbvv8zEStU+P1p3jM9CUSk90FnMyYTglfNQcxtWF75Dl8BUbD?=
 =?us-ascii?Q?ZBzjpeyQB/FOQ2g4zuYx1mZLibDPwGmGpf9Lksq/3pncyvdHJ3RyGD+cPhtC?=
 =?us-ascii?Q?Z/uqU1w11l1M51E1chji48fl3mdTHRBwy0/HTxf9OjdbQ+pliJV9ruISdf2s?=
 =?us-ascii?Q?oNoBbc/t6SS3z60ojZdDhRoLvRQQgNCdxbQJqLeNcJvdVpdJ+JYzBviSA29t?=
 =?us-ascii?Q?nktREtmWLsA86HxHyGdTcwX1W57M86t9gJPW/H/aO6ER54B6CsmyOUMZ8Fc5?=
 =?us-ascii?Q?lf0L35hzr4HcETnVBuAyTiuGCVVzaYO5r+oQ1FOIlVNpKN6t7z5XZ6mSIOTe?=
 =?us-ascii?Q?Eb7pTGJZcoD5bpG7+4HrEnzcFlV2E0ScPEVUCDpiBzFVnhjL9E+2rTaOLEQq?=
 =?us-ascii?Q?fgw5a4QT0A+sT93zUJUJIC4fhybt0sPsu26wAinDZeNLSv8e2Z0WfVRvNvG1?=
 =?us-ascii?Q?G973LkUPQwYH3oWV/2H7yWeCtyVMP67HDD+NQrhS1JlR52QzkA4aX9/V1A5V?=
 =?us-ascii?Q?z9bo54YAfD9lp9kwhu/3NreKWln+byfuPh4zCJye?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fe3f0d-d6bd-41be-5c53-08dc41a6d65a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 08:39:59.9685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLZ1rd1R2+3iRYakZQdbNf7Hac89VzOKzt77ncLqMCkKyjNnbHs4hm6QXQBLqxhz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7602

The patchset supports pmic pca9451a.
For the details, please check the patch commit log.

---
Changes in v2:
- drop old part support.

Joy Zou (3):
  regulator: dt-bindings: pca9450: add pca9451a support
  regulator: pca9450: add pca9451a support
  arm64: dts: imx93-11x11-evk: add pca9451a support

 .../regulator/nxp,pca9450-regulator.yaml      |   1 +
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 112 ++++++++++
 drivers/regulator/pca9450-regulator.c         | 197 +++++++++++++++++-
 include/linux/regulator/pca9450.h             |   1 +
 4 files changed, 308 insertions(+), 3 deletions(-)

-- 
2.37.1


