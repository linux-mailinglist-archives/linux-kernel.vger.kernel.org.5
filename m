Return-Path: <linux-kernel+bounces-160617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6908B4023
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000161C22338
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6501BC39;
	Fri, 26 Apr 2024 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CW11gn7F"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA51096F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159688; cv=fail; b=i5u6t+jB3M1imZOFcqlv7nvCUuIattlVR7bGaW6zlzirph9qhyOG/gyObp2/CqnzZxM56MMPnPhp+29Sj5hQ4KcPcf1TIQTbxerVUiSCbml8vMJV+1MlZvo5r1lMxUEH58pmpMIGDyftEd4Bynq5ji17mT5SSNQ4fzuRskcNCvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159688; c=relaxed/simple;
	bh=jZ2RvqSC2w8TQ/kyfa9wQdTZRxcUUbTFnIDMhzL/NBE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=CoZgUlYm7vztcnOF8iYNz0FjdgpcTlMQs9M+B7ZiC5Mgj8GjbxSkinT1oOWD03mtQceWGfdIShxJJYIBeGSgMmdeCdk86Gu3t106n9CwdmMx7X9VcqZpBVrq1kxUq/Bt4eoV2L4fLMV9A6CDBaN8dwwxKdFZ3DiQ3UIq8H/Wt2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CW11gn7F; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TivsP3+0GspnaYJKeDGtzge2gBwPewQbDacEIJS7A2rB6LrphoHUBAfVX4bpBnYMbq+NuTcD1LGkx7FwzAg9wLVWuJ934ciu3egd4kIexHIZ/FayxZPpKRao9l/fRWC3JTQSXBwtbu5mwXjdHqmTp5mDxAUc0E8amzSD7r/sG+C/QrERNXjb2+amjoNZ7Zuzg68cM5ItHlWgCtb4XL2WguCpHuGPMUsxwTUgexTR1qXhkkCNLp9SgFjvwFX1FmQl3EsNDVHNmufRUxvTQnrw2ChmDzZaJb5nSgoF38s/+6/FmfVcntwdp8aodvjSSfrwhBiVRXGF2Zgx6lSs46pgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2nDNxAmvUroGqRWMjZVFbPDVyiueadVFtL0QtP+QIU=;
 b=mfrCjQkJx3G7avKMbnKEcwgSmh51uRNomvTcTmj1fM/SCghyxCrXiYrgz6aFS5muWZUF6tQLa9NtNr82NKCaJ3SNMYWkzwZFMo+E3BEzm1IaE6aR2X6u0hw8Hh75Ew7jXSB3bjbb4RNZ/B4dHENnPWvyrXGjidAZ2a4xhTu7W1a7TElM5L3QNvV3XeuiRkM43hvg2QsVeAEC41dvjKg7qdR0Od9ozlCdD90pRMm2AGaTs+QoKD/gED4Wkn4LQRpmn2C0SXQKnejd35IVSw9gMd/0LBZ4cqNkHgZpW1w+p08wojjlpmGUsGFN+yVCRfkGAkkFKSKKGBgkZdQ1wwCCUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2nDNxAmvUroGqRWMjZVFbPDVyiueadVFtL0QtP+QIU=;
 b=CW11gn7F9JyegOWJwQOxPjgRJKF7WH9oyDWNY1F8q2LemCW9ze05J3hLZTvFRUfytgKEDKRA5b9lzMTjvJtJKkFO1iqIRhEc3HrB0Efc3Le8/bQXFJWyqZ7zj2UD5i58gx/icN63BD3H4hKwpPXfWOIkzhAce9kbWRbBfJLWGzA=
