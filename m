Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD227D8915
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344789AbjJZTmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344785AbjJZTmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:42:19 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA291BC;
        Thu, 26 Oct 2023 12:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAqzUfhOwGbLnfhCPF1oVoJGNCSB2bzAmAf892MuR9mrKHVrbSH96r0hafgBymiajdN3GbaZ7+fZpGsnghQ+uCu/Tmk2AizK+iplq1t2fUjNK5zD7CPGZMXtPMFpy7UJjRNR2ifIxgayeKxcIDiNhX5wiKHOhEngjuFLa77zck2lg9yeA1msr48MlW/MSZnq2Zk0od3p9U1mDZC9+DfjFvaU2hLqktFKjZFftEeNEJwglanqp/pqCxdSsAY67URrZEIKAxL82yUBn08NWZAiNZibJfm9+dVDpVX+H+5qEmqZQ9+IemZW8LFyCyR24lTZVwC1hCscvNOt2JFHxUIPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZOvWaa4e6CGB762KJTySSBrF8rVKvUyILfvSBU4Mgw=;
 b=fROqw5hmOXhk4Vu1wdzU3my3EsXQ7TERSUZa3xniEt2y/yMJS5WPxrewrRwEMn27zQkdBrqDgwObsNXlZ9bs5wbWleFRo8vMzvs1ndWEgDzAUiVUsJiBf0UDkiu+p4BR8x3IAS6KvZ6ckZ4adSaesgnpE+qwTJoKiLXlr1HhC6BCJmuwpbGB2wqBHS2nV7jd7LVnVx5fNdtibgGReLOI783EJ8xkAm8xbU35VrJgZf967JLRFPaayvuMfqWjqbMRwUx2+qtB3fymOKeWzr+iu5Bb+7yl0HSZqnC6x40AHwGt9Ljsb0ISFo9DVuRf4jttmvwT6A+MUmA3UkOKy1W8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZOvWaa4e6CGB762KJTySSBrF8rVKvUyILfvSBU4Mgw=;
 b=k4r0SdBP/uy+oBwiPPJMyg3NVNEyBs1VgZ1RtTfiyOHa1ScY42Ryzoi2eamktdf0594RwBhmotNg721T9/9CxwtGjDfcNA6UBixMus2eiW28bnloH6wt9TtdIAuYiNgp4pM5w1xsyhgjHpTzP+DmyCqC/nLdJ1+U+2G0JxM39fk=
Received: from SN7PR04CA0219.namprd04.prod.outlook.com (2603:10b6:806:127::14)
 by SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 19:42:13 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:127:cafe::d1) by SN7PR04CA0219.outlook.office365.com
 (2603:10b6:806:127::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23 via Frontend
 Transport; Thu, 26 Oct 2023 19:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 19:42:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 14:42:12 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 26 Oct 2023 14:42:09 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <sebastian.reichel@collabora.com>, <broonie@kernel.org>,
        <jassisinghbrar@gmail.com>, <jay.buddhabhatti@xilinx.com>,
        <naman.trivedimanojbhai@amd.com>, <nava.kishore.manne@amd.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH] dt-bindings: firmware: versal: add versal-net compatible string
Date:   Fri, 27 Oct 2023 01:12:08 +0530
Message-ID: <1698349328-2321184-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SA1PR12MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: efc0999c-5a0a-4069-962f-08dbd65ba6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3laa80rqfEIKKSxVsCDO7qDKiScls7YKhX7BHqD0hTM9xvB6NnJ72jeiNeZMJd5d7yb45McMB40hj/Xt/lK77oDZBZdRvv5RvpIC55CUKmboocTvnoTDbjGort9cPRieeE14kxt16Xgqo05sxu6AbAyp4uBmawu4AVgomW2fObMeA8kcQ40lAKRwBVqdzRZHmr1IGSqk93AH/I2mMEq+R/lwSDhlTN+hJlVcP0Y4eqzGRq0ppvk7WYsflA6+NQcmubC50uSA8F2Va7ovaIdSO9wzg15P8ZeQ5QVcOsTkiZM9Fv23L9dDO+xkFnaCIrln2D7RuSRTp8EQoub6L+MMwpvwgSmBMtMd77Bge9tCVK9sw8Yp2Z2Y4jAK4s4jdfjxFl78H12LF6HD3C6X6pdwDdsayJWLfcZP8AnkBoTIMw4pLkKnY7wlvSNL9sLqxj+JLdk0K6qGuG7RM5o1/B86s56U+z2gmsbVvpnVa1u1M60a4iTyiSRsVb0o7DoB4mgS9FCqVo2Iz2cWuJfpN9VMkTPP/IJFhN061fiuZJmaqCtA/zksDtxzBVB0G0L3xx2034Tqk1DrIlsj4OAgPD4dPvSzGbyEZjKCC7BbWeD/XfLNI1fjBc7F00W+0jUySBrZ68+ufD3/3GYwZ3O/+LoVPLGPcL531L0vlgTait00UNi2MeIeaVeUCD3oAAHgnXimxc70u669CgM7ddHMadf8veVNUdZQcdlmBuGaFy1XyZPk4xCF2n3tXLbRu6Di5TfbWPqmP6It8DmSxjHwX1gKFmkkWcKgWT5EgBGMt/d/Y+xit939CFEUhLeTzn35BcYPW1xGPvaSGxFlmpPb730jug==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(36860700001)(6636002)(478600001)(316002)(54906003)(70586007)(5660300002)(70206006)(4326008)(921008)(966005)(8936002)(8676002)(110136005)(40460700003)(41300700001)(2906002)(26005)(7416002)(40480700001)(83380400001)(86362001)(426003)(2616005)(81166007)(336012)(82740400003)(356005)(36756003)(47076005)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 19:42:13.2602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efc0999c-5a0a-4069-962f-08dbd65ba6e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jay Buddhabhatti <jay.buddhabhatti@xilinx.com>

Add dt-binding documentation for Versal NET platforms.
Versal Net is a new AMD/Xilinx SoC.

The SoC and its architecture is based on the Versal ACAP device.
The Versal Net device includes more security features in the
platform management controller (PMC) and increases the number of
CPUs in the application processing unit (APU) and the real-time
processing unit (RPU).

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
This usecase also looks similar to versal-net clock upstream compatible
discussion[1], so inline with mainline suggestion i have modified
firmware binding. Also firmware driver can be modified later
on when there is a real SoC specific compatible string need.

[1]: https://lore.kernel.org/all/20230620110137.5701-1-shubhrajyoti.datta@amd.com
---
 .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
index 822864488dcb..c5483d80ce3c 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -26,6 +26,12 @@ properties:
       - description: For implementations complying for Versal.
         const: xlnx,versal-firmware
 
+      - description: For implementations complying for Versal NET.
+        items:
+          - enum:
+              - xlnx,versal-net-firmware
+          - const: xlnx,versal-firmware
+
   method:
     description: |
                  The method of calling the PM-API firmware layer.
-- 
2.34.1

