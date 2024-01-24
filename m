Return-Path: <linux-kernel+bounces-36645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC2E83A452
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F1EB26670
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B817996;
	Wed, 24 Jan 2024 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BRqTkhHo"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7E817BA1;
	Wed, 24 Jan 2024 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085597; cv=fail; b=fw56lzQsXKNPQQQuaf9AxLNPZuEXvRZHfpnWd4LOvPQl+lunVakrtc/VJ6U5fs9fUZ8Sn5MQm0hVrQcgEXjC/s5nV+9FY+/JsQy0t6lMB3G9Mk89dSq8zYe+U5frsDyvy5gxnXVuv9Ohjdm6oy7K639GMqKrYw7BgvvaaJeVyWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085597; c=relaxed/simple;
	bh=ir/ka7ufzwISVyYGS8BXiCBiS+UjuZY0MzJuhI5bhAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUUdUqlpxasKH3YyDlfwf3yVR1WqyWTgfubDDqUP8Gg1ozJfFdBSYUnsQAUCIQQsYEoWZdn6FPUXbsAnET15DES+m6ckw82eUIpmiuOfZRBNc2rST/C77TvW5U8cR6g+dWHWuSP5ja7ISB0ouRs+BNUEqxnk1o+0WDIsOfUSk8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BRqTkhHo; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFWeZEF5fKRgphULrghJyGph8HvvGFYheeqOZKxZ8hm8iATN4fBmiML5q4EEpMv2HEauFy+h0hlZxnRj8OqUzoOSA63FSwvDTUwqC+5ou09U1XpfeEBDl+O0SFzySJJB5mOMwcYfTDI7orp+EwdqiAxYRmnGXzV9p98CetoM2UDyEgqSA4Kh1pjvUv8W8GSatlX69VJ9ilqNrExatX3vsuKQg4j/ghWi9dnEpL6nEbR5XEYbF+KbJEUG1zQH83/hXYRz7s4PbItPUHzA93NESnsPUwlox/xL6C8KtYdJ9z2KnZQd8rlSjxOCy/h8/LTSrNBI9OtX/xSEFurdBaYvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A96YmSEaULokCB7+8Jx9VadjPtHpWrWMquVvxIxD/84=;
 b=oIBgYvL/ybFqBLjKvzJ+pKqYwuazS4fIIQkDYaTHN0WwbukkDZ9gHSJFBF0+CnkHtqmpvWRi5Sw5EFQmDiwmXmCGkMkIgJmkMBhCto82w4CYvIWqn1rH8hWXMjBwa3O9UEj9m1AJFV97Yw8hZwMFQetbeF7s+KKyEH95F8njidV7LQsKfSzktHAZH5ZYVWYljnLv5tiGUPvEkTokwBhfzw+0Dylfz+YIbqcjD72SKvXyemWuuDg/ch/tPIsYWRl0MA4VTN7/dFVE/cWn6ct5k5pLKfxJokP12NQuJKZiowR8W0L4oM5hUE+3RHPkHHWa3TDncOpX5tPyefu6X3a1Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A96YmSEaULokCB7+8Jx9VadjPtHpWrWMquVvxIxD/84=;
 b=BRqTkhHoUUVXMocLII789Jn40sPctqcSUdRvhiy2CIcB5ShSViTee151GDRB+RlP5BY0PSvZLwOcdaVXC/3M6k8xEjS2MD1yuwN40lqA1SkCVamxBHsIAaJXcbQqmAr8NEi4tQ9SHmjidZA+JlRcw9EqIpZAWgqG4bANUxMVDeiwh95WWG37UOYa+wM6ODR+kKNiLB9qoYj6wot5vhW2VYSBc4Ki26QGoG3PbXJ+UqBfjfaIOKWWBbEka9+eNTKlBIE91Fd3tnkhPJ+YeuMifU943Zz+Btxz4MWXqnp2E5xpISHjDJ9k/cTgQcN9ySns+qwhztV8B+XNYSWgz1O7wA==
