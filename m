Return-Path: <linux-kernel+bounces-60805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE48509BB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4F41F21819
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B1D5B68F;
	Sun, 11 Feb 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gze0AMeF"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB945B1F3;
	Sun, 11 Feb 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707663303; cv=fail; b=H+6vJNABjv3BauBkQvp7zQ2s9tsJorE6nJcEMyF80dkl7ziw1ZRB+MlcxJv+faYaRzT9SEmhgteyPaZKnp/4QfPunAiN96zHiyvvRxO9yfbBekRaX3k3iec/b3gdzTXcUD0epMaEnFHJIbvtC7/VUSbyo2gy1z4zf/Qc9DUgQfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707663303; c=relaxed/simple;
	bh=zIj1RyOrieQMckow9roEV57b1CLi41yxZh1y0gD70vY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6RvD7DG7zEwN8k3oy9Sf/owYmHkFbHXQkh1EtWSXaVv6evMRf1E/JGL8v+OevDf/9R4stHri5gPrEKKgPVnK3V8PZgab7n6/fjtd1Ncjxt+XKBTiORyWW8niFqCgOp+I1f0Qpe+9T2glqfwaq/CdByK6t3SqSFFeYaUk4KmGgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gze0AMeF; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mckhJ/W8JvePRY9J3lyMuODDvqwnPQdFyAf3KxC+ovAiwYSzYWx0isM240wOsuECyjvqQGLjaKl42+vTuW3oLwniiC7vvNbBU1PAydr34/CcErNmeRUY8614qgU8bo59iY5bEZpEQfnGgzEuZjEFXC3TcGoWFdos/aE41eNXZw3ft2RXC9zXZ8LhY/yk4QOLyWWp1eSRGprGbQA1Gd4wn5YUtf5hB86xhHZ13d1egmrtEBqd6VuDdZQgSwRRY9VtCrCLpN9fM/l9DpdK4gppk2tSJBomSFJcJtaJvp+1Cx6mF0PcSFO9oKTg2ZRauE6/n71qNWBdSI/huDZ4GP96uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTAW5UBg5sWYY7H5wf1R1+6qudoZVN+nF2IpAnXfxS8=;
 b=KPC7gb5qCAzKAoulb83DQLglsqXY1km3W+3AlMBjSJTXMIY0XKB3QpvZ8q6NPpEks9InNbB9kioyY7q9P867pcANGx283PfMYeV9TSiVmzScLrWKVibVmlWy/gwhOW0+qjrGUS8uAdKE6kzog8DBx9Xl4fX8Qtk7QSMbgwoHyEMeK0FgryqbYWamcOMkv/f8y2eLVFWXDb+pJaQmOp12LnGzxw/PR1HSR0h//G9NpLCdBEVjdKAtNF3sJ6OYkblZ2DSoziDeGFvZyNKqLz8xmU+qgPEFnacZgotMecb+6PDRGUDTcfR9jfQhdWFMr+mhuwc3n0o62aBJUUb6bcn1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTAW5UBg5sWYY7H5wf1R1+6qudoZVN+nF2IpAnXfxS8=;
 b=Gze0AMeFwqn4CPF9otD/fV1B7l0u52Q9ej0lgx464s59EP3pcrf9UzYjxoV2zg+bqvOamBsyK8b7/djzDoT+s9RoOPRPewY6s1ULXk8R66U3GRpYoS0wZYvyztJIjpgXOO+zeSPA+YFKT5IwHFfeL6sjJAijq/SCur08tiWr6tk=
