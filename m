Return-Path: <linux-kernel+bounces-64672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F3985414D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4C71F244DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511618045;
	Wed, 14 Feb 2024 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XxjXe84l"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2056.outbound.protection.outlook.com [40.92.19.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FEB17BA9;
	Wed, 14 Feb 2024 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707874566; cv=fail; b=PIemP+CzEBPqixuO/iuZE46X6qXrFC6ePFrocitO37eMcGRn4+IPrxFUwZOGvTbXCjYLlmC63xBl0WnDzOzpLFfp0Jk5DTtF4nwIFTeUHkiXwkkOzzxDNQzRetpl74ef1OutZD4Mb+Tr9nL9Pk5fybvIe83kM3JeM9qc9Y45NXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707874566; c=relaxed/simple;
	bh=t0J7sMT1OVYy6PXTcnIUJkS+vW8wUSf7Ig57jmDKZgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dxYRI38BT5WAgSBtxQmN9bEg5OWzs+IiyYBCLDDbX3Q29/ckXO4ow32kUXIPUnrgn8pi6FVRG4Q9YC+em1JA02LVT5i/t+o0PwDsmUf6JTOUaox3BJTkEBWcJb5ATNLuh+XEoXvUBREp37af7U/0Ss+KyIl45pYB0VmwSNgaGGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XxjXe84l; arc=fail smtp.client-ip=40.92.19.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eT+4BreJ4OL1iwBppeDp8eEM1+jI0o455De0Z0zgFmE9bLf6i2T4khOllchsKs0RoB1/bi/zeg0+SInWQvLgKOIjB0KY8xBycHTB5RpX84jFWinrg1PvpYa47NFNsu/idVhJ3gHb1CM+GHu8DEymL2HKQzXMxS+ZwJD78pjfrWVkxYBtCtFf1lRrncyeiIDUBFPES7Na/OMSziPLanenXaP6lSp3PV6Mxe5x77xd4S44Y4lBJPlDFg1pyhZcW4kDxReDjKBhFJRVhRUiEqqeuKbachbi+2cn/bwx+Wr5sqKuvDwIJlGBfma+zZbosHNYfIUdiIaS7J6vFXbf6+FK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAILyGaP6oUcjwZUbrwWrX1/9+aVCc+T6mKhlGiIX/g=;
 b=aedH+FeBHpq2l/7AFf8AEd0D2HInaH2DUW0j7bI+u6cQi5ZKyBAtrcuGgXge8SrlTIM3RxgKUZvCg/zBLIzGd2I9GVKlzwpfS+8zUixpOlwJX0Oyea6MDOOyXeCa9kUsVU+JEyt7ScdYwA2/3Ek5pm1stipavCnwSBTv0xC0I2rMzCmvywAz/A+6l+Js4kd0ZEH+hW+guG/hnO4o96d5NZ53lS1EUoDJwNcy+sgLOJQFN3L3TcPBKmMWkSBN5NFmaPZsNmgxQkEGAunWqjUY2/yiXuzjWmWM7LN9Pd1DAOOtdlakhzPX1KM46Kw6LQfhwLjFr176QaXufchaif2MPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAILyGaP6oUcjwZUbrwWrX1/9+aVCc+T6mKhlGiIX/g=;
 b=XxjXe84lXR3+koh/WqEja9BnQ33lnwZFDvwx5kuiARMssV/W4Fquo+JvJx8MELLcW+o4KKYHZ7ATxryLBEAYqnYpWqgM6Hp/KYl5mhJqt6k4dXtWujIFd/uNwRh2VpK7d7AqnsuQbGpH7vFRofhe22kGbXwQCCFxtzMxgU7bHFNcNE/c1GsPGsMAMwJ/TltMXyYSW4NKFaDV28aogO83JXW5GocUjEhQ8YYW6SmuhiiARhUrXVMvgMi8ijIzaLaFBS0KJT/+PsK0A9+Cn97sFaXkx3hitPrkSiO/as80l53o6d5qG1v1YRXKcNEborQ2tOYkwp5SzyK5fUgzncEf+Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB4663.namprd20.prod.outlook.com (2603:10b6:510:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 01:36:01 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 01:36:01 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh+dt@kernel.org>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 2/2] riscv: dts: sophgo: cv18xx: add top misc system controller
Date: Wed, 14 Feb 2024 09:35:55 +0800
Message-ID:
 <IA1PR20MB49533397F35C450DB92B00C7BB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <IA1PR20MB4953D95E8657A480813767FCBB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953D95E8657A480813767FCBB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [+5+ulkz148G+a/ym2uORhzAn3xzvlkUbjsP2i4GmtfoVwRA2UizreuHHidT+9OgH]
