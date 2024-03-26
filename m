Return-Path: <linux-kernel+bounces-120004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFB088D000
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CACB4B24939
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7060913D617;
	Tue, 26 Mar 2024 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U1aHYFy0"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B80E12C7FF;
	Tue, 26 Mar 2024 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488429; cv=fail; b=ePn5ZJEmayPIWAjMtcDkqtpprr+psCYSuhW1gFqQFllgmmfXU1NvUIaMftTiha/1fO1FpNJAzeAOsKWd5wBWLADkEIevwi2Y8rizqbBftnYFRYeQEOgtgbni00+5roR2c1uPxmAUimigXK3eT3OO4MMA54SNimcwVVJkyDz9xDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488429; c=relaxed/simple;
	bh=VweSnMaPrFBLGGcsVKRBRPEK8i7INsf2+b4+9QA5Iiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCbZ0EtQB/NwJ4f75yOxlNoFXiwXXk391pgLeZB8ldSMJOzKXxgwPRHsGqmYEaxx8gxeDBlEeR7oKQPN5stmSrlkrNY5Xdo9m54h2KjP/rFYmIlvT10HzfVmYmmTXJeoCc8eN0YPExVjvjfO/GFuIqI3uPPs6Ko8GrQ7006PRf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U1aHYFy0; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbrPyh47bgvnhRRL+ciJs8xXBxGQjURursWOF1aLGwhtnoj+hwNEDOBgO0DYL8VFRrIxAUZyIkMMpOHu0Zwilke9HHqG2W/4CttDk+L63JPkghdsBb1BihOuVW3TWVJpDCHdh2aY75EzHMsLlM4lbu9gFrOHbNCcgALeYVad3NyEuLC2l2zy5K+RZyrxu3b+DbLLqzgk/pCouc0I1NhUJyjLtlM7/jVx7Yt1G71bpu96a8+pPuOg1kvEs99ee23WaPywIb4Y39VDOqwiIfKeMK1dJkWzybkXYJ4AlwwTHuRuQt7DSi/L4VhMAJfS0eNoy2X7QCDOSWE1+/xpZERkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PXqOVA6QIJM5KLA6C+kssbbBOc0vpWoVGJBL1hNkgk=;
 b=LnHDvgCwrdlKS+grbJWc34DrpVcDXLPioqrbcdE8QkH497gaPyEiKBUa+gOFtwZDcL6BDkqvw8lQYF06p30ePj8xnSHQTVQLMcbco8W268TGtzQnrhZL7g7qZdPWVJryIfLixyJ/xRJuFLdDwkhTz2KyicEboCOnjTakEFEM4oeguW4P0txhmafnBu7A33j+yW6+XadpDZdLhHQT76+jXnz6T2p9j1nDSUhynlGyySalvi0lBLL8Kj8gOCCHEjrPKWpTGxWsXV+4G+L5mqfD+eIR8UkXb3AZWgxb0RUm9tUX7sKVHfQeq+vFml5tt9S2q74lCaLXQ1unDyBB6d5gPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PXqOVA6QIJM5KLA6C+kssbbBOc0vpWoVGJBL1hNkgk=;
 b=U1aHYFy0yDlfUeCwXB5Qa1WoZycnLk2U0ZmDLw8yMyQSTtDoyt8744moH1CEUPCfxokUw9T/qDVU1efP0XhN9v6ahSnue2HU2hzVAWgxkVg2Z3e8ZO+biiH0izkKSOcH7u7+DnR5q5GLQarezZwmGUBP9iO3kZ+vQq7Z2yWVhtw=
