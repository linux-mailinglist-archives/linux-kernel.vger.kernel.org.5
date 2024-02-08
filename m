Return-Path: <linux-kernel+bounces-57667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF684DBFE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CF028887F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7353E6F087;
	Thu,  8 Feb 2024 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="seNqDlL2"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2062.outbound.protection.outlook.com [40.92.44.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2F6F51D;
	Thu,  8 Feb 2024 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382169; cv=fail; b=DsX+THhwWwLSTidtuWJGyHdSd79LaIZdl3fdxq5esbTbZyHwNkT8PKM6+OrnC2ihei79pnLBYe4sbFhkZSsSKXcuuc8+p8cEpKg+Kh2CqRm4rqyp2uaicKDT8oVIav5kvmtUl8FM7OQ7aSYqMXFkUCeay22uY+Cep0YKO4R3Q9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382169; c=relaxed/simple;
	bh=xrbXVN1QUqX8r2Hexkx8Tgtbq+geLdAT7EFikTxSXhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fYkHKpj35hdiupkBS+2KDqDMkH0wtrNf/7ugHHrvGRLCJplWUiKPnap3v4xEfqFht0zn65NiXaWT75FtE/31ctlmmbexFDwxZr3y/Jo3n/K5aV4Ovfd/jZOithLgCidezcWfaP3qKIWmIbSqXN1jR9n+7O7H9Vk+aVnVNRwiZRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=seNqDlL2; arc=fail smtp.client-ip=40.92.44.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbKo2hsTWr5hTCmfKHjLdWmqFYpVfXJnfNo70CgSslagR4zZqoPzqOZfH0VAHO+R5zFTKbZHj3IfOqqmvPstAK/miB3NfIdO6QxF1/qa/1tv7bvox5DUXMD2T06LyCqVtayaCxGzruQJDywe0V+eRLhQ/5cDAeO1J8qfrUFzt+49PEi4PUMgWSZATeFiezDfzcNzmI6NO3Cyjt0Nq2UZ7aSyPODF2Kk9unWsWZDfPEG6G4qB0kylnzf7el3CriUKi8OuHCHje81ZtrS3GPILR+UQPBXzXRVMzyLxlK/t7hCjSdmognzSbLi0/pxS8+EkCjq6CIKbU8mI+CaOrz3HTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FacdSvpDTgJbywybMZZ1StTXTxM7PAvHaUuPFXyjpw=;
 b=awhVybUzjgLgcpId/Q8ElJUOSOlAnF4Bybd3VjGQb94auPRa0j0rZyQNM1/nZnoAGcVB6Ecqcnzqm8X7BtFF2t0/RzWZGkfWbNdEuWMO6ydhY4cbv8vLzUCwNXad7Bxf+vlck5hZXHVCkuJfBY1Jvz01PGCYFggYJwaz6Ia7IzrZmgWCIm20xMsb3TEL5A5RDMy1GD7ECyvzpTBLR2oW4ZjWE1wgYhqlZlqw3y5n6gxOu45fywFbrPREGXIde2itTzStQY+2OUsdfHeY9Jbr1OGCmcnZATccZay3hYLkxuZXs1pAWekeSH7pt4RJaIz1vZelqJnA5HiT5/YdBY/Z6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FacdSvpDTgJbywybMZZ1StTXTxM7PAvHaUuPFXyjpw=;
 b=seNqDlL2sWLwUhfSEcI5DgK7r42hT8LvtZCpcstSa8g0OUtTAbhU5Yxj2ivYFudwCwNbCy8EsGubQk7j9hiN79J/G7QJIthPBX4Z5VqhPUKe1VL3OmHDxjJvVPAn9xW2snjRVKyMBmIEVxANcMaon/GRB55zYV1nC0iXrYLhCaOzGtxv0hvEfKrc0KedpZlXgr21IHY+N8LGQZfopi0Qzj9F7p6YtidzKFvplAUeT6lPdti3381ZFJ0Ulz6nGtj/SjW/uJ2smateYiFAZJYqDFPExRYdkqlLP06LIsHmSCuT1gfI3QjUWVRq+0JiL0KXVAOaAUBW4q8BaU1aAWxyaQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY8PR20MB5985.namprd20.prod.outlook.com (2603:10b6:930:73::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 08:49:26 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 08:49:25 +0000
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
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v7 6/8] clk: sophgo: Add clock support for SG2000 SoC
Date: Thu,  8 Feb 2024 16:48:54 +0800
Message-ID:
 <IA1PR20MB49531E8123430F865C5351F5BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB49533B0C8B05FF5679E0C2F4BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49533B0C8B05FF5679E0C2F4BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [zDvzIWwbhO57qGzbAx9ov7J+Vl8HaXGXwWbMaWKwjvoHRk2YxAGdoLw98SaInEFT]
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240208084858.1113628-6-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY8PR20MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: e7dbdbc8-3cfb-45c3-96ed-08dc2882da7c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qDB/aRnD3XEagwIvSainUX0WMYZqLmeQgKqIZ2GuRZZgDxQ7SDk7y01TGefs+XglhiXwQBaE7CBSA9IJyyJgmDZNlQWb4P6MWEURWmJnpJx9pryCZAewoQggFOWAHuYRFaFrP/zaFJ7cJfuOldYx8wm0yumCPyrtqknmqWBhYWE5Nf305gEkU2cUpAfTrl0DX8m8b/ZTTYKUfFd8eD/+jTq6tLD+Jf+uiNZJw6sgelJLupuA7oFiv30IT8s0mqe9mdqbYwjhdN8OgxkKQuvUb8C3HMHcJ+TDdnPhB+DDcM0ucP8kHDkLPiDfiVUvm0qpDv7LksZSMG93BJ90vvfS/GmXcTGcVhoW82oiRzVz9FbNNaVXPYwckTCLSlB11FSyYUBALgHLZRVFt//jCCJZX7Znpq1rnrPZQqsRaHAOea3J+9Nj+GoMPimqpJnwrPmQMDZ595hIx6PdY8YPCES0SUKgayXc18ZNRa9DUScoPyLdHIQuBeAw2/cij5De1IKU3bNdOzlHerAcB/CeGctk25GDit0QI/7omowaEDLormmk6fYkG741M9eBp2/9MRXYso061OgttimciiYwM4HDCvu3X2gnkiJdWB2jxbrzc1qNW513U8XCR9Zui7VgKNEI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HMKsiZXled4a5ZCFd6vNN0d0LIQ8v+Kof+cA314jiwp3E816+S5J6eXQn7S0?=
 =?us-ascii?Q?puiBhi8DQwZo1YtER06l/vHoovEzWzaFHaZdXV0KP5VbHtBCfkUP7eGiketv?=
 =?us-ascii?Q?wyJGjLoS342+wdBN4aIW1MbO4IPLTVQazlzk+EddLOxnntJBTL0eKxu6UfcY?=
 =?us-ascii?Q?CmyGyOjcq7FeFlhDDNIAcOsrYdQbBG8REn77X7SDE+5LhSH0jLfeWDZwRYRL?=
 =?us-ascii?Q?QowZCNoSiZ5ltjo6+uqS8kiToz1DBlfVVZuUxqlAhwrURu5OqfzQG9/1fV6p?=
 =?us-ascii?Q?7a01w3Lw3UhvjmGZLTLM0N66PEyx/oU5pcAba3/2JwAqVJeH9zcRE/ljdQXT?=
 =?us-ascii?Q?YUfrWRSkozaOilRiBx0DSBEN3TW+0sgKBb+M8U8oblgiWwBXLu2w31zQ1aPn?=
 =?us-ascii?Q?flcglGw3uI2kCkdjXQPPsodc7G7hmVP/3Kh7Fyke7PS9MpKAnVDnzWD6kcFR?=
 =?us-ascii?Q?iUjuiK0Jz1/uYbc1fQpaiLnZYl7YkHsIqJEhiPZiPpKIML0Lwouk4zlzgoyJ?=
 =?us-ascii?Q?O8LjwHf7t5UMBBgyY/UG7nYLrDNdeE16crKS6EgGkmRFe076XyIDTOQKKmN4?=
 =?us-ascii?Q?ifTYudODQqou0+4Ijt2tIZhCXLVi32lBcXDH2ixu2Nyslo9OIPbOjFHOzEMv?=
 =?us-ascii?Q?VWfCicFVultF/Ez5Av1gz1Xi8J4xONoHqJHC4sqSwZ75oEnqavV3lnZAZCYK?=
 =?us-ascii?Q?ZnJ12h1z70/yPF2IJkpXmo3OheD+6xB0PEpKapx9cWLhlgiJJyXH59Lj4gTU?=
 =?us-ascii?Q?dIyeZkn851g92uWg8uTGTkF55cmyXV1JgQ6FhDxeodfjajCIeHdHOqjsJpp5?=
 =?us-ascii?Q?puWH1qlZkpcsPpKghvs3sEiAja+eqir6iRz5hiy3YuIYUtXT7LhXhVhIV6Np?=
 =?us-ascii?Q?fjlKJVtMC9noPhr7870BKA11be877G6hS5qmUaSpnz7kxiDz2FWC6OhulSZp?=
 =?us-ascii?Q?2L1Megn4U8V3FrkT+F9yS5glt8MNUcPQzQQqtfiv9bFbwL988s44umQUP/gI?=
 =?us-ascii?Q?Ayp12rL3i83Yan+fB94OzL1W4Tq4QH4iDGKGb8uhUroC44Az9+t26bFsXWgp?=
 =?us-ascii?Q?tnydHX5J8972FxqRGSHtjrZJQzBr18S22H03FfX+tDPclfTN5IsQnZ+p3q4F?=
 =?us-ascii?Q?kZd4Kdc8puo4pWhCbtd33c1tzUO5olOfTdFB8vQmZW/1otCYCzYg6jT/y7kQ?=
 =?us-ascii?Q?o7sy0KcYAoy03lN8OSSil/9k+ELBrhpV3yFTnvz/19ji7h7KW+eqV1DZ3EYx?=
 =?us-ascii?Q?uui0j0znzcqt3xUIV25c+4WwvFN03HQqratBSk9ajA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7dbdbc8-3cfb-45c3-96ed-08dc2882da7c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 08:49:25.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5985

Add and init code for SG2000 SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://github.com/sophgo/sophgo-doc/releases/tag/sg2000-datasheet-v1.0-alpha
---
 drivers/clk/sophgo/clk-cv1800.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/sophgo/clk-cv1800.c b/drivers/clk/sophgo/clk-cv1800.c
index 6ee8ef56570c..1aedf2df242c 100644
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
@@ -1510,6 +1524,7 @@ static int cv1800_clk_probe(struct platform_device *pdev)
 static const struct of_device_id cv1800_clk_ids[] = {
 	{ .compatible = "sophgo,cv1800-clk", .data = &cv1800_desc },
 	{ .compatible = "sophgo,cv1810-clk", .data = &cv1810_desc },
+	{ .compatible = "sophgo,sg2000-clk", .data = &sg2000_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, cv1800_clk_ids);
--
2.43.0


