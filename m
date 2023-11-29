Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B07A7FD59C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjK2L1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjK2L1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:27:17 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE5C84
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:27:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzm4QV59fjo2hDn7mKu4SX19Q5SlEEK4v6P9c+Oauiy0nWZcw75ZVAYX/KU32yE0PgDZokcKcBFCK/10SylqGcUg08naBSL9Gmi7cnKhXz6Vcdp3IBapwDLG7rhFBiLjuRnr2tAR73gyMcvMgwUugJFR5ZuADXxenwiBmyppBrFe179+qkrUJw2dTs4/aD+nUGyE1GC9LEwyl5gCCBrT5V+bJIhK69uPIgM9LBs0XKvi9HBkdwf3myQrrD6ZTQNiYWVS2gzUq+q+ppfoSci0z/PByZ3F5C2f1g3Kq5NLqSUFdb9enKQVw2rBiMGHlR+cz0VTnSJ4WMmLq7GOelcXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x59j93QazxVlTR3tPWzn+uA5uTvD2T48vgAlEUPZ+jw=;
 b=MWu50nS6fvN2uYBKYQ1DPQdQcdffVM9qj5OfePoRVT89Qb2uKc2zIoDfWaClDoVOdcZt9xORetfrIWCipaYEMXEZlNfKeReSUO9pDmoh3aFZzpSxEm22I/XxYiT/H3/SnAeY843PQr9pDGZO9bSW9r+QNF4ZGTovBIbKCcU7YMGb66KXd2HkI/oFiHLhW1b2J3kPhQ+sd4xecGr8tdSWqM61pbcDxLmx23o5xXLFl082gw8MZ32CRRbfEGxZj4MAOpG2PZeriGnStGWEpHKk/cRXafU/2m+Vx5HZN1Vm6jg03V09bc3SOsX1zvxdDzbDBWeWPtwZ/FVxco8/Q+rz3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x59j93QazxVlTR3tPWzn+uA5uTvD2T48vgAlEUPZ+jw=;
 b=LGq+p9lXXqkum3MqF3s04owofvFKzv6DrdIBZmCWriyhSYvHQ5ppV54TsZHXnBYgjxsBsJvMBJhuVgvw2heHoPP4NAYAetpOBa37PDzea995j/ZvVZqDX5wlQQSlnp2Uo+hocSyUP53gR9mV9OWmUqaY3Y+OmXIUkcWxqLHCeCc=
Received: from MN2PR01CA0002.prod.exchangelabs.com (2603:10b6:208:10c::15) by
 SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.23; Wed, 29 Nov 2023 11:27:18 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:10c:cafe::af) by MN2PR01CA0002.outlook.office365.com
 (2603:10b6:208:10c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 11:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 11:27:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 05:27:17 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 29 Nov
 2023 03:27:17 -0800
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 29 Nov 2023 05:27:16 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <nava.kishore.manne@amd.com>, <sai.krishna.potthuri@amd.com>,
        <robh@kernel.org>, <marex@denx.de>, <arnd@arndb.de>,
        <izhar.ameer.shaikh@amd.com>, <ruanjinjie@huawei.com>,
        <linus.walleij@linaro.org>, <shubhrajyoti.datta@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v5 1/5] firmware: xilinx: Update firmware call interface to support additional args
