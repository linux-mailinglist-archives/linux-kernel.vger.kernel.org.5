Return-Path: <linux-kernel+bounces-97822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02926876FF6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F0EB21228
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EFB3771C;
	Sat,  9 Mar 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HDSPzR+M"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2018.outbound.protection.outlook.com [40.92.19.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E93374FE;
	Sat,  9 Mar 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709975026; cv=fail; b=PZI5Lrikm5HlpYFnRltXRlyb1iU3mCEvYoA7H2XYNeNTi+xWAXY7edOp6Q2+lGBExbyU/oyCsZTt+2Z2JzGHD4CYjWSBybWanSHlZerxC6vGFXXc3I7I3w2OOuCR1PHV+wR/XQCdx+id3G8/HIbGdHxqsJsWpEgJWAp0I0N2L3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709975026; c=relaxed/simple;
	bh=Bd6pWgCSDgoX3ropjECG0h0HMNQP9iQhPatJvBMgkTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sCrlhjQkU0PeNfoh66h9iLFCf+HgRkK8iQ3FHDU08MO4i+qntKVYJRIRlAmxIgB2+yG1jI4CrFSVrEskZUh7IXun1tAEnNUAl5kLu47XMpKOTYNcERVkMFago+j0TkSXM+HqJ7m1pj9bnm1eygtCZMk1ub/7mMZ01xd2vV5gBTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HDSPzR+M; arc=fail smtp.client-ip=40.92.19.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeKLcDFkthfS0V5jHd1q80g8XArLzSxjRoG1Dpn359nl4cWoabaafKK3/QJtsrNt7XmtyEjnEiWxyezaFl/HMGjczr5Wd+ZcexLQmEPMyt4uIkKpkrhUUepNi6HLxaLzntlBkNB5tZefeV4pBW6xUDEFPOEpo5jviZZsWUhw1Fl7HysrqN1V+K7kSk0Gm7dsyaMv3qPe/djfr7a1Q69iaqn1xzu1S1TzsBxf0e9tR3MMJb1j2M8//ok6FxlN+hcEM0zKTXV78MwgMkfcECrrxXAMGJCfH/4x5CWVvoEpm90HFyO1eEgO1Tn9es5Q+DinygPaVsfgtctFic5ERoFwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9EvGo1LRo6pSVQFZ1B7U9YPt6MoemRQvCkkbIrqy7A=;
 b=GTxL/cE2uEnmR1w+HY26Y6TfYwsJvbxYamTf4uiocpbkgMJdw5yR1kum/lEIzbJVPUlJP0gPrEe0aGyIw9yNsYae72IDoy5ATZ1dyAeuo2e9NPk2O1GqSdQ7plI9BBimAezvnlN/e1L6kGeus+5RTPzEj5tqc0yKMZIgaJxblYSdq3EYnPAxRGtpE+28CXjzmSerHr4dT86yZpZLmyN+OsFqJh1FoOrbD0MzrrfFn5U1iZXUyLzQFmBnf2WO7p/rOvZH0VY+aZBo01m8CAJx2jRiyKyuTm1c8kv3fUlCjHN9yd2yzrmP60kYtlq5MPhsqiuc+B8CUFaRZPwMqU7v0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9EvGo1LRo6pSVQFZ1B7U9YPt6MoemRQvCkkbIrqy7A=;
 b=HDSPzR+MZEcl72Zx9TpwhpPPsUdfZAtAgKfjMU3AFkGe5ekIc8oXzBx/0SmDCNHDzIRUsirkaDMZn1Rdl5fgFBHACP9HeqxiZJ6Z6WBs/esr4qVarMr8TTATiEUleEIuSw99Yp8ZzIsXhkqGx8T6luMhedhVZIMqbjaePpzkm/AOwP2zAfRXPaLzn7oC7y/i5vfaQduxg+gI9FYgBLNa0aBp/zQx7PWvoDjU/4J6NyNh/cOtQs2rvckS/RGs2mT0S2y5i5RYBljKIj3cHtbOq4u5wugYUx6hq+tfeaspgh2nkmH8Ud3XbrKerYk0Basr7gMbKMGJgUbXs71JgYGW/Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW5PR20MB4260.namprd20.prod.outlook.com (2603:10b6:303:191::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 09:03:41 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7362.030; Sat, 9 Mar 2024
 09:03:41 +0000
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
Subject: [PATCH v9 4/6] clk: sophgo: Add clock support for SG2000 SoC
Date: Sat,  9 Mar 2024 17:02:54 +0800
Message-ID:
 <IA1PR20MB49537156E71B64483F15C0F2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [jD7nV3iBN8HJTdw2704RmV7p4ZzxTve86rOQEnhnomc=]
X-ClientProxiedBy: TYCP301CA0062.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240309090257.927623-4-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW5PR20MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e048cf9-d042-46c0-210e-08dc4017d114
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XqI7ONogh72EGqcpSVhyHRLKyCBiGfmnOGX3X3JjAJBwMdKoDFB4mhaIMQzMBIxolEfjLADDH9vjx68YYxGmQ7XvJqMXJtB+KClnXUjox1VYH6ZRQPZILZ6sQLHnySvH7rge/fSQc3y4Rlg/M54fYegr1yRvgzZpQovkfjjs36trxxvbZp2/MhVrFa0+XlcKDCxC6LCLww3bdpEf7My8VHz9vWcTO3EZE5TKrZnugh7mced6TfzT5qvOq+tCyhM3ZQhqNiui+5cia2JyxQxCnu4rEisT8bjAyAEsh2Hl2Ci+m7ewJs0AlGvHVkJAJsFaKP8Oe4t5nBQncqdB3KUqUP4u8TxPumu7ljl/9FQjv4KrS0PNPPo/ho9cMRTol4Jt2bYsrO/ZQM1NFIr4461caQQoaD+AFXZhigcNMzNVae89vCEDNXIn8mdYoLGH21pi0B9hg51ArfRI3yUWQxycwVoPkcgZld3tYuAZI9j92BfN9yXd09PiyoG2YnLReMmsl5YwIkTv47SQaKpoxA3ylnoVfDbX1ITHEcCSemnkJpPpHMOKdOrHVg6PpYQ/YZ0BYODhtpOaDbzsSDPY3mwWL7HOZbRfVI5j2U3RLt1GdPaoAd1b4x+Mi7lICiishlAd38nxjtYUUmcWKHRqKdXErFXiJLf2m5zFSYZWo43OKtxqbeNBq/biH7CHy+iztKFM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fiRQc5qnU+7XNY14Np5WK/UyAWrTy2/WUu+y8zX5MdFwD1iGZ/V/it80WaNQ?=
 =?us-ascii?Q?H9uEbODYC260mXDmiVxQITrMxQJhRakQ3nAE1x3ZheUKMblFocTaJAUaZEXW?=
 =?us-ascii?Q?d63S3bc1L9yklI05pqAZiPysTxybIlash6wuXF8Z2x/8Nb6k/byYUvrq1XM4?=
 =?us-ascii?Q?OSQt+SvUTfpUyqgZbZIjUGiMg8XMYzocsQxImEDrO2+voaNQLkFMZwpEOvb6?=
 =?us-ascii?Q?LF3Mkvm1D5BJjHVW7uiW8Wv8BPTkpxmvNcxYfOOsg8pgtjuffqM8OnHOApSk?=
 =?us-ascii?Q?ezY3mv8SF07YswhVReA0Eg+mA8jG4CwPzEPVu5Bc7ZtiS1yTj1Uj4FQfeOXL?=
 =?us-ascii?Q?1M0ZpS3o7KQLY9gdYinlBJ2QLXXurh2Kl8Z80+b1yu4dM30JS0FG6UgrrbKo?=
 =?us-ascii?Q?FkKfgLmhmm1jZepyX8cAUtN0DF/HiF8gpguQ6c65s/3dE8zv2G2JSx1AMZv6?=
 =?us-ascii?Q?43N2Y90QjlEy5eguhV5z2s/nOTXI8vjYiNNUOzwCVL2bPPxfuHlgvMDab9IG?=
 =?us-ascii?Q?gpgFM6Vj2XvLIHVR+hXFcZLYr3EsprqY8FHPqLJnQ5gxvPHXLGY996/lgUNd?=
 =?us-ascii?Q?WsEIgbaV2etjMUR6eZS/FZ2DJUU92DsM6jCJZ6SDDG0Z3dQbCapG8RwqzCFc?=
 =?us-ascii?Q?WZE/ldIFSLZmNDh8nX3lMj9+OQqtIxum3GE7S14WigkOio8r/KmJtktQfC+q?=
 =?us-ascii?Q?o2vvjF5j7719lOWboI5jEYnULkxLnveq9ABfBavyPMdxH6VbttSdmPl/3ndO?=
 =?us-ascii?Q?RDhL6dO+BT2o66+9ZFw8hfdB/+DJhoM6Vdg0qDDbOEg+0SqwdrcOZiKY1RUz?=
 =?us-ascii?Q?nNSw7Cepmi3a3U1JScsOApaPBWjiMVjmSOZLrKKAq38QXZEjMl2Q9Gb7iFoS?=
 =?us-ascii?Q?WnWe5I7b3mFzrKS2yHO7SDtaFeRh+s+3uIDCchtiX2YvZKxHKYI5G0gdU1y9?=
 =?us-ascii?Q?+NGG+ulve8x0DOU3CoikL13BgH4EvTAFkuovZFAVTosc1y87P+02c05q3mGs?=
 =?us-ascii?Q?CFmZR3dK5SLpRXsfkDGpLnccQpAor9tLaieDZjBtlkC9UoKxZqm0XRB1uNVp?=
 =?us-ascii?Q?g6KzB6hmydIz6qp19CcfEfxI+7DLmQGxaCtMqFvwJ2uqeSUYKcphqcVvA7vI?=
 =?us-ascii?Q?NHvmRhz6a3XfWahPx/wdueeEaFhTCK0cgxMSZs/VHtkgW6FLtUiKN5vWJaxu?=
 =?us-ascii?Q?10bhE+vPpIVfqCoGT1D97D046j7oc/ANDK0QR6JXbrY7u0BBYivBJvSuqKlq?=
 =?us-ascii?Q?owfR6VYrbXve52SUnodG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e048cf9-d042-46c0-210e-08dc4017d114
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 09:03:41.7453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR20MB4260

Add init code for SG2000 SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://github.com/sophgo/sophgo-doc/releases/tag/sg2000-datasheet-v1.0-alpha
---
 drivers/clk/sophgo/clk-cv1800.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/sophgo/clk-cv1800.c b/drivers/clk/sophgo/clk-cv1800.c
index c7d4aa6c8343..956de5b21a80 100644
--- a/drivers/clk/sophgo/clk-cv1800.c
+++ b/drivers/clk/sophgo/clk-cv1800.c
@@ -1437,6 +1437,20 @@ static const struct cv1800_clk_desc cv1810_desc = {
 	.pre_init	= cv1810_pre_init,
 };

+static int sg2000_pre_init(struct device *dev, void __iomem *base,
+			   struct cv1800_clk_ctrl *ctrl,
+			   const struct cv1800_clk_desc *desc)
+{
+	cv18xx_clk_disable_auto_pd(base);
+
+	return 0;
+}
+
+static const struct cv1800_clk_desc sg2000_desc = {
+	.clks_data	= &cv1810_hw_clks,
+	.pre_init	= sg2000_pre_init,
+};
+
 static int cv1800_clk_init_ctrl(struct device *dev, void __iomem *reg,
 				struct cv1800_clk_ctrl *ctrl,
 				const struct cv1800_clk_desc *desc)
@@ -1506,6 +1520,7 @@ static int cv1800_clk_probe(struct platform_device *pdev)
 static const struct of_device_id cv1800_clk_ids[] = {
 	{ .compatible = "sophgo,cv1800-clk", .data = &cv1800_desc },
 	{ .compatible = "sophgo,cv1810-clk", .data = &cv1810_desc },
+	{ .compatible = "sophgo,sg2000-clk", .data = &sg2000_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, cv1800_clk_ids);
--
2.44.0


