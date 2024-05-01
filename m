Return-Path: <linux-kernel+bounces-164952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5863B8B855C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84200B224C4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B225026E;
	Wed,  1 May 2024 05:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iEKTF46A"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14EB4CDEC
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714541576; cv=fail; b=uBrBoGiVO9mwiRIubWnaSWcdGqbf4pX+NafSCCumyglQqQVcUXTiFmMuet054hfhqcoggPrzyp7jbWuM9G7vT3Hy84gBtgt43O4PomeXmTutxFieJEEFx5HKFsUA+Zkr2KHDO7llJWgLt6+mTN8edv5zY8V+5iJhL6U7a92vWFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714541576; c=relaxed/simple;
	bh=uwMqgs77uOVDL1ohlO/x0xkJFou24MbOwUwzpulhlHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K2e0Jy3QShiraJkrtrlVC+GDZUhZq7CinE10Ev5NWFzVaTUa7Tq0Hwev5mVeQ5OnQxxHDaMQk3ZZ97DxcmNRV/I2wmef4QDF96K13Y9tPeQ/NKXLvxq7SoYkkb7xpod729nV1eurX3k7NbBDYLPyIn4eulQqYTDg+0elVOXaAZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iEKTF46A; arc=fail smtp.client-ip=40.107.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4KG2mcZ/1Mek9q/NLRYBRKX+VuyVVyqFIKAd0eULgytxYT04ZbIyWjqZahl1S/rKaOlgYWgumRwKgglZt0QxdTf3xkdzNow4Vhy4jfOzEB3tP+PD+qz8u+cgd6AI4EstR2HknE/blEW06nFMf/m0ifYVwlyo6Lh7Qz1hXa0/lwFji/pW+6huLy3/HxPR0Dw+hFU1AVNkx/qL+EJL1my01Wrp7GnLsWAXdkrYkeAkBiDFimLUU5XOgBWc61RCCZiTS0BdJ21Zsho++1dArrwazcqzpnap2M4VPAN98pH6/U/COn/e7Nf+76Lf9Dlv3obA/NQ4vOs4WGoKQJ70aQP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Out/W8/iZjCkWUDh5tusZTqTuI9w2WE09XFW9dv0T6g=;
 b=eFyd51yVSp4Glh0xv8AKmVzWQvcpYsK2/xhsrEXnTvuGUFk2gN6pvEd3BMAPrXopgwqbBvzl75f3soxjs9iTT3A59gnD4veZ7+rLIKRLsB3I8vckrWz5L6MVCJ914pEdkIKZPGguXuKjQOWOZl/+di/iOe/lRpsjcV8VTfrdon7omR4qKaYFaZjjhPqHbMRwA/D6pdjt+AWuF5+wdlaD7m6XZPbV5u2yjKdhtJKs//MzItThspHYF8KX0WPqwc+6Z5tVbaluB08+RlfMSGR3Ih4YUHxGd3zjjXL/UaeGWmvvGb86L7QujWI1uG9DQ5p6LYaTXAGrmNbsluwshlzDlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Out/W8/iZjCkWUDh5tusZTqTuI9w2WE09XFW9dv0T6g=;
 b=iEKTF46ATqH2TQllBe+Um/u2YuD4aTGjvQTBDP8ZaZyXrKE4vlU2/CCGvWJeZgrs1Rw4bsugYn7MJyJJD9Si62iCNECjC2E6TJqRTBns+S0G9e1sJzFmpq4USz0LnNY6TdJebL3rhnwWXBNgfUcPFdAv+MYPTazLiR6t7kr3XPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com (2603:10a6:10:36c::10)
 by GVXPR04MB10071.eurprd04.prod.outlook.com (2603:10a6:150:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 05:32:47 +0000
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab]) by DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab%3]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 05:32:46 +0000
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
	Vabhav Sharma <vabhav.sharma@nxp.com>,
	Franck LENORMAND <franck.lenormand@nxp.com>,
	Horia Geanta <horia.geanta@nxp.com>
