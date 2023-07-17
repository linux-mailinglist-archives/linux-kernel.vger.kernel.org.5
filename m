Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD40756180
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGQLZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGQLY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:24:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A161DE4E;
        Mon, 17 Jul 2023 04:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vsaoy0UaF0uH/AF2kSQacG1VduMVHUmg/cDhLtNjS8U79Ko0WawcJBfh4w1ywgGFA6QkOdaFgvXnprj5juAtutQ/xIGnzkkQQriTaeO9UKSVvAEvTnkKVFArqJw/vD1bq8tyMYIgq1ySmyGDS57bNRQdkPiOtGuE1gz+h6YSawM8/nwqVuwhb13QwRShzM69dlUYwSUfsRTruVoqguE/inzhavudfVnzrAt7+FazN3OfS6QVcAcNjtZDT6C8Ql7p81vMO7Xh/ecsSBp3JVlAtLBdRjqoxKy5hIpp90lvth8StOvsomFIGuWc+EAtL2Bp6vnZTAvQaAMjxG4QX3j7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnSMr+FUu31qvyUrZlq17OTbcpj/hKk8Bl/utBHS8HQ=;
 b=D3FK7cCX/jjWzmQAbB4pzvcSx/uTeto8nRpE18m7CHEpzpPEQ1H3uJwB/CcNzrbpaJmtL5fOndtzLbiX7LX5zLLHsRzPyc5/zx4wHy9gQpVwpnK8EXZRvM4UQQAcxDYofUyPDZsfcgeEEO6hOvWwSEZkFNMHSSxxvM0CiWsmFRrDiJHymJXzajd4krwcR8ssSKJ2djiGUYmS/8g8orICXmYHCEhNBfj1qcPU5N0v7bf3DswW7thquQVMr+XrOm0XHEa8/WthwkM2DVT33evQWMW/I9f00locUONuZOU1LHtJ+OjRLSmMDi6w7Pf96sjILU/S12TTTwSLff5GQh9Bfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnSMr+FUu31qvyUrZlq17OTbcpj/hKk8Bl/utBHS8HQ=;
 b=CIpRg452/iLej3Vkhym3LRkaUiCLD3k/yJ4K3O1pRFtwCXi2y4JrGrEMrBzyVzX97+1VEASa+BXOMZSsROZE3gzrnh0m8t5X0mboDFHK/4zBi+vIYJ3OSc7AAFQjlrBl1fBsr/G3WFQBl9Cnk4dWVy0FxGGdBN7Xd3GOyR+RTu8=
