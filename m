Return-Path: <linux-kernel+bounces-71758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACCD85AA02
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E772893CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71AA482F0;
	Mon, 19 Feb 2024 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UPQS1Iyv"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F7E47F78;
	Mon, 19 Feb 2024 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363644; cv=fail; b=nPsXQvEgIw8hXg4/dubcnX9nJ9J4/j7HOGiIoGPpk+5OX3RntZMKLPaxOQiHjE1OwxWuWadhOc/O0IcHXUfiWaa5rwYYDgYbNHeUb1tIa7pwl6ebsFtE5mDI5xIJJUZOXyVWN+v0W5XDebUMwX9OBRwbrh0YpcsQ1K2IjIHbgTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363644; c=relaxed/simple;
	bh=6UIacj9C9cgqwY4NiD8mp0zYDHxnRYr52EBVBRwS+Sc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0sOKz3FhJhcD8Uimks0RyBIN8dEDXlAwrO4Rk/WGpc9kWpCcj/cK+cBOeQMAjFWbZUkmKX4aNNkuPNAk2n8YFWzpjUeumKSm16LvLrKbJ1VRXbO+Zw4JoVEtatF2IS3u9rcGHhQeH38NGiT1fvq8mQYOr8MomYQFRyaKNkQ0SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UPQS1Iyv; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fr6SRd2OzZT8FNuN0N/D3elKThuuALPN/c4d2qY/aqZ1uoGvoRkkSbdJOc3SCdqspGSE5Yto5Y6ZG+8g05PEQRp+WB2Umk0ENDi4MCLRXwFL8A0ZtvKFCRQmWX/eALdAGV4d3rLkuspuceyk8bw3ulZOKeV/IReERfWX6c0d+bJDq8sNNjUwLptSR4fM1lRmP35TUrWTSO+883R+GEi/5YGMhyspByb8tCVvP52m/1/Rlgq8wnQV2k1jXl0/4JjUhZzo44NAHlfHbBtYDTHiRs8u48GK6EQbxLQyHNNbKyDkVuJF4uDa704huFE8NQPkvRqwn//vWY617PsLurg2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jF5sQPd+n+X9yn2ja9bf/8LkID9TWtRFgzUTIzBUhb0=;
 b=a4oNE9gOG3KPiXQNBV16dK+SkZeWPImxXrS+If9yj/hFSLG17QTWEb99IWBQrS+fg7jkc+3IL8hDKH0GCMtnddO6SO6YpjDcPUG6QMIX6WheQpqJx0ZfXtstbXXu2/hacjmDK32DZtG3FhWAu8ch7AK9mWMMAOWY5JY4vs54aZcoBapUQ/7ornVDze4Chxdu2Hce/NKZcK5+2rsoYfjRteyzcoRz/IuR+0WxUpJ/GPHQQFs1F+tSLTUIMlCkmMKjNijEZXLJL5MI2Efl2SepeTGwVaqhfp3ZXArWWA1hzvHunHh+5W025c+jE2NYjRJQKSQyVQd3TVHqHHAHXkTCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF5sQPd+n+X9yn2ja9bf/8LkID9TWtRFgzUTIzBUhb0=;
 b=UPQS1IyvShKvWhvQ+QxazhEbuTgPsQ8cThA0uO6mxq0G5f4KSfKLca64XTMOlVYb4j3ZSYFmsXZasCBd/xiOH5PJgnn7vZ+oc4dJnXI0iySEC2AYe8IJrcQZ4fwzoouXnMHbrgN9RK+eXJFIJ+MisSK176nJ7xgsuHBMQxKVh+/E9tpcSTg1UzbS//9BS+H5OYxIDtRr8dRX5KHVrkk/egDpjCc4N0x5FTube9Xk3o3BZWEm9B+370t1L+QnLeCVEWuk9ViKSNywS0QWARyNnDM0DX2JVB3dM0yhJFEwgMWLR4JymJdJLQ5lYO43OCA3lb00gSidHS4AjWjk50KvEg==
Received: from BYAPR11CA0070.namprd11.prod.outlook.com (2603:10b6:a03:80::47)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 17:27:20 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::dc) by BYAPR11CA0070.outlook.office365.com
 (2603:10b6:a03:80::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Mon, 19 Feb 2024 17:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 17:27:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 19 Feb
 2024 09:27:04 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 19 Feb
 2024 09:27:02 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 19 Feb 2024 09:26:58 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v5 4/5] arm64: defconfig: Enable Tegra Security Engine
Date: Mon, 19 Feb 2024 22:55:29 +0530
Message-ID: <20240219172530.20517-5-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240219172530.20517-1-akhilrajeev@nvidia.com>
References: <20240219172530.20517-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: cdaee026-6102-4053-eb6d-08dc3170067c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/0QXex6so85n1mRY3LREn3UAi9qdLU64ppT73zr/Lb9w+UJ8V2whpnqM62RfzNYSwZ9Sdw5pyRjQU5hber3lQKHe8FypSPZ/FlvEM8BCaSZtqSTpMtEE5r5OhPjRYz5QCeQyejCXs18WOS7cnBkCGmsGJPog5P87fXQhtc1wYxFC+qTAEo/khPYuJTWfEbfheUT5n/iQERi7ND/moF+68jWLLV8NUrfdVW7JvfH/D8z45HVKdrjWT5SfUlGxpBF8m8DX8/ap/kdWusw40Gso/PTSKdSu73Hg6vniqE5wU+3G9I6dxJREWJoZ9nlwFqi1W7I3xO5jYv3mT2IBXwL2/4N8LjB9Ea9ar0FOFyO2Pl4YI64HmyaSX1EK8fki/vILKXGt/tlgPTxCiyvsIEDwQFa5oSRmXIeVomzDwxj/s1wE84nWpwZNGxCcY+1F4jv5ixmS68HjHx2vHnQyrljOnMoMQTG5Uj1jN9FxxeqO7UM+RkXNtQdQ0sR9/UQvMHm7ORqUKQzPrTE9Xz6N3o709U1lRSJcb1E8K7gcbsosgOXHreCxT6HlPE5ExqGBBASXb3sB/PQ2QjAPdE68bM96dkdZfDkjLMiDyfkYJJIHRvmSP3BvDyFk0ha7THh/YQ2vM/0VMHo2SgjkVJHnIdLAg6MJ8GMgFGC+IV3eZojjpRA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:27:19.2528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaee026-6102-4053-eb6d-08dc3170067c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405

Enable Tegra Security Engine which can accelerate various
AES and HASH algorithms on supported hardware.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b8adb28185ad..a956d64b2d22 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1643,6 +1643,7 @@ CONFIG_CRYPTO_DEV_FSL_CAAM=m
 CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=m
 CONFIG_CRYPTO_DEV_QCE=m
 CONFIG_CRYPTO_DEV_QCOM_RNG=m
+CONFIG_CRYPTO_DEV_TEGRA=m
 CONFIG_CRYPTO_DEV_CCREE=m
 CONFIG_CRYPTO_DEV_HISI_SEC2=m
 CONFIG_CRYPTO_DEV_HISI_ZIP=m
-- 
2.17.1


