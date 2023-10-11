Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530AC7C5175
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbjJKLRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjJKLRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:17:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40FE1;
        Wed, 11 Oct 2023 04:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhVc3a/LCwEUN9wuBdiY63wO/sBSPNpJ+jbckx6GsZDo8XwVZWtlusFJXeQo4tAHZXyp/K8pUaLC6Xawo9BYkIxh6PF9yIvXzraNg41VnYFDIG1iWByJVrSoIG9ajCR/8j/KrV961U5RABQSfZ7Hi+iwqtac+anUIPivsXK5MTzJcTzrW717H9LKOCQ7Pr6nY4nFAZGVWQbfl8D7E0lPo+8ZSZsdu3jFtB1SjCzc+Q6aFgsCHwnq8NKWPFmzhf9dL48Et5Zp3xd2j7HTCBtuLLmV+cOJYP9TCucBp+DFmtIlzagEoxnV+Kv6R95tIsw7CNRB0CqoOBhVM42eYHs38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPUgh6twlRJm+WWMEgWW2mHamvqmlffPxhPVO0v6bYI=;
 b=HMc362uhMp3MvkNSyMLuJrv16/Ikovb8a2oXkyLmeAnuaPTzkLTk1j2bmEQOpNTjKUo9pgQpJ1IiEe/4PQPPudue127cCzb+RehmgzN5DXog63T7EdZh1yo/Z4tgf1tzjqzA0tGQc0gjQ+kO6/L75efWmQc/uYLUxa+Y1nBVIEHMbjA3AGsPB7B/c6GqGBfGLjImX3LPXs924Rz1pePUtguAxJyYzrOzJyBGXHduLDY8refHqoBY11Tbb0iA8X9Gvh0mF+jpKuAI6sZCBUsDbby26FtJxunNV4jRasTAQmlfR38m2EpiDH8pAL2R5QwbAFk4xNcTPMy4AqmhkzSIlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPUgh6twlRJm+WWMEgWW2mHamvqmlffPxhPVO0v6bYI=;
 b=UCdjm2ZuK3laa9UWerLLXoxF29yBE3PH+shQSVmLafW36/bm/Kp/SoEFb0EYtx2FDPX9djQdJxQ1MWh+efYzOTItdhI6yte0ahILHYIAmu7ls15h+G5uSBQAOjncOLZdd1wFp2bE3TQCl8t79XbqNoorlzZtcbwAyfisU0zk9ir6CE9kGWxlpWQN63gceNgIlsT3c8vWokE2iu8fdUn6XP2WCoQpBFDCsddkUSSso/zZay1FkCkI/9hL8PrO1WYFBXksxWHg4arF/sPjgj5E14X5Y9Wi7z9XqH/eJk2EvIKM2tEUwcu768thlilHV30prRCadbb7O9fnSPTMUavkcg==
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.36; Wed, 11 Oct 2023 11:17:31 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::29) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Wed, 11 Oct 2023 11:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 11:17:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:17:19 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:17:19 -0700
Received: from localhost.localdomain (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 11 Oct 2023 04:17:13 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <petlozup@nvidia.com>, <pshete@nvidia.com>, <kkartik@nvidia.com>,
        <ulf.hansson@linaro.org>, <frank.li@vivo.com>, <robh@kernel.org>,
        <stefank@nvidia.com>, <pdeschrijver@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v4 5/8] soc/tegra: fuse: Add function to add lookups
