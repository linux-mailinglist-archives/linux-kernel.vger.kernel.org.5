Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CB08133A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573593AbjLNOyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573579AbjLNOxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:53:54 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DBD11D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:54:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ax6IIrA5tZIKgDKM+LiWqsRx1rL6boFEHXXWh3PPQ/qXpHn0qCx+3BvwGgwCDXrOiMjxDg5M9VR4BhHvdv8f9poqegJR3XXfyleJb1JUi4ypnnvyJVPiPy1l6pP22Oon6a1pw3tSGwIgG65YZCYD+iAR5Z5dz4RZUNApF+aih53ovpcpFG3Vk67gQ6qKI6VVe3IMT7Mt9dbaFpfYJ+SJx0yoPQjb3ZZQB+3+NbmqdpA4FmsYNPrbcerqlWDC04MPt6Gm3vz0EF1XqssxpwwH/5KxpsABR3WSpmkrPuvGscicUCEMNuHtV9DX33yAOfHsJuhYOJCEnnlGhGJrbS51Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxANObysrkI8UdK47ibHMIjQZwCQwiruiHAAKrv+5KY=;
 b=JnsqsFirbK1Ze4mgtNJRSBHD+oFoMhnJIlMB0Dy3zfFJKkYtLPmXCS1CqnC+zWY/guBNDL5X+fhQ32l6/qpgWS3NeItXzbHDQrrv4gr4p4VaYvo4AsLZjC3m6K3554MVJCsvvECwVZdSZu3EbP3hKJfBP3OYj4sRWumY/tYAl/jrGTyLB3STRTf0oByhu8YPHOJphtxEpW/bD1o2ZBOA1W3oL8tJSKzH1guJ8gODjvHsLb3sUOR708Vo/sPMoAWrJzQ0wqY88PySBBFJRwgbxiK6ngWbmj60NDITworr/pwwgqGgi79aUHvI7SR1mYJS9T1RmEqYZ4jhwnbLLJU2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxANObysrkI8UdK47ibHMIjQZwCQwiruiHAAKrv+5KY=;
 b=j3rEjgVtJ1kirb2ivezzEIpauXNeXxobJojU9FwZ9BBsDfwClxGjdswq9EVClmitQcpJr6dlt7xMA/IUzUQiInh4Gtv7l9vJzgqo76KIFuvSENe1lwmzSz3jXnV5xbhgsflZgFfk0FNNHtUFam+BiIp75iAolFc46AU6nS0XTto=
Received: from BL0PR02CA0060.namprd02.prod.outlook.com (2603:10b6:207:3d::37)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 14:53:57 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:207:3d:cafe::fd) by BL0PR02CA0060.outlook.office365.com
 (2603:10b6:207:3d::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29 via Frontend
 Transport; Thu, 14 Dec 2023 14:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 14:53:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 08:53:55 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Dhaval Shah <dhaval.r.shah@amd.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Marek Vasut" <marex@denx.de>,
        Nava kishore Manne <nava.kishore.manne@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] firmware: xilinx: Remove zynqmp_pm_pinctrl_get_function()
