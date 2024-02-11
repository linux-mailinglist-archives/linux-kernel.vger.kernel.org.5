Return-Path: <linux-kernel+bounces-60806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7644D8509BC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57450B211C3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F1A5B699;
	Sun, 11 Feb 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KMiyjMqt"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB75B20C;
	Sun, 11 Feb 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707663303; cv=fail; b=B+XZ2/yH94n0o+yjomsUK2qq+wRyKdUxkW4J73GXJyRQ+kcEzrViF8O+uxU0cjN3HIAuMnBAlCBgcq9DAGcXpOV90Tn9SUPufZBeA488D4V5OYaJcoqr+fnfyts6t6GHFyOJYJ7DW0emUpVpaZ/l24iVnr16IbeK9/ZQYpL6U8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707663303; c=relaxed/simple;
	bh=mTg203EhxFDibsmQlzyXmwIvu1v7EvjXVw/HSVsVGcU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTD4TGzQ6IPFe3Jf8V4UP8xngR0M7oTp67jfDV3qziQtKqupWuBCD5Hw3ypjwo1iUDs7ToxvQVe+Gg13OX7UCZjREOT9bH9+RJ1lEn84poql7txXyHEVnp7G/a4/d9EaERyg+qrkdBvfeUCyPN/x7YfdhK/0J0Wav3OSW6Cg//Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KMiyjMqt; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yq1v4/Xo6h8tjqkToftVVOZRf9ecORAb6IsyZ0XPa81hv+fmmSBzBlPQQi4gQui7fM3UH/s+KEMzcdWdKN9As7tDyp6MFQUa2wL+23BXk9ggQEjUKTtSq3nEJWNZUvImzefkWX03GaQzrbHNK3INoY4jydnWssswy5fywDRwnJzi4xqp/da02wKbSSiNEEycB30CUynr1VQHIDZ9uXV12AAdVcDi27nKqmxtVypsttENMVq4B6w5xv/BJyy7DhZ69dTUdHmEB18EY0lE1uFI3XjrHmQj54ehgSVog2xthETaM2UvRduISZe8d8EySr9qFeyctqZ3PWcFuy5/vmsuug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=281dB05FP0PYA2tV5HbCBd5elQzmRC7uD6C5i3A/1m8=;
 b=GuSznVCGEc6U5sADFlmwFj5UNyroyheycRN0PnDWYJSHFfXjmMeeKUGrK+DskbooIm7pssXHblFYZby7tPMMuiYjGO1a6XWQht1/WoNuwot93N9JuuTbMRu27cYB21cWeqvAaYDYEYOYU+uxr3NLADyPbac3hinralHhZwb2Em6j6pdVorJuLveuUVYh+fWhIo6O1KXmDBEbOXUUp7KKDTvRxTJ8OucLI+KppUpZIklUaU4TXt6CHlfaknzBdNgBv+F+L2/u/Gb/AyJAAmqBNFIsk/XCXeYnuxFxcHfLRAfMArF5RXqMxDpfUPr1qD8wlOL/yenx+YsDLjhJ+xpvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=281dB05FP0PYA2tV5HbCBd5elQzmRC7uD6C5i3A/1m8=;
 b=KMiyjMqtH16nd9ePvJwqoO9MO2YkEgLqqZKDww/AfUSYKUeubQQeEp2gODq5WHDlVwMPGX7kCkYOOkhmvvrub42nB82pIbn4JT4vL4I1oKCGlPYjKg5xT3JIisbT0jV9gAYcsQpRANMCgWnhJJhbJKkkZTVYchFXszzp58/Kbgg=
