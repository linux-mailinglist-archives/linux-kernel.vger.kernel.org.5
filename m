Return-Path: <linux-kernel+bounces-57657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E09684DBDE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1DE0B20EBF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414676A8C9;
	Thu,  8 Feb 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hLwgdHpc"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2107.outbound.protection.outlook.com [40.92.42.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A26A8A9;
	Thu,  8 Feb 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382069; cv=fail; b=Q7I545QyG9eyqIFQQCfo3EPc3V46vaWCXD86zpTzMKrubAeMRJ9+tjX4FRTWDOttYIgpeHSPQSKGRtIQ49F88JE/x1/g4dN4N3zPUWjdm0s0xKwhJCIH69grvLi0hV2X4e+bZNI7IetosisT+PFbFUvWAWd0NdI6jScsow6XI+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382069; c=relaxed/simple;
	bh=BEuuu/WSK/zNFQ+na/z27swfV/k+tccAPw9KIjYGaOE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FYWLAmD+pWLUTEzzjQHy4iNeexdapbEQNFRGAQWrPpcCZtOKpkttNaLEao4zZtHMk7jvy1D2foXD0xQOATHNYFFTorVhCLzL0s2NZWec916MjeehZaer+Tw3653gvtsxQazC/38m5WiX8Y4ZqQlxggU/SBm5dndTuJOOtQjhKBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hLwgdHpc; arc=fail smtp.client-ip=40.92.42.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gt6viydCx0lGvAWTN0AAQvcHv7DcFa98+Uw+2FAXrQyhIduUWSew68XZxjmb1du+iRtE5G7G4ec/UzGvjTP7uOTdCeDpbPcypM8Nj1cT7aa1OdeGSK1c2RSGWWlF7Ueni6YAjUJWRHc87GO9fL+tVJpXPuGOG3na2HvXxT0SMQa3IriyY0b+QIMZTrpZE4VIXyF4kocYJdtuqPGh57CpHj9n9uRZmNdc5Gbzo4ZHZkczKJQkow9tw8im6QR0L61/OSc1Ibb9bBl+hmlZENWDLTCJ8jBv+mB+WfsmLd3wyEd16OsZxM6Wz4uqdEA0ErFOASRELxc7QyhZJvrdaodmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPt728JWQKB11LAfIAyYEWAAb5P8id84wKpeuiHCdS8=;
 b=UOCMATprAbodVHXzotOeTE2/gt5ZfC14jG04fphSoxFikX3Azz4tPFAIXaVNUhBu5Ajqxe3GbroW+Od7eG42WBB3mziHHfD3Lo1W0k+bZ65k01xn1+gaB9Qr4YaphfADTrbtaLv82d4/IxqA2aZcUX92oA+/8yaVy2k8Dve1k4n8mUU5FhOAvb4vvm6HRE7gVrvcFIMpE9SvMfFsiIQySDkZSo2sewSIprW9CI0ZHEPWitJuvl2MypH50+3y8zLtsaLGtpLfN8Xs3VgoYzxH3Z9/myd9CjDNxEaArmeNF/cqwz61N+23au1m09IWJG1pwvwPvVc8bgCg14cr5OCIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPt728JWQKB11LAfIAyYEWAAb5P8id84wKpeuiHCdS8=;
 b=hLwgdHpcxY5Pe+81Q+XQzwTbOCbBbgQnP6X0UcyJfYB0PaftiHcN10OQr5EparTE4Ej7y6B/x6Ke2h/4A/sTLG+JOz1hrpOrBeQ8NqjDmfv8hyuWWQmSO97G8pYenAq2E+mf1v0NxxXThZThCdP6kZ2zCadlSAbbP96pM0lC39EhYdMIr4dNdwyLEfb2o+iPYB6RkIY8ZxbkOmxxUwDBDdXZ1PBs5B+H4gW9WTyX80uCbhzjbu3vO115FSZ3xKIvEuN4gSQ5iFQKei4Nikwe80ecTBqeDEsG00fX7tRAA6nEdN4pIUnPO4Aq8iobdnccqUNr54/LKcNRJUfrHXV+xw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY8PR20MB5985.namprd20.prod.outlook.com (2603:10b6:930:73::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 08:47:44 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 08:47:44 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v7 0/8] riscv: sophgo: add clock support for Sophgo CV1800/SG2000 SoCs
Date: Thu,  8 Feb 2024 16:47:42 +0800
Message-ID:
 <IA1PR20MB49533B0C8B05FF5679E0C2F4BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [McTkfx7ccH6l9onq5zc/paGB+pttV+i3Ucn9JyTaMXWmTVzZE3PYfmo50dRN9OIW]
