Return-Path: <linux-kernel+bounces-108824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6BB881089
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537091F23FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2DB3BBFA;
	Wed, 20 Mar 2024 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tw.synaptics.com header.i=@tw.synaptics.com header.b="Sb+QEN41"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2098.outbound.protection.outlook.com [40.107.223.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551573B799;
	Wed, 20 Mar 2024 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933068; cv=fail; b=uYa2gzScl2wIHNcUTy0O5TprrtSrDT3GjJA3fpRXv3X2HJs1OA53vwvyIXDJr5kMFw3ezFSSvi/KVeZK7nndqJ0MWtTpLe77sHVT+R5XnQlJhHjvtSWSMhcK723tAVdB4jy3ZL2Lfh3It9fZedwaX2Ee8ILj8WK2O5fFwvhKJeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933068; c=relaxed/simple;
	bh=cIMnxe7A0SA6CXnlQtdGqDib4zgRcVgs6baVSo22vuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZzBBr+dFDE1sZifuDAszd9Lzc880rkEM8VhBXtGeiYRO0fNOhztmKy8MxeSnLilBEpKXNg5NeLQ80KHqhLytxe3qSDQYPhODj6UjriqqYSLBOeGFrcQIYE/YGLJa/f+quLy66U2J5SlIBFf+vg38pVICFKHCnXtANuZ+xrgmtMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tw.synaptics.com; spf=pass smtp.mailfrom=tw.synaptics.com; dkim=pass (1024-bit key) header.d=tw.synaptics.com header.i=@tw.synaptics.com header.b=Sb+QEN41; arc=fail smtp.client-ip=40.107.223.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tw.synaptics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tw.synaptics.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZVbpfLleFU5H2FR3Lzrb8l+ckE28U09+aOw8irKicou9nvknPPlAgMEah93nw+OGL6FKZnU+tZdZVxpUlYDe062aTU54LBSYd+dEsrwgwLPQh+zuyPK59OnyTqWJnoweTNNwOb/vyQ53W/i2ZTvg0k6dX24B5DxgaWs55wwm8CYs7ZKVOPVdb/fPDo57SSLD1EImLCRg9Z/7V7yeaAbgCBWanPdf1Mg4uG8FoXhR3+8winiVofisSkFVo5ximKwL48th9ttKBK0XKIcguti7ctmSZ+qbw+RIfHJVTC2bJiWc0wlF+vLJydY4ebXSec25ciAQAJHfHLYaRH/TztoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zH8VcghEVxC+HBusf6dDYGSHgBxmCGek04JjrexznGg=;
 b=XHIgYXWzYYLwLu9FuJC3V4PWuj9zOUI5/LA/M7u0D+9sQ7L2kIWzj5QOoqUwJ/Kz/qwjKzF5qmKwE2jmj1wyury/rhGWBDd3aSANCzCtyEw1tsjQkQqr34cGNeF/qHVsLQ/Myh5sLoFX7RrDnIjg4TNWGbfcAxW1egs+AQYaV7iGkdCHyPzy9num9d6y7x7vB9jnoa3YIcNh5anhsW3KT1MscDYer8W0mwGj+5NVXE8li44JU0pKc7HL4kR/58Oc9m/MjpkoaoThojDTv17OZQ+yaZKS40IcXUc9FFHtCFPuw/TA5FN2GKNzOc+/rplRAjfNZZgDnux73uIvxR5+Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.147.44.87) smtp.rcpttodomain=gmail.com smtp.mailfrom=tw.synaptics.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=tw.synaptics.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tw.synaptics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH8VcghEVxC+HBusf6dDYGSHgBxmCGek04JjrexznGg=;
 b=Sb+QEN41fSqpgxlbbwMqZpnHtCqULTwUw4CBvt5eYDbAe9OwRiadrwkYknKHOnb8BnKKnDdjEhakWdRIH/R4Cb7kXCCQbPqW26HT8y6T6szxxDRyEnKZHetzravJIl1DmRgE2wLBKAqWqOxwT64a1YCdlm8tFpaAg6mihGgSRwg=
Received: from MN2PR19CA0048.namprd19.prod.outlook.com (2603:10b6:208:19b::25)
 by MW5PR03MB7005.namprd03.prod.outlook.com (2603:10b6:303:1a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 11:11:03 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::e) by MN2PR19CA0048.outlook.office365.com
 (2603:10b6:208:19b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 11:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.147.44.87)
 smtp.mailfrom=tw.synaptics.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=tw.synaptics.com;
Received-SPF: Pass (protection.outlook.com: domain of tw.synaptics.com
 designates 192.147.44.87 as permitted sender)
 receiver=protection.outlook.com; client-ip=192.147.44.87;
 helo=sjc1uvd-bld04.synaptics.com; pr=C
Received: from sjc1uvd-bld04.synaptics.com (192.147.44.87) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server id 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024
 11:11:01 +0000
From: Marge Yang <marge.yang@tw.synaptics.com>
To: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marge.yang@tw.synaptics.com
Cc: david.chiu@tw.synaptics.com,
	derek.cheng@tw.synaptics.com,
	sam.tsai@synaptics.com,
	vincent.huang@tw.synaptics.com,
	Vincent Huang <Vincent.Huang@tw.synaptics.com>
