Return-Path: <linux-kernel+bounces-48926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA5A846345
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5D71C2533B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679204779D;
	Thu,  1 Feb 2024 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v+2hUSGQ"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911D845C08;
	Thu,  1 Feb 2024 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825507; cv=fail; b=ZQpfoNs/kud+CZBfhr5sP7+bklDT6MzNnWeB46Y65Js/e/k75VHx0ARYXhExSyBXLaTKJQ2Ai1Yvh+/JMHWGnGsrlbvfZXjrrlp96eS+BIgzQc37RxkDAXd4UF8IApKpQRNJTeVR8mDtqEW8pE/PGAfazMh1XDgDg7jWtfQDaPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825507; c=relaxed/simple;
	bh=+rPn0AJ7bD3vu8vabFcCWz0+PsOIVBBugK9xiB6vLyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeidsSURKa9JS53MF1IgGvE5q9/eemx6KeYId5ir/tfJXZ8KN8onqaH1CQnJp647Du9f4v2HdTjeuzVo7bR04MqAHmTFudXNkF+6zsyuV40lHn3D0vzHso85PQlvHSQG8JJH2dERk1hI63DZMRItk8t8A9mfTy7mp3FIx26hgQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v+2hUSGQ; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJiHFaVyTf2kX32RRQDiqNPDjCVRQ/rwTX26g4qu9O0mVAb+utBh8g3riD4OSj+oeHgIyQlvOHKl4YUuGrKdfMXp8cVY8/RZtmoyedj61D+KxOcbU8stah1qxCzIl3RIdCUgmB7+eOMUsf06xMt4UIPiEq9AonxHKt5ih31ZdR3WGy0ex3fbCMnB2tXLev7kSeVFb7pvlK/mUJaLEc8379qDdcKqKFICssHm5P3q/UL6V3KnTuptedziMmIPtuHI7iJFBFJ8GWsw4rDPwJhzyZi5HVqfoTQph2MRfafhfHsuRrYedyLo70/EhQwJVgJ+BJaYHBmwAQ3cb2LisBkJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74dNLM/t9huEm0pVQr58RF1E6RXQcgyu/W4MGe1qImA=;
 b=WsaipvpdJf+tIvC7vTncZcz3P+arB91UqSEE0Fl2U6SpD3yG0+D5gvxZHN5+AZIrVO4FLTJ21rINmIInk2Q3Sya7gvB08iY0Ao7KN5eOepdOCL6ac37Dij0LGJIA0WLbhWalzRGPPCGXUvFeOiILmmQX7RmgCnxVg4a/KdCXlIQmluYgU3ogtV+G409PAjvH/sW8J/3vHTrXs9FMZJEgyAcNiYXuRcesFxiztc+0Ac6FCcDlTOSbuQcy/lIlwPt/W07gNFPCF+Ijb2dIzEKX17weOYC+7OXNkzDK2bDyl83QwFvCdspZgkwYeDWOt/0rEB5LXl3Tlu2vGT4x0MFyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74dNLM/t9huEm0pVQr58RF1E6RXQcgyu/W4MGe1qImA=;
 b=v+2hUSGQu26IBUCMfs2YSCzRA3TjmppOY2J1tsQDymH/XqSHiWAR2ZVp0cZycXXppP308JxIby4JCh6qd6ZP4aSjv15ml7PurbR6UIVpvSH3fxrLPh7S+3nQIs/3VOEOD01yty1/pUwiTX1BUZZxR0/+K0T8lEL9f/LQtvCddKM=
