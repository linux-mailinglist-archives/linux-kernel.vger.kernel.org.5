Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4461975BD25
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjGUEMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGUEMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:12:08 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D9A2D56;
        Thu, 20 Jul 2023 21:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLqklGztvamKzNXscW0t3yAhHH+GjrUe9ooK+ocyK5xvgctKjc0A6qOHJsAnOyX46ND3rOvHBdz0x6ITnlO6Y0dAtcloosJQmZ0T+o9j39x13yP6pUyYZ3VQ2Gu6pXYHyPejyHtvJyrzQplooJuwf1Er//fOGnSYt9zwf3UTrevvLUvoFlswaXj+QKOkpO5jLx5VwMH4Rjv+OGrjR4QY+fLFP/tAxk3kRffkUyQH9Lsmztm1/Dnzx5FRm30y+iLI9iaEA3VBxSdJoSTmDMET5kSJqYuqClL7TCejbJeLKZwdomC+VQG2pwylzJPl7Bw/gfkEot8CvTeWe7tkotq/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WffyS0VOGOCv0mJMZQfrtHvHj8aTGNvwWksE/1ARQoI=;
 b=AO+A1qMRFlrdE8YNMCWI541nvY+XyOjD6ZOO9gbwLfIBgjiDbxlqgSjAcSP4RQiIJuRG3lU/hN1Jf8/iGDRx5AyT7R2czmWvW+zgEgTi3vNtFHeEdbR9PxVTl6xiDTLbK6smVyya0Igdnh1viU+PnKv8MbdCh5sM7MteSI2cEJ63bll6zSb1jC9bqa8OKyDPETsua7wd1dzRJt0fCsbadufso+3yeFexXyMLs6zTMvWps/9Ejhf0pN64iuUsJPSJNkS4r77pO2umvpLmq4x3ffzCHMCMPpYEbJ6QWvLQl/4Hc0BWYSPGckQL0ncVXpDZdk5tMqe8vUSiCHXxMgXRIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WffyS0VOGOCv0mJMZQfrtHvHj8aTGNvwWksE/1ARQoI=;
 b=4xpuubjhae66d92f00LtjfatooweNXChzGI9DTDA4H0sm8e+//X2CqKVTOvKsNmjx4fGLreebvyIMnMbrI3r4zg7pDPpVn+N944lbb8ZF4aah10rR1w4rUNo0K855qUZMQPzRvr+cpL/vvSr73Kye7bmiqG+kn9Mds8Ybb/JQ2g=
Received: from MW4PR04CA0107.namprd04.prod.outlook.com (2603:10b6:303:83::22)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 04:12:02 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::1) by MW4PR04CA0107.outlook.office365.com
 (2603:10b6:303:83::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Fri, 21 Jul 2023 04:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Fri, 21 Jul 2023 04:12:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 23:11:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 23:11:55 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 20 Jul 2023 23:11:53 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <michal.simek@amd.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V2 1/2] dt-bindings: reset: Updated binding for Versal-NET reset driver
Date:   Fri, 21 Jul 2023 09:41:18 +0530
Message-ID: <20230721041119.4058430-2-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721041119.4058430-1-piyush.mehta@amd.com>
References: <20230721041119.4058430-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 81152384-7468-4e31-3428-08db89a0a269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqGYKjjF1L/12iY+ardyxFWu2TSyFjBuerDl0HCyKp/tvt6edVpfY0h1do4sF7KiC+tf0+e3nK5NDAdOnpXy+CupeU76Nqwsb6FYsCLzwUc7469vSFHDUNTTDMQaFVijUEnicmsPycIPl/xYnMb7cyqU7Ujmlez0QUtxYMMgQtvliq4NEeDqUgA+h0sS+kL9RYU2SwnV3j7PPV3F805B271mshWPp1Xxg1yBdYUICFRDAwJJBb4RL8Uxc91P5EN1cgrNfR2HtCR7ZL1Bi/7G1/qxW2QATnpyVH/1NtANGhCRsqtcugK8FthqzTr+hPCuNR1zhaQd8lm2yfXGTJDMvpN5FmsDvb0KySVJkb409u/7Nw0RfpLpJS3SCrFdvyWwIRP3zCaXGMEUa1Hhz78l0z3gqO+auVwjVA3F7Oji/V7Hca5EWsrighADO+YKNszqI8k20NHb6CpuqXoEXy8Rcr1SAgVsnnq0QCqRjkcFjoTBQRVAnLIkSmSE5oA5E2P6nD5G5NIE3WWlkD2J0tD0QQGIBkpj/y2/KiyeqVqjJubXBiAlIA2H61yogHmpvuDGpVqYmBQSxO4NYwhmoDWzpM2vNjzIfwSclXyADfm5m1VdoL0fl4vnW0NgOfamWDt7fjHNMXddfkV1fClT13yT+AxQRXMmUFtglXDacx0gOK+KkFr3wJtaSglTRCxKmJf+egGysut5btTIBfywnfXu3MpD9Rc5Y9HLFR37G16fF9V7aP0l9CJ4k+7pzICNT7xirafrrCUCHEknownmk2aeFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(54906003)(6666004)(478600001)(110136005)(966005)(186003)(2616005)(336012)(82740400003)(1076003)(15650500001)(2906002)(4326008)(70206006)(8936002)(44832011)(70586007)(6636002)(41300700001)(5660300002)(47076005)(8676002)(81166007)(26005)(316002)(356005)(36756003)(86362001)(40480700001)(36860700001)(83380400001)(40460700003)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 04:12:01.4071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81152384-7468-4e31-3428-08db89a0a269
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added dt-binding documentation for Versal NET platforms.

Versal Net is a new AMD/Xilinx  SoC.

The SoC and its architecture is based on the Versal ACAP device.
The Versal Net  device includes more security features in the
platform management controller (PMC) and increases the number
of CPUs in the application processing unit (APU) and the
real-time processing unit (RPU).

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
Changes in V2:
- Addressed Krzysztof and Conor review comments:
 - Updated the commit message [1/2] with detail description of Versal NET SoC.
 - Removed the dt-bindings include versal NET header from the binding documents
   as it is not used by the driver.

Link: https://lore.kernel.org/lkml/20230717112348.1381367-1-piyush.mehta@amd.com/ 
---
 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
index 0d50f6a54af3..49db66801429 100644
--- a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
@@ -32,6 +32,7 @@ properties:
     enum:
       - xlnx,zynqmp-reset
       - xlnx,versal-reset
+      - xlnx,versal-net-reset
 
   "#reset-cells":
     const: 1
-- 
2.25.1

