Return-Path: <linux-kernel+bounces-164949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C20E28B8559
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9AE9B22558
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D5E4C635;
	Wed,  1 May 2024 05:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SdF3Qk44"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2081.outbound.protection.outlook.com [40.107.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC5C487BC
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714541570; cv=fail; b=DYpD1/wC7noU+B7DyU4973y2JkQ6J7v1vmbujrgDQ/8NPNoolDHoq8F0iFm20gElU/k/ZDyI4P7b7L/7MNme4Uq2uxwBXpvZZB9yr/fBDeS0GYBjhCZXHTxVSrQvp8DMn0fCIKcyXyhADQF1vYwcZtC5L5tgQnvvjaMepU00UZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714541570; c=relaxed/simple;
	bh=wc1/9BYvtDC7he2rYMli1J9zGaGzCfsFcdaWnM1ZiQU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=j62FwrbGqq9OnpgA5c5Gp3vFALMAjytF/NO3cr7aznfCLqIO+jhZZoZfXojswjh8UKeGNnuSSsEa4iKLcn/Wma7Fu3uT16bJ/+TmAZKoiW/0j9SXqMU8HOIhY+PstRjQineK7LCsPyRw2zvS0mrLD6Rwj/6nXsU36HBO6Jgza98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SdF3Qk44; arc=fail smtp.client-ip=40.107.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAXPSvEdn5l/+ffIdnxjQtwLsfOnsDmTc4J4oEIMvzvGXqkfBdKXfFmDuCKryw35cpo1JBYIM6XC85prHj4+rchyMCKQOY6XygfVzImK9YXz3c+2MDhzj0miZJrenBBrqZ9gbBKeYbNoDytpqVFLo/YhWYJzXmmqK5HMzJPr8IuCjiTz/EvI9mJq0w3T4vvTWFHFTAmZli5+h2FJzr9+cMEPkMOTU6kTVMJrtS+6bbkJOwGiKisOerf7x4BR/azlnFmPxwMAHmH3xaxo+htm8izK67qV6iJn1KOg0cMIJqrt9/cFlgaSqKlE/gkLuTjGzHsjIAvURNOgQZJ3qg3n8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRFdVZ7lA5tcovoqX30gq0W8zH4Lh+vOfntvi9JUfWw=;
 b=Tuin5pbEV3TN6FJJg1hprHI76YLfLQrZPfqnLuUN9Y+EXXipMCWqVRgdRDRKJsHoKXfhU3d9YWMd75ZIJM83SBbYm+9JTl8bxeQtwmuC1IY9ZxANb5mpGZz7L+XpzOc4CW0Y19aFFw1mQ6qtvZbkvedwR9iJWpFfjrMiv85GENziuISIYZKrEW+JOKNVKVRnq5fVtgf7njZGzvvE6AcFfQratxzGvURUQ9PG9UnIPvZ2dmxkLIz+g+kAEkcARXOu4kNBVqeXXdbAI5pxQY+uADMVq1MtIAufPoGkSYZQKyAVmFn1CbQY/wCNhp9oeIcKyv7gzbW4y2S3BQOaVinz1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRFdVZ7lA5tcovoqX30gq0W8zH4Lh+vOfntvi9JUfWw=;
 b=SdF3Qk443mxml0i0mxtUNoGUKvp3H9RkSVWWtlj1zXHXLKhdmdU7nQXoOXj2MUaMYwNj0QT47H+t+jxJMgek4F+xOwSrmmYC2bGTrZMToJD7dU02iluUx79xNVtwYjTbPu/Hh6yE+i977hUIi+Wojwb/kGQ7v3+HKgt309NF5EI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com (2603:10a6:10:36c::10)
 by AM9PR04MB8859.eurprd04.prod.outlook.com (2603:10a6:20b:40a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 05:32:45 +0000
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab]) by DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab%3]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 05:32:45 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-imx@nxp.com,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: Silvano Di Ninno <silvano.dininno@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	frank.li@nxp.com,
	daniel.baluta@nxp.com,
	Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH 0/4] soc: imx: secvio: Add secvio support