Received: from MW2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:907::16) by
 DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 11:24:51 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::fc) by MW2PR16CA0003.outlook.office365.com
 (2603:10b6:907::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 11:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 11:24:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 06:24:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 04:24:17 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 17 Jul 2023 06:24:14 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <michal.simek@amd.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal-NET reset driver
Date:   Mon, 17 Jul 2023 16:53:47 +0530
Message-ID: <20230717112348.1381367-2-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717112348.1381367-1-piyush.mehta@amd.com>
References: <20230717112348.1381367-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: e183ad5f-4eaf-4d2a-019b-08db86b87009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVU6bg6LzL/yq4gJb3KcYil/xqaS+Mhn4i6KzpELIT7mxAS8VGZb31aHjMucP2S5txUoP3IKJ1fjA11Xz7a45aK0TOxZjevD7a/Nv75fQVZfsd2cdVR6OZdDQ7GYjGE01beSMSynoRCg4y8VufbqW55lXkc0nO5lQ2EalDVHfg0/J6mTWdTJUv7Jz0Y88tOcIxomb7wHy6xkrpwiU71QMStN1nSofFtGXrQHKo2YvuoxOVhn8JP/62eAUlm7YyrxP5ABxPExn4YZqNQJ36/YqG9FSpE9UfIIG4xaR3zG6pIeFKXzR/Ih2xGCZhfz08GPlt29E5jnsN9hWgn8eHCzACgkdT0LkaAm+5U/C2bspTeheAMgKYlWvebeVXfx3hqkbYwgKhrKVR0csb4xHpYxyWrZbqa4AyNVAZfNKSZqyZ5IuYqst9iK9StMhZATH5Cl3JDNOGxwKDosVT0C6PtLGcGZujWIyr+izI/7GGsS2hYbaO4VtybdfkUfgCkzGX38kvyu7qQRnr3MhcAOMCRhiDwi5aswWbqvX9dxwDkhmtBD/66Ss4n9p6DUobIdNvG+tw7lWP2RCgx7ciKtPCwSWIcXPuDjLMD5QAhsCRh+IkjS3oAGUT/spqm1fD0BrdkgrAxwmg1o4ANZjdxxBRx2qfyl2VfRuh2ppD4T4cZuuyEqvRiiz7N3/JYpVhpAVwpak5JhjPkvB6B4vma7GfPxaccTV2Em2r6OO3eidKzIs5eClDZVH6toXAO9p2JqYgqN+v/C3v/r7aR8gFGxiw3NDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(54906003)(6666004)(110136005)(356005)(81166007)(82740400003)(6636002)(41300700001)(5660300002)(8676002)(478600001)(8936002)(70586007)(4326008)(70206006)(316002)(2616005)(36860700001)(83380400001)(186003)(47076005)(26005)(1076003)(426003)(336012)(86362001)(36756003)(44832011)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 11:24:51.3081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e183ad5f-4eaf-4d2a-019b-08db86b87009
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added documentation and Versal-NET reset indices to describe about
Versal-Net reset driver bindings.

In Versal-NET all reset indices includes Class, SubClass, Type, Index
information whereas class refers to clock, reset, power etc.,
Underlying firmware in Versal have such classification and expects
the ID to be this way.
[13:0] - Index bits
[19:14] - Type bits
[25:20] - SubClass bits
[31:26] - Class bits.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 .../bindings/reset/xlnx,zynqmp-reset.yaml     |   4 +
 .../reset/xlnx-versal-net-resets.h            | 127 ++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 include/dt-bindings/reset/xlnx-versal-net-resets.h

diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
index 0d50f6a54af3..b996fc1d4e53 100644
--- a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
@@ -27,11 +27,15 @@ description: |
   For list of all valid reset indices for Versal
   <dt-bindings/reset/xlnx-versal-resets.h>
 
+  For list of all valid reset indices for Versal-NET
+  <dt-bindings/reset/xlnx-versal-net-resets.h>
+
 properties:
   compatible:
     enum:
       - xlnx,zynqmp-reset
       - xlnx,versal-reset
+      - xlnx,versal-net-reset
 
   "#reset-cells":
     const: 1
diff --git a/include/dt-bindings/reset/xlnx-versal-net-resets.h b/include/dt-bindings/reset/xlnx-versal-net-resets.h
new file mode 100644
index 000000000000..b3e7d5e4c33e
--- /dev/null
+++ b/include/dt-bindings/reset/xlnx-versal-net-resets.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
+ */
+
+#ifndef _DT_BINDINGS_VERSAL_NET_RESETS_H
+#define _DT_BINDINGS_VERSAL_NET_RESETS_H
+
+#define PM_RST_PMC_POR                          (0xc30c001U)
+#define PM_RST_PMC                              (0xc410002U)
+#define PM_RST_PS_POR                           (0xc30c003U)
+#define PM_RST_PL_POR                           (0xc30c004U)
+#define PM_RST_NOC_POR                          (0xc30c005U)
+#define PM_RST_PS_SRST                          (0xc41000aU)
+#define PM_RST_PL_SRST                          (0xc41000bU)
+#define PM_RST_NOC                              (0xc41000cU)
+#define PM_RST_NPI                              (0xc41000dU)
+#define PM_RST_SYS_RST_1                        (0xc41000eU)
+#define PM_RST_SYS_RST_2                        (0xc41000fU)
+#define PM_RST_SYS_RST_3                        (0xc410010U)
+#define PM_RST_PL0                              (0xc410012U)
+#define PM_RST_PL1                              (0xc410013U)
+#define PM_RST_PL2                              (0xc410014U)
+#define PM_RST_PL3                              (0xc410015U)
+#define PM_RST_ACPU_GIC                         (0xc41001aU)
+#define PM_RST_ADMA                             (0xc410026U)
+#define PM_RST_OCM                              (0xc410028U)
+#define PM_RST_IPI                              (0xc41002aU)
+#define PM_RST_QSPI                             (0xc10402dU)
+#define PM_RST_OSPI                             (0xc10402eU)
+#define PM_RST_SDIO_0                           (0xc10402fU)
+#define PM_RST_SDIO_1                           (0xc104030U)
+#define PM_RST_GPIO_PMC                         (0xc104032U)
+#define PM_RST_GEM_0                            (0xc104033U)
+#define PM_RST_GEM_1                            (0xc104034U)
+#define PM_RST_USB_0                            (0xc104036U)
+#define PM_RST_UART_0                           (0xc104037U)
+#define PM_RST_UART_1                           (0xc104038U)
+#define PM_RST_SPI_0                            (0xc104039U)
+#define PM_RST_SPI_1                            (0xc10403aU)
+#define PM_RST_CAN_FD_0                         (0xc10403bU)
+#define PM_RST_CAN_FD_1                         (0xc10403cU)
+#define PM_RST_GPIO_LPD                         (0xc10403fU)
+#define PM_RST_TTC_0                            (0xc104040U)
+#define PM_RST_GPIO_LPD                         (0xc10403fU)
+#define PM_RST_TTC_0                            (0xc104040U)
+#define PM_RST_TTC_1                            (0xc104041U)
+#define PM_RST_TTC_2                            (0xc104042U)
+#define PM_RST_TTC_3                            (0xc104043U)
+#define PM_RST_WWDT                             (0xC410079U)
+#define PM_RST_SYS_1                            (0xC41007AU)
+#define PM_RST_SYS_3                            (0xC41007BU)
+#define PM_RST_SYS_2                            (0xC41007CU)
+#define PM_RST_I2C                              (0xC410085U)
+#define PM_RST_FPD_SWDT_2                       (0xC41008AU)
+#define PM_RST_FPD_SWDT_1                       (0xC41008CU)
+#define PM_RST_APU3_CORE1_WARM                  (0xC514099U)
+#define PM_RST_APU3_CORE3_COLD                  (0xC61809AU)
+#define PM_RST_APU3_CORE0_COLD                  (0xC61809BU)
+#define PM_RST_APU3_CORE1_COLD                  (0xC61809CU)
+#define PM_RST_APU3_CLUSTER_COLD                (0xC61809DU)
+#define PM_RST_APU3_CORE0_WARM                  (0xC51409EU)
+#define PM_RST_APU3_CLUSTER_COLD                (0xC61809DU)
+#define PM_RST_APU3_CORE0_WARM                  (0xC51409EU)
+#define PM_RST_APU3_CORE2_COLD                  (0xC61809FU)
+#define PM_RST_APU3_CORE2_WARM                  (0xC5140A0U)
+#define PM_RST_APU3_CORE3_WARM                  (0xC5140A1U)
+#define PM_RST_APU3_CLUSTER_WARM                (0xC5140A2U)
+#define PM_RST_FPD_SWDT_3                       (0xC4100A3U)
+#define PM_RST_APU1_CORE1_WARM                  (0xC5140A4U)
+#define PM_RST_APU1_CORE3_COLD                  (0xC6180A5U)
+#define PM_RST_APU1_CORE0_COLD                  (0xC6180A6U)
+#define PM_RST_APU1_CORE1_COLD                  (0xC6180A7U)
+#define PM_RST_APU1_CLUSTER_COLD                (0xC6180A8U)
+#define PM_RST_APU1_CORE0_WARM                  (0xC5140A9U)
+#define PM_RST_APU1_CORE2_COLD                  (0xC6180AAU)
+#define PM_RST_APU1_CORE2_WARM                  (0xC5140ABU)
+#define PM_RST_APU1_CORE3_WARM                  (0xC5140ACU)
+#define PM_RST_APU1_CLUSTER_WARM                (0xC5140ADU)
+#define PM_RST_APU0_CORE1_WARM                  (0xC5140AFU)
+#define PM_RST_APU0_CORE3_COLD                  (0xC6180B0U)
+#define PM_RST_APU0_CORE0_COLD                  (0xC6180B1U)
+#define PM_RST_APU0_CORE1_COLD                  (0xC6180B2U)
+#define PM_RST_APU0_CLUSTER_COLD                (0xC6180B3U)
+#define PM_RST_APU0_CORE0_WARM                  (0xC5140B4U)
+#define PM_RST_APU0_CORE2_COLD                  (0xC6180B5U)
+#define PM_RST_APU0_CORE2_WARM                  (0xC5140B6U)
+#define PM_RST_APU0_CORE3_WARM                  (0xC5140B7U)
+#define PM_RST_APU0_CLUSTER_WARM                (0xC5140B8U)
+#define PM_RST_FPD_SWDT_0                       (0xC4100B9U)
+#define PM_RST_APU2_CORE1_WARM                  (0xC5140BAU)
+#define PM_RST_APU2_CORE3_COLD                  (0xC6180BBU)
+#define PM_RST_APU2_CORE0_COLD                  (0xC6180BCU)
+#define PM_RST_APU2_CORE1_COLD                  (0xC6180BDU)
+#define PM_RST_APU2_CORE0_COLD                  (0xC6180BCU)
+#define PM_RST_APU2_CORE1_COLD                  (0xC6180BDU)
+#define PM_RST_APU2_CLUSTER_COLD                (0xC6180BEU)
+#define PM_RST_APU2_CORE0_WARM                  (0xC5140BFU)
+#define PM_RST_APU2_CORE2_COLD                  (0xC6180C0U)
+#define PM_RST_APU2_CORE2_WARM                  (0xC5140C1U)
+#define PM_RST_APU2_CORE3_WARM                  (0xC5140C2U)
+#define PM_RST_APU2_CLUSTER_WARM                (0xC5140C3U)
+#define PM_RST_USB_1                            (0xC1040C6U)
+#define PM_RST_SWDT_1                           (0xC4100C7U)
+#define PM_RST_SWDT_0                           (0xC4100C8U)
+#define PM_RST_RPU_A_GD                         (0xC4100C9U)
+#define PM_RST_RPU_B_GD                         (0xC4100CAU)
+#define PM_RST_RPU_CORE0A                       (0xC4100CBU)
+#define PM_RST_RPU_CORE0A_POR                   (0xC30C0CCU)
+#define PM_RST_RPU_CORE0B_POR                   (0xC30C0CDU)
+#define PM_RST_RPU_A_GD_TOP                     (0xC4100CEU)
+#define PM_RST_RPU_CORE1B                       (0xC4100CFU)
+#define PM_RST_RPU_B_TOPRESET                   (0xC4100D0U)
+#define PM_RST_RPU_CORE1B_POR                   (0xC30C0D1U)
+#define PM_RST_RPU_CORE1A                       (0xC4100D2U)
+#define PM_RST_RPU_B_GD_TOP                     (0xC4100D3U)
+#define PM_RST_RPU_A_TOPRESET                   (0xC4100D4U)
+#define PM_RST_RPU_B_DBGRST                     (0xC2080D5U)
+#define PM_RST_RPU_A_DCLS_TOPRESET              (0xC4100D6U)
+#define PM_RST_RPU_CORE1A_POR                   (0xC30C0D7U)
+#define PM_RST_RPU_B_DCLS_TOPRESET              (0xC4100D8U)
+#define PM_RST_RPU_A_DBGRST                     (0xC2080D9U)
+#define PM_RST_RPU_CORE0B                       (0xC4100DAU)
+#define PM_RST_I3C_1                            (0xC4100DFU)
+#define PM_RST_I3C_0                            (0xC4100E0U)
+
+#endif
-- 
2.25.1

