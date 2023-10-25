Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376D57D63DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjJYHqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjJYHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:46:02 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E215D3C01;
        Wed, 25 Oct 2023 00:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aD1HXrSL4JpT7l6NTHSM/6oVuwCvTXoZldxf9+7plya0LQKL87HzAq4E5moz1ybUazpGZbXU8faqQ/GbvqiX6P6giewY01A4sr4Es+i/dzurCExDyBgZegPkyBuIjsAs0Y/Wx0Y6fWE7UoZ5Pxb+/+p9iAHp2cxE8K6h2A2mrxiHbX9lGanGD60B39PFAj69jRL9mDmFXKO6OJL6+j0TE0DoQFsSUGa8a3H7T2Ror1y76bKxKG6sE7gyxMkTdnx7YKxlBYxeFr45p8Mj9KRsL88xH8AvwBA5JaupA9KJWG91VZot8Y29EfM/fk4PB8ebUAqfzpWvzRLdQ6Z3vRQC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAgaZShz+j9RBH+IhtiZKlkiSI79z9oHr/WIVdQl0dA=;
 b=YMUyZGh7UE5WJdM5l4CNvXuNT8CaRMNDusUVW+7tRdEAgwBe9AJ79KsuSGVhi7y08LgXURIzlte2ktFk6n/mvx7BEHFnGQedt0ZBQTFYJjaKKz7Z0uDu5UFxDZuSfWeYsL2hSu71dP6bm2SKrRA6/ITVQpYlCirKRcJcdf2j28D5YkBMwK7JJjigQuDFsiRSsv5D4B0KTKn3/fUCLQsh7uNSTvyYs4OcJnjtPdt4SBB57wLQ1sg7cpfSYyOEIf+fx8SdwRA7k56LGPldI4MGV+XPNKwfLvJWPYkHNC23Ck9sdPKaJPAftrtdVJgzPEHhEPJvEUtlm5FdDimN+uL0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAgaZShz+j9RBH+IhtiZKlkiSI79z9oHr/WIVdQl0dA=;
 b=3LTBh1zprNiwxiYzMyLsD63iw7r9+K8fGj62C0l9GCTO62o1+kEzzzz8ol6EA9aHRGKQEsv3+wR2+d77INIlGyK8IDFNVfMLIvtaAAOYgznTdipPMGiomHfbMbq98e2qPY0NBCbyA/vQhTdwloFsS+ok8qpSlvIQNLHoG4qlit4=
Received: from BYAPR21CA0002.namprd21.prod.outlook.com (2603:10b6:a03:114::12)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 07:35:26 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::b5) by BYAPR21CA0002.outlook.office365.com
 (2603:10b6:a03:114::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.4 via Frontend
 Transport; Wed, 25 Oct 2023 07:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 07:35:25 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 02:35:22 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 6/7] RAS: Get CS fabirc ID register bit fields
Date:   Wed, 25 Oct 2023 07:33:38 +0000
Message-ID: <20231025073339.630093-7-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025073339.630093-1-muralimk@amd.com>
References: <20231025073339.630093-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbc378d-1015-4740-b5a7-08dbd52cf43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHS+Fz3hLFFKCUrD+XaPiWIb5aMWAjTcoxnOQOHvcoZkzs+CcZPejnmhVvT547yqsL3MCk0Slu1Krq1O0sIURLRkiA1uVp4YCuMAY1/pWE498XT/ISgz9566jOWb2Ed6rX12Q+hTnGEfobPJoqPZwetyG+YTVpFvTpZ8T/3hbm3YloTSaLk4AYDXZUL6AyD+Us+uHO8hZTteBAdUyR0GNddeGsG+AtWPs+tmYAUsjmR0upWqDNe5QnZ1VkFEmtUVUy3eT+QPgNVgf+GRXZqwbuO8xaE+uCwOhMIku5kUfVXBre+UFHazRIXPOvBL0WI8VymBY8kEkaq0pTU+1jY0Xpdq3ScRxkA5qiu0zIeeM9z6mT4b+ypzeDTNCZBwQJafs/0S0h4p+FYez8c7xwfl8SS2RDPtzf7Y+HpedhELl0sisamkKUFsOFlycMkDlnd81hHY9vqkAFc4XG52dzX37bxIOCNQoy4TReOYPpH7I5QlY9fsflQC7UaQ3JfgivdUWVKX/yI5eGqFdys8NpgUsPCB+dg9QT6kBqxeglh+dIxp3EFczVOsWNtJzuCTIBwtil42TPpferS5M9coGmet5aeP9aWkxTvvAS+CzL/19O9lR4+9mPFHyxPlOkU1Oqi+QT1x8iXwWO6jalSFCBwTuW87DMOHPrL6Wnj58xq7FVyF+G+TbpNHSNdmsaWOt7UtM1bFQILP6wE/wZNiZnIzXcuS2DNmQ9QWzbiU4S5lB2v1dJSPvJomaUoXp4f1jJXkGhdCGBvqIrDp7FMXXSV2YA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(40470700004)(36840700001)(46966006)(36756003)(478600001)(6666004)(4744005)(81166007)(426003)(5660300002)(336012)(7696005)(2906002)(83380400001)(2616005)(40460700003)(47076005)(1076003)(41300700001)(316002)(70586007)(70206006)(54906003)(110136005)(36860700001)(4326008)(8936002)(8676002)(356005)(40480700001)(16526019)(26005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:35:25.4613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbc378d-1015-4740-b5a7-08dbd52cf43d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Read correct register bit fields for cs_fabric_id for
address translation to work.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/ras/amd/atl/reg_fields.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ras/amd/atl/reg_fields.h b/drivers/ras/amd/atl/reg_fields.h
index c3853a25217b..6b60091f235b 100644
--- a/drivers/ras/amd/atl/reg_fields.h
+++ b/drivers/ras/amd/atl/reg_fields.h
@@ -28,14 +28,14 @@
  *	Rev	Fieldname	Bits
  *
  *	D18F0x50 [Fabric Block Instance Information 3]
- *	DF2	BlockFabricId	[19:8]
+ *	DF2	BlockFabricId	[13:8]
  *	DF3	BlockFabricId	[19:8]
  *	DF3p5	BlockFabricId	[19:8]
  *	DF4	BlockFabricId	[19:8]
- *	DF4p5	BlockFabricId	[15:8]
+ *	DF4p5	BlockFabricId	[19:8]
  */
-#define DF2_CS_FABRIC_ID	GENMASK(19, 8)
-#define DF4p5_CS_FABRIC_ID	GENMASK(15, 8)
+#define DF2_CS_FABRIC_ID	GENMASK(13, 8)
+#define DF4p5_CS_FABRIC_ID	GENMASK(19, 8)
 
 /*
  * Component ID Mask
-- 
2.25.1

