Return-Path: <linux-kernel+bounces-45189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DC2842CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7B51C24813
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704DC64CE9;
	Tue, 30 Jan 2024 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K88CVW/l"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D27B3CF;
	Tue, 30 Jan 2024 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642804; cv=fail; b=Nc2mvcqajtReKBGLwyoUNsmVa4sqO7OU4t+RKz5590D2H9LfXGK1SWMhQnZ3vUt9Pg9HKhvtJjZpGmozGzkDt+nubjwg8wrqk2gfhX2ZlgyCQzBbxcKNfeUnIk2eHw9udffSYB0yPd/o4eDxaiAqkdCZCxZ4HdqAy+U9xoWlehk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642804; c=relaxed/simple;
	bh=OsQ13b47E9eGFpCjlGDKy0SMaXKVoEb0+UMEZ5SIFXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSS37NJ1VlcpZ5DCNrWdj1oOCKuVx1xqpH5Mu9RqFTFAYS4JGWvycLN3hhzUpYzhU4+V2TIy2EVCqQgiUmWJ36aB9q1lmpGLU1PZZjoZaW/KmPkd5snWxsMfjSDNpdJaPVmXmSRxkzXLEx6k87G+Bw7FTmziYyEkKVLHzwk0laA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K88CVW/l; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQI2ncC6amPfVbK7823viQWi6+6Oc+XYgoRtH9ozp/lTpl5fIg7CtsjdAIbmdUtu01PeNZlP732pOjAwyjNi1wbaItsRkNUJEfLSuV7bkLEG3H/Da6J2js5z5l4UNWQL2opTvTEIaEaFz2CIce1IXiHbzkUmDkeMALbLILbMSM0SNpYnnC8iBC9xwoHMnnn27RS2VoGp9MS2P6RUZdY9Arq530v+VNUDVlRKLeFD7939dt8BkmcFrIL0wEsPpW4zpRvHy2D8bpTzLmqs40ry3byCZLF6FdWQYLd5jRI+sz3xANFlGcYpva4qjLhhmPreaL1S4GHLfLh0/i5QZ6cl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUV/SfNT6YO2D0Y8SkwnLSND4pHgedqZa4AKzXhj4as=;
 b=l+bNIEhNYcjQSva/llFGQYp8eY6hMnXp46cBkCXaKB5ZYY03q1tWQXa1YFr6iIyx3oQC/NiPbnT66f/AKkbzckONmEz+d2tM5x4CkRWz2SYHkcALyn2XfGn44E0gIzO2sNCMmqrLzVVhWZYhOchLxEDWCAMeAmTflNwBHqgGy7BcNnM/Fy/MwyD61UN13PQIASWWK0H1CtMxCHNUdzVz9ab1vXBRIZGaq/bCqYS7ZiDOF/s+7DdV7K9QiPoqgGs7/MCA3phETyQLoKip3ts4mZbP1LPQwKOY7uQtukfauKEYcv3bZS/Ao2dtH9rl9j1BIFmMuHTmH/hgHcCiB+JMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUV/SfNT6YO2D0Y8SkwnLSND4pHgedqZa4AKzXhj4as=;
 b=K88CVW/lakgcgW+Uyf9H4ZWqdD39QIxoltMl8tQqad49CY0Xh4ZclmXKXFPlaNQaGv1AFFVgXLp20aIrsnflR2Iyye7WZmkFjEWXygyssVqmUkV+2V+WvZCkCzrhDLqYXqfTwOJfCayNMMc8TtbzcA+G93ZdEyIA0cGXfK6S8hg=