Date:   Thu, 14 Dec 2023 15:53:48 +0100
Message-ID: <e52a415a004e28a43e6d08e9e22d9e8fef3737df.1702565618.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <6ccbffbafd1f0f48f6574d5a3bf2db6a5603fdb0.1702565618.git.michal.simek@amd.com>
References: <6ccbffbafd1f0f48f6574d5a3bf2db6a5603fdb0.1702565618.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2588; i=michal.simek@amd.com; h=from:subject:message-id; bh=GL86RAjPMm4FBS16W+zUapn4oj17oA3Pc3FQcueHylw=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtRqsR/T1BX/WS6eG/qx94DhjZ7cg0UXJUoypDs+CBxQ1 Xku1ivSEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACayz4RhfkZXjHb7Erfvx36J zLq5adGDK1u/ZTPMUxFbdCcirFaxXvjEq4/LGJTtqzVSAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e399530-9ae1-4705-29e5-08dbfcb47fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKgpNSrQcMQu+benjmm0os57R9fq+hebXauBl3J9y4uXhl9wmT2jPWaWmZpY3JtQW9uTnBMjSAEJnV9xlvvUEMP3BOgIxburgfrJbV8ZaZjLKjtyddCCnEaO/wQDyTq7NHBp4GC+jr01IfdaeAbyuE2rtgsMksV4JkvXP7bMnExbq81dTFZLV0S+SHRlz/GH46/ingzrdtT3JP9pL609oLohky6r1Zlj2oGh4NbxS7ibLOKZt1OpUCLmTfqbLPk3KEiLJKL52jE2M0cUsPIkfeq42P2GiMKYfdnnvJiLI03Ey5F3mr+ZVQJKUi7rOsrBuF00ZtTLRjRfeQcy0Bypl+nENhVk7DRCp85TqL6/9rRkxzfWXgzVZKwqSqvVmP34r2O+bGaj3yvN2mUWwiaGzxy7RSDy9x61t0QEmGhDvHZxZ8CsllSgSZG1NCSs/NDljLaNYsJT1tSoEkkuv3W+D+BVAK3pTpWBpYiVsh3ppfExW6FRebBEKqHEqL+WdcTQt1dsXJiqIUkU4d9ERvSfSZwvPnBnyakmAVc1Q7tuHM6cgJWk2dPnC88WOK0loO8gd4+W4uHhpi7p5FGGkV+jkAnvCd0FoZgPSS9xoDpMbgw9mTY44Du0CJRaYaXVFnsrfNFakxvRhTmv8qO2HL8dOHEtNAg33/zpUHtVtzB5Ducc9zzsni4be3OS9Sm/4d6HX053m0BO2pIyPEc8sSI1TXwGokeyGiJ4POn8wElXiwX+Tns/sWhqwaXOnXkigrXR9aEoF8c/OtwQoTLUlWGvp523W5fYHeTWR3imev6eRAs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(44832011)(478600001)(5660300002)(6666004)(2906002)(82740400003)(356005)(2616005)(26005)(81166007)(86362001)(40460700003)(16526019)(36756003)(54906003)(70586007)(316002)(70206006)(4326008)(8676002)(8936002)(110136005)(336012)(426003)(83380400001)(41300700001)(36860700001)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 14:53:57.0266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e399530-9ae1-4705-29e5-08dbfcb47fc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no user for this interface that's why remove it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/firmware/xilinx/zynqmp.c     | 24 ------------------------
 include/linux/firmware/xlnx-zynqmp.h |  7 -------
 2 files changed, 31 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 2ae9da268215..a55dfd9bae6b 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1060,30 +1060,6 @@ int zynqmp_pm_pinctrl_release(const u32 pin)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_release);
 
-/**
- * zynqmp_pm_pinctrl_get_function - Read function id set for the given pin
- * @pin: Pin number
- * @id: Buffer to store function ID
- *
- * This function provides the function currently set for the given pin.
- *
- * Return: Returns status, either success or error+reason
- */
-int zynqmp_pm_pinctrl_get_function(const u32 pin, u32 *id)
-{
-	u32 ret_payload[PAYLOAD_ARG_CNT];
-	int ret;
-
-	if (!id)
-		return -EINVAL;
-
-	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_GET_FUNCTION, ret_payload, 1, pin);
-	*id = ret_payload[1];
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_get_function);
-
 /**
  * zynqmp_pm_pinctrl_set_function - Set requested function for the pin
  * @pin: Pin number
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index c6a7fb1f980b..1478f691cc10 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -149,7 +149,6 @@ enum pm_api_id {
 	PM_SECURE_SHA = 26,
 	PM_PINCTRL_REQUEST = 28,
 	PM_PINCTRL_RELEASE = 29,
-	PM_PINCTRL_GET_FUNCTION = 30,
 	PM_PINCTRL_SET_FUNCTION = 31,
 	PM_PINCTRL_CONFIG_PARAM_GET = 32,
 	PM_PINCTRL_CONFIG_PARAM_SET = 33,
@@ -567,7 +566,6 @@ int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
 int zynqmp_pm_set_boot_health_status(u32 value);
 int zynqmp_pm_pinctrl_request(const u32 pin);
 int zynqmp_pm_pinctrl_release(const u32 pin);
-int zynqmp_pm_pinctrl_get_function(const u32 pin, u32 *id);
 int zynqmp_pm_pinctrl_set_function(const u32 pin, const u32 id);
 int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
 				 u32 *value);
@@ -804,11 +802,6 @@ static inline int zynqmp_pm_pinctrl_release(const u32 pin)
 	return -ENODEV;
 }
 
-static inline int zynqmp_pm_pinctrl_get_function(const u32 pin, u32 *id)
-{
-	return -ENODEV;
-}
-
 static inline int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
 {
 	return -ENODEV;
-- 
2.36.1

