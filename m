Return-Path: <linux-kernel+bounces-67870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE6585722F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326EEB22EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622382F43;
	Fri, 16 Feb 2024 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ApLlvxWO"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2028.outbound.protection.outlook.com [40.92.21.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C474FA21;
	Fri, 16 Feb 2024 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041636; cv=fail; b=qk/iz3XbPmeNffD4UUOrxU9YWFOsD3uqJZLcdMd6/KRyT7LKIP6X55SI5O/M5/Xc1wD/jc4kKtHCNMzNl7RzIGYWBKwcykAWOh5QH8h+Iml+2gfFD+I9C/j5q1UrVdeSxFRgcrBFlguA3Tqce16Gj+Gj642tFEEy0OyS2sd9euQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041636; c=relaxed/simple;
	bh=DTKspi8CdD4eizvSYyh5c3ViKBr44avuj358KQ4APK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RcHa9zxsDDV5UxJC0/74hzwzbxP05WoAFgxOG8Oj+QWcc+wuHp1doSSqnaplB0hdUKNZfoR0pasOnlSQ48wDoJcChsldi/G+4BqczWZFzciHi+xQvmbpBS/uGu1m1bZexSPaGB5PpBm/ujKqGBQCz83s0h3X/kv81XFeWAO+//w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ApLlvxWO; arc=fail smtp.client-ip=40.92.21.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpHDu/Kah9xa4hYZFshA473LjXSQuTKnqdznAOX6r8PLrLC4lW8jPAfZe5ZvWgXTHCKJHnpPZ58cHPwNVcExAXsCDqaDJPwBh2VlpNdCWn4OCi1fscJ0T4wH0e6yifz2gSzexEJjEa5TpNmHhyR7a2c4LSfcftX6HTurqGMwnhb+cMWcc68OeVvXnUhFdlQqtrUtj5A9whiX1qMc1AhTg5g5T0XnwerMfwDZK2y/2tlnymTwbGzoK2yBd02TRDSLhxjOtyIvGDCSBYm/7++E3uEReNvX2t5phe6yZ5Gz9IQUvHCib1aEfgWWmxI27NN8KxVQdScGL1Mug543X83+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyswYmvK+ldOJPF73JybJxDTxkJw+TSdN6fBn4NWEro=;
 b=bV6rav0VwC1cHPIfgBC5thNlz/CyXVZMYY+4U1Pab5QrOidyI40UlRJ9n7ghVdm0lRVGw5pcr9ckaj6SsbmAIDWznlXJYIC51U3BmoBQ4s5gaK1u5UtgKf5NQwDTNdXR/M9pg1tQaSyUcDit0oUIkyRQ1amBpvrojt5xFwBzIOD34BpFTTPDFfmN/JZSoZuaz7s29vVEDiYhLq/wZg3Aj0C0VVVv6jxWeK+dqtaaYCDulYTKJ8wooheOAhV8FA3tM2fJkxQJk/y1JmiBkxJUY8tKeInAK4qRpT5lt1wTM9CH3kUUVMCzyaFafcvH3MArIpU/Ptd8ECPf8SJFBkz3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyswYmvK+ldOJPF73JybJxDTxkJw+TSdN6fBn4NWEro=;
 b=ApLlvxWOVaimy02xHRLpRFODOuJ5zvaW0CXHNKfftpAzSGVV3jfexXgUtSc5rUoi1DoQKxXQUz+moAkJOMswVE0NmpVLoHJrB6+Yare5YYMf+2/NE29nYbsdDmUOf5FJ9FfmdcXe9BbUejfkfP7DMq5QMziD1d+U2s9uS/n32+wQionblx+avYSZRFA2HG1ilnSkFUjDa4V+dmYSK4A2E9W0ra6h0XowuU5riHRjyW6/JD0Qv1L1RRMBt7FAOK6GYOQpAdjj7mS/g5nsMytLQYfxE6C0kohr/2LLk8vsk0gIXJr4DT0P0L+03EbspR8FpJqidx+WC+d9f71TH4+VNw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA0PR20MB3296.namprd20.prod.outlook.com (2603:10b6:806:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Fri, 16 Feb
 2024 00:00:31 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7292.027; Fri, 16 Feb 2024
 00:00:31 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicornxw@gmail.com>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	p.zabel@pengutronix.de,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v3 3/4] riscv: dts: add reset generator for Sophgo SG2042 SoC
