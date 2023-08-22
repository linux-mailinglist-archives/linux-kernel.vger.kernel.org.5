Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D2D784AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjHVT7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjHVT7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:59:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC731AD;
        Tue, 22 Aug 2023 12:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUptiYd4GhH9cjA1Yj9ztoLGI85sAHGujUs3d23eRmMpPkd4keivhcfAijplnvMalZChhGGqP02+20EELq6tFxbeZvmDwhuAKIXa3vbJKs0sNbb1ZrkdDgyBYqECnMT15aft/unMhRezLQsGHKnqQtD22JzGoesYAY+wzvOZgGnG+pogUbnu+VUtNiJqkVaEV3Bh5JwnK3GKXzVsfCdj0+QiDDKKibjOY8PL58iFJb1CHtZ0eWY3s6j+6919IfKAWDPJESm5T418aNyOZCWFZMbyhDoWYaFJfyob1QuKcrh8p23yrFcZvf2UTNQmKbW+F42ti6MvijoB32KkAzFYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cFIMbU9T4DVU9aCC+0eQh4Hcqs6NKy56SsjNoDgP6s=;
 b=fZ6iZdS6xZJ8KN7V2lo3w0fIPoYamDhkZ82qehI4l3L49LhBvR2a7BpkF97H+TEHi7dY+A2I2BxhkZnYzkq97Ry1tmaZsVPGW30Il+VqeZ0GCr2HUdBxvbL/GDW/oUMdtncHpgE32EvfjmjHGtc5/f2g3EzdVcp/gyDjbL2d+HiFjJJavhHUjRFH7gmkVN1SYfpgm7OdS8RHX2Gjy5YXEkhcVCfw0nyljF6a/8TQc8lV4uVLdJy2DtqljOEFDKWjSWMOwwcLckX8eA6x9vVAm563AEPT2H8Gs28WaSN0iUwr40ZnPC97CTukUrnAK6ha58QXCagr1U7v8+voRRPv/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cFIMbU9T4DVU9aCC+0eQh4Hcqs6NKy56SsjNoDgP6s=;
 b=KTPhHjYkfOA6lXciZbqQSM5jCmj9aDxFYGniHdZufArVfjWjR9hVG3D2t9TSaUX91gDwasJGWJpuOGqLkLk7gT6VCYVyhfoHpKVaiJeviwxG+maSZT8Z/M7riljZKhbUDoAqmBXk20YCffuy28NtHxRu0uBJ8uJSmap3DPCG6nItzXl05XZ3TZip+gfKsznjjHKpC99Yrs+PUYG0IY6d5zEClINz9pNIajkdg6xQRFQkgfzNGNiCOOR42VcnT4uXR3yQE5sJxaJuIbJ8UO3eZfWQ48JpbEekJCdG4qpTkcLDvw7vvykkNeFMP1UQVPe5PPGPWR7X8C6x01pX3gIyFA==
Received: from MW4PR04CA0390.namprd04.prod.outlook.com (2603:10b6:303:81::35)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 19:59:42 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:81:cafe::65) by MW4PR04CA0390.outlook.office365.com
 (2603:10b6:303:81::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Tue, 22 Aug 2023 19:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Tue, 22 Aug 2023 19:59:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 22 Aug 2023
 12:59:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 22 Aug 2023 12:59:32 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 22 Aug 2023 12:59:31 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 1/2] mmc : sdhci-of-dwcmshc : add error handling in dwcmshc_resume
Date:   Tue, 22 Aug 2023 15:59:28 -0400
Message-ID: <20230822195929.168552-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 020c9517-087b-45d5-91b4-08dba34a5372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8K64XFUNgI7eP4X/ZTAwbuJJQRL2Mw2/J+/VHW9khtMHB3H5/NmDeYbebj+xpi7k37Ij0f2kteeciNA+RwRzqeY3qfILgJlkZN/a+ru4cO17ogQ8ia8kyX7H+bBDVyeH9aX1CHaDhIFqPyyEkFzp0t5wDbsOgx7AbwkzQt0kg/mZmYrAcHWLa3M4Jn4lGNjBy3yteHPmYoaQHmDcOf76o08ZC13/frFAmy6mTawjavp/PhZAwbNUx90LflZX75IiKxnUWV2qTz3PeGCI+r4sx4H+Gs6cAE6Z24xWI8ZiBcEqVgEMFoN+cLiSft7MZzx75Sv3lk61xmvmdRCbYjyOFSl7Xxv2C7rvcx0tCCjYpPyMtsbLMc7PtdIMq6pbTTcfTI729qEf44VbxgCKqTJXXLo6+9Yu5O7L2pB7az3ijpff275xrgIwp+8wthY/Lj8xDLqwZmTN6tGsVzNgKrwKtjO/qUWntnuEJN3GAZZLSt+g836qQdS75LNsf322ozxf0HWsKDNz97h8anIzwflGRLI4td31ch+Ni7uva4gSAsUPaZdMTJNqsz+wOlA4TaNZGNJkiNJggFtXXo3ws7SkO6542a6txBemGFdxuHD+AvieDLAUQ/uWHoCp6UPdhlj8PTH6mRbC63j7L0jVSmXEcwhlF7ZwhtbHHEiu9k+GNmB1Ejv1D/AQv4YWqUvmT8WqnaaRC0M29YeUi2yZY/YlN3zV951HIdU+Sm4resg0t1RlU51uVszylGIQnZnPXB4deUkUC8Gcu7sjV2mcJTF6w==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(40480700001)(83380400001)(5660300002)(426003)(336012)(26005)(36860700001)(86362001)(47076005)(7696005)(8676002)(2616005)(8936002)(4326008)(316002)(70586007)(54906003)(110136005)(70206006)(478600001)(356005)(82740400003)(6666004)(40460700003)(36756003)(1076003)(41300700001)(7636003)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 19:59:42.5200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020c9517-087b-45d5-91b4-08dba34a5372
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds handling in dwcmshc_resume() for different error
cases.

Signed-off-by: Liming Sun <limings@nvidia.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 31c1892f4ecd..bc332a035032 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -630,17 +630,32 @@ static int dwcmshc_resume(struct device *dev)
 	if (!IS_ERR(priv->bus_clk)) {
 		ret = clk_prepare_enable(priv->bus_clk);
 		if (ret)
-			return ret;
+			goto disable_clk;
 	}
 
 	if (rk_priv) {
 		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
 					      rk_priv->rockchip_clks);
 		if (ret)
-			return ret;
+			goto disable_bus_clk;
 	}
 
-	return sdhci_resume_host(host);
+	ret = sdhci_resume_host(host);
+	if (ret)
+		goto disable_rockchip_clks;
+
+	return 0;
+
+disable_rockchip_clks:
+	if (rk_priv)
+		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
+					   rk_priv->rockchip_clks);
+disable_bus_clk:
+	if (!IS_ERR(priv->bus_clk))
+		clk_disable_unprepare(priv->bus_clk);
+disable_clk:
+	clk_disable_unprepare(pltfm_host->clk);
+	return ret;
 }
 #endif
 
-- 
2.30.1

