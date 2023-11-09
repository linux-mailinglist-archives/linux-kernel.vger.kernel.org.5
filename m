Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4E17E6419
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjKIHBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjKIHA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:00:57 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397622D55
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:00:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bbx6FDmrDyRPwGkxNwwrLU35eAxQnKfEvoywHktQsbc2w6Gtv2+IRb8PXhWEEIRF+YW4NUg0Xo9TC5EzGsrktMl9+1rQuvsp4Wn8nEhxqp44bEP46ScDdi/ndria61Mi3r4rBUoXVIlyKWurXR4vOk9J3RsRGtq94+X1RmrUV5FI0EB12wiCMQISPHFmDeoG397C88T3XvFzbHpFbdVBHQVazW8J2gk4+9HQUkBmiOEHrECWpp9AJFlWbm7TYLvQLGXQVjl5yRbCGdIx0F6IyUD9p5HCZpWwSxVyIi8sOPSGP3fmuSNCJ5me6ooNSVYDHepwdS1sBel5S0u5qnZknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi4pLIJ3WcTHcbA19OTh+HnnApBV0zhe5s77UMw2zoo=;
 b=BhJtmeaQAoWKLpIPuyxZyrLuZW5LM6T6Fg60txNDEk1PwPqVqq8daQeid81FjyqvrHB5TOIZgrluagbAPViaITuRVkgK/FW0ZtcNJmzD2pLqMfuz5q/nGo9eQkZIvvNMCEPPdLVskgR+TSLn5GznXLvoL0KmZ0wcPEN5fHrRImRVOq9irvZtyvtWAPRSNTeCVP9BZ56h+VATMd0DiRnptAptITliZ2ePVqoygVju18hJizQYqfxISbwFyx17o5PpZNP0DDWcx8qwJQPKmrDoIMOVOu+oymu6nC7DCSqVrv9OvUwu2Uge2u4TCZdvUIgg2GCGiH4/pJaQf74Yj/4fog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi4pLIJ3WcTHcbA19OTh+HnnApBV0zhe5s77UMw2zoo=;
 b=1y9hrVi8oerAHrfPjMzQgiRdHKzkMRpeQKKBIUnN6iOoOnTXFfJOnPYsEyEmMagirMjBvKUkR9XEZssYzY9+My5Apo5zEL18+FaHpziosZL1Sf06iuLVMXNr5w1Yt5X/Yis4p2xTYGuxo/Ozl8xWTUZHJVhP94aApNPDdpq4NXQ=
Received: from MW4PR03CA0082.namprd03.prod.outlook.com (2603:10b6:303:b6::27)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 07:00:52 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::26) by MW4PR03CA0082.outlook.office365.com
 (2603:10b6:303:b6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 07:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 07:00:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 01:00:50 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 01:00:49 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 9 Nov 2023 01:00:48 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <tanmay.shah@amd.com>, <mathieu.poirier@linaro.org>,
        <nava.kishore.manne@amd.com>, <ben.levinsky@amd.com>,
        <sai.krishna.potthuri@amd.com>, <marex@denx.de>, <robh@kernel.org>,
        <ruanjinjie@huawei.com>, <arnd@arndb.de>,
        <shubhrajyoti.datta@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v4 4/5] drivers: soc: xilinx: Fix error message on SGI registration failure