Date: Wed,  1 May 2024 07:32:01 +0200
Message-Id: <20240501053205.1737248-1-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::20) To DB9PR04MB9354.eurprd04.prod.outlook.com
 (2603:10a6:10:36c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9354:EE_|AM9PR04MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d165a3f-b65e-4320-1f37-08dc69a0211b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|7416005|1800799015|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fmfuBPAvFoEnbsv9EqAFcSojBaJmofpcj4DbgqIaEE/TRrCdrH8xCSnrYOwB?=
 =?us-ascii?Q?Yp24njoU171j06ahtWNZkU4Pdva6t8tNuwDMZzrR6Tp7jkFqS3FrNR2dfH2X?=
 =?us-ascii?Q?3S9ty93DG2Hcy7gUWoLXJwVLiJf26y8GfS+Mp6D6MA9iDI6hVQouM1ZvJ/cU?=
 =?us-ascii?Q?h4dKsaiCu7Zrrryo+j3aQ5UrKa+KHHPU9urj29CjRsqBg1k/g6trTqCVzmPC?=
 =?us-ascii?Q?VKy50UkKshRTP1IrLvhBe6/UZ1wqfwbaKYXbqhyS3wYeYlWqBEG0zn98i6D0?=
 =?us-ascii?Q?yvolnv65VTy+nVZtqUxjrxKYfDntAtzhjOMxP2ucuO9NvVjGtaObnp7ZQLmw?=
 =?us-ascii?Q?/4vxjpoLZKj8a+XNZkCxYOS/QFR73qWkRsw6xGoBWFiLy9k2CysypROZkMi5?=
 =?us-ascii?Q?MKziheeUbGOWFRy7cyXWKCdWJH+/xJhfVlphgzKxLcQFOOaB+UArrcOVk9q3?=
 =?us-ascii?Q?tGQ4HWyOLr711pvpPJ4NujvYtd1xLw3fQhQnkdU5N1fy7xCJ+iLGwrJjnMCQ?=
 =?us-ascii?Q?xDUfIrIkElZCiya6GPS+FeB26ZoRy4ptk6nWFOH2Pz7WGTWcgJyDbeREyWt1?=
 =?us-ascii?Q?+2W/yLrW6xEI8hiJMnXf2w236jiMSzCyiC90KQcxaUeCJ9TtJCWqIXOJbdP5?=
 =?us-ascii?Q?bsg+3iTG+bmuwgsvW9+w7pcWDFd/4MjXUjbpXERdSlfletalSsJt3JW7fuxr?=
 =?us-ascii?Q?SDsD2IAqsqVFe5+7hTzMIwVGLnwiavNEaNRCnWKH6j3mlfT+h7zmqt7VflHo?=
 =?us-ascii?Q?IQvkStBTuz6/pNGcdh53KRt9YOpC1Tw7RuTJ1z3XGDkZc9TwJbijVXzFF/V2?=
 =?us-ascii?Q?tjGyNb/L+hBtDEr7f9ZSJcw1+1RKGPPJiagXn+fFPV+xRdXyNQShYgIRxubV?=
 =?us-ascii?Q?1+rCZQtDuN7CSj1aBZYUD3lRhG6+G29npFTUENhX/lZtjbY4z6ry7COjck5K?=
 =?us-ascii?Q?1Rt4VAbgNUb63S3kpHSJa3Xq17DgMDYJGrx5re+SgJdlfHIE9+sHqkgG45mL?=
 =?us-ascii?Q?wFjYWnbr1u61nR6/WkB/htEFiQ8nAllm6VB5OOSAM7FTrs17/mqy7OegF9dL?=
 =?us-ascii?Q?cJJ+jWGnCkCCZ0XUH9oT8naOeQpy2Dqtgfe0TjsOqVDI3EtgrnNAew7Eionx?=
 =?us-ascii?Q?D2gYVzsWA2Naab7L5VrfXLUgpRoc5maVUQWokH4AMMbasrea/hNloIpUkuln?=
 =?us-ascii?Q?2hGbap7sznKhSQrLPuqUwYoew8bgeJMsijCHd1evjEFpXxIYL43Rg6tX/PK+?=
 =?us-ascii?Q?cOqZGkO4h2Olog5Ew97hnN/o5+5bka2AWLsc+v9xZsiO4447xDqVNn561Eq/?=
 =?us-ascii?Q?BSoXpnck8fUZxLfRTVXAwfYZP6L1//migb+bOXPS3kZHfETwVp/i6I+97aDw?=
 =?us-ascii?Q?WiIBmvw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9354.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9gAxixI3GXIPjMfL5FEROvcCKseDEY/TGke/yfdkUntivxeeqHZKxUtrloMu?=
 =?us-ascii?Q?9hQcxsq4WLsgKmFqDoQKeEKMX4zWeb89JpYTipMnlJi1RLXgWaVTnBUTvLxC?=
 =?us-ascii?Q?/7wGu2RBMvtzNM8Nq5zaRkTVeMGDtAGPgD2B/Fdk6CkyriQOmQcBKSMA730p?=
 =?us-ascii?Q?vpSDUGHgr2bz3IAZGouOUlH934WCRL6Km217Z4J+yZO3fC3oE47BdiX61X6H?=
 =?us-ascii?Q?7bbw24AXF1HsGyC3Hgd/n1DwmLQSWy5ckRl5kaS18jeoiK6OQqgClqHsWfNd?=
 =?us-ascii?Q?wv+L/4jZQOuMm6xKYhK+pQTmrhc6lU/0tSR2+r9bbja+j3PkQ2gwnbdB8KHO?=
 =?us-ascii?Q?eDLiyBtLAJh690nkTMsNqSYmlLKSq7iMZF4LWBQ67F7ujJVQAADoHXeXKPue?=
 =?us-ascii?Q?doGuCA2DALPk1iwSgKHbxDmmHQwPtfUYzRj7fXnmMz/GzmnnFNHcnueUSNTk?=
 =?us-ascii?Q?VN1xb10KSAU3qS4bfVBPXEnFBVzKszwRNlclMkD2lsqhc6EJ4A5sN4QGBVv4?=
 =?us-ascii?Q?0/xAS3vd5sogh+RNSrQiGDQAMKLuLfUoXLYpZdIuptPNwRC8OK6YxgCwhtwQ?=
 =?us-ascii?Q?r+28xr4N7LX7acnXKBjQTWsrX8WXLsM7WsiT2qNbudMix9esHo0nwvW33ilQ?=
 =?us-ascii?Q?PxMmLZs91fA6bSK+zHY3QmlFgU0IuCzhF48oqxc8pdr1bdVrYM/iC08z26zX?=
 =?us-ascii?Q?O87R3OsR01r2pnLS34c9eAfzkZPG02FS+QFgt4Toasq9IJ6wHft2GRcQDP5v?=
 =?us-ascii?Q?WGdLBGoyIPFMq9FhDLht0aNRqedCloSVo3EjmP2rML2GC3az2M8EPK1Tu5fF?=
 =?us-ascii?Q?A0tQtW6ykyaHdbJOAuccm72GEFUYL+KG9u/JY2KWdhfhs99SzrLRjO7wndGJ?=
 =?us-ascii?Q?xxhK8huGewPWc+XqRDDD/hMTGTNZuNRYfPqGdKaakphnOoZJNEOn/NqhXAgy?=
 =?us-ascii?Q?TpxihqfHBXD071d8gXunIi2AUQPa24bsDZX7lDWitWK6yrQSMJnPUPTdEZaa?=
 =?us-ascii?Q?AGDIq4sAeEkdl2fmak0We0Ig41hs4nZ7APJ2RlKTwbx7VYD488LxB3qglIT+?=
 =?us-ascii?Q?7oZ8blyttHkYMDZ4jLsROC8+7BReMv+GIqdNlD4g9qSki9Xu0dL19DAuY0sp?=
 =?us-ascii?Q?6n6slT280jqsRz0UGFhAkMqmsQhjsnS/o+s+y1ybrHMKxvNE7JOGcW6dw9u1?=
 =?us-ascii?Q?IpmthkTBcFHtyAIlGDCQ4bk1YsHdRNWc+eiHXp9/FHhE1ryzHJPN6gJKEjHK?=
 =?us-ascii?Q?GKawkBtp57CRD3LPfhNWAzt19CmSbqoIjffxXZ0qBZ0nyPkXCjivTkCyQ/p3?=
 =?us-ascii?Q?8StygXLTj8xS/UvchQJG0ISMZ53CKp2LPmvWgnEcCD2F8SmvoebrX8/Hh8KW?=
 =?us-ascii?Q?utVD4JHbpUuoRoHwXpn1DF6enuJb8vwzWzebcSnXRBQvsBan96RbNYDpzXtH?=
 =?us-ascii?Q?HM8oCWjWlaKEUW4F3G2W3/V98x+H9fn1HM/WW05vi4GVtmL1jmkHJbmUg5GD?=
 =?us-ascii?Q?SaVDJjVtxa1Nd3d28eZCz35/wfyT4+KDD4jJoQKCRQR1MRqTmJxFIHtaMTgY?=
 =?us-ascii?Q?cTbMPsrRkH4ppqsil2+pLxtILA2sHLp5wWAuJXnZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d165a3f-b65e-4320-1f37-08dc69a0211b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 05:32:45.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoU1af4iS/bvnmd+IBxsE0CL/5lc792nT4c6wGZwyuT0Snd7rVbfzcD8mNQh0N1VErYj/DleZ+YkBA9aiIWG9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8859

Add secvio driver to handle security violation interrupt.

Vabhav Sharma (4):
  dt-bindings: firmware: secvio: Add documentation
  firmware: imx: Add SC APIs required for secvio module
  soc: imx: secvio: Add support for SNVS secvio and tamper via SCFW
  arm64: dts: imx8q: Add node for Security Violation

 .../arm/freescale/fsl,scu-secvio.yaml         |  35 ++
 .../devicetree/bindings/firmware/fsl,scu.yaml |  10 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |   5 +
 drivers/firmware/imx/Makefile                 |   2 +-
 drivers/firmware/imx/imx-scu.c                |   4 +-
 drivers/firmware/imx/seco.c                   | 216 +++++++
 drivers/soc/imx/Kconfig                       |  11 +
 drivers/soc/imx/Makefile                      |   1 +
 drivers/soc/imx/secvio/Makefile               |   2 +
 drivers/soc/imx/secvio/imx-secvio-debugfs.c   | 283 +++++++++
 drivers/soc/imx/secvio/imx-secvio-sc.c        | 595 ++++++++++++++++++
 include/linux/firmware/imx/ipc.h              |   1 +
 include/linux/firmware/imx/sci.h              |   4 +
 include/linux/firmware/imx/svc/seco.h         |  69 ++
 include/soc/imx/imx-secvio-sc.h               | 216 +++++++
 15 files changed, 1452 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
 create mode 100644 drivers/firmware/imx/seco.c
 create mode 100644 drivers/soc/imx/secvio/Makefile
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-debugfs.c
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc.c
 create mode 100644 include/linux/firmware/imx/svc/seco.h
 create mode 100644 include/soc/imx/imx-secvio-sc.h

-- 
2.25.1


