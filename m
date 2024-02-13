Return-Path: <linux-kernel+bounces-63099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F017852AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EF72826B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172A118EC0;
	Tue, 13 Feb 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rfxBzUPS"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2089.outbound.protection.outlook.com [40.92.42.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9D22EE3;
	Tue, 13 Feb 2024 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812504; cv=fail; b=VPDxtJjOJeKNPCbGGZN8MYlgouNLnwOAeVVNHIRVKRrCB6gdNrpaA3Gn+COFqnwCerIgdGwjXPwwXQ1ZVX6rzU4+mtwRLPhYtpr83imKhr/QhZE7V4OJ71hm2NGeq8NrANVgxEkmcfHNAEZKjexUzys02+9PhceCxVvY4YtObfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812504; c=relaxed/simple;
	bh=TJMQ9b1tleWzB3EubV76b3sc1s3JXdlsf2ZDkXHgXJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Tama3bKtuk55yWo+5xVcRLZmsuAu8mWG7LIPr2gUzwRqFxsiRi1RIsURsCb+opmEF023ZN7ftIX/j/wLOZW0fBxls05YIdGhELwBhAzREfImNWKqrCvYJkc6KWebqGr7S5bynjXco7arYCkqdWbG3vZl5vaCjoG3NIQgH4tUemA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rfxBzUPS; arc=fail smtp.client-ip=40.92.42.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1VEYMqONYCwE5tkvAX7qCgegRd2PA/Gp1C4Tdp9qpkn59oYcnurk3lScOzRhGSGgczVI699eKDHruRwleGYWeblx0eai77ymaPJISNb4eDm+W88A7exYHGrJfoZRM+MvMVlII3TbYYF4gW6dr/Xu11VEqehDvBDN3fJpJZBL03RJKhGW5RbnJHXPZfp4oTS6Ueg4vQrTfgFl2EgbCESRF40J3+8f2JquiyGcC/dsSlFPocj4tVzh8o2zKw0XOkVqb7mg80SgV6LkMdteZdu9TE+ELyDV0HjSuv079Tjz5fOzGnCg3rICfC9N0IWYlIzw+CwXyfz0quP+K83T5GEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEt50qoic42jLe4F/Hv1osOVrSwMApuYOG5cQBkRpcA=;
 b=eanjEHN33LYMCYwzBzo3QybizHsVTcHlUjXFE5BgFvx3/HY0ZWPdhu1HukV5QIaqa0f90p+sBVxZnJz7EV9Xlw/VC+y7zKg9PY4rYv/DND9od0CBYf5zSVrA3AVqtfD1vwnZixecJa1blbatNPOfpob8xZjH7GMQAAVNPqx4xJjWlnA3jdO1+vSuxVv+R8yWFzUAOA/tcxSR7GhsOfGv/Lw+qFoe6oB43PqdWxN4mqjJA/oyD37vb/Z6SNpqcGX9UmIGPBBTvbSyWfODDZNkpKLMqVZn0ifYsongtbMnksFs8d6EBqpkzoeL84BgcU/zurzS+WYl0+O3W15R6jG2lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEt50qoic42jLe4F/Hv1osOVrSwMApuYOG5cQBkRpcA=;
 b=rfxBzUPSqOHHJPSYgI/VICBk55ke1sjtwEfMeIbmDEb+Z8EuWb9LvD4uGwf80SvL2T1CW7GKy9KjArZOzt+gi897kce6jwr/p3ZmiIyBhVEB7fso4Xp+G21mc9wQpEALbt8S+cTcjdHZEyt/DmcQL21uqGE85bB0tUjrF2nU99TqtOsY+VR3G3t5v5s5Zb6RflbsnEafATKawbDUmX1egoDgq6h635yx0dQtJ4P2ZvgARy1VKf6MmHnZQx/CHBRKBv7uj9i+/EJo1CUQShr4nyQCrTijdj0BxfBf0G5vWJishf3ly99uCWCFxk5MiFe/dUdUZpRfVenYQ+DbjpOq1g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS7PR20MB3776.namprd20.prod.outlook.com (2603:10b6:5:3ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 08:21:40 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 08:21:40 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 0/8] riscv: sophgo: add clock support for Sophgo CV1800/SG2000 SoCs