Subject: [PATCH 2/4] firmware: imx: Add SC APIs required for secvio module
Date: Wed,  1 May 2024 07:32:03 +0200
Message-Id: <20240501053205.1737248-3-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240501053205.1737248-1-vabhav.sharma@nxp.com>
References: <20240501053205.1737248-1-vabhav.sharma@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DB9PR04MB9354:EE_|GVXPR04MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: 28dd5c37-88d8-43bd-bd84-08dc69a021f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|7416005|376005|52116005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gxNBISdPuUMw5aiuy0AwAjNTgq2FtzGr6y4g24y69ZZk/haFyG+cWWbTj3YO?=
 =?us-ascii?Q?qzLgBAluaqaPXNclXID1Pck3J3txLy8qxPoz+f+kSg/DbLST/0+uiF+7H5FS?=
 =?us-ascii?Q?RDm2sC+5ZcWLfL8f9slmqwn0AHL2IFNm9kuQ6f5Rkqd37X9O6cGjoGiTqwcO?=
 =?us-ascii?Q?dTmQGWzIWM3bjsH8hUbbLvOJ9aM1UNeAWlZWBfPAB5+jkGmAE96mNKIo27TR?=
 =?us-ascii?Q?0mosYeqVMGDo6T9Q+b07d5OUFm5xQEa3BRzBC13p1df0Ro+cdwhHipRksLMm?=
 =?us-ascii?Q?zB7/954L7A1x+gmPX2BOC2Uh2H2mWOa4ZQa3KZgZrOjQCK0fF6D1kR0I65MV?=
 =?us-ascii?Q?p6CzMoTaepehUGGbdk5/1D+UJ6jzAtKvaa57sQXSUGUeJMXMaZgLkVRkQR0I?=
 =?us-ascii?Q?Fesok8y0HZQVLDdTDd3gGU31lkyGMLaR5PddATD+PFvIxEdWzbaVV8dHZ8h6?=
 =?us-ascii?Q?zb/MW/zOuNdg+Z8+50fSfjZD9A1qiC7IVy5qirJ8arsd2ma/vD64Vu2CeFos?=
 =?us-ascii?Q?BSnSM3RXjEypTSd9W9rpaANB+iJ2fapzySIzY+ZC4Ayhg4Q5XM6H5ORdD9f8?=
 =?us-ascii?Q?TK8QsIWcVQxPc8MLs3gao9eNoj99Bk4uJ4EdoGXceZwW3kDqPLvgbO+DYkBQ?=
 =?us-ascii?Q?ittTb3BP3RhMrVpTzECvmNsy9vQgTM+wAWzYtJJ+NvdAXfEVY8Wfyjvt+Z+6?=
 =?us-ascii?Q?7k76Jau9Fed6VJ4XjaGmf2/u7YfGrQIem7PI+yLmITZBsOFMlTPlUBOx7Nve?=
 =?us-ascii?Q?ttFiB+sEsPjFgyi2lXX5aZgpdv7p3atkArMcpHA7Mmx2fSfl2KQiFBespgkz?=
 =?us-ascii?Q?nYxA+dq87uxIrik2dVDiwZ55r3J8NRME3nYI432JaZk5YPFk3L0FPTlls9Jl?=
 =?us-ascii?Q?ckVX08R8tyn0ZqhCb1sccoQk0Repwf0tvX3JVFyZPFGVec63p3vvZFxOYUzZ?=
 =?us-ascii?Q?quxofCWXX7l+hxCinqROBrHMWI7LvmgQpQG0rk0TNQQjmieEVykfO2hQ5eCo?=
 =?us-ascii?Q?rhvJc4MYOx0znM/0KoP0iF7bQaiYfi0aTaKJJwuYEP0oxE7j71unuwOt0kZG?=
 =?us-ascii?Q?V19gUI9oqn5+OFLsaPEIgUmKB42LAav0JZs3FEgMRllNLIsgLdowFhdqlNMT?=
 =?us-ascii?Q?mF9jLIBLTQ7rbyFS359BT6+bB9MMYl8SYPFFw/IQqxAI6Qova80T8ciheyzp?=
 =?us-ascii?Q?wUWI7e1Y9MWQ5By/FIt618l+XhAMhOO87Tv8gS5Snj1AcHdfK9ChDdn4zvfv?=
 =?us-ascii?Q?2cDoogd6284esUf9XrCjvcrdsjJI/7UpXhMd4CHDsAcjpc7fTlMDAfqpJfRz?=
 =?us-ascii?Q?o+mriw9NvvUo+LFMwLhi2Ridq6n1M07dmmodhf1a8O/d/fqDBXst8Rt+qOZx?=
 =?us-ascii?Q?0lcy9p8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9354.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BVYeWOk38YXD9WYYA9/2aKiR5VG+QS7qzrkzJXKsJnTtkJ96ocQ4Idxj3BEn?=
 =?us-ascii?Q?9Mf9pBOAxcyUPQXB4/+rf/kPiiE51SCnb81Eh/5ihEBOcbEmntMoYxS4+XHX?=
 =?us-ascii?Q?qjwUxbXB54A3aC2NOHLCY1McatlTwGwTXBUWyojTZ7RV+VzhGQDngDG3lRyv?=
 =?us-ascii?Q?mg2wtj0AVr2QdplbWTBsPDsR9tQo1fFOy6426kQMCsK9oSz99xZPQxBIP3P1?=
 =?us-ascii?Q?FgOCxi5QYhb5r+ygBJC6R92BbGL1o8p8nIC31l9g0Mk0NkoQ5iv/Jrd1WiuE?=
 =?us-ascii?Q?Xv3Hh698xPxiA33kOeLX8Y8qgfh8dNIuGlZFgVe80UBs6tPda0BmYxBFOSii?=
 =?us-ascii?Q?DFzAlgsFjEOValleSY7NAMvYhlrGjnjRFnivs/T5YJAI4341XT3v2tg4U4NZ?=
 =?us-ascii?Q?ktJBJ0vYMjHyMe1MIR06z9IzVaoTK/hov9eIRpGpAUpQWBrnWJ0kxs0gyCK/?=
 =?us-ascii?Q?LPW+GfV/JY0603LO8YcbpHJJCqKgtRLpUF81DsC52WVUMLLwCyshLFMA8Fwh?=
 =?us-ascii?Q?rwD9P6jDUBEX7WQqnivv4Se+87J3CoCNW7b4V5G67u8irA51xBM1Y6TgNVWG?=
 =?us-ascii?Q?Bsl5FMchAp8tyV2VmQm0oqYAGwT+B1/Wx+usNWPBJ+q9+z11fEoCoezbfh4I?=
 =?us-ascii?Q?zHJdJ2wDJ/v93kS4JVzpjZtzb0IaASdWX1eMDIl0a6Hyare6WaySjhKjU0Up?=
 =?us-ascii?Q?PMnqmx6qgoT+H9qDGThqKuTEoEoe9Pnsa9XaECRPj2C519LCXdyU9eeqevkN?=
 =?us-ascii?Q?cwBM0oSuPAKoKZdCkhjIT8jSaazjlFIdms3gedFeWMitibxNXvxLNE3cLuxE?=
 =?us-ascii?Q?lhHILw4gIWWpc4LmPd3y7U6Slknkk4XJDVulkdo7EY+64HLrhDfy/60Kk58k?=
 =?us-ascii?Q?tYt38T1XoFh+YwZRYjOCZzk+tbv/eVRQL8zuhI2vGLUk2WuNk0Ja03l4nI17?=
 =?us-ascii?Q?YOkmJgc3Cil5jKgXiPo9Qn356QwBnaykPUSSXxUdCG4kLlmXE2mqQnCK+TyA?=
 =?us-ascii?Q?fDFcLK9vQJSxUiqKe6nNp4+xJt44dXGuh1YCEInhx4gYi1XFNlKdm5HLdC5v?=
 =?us-ascii?Q?G7I8q2R0KYd1B9uEATOTMnXUZNj1VQbNKERQo5lVj6pPE21UPk1zzvzyqFXH?=
 =?us-ascii?Q?TJJmTD89892vyOuWC/KdKW/TzQ0S9cZI7/aGBDRekvMShD4U5etikN6Mu92K?=
 =?us-ascii?Q?aphoJa9HBiMTExf0rpL40INiNzb3Jib4oLfEeuASr5w5SlPOugF0fpT2UuQn?=
 =?us-ascii?Q?T3hCZHn4mrPRT3bTHJpdPbBGQ6uhzzwSqi/1uOr3akt/DBIEBq90bfdTPO5m?=
 =?us-ascii?Q?VENX6rF0ZseXe9bHopMMM0JCT7ApzlM7sHfEjRCjb4dDK8qi8aZ0Z6qFitmh?=
 =?us-ascii?Q?yvqHoDsqM0GMGqqbCzxAwApLEuFvpWszwPTFlJZPp8nuRaMAtsrSFkrR97Ro?=
 =?us-ascii?Q?jyEsqo32RmNqmbZ6/TinsxvMmbixWEBSsdenX3tm8i6jY2/y8qzrdSA/nB8q?=
 =?us-ascii?Q?172U2imELs7554/6rwe3IkT/Nw9JNlB3Cc+BMXQIbeFaDte9exzGgv9GlQeN?=
 =?us-ascii?Q?zi0T/AtwOD9ab1Vy394lxP9snTa1WIZfM9Fh2Ju5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dd5c37-88d8-43bd-bd84-08dc69a021f2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 05:32:46.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xd79naCG10ekIJpHecdmFejrHXpP3T1aC/6mEfATjyuKlOej2AshS1g3wCFX0sEoRuS31SaJhkfTYDbx8UbjFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10071

