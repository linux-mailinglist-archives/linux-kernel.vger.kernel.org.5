Return-Path: <linux-kernel+bounces-44322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3784203E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8469B1C23A43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF7167A0F;
	Tue, 30 Jan 2024 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N+raa3JY"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B4679F0;
	Tue, 30 Jan 2024 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608451; cv=fail; b=KlDRguAQpZzvrDxlVXHNJ0eI6pwzNqHvoHuRjA+IEWHbgnShqin9wAepiiNUv24oD6o74LB9BCplnTC5Vpr0/lvIzAvfImuwiUzgGGbQ6JOgehQHTF963Eb1g/+SEGHvGYQAp9HMDpPbYb+4HcM6Wh77H1bY03g7AgAYP8okfd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608451; c=relaxed/simple;
	bh=yzYxPXXOzwL7d3D8mjw2vCpTvm75WLiKddw8/NiTkkE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fGCjwN/kdNV0A26T+OXAkFpH4h/g/Kb+NO178+RTxlFbPVCQk1eKdoMyJi4A9iyLyzhj2OKVpcYp8vmB3C2zsrAOpkyQRUZEILvbjB6ZMJH/UP+MRl7mC0pgBsCfpM1rQZcQ+I5vVFpxlPGiuluRPpDSPNTDkQd2bprBMLbr6qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N+raa3JY; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDX91v52G2BLWe04ZFbCaln7eimCICRxuK83oy69fVBsem3w9WVETKxuG2lGaOzCnOpe0nfZ9pyXRJ2b+nlSA8TacFGKAR7e23RgMavTG/pA3xKCp73f87Saa6PAz29jsigE+awErbV0iZWb2hVWLDs1l8LHutV4H9RfKiA6obsI/kwp20vS4eq5+rEQ010fT4gzJFTPsFetk0VE7OfOzaV3t26l8aRffuSnkASCBqflfrGRNRou4ASAhfwQZSLva2s/uj3vrMVT9EwX4B+9G+AGaFYDmn3dU4fG/kj5e3QjLkSAfStqfwTBjf7bx/pDqIFG6vPip7CGGknxlQ9wHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeZAp81m0qPLHUrfTH2D9BDa02DJQp3gyl1pficFulk=;
 b=nRBHcZPoHi7g1DkvFeb3zkqp/HH5eC1TDhnr1BiEGcX2hqPeJ7k7NFemGHvQKOIGzwNhZMyj1+7m+GLktWiJlS36Vc5ZcysgVGA0U8/QQvSzGrxgoY/ELfLEv8ahDHQVEnq2XLT877ubS1IjJW3/j6nC3FkQXFW0jPr8NDUqt7cKn3w21EWWv7GJa7ZVlYywjbzWRVaplfyQwnrrSfMy7SG9xEoi6JJLyTtcZY41Ou9woOCp5ZOT3zYBzVtGtHKNTr6uvh39e61m2qFYKPF8vc3rKV8RNnB7CG8CLrvvyEyF/HdXolbA3+YrngRS7PFf7RiwI8mJnFIxuDoiu9YRqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeZAp81m0qPLHUrfTH2D9BDa02DJQp3gyl1pficFulk=;
 b=N+raa3JYpW4STlt4bT2sXGJ6PfkLWeNVObblCxucsykHDhcWYQuqE9ok+kIrAyEKUrEycfHz8Jo8I1j63jDVW6nNvYD/d8jFVx2RjYopITSPEaQmVYmewCBFbihxqPNGICG92MiznQDxGA2vrkizJp/Ps0wvpnhFDSjFMup9NUk8d+aV+pPxOuosspWlo1n/C9+EcXrAImCtrvgABmseX9sdI3/g0UXLx4OoH8W/JDc0w0cdzCDSf0Tvwfyiva1jSFa6PrbscWDan2ILxyQ7ySE9g0dSbiivRE1YAGQPACtapUd7ayLi/P+G4XO4FO6jIMKXvlk4ZSkYJuu0dWGoxQ==
Received: from DM6PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:333::21)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 09:54:06 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::79) by DM6PR03CA0088.outlook.office365.com
 (2603:10b6:5:333::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Tue, 30 Jan 2024 09:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 09:54:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 01:53:53 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 01:53:52 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Tue, 30 Jan
 2024 01:53:51 -0800
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] Feature additions to mlxbf-pmc driver
Date: Tue, 30 Jan 2024 04:53:46 -0500
Message-ID: <cover.1706607635.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca0aeac-e7e8-45c1-7a45-08dc217965ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wuHQBdx4eLHu8pT/kzL2UhF4/tSNTRPAgzrZHYriE1wKB/pqCliD16JZBMf+1gH6uEDW3bktPp+pWJflT14b1Fl+/X96FqJWMXh4j6/nbo85exFj7H8/UjdrykTDCjIIhaMlDdgGIw9XUK5Nh1Tejgu7eyaRi6oZonwQVP5AgZTe5yafD4e9MjyJGBRu3Xg4Nv4emtSTP/6ri+PwoQ8sZ8dV4h/S+Sz6NMNTBBVplxtzFSrB1JsOLlvzImjVSs/gaeZsMXmfo+X1Ci1dagR6r7XIUuNgoTRFWwfS4TATZkX2xuiVHxrtwY5Bj+7p4E780QB7zD/DtYxWdFaoGnkeViSQsx1zFSQO4UPdZOOiM35G6w2HCvK3DPBD4ZNvyDuNmu0plU8LmKUNxgGqopHE9wDHL3QbMvyc1sl52puKsdwIxaysxbWVq6R49pDp9jO/Cj7D6o0Jis6zTN7XZ6GKcyHwlaXfUwmb3245HSYG1hes4rFpdy+bNvzQYqHuRltrr4X1njZg8iyCF/swxvNLs1pxiDJtGkNzpWSoxmSAeGQwD90XXijeaWi0iuT87hUV+bWNT7rHd+V8HOxV2OtahkT7M7Tea9HLVqnwbGjyw2C7x4Ntk0TfZ7K06c6E1m5tM0LowcwkG0ZHU2/jzpKtQc7fmMKvLGMKM7FRaX/0HoTsqlGukXnw43XwV8+j0KilX9+B3YDaj1G3q35V0QaH3OLcfq+vvClHLSrZA2uSKXQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(26005)(40460700003)(40480700001)(336012)(6666004)(36860700001)(426003)(2616005)(7696005)(356005)(82740400003)(7636003)(86362001)(36756003)(4744005)(478600001)(4326008)(70586007)(2906002)(41300700001)(47076005)(83380400001)(5660300002)(110136005)(70206006)(54906003)(6636002)(8676002)(316002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 09:54:06.2986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca0aeac-e7e8-45c1-7a45-08dc217965ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083

This submission contains 2 patches:
Patch 1 adds support for 64-bit counters and tracking cycle count
Patch 2 adds support for the clock_measure performance block

Shravan Kumar Ramani (2):
  platform/mellanox: mlxbf-pmc: Add support for 64-bit counters and
    cycle count
  platform/mellanox: mlxbf-pmc: Add support for clock_measure
    performance block

 drivers/platform/mellanox/mlxbf-pmc.c | 178 +++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 4 deletions(-)

-- 
2.30.1