Date: Tue, 13 Feb 2024 16:21:42 +0800
Message-ID:
 <IA1PR20MB4953366482FEBFC5E7F6F34BBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [8n6PzKHk2oiCnzp0EMVkK68fepHk6tva0ajc7E5F+7CR1eIb1ywgNgRxdkCWaV09]
X-ClientProxiedBy: SG2PR01CA0109.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240213082143.591393-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS7PR20MB3776:EE_
X-MS-Office365-Filtering-Correlation-Id: 3abc961b-867e-4029-529e-08dc2c6ccddb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NWMHQ+DHQAw+NcPXCGc7lhY3W0xvKvWf6A6oCaOD7m7pcRHFZLT9EfOOceVC2kMiYVldi02TzJB6lsRS1NxyNQSvkzx6/fH5dM9j237cMOvGAQpgH+gkD7BD6CChEXE2nOhAfLqZNMgMM6ODOU87Cb5Xw8SGIYZkGv2eyZn96oleT148Hjb/kRAP6kW7Sx9ycjVXQLJcF5SUsn1h0bG6aYRWrnCXyYyroq5eM3nRah14IWWPxUdM7pNVUc5b1rZlJnqviolCPX4WH5tAnsQCsgxf/CiW6IW7fzCq0iEk2P71nLz8/FD75hnPaLduooJw1estNcjocfy4E9IwLz9zmxtrF7sohdVPMsNRc2GzI8UAb+gbdnuRNWxxw4JpN/ro92UJ9R0p2LxsSlHQsIpEGnNw4WXGfMw/U9wCJKOYPX1Eq6fMJgyV0VWJA1/9hpKyqUkfg3Zf8PZZwj0G1ASSe8ToqyanTmaoZsygtfeERuj4DrUPmGS4l+4jAvTiteQ39yKEJLevt0mDlf47TLVHqxqbY7pDjlRl4Doixt0FyrXzwWa6dn7Y98x4OwHrzvzPn5qdvWyS2BqE0p+OD+vYyAMTdYyZHbZUwmNsAasutD43rxdPH4SmRNOihi2t3pq0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O98qB0I5T0BPZ1Eu/KR6DvjDjiLUjUZq22vbpnTk/HWN3upBKt4AmFqIfYft?=
 =?us-ascii?Q?pzsAVzzS/mU9NUj1gYr8ohBmrqcgIsASHN8kYTR7gf9L6mjmG5uAmnisDnfG?=
 =?us-ascii?Q?bbodGvHXTB93lGr6GJg8SZnqpaRnAtdgTP5YZ/lSuS7bao8oo2EAgskgsSm8?=
 =?us-ascii?Q?wZTcfgMjacvGQMW9CIbAd3d02+jQxYIdpZI7rieqITmvuVG9Vd+KkhcBKuzI?=
 =?us-ascii?Q?IsgHI3XiMJWTcAAsBePIiXKDuSpXIu1COZqFc9CXRgMB927J3LufckJ4wKJK?=
 =?us-ascii?Q?1ZrCZpyGdtbrxlMq9yE38NOhmesmPq7TNkRnlnPln7kSdjSSzURul/iNuFH/?=
 =?us-ascii?Q?qB3D46imRySPb2PLEqUmMTJsJpqDRraGpY5lhX+neftT94AjvYCYdEo9smvz?=
 =?us-ascii?Q?Od6MFLXdVNWXqSFwe0baa6taY+lwy39L6iQ3HelgOoX8YbgPl+RJPVM6pfVm?=
 =?us-ascii?Q?VQrHNkN1ctGhzerX+uHt8pspMTdLgzhNKjnSEUOyaM5rkXndzQCZwk5+0HGg?=
 =?us-ascii?Q?3TOObbEatqtUr8XJrdfn2ELKasoe+6dqkDD2DQnXY63XJ+dKUt1FTiizdw6L?=
 =?us-ascii?Q?uhs3/TDpucCt+SBGDfkuiLHFy4D1LcFRHxf9RGaOh/ltJ6ZqX9d6RsRF04wR?=
 =?us-ascii?Q?D/i0XHdVZg7WZ1YZM35hx3Nw4Jg8tQfVePAddrRqF1/9T+Teh3WtSLjVXtDj?=
 =?us-ascii?Q?gNbekVekKuytDMuyAdvpPlipsshT54DCoqD7a2lFbBN9XNkZ3bJYH30oqn3V?=
 =?us-ascii?Q?9sGdN711DU9LxmVdDRUILjy3X2qK8qOQDGS+Vt+ldZguJjE0lPb63DcIRk7k?=
 =?us-ascii?Q?HZpyjhvrkdh2MVCP8oy/B9Bp1E+cPgOteF+EtVBmc97e7Px4ltycpKg+/udv?=
 =?us-ascii?Q?1PqeIrYlILkVi+0tOD95DJcsztX5Zwm+9tpWoq3HqSnDpu39SyQ4Sz/IPGlu?=
 =?us-ascii?Q?sKtmKByruXXJrqyfsl98MjZYkQwgsItZnzl88n7cfuiL4FmcoGPtF+Rl4pG4?=
 =?us-ascii?Q?0FSy8mD45I9Snd7KGsMnAZbKqB5NW0NTFERYHho6PiREJbdexBu2Cbyup0yw?=
 =?us-ascii?Q?5E62hq8wMAKFnHGOD3Npb1V8qniFqXWIdb6Di2Vo+q4qRw8QYjaeTf6NVr3n?=
 =?us-ascii?Q?yR2YxPxsiOr0b/YlPeJYb0F3zkKuqOd3r/mURmS9PTeDLRhPXUDZ8UXZ3eSd?=
 =?us-ascii?Q?WNa9juw/JeYUC3birKdinnvUq0/0WCN3Wz9WpLA5UjyduiPpqThFMKmLJmZU?=
 =?us-ascii?Q?kJ8xmiepNsTi90DFNvtND+qmvNorB7d54WjIVuf8iVuaTGwO5lHrWSRNugwA?=
 =?us-ascii?Q?9HU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abc961b-867e-4029-529e-08dc2c6ccddb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:21:40.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB3776