Received: from DM6PR10CA0022.namprd10.prod.outlook.com (2603:10b6:5:60::35) by
 DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Thu, 1 Feb 2024 22:11:42 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::32) by DM6PR10CA0022.outlook.office365.com
 (2603:10b6:5:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Thu, 1 Feb 2024 22:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 22:11:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 16:11:41 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>
CC: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>, "Mark
 Pearson" <mpearson-lenovo@squebb.ca>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v3 5/5] drm: Drop unneeded selects in DRM drivers
Date: Thu, 1 Feb 2024 16:11:19 -0600
Message-ID: <20240201221119.42564-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201221119.42564-1-mario.limonciello@amd.com>
References: <20240201221119.42564-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c398e72-7c82-43c1-f362-08dc2372c54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2FVzbcEsd1yUeGIvua647CrVswhqVmvI88zb+/+P/iWlLAC4PQ6n0ldlwhA3EWMsdrJpJuomeQMciLyrk7h2d7T2j2NZBF6jpGyUKdUorE0JKDeZ/h12U9fz8hUK+n4ECTSv//FGOCjgd42/MoTD8oOvX5RInA4i+TwctblDUMM1oCf2mTOyHOSO7RnPlD698KQFwepsBi9kOBAfEUHkwUZiCDVbQy8WtlcZtwoxxnSaTaDG1ab8jO4OyiKJ/Hjplw7g4QPNU3nsuMmNWYYWql4HLLzPHI9Wxy7hYNhv/ox3x+Hr+gyi8G8eeFOH0cMdx/qXuzSfDvVq9WQsFNl4F+dYKVzcsZARGMTvUW3oliTvjV5tqOtS7LyCCp3rwG1f73F+J6NljjbUjJaJodgyTajL04nDGqotWmf/tHFf3gU1TDU/h1PS5BmODPVF2ZFrohxx49LcIeIm232wp13CB01rdnr+/jeD4vDOQYYGi6AOd2764Ytn9SEuvlSpk7nQyCipFEqCKuJJsvO6Og+wnx9qdItaIuOCQ4kaPHlfhplfJHvntjkiyEQWzReqRAJnfj0TmFo4zB0K1RO4n17buP55d0Q/CyqKbul7h+7ZS0mKpcITjKgKHY/L3iiXb1VAZNLYaOyOMyKtbHdCpLSEjdich3ix7odC1X84KqsdhEwEc0tduWtodfN9AeS1U4rC1j5lY+3hw8l02kfmvYBDVbQGio1Z0dKCX4HEMZg6lCdQCuIcvvQkTdUfdw18wqCxtqw8ajzwcPDbgzJPKmAcsw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(26005)(41300700001)(316002)(36860700001)(8676002)(4326008)(5660300002)(44832011)(86362001)(8936002)(2906002)(110136005)(70586007)(70206006)(478600001)(36756003)(356005)(54906003)(81166007)(7696005)(83380400001)(82740400003)(47076005)(6666004)(2616005)(426003)(1076003)(336012)(16526019)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 22:11:42.2581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c398e72-7c82-43c1-f362-08dc2372c54f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541

All of the selects on ACPI_VIDEO are unnecessary when DRM does the
select for ACPI_VIDEO as it provides a helper for acpi based EDID.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * new patch
---
 drivers/gpu/drm/amd/amdgpu/Kconfig | 7 -------
 drivers/gpu/drm/gma500/Kconfig     | 6 ------
 drivers/gpu/drm/i915/Kconfig       | 7 -------
 drivers/gpu/drm/radeon/Kconfig     | 7 -------
 drivers/gpu/drm/xe/Kconfig         | 6 ------
 5 files changed, 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 22d88f8ef527..b2178a5a947c 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -22,13 +22,6 @@ config DRM_AMDGPU
 	select DRM_BUDDY
 	select DRM_SUBALLOC_HELPER
 	select DRM_EXEC
-	# amdgpu depends on ACPI_VIDEO when ACPI is enabled, for select to work
-	# ACPI_VIDEO's dependencies must also be selected.
-	select INPUT if ACPI
-	select ACPI_VIDEO if ACPI
-	# On x86 ACPI_VIDEO also needs ACPI_WMI
-	select X86_PLATFORM_DEVICES if ACPI && X86
-	select ACPI_WMI if ACPI && X86
 	help
 	  Choose this option if you have a recent AMD Radeon graphics card.
 
diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
index efb4a2dd2f80..6921ef67b256 100644
--- a/drivers/gpu/drm/gma500/Kconfig
+++ b/drivers/gpu/drm/gma500/Kconfig
@@ -6,12 +6,6 @@ config DRM_GMA500
 	select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
 	select I2C
 	select I2C_ALGOBIT
-	# GMA500 depends on ACPI_VIDEO when ACPI is enabled, just like i915
-	select ACPI_VIDEO if ACPI
-	select BACKLIGHT_CLASS_DEVICE if ACPI
-	select INPUT if ACPI
-	select X86_PLATFORM_DEVICES if ACPI
-	select ACPI_WMI if ACPI
 	help
 	  Say yes for an experimental 2D KMS framebuffer driver for the
 	  Intel GMA500 (Poulsbo), Intel GMA600 (Moorestown/Oak Trail) and
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index b5d6e3352071..476da09433bb 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -22,13 +22,6 @@ config DRM_I915
 	select I2C
 	select I2C_ALGOBIT
 	select IRQ_WORK
-	# i915 depends on ACPI_VIDEO when ACPI is enabled
-	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select BACKLIGHT_CLASS_DEVICE if ACPI
-	select INPUT if ACPI
-	select X86_PLATFORM_DEVICES if ACPI
-	select ACPI_WMI if ACPI
-	select ACPI_VIDEO if ACPI
 	select ACPI_BUTTON if ACPI
 	select SYNC_FILE
 	select IOSF_MBI if X86
diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kconfig
index f98356be0af2..12149d594100 100644
--- a/drivers/gpu/drm/radeon/Kconfig
+++ b/drivers/gpu/drm/radeon/Kconfig
@@ -19,13 +19,6 @@ config DRM_RADEON
 	select INTERVAL_TREE
 	select I2C
 	select I2C_ALGOBIT
-	# radeon depends on ACPI_VIDEO when ACPI is enabled, for select to work
-	# ACPI_VIDEO's dependencies must also be selected.
-	select INPUT if ACPI
-	select ACPI_VIDEO if ACPI
-	# On x86 ACPI_VIDEO also needs ACPI_WMI
-	select X86_PLATFORM_DEVICES if ACPI && X86
-	select ACPI_WMI if ACPI && X86
 	help
 	  Choose this option if you have an ATI Radeon graphics card.  There
 	  are both PCI and AGP versions.  You don't need to choose this to
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index e36ae1f0d885..cf60bdcafb0c 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -19,13 +19,7 @@ config DRM_XE
 	select DRM_MIPI_DSI
 	select RELAY
 	select IRQ_WORK
-	# xe depends on ACPI_VIDEO when ACPI is enabled
-	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select BACKLIGHT_CLASS_DEVICE if ACPI
-	select INPUT if ACPI
-	select ACPI_VIDEO if X86 && ACPI
 	select ACPI_BUTTON if ACPI
-	select ACPI_WMI if X86 && ACPI
 	select SYNC_FILE
 	select IOSF_MBI
 	select CRC32
-- 
2.34.1


