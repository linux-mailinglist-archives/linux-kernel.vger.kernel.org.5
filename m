Return-Path: <linux-kernel+bounces-48921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBE284633B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA431F25C6F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3924840BF4;
	Thu,  1 Feb 2024 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4/ipnymN"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2557405F1;
	Thu,  1 Feb 2024 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825502; cv=fail; b=fW4bhU8Ympfre/clK6g0OPw1ag1jBda/0BiV+oI5JdZhY2p+QVCugqyCBZoHKA1pWL4lOx/DKHODf+XJbmVhwtwBx03ruCVMgMNU2jFXjag9UeRLRzVQo/sIpsiXVlb3pDZTg/0MhToB+jGEcOfxfFAgeW1GNc7pCgn6YZhsLxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825502; c=relaxed/simple;
	bh=xLxs1vZvOkpE+6Jnr3A9tUH03CM00bYKDNqfSKQEXcs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HoaHUfxMxYmmdllErWL4HcNPONsdBqIjUg81jIUJym0z/aOjXhv8GV30r2DK7fA68lJfehHMU+1OZi92WPyIFFCkrkZYhyGylErkyQbJGfbjDHMJ5DZ6SfeDERSQwcmzrmiXoXJlZZu/0/bWAxvs+I/MX7qC6xBDrpGWRuhXq5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4/ipnymN; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLHYWmOkUyMDzKP8NuoeoDXByr8JYgdje/oTnsFs+Tns/NWIpomypmWOfdr3bswZFkLqc3qlqgNj4SleW94+Np+AcQtveujo8Cd/oTluA8sB/++bieBr51LGPiYD8Oq7SqneNaG03fRYKBmJdi0cBI4nHbpJJv/NMU0eroQ2kFlyxxwZhbeQ34MWslXxJD2uGG+aMNcmaUE/CsfMKSNpvKVaFg1uJ8f8amN9rsVOtPaQIth+KVlynJcaAEE8mKcvyjvumOngaj4ZZBdFkA0FAZdLzPL+i8BmVl68k5pNGJXyG5Ud5e+ejjEhj/4/00slVqZ006JZKh3YWXR6OC0K5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCywjw5D8vgHFCTQux8e8mViMEgVBwqXflFfsD5FsvI=;
 b=nTX+5VRt8Qs/7HUMjHJzSMWxCjnmSyNQAduMUU1vr3v9buPddEhSb5yD15eROvMonYCNM2FTbRUyDYybOL+sWkhyXMcrV2FJJZDlqsVoQare5yBVGIX83GO5QhpF0g7SwcL5eaF2MrjMH5LTfBPL4s/eqHG9SxFLlih0aVPKPLJJavd2sEVOsrmRJ2mTZypyP1HpHHo1m7waqTUQb8GsN3xAux89YQMbIvEmbKZ/nBue1yYDRgpvZB+aiV4wqfDxOyai1cP0a5D9WQKsQ3mHZh99ULVrql0t/77TqXDKCp/goaFBfN2421rvMEsG51u0xggybqvE2LVA1YFtvQXSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCywjw5D8vgHFCTQux8e8mViMEgVBwqXflFfsD5FsvI=;
 b=4/ipnymNbePiEYucEnJn2edsBbf8qRfXfmvqxkflVjjpjsicP1BtJoxZQL6DrWNIzEVmBD2Z/UVr644rIWu8tBeMlRoB9gtYc3DJuwhS71eFFf2HNZYALTF/spReEGEYepdgFHIBT9D5F8LYKEHDC26fqFqjT+gsjpsCNRIlDak=