Received: from MN2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:208:239::35)
 by DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.14; Sun, 11 Feb
 2024 14:54:59 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:239:cafe::66) by MN2PR08CA0030.outlook.office365.com
 (2603:10b6:208:239::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.26 via Frontend
 Transport; Sun, 11 Feb 2024 14:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sun, 11 Feb 2024 14:54:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 11 Feb
 2024 08:54:58 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>, "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>
CC: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Melissa Wen <mwen@igalia.com>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 3/3] drm/nouveau: Use drm_edid_read_acpi() helper
Date: Sat, 10 Feb 2024 23:50:11 -0600
Message-ID: <20240211055011.3583-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|DM6PR12MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: 13be7fe2-4e33-44ce-72d2-08dc2b116b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xj0XztX9PjsTPiNAw+eM6p+GlJuYxjr0UOFhjOD4smwUScb8XnWuoxhdiqJy06jClb/tK8m5Qj/E71ivjyZN+cFLVRfVkRLw2BBStJoeYt2cJfu6g5eCuCdvObYu1IQfm55k1kju0gVhsx4+ip+oN6rB6HI68jUp1wEJovqCqSmgkrtghPJhsjF4S4h64sG7muFE7Q/L+JY0sUnR4zzECynFoJX3YLHWPH7QCRzVFRO0Remzpt4WF9VRYRjXyNP94LY4DYXL6gYr/i/d22js1x/3/c9NGvXHkwbxzpKT33lgBOBx9+C9wZv9pX6T5R/oxDHf7yQGLFPeNsSgJHN1TxDAPllT4s/EquYfzUdbndZ47loKfA9IV0Mzj4gUBrqHvkj5yNFpnAg3xWzKkhZJC13T94iZuxhO7jy+t4x5gGOXMam5el2OdRkgCN0jUZkVqh1K5ontLnytwLgIJ4RAnPtIk9Tz5I18Tvlkolo/uCEqzRZF9aIylFuiXwLHIrU5u+HJ9WB/eVPgP7/og35hn3MbN5xbsBCDy6d/uWOzLJvtR6HOKuU3NW7/rH1uDCdJwRLyEcdNmQtUSl6Sybwm+TQPeUj0WQzl/W4fpuRvq+I=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(478600001)(54906003)(110136005)(70586007)(36756003)(70206006)(316002)(426003)(336012)(16526019)(83380400001)(86362001)(356005)(82740400003)(26005)(81166007)(7696005)(1076003)(2616005)(6666004)(8676002)(2906002)(8936002)(44832011)(4326008)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 14:54:59.1550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13be7fe2-4e33-44ce-72d2-08dc2b116b28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518

Rather than inventing a wrapper to acpi_video_get_edid() use the
one provided by drm. This fixes two problems:
1. A memory leak that the memory provided by the ACPI call was
   never freed.
2. Validation of the BIOS provided blob.

Convert the usage in nouveau_connector_detect_lvds() to use
struct drm_edid at the same time.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * New patch
v3->v4:
 * Rebase on v4 changes
v4->v5:
 * Rebase on v5 changes
---
 drivers/gpu/drm/nouveau/nouveau_acpi.c      | 27 ----------------
 drivers/gpu/drm/nouveau/nouveau_acpi.h      |  2 --
 drivers/gpu/drm/nouveau/nouveau_connector.c | 35 +++++++++------------
 3 files changed, 14 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index 8f0c69aad248..de9daafb3fbb 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -360,33 +360,6 @@ void nouveau_unregister_dsm_handler(void) {}
 void nouveau_switcheroo_optimus_dsm(void) {}
 #endif
 
