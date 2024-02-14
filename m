Return-Path: <linux-kernel+bounces-64710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B288541CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA4B1F26ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F27BA2B;
	Wed, 14 Feb 2024 03:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vmm2Bl5h"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201EC9474;
	Wed, 14 Feb 2024 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707881735; cv=fail; b=sPcdOdjFLr1gjg26NNENb+PhSACAtKNh+pIBIKdHG7a4UBX1IbDk5wXVtN0JqZELUPPWrXRWTDRLQ1mPYsGdzbRoE+MhY6HwfV9bexh2L8Boqz9g5E6KJiLF3nPEPXDMqT3HMff1ZnYskzN9AGwTOGWBhtxftw/DY3LzcgzEZKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707881735; c=relaxed/simple;
	bh=h2bWvhUKI1/K20+NsRARFHdbaTLFy4cUHc0EQD+Uxb8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jgxm/CGclQ+psL7D5pNJJKbsF0jrnWf6rYjWz5kjfPt9/XZcSlsWJmmsnDSno4YXMasCCMEC1/82riLxt5zy67cD/LXfG2zyHvgTZmb34LhMm8TytErHGIgsFcN/Lr3omkZ87TYyPnPJP4+9xdPVP0lSJKSXDV/4yf8IKmBtFkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vmm2Bl5h; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Br/6IvFSzssWtwPARqCOFxqyi4/M7n1LQ9Kd75WrfyZPwSTPZ5sM/fUKjlL0nQ8raT/CNhWyPsMWwJXbGZbtmfOtPflLHxw1je/Q3gvp96gP48nIZa8dqW0qtEHZCtmE8CEnpGaoTnfSY7Dc0/AIlPhpzi4UrntbJul3HYFRWf5Mn5Z4NaLvlv32t0uaLX2HFuxmyQfKMn2bzxJl3kkeNAtLJlKQkPizBdUH3HO+YSMDrbtxQLUb1Hb4uNyLzJOz/qy+a9Ll6oeO2MOb7UX9InXeQtR7mP954YePj7C60MluMJZ4gM+p3dpJFR40qBvqRTaQ303AvX1pwdYTv6EMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp8pBp1+rdoLWafplcme5Q3GhOFRgEIhhY2q1OH5I08=;
 b=lI4FQ2o8TVQSjszFzr7GimYaM2XA9vYnD1R1KHww3eW9cwVwZgXtVC+D3m3O36+c6E+JNvG7WzLUJgCQsi1vrwpE0SDldb20qs32N0h+pz9CyllKF5uvgDPv4dMtq6d9THz9MDj85FQLAIBtVmPg+iZJWy/dGsOjZ92OgrccMVqtWTktVPekXFpkEkfsnmFJv5Xcl+Kt+pQ5lyRkYYg1jUjXCaHRwCJFlQe0jon78KUyXpqwwhxWfbX7cW3sPjERvio4ZWE/9+Tx5p6T3+ttvUDoljh5u62Khc7+CTgiKXKR0WqwHhwWKvQY+FhHj4Y4N6zmbeaE11oyAalGljzRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp8pBp1+rdoLWafplcme5Q3GhOFRgEIhhY2q1OH5I08=;
 b=vmm2Bl5hfQyaQxFuduxrQLZjQumSC+jVqWy6bYvldQ5xDz99m+WQC/XtrdgeKV81RNWpDQhxuS8/PbvMpfn8IFpQo8Dr6KaBier1QE979RLiGOBHWmJTvGXv9bFYKuQVFCsBzTx1/GhkTMuJF3OCt6PlnGVpP/3L/3MLygfB33k=
Received: from BN9PR03CA0588.namprd03.prod.outlook.com (2603:10b6:408:10d::23)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 03:35:29 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::49) by BN9PR03CA0588.outlook.office365.com
 (2603:10b6:408:10d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 03:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 03:35:27 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 21:35:26 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>,
	<naveenkrishna.chatradhi@amd.com>, <sathyapriya.k@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 0/2] FRU Memory Poison Manager