The Security Violation module requires SC API.
Added below API:
    - imx_sc_seco_build_info
    - imx_sc_seco_secvio_enable
    - imx_sc_seco_secvio_config
    - imx_sc_seco_secvio_dgo_config

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Horia Geanta<horia.geanta@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/firmware/imx/Makefile         |   2 +-
 drivers/firmware/imx/imx-scu.c        |   4 +-
 drivers/firmware/imx/seco.c           | 216 ++++++++++++++++++++++++++
 include/linux/firmware/imx/ipc.h      |   1 +
 include/linux/firmware/imx/sci.h      |   4 +
 include/linux/firmware/imx/svc/seco.h |  69 ++++++++
 6 files changed, 294 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/imx/seco.c
 create mode 100644 include/linux/firmware/imx/svc/seco.h

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8f9f04a513a8..b53d2dee8ff3 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
-obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o seco.o
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 1dd4362ef9a3..c96dc73689a8 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -242,9 +242,11 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 		 * APIs are defined as void function in SCU firmware, so they
 		 * should be treated as return success always.
 		 */
-		if ((saved_svc == IMX_SC_RPC_SVC_MISC) &&
+		if (((saved_svc == IMX_SC_RPC_SVC_MISC) &&
 			(saved_func == IMX_SC_MISC_FUNC_UNIQUE_ID ||
 			 saved_func == IMX_SC_MISC_FUNC_GET_BUTTON_STATUS))
+			 || (saved_svc == IMX_SC_RPC_SVC_SECO &&
+			 saved_func == IMX_SC_SECO_FUNC_BUILD_INFO))
 			ret = 0;
 	}
 