X-ClientProxiedBy: TYCP286CA0228.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::7) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240214013601.135526-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB4663:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cb2cf1-dab9-4642-8e93-08dc2cfd4d5a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s4s4i9osvK4YL3Arvct4EKMqbakEYJ9N4pTiUfAq01ho+rFM/C6nQ2zUAHn6WWUv4tnql1hrLAMKmShOVyLEYVcAx9Vm7qR49m9LUqYSUxWXHDtvLMkAd5qh3LJc9t1RL+c9TCCaXMyGPECqWbzf0E5dYhewipgr1ISR+lRRYAOnjX0mWTcQzDEA2UVZW/iNm12LlvcQoM88b6GRmzMF7gFFGrjarw5tvN930xoIDeyBL5UUOlIv8M3Dnkcu3yJcnPN+aRRs/j4rwbAwj7lodvDOxzTXXMz5f1Xt72+woZa+QA/MA80Pm20Vit52u0D+1ZUFs+PYXt+RWOojXc5C2baNrgMN0wE9kwaWNTkDKPzcFGlkp5yYpwKlDFX1z0rrsT2+mibLyMOlOakUEUvGLBf36dkyk7xcNBlZdn2xMZBY88yV+N8r32T5HtVm91MQQIuWP8AGMCX+MnPrlrhoQeUN4NN7LIh6cGyek/6MOqENsOn62oDnFYCcEHV0J+uHVOOVK83Mc/tEWeDas4h0WPnVkoTyxjo+JJxkAMqJr+hrGF/vEH38OHyEm8Wrb7TXCYaZme4Csgy70NLSHoTZq7DFyQpjjlo4U/BXCgwfOlw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CRNWYF3MCQuybxC0rkFbJ5svYMdDsLOSgWhXesDWD/RaKqonsfPgc2FmO2ls?=
 =?us-ascii?Q?Tcxp4ricdtmxxzSGJnXHZWHuhHAt3s2aeCyhLWMeLsJjmi67IL9XYusJA92l?=
 =?us-ascii?Q?dL4RWPtm+//UHZwZiY4UgHjQjMexzy9NSdsZfZKZvXKZtMB9v72KUWR8Iwse?=
 =?us-ascii?Q?4Ozy51IMhyTXbg4flg6PptUJ+i2auBKIY2HAMQ+c05vnpDuIZM0+/mzZFLgv?=
 =?us-ascii?Q?SpDylTV6PMx2TJ02C7wcFBAXH0VYCRqod0ELvjemcAdIHK48ceUFtyGjxw/i?=
 =?us-ascii?Q?X8bYa5zbl72N058COY3Dq49TngRO66qkuNJskru/KuibYjcOG1a422FZJuV1?=
 =?us-ascii?Q?7uv2d4go+/HIm0BkcfnUeZsilasZIfLjLBd/ymJAFaSujpgK4GcKWFKu+mOQ?=
 =?us-ascii?Q?YMU3KH2fGX3E9+nuCjYWJ0gHgtfTj1X7urKGpN4nUYpPGAJQy3ymbJ10dxOl?=
 =?us-ascii?Q?f6GwW7hmVd3COZwEsfLNhO0wUrenPE5nPKgAbondRmon7u20L4XF+sSJ49s/?=
 =?us-ascii?Q?xkMD2m1qTWnyCrynrlj6LMfjfD2tvf0zxE7bHPCpgYdV9c0vBodQcu+QDFkW?=
 =?us-ascii?Q?ne+wYSXGoOMfJyCkLa7u49G5tuyqZ50XvGfkLxyJIijRjlbkQ9IQ1f4oIhMU?=
 =?us-ascii?Q?5CciK5eyVYrpf2txF8n/PT6BvCpcehZqCaRI2Jhhq4E5kQ1RQcjPUORpI3uH?=
 =?us-ascii?Q?mTWXvP/TtYaEOEhdx/U1ArgNdyz6LGDfovR5/fBFZWXJxgPSCM5BmevHjl56?=
 =?us-ascii?Q?1hLo8j6s19bxckYeEXjpv1lS53Gj0YdvQ+sSRfS5idgtOOKa8tbSZcMhaoJQ?=
 =?us-ascii?Q?h9hlYDpw5j6lV0N4o0HxQ7By0zqiWrDDKeYLU0Bn7sDuTxNp9f0Ku7HmeGhi?=
 =?us-ascii?Q?90Aplz38iGq63IBm4uaDAjr5ZgyO21HSlOOMWUjlXIVM6NzHADXHUNdrYSsb?=
 =?us-ascii?Q?RtO8BxXCYdbywGDmDP9eAb/Ff6rgDvmupEgk+GklRdU+L26kRn0CBE+X5FTN?=
 =?us-ascii?Q?xBtxEbfucZFqfV9nJghNmrueNzrIsPVdQRrOQQSKRc9Utw9ACSyYdauGk1nG?=
 =?us-ascii?Q?7x4WdJaSPoDAiTDc/mrpNCTCJYcZXwyau/14/HNewe1Z9YcQ1E5nA+9tEJBh?=
 =?us-ascii?Q?HldDcp3pRLJyuCmcB+i7/v5ffXsJ6d9Sv4dKYfq9AlgQAAQI/1piKAjrughl?=
 =?us-ascii?Q?/McuxYfygVU9VNV4vYKqjU0WAUBVHceTuXpkZtOwdpA4R6pRvIv79VUZILrl?=
 =?us-ascii?Q?XzRkQt1dkYPKIq4sfZWpEldt3NdryUPDTyuOG9MznvLQ+LtcFg2yyzIiHFHv?=
 =?us-ascii?Q?u0M=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cb2cf1-dab9-4642-8e93-08dc2cfd4d5a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 01:36:01.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB4663

Add top misc system controller dt node for CV18XX/SG200x.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 2d6f4a4b1e58..dbf018e99c48 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -53,6 +53,14 @@ soc {
 		dma-noncoherent;
 		ranges;

+		topctrl: syscon@3000000 {
+			compatible = "sophgo,cv1800-top-syscon",
+				     "syscon", "simple-mfd";
+			reg = <0x03000000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		gpio0: gpio@3020000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3020000 0x1000>;
--
2.43.1