Date:   Wed, 29 Nov 2023 03:27:09 -0800
Message-ID: <20231129112713.22718-2-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231129112713.22718-1-jay.buddhabhatti@amd.com>
References: <20231129112713.22718-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc0f554-5cce-4d25-8b42-08dbf0ce2508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /uI8Yt1gSoJISM3cQARc924Dgx9fBDwykxkPOOYUj0LSq2O3k2A4VNrtG9XkZrDaaft/ZgXb/wmVPwuOdOXWmFVyeqRu7+qQ+ZMnIjXULPafB2IE2V0adSmb/doplHX0hKOP9ZhumF0hKwTOduM0k1fmonQsVYPm9KCOkI903MPkxQ5yv11XczknzOtvuk+gibavwOIhQ1tamWwE+4rY+K2qpv/wl5LE5Iw01Pv4OOVPLwGMH9aziREu4aS77MBI+z6X2Lnblc7Xa5RU+QGUj18Ls3hZs8t+0W7Cl/rffDcUso9nl/ALZHGOdyUAROnQuRqqoKVQX6X6YcSrCYC73NXXh0eAFiWlrvbIaMMUud0sQIboUl7hmoDqSRJ3+mHoSoiiRtjsHrgtulfIjUBBkeP1CasN879aZMcNobzNDJ6xBtYtqvt/F4r727pw0TJ+jruTcwC7VaTla6NZS2KQ5RjOf1AgXjRdJD4L6N3Gjy+h/KWixWNniranMjRByydJIumcd5SgjCStIFxY+3owMbFPSvU2w+uD1J7vttqtftoc3dWYjk3NevJIHTaTzVu4b/vRxGGur6OKzyWU9yuDGdNXyPrWYEJ+/vg9w0d1znT9YdRzHb9sPxghYMOaXIUBPHy82pqO7QByMIzDP1XKnTtp8qmZVWYtJBAIEnzOV4v1o+UBaeBJmtM0tRh/H5fN3n9MOdz25D6VoTt2UB/kWbQO1dDvyMw1/L10IlfdKZih3gleKWUZUKSBI5Krki72RBKQE5mRrJT7b1y6M2QlPzw9B+m+kXECgOcopvb0fyI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(356005)(47076005)(81166007)(40460700003)(26005)(1076003)(2616005)(921008)(15650500001)(70206006)(54906003)(70586007)(316002)(6636002)(30864003)(110136005)(2906002)(4326008)(8676002)(8936002)(5660300002)(86362001)(44832011)(41300700001)(6666004)(36756003)(478600001)(82740400003)(426003)(336012)(40480700001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:27:17.7990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc0f554-5cce-4d25-8b42-08dbf0ce2508
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System-level platform management layer (do_fw_call()) has support for
maximum of 5 arguments as of now (1 EEMI API ID + 4 command arguments).
In order to support new EEMI PM_IOCTL IDs (Secure Read/Write), this
support must be extended to support one additional argument, which
results in a configuration of - 1 EEMI API ID + 5 command arguments.

Update zynqmp_pm_invoke_fn() and do_fw_call() with this new definition
containing variable arguments. As a result, update all the references
to pm invoke function with the updated definition.

Co-developed-by: Izhar Ameer Shaikh <izhar.ameer.shaikh@amd.com>
Signed-off-by: Izhar Ameer Shaikh <izhar.ameer.shaikh@amd.com>
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c        | 278 +++++++++++-------------
 drivers/soc/xilinx/xlnx_event_manager.c |   2 +-
 drivers/soc/xilinx/zynqmp_power.c       |   2 +-
 include/linux/firmware/xlnx-zynqmp.h    |   3 +-
 4 files changed, 132 insertions(+), 153 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index b0d22d4455d9..c9ec2c75cf0a 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -106,8 +106,7 @@ static int zynqmp_pm_ret_code(u32 ret_status)
 	}
 }
 
-static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
-				    u32 *ret_payload)
+static noinline int do_fw_call_fail(u32 *ret_payload, u32 num_args, ...)
 {
 	return -ENODEV;
 }
@@ -116,25 +115,35 @@ static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
  * PM function call wrapper
  * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
  */
