Return-Path: <linux-kernel+bounces-142684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1441A8A2ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937991F220F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27475F873;
	Fri, 12 Apr 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hz0GlRA7"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4205D8E4;
	Fri, 12 Apr 2024 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927162; cv=fail; b=Y/8YazRBApuZtLag8bbXtpUJV/nnOYe6bziy2AevML6tfexJcBv4EmTIu8YXK/P7qwUMESuHK7K+I58zBWI0RcgEIp95TB89FOeNDqatZTTAWhReRluY45uAelKrIGFQY9b8d6p8qb6bH5KcYvV6CS+i/HbYasbQVnPlZBqnm6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927162; c=relaxed/simple;
	bh=EUETNjNg1KTODqS2H2cOaD29uibXEb6ATsQxK3u1YNU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ep9rh7zwZxjr9YTO3u0i5CWBSrlgxhpSNEdaohVjtAFcHK//XIr9oIJ9W6P2PSg2+UPl14ESa91WYxXWksXrNjO60FxNGZ//wUoLMyLPsGS9B4QUsVIt3btCWiF3NChCVwfM/+JamQIVyyKjHTB/l2FgaRZVtl4Zz2RZEWNNADs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hz0GlRA7; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gs/kSK7FZuwvwbg9sgViGaxoGw9xOzNnOXF4KsNWcfxW1BcgbAlzpEEjmsvM87iBKkIhkEVfc1pVY98EMfIzAkkioRNkRhlgsi2VnmB39F/ticAtGRvvnaxZSCI9t6wP7tY/S8vEe8lcg5usPSwXhQYSHelh8tboLdeWOeTuKgjomrE+Mp/en9zxIC/qNVcY0m8ARRt8oS66PD2iIpv24/KQZB8FfsBHJNkJgixGStt1f/soRaV6tmAUvrj0MPCY6tjTHz5OQHwENAgcOBXtr5LQfukP5xjJOp6I/om3mwxjr66ioPXWL96eI+lrquarPiEy1hHSmcGIahjH99WkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgpPRdZgQC+ZkTWiUTbnRQ5PMvQQ+bCXlTifXB9NZAc=;
 b=dzT4fslGAHS0Ag3fHnS65frkAjep4XY/+NEU+gOzpptmqd2O4rE1pDASZxrkt0E0cpUl7BmLwG/BCMo37297HIG+fpCxkJb/FyPwH3gM1Bzhbn+S42Ky4BScL5ZK+i8gglT34P6Cr5lBr7/qK+ShRNWMD4r7KgqdRqTgWWfImcZGDY0Bs4KJ1Fb4/ZqrZLINwo7b7/a7ns04zTyrVNKAvN1qXblEIbaHRTbCcHprBYhnj1cvsYI+AKty63WkZopISpq9bwRi5lG4FiSpJeNpk7fGdZ/AZ5GFCtJhaAvLR9uZ8LYi3Kk9TFa7xlQWuNoM/17fgHVc6cQfiW0ND9G2ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgpPRdZgQC+ZkTWiUTbnRQ5PMvQQ+bCXlTifXB9NZAc=;
 b=hz0GlRA7u3I0dm0s/29gmb0KEKAWIiROFafNZSRifByfqQVAU70guwh5JGnj+jUjm8nRiPFP1JvXgtzKYOQcV79YVIEgN/3/YabCaxYzdv29Y4KO67DEKgSnQCv5phIuXfEyRqtVQ8QhmpnbMRogZ7+LiTTNxDO9wi+L31IMb7IY6c6cvCNSezyIsGP6Pqs+xxI3Etk7VxaLF3u3mdjXDeoOhmrQlYIRo766mXmMgumTQlVJPsK4NGmbKw8dsuLu23/mO4USeTbuYjStm7jrik6TOVc6krvtZ6Sq/CfgGsvDobzUbEKzG7sqL8RyrDnlimaN8L9clKb/CEy6hRGGfA==