Subject: [PATCH V1] Input: synaptics-rmi4 - Supports to query DPM value.
Date: Wed, 20 Mar 2024 11:10:58 +0000
Message-Id: <20240320111058.601156-1-marge.yang@tw.synaptics.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|MW5PR03MB7005:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a7f38671-e9aa-456c-7a2d-08dc48ce6e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FREVldAgZgeznk+x+N6X2y4LxhX5+PaEEeGp4cR8+TR6jBtpbtF/vfZDFfsI0PZIelb+U0P0kNGurwH5PpwvjLFCYtGXM9ECqrF9ZncOG2nZd7Mu4fgYb3/lWZBKotwej7/GheQhgXTUX6n9hYfQ+XF39pxQ6Y217yrqv4DkmrZ36H7K2fk3tS1HGUtPDI+rQKHpBmfR71R5GChSFtEsq3wnBEqZiDjynkiM+OT5H62igcJKPIpn9NEb7yN6K5elFRKPfEUIrNLawWgWtIkBIHuUZnT2sH++mOsGLnhVK+ygMTrhUaPRyJ329mzKCFUHNOyNmcdib8POLi32T+fRDKj8Ztm7/JZx7qxCaqaemS9S0FHSflNPFblTl78kKdzVvQ1R8fkD4co66eeFVdjepF0tThp0TiucoHMVsqTz6DCO8KSp4FTVESB7nAHbMcxqTXItpM7Nx0KgAcoPNvRTnW4aG0P2IVkMuBqKiltm3fFiMUQ70hTUE+fjuBok6Uo8JHoAm9WD1009BruBiR2WhDx++ZRYjGIV5Z8kFcrqQ6SoMJ2GJ/NQBzsJ9+gZA5ndsSWAkT0GwNPIBO5juXb/jOEFoph2FW4drC7MUuXdTZKR+HW049Bm797cO3L+tlU+I6PC0f2gC86+suKZTYWVbmmABorXGscrAWUrG7XIfD22ASmLQlyiyntJRmlxpDzHKiOvPTo4snzEioQ5ONEXRBdQ4s/x1ydyOS8UpnogOR6qKlZcX6ItsENsM2rlzpn0
X-Forefront-Antispam-Report:
	CIP:192.147.44.87;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjc1uvd-bld04.synaptics.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 11:11:01.8498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f38671-e9aa-456c-7a2d-08dc48ce6e31
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=335d1fbc-2124-4173-9863-17e7051a2a0e;Ip=[192.147.44.87];Helo=[sjc1uvd-bld04.synaptics.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB7005

RMI4 F12 will support to query DPM value on Touchpad.
When TP firmware doesn't support to report logical and
physical value within the Touchpad's HID report,
We can directly query the DPM value through RMI.

Signed-off-by: Marge Yang <marge.yang@tw.synaptics.com>
Signed-off-by: Vincent Huang <Vincent.Huang@tw.synaptics.com>
---
 drivers/input/rmi4/rmi_f12.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 7e97944..6a7a17d 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -24,6 +24,7 @@ enum rmi_f12_object_type {
 };
 
 #define F12_DATA1_BYTES_PER_OBJ			8
+#define RMI_QUERY_DPM_IN_PRESENSE_BIT          29
 
 struct f12_data {
 	struct rmi_2d_sensor sensor;
@@ -73,6 +74,8 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 	int pitch_y = 0;
 	int rx_receivers = 0;
 	int tx_receivers = 0;
+	u16 query_dpm_addr = 0;
+	int dpm_resolution = 0;
 
 	item = rmi_get_register_desc_item(&f12->control_reg_desc, 8);
 	if (!item) {
@@ -122,18 +125,36 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 		offset += 4;
 	}
 
-	if (rmi_register_desc_has_subpacket(item, 3)) {
-		rx_receivers = buf[offset];
-		tx_receivers = buf[offset + 1];
-		offset += 2;
-	}
+	// Only supports to query DPM value on RMI F12.
+	item = rmi_get_register_desc_item(&f12->query_reg_desc, RMI_QUERY_DPM_IN_PRESENSE_BIT);
+	if (item) {
+		offset = rmi_register_desc_calc_reg_offset(&f12->query_reg_desc,
+			RMI_QUERY_DPM_IN_PRESENSE_BIT);
+		query_dpm_addr = fn->fd.query_base_addr	+ offset;
+		ret = rmi_read(fn->rmi_dev, query_dpm_addr, buf);
+		if (ret < 0) {
+			dev_err(&fn->dev, "Failed to read DPM value: %d\n", ret);
+			return -ENODEV;
+		}
+		dpm_resolution = buf[0];
+
+		sensor->x_mm = sensor->max_x / dpm_resolution;
+		sensor->y_mm = sensor->max_y / dpm_resolution;
+	} else {
+		if (rmi_register_desc_has_subpacket(item, 3)) {
+			rx_receivers = buf[offset];
+			tx_receivers = buf[offset + 1];
+			offset += 2;
+		}
 
-	/* Skip over sensor flags */
-	if (rmi_register_desc_has_subpacket(item, 4))
-		offset += 1;
+		/* Skip over sensor flags */
+		if (rmi_register_desc_has_subpacket(item, 4))
+			offset += 1;
+
+		sensor->x_mm = (pitch_x * rx_receivers) >> 12;
+		sensor->y_mm = (pitch_y * tx_receivers) >> 12;
+	}
 
-	sensor->x_mm = (pitch_x * rx_receivers) >> 12;
-	sensor->y_mm = (pitch_y * tx_receivers) >> 12;
 
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: x_mm: %d y_mm: %d\n", __func__,
 		sensor->x_mm, sensor->y_mm);
-- 
2.7.4