-static int (*do_fw_call)(u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
+static int (*do_fw_call)(u32 *ret_payload, u32, ...) = do_fw_call_fail;
 
 /**
  * do_fw_call_smc() - Call system-level platform management layer (SMC)
- * @arg0:		Argument 0 to SMC call
- * @arg1:		Argument 1 to SMC call
- * @arg2:		Argument 2 to SMC call
+ * @num_args:		Number of variable arguments should be <= 8
  * @ret_payload:	Returned value array
  *
  * Invoke platform management function via SMC call (no hypervisor present).
  *
  * Return: Returns status, either success or error+reason
  */
-static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
-				   u32 *ret_payload)
+static noinline int do_fw_call_smc(u32 *ret_payload, u32 num_args, ...)
 {
 	struct arm_smccc_res res;
+	u64 args[8] = {0};
+	va_list arg_list;
+	u8 i;
 
-	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+	if (num_args > 8)
+		return -EINVAL;
+
+	va_start(arg_list, num_args);
+
+	for (i = 0; i < num_args; i++)
+		args[i] = va_arg(arg_list, u64);
+
+	va_end(arg_list);
+
+	arm_smccc_smc(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], &res);
 
 	if (ret_payload) {
 		ret_payload[0] = lower_32_bits(res.a0);
@@ -148,9 +157,7 @@ static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
 
 /**
  * do_fw_call_hvc() - Call system-level platform management layer (HVC)
- * @arg0:		Argument 0 to HVC call
- * @arg1:		Argument 1 to HVC call
- * @arg2:		Argument 2 to HVC call
+ * @num_args:		Number of variable arguments should be <= 8
  * @ret_payload:	Returned value array
  *
  * Invoke platform management function via HVC
@@ -159,12 +166,24 @@ static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
  *
  * Return: Returns status, either success or error+reason
  */
-static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
-				   u32 *ret_payload)
+static noinline int do_fw_call_hvc(u32 *ret_payload, u32 num_args, ...)
 {
 	struct arm_smccc_res res;
+	u64 args[8] = {0};
+	va_list arg_list;
+	u8 i;
+
+	if (num_args > 8)
+		return -EINVAL;
+
+	va_start(arg_list, num_args);
+
+	for (i = 0; i < num_args; i++)
+		args[i] = va_arg(arg_list, u64);
 
-	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+	va_end(arg_list);
+
+	arm_smccc_hvc(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], &res);
 
 	if (ret_payload) {
 		ret_payload[0] = lower_32_bits(res.a0);
@@ -184,7 +203,7 @@ static int __do_feature_check_call(const u32 api_id, u32 *ret_payload)
 	smc_arg[0] = PM_SIP_SVC | PM_FEATURE_CHECK;
 	smc_arg[1] = api_id;
 
-	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, ret_payload);
+	ret = do_fw_call(ret_payload, 2, smc_arg[0], smc_arg[1]);
 	if (ret)
 		ret = -EOPNOTSUPP;
 	else
@@ -295,11 +314,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_is_function_supported);
  * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
  *			   caller function depending on the configuration
  * @pm_api_id:		Requested PM-API call
- * @arg0:		Argument 0 to requested PM-API call
- * @arg1:		Argument 1 to requested PM-API call
- * @arg2:		Argument 2 to requested PM-API call
- * @arg3:		Argument 3 to requested PM-API call
  * @ret_payload:	Returned value array
+ * @num_args:		Number of arguments to requested PM-API call
  *
  * Invoke platform management function for SMC or HVC call, depending on
  * configuration.
@@ -316,26 +332,38 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_is_function_supported);
  *
  * Return: Returns status, either success or error+reason
  */
