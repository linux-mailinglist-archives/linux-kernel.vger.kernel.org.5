Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D704D7812B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379229AbjHRSQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379258AbjHRSPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:15:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040412D70;
        Fri, 18 Aug 2023 11:15:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kD7ZKsk+OdvqD2knYkkt7iWfUl0m4b3QuKE96Tb0yiXSAp/w3XAMR2d9J6UcaxozeY4RFYohnnGC/dAxQ+rbMlY4mpidWnJlwwVxWgOr90ZoB05ENBxE6XAlF+3l495g6TVTkocE5esTrn78BwlwFa7+i09sYf7qC8YJlrxJmqNkFw5wu3Unk3cr0eXl+Mb8lxaatWNyDQqVz/VWCJESzsGQbvsfPsJNODSazWxEUFfVnPpXASnX0JcatLFMM3HgitZxMUclwOruStIHUCBDvFRxtXu2a/ChJ4RJcZjzmxDIB/1+ERksVmo1gZ5YWdxaXdgRhQ0QwE6TdpYG7yxlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+7nM7XsdgnsxsSnJH/2QBAjzB74eXD8P7vIXcRa+G0=;
 b=KlJGDxugOjA5NC7DR/ddIhmOe1e5Ari+hNk25GZ46v0O0M+n+dovaaIp0LXK1rqZbaHNV/8bt94VO9nouHYlnixV803uV49yvV7ezdCgvtF2OE5i39VhrXaBm8Kq7q6FxZUAV3BrnL6xFeHWaOh0b3pAnb9EIxsvJFM80JZj/JhgkG98Y5WnIuP7zOUqeuuijXLHamwLrUjhkOA8UslEVBuAGiGBNyD8FO6HhNoKC+ftO4tr7k0oo99qh82bcRDukwsV8MmRSgZYtHOimSjHFOPfsVUGXTI5ei3KnvzXRTYNbWF04eiGOA4rHs0BEMe+WjjU3p5dZ/aHesdeQXFPFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+7nM7XsdgnsxsSnJH/2QBAjzB74eXD8P7vIXcRa+G0=;
 b=PmHyffkIVEIW4O4AV34mEbnw+2WXDJniweaFJTHPcLsmzTLRwxjwzJO4BQBBCwyB7+V4XiO4Df4wzXmnTBZzQQsjPwukGYqXCzwC3kF4klBG5Si6IkZx7HkZmdcWOjHUb8vKvT/CH06W26KlKQLp4U/tRXqHQjwJJ9/6IYnmLdk=
Received: from PH0PR07CA0091.namprd07.prod.outlook.com (2603:10b6:510:4::6) by
 SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 18:15:36 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::f0) by PH0PR07CA0091.outlook.office365.com
 (2603:10b6:510:4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 18:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 18:15:36 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 13:15:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <jarkko@kernel.org>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        <charles.d.prestopine@intel.com>, <rafael.j.wysocki@intel.com>,
        <len.brown@intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>, Todd Brandt <todd.e.brandt@intel.com>
Subject: [PATCH] tpm: Don't make vendor check required for probe
Date:   Fri, 18 Aug 2023 13:15:16 -0500
Message-ID: <20230818181516.19167-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: da5779bc-eddc-4884-4193-08dba0171edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaGjO42SKQdf/3TxbDU2y7YdXt4TBVprsCAFfJLX7RMo6rfNu/2JVUeFBUFrOWxH861IbBtt20WZsttw6mWURYW6uCVTaXuQ4w+/wpWRH720CSt2l9fZghqlLWwJMNmhv48OUXus+Pj3Ao3Wh45aw7WeY3/APDEvBm11wQoyORZKV7kzTI9OxZyXyeW0vTlfzkQPWdqnhYO6piRLcnbxgJuIR7MmBzd+W7TIDMT+j+4F4qzk8v19t4LDParUJYiIWDuGgh/d2TUsewG72xvWWY+1iDOlhXFjn4JdwQBlxZ6RKyu98XXk7TjoXzG5gLzlgKwruEfrafRAaNJ5ZeBrSTn9GEQfHvz0x/ZJ1ksyvKgOapADnoG1xVSYZFKqxIDYubxYRLLizw41CeEJlVUjJYAElb0m6sXzUGbE53CwQd7w8bOxjnGlyOROcoc4k9JVsSI+dhvWk62sHyVYLrAXtI3RfQoHOfdSbhngTNTr/YvNyHvHr+VQFNm32SANQCyXKmdny+B/MdeYyc5hak/P71FF7yNO52tVF6ROeA61w6qscfqeDnDXl0t4faC4UqYAHgkowAfGdXJGU/nmWCKn6dLtVdTJTGqBRzpB/HM888HhR2zuyD55iGbulMk6htzudQ0NBGPdsroX3ce68NxvLGIiEzoRbJvo0ejoOf7e/w5ZOmj1EmOXZtOC32UF6XgMcfed3fokTwZD6+Ti0vcotqroTSxzCleafdzPvTwgQx5sdT/jLFtQLlSWC2rBjdC1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199024)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(966005)(44832011)(16526019)(5660300002)(2616005)(7696005)(70586007)(54906003)(70206006)(478600001)(6666004)(316002)(6916009)(26005)(1076003)(4326008)(8936002)(8676002)(41300700001)(40460700003)(47076005)(336012)(36860700001)(83380400001)(426003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 18:15:36.5071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da5779bc-eddc-4884-4193-08dba0171edf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
all AMD fTPMs") doesn't work properly on Intel fTPM.  The TPM doesn't reply
at bootup and returns back the command code.

As this isn't crucial for anything but AMD fTPM and AMD fTPM works, throw
away the error code to let Intel fTPM continue to work.

Cc: stable@vger.kernel.org
Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/char/tpm/tpm_crb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 9eb1a18590123..b0e9931fe436c 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -472,8 +472,7 @@ static int crb_check_flags(struct tpm_chip *chip)
 	if (ret)
 		return ret;
 
-	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
-	if (ret)
+	if (tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL))
 		goto release;
 
 	if (val == 0x414D4400U /* AMD */)
-- 
2.34.1