Received: from BN9PR03CA0579.namprd03.prod.outlook.com (2603:10b6:408:10d::14)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 21:27:03 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::25) by BN9PR03CA0579.outlook.office365.com
 (2603:10b6:408:10d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 21:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 21:27:03 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 26 Mar
 2024 16:27:02 -0500
From: John Allen <john.allen@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<yazen.ghannam@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, John Allen <john.allen@amd.com>
Subject: [PATCH 1/2] ACPI: PRM: Add PRM handler direct call support
Date: Tue, 26 Mar 2024 21:26:39 +0000
Message-ID: <20240326212640.96920-2-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326212640.96920-1-john.allen@amd.com>
References: <20240326212640.96920-1-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1e35a0-40c3-4fbe-e8bb-08dc4ddb7b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HIYoPfOZnNlSEz5tEGJ6Nk5Q7URKX2wxNv4FYihYajx04gkCUX6F2TZxqkGmwOfpV1NYm4tEDWCB2TC+RcsHWXQQYMvuMWnylcJ7g9vdLicW/wjvppXscdHDzRkONSzBkkqleDM25UQsFMHf9w0TMZ8nHf+vAJnfainYcpHmQbiUfv3Hnmt3seijj1RHhKyXzlnmO9gihBxt2eLoufyHFHjigSKZM+V+J714kFLTIaSZ02TpSk5klf1Mwom8bkfkTGLVox4twa3cFtq/yww8GJ4Ibx8F3cBr3ZtgwnmIcA/EFLdULLqBHnWk3ZgwgJrFEac7lNnCzGiEDlcifqGSVgK9QGXBFobv8YmPf4c9xKWpIMtaLFxxtpUDD5s+4ZXfkDo9oOv0ggOnd96QP2PZkda9I6bBJEMoF6V9O+t6/TNG9TFACg60t8QIHprALG57sgd6Fhyc1/6hiY2++iQGDc44PayUpd1qAODcImEHW+DfKHB2HZvrr/3dwk2l9v5Ux4pV7LI1xX4lro6U0Xp6Qap/o7PBW/4L+soxN2eQNlK4ca/eLem+LFYWngJT3eIv9WaqN1kZ7P/yxMdoA7+u6n2foM/ZCqAcKajtNg9Cp8DgbZzb3IytvqQQKB3VlRbURgfU1s5Y5ICIhTrKbCRIy7t+EVIT/Z3QxWjQ4AMCHaGmMX9enNxDLTFNmQuHPjvff+PaQpuIRYErcQqGybpClKBAz2zZSW+VcM7fMl0rt4NVTwTzl6S482Mi0DS7QKI/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 21:27:03.6137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1e35a0-40c3-4fbe-e8bb-08dc4ddb7b0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017

Platform Runtime Mechanism (PRM) handlers can be invoked from either the
AML interpreter or directly by an OS driver. Implement the direct call
method.

Export the symbol as this will be used by modules such as the AMD
Address Translation Library and likely others in the future.

Signed-off-by: John Allen <john.allen@amd.com>
---
 drivers/acpi/prmt.c  | 24 ++++++++++++++++++++++++
 include/linux/prmt.h |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index c78453c74ef5..9e548426cc22 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -214,6 +214,30 @@ static struct prm_handler_info *find_prm_handler(const guid_t *guid)
 #define UPDATE_LOCK_ALREADY_HELD 	4
 #define UPDATE_UNLOCK_WITHOUT_LOCK 	5
 
+int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer)
+{
+	struct prm_handler_info *handler = find_prm_handler(&handler_guid);
+	struct prm_module_info *module = find_prm_module(&handler_guid);
+	struct prm_context_buffer context;
+	efi_status_t status;
+
+	if (!module || !handler)
+		return -ENODEV;
+
+	memset(&context, 0, sizeof(context));
+	ACPI_COPY_NAMESEG(context.signature, "PRMC");
+	context.identifier = handler->guid;
+	context.static_data_buffer = handler->static_data_buffer_addr;
+	context.mmio_ranges = module->mmio_info;
+
+	status = efi_call_acpi_prm_handler(handler->handler_addr,
+					   (u64)param_buffer,
+					   &context);
+
+	return efi_status_to_err(status);
+}
+EXPORT_SYMBOL_GPL(acpi_call_prm_handler);
+
 /*
  * This is the PlatformRtMechanism opregion space handler.
  * @function: indicates the read/write. In fact as the PlatformRtMechanism
diff --git a/include/linux/prmt.h b/include/linux/prmt.h
index 24da8364b919..9c094294403f 100644
--- a/include/linux/prmt.h
+++ b/include/linux/prmt.h
@@ -2,6 +2,11 @@
 
 #ifdef CONFIG_ACPI_PRMT
 void init_prmt(void);
+int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
 #else
 static inline void init_prmt(void) { }
+static inline int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer)
+{
+	return -EOPNOTSUPP;
+}
 #endif
-- 
2.34.1