-int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
-			u32 arg2, u32 arg3, u32 *ret_payload)
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...)
 {
 	/*
 	 * Added SIP service call Function Identifier
 	 * Make sure to stay in x0 register
 	 */
-	u64 smc_arg[4];
-	int ret;
+	u64 smc_arg[8];
+	int ret, i;
+	va_list arg_list;
+	u32 args[14] = {0};
+
+	if (num_args > 14)
+		return -EINVAL;
+
+	va_start(arg_list, num_args);
 
 	/* Check if feature is supported or not */
 	ret = zynqmp_pm_feature(pm_api_id);
 	if (ret < 0)
 		return ret;
 
+	for (i = 0; i < num_args; i++)
+		args[i] = va_arg(arg_list, u32);
+
+	va_end(arg_list);
+
 	smc_arg[0] = PM_SIP_SVC | pm_api_id;
-	smc_arg[1] = ((u64)arg1 << 32) | arg0;
-	smc_arg[2] = ((u64)arg3 << 32) | arg2;
+	for (i = 0; i < 7; i++)
+		smc_arg[i + 1] = ((u64)args[(i * 2) + 1] << 32) | args[i * 2];
 
-	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
+	return do_fw_call(ret_payload, 8, smc_arg[0], smc_arg[1], smc_arg[2], smc_arg[3],
+			  smc_arg[4], smc_arg[5], smc_arg[6], smc_arg[7]);
 }
 
 static u32 pm_api_version;
@@ -347,14 +375,12 @@ int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 {
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, sgi_num, reset, 0, 0,
-				  NULL);
+	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, NULL, 2, sgi_num, reset);
 	if (!ret)
 		return ret;
 
 	/* try old implementation as fallback strategy if above fails */
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, sgi_num,
-				   reset, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 3, IOCTL_REGISTER_SGI, sgi_num, reset);
 }
 
 /**
@@ -376,7 +402,7 @@ int zynqmp_pm_get_api_version(u32 *version)
 		*version = pm_api_version;
 		return 0;
 	}
-	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, 0, 0, 0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, ret_payload, 0);
 	*version = ret_payload[1];
 
 	return ret;
@@ -399,7 +425,7 @@ int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
 	if (!idcode || !version)
 		return -EINVAL;
 
-	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, ret_payload, 0);
 	*idcode = ret_payload[1];
 	*version = ret_payload[2];
 
@@ -427,7 +453,7 @@ static int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
 		return 0;
 	}
 
-	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, ret_payload, 0);
 	if (ret < 0)
 		return ret;
 
@@ -459,8 +485,7 @@ static int zynqmp_pm_get_trustzone_version(u32 *version)
 		*version = pm_tz_version;
 		return 0;
 	}
-	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, 0, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, ret_payload, 0);
 	*version = ret_payload[1];
 
 	return ret;
@@ -507,8 +532,8 @@ int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
 {
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
-				  qdata.arg2, qdata.arg3, out);
+	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, out, 4, qdata.qid, qdata.arg1, qdata.arg2,
+				  qdata.arg3);
 
 	/*
 	 * For clock name query, all bytes in SMC response are clock name
@@ -530,7 +555,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_query_data);
  */
 int zynqmp_pm_clock_enable(u32 clock_id)
 {
-	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, NULL, 1, clock_id);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_enable);
 
@@ -545,7 +570,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_enable);
  */
 int zynqmp_pm_clock_disable(u32 clock_id)
 {
-	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, NULL, 1, clock_id);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_disable);
 
@@ -564,8 +589,7 @@ int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, clock_id, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, ret_payload, 1, clock_id);
 	*state = ret_payload[1];
 
 	return ret;
@@ -584,8 +608,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getstate);
  */
 int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
 {
-	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, clock_id, divider,
-				   0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, NULL, 2, clock_id, divider);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setdivider);
 
@@ -604,8 +627,7 @@ int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, clock_id, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, ret_payload, 1, clock_id);
 	*divider = ret_payload[1];
 
 	return ret;
@@ -623,10 +645,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getdivider);
  */
 int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
 {
-	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id,
-				   lower_32_bits(rate),
-				   upper_32_bits(rate),
-				   0, NULL);
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, NULL, 3, clock_id, lower_32_bits(rate),
+				   upper_32_bits(rate));
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setrate);
 
@@ -645,8 +665,7 @@ int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, clock_id, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, ret_payload, 1, clock_id);
 	*rate = ((u64)ret_payload[2] << 32) | ret_payload[1];
 
 	return ret;