Add clock controller support for the Sophgo CV1800B, CV1812H and SG2000.

Changed from v7:
1. fix unused variables warnings in patch 3 of v7
2. fix wrong pointer type in patch 3 of v7
3. move the clk_disp_vip_parents variable to the patch 5 to avoid warning

Changed from v6:
1. fix dead lock when setting rate.
2. split the driver patch into several patch for easy reading.

Changed from v5:
1. rebased to mainline master tree
2. add SG2000 clock support.
3. fix document link

Changed from v4:
1. improve code for patch 2
2. remove the already applied bindings
https://lore.kernel.org/all/IA1PR20MB49535E448097F6FFC1218C39BB90A@IA1PR20MB4953.namprd20.prod.outlook.com/

Changed from v3:
1. improve comment of patch 3
2. cleanup the include of patch 2

Changed from v2:
1. remove clock-names from bindings.
2. remove clock-frequency node of DT from previous patch.
3. change some unused clock to bypass mode to avoid unlockable PLL.

Changed from v1:
1. fix license issues.

Inochi Amaoto (8):
  dt-bindings: clock: sophgo: Add clock controller of SG2000 series SoC
  clk: sophgo: Add CV1800/SG2000 series clock controller driver skeleton
  clk: sophgo: implement clk_ops for CV1800 series clock controller
    driver
  clk: sophgo: Add clock support for CV1800 SoC
  clk: sophgo: Add clock support for CV1810 SoC
  clk: sophgo: Add clock support for SG2000 SoC
  riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
  riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC

 .../bindings/clock/sophgo,cv1800-clk.yaml     |    3 +-
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |    4 +
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi       |    4 +
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |   22 +-
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/sophgo/Kconfig                    |   12 +
 drivers/clk/sophgo/Makefile                   |    7 +
 drivers/clk/sophgo/clk-cv1800.c               | 1541 +++++++++++++++++
 drivers/clk/sophgo/clk-cv1800.h               |  123 ++
 drivers/clk/sophgo/clk-cv18xx-common.c        |   66 +
 drivers/clk/sophgo/clk-cv18xx-common.h        |   81 +
 drivers/clk/sophgo/clk-cv18xx-ip.c            |  887 ++++++++++
 drivers/clk/sophgo/clk-cv18xx-ip.h            |  261 +++
 drivers/clk/sophgo/clk-cv18xx-pll.c           |  420 +++++
 drivers/clk/sophgo/clk-cv18xx-pll.h           |  118 ++
 16 files changed, 3545 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-cv1800.c
 create mode 100644 drivers/clk/sophgo/clk-cv1800.h
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-common.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-common.h
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-ip.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-ip.h
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-pll.c
 create mode 100644 drivers/clk/sophgo/clk-cv18xx-pll.h

--
2.43.1


