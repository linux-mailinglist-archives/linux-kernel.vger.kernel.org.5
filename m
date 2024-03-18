Return-Path: <linux-kernel+bounces-105913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32D487E651
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0291C21800
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62DB381D3;
	Mon, 18 Mar 2024 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2XYYnl5C"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101A2D05B;
	Mon, 18 Mar 2024 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755357; cv=fail; b=AURIM1NJYBmnlAdz38S6QJfAQMY6EC4EpUXkItonjuXOiP91rZPFpqxSPPVwvlC3zKRdt74iFZvdVCIm/HwnB670ACHRanbIQ0OfXTbNrCVfaG0V07WZqygty/Tzj6Qx9MDtGxTZ3durS5abiAUlfKSfrn21ua4Ol9DNtGqh/T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755357; c=relaxed/simple;
	bh=oUsCTLS81tnEaeLA8CnwR3jnc4v4JZvRlfYO+nGnqrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nM+poQG8iAUacsoxsfL+0LS9IjdJ2x3G3grQ6KO930cmjdQ1+UfNN4KXFPSG7/MvP8TXCNKvf7o7iaLnfLPUFYawcrQU2g5EhPjHYGCTPJhX4pYT9/8ljvWx3gHBr9TP7J9qzoDqXykkvzy1ewnIJ80DNZKA5arRZXfOL241OCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2XYYnl5C; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7YPlcJBinOHb7l/FV5gNXPPpAiXJQYPxolRjzzN/uuFCPkasI2ncnxL5MJ9N5Xysnjvk6K2yvxgQnsYnZwgChQuMQVROaeJGpQmg13DSrWZ8Ngg8CcevGvNrOYjP139nKGFCzlMJ58kSst0iaTRujWf7okObVXdkm4euM/pJhgtIR/9uhrjlRvXakKjKokzJolOIrXaDFuUfT8s9NZ+jpHPfS3yVMd8OobScfXA0sibtI8v4FqU9uT8IFzszbBziU8KvnwdCB4D1m/nNXhrzsm4d8gJGpal2QSBLWog9EfZgzWx16c5D+9AeOL0nLWZcCUoPcn5KDS1rBmtVrSP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcnNqZN0Q2o5ao0YuIpHgjFGfQ/tZ7BDDZmMPr4XLac=;
 b=OQIYL62eBuy1m9LS/m8rRicM3R9NUUgsTsX/2bRtvb0BqKztKK8TIbqxUvYSb83YojiLeYrwBHilZwtmecTBEAgG0+QEtm3xNI1KYF5t+ihf1Tn84rwtwFXXlS0Xziq5HaTQPzDrGIyMUha7JEs2r9XCZVDE7V8FifMagDWG0gwuyBuQ9Z5itPWSQ/O6pU8VoS0MzAQNPc52pExgxBUX3IFmieIxHSWuYMwvhutwLlg+jMZEjG7v/15VNi5RAx0kcOLv+80EYXM6ZPYZneE6PbNgGl8vF+uEkbWzbE6q+4cPHjEQhpsttngyzUljdiiabaZTU9WWMLvUK9EX31KCYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcnNqZN0Q2o5ao0YuIpHgjFGfQ/tZ7BDDZmMPr4XLac=;
 b=2XYYnl5C48Avri2TWMBVmIiuYvHpzkPZXiNpDJrznWCoBBC2kv2g1FzbZ9M96agNBc8ZYKV4hIFlDs1jdohjvgq31Gim+oP25TSiCAtuP93tFQ+xHUJdnHkNU5XUEdmd+Ut7t5+6O1TD9VTuOJGz1NjnAqWX+oe8emKGmIVPI2c=
Received: from SA9PR10CA0024.namprd10.prod.outlook.com (2603:10b6:806:a7::29)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 09:49:13 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::7d) by SA9PR10CA0024.outlook.office365.com
 (2603:10b6:806:a7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Mon, 18 Mar 2024 09:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 09:49:13 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 04:49:09 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 7/8] cppc_acpi: print error message if CPPC is unsupported
Date: Mon, 18 Mar 2024 17:48:26 +0800
Message-ID: <da69793f5f9f2e4d110ded24026ecee0dd3d92bc.1710754409.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710754409.git.perry.yuan@amd.com>
References: <cover.1710754409.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 311e2ec4-b580-4e3c-057e-08dc4730aafc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T6PGxSMgAjm+QBaj1nIOhq88NFQk4NFKk58a9aDjSM0KkWpBbN35jVjk8zHnf8JmMgM5Gg08Zk2JRY/hAVI5tS2As9z+0XOK+eUZNK5I460JRE1ycviS9nNUPRE544ZVeR6+pUU4uX0cOp/YDSCE0SlUaD2JyZRB/yVSUkmYaF9F4/ZVEPHy5RxYw5ztaTxFvl5AWApzcZ3LztRQZzHCD66Yny1o86CmqCkMEnfJBp3lNe4R8xkgLDzY0R8TzLY2AnyLNd9GUrjVVbeSc10v662X3ma29SO1vQeLm3Zu+lF5Dx4D7BsfQjbJwAG7agDFgG0GI3wff8QZ7KMzUa0F7pI9Ujbu/dD7lodTVQkKr4ybfLAg2gcpY6nmw1NrASLeUmj0jJS4CWcMUtwtyZl7DIAausUFuOHZh8XfN8rHUaAzJXity5MBOUh4S5lANuEMRPqXw8AkUr1KbhaHpCDFcfZI74Qd4g4XSBl85tufzyGBadUl9XGO+fJqL6D3NLes7NOiT87lfzt5UW6TgMEE7DMU7dGnaQv3QMGlm4u3ORKr3qAAsqS1xLPCpS/MjoSnartER8fzAew9rV0dc/fwOjlwrY/2IN2qbJ9DOcAQjIVspmlCQ5x461U3YnOronvmXfp+XxOEud6WLBNMtbk9zeTz2a0u4V2xvJ33aK/rap3UXdYFEzrN3x8ML3kieHpgWi9tYXWE7rfzmdOQRvZMlT+LwU6x8xrs4vjafdPfxpyomJNJEkSdt4mVZBqmu0py
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:49:13.1788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311e2ec4-b580-4e3c-057e-08dc4730aafc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128

to be more clear what is wrong with CPPC when pstate driver failed to
load which has dependency on the CPPC capabilities.

Add one more debug message to notify user if CPPC is not supported by
the CPU, then it will be easy to find out what need to fix for pstate
driver loading issue.

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

Above message is not clear enough to verify whether CPPC is not supported.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 4bfbe55553f4..3134101f31b6 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -686,8 +686,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	if (!osc_sb_cppc2_support_acked) {
 		pr_debug("CPPC v2 _OSC not acked\n");
-		if (!cpc_supported_by_cpu())
+		if (!cpc_supported_by_cpu()) {
+			pr_debug("CPPC is not supported by the CPU\n");
 			return -ENODEV;
+		}
 	}
 
 	/* Parse the ACPI _CPC table for this CPU. */
-- 
2.34.1