@@ -664,8 +683,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getrate);
  */
 int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
 {
-	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, clock_id,
-				   parent_id, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, NULL, 2, clock_id, parent_id);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setparent);
 
@@ -684,8 +702,7 @@ int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, clock_id, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, ret_payload, 1, clock_id);
 	*parent_id = ret_payload[1];
 
 	return ret;
@@ -704,8 +721,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getparent);
  */
 int zynqmp_pm_set_pll_frac_mode(u32 clk_id, u32 mode)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_MODE,
-				   clk_id, mode, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, 0, IOCTL_SET_PLL_FRAC_MODE, clk_id, mode);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);
 
@@ -721,8 +737,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);
  */
 int zynqmp_pm_get_pll_frac_mode(u32 clk_id, u32 *mode)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_MODE,
-				   clk_id, 0, mode);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, mode, 3, 0, IOCTL_GET_PLL_FRAC_MODE, clk_id);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);
 
@@ -739,8 +754,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);
  */
 int zynqmp_pm_set_pll_frac_data(u32 clk_id, u32 data)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_DATA,
-				   clk_id, data, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, 0, IOCTL_SET_PLL_FRAC_DATA, clk_id, data);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);
 
@@ -756,8 +770,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);
  */
 int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_DATA,
-				   clk_id, 0, data);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, data, 3, 0, IOCTL_GET_PLL_FRAC_DATA, clk_id);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_data);
 
@@ -778,9 +791,8 @@ int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
 	u32 mask = (node_id == NODE_SD_0) ? GENMASK(15, 0) : GENMASK(31, 16);
 
 	if (value) {
-		return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
-					   IOCTL_SET_SD_TAPDELAY,
-					   type, value, NULL);
+		return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, node_id, IOCTL_SET_SD_TAPDELAY, type,
+					   value);
 	}
 
 	/*
@@ -798,7 +810,7 @@ int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
 	 * Use PM_MMIO_READ/PM_MMIO_WRITE to re-implement the missing counter
 	 * part of IOCTL_SET_SD_TAPDELAY which clears SDx_ITAPDLYENA bits.
 	 */
-	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, reg, mask, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, NULL, 2, reg, mask);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
 
@@ -814,8 +826,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
  */
 int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SD_DLL_RESET,
-				   type, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 3, node_id, IOCTL_SD_DLL_RESET, type);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
 
@@ -831,8 +842,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
  */
 int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, dev_id, IOCTL_OSPI_MUX_SELECT,
-				   select, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 3, dev_id, IOCTL_OSPI_MUX_SELECT, select);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_ospi_mux_select);
 
@@ -847,8 +857,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_ospi_mux_select);
  */
 int zynqmp_pm_write_ggs(u32 index, u32 value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_GGS,
-				   index, value, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, 0, IOCTL_WRITE_GGS, index, value);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
 
@@ -863,8 +872,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
  */
 int zynqmp_pm_read_ggs(u32 index, u32 *value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_GGS,
-				   index, 0, value);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, value, 3, 0, IOCTL_READ_GGS, index);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
 
@@ -880,8 +888,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
  */
 int zynqmp_pm_write_pggs(u32 index, u32 value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_PGGS, index, value,
-				   NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, 0, IOCTL_WRITE_PGGS, index, value);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
 
@@ -897,15 +904,13 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
  */
 int zynqmp_pm_read_pggs(u32 index, u32 *value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_PGGS, index, 0,
-				   value);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, value, 3, 0, IOCTL_READ_PGGS, index);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
 
 int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_TAPDELAY_BYPASS,
-				   index, value, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, 0, IOCTL_SET_TAPDELAY_BYPASS, index, value);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_tapdelay_bypass);
 