Received: from MW3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:303:2b::20)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 19:26:39 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::76) by MW3PR05CA0015.outlook.office365.com
 (2603:10b6:303:2b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Tue, 30 Jan 2024 19:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 19:26:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 13:26:36 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>
CC: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>, "Mark
 Pearson" <mpearson-lenovo@squebb.ca>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v2 2/4] drm: Add drm_get_acpi_edid() helper
Date: Tue, 30 Jan 2024 13:26:06 -0600
Message-ID: <20240130192608.11666-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e792278-c82b-49cf-4a40-08dc21c96223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Toe45ZrHu4YA2zS4UxWxGODsDJ63kC+gz3bM737SObEsbJsurxI5SJTs2wf0F3hz3Z0mTgeBBddRQsu+JRLyz2OhuetUfpwnB7mnhd6aN68t3owEpuLd5vqs0cXPV1CsuFhYKMtrFwSmHhhJIaWqnv4awuoMa1Dvc+pMesrfrrgJn8M+McaQndWFjAYUiMvVSeExGDoip7Jsnmd1rle0XtPKuN3Hr5szHI+0kKgA+9OopMlgHzabQisDDzMTY+rNHeHHk5YC8I+oZNKLudqw2W61XnIeG5bkvjzlucwqJq5Fx4WcFsakK6Ofyb07zNQ9XR9sK6GJM7oV2v/B9EZ6DXMMqweVJtg24plWVcITLWBSaHeVPt2GSeJCMp72Q1UEtJGp1Ui2EQvvdZz0VaOQvatGfuuWM5TOutWyhxGwr66d460zczC2blwSAYTqpFolqUezGKcS4O2mT46XrbcSaipVShyhKAA9kQBCD5/Vv77r94mkUVKPNKvCcGhEpX8F8qPJnjrAfwYOxGE5CA9gcU9KsM+rdxwG0arqizwTqiXXcDHv3DsI7wFP6bfzuUk4Y+YxSMKa7yND0Jk9FAO2awpFFKSVegmHuFkCHgSVEXAfWHI1/x0OtlrAABdWFykYSvnEjJyWLThT1X1Sx0tPrrW+PaN4gE2kuIjYokqWZcsQ/3LBPjH9KPKNpz943Xu9W0gVhKWt+JjR/BhQzC2PZ7PGiXI54RNZnnYzQ2IJAGEpQG331rBNN+WLPvGcC6A/Ip4ofEcVF8BBHH+/NuSM6w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(66899024)(36860700001)(478600001)(110136005)(356005)(44832011)(86362001)(81166007)(2906002)(70206006)(54906003)(70586007)(316002)(36756003)(4326008)(8676002)(82740400003)(5660300002)(8936002)(41300700001)(7696005)(426003)(336012)(40460700003)(40480700001)(83380400001)(47076005)(2616005)(16526019)(1076003)(26005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:26:39.6828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e792278-c82b-49cf-4a40-08dc21c96223
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088

Some manufacturers have intentionally put an EDID that differs from
the EDID on the internal panel on laptops.  Drivers can call this
helper to attempt to fetch the EDID from the BIOS's ACPI _DDC method.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Split code from previous amdgpu specific helper to generic drm helper.
---
 drivers/gpu/drm/Kconfig    |  4 +++
 drivers/gpu/drm/drm_edid.c | 73 ++++++++++++++++++++++++++++++++++++++
 include/drm/drm_edid.h     |  1 +
 3 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 2520db0b776e..0065dcb63745 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -21,6 +21,10 @@ menuconfig DRM
 	select KCMP
 	select VIDEO_CMDLINE
 	select VIDEO_NOMODESET
+	select ACPI_VIDEO if ACPI
+	select BACKLIGHT_CLASS_DEVICE if ACPI
+	select INPUT if ACPI
+	select ACPI_WMI if X86
 	help
 	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
 	  introduced in XFree86 4.0. If you say Y here, you need to select
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 69c68804023f..1fbbeaa664b2 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -28,6 +28,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <acpi/video.h>
 #include <linux/bitfield.h>
 #include <linux/cec.h>
 #include <linux/hdmi.h>
@@ -2188,6 +2189,47 @@ drm_do_probe_ddc_edid(void *data, u8 *buf, unsigned int block, size_t len)
 	return ret == xfers ? 0 : -1;
 }
 
+/**
+ * drm_do_probe_acpi_edid() - get EDID information via ACPI _DDC
+ * @data: struct drm_device
+ * @buf: EDID data buffer to be filled
+ * @block: 128 byte EDID block to start fetching from
+ * @len: EDID data buffer length to fetch
+ *
+ * Try to fetch EDID information by calling acpi_video_get_edid() function.
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int
+drm_do_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
+{
+	struct drm_device *ddev = data;
+	struct acpi_device *acpidev = ACPI_COMPANION(ddev->dev);
+	unsigned char start = block * EDID_LENGTH;
+	void *edid;
+	int r;
+
+	if (!acpidev)
+		return -ENODEV;
+
+	/* fetch the entire edid from BIOS */
+	r = acpi_video_get_edid(acpidev, ACPI_VIDEO_DISPLAY_LCD, -1, &edid);
+	if (r < 0) {
+		DRM_DEBUG_KMS("Failed to get EDID from ACPI: %d\n", r);
+		return -EINVAL;
+	}
+	if (len > r || start > r || start + len > r) {
+		r = EINVAL;
+		goto cleanup;
+	}
+
+	memcpy(buf, edid + start, len);
+	r = 0;
+cleanup:
+	kfree(edid);
+	return r;
+}
+
 static void connector_bad_edid(struct drm_connector *connector,
 			       const struct edid *edid, int num_blocks)
 {
@@ -2643,6 +2685,37 @@ struct edid *drm_get_edid(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_get_edid);
 
+/**
+ * drm_get_acpi_edid - get EDID data, if available
+ * @connector: connector we're probing
+ *
+ * Use the BIOS to attempt to grab EDID data if possible.  If found,
+ * attach it to the connector.
+ *
+ * Return: Pointer to valid EDID or NULL if we couldn't find any.
+ */
+struct edid *drm_get_acpi_edid(struct drm_connector *connector)
+{
+	struct edid *edid = NULL;
+
+	switch (connector->connector_type) {
+	case DRM_MODE_CONNECTOR_LVDS:
+	case DRM_MODE_CONNECTOR_eDP:
+		break;
+	default:
+		return NULL;
+	}
+
+	if (connector->force == DRM_FORCE_OFF)
+		return NULL;
+
+	edid = _drm_do_get_edid(connector, drm_do_probe_acpi_edid, connector->dev, NULL);
+
+	drm_connector_update_edid_property(connector, edid);
+	return edid;
+}
+EXPORT_SYMBOL(drm_get_acpi_edid);
+
 /**
  * drm_edid_read_custom - Read EDID data using given EDID block read function
  * @connector: Connector to use
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 518d1b8106c7..60fbdc06badc 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -412,6 +412,7 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
 	void *data);
 struct edid *drm_get_edid(struct drm_connector *connector,
 			  struct i2c_adapter *adapter);
+struct edid *drm_get_acpi_edid(struct drm_connector *connector);
 u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
 struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
 				     struct i2c_adapter *adapter);
-- 
2.34.1