Received: from CH0PR03CA0066.namprd03.prod.outlook.com (2603:10b6:610:cc::11)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 13:05:57 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::c3) by CH0PR03CA0066.outlook.office365.com
 (2603:10b6:610:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.21 via Frontend
 Transport; Fri, 12 Apr 2024 13:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 13:05:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 06:05:46 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 06:05:45 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 06:05:42 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <amhetre@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [Patch v3 0/2] memory: tegra: Skip restricted register access from Guest
Date: Fri, 12 Apr 2024 18:35:38 +0530
Message-ID: <20240412130540.28447-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd9cc91-9786-4c66-5e30-08dc5af14b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x93W4g5ImBi7TpfE7Yphj4LLyvqDtx/pUtPHx9v4fwfg1Z9ElcJ8X7+CK4YqJHalbNYbwCRLHtWDuiAazTONtb9eT0tsrfafv1YP5O+t6nXjmSZQGvOSV3A8yTYrjW3It2ArN4PvAmEF2nzhoeQoHchfBiFQJK31B7SDsRnMu/FsCZboqrNOaLDOeqxl9FYm7d1R6mKOoErXWVzmngYJ6sDJz/keeGyrsTEOqe+ooAYTmyn2CCDGg82c0DkjBBEEk1ZG3O40sVRxgsb9xZEL1QwYEXOrN62go7cK/gqnLMBMk1kjYG8j6SDmpnl1HMU8uMeO/B651TiOyWdMP8rodxTWAWai7ZRmLP3QBA6pCphD5OG5dEdyP8tMn8vfU2DT5cIVF8IQq9LuP1CmkbxDi1vXm6MaATCRTVogBCpOcM9Dzjr34kyJhOl60EscWmNV/EMrCup8bS3B/jqMb0T4WpPihHFD1a3L83zRXdy67dPSW5jVf84ssuuV0yDmDq/QSE4uPPvRD8Lp07lCNKVESdko3KrXZs/iJF8ys06dGjkUHX2PbznviO37SNVIWpHKLBAuSR5kbQwnS10xwtbcb8RVD+xbjG+g1kNK1hhH7rRMU+mGrCd0c1JQwyZhqbS/V1s3uxdg1pn0UJhD7qGjjoNgQPoF54aUS5Va1BgNStLxUtbUlr1HBtflYaB2dHx90YkSnD20Vt8nLPfIX5CUzsAKHwD1eTqQ1fMAMXcrGErUoT8ZWeFRrWn6KGnEZwLm
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 13:05:57.0794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd9cc91-9786-4c66-5e30-08dc5af14b0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287

MC SID and Broadbast channel register access is restricted for Guest VM.
But the Tegra MC driver is considering both these regions as mandatory
and causes error on access. Change that to consider both the regions as
optional in SoC's from Tegra186 onwards. Then skip access to the
restricted registers from Guest if its region is not present in Guest DT
and hence not mapped.
Previously, the solution in [1] was not accepted. Now, handled the
problem with this alternate solution.

---
v2[2] -> v3:
- fix the yaml error.
- add null check for ch_regs in mc_ch_readl() causing error in old SoC's
- remove unused populate label reported by kernel test robot.
- fix existing compile warning about length of name in tegra186_mc_probe.

v1[1] -> v2:
- consider broadcast channel registers also as restricted along with sid
- make sid and broadcast regions optional and access if present in dt.
- update the yaml file.

Sumit Gupta (2):
  dt-bindings: make sid and broadcast reg optional
  memory: tegra: make sid and broadcast regions optional

 .../nvidia,tegra186-mc.yaml                   | 95 ++++++++++---------
 drivers/memory/tegra/mc.c                     |  9 +-
 drivers/memory/tegra/mc.h                     | 22 +++--
 drivers/memory/tegra/tegra186.c               | 25 ++---
 4 files changed, 82 insertions(+), 69 deletions(-)

[1]https://lore.kernel.org/lkml/20240206114852.8472-1-sumitg@nvidia.com/
[2]https://lore.kernel.org/lkml/20240402132626.24693-1-sumitg@nvidia.com/

-- 
2.17.1