@@ -920,8 +925,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_tapdelay_bypass);
  */
 int zynqmp_pm_set_boot_health_status(u32 value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_BOOT_HEALTH_STATUS,
-				   value, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 3, 0, IOCTL_SET_BOOT_HEALTH_STATUS, value);
 }
 
 /**
@@ -935,8 +939,7 @@ int zynqmp_pm_set_boot_health_status(u32 value)
 int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
 			   const enum zynqmp_pm_reset_action assert_flag)
 {
-	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag,
-				   0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, NULL, 2, reset, assert_flag);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_reset_assert);
 
@@ -955,8 +958,7 @@ int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status)
 	if (!status)
 		return -EINVAL;
 
-	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, reset, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, ret_payload, 1, reset);
 	*status = ret_payload[1];
 
 	return ret;
@@ -981,9 +983,8 @@ int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
-				  upper_32_bits(address), size, flags,
-				  ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_LOAD, ret_payload, 4, lower_32_bits(address),
+				  upper_32_bits(address), size, flags);
 	if (ret_payload[0])
 		return -ret_payload[0];
 
@@ -1008,7 +1009,7 @@ int zynqmp_pm_fpga_get_status(u32 *value)
 	if (!value)
 		return -EINVAL;
 
-	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, ret_payload, 0);
 	*value = ret_payload[1];
 
 	return ret;
@@ -1036,11 +1037,9 @@ int zynqmp_pm_fpga_get_config_status(u32 *value)
 	lower_addr = lower_32_bits((u64)&buf);
 	upper_addr = upper_32_bits((u64)&buf);
 
-	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ,
-				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET,
-				  lower_addr, upper_addr,
-				  XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG,
-				  ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ, ret_payload, 4,
+				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET, lower_addr, upper_addr,
+				  XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG);
 
 	*value = ret_payload[1];
 
@@ -1058,7 +1057,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_config_status);
  */
 int zynqmp_pm_pinctrl_request(const u32 pin)
 {
-	return zynqmp_pm_invoke_fn(PM_PINCTRL_REQUEST, pin, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_PINCTRL_REQUEST, NULL, 1, pin);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_request);
 
@@ -1072,7 +1071,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_request);
  */
 int zynqmp_pm_pinctrl_release(const u32 pin)
 {
-	return zynqmp_pm_invoke_fn(PM_PINCTRL_RELEASE, pin, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_PINCTRL_RELEASE, NULL, 1, pin);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_release);
 
@@ -1093,8 +1092,7 @@ int zynqmp_pm_pinctrl_get_function(const u32 pin, u32 *id)
 	if (!id)
 		return -EINVAL;
 
-	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_GET_FUNCTION, pin, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_GET_FUNCTION, ret_payload, 1, pin);
 	*id = ret_payload[1];
 
 	return ret;
@@ -1112,8 +1110,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_get_function);
  */
 int zynqmp_pm_pinctrl_set_function(const u32 pin, const u32 id)
 {
-	return zynqmp_pm_invoke_fn(PM_PINCTRL_SET_FUNCTION, pin, id,
-				   0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_PINCTRL_SET_FUNCTION, NULL, 2, pin, id);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_set_function);
 
@@ -1136,8 +1133,7 @@ int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
 	if (!value)
 		return -EINVAL;
 
-	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_GET, pin, param,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_GET, ret_payload, 2, pin, param);
 	*value = ret_payload[1];
 
 	return ret;
@@ -1166,8 +1162,7 @@ int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
 			return -EOPNOTSUPP;
 	}
 
-	return zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_SET, pin,
-				   param, value, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_SET, NULL, 3, pin, param, value);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_set_config);
 
@@ -1185,8 +1180,7 @@ unsigned int zynqmp_pm_bootmode_read(u32 *ps_mode)
 	unsigned int ret;
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 
-	ret = zynqmp_pm_invoke_fn(PM_MMIO_READ, CRL_APB_BOOT_PIN_CTRL, 0,
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_MMIO_READ, ret_payload, 1, CRL_APB_BOOT_PIN_CTRL);
 
 	*ps_mode = ret_payload[1];
 