Received: from CH0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:610:cd::32)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 19:28:04 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::a5) by CH0PR03CA0117.outlook.office365.com
 (2603:10b6:610:cd::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 19:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 19:28:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 14:28:01 -0500
Received: from xsjanatoliy50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 26 Apr 2024 14:28:00 -0500
From: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Subject: [PATCH v3 0/2] Fix Kernel CI issues
Date: Fri, 26 Apr 2024 12:27:55 -0700
Message-ID: <20240426-dp-live-fmt-fix-v3-0-e904b5ae51d7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADsALGYC/4WNywrCMBBFf0WydiSTRx+u/A9xUZuJHbAPkhKU0
 n837caVuDwXzrmLiBSYojgfFhEoceRxyKCPB9F2zfAgYJdZKKmMNMqCm+DJicD3M3h+QYPy7su
 61LYuRLamQHnei9db5o7jPIb3fpBwW3+3EgKCkdZrq5w2lb00vTu1Yy+2UlJ/bAUSCmkqqlAhO
 vra67p+AL9HHirqAAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Michal Simek <michal.simek@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Anatoliy Klymenko
	<anatoliy.klymenko@amd.com>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
Received-SPF: None (SATLEXMB04.amd.com: anatoliy.klymenko@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 20daf20d-85e6-475c-3e75-08dc6626fe53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWZpWVEyZjJOUVFDS1FNTGJFZ3dhRW5pTnMybm03MllCT0NsZ3RxOUJOU1dI?=
 =?utf-8?B?OHovZmpxaE1TL0Jhb1lMNXZmWjROaDdQUkFoQkc0c2g2dTQwV0djeXoyemlK?=
 =?utf-8?B?YVhKbDljMTQ3ZE93WDZ1dG9NM25MUWd1NTJFbmpjV1dpak5rZ2tYaFd2SERR?=
 =?utf-8?B?MmlBNVlIT1VEWjB0QjlsQ0dMbDVsaG41M1R2M2cwTEc4S0pLU0lxaXlhT01z?=
 =?utf-8?B?eUVsWTk5WFdyQ0g3dDBMRmw1ZDBOWXhYb2lEMGdGNXVjRjhWWVlBL0lNa3Zh?=
 =?utf-8?B?T0l2VWFOb204b0MwY3BrWFVneFJCWkNvU0hlNlBQQzRmYWNRSkxvczE2RklV?=
 =?utf-8?B?ZTIrTE80Umt3RUdLakRJZ0Rqb3VzMXpKVEV0aVVYZDUzcWtYanRid21HSCtn?=
 =?utf-8?B?aG5xanhTcm5xbU9sYndJdDVZWjF4SmR1c1B1Z3BSdGE0NEpoL0ZyWlFiV0pD?=
 =?utf-8?B?dVAxNmRSbXpwTDd3R1NUV1lLYm5od0x1bXl4MEUxTmlxbUlMd1FvMG5WSHFN?=
 =?utf-8?B?V1d5Wjg2U2duT0l2TWQyV2xtTTUzVktXcHNWeXhVOHE5cUdZS3ZQQ3RvdmdW?=
 =?utf-8?B?RmJROWFwamx6VTJIOFo5Rmd2cU9mTHQ3dlV6WCtIZlJrN2YvUXpmY3MwY3lS?=
 =?utf-8?B?eTYyTTEwSFpCSm9XVDQyS3RWWU9VQzN5SDBnbFJrK0VPVUNYczhLOWYxZ2Mr?=
 =?utf-8?B?NGxwSUdoaU42ZFNBcE1Ba0Y3eHRXamRpaEVINkQ2SHkwMzR0NFZkR2hlNWRY?=
 =?utf-8?B?RGlxTWV1M01NNFNVenY2Rm5SVndQdFVHNDg2R2dTSmJvSnV2NFhUcTN1VUNw?=
 =?utf-8?B?TGVVVDhQemV4ZllKMWJ2M0VrNzJhQTRERmlybjQvOTl1SytWNFpCOUl6THBE?=
 =?utf-8?B?aThpSmRFU0lMYmxmbUp1K0ZVcXQ0Z2k5ZHNzWWh1cldEWVQ4QmliRWNJVHBJ?=
 =?utf-8?B?RjFNOFFiZTUwZlZJVGN6azZRZFg1c0hQNG16V0g1SW9jbi9TVUVRWW9vZmxP?=
 =?utf-8?B?THlYbDYwNVE5YytZUXh3TnA2U1FJRWJLT3FnT0dOVnpuc3VMaExYTHlhZi8v?=
 =?utf-8?B?dFhNVzF1c3p5aVFla3Y0ZjFsYTN5ZzN4aWtNMzBOVDNOWTFoZ0NTbUpaaEgx?=
 =?utf-8?B?SXNBSTNTUGNyeGE0YURweExqb0syRW5DL2xBSWdkYjhpTVY1K1FoWERoRXVq?=
 =?utf-8?B?cGhuaFJjaUNqQTN2djZjblZid3NJaklwdTdjUmJEWHV1MHdOeUQ1RTFOZTVC?=
 =?utf-8?B?dHk0TWlOSWxqNUtrNmdVWVdLbzNCaS9QbVBGR2VOK0Rodlp2N2ltOXVEemph?=
 =?utf-8?B?OVc4RmFyKzZQcjAwclJoVHRHbjBjY08vMkduOUFGWGdrV1NKLzJna25vMGM3?=
 =?utf-8?B?UkR3cFFTQjFpaVBDTERlaldtS2M3aHN0MUt1UktLaXROcWNQcHBVQXlZdjB0?=
 =?utf-8?B?YmtkbFg2S1pnV1dqdFg2TkptRys3RGFLakF5ZmhyOVpXTnNBZkIzSEFCeG9a?=
 =?utf-8?B?SEFtcUJWYXUrSmpYWk9yN0p6UDZQRHZrOFRheVlhQXdLNkhIcmpGQ2tkWi9I?=
 =?utf-8?B?eTN4WXE1RjZnRVNtU1FjU1pBRkl5ZlhEeEZMMlNWbzJ3QVFwaE8zekhuOEdT?=
 =?utf-8?B?aHNPa1ZDOElRYTFLVlFZL2lYbko4MUlLNXozdXJPQ2Q3Y2U1ZHFVbHFKSmRH?=
 =?utf-8?B?ZUtvMUdHdms3czRsc0Y3RHBZQW5jYVFsU2hxcW9UaXV2NVB4SWgxZjR5dDhx?=
 =?utf-8?Q?ddpZ7CWYeGPY5eS6Kki2585HT8SAoPj75ul+NS2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 19:28:03.9864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20daf20d-85e6-475c-3e75-08dc6626fe53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

Fix number of CI reported W=1 build issues.

Patch 1/2: Fix function arguments description.
Closes: https://lore.kernel.org/oe-kbuild-all/202404260616.KFGDpCDN-lkp@intel.com/

Patch 2/2: Fix clang compilation error.
Closes: https://lore.kernel.org/oe-kbuild-all/202404260946.4oZXvHD2-lkp@intel.com/

Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
---
Changes in v3:
- Add Signed-off-by tag.

- Link to v2: https://lore.kernel.org/r/20240425-dp-live-fmt-fix-v2-0-6048e81211de@amd.com

Changes in v2:
- Compilation error fix added.

- Link to v1: https://lore.kernel.org/r/20240425-dp-live-fmt-fix-v1-1-405f352d3485@amd.com

---
Anatoliy Klymenko (2):
      drm: xlnx: zynqmp_dpsub: Fix few function comments
      drm: xlnx: zynqmp_dpsub: Fix compilation error

 drivers/gpu/drm/xlnx/zynqmp_disp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 2bdb481bf7a93c22b9fea8daefa2834aab23a70f
change-id: 20240425-dp-live-fmt-fix-a10bf7973596

Best regards,
-- 
Anatoliy Klymenko <anatoliy.klymenko@amd.com>