X-ClientProxiedBy: TY1PR01CA0205.jpnprd01.prod.outlook.com (2603:1096:403::35)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240208084744.1112468-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY8PR20MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 41df43c5-3882-440d-a50f-08dc28829ded
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m+Zm9pLA60YDx9ic/IOb8iR0YoSbfehTnFDgBu12k9+9Ubq2WvyliHyCB6vKkdxzp44oM4JbrNGoP4DBQc9fwEgEyr6HvXjWm/H0jcfuztZL69jwjJJxkv464OIQabi6YBYv4bEgTIL3B/B2k38rBjqghxOlrQAVvMXcJQwDqPJSQHzqKhO+eBmPVeJeZGpJYqpzTJa7vOY+TEG58qIYpmbdSgydeK/wg1Q9NduYze6/8iw62kc41SJ1qgZOtdC6Aq3GF8oV+QKw8TcHe81SLz48fosEF96cN+yWKdscXzPP0vv9wiOJb9jPdL6Ez08PwLrV/qPkYB7IfE+0zFudQ/eURfyyHgURHbON0HDAoaItcdX9EWFWj1BtZeo1sO1YQ+o0QLbVbziIg3G8fdS7HOGSO9wxg32HNplyNzANBrF0FKqSEBXFG+Bm0PA60rKTd8T5jBREI/yAk5wvpePzRATXFwdI202DMslJe8XibP86/pDggDskzIvL4wSHZdPyV33ciyJvemhP1t4FjpIdEQwI6iBklM8IMhtRIDxm/FNIExgyzAZsR7a9qxFMDL9NK5V2pSwLKdVU6PXD+gFoJRMd6EkZuxC3QfKxJJWRM1+Xd4IdRuNP8QEncBai/FSd
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WUXR0fRCx3Y7UKfm/pgCx2CTT6cBYyNb5tkCmy8+gaTpEEOt34OZlzo31T1C?=
 =?us-ascii?Q?wLWLrE+snf1oVVnAT3EXROvUHDP6h7fL3DVKcxJ76BeXlb+s3UgvdjsnhW+x?=
 =?us-ascii?Q?efxJzFWZ66SW13nA7yUFU3oxICMh5CqorK7G4/9FxoZcBUU25+9R4GgxzfBt?=
 =?us-ascii?Q?01M/FNkuVfzjcbQkEXnIUe1RGMf65w2vvjnXCwh5d+vkRulIflHPv32SMvFA?=
 =?us-ascii?Q?pabNb8zHSICu3/dZgfQJE3/mADhRh+ycPVGnPUjGorRY8RAEs8u+k9JwCMeo?=
 =?us-ascii?Q?634ngo13ZXo9lF3zoua2DWp7Y0kLAIn9qcxeAUZDaytJC1oXZQNsB9kZ1PaL?=
 =?us-ascii?Q?cgvRwJ4Wg2EMzjQ5d352VfzcEo2GEQQlz0a4FyqETHtVbLTxTz3gfoSPbsOk?=
 =?us-ascii?Q?tS49FPnxeclwXVODMqqXL+g3GF/4FL3LmmeNASiYFh/KX04gII3uEf/zv9Q0?=
 =?us-ascii?Q?sE6nn+YBK5KsBitWaL8w2x56Wf2DgLhnUoFJbKNcKm0kbxNGlVAAWK54OWCs?=
 =?us-ascii?Q?EsN3fcC7qpjeX2QUCMeTWGmxPGzdwtgEEX+N9hsYD0GJfOXN7Z1WF1VTuYKd?=
 =?us-ascii?Q?XwIYH/pxHNLVoRl62++eAzIf6VkNG9oNeObC79fJrJqMZn8x3iruww7npCqi?=
 =?us-ascii?Q?8htUdVdR3XpmJ/sgoFZSrIkp84ckDyOw5V0dpY7o9VdmKL2qOeNHUT8pQicN?=
 =?us-ascii?Q?gO47VkamTXfG9olnzwZqU8vjL9rFpEiFmDWysgwttJosRftnfTTn9diYosq4?=
 =?us-ascii?Q?LhC07yMqaDt/hn3kxFexHVAlijXmQ7LUDez1BzaolGpHNBsTiLpoEpzR9t3l?=
 =?us-ascii?Q?dSk0efCcq3nfUvegcnlwM4YVkTHl9OSwcLEXnBsMwQkdYn4i6gx+4n4wLMnj?=
 =?us-ascii?Q?ozV+sRfELlibgxmhfPjMQ5oPdsNcbNcmyntUy9L5sWoCft+04+7O7bAfoJIc?=
 =?us-ascii?Q?zZO6Tz80Zto7B9L30am1ri9DCYIs63tgdP9GrAHhNZdNh505e7nwQUC7iM0N?=
 =?us-ascii?Q?htkPyymxCE3eYgztb6k/ThAbp45gn42PahDXwziB0DrAtUfF/Dob9xq8OMk0?=
 =?us-ascii?Q?L/C0Xj2q4/FlMxx3xQdHoFDLmhB6tv92f7JApfXTonSwavk1WKR3PBjRJAsM?=
 =?us-ascii?Q?rciGniOqdnkx7J/ITbCG2YSBQhFoALTXF9mQY82zVm0EAkuUNnUz+2QIDcBX?=
 =?us-ascii?Q?SDXelj8opo0GFZwaSiHtQlYNTFb/2WUckWBV4pcE422kytmmKRipMYkEmfrg?=
 =?us-ascii?Q?zmSr4Hl+2h7Sz10/GHPnncJ/Qt+d1h7O6bzEo4+0Fw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41df43c5-3882-440d-a50f-08dc28829ded
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 08:47:44.2367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5985

Add clock controller support for the Sophgo CV1800B, CV1812H and SG2000.

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
2.43.0