@@ -1205,8 +1199,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_bootmode_read);
  */
 int zynqmp_pm_bootmode_write(u32 ps_mode)
 {
-	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, CRL_APB_BOOT_PIN_CTRL,
-				   CRL_APB_BOOTPIN_CTRL_MASK, ps_mode, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, NULL, 3, CRL_APB_BOOT_PIN_CTRL,
+				   CRL_APB_BOOTPIN_CTRL_MASK, ps_mode);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_bootmode_write);
 
@@ -1221,7 +1215,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_bootmode_write);
  */
 int zynqmp_pm_init_finalize(void)
 {
-	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_init_finalize);
 
@@ -1235,7 +1229,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_init_finalize);
  */
 int zynqmp_pm_set_suspend_mode(u32 mode)
 {
-	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, NULL, 1, mode);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_suspend_mode);
 
@@ -1254,8 +1248,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_suspend_mode);
 int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
 			   const u32 qos, const enum zynqmp_pm_request_ack ack)
 {
-	return zynqmp_pm_invoke_fn(PM_REQUEST_NODE, node, capabilities,
-				   qos, ack, NULL);
+	return zynqmp_pm_invoke_fn(PM_REQUEST_NODE, NULL, 4, node, capabilities, qos, ack);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_request_node);
 
@@ -1271,7 +1264,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_request_node);
  */
 int zynqmp_pm_release_node(const u32 node)
 {
-	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, NULL, 1, node);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
@@ -1290,8 +1283,7 @@ int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
-	ret = zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
-				  IOCTL_GET_RPU_OPER_MODE, 0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_IOCTL, ret_payload, 2, node_id, IOCTL_GET_RPU_OPER_MODE);
 
 	/* only set rpu_mode if no error */
 	if (ret == XST_PM_SUCCESS)
@@ -1313,9 +1305,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
  */
 int zynqmp_pm_set_rpu_mode(u32 node_id, enum rpu_oper_mode rpu_mode)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
-				   IOCTL_SET_RPU_OPER_MODE, (u32)rpu_mode,
-				   0, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 3, node_id, IOCTL_SET_RPU_OPER_MODE,
+				   (u32)rpu_mode);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
 
@@ -1331,9 +1322,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
  */
 int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
-				   IOCTL_TCM_COMB_CONFIG, (u32)tcm_mode, 0,
-				   NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 3, node_id, IOCTL_TCM_COMB_CONFIG,
+				   (u32)tcm_mode);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
 
@@ -1348,7 +1338,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
 int zynqmp_pm_force_pwrdwn(const u32 node,
 			   const enum zynqmp_pm_request_ack ack)
 {
-	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, node, ack, 0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, NULL, 2, node, ack);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_force_pwrdwn);
 
@@ -1367,8 +1357,8 @@ int zynqmp_pm_request_wake(const u32 node,
 			   const enum zynqmp_pm_request_ack ack)
 {
 	/* set_addr flag is encoded into 1st bit of address */
-	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
-				   address >> 32, ack, NULL);
+	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, NULL, 4, node, address | set_addr,
+				   address >> 32, ack);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_request_wake);
 
@@ -1388,8 +1378,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 			      const u32 qos,
 			      const enum zynqmp_pm_request_ack ack)
 {
-	return zynqmp_pm_invoke_fn(PM_SET_REQUIREMENT, node, capabilities,
-				   qos, ack, NULL);
+	return zynqmp_pm_invoke_fn(PM_SET_REQUIREMENT, NULL, 4, node, capabilities, qos, ack);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
 
@@ -1404,9 +1393,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
  */
 int zynqmp_pm_load_pdi(const u32 src, const u64 address)
 {
-	return zynqmp_pm_invoke_fn(PM_LOAD_PDI, src,
-				   lower_32_bits(address),
-				   upper_32_bits(address), 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_LOAD_PDI, NULL, 3, src, lower_32_bits(address),
+				   upper_32_bits(address));
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_load_pdi);
 
@@ -1426,9 +1414,8 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 	if (!out)
 		return -EINVAL;
 
-	ret = zynqmp_pm_invoke_fn(PM_SECURE_AES, upper_32_bits(address),
-				  lower_32_bits(address),
-				  0, 0, ret_payload);
+	ret = zynqmp_pm_invoke_fn(PM_SECURE_AES, ret_payload, 2, upper_32_bits(address),
+				  lower_32_bits(address));
 	*out = ret_payload[1];
 
 	return ret;
@@ -1456,8 +1443,7 @@ int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags)
 	u32 lower_addr = lower_32_bits(address);
 	u32 upper_addr = upper_32_bits(address);
 
