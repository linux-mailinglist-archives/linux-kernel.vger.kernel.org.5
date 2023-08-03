Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C110076E139
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjHCHYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjHCHYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:24:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAA730F6;
        Thu,  3 Aug 2023 00:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmRbrgj6a/6lzjYw8LRu0hURMdJBQ3sDM1Zyra+pYpH2ZRwqD4gN6tnjk0JL7BPdO/J2HDGQ+ofl4tV1/asa7V84IIkiGB9069P9eChs3CnPN79GW6PHu2jSu//7c3gRaKjYFjIbzWFcwIpNXM4/1T7tOYgTT5qMW2FAGZ/YcwowJMrCituB/W7nnlkLyUm2EmhvXtnMFJj9O5/hvQznV0liLmd1Jkp1mFvEtBizHR9kMS4FmoNWcWTDGFr45T60IwlQlfFl4jWtD1sSxVf6tjMSSYC+zLLekSFtAfMQ+bEYQ3eCHSqy7c5fc4C1ky20xE6n7ECNgwNMuRrj4v6R9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IiXW7cucyPLWuMPcVAsOmTRyRLr96kiteBaOBJYEY0=;
 b=SfSVFrMEPtkt6G0mPUEe92ujDu5PxVmVT3tOZVD2EN6cYgfEqQEMPEXCKlG9TYPJVVdBXm9dJsiSc5HhCnmM+URRlvto4vKzqG7xD6NVbSFrPMw3nK5eRI5JlRgpWC2/KInE0WEUHDQ0UWMB4p4FJ1rsW2M0ReEIrRvOzVSMCukbrpAE1auyvcZ3yPrfNzgMQW4JUuffjcjuSeD6fVgiN6CSQYKmReIuLAPhsj8q9zc4i3xR7A5GWSgpZGRcy3R1zk6CfbuoJtMpk3AR1vJHyQJUC7h2HnFO5whehyPUYc/Ji7H9eEr2GFZPXdfImWCVYmKv2HtgSN3a9Otpa4qpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IiXW7cucyPLWuMPcVAsOmTRyRLr96kiteBaOBJYEY0=;
 b=iw6k/yH0CjassFzRA1CO4RQnkR9C/X4cIybUeqiv45GToWGih1o4xn8RazKZpSnuXSMhi7Onw4+m0MeQULEwO1kw56vkxDwrFHZQX+8TPj7+5GT/gc1xjrl2W6WdY+bwzWEazvfw937ESqUt7HP1rWvBVq9rfkTaPD4Y1410BVI=
Received: from MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::7) by
 PH0PR12MB5418.namprd12.prod.outlook.com (2603:10b6:510:e5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Thu, 3 Aug 2023 07:24:34 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::64) by MW4P221CA0002.outlook.office365.com
 (2603:10b6:303:8b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 07:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 07:24:34 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 02:24:32 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH 2/2] dt-bindings: spi: spi-cadence: Add label property
Date:   Thu, 3 Aug 2023 09:24:25 +0200
Message-ID: <82cd1a57397867b5a1039cd15244344c02a3ece1.1691047461.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <987430ee905fd299fe962663d94f848b341c87df.1691047461.git.michal.simek@amd.com>
References: <987430ee905fd299fe962663d94f848b341c87df.1691047461.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=michal.simek@amd.com; h=from:subject:message-id; bh=OKa5K4rEfanyCQWGCi96izfmui6MhFnkHoIQsjD2niU=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTTYWpyE7yl3R/Y/zO/4vfhaj/b7tdykjunFc7hz13p5 eS42KOuI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExkmj7DLOaXfozL07RZFRf+ YBcz0j+0IaZ8NcOCvtIlrx6qTtQz7T+XuPJ/gEWw6qVPAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|PH0PR12MB5418:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8f1aa8-8459-4709-393b-08db93f2afaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUvbp0nccpKMVM4cWjbqe/ufNScy5SmpBM803ONTKPARHJedR+d+emo5BICF9YX+7NX4On9rCJI9uCXqinuY976T3fASNLRyun68qVnpuzUQX4XPjlKy+aqwEUcszpMEJ5SsIMVAOJhI/A2Z4gJWmPNfJDxe2ROrcj5OnUhtV8NhG5yWE5413bhsxmFOZthYOrc6ei3EZi65Y51v9fovXh2gl5BC6cVxWRlCoHfa/AqE2HPpltQJnR4aCnUqqUyZwS36/DlqYR0RVEA6yJHZhpfS7RD2IczFdcxXqINyhLa2ChfqtPdvL1w5iAuUPhh76OCPhXfLaIx+uDZgye4Xfj6ZKCxnKq6Rp4a1AWEqTOF3uSvhRJAFVFN/GmBlx5lapvFufU13EmyS1wPY0ac0r25Pf32q3rliwlOE8cveNIEJGv9b2oB8Y0VWIK5W2vc+OJEoE165/UKyX7Qgy4a12ArLGmlFYYV9r+mtaXf2/stBcI9n519Ov9bF5nVELb1IxCn4laCvDIEgjeCiDlZ8HY5ngj13zPOTFSBdJjMqvcieW1hrzOmyJY8D6m1oS3/nPobJ2rBs1XEFW/neANvmaIEiBHokyefzZBY7t1SfEzH7lUytN+h1V3PEQCRfTm7zYIfgF0PKnVobNXdhygP8jZN9jmLCk6mVR0Qn4mKAjrgeAKMFlj7MpI/Q5gxdNtnO+P0Lyuzbg9Mexbq5X9kuYg23PprpBQIizf4lxAXwuXgXHC09bOII7OcwNj1fU7iNzfaWMNMIQ3YP3jhOCRih+KRqot5pCFPNCy98YZyf4QU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(40460700003)(16526019)(426003)(2616005)(26005)(186003)(336012)(47076005)(36860700001)(4744005)(316002)(70206006)(70586007)(2906002)(5660300002)(4326008)(44832011)(41300700001)(8676002)(8936002)(6666004)(54906003)(110136005)(478600001)(40480700001)(356005)(81166007)(36756003)(86362001)(82740400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 07:24:34.0359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8f1aa8-8459-4709-393b-08db93f2afaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5418
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a label property to allow a custom name to be used for identifying the
controller on a board. This is useful when there is more than one
controller present. Similar change was done by commit 412b7a521c30
("dt-bindings: eeprom: at24: Add label property for AT24").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/spi/spi-cadence.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
index 9eda7f0d2869..d4b61b0e8301 100644
--- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
@@ -52,6 +52,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  label:
+    description: Descriptive name of the SPI controller.
+
 required:
   - compatible
   - reg
-- 
2.36.1

