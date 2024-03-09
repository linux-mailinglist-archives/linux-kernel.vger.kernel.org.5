Return-Path: <linux-kernel+bounces-97818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58F1876FEB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031F51C20B2D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BED2E630;
	Sat,  9 Mar 2024 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NoDOFASp"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2102.outbound.protection.outlook.com [40.92.44.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430523DB;
	Sat,  9 Mar 2024 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709974943; cv=fail; b=jBTgoX1uEuxlAMKxTQm28EU2mf1c6vc078WtbX+wfPCq2gbTcqcZvGyANftxSqjN7jSM8ACUuMnd/n8rT5kXqmIZl7BPxdljBUeQty79dc2QwRzZld5dwjwmeapgPsXkFZhIHlhkxG4HyCwLKmmhuFsmqFUKZhqrItigyAMH8h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709974943; c=relaxed/simple;
	bh=sN6XCJKdQdV+4nTFmyDp0eAhTUtnK7UAyZ4/vFGhq5I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f6hq3wMq7J19tOrTno05W+v1RNEOfI1+g7G4dJsxG8t5TPyvi2DWnz+XZVnh3LKPNDzOpqWJIuM3UZBaiWeO/NSiPtgCF9sYH7ZNOn9sg6loOy1oIeuuvhrMWJWndfDTIGFFBIqnpKdk2KREmWDUVUL/EcFdjiO6YFBwBtP97S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NoDOFASp; arc=fail smtp.client-ip=40.92.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMDDRxwn2LjmY42rkopUhB/ErZ3a9rUQauMWtLjO7nYcttlcZHBHTaFiOHBrJCrmrXkaErxFDvFUy/mOqgEbWGQ9SBN9paxTNq9tMvyN1TE6V1wr0q468Y1ILnyH0zfx27TPjVNNk1fETxhR7IzhUaHBmhUaiy9NFyjpsdqM5xfozKzNw/6l1f4F/u7kVqZAZnly2Pt3XMsRw00AsFWVBMPkMRftBiHxCnRCZYZ27mPs1dVbBq4EG8xoxHWDDC7lFnVLqivm8LAqlC2hccyGA/BR5mX4s0tzB3hIH+LnghrI2hJIfXSqqBESm0v2Cnk4pdEAbZvdHIjBGYOrF3sKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MP+JzqZnpiVdRKY3YuQzMrKA+g/MlHBCB311pDKWoEU=;
 b=bPpXdIQRYLwTlPoGaqP0LpUT6bcHzscqzhmJy45H556+pT6FMwKmu5ZF667+8RSBUtO/HtFm5EhicTF2cVPn7yXj/nWQTmj4/OKleYJTdWlm7Hbve29PN4GS0/VmTVa0ftlmIelTsmCj7XbyUSYlVh6znt6u18YhQVg3XfIUEyBq2DDRW2/oDWueqBTBLI0phMdMn/xYNsNDfPNvqEdqqSgq7BceVMerEZ0wppt+Zo67BlRl+8C7ddLl6kHec9FBVGJLJBOHGDxmSqNblZBRsEC8NwQGx+ZKPrPtMX0a+rHMhHg4wLtM42FTTKAc6EWq49Blciogg6Bk56qpDASTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MP+JzqZnpiVdRKY3YuQzMrKA+g/MlHBCB311pDKWoEU=;
 b=NoDOFASp7OkW5bBaxehCl7MPiToRMLlNaqZpYdj7N4bysDH+w98Ghcq0ztN+8ESwUziNpEioGXoJmpbD9WSF533pp+kNu1BQta4E/Lc9VBIeaSDseSMumg2o88wkIOjGADpdwhDzLspBKxLqcpnhNjrRewqrcgUcvm5nAfDykVYQe52aaEJp8dN6YKvOyRcRcCZE/Y+1Dsri1Op1HIf9yJSI5rbOmuQX4jng4JZGFcc7is5y8CTxgNBjDF/UpIy4ltVef3uFEOcoSk+oxsj5ri4w1+L2u3IVM8r0xAf7U46rnKf2p1+775TE9GMK5vqQ2asmB3iXqetAj2i72ha3Eg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW5PR20MB4260.namprd20.prod.outlook.com (2603:10b6:303:191::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 09:02:18 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7362.030; Sat, 9 Mar 2024
 09:02:17 +0000
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
Subject: [PATCH v9 0/6] riscv: sophgo: add clock support for Sophgo CV1800/SG2000 SoCs
Date: Sat,  9 Mar 2024 17:01:21 +0800
Message-ID:
 <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [em0rheyqiWm4b20DP98OoLbeYI6QcF0VDrHxlEQGomk=]
X-ClientProxiedBy: TYWP286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240309090122.927241-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW5PR20MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 925f8e54-bb94-4fbe-11f6-08dc40179ebb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bSsZ/Z/9sGB4zBhvqEQ4Ho6Ns2rLVJtMdVNoc6Rmiclj++uprKvk7jzsGzxinBd8NDQEdNDxTz6R1RC47DdWVplfIGmCKORLmcw97e4gQ8kZzRtyP95cjaAi20iA0eSb1VJhRUM4UwO6gN6oZwJSAXBNpMfpQjoEV37e71w9796LNldwMlh9fL4qaiPDeS3mSJzigtQS8oxOlfUP45qUPv+IMtaieHTRze9CqdgC7/IoVr5y0pg70bb7S3+02wSbMYphanTzLqUhV5Ui0T13PBG1vkKwnBQZiEVMaQSzmbzfUiQai0e1kDJ+uyWbwcszjmbbIpqXiTCqxMJ/I7cJ5s1f50/PfJEnLiAuJ3R5GNhxrfdyK9Tw1PVktpgWRa6WkQw2vxbU0GQ7jfRSoama4lYkTSUIUPGrxMiaZohS+hcZLxIS1f3Vj8TRrKaOEpH74Q8sRQFhOZMVSeu22kwGpqGCvQZqaQAutZRuV4hmpfGPg3eRs9Rkqf2Jru2+vkNHneXKGYQg2dSheNJGRYY6+GuV2yXBNMg9sV/aKwLfAh+xyizNPPMn/loU6o2RrEQQsGPs7il8QJaWKT3XqMPN7tER1aor9o724KOzL0my6+m5M8NAXBz6+Na3gx/YYjzvzIezW4h+T4+9MIfNcbu7lwJy31acVQWsMPYXN7xNwiFrUfYkk9WsTrpX3bqRES9z
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Yqn4yW0OjsQ/YIlQiEgIJ8Jx+4spx6hb2PvvwwLpaghYcq+Vbz9s+tgWbU7?=
 =?us-ascii?Q?/WayHTDRmbn2t9hZ1aB0A2Ngg3GOuRVe1eUIpV8Vb7v7gF7zql3zuMl/WYwD?=
 =?us-ascii?Q?fw/za+rxqODenY/YONGTDXjC7Wfd9PM6vkhfP8ejMr1cNq5zQIiwHhxTqye9?=
 =?us-ascii?Q?r7dIitbt0mg8GjcMnvO0ozVdJ3w+DVcPG52Pqf7hePYOg6gsVcGC4ByXu4ci?=
 =?us-ascii?Q?Z9Npf4sTCHwX+g4P8HqDxRcYd0DM8CCmYjxAoqv5Dngv/FTV+c3lM2R13b7w?=
 =?us-ascii?Q?B63yV8MmD2edaioO1n3C4SChNj7rdc+OG7SroLomCcuxO5IY+Dk0stiwOeh1?=
 =?us-ascii?Q?o9rs4JfaWZ7lmjN4I+URFRAvp+KHzM4TZdK+OUuR/dpOPVymAEbCUxx+ZfqN?=
 =?us-ascii?Q?MLFk1zV2DHMHRfS0tyELjIxUXFLlaNzTYL6A4LrAeqnJiAVWVJJ0HyCVc+1I?=
 =?us-ascii?Q?LXALKKxmx1jRuACW+3qUYVVhdvgPpZ2t2E2soPk2EI5ZF0u2Vajvz/0/+elo?=
 =?us-ascii?Q?9iJl3rRPPaR8y5UQRVOW0pNuD0ytNg/LHOj6OhzfBjE1LXOA5EXNddEGTY+A?=
 =?us-ascii?Q?rUbi6VC09SXFT1wxZdmE/f5RwR4KefmyV9SAn2w6ipnPdbY61AnrKgr/UJUO?=
 =?us-ascii?Q?MyaYSlPE4kN/P4MQfIc4I2pSRi55J4JgHjdP1q8bTzTZr6UCizfPkUNPOEwc?=
 =?us-ascii?Q?mVSwkIQ3LhFtvMSQMxJzzYFXsdiQyFzixAFZlm6PPbmY6LXEBRT072siS4Ra?=
 =?us-ascii?Q?Wd2SF3AD78BvMvDnZDQhp5Kw024pYOpkkj5uiYKN24yCWI3+XOhtrr5PZJII?=
 =?us-ascii?Q?JfpzmMPAxZZE8EzfjzNU/VIgdQ2TM8HWVMg9801UY3gT4Kcn9b5FwZ5k+wjN?=
 =?us-ascii?Q?RlIS6uJWgcE9nUP4WQERzAIFWE4jmeuNtCa/KAdQsk/yqmiBNicWo+nTYDZd?=
 =?us-ascii?Q?T5Lr2kVDTaOsPractKp/VhKKt4p3/CjyI8zoCnKkMNdSsm4KUNq6CGFU9qaD?=
 =?us-ascii?Q?GW2uQowI5e1CaWUQp0A9a8ldw06LZB5gXVdI4HkmOhs1IT1LlT9boehIf4hn?=
 =?us-ascii?Q?jLVpA7adyeFm2BISvOSdBHjoaO6B4QgKAHHK4VHLttYKy9eVA9ASPvtd0aRj?=
 =?us-ascii?Q?I8gnuobI4Cl73nJiEqud+IL7tMencvj8JN5EEillsJt0EoQDnNX/dfN/minl?=
 =?us-ascii?Q?DTP8iIxeiCUFKUEahKhTyMKEcBzoj5i5lVq3IIzZybrh4ZQveNuUgpzL3P8c?=
 =?us-ascii?Q?GdFMpu0OOzDFVX0913fs?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925f8e54-bb94-4fbe-11f6-08dc40179ebb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 09:02:17.2680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR20MB4260

Add clock controller support for the Sophgo CV1800B, CV1812H and SG2000.

Changed from v8:
1. improve code.
2. remove default config in Kconfig.
3. merge patch 2-4 of v8 into one.

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

Inochi Amaoto (6):
  dt-bindings: clock: sophgo: Add clock controller of SG2000 series SoC
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
 drivers/clk/sophgo/Kconfig                    |   11 +
 drivers/clk/sophgo/Makefile                   |    7 +
 drivers/clk/sophgo/clk-cv1800.c               | 1537 +++++++++++++++++
 drivers/clk/sophgo/clk-cv1800.h               |  123 ++
 drivers/clk/sophgo/clk-cv18xx-common.c        |   66 +
 drivers/clk/sophgo/clk-cv18xx-common.h        |   81 +
 drivers/clk/sophgo/clk-cv18xx-ip.c            |  887 ++++++++++
 drivers/clk/sophgo/clk-cv18xx-ip.h            |  261 +++
 drivers/clk/sophgo/clk-cv18xx-pll.c           |  420 +++++
 drivers/clk/sophgo/clk-cv18xx-pll.h           |  118 ++
 16 files changed, 3540 insertions(+), 6 deletions(-)
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
2.44.0