Received: from DM6PR05CA0044.namprd05.prod.outlook.com (2603:10b6:5:335::13)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 22:11:38 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::8f) by DM6PR05CA0044.outlook.office365.com
 (2603:10b6:5:335::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Thu, 1 Feb 2024 22:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 22:11:38 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 16:11:36 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>
CC: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>, "Mark
 Pearson" <mpearson-lenovo@squebb.ca>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v3 0/5] Add support for fetching EDID from ACPI _DDC
Date: Thu, 1 Feb 2024 16:11:14 -0600
Message-ID: <20240201221119.42564-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a28923-d0db-41fc-f83d-08dc2372c2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yKrFFOERkdfW2MwYhDxYdyRQTegaMSSuWMDGIBeZn2/g2iO+1VMHp6/K6Qazy3tobMja5lXgwTTrtYa0kkk9ZxIyg5Ly9cfUJgzTAiOd0ktIwgcKgAlnpSFz0ndlrriEE6uogSOpaqyQ/lGUJBkLeqODQaaNO6EMeFDUH+tgfrTLiNA+7nz+j1UFQ1pPXcAey5aYgrT8tS/40u5DsbquFZN+27p7nsrt1uLHS2xP7a/T+82LkZuU3GcfKHqKnEAMGWbP4k1Yji+L4Ms5LdLBbwHNemdhEy99TcGI1DTqqJ4GeTuAXwko99VOccHWx1E+0wGdWwMwx67SHov+LUEDaGtxd4fhQgoJpX4rijdFFJq21Txl/X9RA1GSXLmtVb+SxBHNllCdfElIbRazgk6QNfJUCYMNTGHL8uaAqAs0H9KTr0uS5kGrJTK3P1cfSgjBUurx1RpZ9YT3HNk9F+0K/2damTynnzxTu4stypItBKKj+Sj8g/G7Krv0tPIv0EZc4zZt858D5rvK34COqJ0h1IBveOwypP/cJ9CKlIVrG9JcLBAvs9fjiNhvhnex7DOqwba+E63D+bEC1nkYJGWMpi3RglneI/6fXAwfc1xDvWql01UKFTmXCsUmzUY3PNTBtuYuJO4bRfXr+pAY3JRJH50kAP6N9icePPX/9JHch2BqR64NlbKP6hfldjM2KrrjW/cgKB5xiBZmUsJwXkahLh8iX5uxQxdaBWD7x7V7rpMJOCsvbvuHs+M1NLLWxO1N
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(40470700004)(36840700001)(46966006)(83380400001)(426003)(2906002)(336012)(2616005)(1076003)(16526019)(36860700001)(5660300002)(26005)(82740400003)(47076005)(70206006)(54906003)(966005)(8676002)(110136005)(70586007)(6666004)(4326008)(7696005)(8936002)(44832011)(316002)(478600001)(86362001)(41300700001)(81166007)(356005)(40460700003)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 22:11:38.1688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a28923-d0db-41fc-f83d-08dc2372c2df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092

Some laptops ship an EDID in the BIOS encoded in the _DDC method that
differs than the EDID directly on the laptop panel for $REASONS.

This is the EDID that is used by the AMD Windows driver, and so sometimes
different results are found in different operating systems.

This series adds a new DRM helper that will use acpi_video to fetch the
EDID.

On amdgpu when an eDP panel is found the BIOS
is checked first for an EDID and that used as a preference if found.

On nouveau it replaces the previous local function doing a similar role.

This does *not* use struct drm_edid as this will require more involved
amdgpu display driver work that will come separately as part of follow-ups
to: https://lore.kernel.org/amd-gfx/20240126163429.56714-1-mwen@igalia.com/

v2-v3:
 * Clean up some of the 'select ACPI_VIDEO' kconfig spaghetti reported by LKP
 * Drop the 'select ACPI_VIDEO' from the DRM drivers

Mario Limonciello (5):
  ACPI: video: Handle fetching EDID that is longer than 256 bytes
  drm: Add drm_get_acpi_edid() helper
  drm/amd: Fetch the EDID from _DDC if available for eDP
  drm/nouveau: Use drm_get_acpi_edid() helper
  drm: Drop unneeded selects in DRM drivers

 drivers/acpi/acpi_video.c                     | 25 +++----
 drivers/gpu/drm/Kconfig                       |  5 ++
 drivers/gpu/drm/amd/amdgpu/Kconfig            |  7 --
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  8 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  9 ++-
 drivers/gpu/drm/drm_edid.c                    | 73 +++++++++++++++++++
 drivers/gpu/drm/gma500/Kconfig                |  6 --
 drivers/gpu/drm/i915/Kconfig                  |  7 --
 drivers/gpu/drm/nouveau/nouveau_acpi.c        | 27 -------
 drivers/gpu/drm/nouveau/nouveau_acpi.h        |  2 -
 drivers/gpu/drm/nouveau/nouveau_connector.c   |  2 +-
 drivers/gpu/drm/radeon/Kconfig                |  7 --
 drivers/gpu/drm/xe/Kconfig                    |  6 --
 include/drm/drm_edid.h                        |  1 +
 17 files changed, 116 insertions(+), 84 deletions(-)

-- 
2.34.1


