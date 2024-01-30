Return-Path: <linux-kernel+bounces-45192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466D842CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D3A1F25AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04CB71B53;
	Tue, 30 Jan 2024 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mpaWPdgB"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90AE69DE4;
	Tue, 30 Jan 2024 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642807; cv=fail; b=RrqLHjSkoS65/kZ2gKR6O7/EKxaheEW6Yqzn8wAdeE7WZby5qGUIuyPp01zNP8QrhxrFl4MS3oV35VH96j8gllxHsMQjjQnQuLJklvx2mdm+015Dn/iRezZzWXOII5UQGJyJksajuTZzK5bNY8ZUd4mvruOxH7bs+GySWVCvnfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642807; c=relaxed/simple;
	bh=r3ILdclr4WwDh6gwGivDJDrcSUz9fgW4v02IFnQ4XcM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAWIJUvNvxPuOZVzRpRGCwDxuI7bz/GmmG0abUEtHa/vFa2NWAILCod3DODjmJ5mKUKCd5gxAMmT9+a9fcfpb3WNJhKGM67YY61YzCWNuGR13YSjWPGX0n5164PAL0TezY+DPQIBhlWwdNndnn5pS3417q3jnYk8xOiOx7Ez9Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mpaWPdgB; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/gPDtNo+V+Bzen+QrtpWvlm75k3/7kzQrCQ3cFJ/C8MHBvvmY9a37bDHC/ddRY2HlfzylXFACnEVo1x4DqH8zM4wPQ54ofPFlQ/NDdtm7b+5uM5LroaVKOYzBakIhU3sdSJisF+Tz8LX5gw95ZITMXcDKjL0nJlpCiXPbYBhsF8U4tbVLVAQcGKDBaDUm64uPt2DPjEMFZrJjznLiEQwo0ptaVuYgAJgoScQUHNh2X3zkdVrnZPc+lTz/fFwSOapmnbouXHaXC/SkoNVIySx3nunAHrDrGTsTZyJpxtTsF4bob6x272By3DVGseocR4BDj1hVngw9piB9ihlrAXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvdY9+EfGzsWnuaI1pRPOqi6JEPcNDV0fXiaLf5JpnE=;
 b=JRU4lNcEt3I+kxNgWRurnXnVvOac9DT5MB+WrVSih9Vwnt1Fw5cp5BuD3TBuQmVF0gIjLAgd5Q1alM+oBKMP09zwdXUwXSBe7+hKqgIvc9Gfg4sz+FsLkedXuQsdAzTlRYRlqHqrgXsbL6DLv6Z6ixxc5mANR5LoPNsGOmlJDh/pSuQpXGtWj7kzE83Sxb8D741taGVBYFLgM80kNWG42TNstVrRxRcnlEP+u/ctvmHmxhv/CMAcBvDuWFTuZqyiW9OAjL2FHRnmoUZiSJECocrC93W0kyLYG5cGI6jiefsJVAOSwYaGoSpm6EV9F+3U61RQnzfAaHG6lOY0A3swwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvdY9+EfGzsWnuaI1pRPOqi6JEPcNDV0fXiaLf5JpnE=;
 b=mpaWPdgBdO6Wb2nt7ylxZ4qDZn0QYIbxk2NJxpv4ULZz7j1oOR2i4UbpMHqh/U9DDPAheRgXGVYnwXiMTvb7IwNLxmP6i4tPzwrh7X0i/vNtNm+vhxtfMxcYbJdjch7GQVFsq5wrHV/nZyGWrBLhj+BycJ2m00bYlrtbuO/85Lk=