-void *
-nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
-{
-	struct acpi_device *acpidev;
-	int type, ret;
-	void *edid;
-
-	switch (connector->connector_type) {
-	case DRM_MODE_CONNECTOR_LVDS:
-	case DRM_MODE_CONNECTOR_eDP:
-		type = ACPI_VIDEO_DISPLAY_LCD;
-		break;
-	default:
-		return NULL;
-	}
-
-	acpidev = ACPI_COMPANION(dev->dev);
-	if (!acpidev)
-		return NULL;
-
-	ret = acpi_video_get_edid(acpidev, type, -1, &edid);
-	if (ret < 0)
-		return NULL;
-
-	return kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
-}
-
 bool nouveau_acpi_video_backlight_use_native(void)
 {
 	return acpi_video_backlight_use_native();
diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.h b/drivers/gpu/drm/nouveau/nouveau_acpi.h
index e39dd8b94b8b..6a3def8e6cca 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.h
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.h
@@ -10,7 +10,6 @@ bool nouveau_is_v1_dsm(void);
 void nouveau_register_dsm_handler(void);
 void nouveau_unregister_dsm_handler(void);
 void nouveau_switcheroo_optimus_dsm(void);
-void *nouveau_acpi_edid(struct drm_device *, struct drm_connector *);
 bool nouveau_acpi_video_backlight_use_native(void);
 void nouveau_acpi_video_register_backlight(void);
 #else
@@ -19,7 +18,6 @@ static inline bool nouveau_is_v1_dsm(void) { return false; };
 static inline void nouveau_register_dsm_handler(void) {}
 static inline void nouveau_unregister_dsm_handler(void) {}
 static inline void nouveau_switcheroo_optimus_dsm(void) {}
-static inline void *nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector) { return NULL; }
 static inline bool nouveau_acpi_video_backlight_use_native(void) { return true; }
 static inline void nouveau_acpi_video_register_backlight(void) {}
 #endif
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 856b3ef5edb8..492035dc8453 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -687,22 +687,13 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	struct nouveau_encoder *nv_encoder = NULL;
-	struct edid *edid = NULL;
+	const struct drm_edid *drm_edid = NULL;
 	enum drm_connector_status status = connector_status_disconnected;
 
 	nv_encoder = find_encoder(connector, DCB_OUTPUT_LVDS);
 	if (!nv_encoder)
 		goto out;
 
-	/* Try retrieving EDID via DDC */
-	if (!drm->vbios.fp_no_ddc) {
-		status = nouveau_connector_detect(connector, force);
-		if (status == connector_status_connected) {
-			edid = nv_connector->edid;
-			goto out;
-		}
-	}
-
 	/* On some laptops (Sony, i'm looking at you) there appears to
 	 * be no direct way of accessing the panel's EDID.  The only
 	 * option available to us appears to be to ask ACPI for help..
@@ -712,10 +703,14 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 	 * the nouveau decides an entry in the VBIOS FP mode table is
 	 * valid - it's not (rh#613284)
 	 */
-	if (nv_encoder->dcb->lvdsconf.use_acpi_for_edid) {
-		edid = nouveau_acpi_edid(dev, connector);
-		if (edid) {
-			status = connector_status_connected;
+	if (nv_encoder->dcb->lvdsconf.use_acpi_for_edid)
+		connector->acpi_edid_allowed = true;
+
+	/* Try retrieving EDID via BIOS or DDC */
+	if (!drm->vbios.fp_no_ddc || nv_encoder->dcb->lvdsconf.use_acpi_for_edid) {
+		status = nouveau_connector_detect(connector, force);
+		if (status == connector_status_connected) {
+			drm_edid = drm_edid_alloc(nv_connector->edid, EDID_LENGTH);
 			goto out;
 		}
 	}
@@ -734,12 +729,9 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 	 * stored for the panel stored in them.
 	 */
 	if (!drm->vbios.fp_no_ddc) {
-		edid = (struct edid *)nouveau_bios_embedded_edid(dev);
-		if (edid) {
-			edid = kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
-			if (edid)
-				status = connector_status_connected;
-		}
+		drm_edid = drm_edid_alloc(nouveau_bios_embedded_edid(dev), EDID_LENGTH);
+		if (drm_edid)
+			status = connector_status_connected;
 	}
 
 out:
@@ -750,7 +742,8 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 		status = connector_status_unknown;
 #endif
 
-	nouveau_connector_set_edid(nv_connector, edid);
+	drm_edid_connector_update(connector, drm_edid);
+	drm_edid_free(drm_edid);
 	if (nv_encoder)
 		nouveau_connector_set_encoder(connector, nv_encoder);
 	return status;
-- 
2.34.1