-	return zynqmp_pm_invoke_fn(PM_SECURE_SHA, upper_addr, lower_addr,
-				   size, flags, NULL);
+	return zynqmp_pm_invoke_fn(PM_SECURE_SHA, NULL, 4, upper_addr, lower_addr, size, flags);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_sha_hash);
 
@@ -1479,8 +1465,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_sha_hash);
 int zynqmp_pm_register_notifier(const u32 node, const u32 event,
 				const u32 wake, const u32 enable)
 {
-	return zynqmp_pm_invoke_fn(PM_REGISTER_NOTIFIER, node, event,
-				   wake, enable, NULL);
+	return zynqmp_pm_invoke_fn(PM_REGISTER_NOTIFIER, NULL, 4, node, event, wake, enable);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_register_notifier);
 
@@ -1493,8 +1478,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_register_notifier);
  */
 int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
 {
-	return zynqmp_pm_invoke_fn(PM_SYSTEM_SHUTDOWN, type, subtype,
-				   0, 0, NULL);
+	return zynqmp_pm_invoke_fn(PM_SYSTEM_SHUTDOWN, NULL, 2, type, subtype);
 }
 
 /**
@@ -1506,8 +1490,7 @@ int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
  */
 int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_FEATURE_CONFIG,
-				   id, value, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, 0, IOCTL_SET_FEATURE_CONFIG, id, value);
 }
 
 /**
@@ -1520,8 +1503,7 @@ int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value)
 int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
 				 u32 *payload)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_FEATURE_CONFIG,
-				   id, 0, payload);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, payload, 3, 0, IOCTL_GET_FEATURE_CONFIG, id);
 }
 
 /**
@@ -1534,8 +1516,7 @@ int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
  */
 int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, node, IOCTL_SET_SD_CONFIG,
-				   config, value, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, node, IOCTL_SET_SD_CONFIG, config, value);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_config);
 
@@ -1550,8 +1531,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_config);
 int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
 			     u32 value)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, node, IOCTL_SET_GEM_CONFIG,
-				   config, value, NULL);
+	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, node, IOCTL_SET_GEM_CONFIG, config, value);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_gem_config);
 
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 86a048a10a13..adb875f89829 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -483,7 +483,7 @@ static void xlnx_call_notify_cb_handler(const u32 *payload)
 
 static void xlnx_get_event_callback_data(u32 *buf)
 {
-	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
+	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, buf, 0);
 }
 
 static irqreturn_t xlnx_event_handler(int irq, void *dev_id)
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index c2c819701eec..0de0acf80ef8 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -51,7 +51,7 @@ static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
 
 static void zynqmp_pm_get_callback_data(u32 *buf)
 {
-	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
+	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, buf, 0);
 }
 
 static void suspend_event_callback(const u32 *payload, void *data)
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index d1ea3898564c..a7e24f5a71b6 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -509,8 +509,7 @@ struct zynqmp_pm_query_data {
 	u32 arg3;
 };
 
-int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
-			u32 arg2, u32 arg3, u32 *ret_payload);
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...);
 
 #if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
 int zynqmp_pm_get_api_version(u32 *version);
-- 
2.17.1