Date: Fri, 16 Feb 2024 08:00:25 +0800
Message-ID:
 <IA1PR20MB495329B03230CF29785A14B3BB4C2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <35c348437b6e18972ccaf90d9c38040caccd1f11.1706577450.git.unicorn_wang@outlook.com>
References: <35c348437b6e18972ccaf90d9c38040caccd1f11.1706577450.git.unicorn_wang@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [vs8bMyK/Sct+iTx9B+KRQ/4MMKGfk3J5HKchaFAEupyahuT9e6P+EusKXjk6K2/T]
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240216000026.55513-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA0PR20MB3296:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a93c28-34e9-4944-d447-08dc2e824ac1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FbDqT+tojq1h+wFIpA6f9gruyYXiuTjnCCC//tK8vgDhfnY7gYW/1amrb06CSr3OsmBVKoxWPY5rJQQ7BMPfpSog5d2HToV/IF3xPMGYj1xI1aRE9HRH+ONQ8A0kedPB6eowqnHYYphB89w5+OnUTY6VusoF4r8A36Hsb2g0gb7LHml0rdlKif7cgS3Fk3TrH+G1zGVaDVQElDQh9nJwaABFZFr3GsaLPquzi3AEpDTlSZYTOU4hNV5jO5zsKwyCUyeW04rnnJbEvzyJytbPGE97M6r1mvNwCAg9jXSfPUq9/87g6p0ZrGTmP3/d/CudbsAj9e+diHXfVfhriIGWITrh7sg9Q4+/oo/UlD7k1Sadn9PGkJWaYV3aPjGdHCDB6KUfoMCv6DltVUdZGCPV7sA42Ga20KzCyNW2atTt/84di2UucIV1HV/9gLEtZzRErbEoA4QaY23Kyyfv/FJhciDq65f/gXuNnpBFYnZZRYrBVh7ihHofWoWON+5eITxZX0HBtgh9kayDqcPWiJ+61l4xgeDDh06lNT6RN1607uDGRx8CialIe6QaNpnXc71KtIQoXf6LYL9mWAhC4iXPrcJwdBuN+NUb44NKR2xAOuChKMwosmBbJnAJAwJZmnaj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GnfAYYMsnFZ3PVjcHuRZZLeERZxY+hnMc7XF+xn6M0v0vsewIrQobHuj9xRF?=
 =?us-ascii?Q?0xWcf4tqAG4GUqWW0xlaHXMnuSSi/Z9h59sG6eEBpHSBYNM4hQnJHMtRZNSI?=
 =?us-ascii?Q?DdG2AUKbT0Ea94ivm1E3cwoPXL1LL5CRqdgxh4znAfIn9+2vsExxp8lkJGke?=
 =?us-ascii?Q?zGZFaOVTHVC2xAQV0ygZzamaesO7MIB+JtgPitYiO3m5iKMD8dcnPVfsTGZ0?=
 =?us-ascii?Q?FmEC+NXUUDjlmd5Kw+BRwEflGl1H2b+UL7XQujBEkhppzYIGfg7RCGGuWpk6?=
 =?us-ascii?Q?FYEsMeJrGybfagOO5AGDCwsO2RjESs4o+xTYgZ6MtaA9DkgIRiI490JCqhsy?=
 =?us-ascii?Q?h+i4BsrkBvWoa3EFNR3l/09dpRbmODkd/VHlWayN/H+rZ27qqXpEbc8vWtyE?=
 =?us-ascii?Q?tX3/jI9baUEoibqnlqnR5loAed8mGbbeBo0LXXkmKAiMdDrh6m4c3ArnKevZ?=
 =?us-ascii?Q?9Loye63Yc6yWU05/YRTlWHpx7RSGcJUHcUD8SVvhOdkv2+yRlywmQNAI2tFn?=
 =?us-ascii?Q?4Cjr/Ersm0OtkB0RSKOMa/N6eWSpzj3E4w1tpM7HshnJ/xVJJxazGolH8JRg?=
 =?us-ascii?Q?QiQOFYkXvElCVTmSIRHsBfpSVJiZO8zBk9zUCNg9rIXb3zd2sQehUeKHBthT?=
 =?us-ascii?Q?fr8bYG/ob2aCr4vaxQHiSsKjeVrL1eX4crkUVik4gfRitL1VDBPHquyk74ji?=
 =?us-ascii?Q?Ao6Btml4i5vI6/BcenUUPfeIlNryBLBBKBl1PfvTOX/xvI7rkrrvwiVqEz3Q?=
 =?us-ascii?Q?dWf7ykE8WCyIRJNwxw+9RASJTWbCxcSFlScAL6nSQpZ6KCWAP47tTKFYoVJj?=
 =?us-ascii?Q?bmp4xqrnHcGSszq9UGcWenWcBPaCNmCzc8wRTgMIjxnkgnQcjB8NsFc3nM3F?=
 =?us-ascii?Q?fYpNVY9kttzT9rqaawPOPh7ACnIx3qp55kS7PBLbk6cl4OiToTW6aGDucjru?=
 =?us-ascii?Q?g+pr3T+oQoEDAnduApu2ZovYHm0a9KUet6TjdswqUsBhThcENRr7A/suPXSX?=
 =?us-ascii?Q?vCc7+f9XCU5MmqjtZpDqX9CymLkB2DoyMXA800sQtZ3DQlZQSrRmibK1Jmjr?=
 =?us-ascii?Q?7lzWwBAgwpgkOA+AzD2i4T2+y0P+Mk9S3dtRn01DOmwTya1D9PAOUuvO/Guw?=
 =?us-ascii?Q?+nPcfom8CLw9AhRZZc2s+3gM3aHMc/Ikfyrt2DdSs3ntPsIjbIAbzrdEZBeN?=
 =?us-ascii?Q?hyLiDaquVEuGQA73u8UleCKYtFq2hHk7A9TVkG2e2g9+QQKxzspYBfw7yG8a?=
 =?us-ascii?Q?61ScpCEqEgQiaRfk41NfCtN/1+b/MPSdoi5tQBK+lPTHxjfc0SrPpIBwisUa?=
 =?us-ascii?Q?CIY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a93c28-34e9-4944-d447-08dc2e824ac1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 00:00:31.6487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR20MB3296

>From: Chen Wang <unicorn_wang@outlook.com>
>
>Add reset generator node to device tree for SG2042.
>

LGTM

Reviewed-by: Inochi Amaoto <inochiama@outlook.com>

>Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>---
> arch/riscv/boot/dts/sophgo/sg2042.dtsi | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>index ead1cc35d88b..eeb341e16bfd 100644
>--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>@@ -6,6 +6,8 @@
> /dts-v1/;
> #include <dt-bindings/interrupt-controller/irq.h>
>
>+#include <dt-bindings/reset/sophgo,sg2042-reset.h>
>+
> #include "sg2042-cpus.dtsi"
>
> / {
>@@ -327,6 +329,12 @@ intc: interrupt-controller@7090000000 {
> 			riscv,ndev = <224>;
> 		};
>
>+		rstgen: reset-controller@7030013000 {
>+			compatible = "sophgo,sg2042-reset";
>+			reg = <0x00000070 0x30013000 0x00000000 0x0000000c>;
>+			#reset-cells = <1>;
>+		};
>+
> 		uart0: serial@7040000000 {
> 			compatible = "snps,dw-apb-uart";
> 			reg = <0x00000070 0x40000000 0x00000000 0x00001000>;
>--
>2.25.1
>
>