Date: Tue, 13 Feb 2024 21:35:14 -0600
Message-ID: <20240214033516.1344948-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7e377d-631a-4ced-c177-08dc2d0dfcb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9be3LgPceT3ufwZuWaVNNTpNoM0up8YKnUasyfP0tacmbGO1VkygtpTL968pSIIAJS0T3oYAi/ItYUi9P5ChBlLQrU+01fHnBNnE4wp5l9q34P6Ks6jTbmiN0p8T22S11P6FlKixjii642+F+Z8tM+Qmyu67C+9S7jKYPMDYk1mksnNPSP4g2+cm4HAUum9kT+Y4ajk/JYAJhWRyfsmCXF5wJ6+hRZz12W4ayonhKSbP5BTXOEysuIXa0k/1Hbo/RuD+aKss+ja/nSYsGDpTNmST4wL4biOQI5mQ0N1+U97fFn4aBFv7VpYiGp+CNpX/WT/g1xXKcYnVADwwmEEVPZUNOkcEU85fQ2dRv2D4Zh+hJ9p/K5plboaiKYtOIC+lmVFdHkPwYF+TJdum/YBDJ+oGUMTOXEL81Zh0/GQQMCibV+CxeH889kzYzNL1TChQmRnkGBxdlCGCo87kpY8FhbYz1IUtzyrM/kG2J47F3Gr83X25I85wWr6ZIUEQE525gF9AoXU5wniZYr+XEhG63+1oxnyH7PWciPvpcx0WVFzOdbAOZKUrkKKJdm6ChSw/ywllQqEDiqScwII0dnUa8A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(6666004)(2906002)(86362001)(36756003)(41300700001)(26005)(7696005)(83380400001)(8676002)(8936002)(70586007)(70206006)(4326008)(316002)(16526019)(1076003)(110136005)(54906003)(2616005)(966005)(478600001)(426003)(44832011)(336012)(81166007)(82740400003)(356005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 03:35:27.7024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7e377d-631a-4ced-c177-08dc2d0dfcb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

Hi all,

This set adds a new module to manage error records on persistent
storage.

Patch 1 moves a function from AMD64 EDAC to the AMD Address Translation
Library. This is needed for patch 2.

Patch 2 adds the new module. This is a near total rewrite based on patch
2 from the following set:
https://lore.kernel.org/r/20231129075034.2159223-1-muralimk@amd.com

I included questions in code comments where I think more attention is
needed.

I'd like to add Murali and Naveen as Co-developers, since this is based
on their work. Also, I kept Naveen as a maintainer in case he's still
interested.

Regarding the old set:
 * Patch 1 exports a new function from the ERST driver. This is not
   necessary.

 * Patch 3 adds a new sysfs interface. This needs more work.

 * Patch 4 old set adds documentation. This needs updating.

I did some basic testing on a 2P server system without ERST support.
Mostly I tried to check out the memory layout of the structures. And I
did some memory error injections to check out the record updating flow.
I did some fixups after testing, so I apologize if I missed anything.

Thanks,
Yazen

Yazen Ghannam (2):
  RAS/AMD/ATL, EDAC/amd64: Move MI300 Row Retirement to ATL
  RAS: Introduce the FRU Memory Poison Manager

 MAINTAINERS                 |   7 +
 drivers/edac/Kconfig        |   1 -
 drivers/edac/amd64_edac.c   |  48 ---
 drivers/ras/Kconfig         |  13 +
 drivers/ras/Makefile        |   1 +
 drivers/ras/amd/atl/Kconfig |   1 +
 drivers/ras/amd/atl/umc.c   |  51 +++
 drivers/ras/amd/fmpm.c      | 776 ++++++++++++++++++++++++++++++++++++
 include/linux/ras.h         |   2 +
 9 files changed, 851 insertions(+), 49 deletions(-)
 create mode 100644 drivers/ras/amd/fmpm.c


base-commit: c2064388aa8765abd7c2c5785e7bfe266a2f6cd3
-- 
2.34.1


