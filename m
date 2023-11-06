Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978707E2021
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjKFLh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFLhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:37:54 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D896C9;
        Mon,  6 Nov 2023 03:37:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LX+d9vP7+ST9XqmmTcMMJl8NFHzy1gASjzg0Kdd7yvotKgxGtGNzDQI3lwJLU6Kv+Ez9UiLqHMW/DaQ/9cOkWNQw6dvvHggbDsxOajoSgm4nPTFyCixyoIi95E3KS8rsPMNc1HD81VcdJlG0j8qAwBh9KDbAFbG0m+BZjF8rG0KfFWEJXStxLn1Ua/7wJHB8mHfGXaTKB+oEo1mW4mgPTH+OOWbc001YJZlW4+yRMr6EK2yt29WqA3QudSy8MdGv/o3ctamiEX4O1XNzYw9VwGgupyMVSyT/STiUwT7Z5pAQQ/fgS6zlGNhGroQimW5My2BUgHv2kwOVxNKaMFkrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaGt9hTZSBqN0T4fS+Jsob93A7Lkuy+bZK/a7sxL2OU=;
 b=lGlGCyzc8L7zbyS26pNXaqWKVjPfJZtGmxRoNUS0IZb8xweokh5fTdm0pFUtvLkgnOCjP9RvatAd+KB29YacF/J8kjkWztVlkWH1BHZTg4M7VwP+aMmX31VKbo7iCawvs8/5AvFLP23SQFeDAXSEpVzXpN7QUlaH+nqhQFtKr0bNCZfiyurcm+TqyMGIJ+G07GGZweplOzjAHmecuNxESBH7t7OpWc2lovYpxpq8DQQhXT7i4ibGzlRhP+qRej+IV2EQGf+D9EOxeQ/YMat2+QIozyM2YGUHYtv2Ldi4VsbsiHO43kQFFTpsqhJYAOkGPYDIqXyTBtsoazOEznAATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaGt9hTZSBqN0T4fS+Jsob93A7Lkuy+bZK/a7sxL2OU=;
 b=knDFHnno0bCPCAvsuZk63sPn3Hx9BARe32l376ucjYR2KoDr1bHAMj0lmZPtKIxUbKK0pnhOlR9W9XMihJuiCM4wRUynYY3B+z3BgaVR+m08IU8Lbg627j/0p6PGXCc9hcPbmzlycsQn1OPJJcmMrSwLIoPCW6B+NzWMizfQWC8=
Received: from BL1PR13CA0412.namprd13.prod.outlook.com (2603:10b6:208:2c2::27)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 11:37:49 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::3d) by BL1PR13CA0412.outlook.office365.com
 (2603:10b6:208:2c2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16 via Frontend
 Transport; Mon, 6 Nov 2023 11:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 11:37:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 6 Nov
 2023 05:37:47 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH] dt-bindings: riscv: cpus: Add AMD MicroBlaze V compatible
Date:   Mon, 6 Nov 2023 12:37:47 +0100
Message-ID: <d442d916204d26f82c1c3a924a4cdfb117960e1b.1699270661.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=776; i=michal.simek@amd.com; h=from:subject:message-id; bh=GDvq6KqQCHIitPu5PpTWyii0iccwgdh5z1vhjvJcVwo=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSPC6zfGjfnNkvOtrZXXaukxllaseVvvNXuh5zC0dsct if8ePepI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExEQ4VhfmadlVvD5idP5oXu 8L50u7+4f/ODAIa5Mu92NL6eKK/XMeXQk1lPYqTtGy2eAwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|BL1PR12MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e80ce2-fe9b-4cbe-d9bc-08dbdebcce1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JI37KEr9Ztjy9iq/c2/zB7kbdsiM1ZP6uv9hiBBb09fQoeBcVBqKs4Pr0q3htZXgrLfH/LsLm/czE2n76IVdMrMj6gIcZvmG6i/N4dCm/kI2GdDiwwsXyYDZhQC3PTDrLSaMnJEssqG+2kH3YJzBAZjXIOem6StszpzAHNJJq2bnKorUmwi9zJAEuSx4SBfuJ9t9t4bWV0D7D+M28KUusrEux+oYlXaqiU/7//zcA2SSgXoywQS539Y60kL81/LJkeLtpJhzd5ZXbymWzR01UulbBv5cqliG0SBTBxvpF7LsK5FkM9XSpR/G8rl39kg0FncGNA96bg7S0mBnzaaf3lcGcsBHFM7Kmt2VxE6PGRJJ85peen+hZyCi7ujuDJzzxRcf3K0yRoetl21kd4EgCEOWenuejJ9tv4J/jQOy6oxaGUQE5lpPe7g7tfjvRjK4CQh86ppshuQa1Ki4wVskzH1HQTDWJAJRrlpx44nqMJcuShgxEDZJebgPbVPVO/JabTGGPSeRVla+YZONUwbLmFtmMeJonVlcaMTKkhP0DzzF2XlNuj1VaKfA0O9KteZytKSPjt8iUOugO0ZgsC2Cl85aPUmcDzItvMnHciEV+edMz6R/7FANcoDe0tJQZ3GucnJwHj53kirBxoxk2cmHAuwHGeE12/Ga7k7vs20FWYktrq4tIJBt/bag+BKpSGeMDHfbv7do8bQ8aO3xpHSnfg6AQcC5DPFvahO2dJwrA5UqCyKV+knibHn+09ucwqBHzfgCkZ+G6Z+8bI4jMmG8tX7Ob7xlMW9ECKWI57LNL6g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(36860700001)(47076005)(316002)(356005)(81166007)(82740400003)(110136005)(478600001)(16526019)(426003)(336012)(70206006)(54906003)(26005)(70586007)(2616005)(7416002)(5660300002)(2906002)(8676002)(4744005)(36756003)(41300700001)(86362001)(4326008)(44832011)(8936002)(40480700001)(40460700003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 11:37:49.5531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e80ce2-fe9b-4cbe-d9bc-08dbdebcce1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
It is hardware compatible with classic MicroBlaze processor.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 97e8441eda1c..7b077af62b27 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -32,6 +32,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - amd,mbv32
               - andestech,ax45mp
               - canaan,k210
               - sifive,bullet0
-- 
2.36.1