Date:   Wed, 11 Oct 2023 15:04:09 +0530
Message-ID: <20231011093412.7994-6-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011093412.7994-1-kkartik@nvidia.com>
References: <20231011093412.7994-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: b3394372-dbc8-4f89-0f64-08dbca4ba909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RTWc+UbHcA7C/Mq1UuqeqLkIfrkOxlyPEU6TuCZKD4K99zfrBrq/z4rhNfHQry7eXvclCS7GF9X02boSk6ka7cAbzINc3vYWuLpNR30pMa3OkI88pGNA8QAmtlW0TMiWEFTvo0Jfs89bU2l0ZT5138vpRJ9mvcFTJBQJgje171HvA0iHmS2FcZ4rFFpH+OkMo++Ra1yjRkFcsToqW0GN1NWwum2G+a0OF3niDG/U/eILEEFDtoMJ9c7UoUD412y6YYyFMVtLdcvJ1RjI1w4BWDVMbYIVsOY9KgCtx+NtguAQEvW9xmmydUhW52CR01GJcZ/qz/sibiRLWy3Phe/2NxXOCC4pMCjF5k3E4WCAhvqVHgUpkseu/ro+ieAUGTpddLAYhfauk9d91k/XXhajulWpdPOnXqTftTJY6nTq7ZuZ6otd3QLylCPnzFTztdNN5YmZcmFAliyZ0tQ4cT4LxEsj1uHfgykQRTXOyQ+r8BxqnEJkKNn5QTuRaIr4l7vd5P4m0MmIIXyYALdOfBiOkqiG7hLXxx+RSnsHf5mB94tkRXvxVzQUMQj4TimIS152biroYXDjMpXkmz0WfsjvXEmcmOobkaKNWQ4Eir5tzIzSvRKtoY2vec2madqgkSOpUFQ4WKuHkt8+fVuy88KvD1QK/PixkuTI8AaeHVu47TJ4AmHxdNvRNC4z8hgjoz2FmMKrCs1pQhlBS/+CcV9nOiyAjMpMIVEYf4a3UK8dLAqwkqiiklDkUP4AAq9EpC973EV0bvjOwDz8yUQ60p375DysVhWuvomO9QxKsmqJG4odtC9FAGS0jVy5Fi8hibGzHbBcy87r81URnwGZfwtDw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(83380400001)(26005)(426003)(1076003)(336012)(2616005)(40460700003)(86362001)(36860700001)(36756003)(40480700001)(921005)(82740400003)(7636003)(356005)(8936002)(478600001)(6666004)(2906002)(7416002)(47076005)(8676002)(5660300002)(316002)(110136005)(41300700001)(70586007)(70206006)(334744004)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 11:17:30.8795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3394372-dbc8-4f89-0f64-08dbca4ba909
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function tegra_fuse_add_lookups() to register Tegra fuse
nvmem lookups. So, this can be shared between tegra_fuse_init() and
ACPI probe, which is to be introduced later.

Use kmemdup_array to duplicate fuse->soc->lookups.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
v3 -> v4:
	* Use kmemdup_array to duplicate fuse->soc->lookups.
	* Return err at the end of tegra_fuse_probe to remove
	  redundant code.
v1 -> v2:
	* Use size_mul to calculate lookups array size.
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 98805885158e..ddf25a1bb19d 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -113,6 +113,21 @@ static void tegra_fuse_restore(void *base)
 	fuse->clk = NULL;
 }
 
+static int tegra_fuse_add_lookups(struct tegra_fuse *fuse)
+{
+	size_t size;
+	int ret;
+
+	ret = kmemdup_array((void *)&fuse->lookups, &size, fuse->soc->lookups,
+			    sizeof(*fuse->lookups), fuse->soc->num_lookups, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	nvmem_add_cell_lookups(fuse->lookups, size);
+
+	return 0;
+}
+
 static int tegra_fuse_probe(struct platform_device *pdev)
 {
 	void __iomem *base = fuse->base;
@@ -398,6 +413,7 @@ static int __init tegra_init_fuse(void)
 	const struct of_device_id *match;
 	struct device_node *np;
 	struct resource regs;
+	int err;
 
 	tegra_init_apbmisc();
 
@@ -495,15 +511,11 @@ static int __init tegra_init_fuse(void)
 	pr_debug("Tegra CPU Speedo ID %d, SoC Speedo ID %d\n",
 		 tegra_sku_info.cpu_speedo_id, tegra_sku_info.soc_speedo_id);
 
-	if (fuse->soc->lookups) {
-		size_t size = sizeof(*fuse->lookups) * fuse->soc->num_lookups;
+	err = tegra_fuse_add_lookups(fuse);
+	if (err)
+		pr_err("failed to add FUSE lookups\n");
 
-		fuse->lookups = kmemdup(fuse->soc->lookups, size, GFP_KERNEL);
-		if (fuse->lookups)
-			nvmem_add_cell_lookups(fuse->lookups, fuse->soc->num_lookups);
-	}
-
-	return 0;
+	return err;
 }
 early_initcall(tegra_init_fuse);
 
-- 
2.34.1