Received: from BL1PR13CA0249.namprd13.prod.outlook.com (2603:10b6:208:2ba::14)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Sun, 11 Feb
 2024 14:54:58 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::ea) by BL1PR13CA0249.outlook.office365.com
 (2603:10b6:208:2ba::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16 via Frontend
 Transport; Sun, 11 Feb 2024 14:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sun, 11 Feb 2024 14:54:58 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 11 Feb
 2024 08:54:57 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>, "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>
CC: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Melissa Wen <mwen@igalia.com>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 2/3] drm/amd: Fetch the EDID from _DDC if available for eDP
Date: Sat, 10 Feb 2024 23:50:10 -0600
Message-ID: <20240211055011.3583-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240211055011.3583-1-mario.limonciello@amd.com>
References: <20240211055011.3583-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: db942123-a24b-4dc5-e139-08dc2b116ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Amuu3qXcr2yyYfHQTnL6NQX+eHcpAKisuBRXc41MUMwech4hElSqNhJs+APw04NmBCbFD0ouO4+/kR/NgFWOY9V7Crc0GwMkdTXYrtsmgAgU0JA+C6c9Ytn97ohwb8xMlty6dyMq8jQoBy+LAGPLnhEAoY4rP5qKyVO5TsZxq2VfESX5UE8y6iIRdKvOya6X+oNTSClMLEaQhjs9GPAU8nE7jV6+gQD4zMPL1LvgHcNr5zlV9eANC7H7FvgeifFbzy7KiLcrNtXV85cWQFn59ExfUWiskHhRHObvEKNx4pqpd1vDQUbPK1OYE25y3n14JPMmt2QxPa9dYtuJ+ttsTEF39jOlWu65q0ywtwBnHyJwWfybiaW61rUgVwC/kfv/q+gBvGmRvjk7/X66ZkhSMQisYlV3FQHygiwfoffZ6EqVRn2/FFq8Ejo9+Xmn2Nku6HTih5Wb4Y1BvmQORLw3uUl87mdaNsY2jJckcbL5JLO1LcD1HDcP6vJyKqdJs5qJBd9fqlWV6tw2PjNQOhbFOpbF7QWvqJerN+pVge6vKFHi239gTHhDgvLmkI0fIGBbLkIfKaaAkIcIRle3RPv/dYAI973F4lsNjECvC6Bdu70=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(36756003)(2906002)(54906003)(26005)(44832011)(70206006)(83380400001)(478600001)(110136005)(2616005)(426003)(16526019)(336012)(66574015)(1076003)(5660300002)(70586007)(6666004)(8676002)(81166007)(316002)(86362001)(4326008)(356005)(8936002)(7696005)(82740400003)(66899024)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 14:54:58.5877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db942123-a24b-4dc5-e139-08dc2b116ad1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315

Some manufacturers have intentionally put an EDID that differs from
the EDID on the internal panel on laptops.

Attempt to fetch this EDID if it exists and prefer it over the EDID
that is provided by the panel. If a user prefers to use the EDID from
the panel, offer a module parameter that would disable this.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * rebase on v5 changes
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c            | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                   | 8 ++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 4 +++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 ++
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 543ed9de5a6d..399885251714 100644
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
index 9caba10315a8..9165a199ac9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -281,6 +281,9 @@ static void amdgpu_connector_get_edid(struct drm_connector *connector)
 	if (amdgpu_connector->edid)
 		return;
 
+	/* if the BIOS specifies the EDID via _DDC, prefer this */
+	connector->acpi_edid_allowed = acpi_edid;
+
 	/* on hw with routers, select right port */
 	if (amdgpu_connector->router.ddc_valid)
 		amdgpu_i2c_router_select_ddc_port(amdgpu_connector);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index edc042db4ea8..123f1128d14e 100644
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
@@ -991,6 +992,13 @@ MODULE_PARM_DESC(wbrf,
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
index ed90fc8fee9f..0b3a19d3d43a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6619,8 +6619,10 @@ static void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
 	 * Note: drm_get_edid gets edid in the following order:
 	 * 1) override EDID if set via edid_override debugfs,
 	 * 2) firmware EDID if set via edid_firmware module parameter
-	 * 3) regular DDC read.
+	 * 3) ACPI EDID if allowed via module parameter
+	 * 4) regular DDC read.
 	 */
+	connector->acpi_edid_allowed = acpi_edid;
 	edid = drm_get_edid(connector, &amdgpu_connector->ddc_bus->aux.ddc);
 	if (!edid) {
 		DRM_ERROR("No EDID found on connector: %s.\n", connector->name);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 85b7f58a7f35..d570a1b6141b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -910,6 +910,8 @@ enum dc_edid_status dm_helpers_read_local_edid(
 	 * do check sum and retry to make sure read correct edid.
 	 */
 	do {
+		/* prefer ACPI over panel for eDP */
+		connector->acpi_edid_allowed = acpi_edid;
 
 		edid = drm_get_edid(&aconnector->base, ddc);
 
-- 
2.34.1