Received: from SN4PR0501CA0007.namprd05.prod.outlook.com
 (2603:10b6:803:40::20) by CY8PR12MB8411.namprd12.prod.outlook.com
 (2603:10b6:930:6e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 08:39:53 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:803:40:cafe::6e) by SN4PR0501CA0007.outlook.office365.com
 (2603:10b6:803:40::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.19 via Frontend
 Transport; Wed, 24 Jan 2024 08:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 08:39:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 00:39:43 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 00:39:43 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 24 Jan 2024 00:39:39 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v4 2/5] gpu: host1x: Add Tegra SE to SID table
Date: Wed, 24 Jan 2024 14:08:43 +0530
Message-ID: <20240124083846.46487-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124083846.46487-1-akhilrajeev@nvidia.com>
References: <20240124083846.46487-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a77b90-5746-4dfe-3c85-08dc1cb8090d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wLLjDiALwuhl1aLH3T1N3AltRPK6owPj/fvCv69Cu52inxgNYQN7LG/N3Wesbs6Shd527rLecX5yzCXnEm2HdcsHm9oyeEXk0e0hijvypp4eo5WOSdHULmrOwWNijckHoboRoFGEAsCQTKm9B+YWbQ1rHLy/0KrE+43PEFHPuiTgJl6m2RY11FQ96a0BWeCJLkQ91wNn/59O5Z6ClBRw6VwxqMrJmyo4dXF/eAYWE5bUK4Oj7IQEr5xq1nVGiQwa7y1FODkmKJPMRyNgaV2V+njVChuM+MEoE5OzeIHkftqX/+0JwgxQtR7mzoi8uj3GYMYUQ7Bta+qtUO0yPbHzk7mZdQzHHxg7b0RkpHOjiKyea3l1CvLFkR0wNoxCD+etEbi69surLvGs0R2k+XCasqc7kaVlHtG04D6vDCmhG0FNh7XsnIW7GbCQPR3gPnO/w5OUnEV4w9BYj35fiY7GtiJrbT2Jkl0OsRHxrjkbKs5N9lccKdDUGLyONPXDTRoeP9tCAtspJyTLpz/HVvNaJSRg6RcRrpvrvbFZBTuWBicJlkzFJZ/udBulMK2GsUHLovKtH1lnfOfIlj+MBcpZXVOMe0gPBNZGGlWd4uFqlQXF8hAc7H3CpyiGJp+VFpYhaf7SmmwXbIo1c5uOuJ+d357hab/dXaCZDYl4mJX3GLhxfimWksOl0xv/Gr53VS4TgWSlwqxE/hlSMjyYu0pLG6jFSF7BWCtsiNJOh574w72eYCOuif0ccW2U5uPwd+85xicC/i6aOOtQ/oU551Zh9y8h8mnGYGk7djCgxYTAR5fEE/vnIaRiW71irzqOW49W
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(83380400001)(426003)(921011)(86362001)(36756003)(356005)(6666004)(82740400003)(4326008)(2616005)(7636003)(110136005)(36860700001)(107886003)(1076003)(26005)(47076005)(336012)(41300700001)(7416002)(70206006)(7696005)(478600001)(70586007)(316002)(2906002)(5660300002)(8936002)(8676002)(32563001)(357404004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 08:39:52.9627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a77b90-5746-4dfe-3c85-08dc1cb8090d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411

Add Tegra Security Engine details to the SID table in host1x driver.
These entries are required to be in place to configure the stream ID
for SE. Register writes to stream ID registers fail otherwise.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/dev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 42fd504abbcd..b564c7042235 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -214,6 +214,30 @@ static const struct host1x_info host1x07_info = {
  * and firmware stream ID in the MMIO path table.
  */
 static const struct host1x_sid_entry tegra234_sid_table[] = {
+	{
+		/* SE2 MMIO */
+		.base = 0x1658,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE4 MMIO */
+		.base = 0x1660,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE2 channel */
+		.base = 0x1738,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE4 channel */
+		.base = 0x1740,
+		.offset = 0x90,
+		.limit = 0x90
+	},
 	{
 		/* VIC channel */
 		.base = 0x17b8,
-- 
2.17.1


