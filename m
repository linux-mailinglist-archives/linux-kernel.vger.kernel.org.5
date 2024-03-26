Return-Path: <linux-kernel+bounces-119929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1A688CF0A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DBC320715
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BB613D8BD;
	Tue, 26 Mar 2024 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zs4xrFeD"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14313D513;
	Tue, 26 Mar 2024 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485188; cv=fail; b=gDatAh+xRZbNbihTXk1F8ATDGqqaScynNCSYljxF7/IA1lWGpo/vnHSuTFGgXDHZJd8xDQygCQ39r4QmMFjdpzXzPlW5N5jNyx2Ma3ZHAiOCQnrj+5lGgii1Z6n9R5yFkSiMJBY6ovQbrK2CWIuKE+SYs3h6VNT8xVumObzsduY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485188; c=relaxed/simple;
	bh=KWbrCl+PZ3tLX5BxiE1dr0dSmkQqfrKfUTmmzX2WA1A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lI21pDgc2FJWsVjkt+kAd5TDSLm6alRkfnoQiqY6ce7KRIqbXEfpmMxJAXXtJrl04nsoBy0e9D0rZJCuo4ubo/RaFHmmBH5x29BLLVoLS+vReeBJ4xls1RxxZcN/5S5iiCaFCHx/fRCGDuKbo3qynyqVC7USLkCo/GRZvape9eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zs4xrFeD; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAOz0vFO6Fi/T0Pu60drSpTV1bB0lJ/8LzIFYteFcx93J1hKhh1cRyxEtw59iSLTVlISytiY24tQUIjF8upWQrePxP1BLg0Qi7489yaN64KSzXwYaSbDARMzOe7u/qFXuK9Dksp6V19NQgFsdc7A7g3Cau4BWlu18de5/bDK76kGZlhj1D0YAVdENKi9Li3kDIL5z0uHbJyrTGh0aGjFibp3kY8ieTnID8n8vtsRkrzlYFPP981KGi6/zSFJwiLymYJyOJrZx5fMeqA2sb5+TeE8vXSiZzVMelWEFf2xpVhe+4AFTDMKDa0vY9mM1KwTKE9WDc/mOZyqCvzQvlnDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfEkF9NVMBpQlwcgRuR3dV+4dn6yy6SCJE8LBVFU6LA=;
 b=Vdn3y+sXN8w/glD8SDcy3SHQrpdvQuUT9JpxBQz+V92hOznTdb0PiHnX1LLSMmBwFGj8Se5g2HGq/tNME+NEIytYSIVEYFW2fuM1c+ra9l5l3Ay94pFrFqQc9HBlqlphAQWfEMxw5FzgWkRKWUSG4fJtCzYKoXPb0p+6R0AFWQG0aUAgxSK9BIIl8jA5uIrzQQAhM0BLRRYGOhQMmUDuvieueoXSqwcj6KBJJQH0sem9AUcXZP3J361mgh1j+0pZaS/S1EoYrCsinfQyqQX//W87Ywvw1sgn5iD3WISpsXGhin3/C/zGG1afjTogxAV3QcGQh5Nk6t3C1/buven3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfEkF9NVMBpQlwcgRuR3dV+4dn6yy6SCJE8LBVFU6LA=;
 b=Zs4xrFeDz7xzBwg62PruvrIq/Pa32MLdimEBpa+XD+FhyE+SfHC9VcDzpdEhrQUQMc07XhQVv0q0LuQ9dPm99sBzKm+rbTVtp6ZHvJyevfnc0knshEzyRa/Dvmm36vaTVsb7x17AiU16YAoy5uJjWgc7D7zTv/zd+MtnUiQqJb0=
Received: from MW2PR2101CA0034.namprd21.prod.outlook.com (2603:10b6:302:1::47)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 20:33:04 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:302:1:cafe::8e) by MW2PR2101CA0034.outlook.office365.com
 (2603:10b6:302:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.8 via Frontend
 Transport; Tue, 26 Mar 2024 20:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 20:33:02 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 26 Mar
 2024 15:33:01 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "anthony s .
 knowles" <akira.2020@protonmail.com>
Subject: [PATCH] RAS: Avoid build errors when CONFIG_DEBUG_FS=n
Date: Tue, 26 Mar 2024 20:32:52 +0000
Message-ID: <20240326203252.2699278-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: ce771791-5b68-4406-421d-08dc4dd3ef35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IEl1ETi/zayBRF/fF7dLfRS5U90XPXkBJRiSeF6qMXH7b5OcsjQ2WFxmOPWBSu87WD5Q5wuHQ5QGAKyeCjdmL272U2cboLRpeJDhgJMyp3C9VGi7aCNX4nnMHzG1/duUNgZsxafOTz37F1F7n+jqjcC2/SsFhX+NpobjWEuI4vXLQnykhPg++B9hZN2EFltYx5Ck5VifcGM/RRbE+C5y2M7dl0mcN2T8zqaETYVthQdD5GLBZCDuyj5WKzPQ1lO1lUUsJHX6FLh82KYK5dn8GnqFUyYPcj2dV1eryvsFU1k+kOGJFZf/DzXNHdwHjE3pbOZXMERD6dOvXYYE7LZW9O/UESC6XIfLp/Jiw/HjsC7gLoKfrLPOv4yBxPveRJ6nq0WfG87G9T9dTrCDR5YZoIcBBu+NeY0+FY33BHHJnA5iSetfImh64J5r268PM/47VwHCsRkO1uX0aSytOGlcvIf53m4sPf/ypK1tSGYto6TcBrJj/j1miP00F0f9vXmB8m3LVuGLDT7cmi566Fky7YFlOethHPzhVE2amBeU41OVZm3IPlQR00YYaSgH9o7YsZB6B0ZABqOfysCVlNcv5H8Qe+kGesegxerkwxAGVL2ItQIHb08JqU4BN0uXPoYq7Wr1NaHcWKyVLdqnT9JcM0D0DXk6+E7hT6FNykHx9w7RWF+vB/tEg12F1jCOKCLPH8h5JxsIxp4a7IvnD/Bb3g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 20:33:02.5044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce771791-5b68-4406-421d-08dc4dd3ef35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472

A new helper was introduced for RAS modules to get be able to get the
RAS subsystem debugfs root directory. The helper is defined in debugfs.c
which is only built when CONFIG_DEBUG_FS=y.

However, it's possible that the modules would include debugfs support
for optional functionality. One current example is the fmpm module. In
this case, a build error will occur when CONFIG_RAS_FMPM is selected and
CONFIG_DEBUG_FS=n.

Add an inline helper function stub for the CONFIG_DEBUG_FS=n case.

Fixes: 9d2b6fa09d15 ("RAS: Export helper to get ras_debugfs_dir")
Reported-by: anthony s. knowles <akira.2020@protonmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218640
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: anthony s. knowles <akira.2020@protonmail.com>
Link: https://lore.kernel.org/r/20240325183755.776-1-bp@alien8.de
---
 drivers/ras/debugfs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ras/debugfs.h b/drivers/ras/debugfs.h
index 4749ccdeeba1..5a2f48439258 100644
--- a/drivers/ras/debugfs.h
+++ b/drivers/ras/debugfs.h
@@ -4,6 +4,10 @@
 
 #include <linux/debugfs.h>
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
 struct dentry *ras_get_debugfs_root(void);
+#else
+static inline struct dentry *ras_get_debugfs_root(void) { return NULL; }
+#endif /* DEBUG_FS */
 
 #endif /* __RAS_DEBUGFS_H__ */
-- 
2.34.1