Date:   Wed, 8 Nov 2023 23:00:20 -0800
Message-ID: <20231109070021.16291-5-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231109070021.16291-1-jay.buddhabhatti@amd.com>
References: <20231109070021.16291-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c77f09-82a7-4e55-18f0-08dbe0f19cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBSP5SxqVRISGghTpV0jaW8OUkyVNY4DzQkiuq2lw2AJpsKCHiy3Y/jis+kD9HOElfBfNtHnGHMmFv3KxwvQp1fI2xtvuJKP4D+syUae3g5+liTDKGrzISwymVIzcO3Y+VuwI/GLx1ejjpZQ2iTzt1FBuax5iePPo8Ajv1WRa3iHDL8bIKSTR6mJRF0cXfzGFScU1c1BAdlF0Hm+0lm/P2wIT5TomCRbf8vZGjAdyNPO4Zcr/BPujnLEcBdQ2ZO/xH3m7WRjYwEkqarnrl983qAmBWkIq18Aa33epOKGvqhPdDozcKWxZMS+A2pnwngq2cqej8qhLRiFaqDa1eG3cvEl5Z++WU2c35VKqo7MU18ScaJevKG/oqbf0/GnkDqybFIoOm9WLlaYVQmMKHiEYJ7gX2tarOd1RfQHooizRTv+CV81O8hVbIMJug5OqrqKH11AYhQHRDTFaOsggL+5fmajfkfsVdI5UsfnWLmYKrWLa2cFD13MiTOEb+UV6wTMC123zXWdCclq0hrtRsMrlU9cS7rZEtC64K6eohWTmdRgM/JBuCA3YEwjbX4zaDqMwh12rkR80sE/7llMV7z6gWuWEcjsttH9foph1RKyPxXTUL6qz1a/1PVUb5x2IM+kwD6FGOMpBHvpVB9BYdpq/Cwmfso83OMBggYp9cJ1+p1p//5/7RU6TIDsR4J0sKhnI7rGaKUBj4tAYYZ8UFn+i6+NJFU6qP+QiN4qNYJLifex3wvZ1tSZx5LuvkR96uMb97EFD4qlPFIZoyfyZwr4fv5yoc/VUp4n4hxKvpAXz864WXNFyRG65yk5vrkrKnOYGZiTO7L/9N4NNpjq80EZAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(478600001)(921008)(82740400003)(47076005)(36756003)(36860700001)(81166007)(356005)(83380400001)(86362001)(2616005)(110136005)(54906003)(1076003)(2906002)(41300700001)(70206006)(26005)(70586007)(44832011)(15650500001)(336012)(6666004)(5660300002)(6636002)(8676002)(316002)(4326008)(8936002)(426003)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 07:00:52.4773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c77f09-82a7-4e55-18f0-08dbe0f19cda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Failure to register SGI for firmware event notification is non-fatal error
when feature is not supported by other modules such as Xen and TF-A. Add
_info level log message for such special case.

Also add XST_PM_INVALID_VERSION error code and map it to -EOPNOSUPP Linux
kernel error code. If feature is not supported or EEMI API version is
mismatch, firmware can return XST_PM_INVALID_VERSION = 4 or
XST_PM_NO_FEATURE = 19 error code.

Co-developed-by: Tanmay Shah <tanmay.shah@amd.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c        | 4 +++-
 drivers/soc/xilinx/xlnx_event_manager.c | 6 +++++-
 include/linux/firmware/xlnx-zynqmp.h    | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 125bf6ad28bf..ff57dda669c7 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -92,6 +92,8 @@ static int zynqmp_pm_ret_code(u32 ret_status)
 		return 0;
 	case XST_PM_NO_FEATURE:
 		return -ENOTSUPP;
+	case XST_PM_INVALID_VERSION:
+		return -EOPNOTSUPP;
 	case XST_PM_NO_ACCESS:
 		return -EACCES;
 	case XST_PM_ABORT_SUSPEND:
@@ -396,7 +398,7 @@ int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 	int ret;
 
 	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, NULL, 2, sgi_num, reset);
-	if (!ret)
+	if (ret != -EOPNOTSUPP && !ret)
 		return ret;
 
 	/* try old implementation as fallback strategy if above fails */
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index adb875f89829..27a8d89a0a09 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -653,7 +653,11 @@ static int xlnx_event_manager_probe(struct platform_device *pdev)
 
 	ret = zynqmp_pm_register_sgi(sgi_num, 0);
 	if (ret) {
-		dev_err(&pdev->dev, "SGI %d Registration over TF-A failed with %d\n", sgi_num, ret);
+		if (ret == -EOPNOTSUPP)
+			dev_err(&pdev->dev, "SGI registration not supported by TF-A or Xen\n");
+		else
+			dev_err(&pdev->dev, "SGI %d registration failed, err %d\n", sgi_num, ret);
+
 		xlnx_event_cleanup_sgi(pdev);
 		return ret;
 	}
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 96f3d949afd8..815bef3f0bd9 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -172,6 +172,7 @@ enum pm_api_id {
 /* PMU-FW return status codes */
 enum pm_ret_status {
 	XST_PM_SUCCESS = 0,
+	XST_PM_INVALID_VERSION = 4,
 	XST_PM_NO_FEATURE = 19,
 	XST_PM_INTERNAL = 2000,
 	XST_PM_CONFLICT = 2001,
-- 
2.17.1

