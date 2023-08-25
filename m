Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE90788586
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbjHYLU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240370AbjHYLUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:20:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19C21FF7;
        Fri, 25 Aug 2023 04:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwPzoVEweXL5A/9HK7J9rkeuT902LJ79IotFBR9CBmjuYtKQD6JLQUbGlXsZHkncOC7ggUc0KbOL6S+yEuMLMTl+nqi8XAw0Bf9n2glJWVyoj2i9ciBmc5IiyF1DbyvFeiTs1/OFlRk6xh3HZpAkT91CniInIrmKwk5DzakWKsDd0n4NvrwGqhByN5o9wBY3jsrVqvcRsXoG9WQ/5KC8V1DqsuShR0xkTr56vpmCah0feXbYj5MXgNBhg2afHIGGwl/3prY/aSkaQi9A9PpP5A1eLiurkoN0CTWVC+rveaDzzZHvsBtk0H0Zu9PNnQn+E1x+K/DpMHrKmme6hcCktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHN0gqgIX/RiDR0udQ99rjjs3l4Q1zSqyCh62ojc9/M=;
 b=ViEjdisXYYOt04MCIc4Ndzo6p/Y1vaJswuIdIN4KmOuiVH+cf+QzynSUshYUa7dJGcKCPaY1N/RYuZOjIuZcnvRR7qdkOGEaxXo6iMEMZBQ4s/dTAGJ/qFoShe/uXhCyqeXDcrVWYdiiwxUkKAE392NPpdB/ojXYkFEkfTr6njg6uE/VOX1WUKhCZcpRM6vDHyJlxGebqU/bMjCyg0LAJ2qpfuK0yPrzHyAOUjkM2lcyBskj2FE7ns+HESt63H28SwihBiBe6P46xxawrIXRIXx7zDdhO7szu4SE4gexzkXn8VWXfTbFay6VH/VZRAOAX97yOfSOl0vwo6st0eblqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHN0gqgIX/RiDR0udQ99rjjs3l4Q1zSqyCh62ojc9/M=;
 b=i+LzJRvW+tJAq+/TtBEerw+Ag1yjD57xfuQAHXfktWVvXvqK/akz6QFVt9OrAHsHi6NhP1XWHRj1l2bUBRjsGT9x8yCwIcIFHhyZvcTNJBfSPamZ6CevGfC6lAbCPexjo+KAIKriE5FhRoVBcqhvAJyGONyOrc0b+x58IPuiF/bEFkv87RFjLsisPpKdUg2ZjD9pxliqT632kfp7AsGbcZ3cpdrpheOKck+lOWhzYpkeLjXEd6M0SdIPhmiS4CVZvCL9v6V03gaOuXMdPnrto6c8XQZAJgc0aT0mZns6cU65kUzwa85/MYvcjlxYAmJco71qAvEb/BZjECGt2CM9iQ==
Received: from SA0PR11CA0122.namprd11.prod.outlook.com (2603:10b6:806:131::7)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 11:19:40 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::83) by SA0PR11CA0122.outlook.office365.com
 (2603:10b6:806:131::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 11:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 11:19:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 25 Aug 2023
 04:19:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 25 Aug 2023 04:19:25 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 25 Aug 2023 04:19:22 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch] cpufreq: tegra194: add online/offline hooks
Date:   Fri, 25 Aug 2023 16:49:20 +0530
Message-ID: <20230825111920.8257-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: a7adb663-42ce-4817-31f0-08dba55d2cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xm7L1tOn7AiXwxX1GaMX4BT79VSnhhwdXcgtdJiVa+KPT0f5txH2ZHnPSB1ndaHd5Bu4JDNp7Ve0seSKHjN5HLLsq6SG8r4Yyifojvcu5eG0N9c/BbCicMfqWaSVVGLWLW9DcWyGnVTvXlGknSlEPJr/jUzrEqeGiRPWK5pXPRvSuyCNrJjzEey5maQHfxasY3zj88RNnzk5oZrKpp1cEDrmOmsCn9S/pVGukTc9YsE5TDLQdnHB6E3TyKmpq8O6PYV4fL3xav5/W/Ya9RSaPbXpaKMFek60wZkH8Q46ohVLnfvFlcc6UPl5YthVA958PufBY7Nrmb9Hw1hTmlFI7lJjCTlkmyQdAVtm4Iv6BPt/Dyg6Bfei4YqoAzOHKUyjCoM1Jh8itdZNdMbVMZLbqhljb5PULrjXKDOFzB+rQdgFwAS+UVmReg4Edv2YVymBJQUrWb9DGf8Jc/63CFnxNBlOl/Vh2ZnmaiQznX76s4iCgYRIxMB0OS32ctRXGXLZbB3pzYGtAOcoW7xobon+M6fvVl/GKMMxwfSFolXpBwbom7CGIUu1uosercSP9EiyiZfa/kR+LVfHA7zNGr/Ay098vRAtEHDsWnBsT+KBm3Auu277A6X8pjPwxvT1pDDaqSgTFIRR5rK59BFoSuRdQNSukh55c/s5YmtnrgzcOyIa7Mv51zxMv5Lq3pM1pXfBTchN+8EoJXUhoFOGAVjjL0QIwYjmCOn5gH6LWh4tpXX138xttGUxUT8dgmtXZuUqZ2vuliuj1zq+Uifw7hSqPZm0V1/QEXyT1vCST23+X1lndvJEHF1GjstgDU8zd0p0tgLYiPG3Fdp74yyKigjEQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(40470700004)(82740400003)(7636003)(356005)(40460700003)(8676002)(4326008)(8936002)(54906003)(41300700001)(316002)(36756003)(7696005)(110136005)(70586007)(70206006)(86362001)(40480700001)(47076005)(26005)(478600001)(336012)(36860700001)(1076003)(83380400001)(966005)(2906002)(2616005)(107886003)(426003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 11:19:40.3469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7adb663-42ce-4817-31f0-08dba55d2cc5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the light-weight tear down and bring up helpers to reduce the
amount of work to do on CPU offline/online operation.
This change helps to make the hotplugging paths much faster.

Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Link: https://lore.kernel.org/lkml/20230816033402.3abmugb5goypvllm@vireshk-i7/
---
 drivers/cpufreq/tegra194-cpufreq.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 66a9c23544db..09582696b83d 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -510,6 +510,21 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int tegra194_cpufreq_online(struct cpufreq_policy *policy)
+{
+	/* We did light-weight tear down earlier, nothing to do here */
+	return 0;
+}
+
+static int tegra194_cpufreq_offline(struct cpufreq_policy *policy)
+{
+	/*
+	 * Preserve policy->driver_data and don't free resources on light-weight
+	 * tear down.
+	 */
+	return 0;
+}
+
 static int tegra194_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
@@ -548,6 +563,8 @@ static struct cpufreq_driver tegra194_cpufreq_driver = {
 	.get = tegra194_get_speed,
 	.init = tegra194_cpufreq_init,
 	.exit = tegra194_cpufreq_exit,
+	.online = tegra194_cpufreq_online,
+	.offline = tegra194_cpufreq_offline,
 	.attr = cpufreq_generic_attr,
 };
 
-- 
2.17.1

