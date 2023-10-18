Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AF47CEA09
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjJRVd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJRVdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:33:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B99FE;
        Wed, 18 Oct 2023 14:33:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E26+9AhEI2lkG+ef4AwdCYDZy4qhlWo1enV6/8VYBmgRe8zDPuvsZDvKAao9J8gv4kDXG1KiQI7cMA2BF8AeBW+ozctmXaORDp54k1cW1l50CCyFob+fYylLbGdxTa5YmYTzaT49m8TjnExUpK90Ceg1YAcmGQvJC1LSDCBawYemRgxpM9rcFxENhE6kWRRbE3awIdjqqUfMiiNOk//tW2fdvY2KYiRn5BcLvT9HENKYTdlJxZe0O9/+GJVovcNeNK0DPdl5q/f4EshLY5woIlI3zqufLOfOGSwEbEf28n3AqTRh/o66TyhZ1bX0XaGFpmEDUuohML9BOvzTWn8BTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5mqpHnfYMEPp/K3f3bZgmug97OgZD/HN9a0e4dtXkU=;
 b=TUL7ixVEPwrsjKpDbACYOf4z/V47J9O6WB3+myxyNTCzsOag783vT6QD0N56TZaiL+nrj+DcM1UVs+Th7ytGrv4FT8o0Tq3sTrDXHdnHPB2PTJ5Mna84P087cgxnYCJgjScDS7eUKyR1gJMMN72D1Dz1Px9+EaLgRCJgkCI3ROPCkCCT8U/fsfT07ekxi7nxmIikMT56n3C6M995x2gbOZJALAKVzmzAg4nV2BxV/3f9pwqBRS/POC4DQkqQMz0EGCJJtgy7GD6jdwdEXjcLfHiRYLO+wZQ4M8W9WjYoYFbnCybr3Kv3IqnhhG1DIs9UKPGnSfVKz9z3XkYn6BKFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5mqpHnfYMEPp/K3f3bZgmug97OgZD/HN9a0e4dtXkU=;
 b=SZ90dstoK/X7WkjQvX09ypCuUigDAR9TmUH+Aki0k52SNBoGfhGB1B00fElMa/318kwRUC7mUQQmZ6fM+kHtG8sQ43xKEaBquAhUgrr8INlAE58dVDOiO4qOr5wRaq0z6zr59vz8LwYxeQZdjklUoVjZKCIfSAjr+U3TpIlMxTU=
Received: from MN2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:208:134::14)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.40; Wed, 18 Oct
 2023 21:33:47 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:134:cafe::44) by MN2PR16CA0001.outlook.office365.com
 (2603:10b6:208:134::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Wed, 18 Oct 2023 21:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 21:33:47 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 16:33:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 14:33:46 -0700
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 18 Oct 2023 16:33:41 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>, <michal.simek@amd.com>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <amitrkcian2002@gmail.com>, <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v9 2/8] mtd: spi-nor: Convert macros with inline functions
Date:   Thu, 19 Oct 2023 03:03:22 +0530
Message-ID: <20231018213328.40131-3-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
References: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: c6aeb351-f92f-43c1-07f9-08dbd021e965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1kuhm1yKQ4UIO2ObNxyMyFYrF8AvM39G13xCXNdcIMgaIAesyWsG0Q63vrP72NcGIqyiGNidwl0Bi7LNmnAsFYyJmaKpAk1BvdUsEkHy3Zw+gqgxTtljfOld/m0A/M7PeUi60ROuGW6fDE93Ei+lMgW1KtpSHFyT68p3rWMEst99uMHizThUyKWJK7FXezz2gNJcPO1FhG+JH83JTqa2z9/HzGbms6AivobbwiIOwAx3WXg4QbcJO75Lx/CiCqpOv1sPc/354RqXuJxpakbnun041EFJFMXLliZuAZwqbEktmjBTEFw/Mi5RU8nobxMQtmPDEp4qT8MYknuMeOpDWLOLb2VvbQrtJcM+ue8gQ59NZSUKw4HBtFmvBDfqbXPeQsXSBFnnY09MOCnu1uPEax4WD8scoVJAaMjC8CwtLcI+V2Zhf2jxi0hrqQBskSsxscYK2F5hiangD2lIdAg1B6WFRf9caBJz6zQGJU6m8r7+7qNIPxxjajpyIStfyL1DZWcJGD2QmDzYUbOfc1Ot9Xb79GzUc5Rm8aMfjegJfekOEVPd5VdgR6NaQ+mf+GmGbwoRueUobhX8ObBgCZu9SQrlULB8Dq0drcNm8I8uV8gP62WVms8fCyjtgJoGa5/dXJDHIQ8DCvSFE7Sb6kt/2eq06jsjMr2rxy1ZSdB5Nut74ysudc65IPzvwSha/DbNGU47e40bPltGoTjXf12fcEqjTU5qm+r7ug3X2wmOzGKeWKhV8n2tkZWZnumYxHh9rFEHi9ctxs64sPjDSpfOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(46966006)(36840700001)(40470700004)(83380400001)(54906003)(40480700001)(40460700003)(36756003)(2616005)(81166007)(41300700001)(316002)(1076003)(2906002)(86362001)(110136005)(70206006)(7416002)(5660300002)(8936002)(4326008)(8676002)(70586007)(478600001)(6666004)(336012)(426003)(356005)(26005)(82740400003)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:33:47.0799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6aeb351-f92f-43c1-07f9-08dbd021e965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In further patches the nor->params references in
spi_nor_otp_region_len(nor) & spi_nor_otp_n_regions(nor) macros will be
replaced with spi_nor_get_params() API. To make the transition smoother,
first converting the macros into static inline functions.

Suggested-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/mtd/spi-nor/otp.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 9a729aa3452d..23fe75ddc9cf 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -11,8 +11,27 @@
 
 #include "core.h"
 
-#define spi_nor_otp_region_len(nor) ((nor)->params->otp.org->len)
-#define spi_nor_otp_n_regions(nor) ((nor)->params->otp.org->n_regions)
+/**
+ * spi_nor_otp_region_len() - get size of one OTP region in bytes
+ * @nor:        pointer to 'struct spi_nor'
+ *
+ * Return: size of one OTP region in bytes
+ */
+static inline unsigned int spi_nor_otp_region_len(struct spi_nor *nor)
+{
+	return nor->params->otp.org->len;
+}
+
+/**
+ * spi_nor_otp_n_regions() - get number of individual OTP regions
+ * @nor:        pointer to 'struct spi_nor'
+ *
+ * Return: number of individual OTP regions
+ */
+static inline unsigned int spi_nor_otp_n_regions(struct spi_nor *nor)
+{
+	return nor->params->otp.org->n_regions;
+}
 
 /**
  * spi_nor_otp_read_secr() - read security register
-- 
2.17.1