Received: from MW3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:303:2b::29)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 19:26:40 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::4a) by MW3PR05CA0024.outlook.office365.com
 (2603:10b6:303:2b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Tue, 30 Jan 2024 19:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 19:26:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 13:26:37 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>
CC: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>, "Mark
 Pearson" <mpearson-lenovo@squebb.ca>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v2 3/4] drm/amd: Fetch the EDID from _DDC if available for eDP
Date: Tue, 30 Jan 2024 13:26:07 -0600
Message-ID: <20240130192608.11666-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130192608.11666-1-mario.limonciello@amd.com>
References: <20240130192608.11666-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b07ffb-3c9d-4640-92ec-08dc21c962ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tlcuxJmHDXKNaWhoV68zxYzlE9hWzNIHLTuhxxAGpf+NQrHCYG8KJehxwzMUR2DUnttx0bwKT6rdwNqsuZ8JnkRc7332qkakGcj8kGUt/z3w1kgLhC3PFOTy97DjH3jKlFnGtk4jZmrX4HoP04mhKb54sgCzpwC5hDgA0b+SWUhkvyLG0RE+7cfPFSPACSExKNbTrF7pww29/bMyofjZ1613K31hsgByQ3xr0+WnZX/uU655p2UrsXzjgmJ0R82uEd6WbFuwZUN1hTPb7bGZ2zovPH6ESXKj9Pda93TYiriFQzckfP+OA25Ay+SAF9pI8EosB2Qt+NQiddybGcJ3E+CitpUmaya61lxgbzxRyHmNGQ/8/VuhCgTJMkmTvYhO+zIPxfqmezrB/okniWmTSos62rtKl/N930GXSW9Lxwt9rjQcfMOI/dq+jHqweiDRD/wvClW3DByoonCd63UjwD3CE/liayHkiF6JQm/dO36+GZR7rlBsDqNdOrMSzwX6Q2BfVPLOgAgQ9dfcM9ZzwlT/YSL8VkyiKNUPDLneLEjwgox3WtIq3pSwJDuqCjQAYVliRp88BdCF9t90x+LkEFhFH3JUQLHcEY1CGjVsbL1Gib6SKs3nLREWh1sQEW0SgNt5D2uxDLqLREwpvMR4gZs6LNkvBi1eYIm82RMffdXKoor4eXIniPcqY4E2OTUcddZHjfcNkJi+xkrRg8+Ug6reNrHOz0yqsGTYjpL2BJl4ZhAK0AFSE6LpU9+8xj4YLy5WEM5QHl0Jg74r8lG+vA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(41300700001)(81166007)(82740400003)(356005)(40460700003)(40480700001)(316002)(36860700001)(110136005)(47076005)(7696005)(70206006)(8676002)(54906003)(70586007)(8936002)(44832011)(26005)(336012)(426003)(86362001)(5660300002)(2616005)(478600001)(4326008)(2906002)(6666004)(36756003)(1076003)(16526019)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:26:40.0734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b07ffb-3c9d-4640-92ec-08dc21c962ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250

Some manufacturers have intentionally put an EDID that differs from
the EDID on the internal panel on laptops.

Attempt to fetch this EDID if it exists and prefer it over the EDID
that is provided by the panel.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Use drm helper which will run more validation
 * Move eDP check to DRM helper
 * Add module parameter
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c         |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                |  8 ++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 10 ++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  9 ++++++---
 5 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3d8a48f46b01..5d5be3e20687 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -217,6 +217,7 @@ extern int amdgpu_smartshift_bias;
 extern int amdgpu_use_xgmi_p2p;
 extern int amdgpu_mtype_local;
 extern bool enforce_isolation;
+extern bool acpi_edid;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 9caba10315a8..6aa8cc431abe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -278,6 +278,10 @@ static void amdgpu_connector_get_edid(struct drm_connector *connector)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
+	/* if the BIOS specifies the EDID via _DDC, prefer this */
+	if (acpi_edid && !amdgpu_connector->edid)
+		amdgpu_connector->edid = drm_get_acpi_edid(connector);
+
 	if (amdgpu_connector->edid)
 		return;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index cc69005f5b46..be7a4da85a8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -166,6 +166,7 @@ uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
 bool enforce_isolation;
+bool acpi_edid = true;
 /*
  * OverDrive(bit 14) disabled by default
  * GFX DCS(bit 19) disabled by default
@@ -990,6 +991,13 @@ MODULE_PARM_DESC(wbrf,
 	"Enable Wifi RFI interference mitigation (0 = disabled, 1 = enabled, -1 = auto(default)");
 module_param_named(wbrf, amdgpu_wbrf, int, 0444);
 
+/**
+ * DOC: acpi_edid (bool)
+ * Try to fetch EDID for eDP display from BIOS using ACPI _DDC method.
+ */
+module_param(acpi_edid, bool, 0444);
+MODULE_PARM_DESC(acpi_edid, "Fetch EDID for eDP display from BIOS");
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 202c6ad443a3..688d615c6687 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6589,7 +6589,11 @@ static void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 	struct dc_link *dc_link = aconnector->dc_link;
 	struct dc_sink *dc_em_sink = aconnector->dc_em_sink;
-	struct edid *edid;
+	struct edid *edid = NULL;
+
+	/* prefer ACPI over panel for eDP */
+	if (acpi_edid)
+		edid = drm_get_acpi_edid(connector);
 
 	/*
 	 * Note: drm_get_edid gets edid in the following order:
@@ -6597,7 +6601,9 @@ static void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
 	 * 2) firmware EDID if set via edid_firmware module parameter
 	 * 3) regular DDC read.
 	 */
-	edid = drm_get_edid(connector, &amdgpu_connector->ddc_bus->aux.ddc);
+	if (!edid)
+		edid = drm_get_edid(connector, &amdgpu_connector->ddc_bus->aux.ddc);
+
 	if (!edid) {
 		DRM_ERROR("No EDID found on connector: %s.\n", connector->name);
 		return;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 85b7f58a7f35..cc39b1c14aa8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -899,7 +899,7 @@ enum dc_edid_status dm_helpers_read_local_edid(
 	struct i2c_adapter *ddc;
 	int retry = 3;
 	enum dc_edid_status edid_status;
-	struct edid *edid;
+	struct edid *edid = NULL;
 
 	if (link->aux_mode)
 		ddc = &aconnector->dm_dp_aux.aux.ddc;
@@ -910,8 +910,11 @@ enum dc_edid_status dm_helpers_read_local_edid(
 	 * do check sum and retry to make sure read correct edid.
 	 */
 	do {
-
-		edid = drm_get_edid(&aconnector->base, ddc);
+		/* prefer ACPI over panel for eDP */
+		if (acpi_edid)
+			edid = drm_get_acpi_edid(connector);
+		if (!edid)
+			edid = drm_get_edid(&aconnector->base, ddc);
 
 		/* DP Compliance Test 4.2.2.6 */
 		if (link->aux_mode && connector->edid_corrupt)
-- 
2.34.1