diff --git a/drivers/firmware/imx/seco.c b/drivers/firmware/imx/seco.c
new file mode 100644
index 000000000000..2d6bf301ac87
--- /dev/null
+++ b/drivers/firmware/imx/seco.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020, 2024 NXP
+ *
+ * File containing client-side RPC functions for the SECO service. These
+ * function are ported to clients that communicate to the SC.
+ */
+
+#include <linux/firmware/imx/sci.h>
+
+struct imx_sc_msg_seco_get_build_id {
+	struct imx_sc_rpc_msg hdr;
+	u32 version;
+	u32 commit;
+} __packed __aligned(4);
+
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit)
+{
+	struct imx_sc_msg_seco_get_build_id msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_BUILD_INFO;
+	hdr->size = 1;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	if (version)
+		*version = msg.version;
+	if (commit)
+		*commit = msg.commit;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_build_info);
+
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc)
+{
+	struct imx_sc_rpc_msg msg;
+	struct imx_sc_rpc_msg *hdr = &msg;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_ENABLE;
+	hdr->size = 1;
+
+	return imx_scu_call_rpc(ipc, &msg, true);
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_enable);
+
+struct imx_sc_msg_req_seco_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data0;
+	u32 data1;
+	u32 data2;
+	u32 data3;
+	u32 data4;
+	u8 id;
+	u8 access;
+	u8 size;
+} __packed __aligned(4);
+
+struct imx_sc_msg_resp_seco_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data0;
+	u32 data1;
+	u32 data2;
+	u32 data3;
+	u32 data4;
+} __packed __aligned(4);
+
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size)
+{
+	struct imx_sc_msg_req_seco_config msg;
+	struct imx_sc_msg_resp_seco_config *resp;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_CONFIG;
+	hdr->size = 7;
+
+	/* Check the pointers on data are valid and set it if doing a write */
+	switch (size) {
+	case 5:
+		if (data4) {
+			if (access)
+				msg.data4 = *data4;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 4:
+		if (data3) {
+			if (access)
+				msg.data3 = *data3;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 3:
+		if (data2) {
+			if (access)
+				msg.data2 = *data2;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 2:
+		if (data1) {
+			if (access)
+				msg.data1 = *data1;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 1:
+		if (data0) {
+			if (access)
+				msg.data0 = *data0;
+		} else {
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	msg.id = id;
+	msg.access = access;
+	msg.size = size;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	resp = (struct imx_sc_msg_resp_seco_config *)&msg;
+
+	/* Pointers already checked so we just copy the data if reading */
+	if (!access)
+		switch (size) {
+		case 5:
+			*data4 = resp->data4;
+		fallthrough;
+		case 4:
+			*data3 = resp->data3;
+		fallthrough;
+		case 3:
+			*data2 = resp->data2;
+		fallthrough;
+		case 2:
+			*data1 = resp->data1;
+		fallthrough;
+		case 1:
+			*data0 = resp->data0;
+		}
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_config);
+
+struct imx_sc_msg_req_seco_dgo_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data;
+	u8 id;
+	u8 access;
+} __packed __aligned(4);
+
+struct imx_sc_msg_resp_seco_dgo_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data;
+} __packed __aligned(4);
+
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data)
+{
+	struct imx_sc_msg_req_seco_dgo_config msg;
+	struct imx_sc_msg_resp_seco_dgo_config *resp;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_DGO_CONFIG;
+	hdr->size = 3;
+
+	if (access) {
+		if (data)
+			msg.data = *data;
+		else
+			return -EINVAL;
+	}
+
+	msg.access = access;
+	msg.id = id;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	resp = (struct imx_sc_msg_resp_seco_dgo_config *)&msg;
+
+	if (!access && data)
+		*data = resp->data;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_dgo_config);
diff --git a/include/linux/firmware/imx/ipc.h b/include/linux/firmware/imx/ipc.h
index 0b4643571625..df38ab8e7e2e 100644
--- a/include/linux/firmware/imx/ipc.h
+++ b/include/linux/firmware/imx/ipc.h
@@ -25,6 +25,7 @@ enum imx_sc_rpc_svc {
 	IMX_SC_RPC_SVC_PAD = 6,
 	IMX_SC_RPC_SVC_MISC = 7,
 	IMX_SC_RPC_SVC_IRQ = 8,
+	IMX_SC_RPC_SVC_SECO = 9,
 };
 
 struct imx_sc_rpc_msg {
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index df17196df5ff..947e49d8bebc 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -15,6 +15,10 @@
 #include <linux/firmware/imx/svc/misc.h>
 #include <linux/firmware/imx/svc/pm.h>
 #include <linux/firmware/imx/svc/rm.h>
+#include <linux/firmware/imx/svc/seco.h>
+
+#define IMX_SC_IRQ_SECVIO            BIT(6)    /* Security violation */
+#define IMX_SC_IRQ_GROUP_WAKE           3   /* Wakeup interrupts */
 
 #if IS_ENABLED(CONFIG_IMX_SCU)
 int imx_scu_enable_general_irq_channel(struct device *dev);
diff --git a/include/linux/firmware/imx/svc/seco.h b/include/linux/firmware/imx/svc/seco.h
new file mode 100644
index 000000000000..508444c02d39
--- /dev/null
+++ b/include/linux/firmware/imx/svc/seco.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2020, 2024 NXP
+ *
+ * Header file containing the public API for the System Controller (SC)
+ * Security Controller (SECO) function.
+ *
+ * SECO_SVC (SVC) Security Controller Service
+ *
+ * Module for the Security Controller (SECO) service.
+ */
+
+#ifndef _SC_SECO_API_H
+#define _SC_SECO_API_H
+
+#include <linux/errno.h>
+#include <linux/firmware/imx/sci.h>
+
+/*
+ * This type is used to indicate RPCs/RM/SECO function calls.
+ */
+enum imx_sc_seco_func {
+	IMX_SC_SECO_FUNC_UNKNOWN = 0,
+	IMX_SC_SECO_FUNC_BUILD_INFO = 16,
+	IMX_SC_SECO_FUNC_SECVIO_ENABLE = 25,
+	IMX_SC_SECO_FUNC_SECVIO_CONFIG = 26,
+	IMX_SC_SECO_FUNC_SECVIO_DGO_CONFIG = 27,
+};
+
+#if IS_ENABLED(CONFIG_IMX_SCU)
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit);
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc);
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size);
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data);
+#else /* IS_ENABLED(CONFIG_IMX_SCU) */
+static inline
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* IS_ENABLED(CONFIG_IMX_SCU) */
+
+#endif /* _SC_SECO_API_H */
-- 
2.25.1


