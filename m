Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707ED7F414F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbjKVJOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjKVJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:14:03 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12EF83;
        Wed, 22 Nov 2023 01:13:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp6FM0EGn+hWMyEmPMtQdrpn2C3BYvLDZMZ277DPc1QvvGGua1tBomeRpXij/X/j4Exc9jQy3iic9yF56b76I3LsJ0ZQhtq3UzoDuJqrIsHrveoLwXsjePI85cIPtLZ9r1WciAYLA2312JUPisWGqD0k9rND0FwT33kEwKJw2emmWN7JQ5wBIUtLzIawkgaKeVE3kJAW8F0fywMGns5j3JNMzdK0/NMPg4f4XH7950dkverA7dUMpC2KwSYpj64DjEpzBtF7Pe67OMC7xaGQKKHviEZvOr12RnLhxa/GM20qUzL2WVzhvO/0D7M/FnO6E8Gbh2IwcUyh7UFdQyxkSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKReauIfj6MbVxEW3JpM4ioq0+LUx+yYx+r+DWbEtDg=;
 b=dNyuCrYfnObEVWiGtkEq7Hoxx/wLk4IIJ/GUjOScXyxHBgN17LUSLjeaP6MTLNuVZ+5uEFOD7hcEOtKKNRwY/NeAWWk6EM6vJ9KiNeK0Tum/OuapuvbzkPc+x/5Bm5cn5KijxxO/x3exXIeV9C27YVAiu1A3v9z90qPTlnvHsE/W6jafm2Zs5bKQWkqnfRENE1Z51qTO0QgiiAT5+ybSR89zpB9Ja1JeyyxMYX3wepGNlD1WRSxVZC07LJfOBhWSPQDcDF+muxYG3S+n7FFReFql6V4a0blzR9himS0X5UvcUnfmvmn/8Tv1VcKXfylckcSzbv9b/ek8TjTqzYr22Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKReauIfj6MbVxEW3JpM4ioq0+LUx+yYx+r+DWbEtDg=;
 b=QtzD+1SS2kK5QANPG+JJWVsKqKtkngHe/FGQHcyrwz6NCdDWBG63Wk5ehgNTGkQzMTxmOXOca1FfwVUtfArK6C+ceSypBhjBLy33yDwaAKN4FuceEsBwneY1vAc+kdilwpK/Au3q1TBkXtBihRJv2eKmOw2R9uy4ocr2CP0B4QQ=
Received: from SA1PR03CA0014.namprd03.prod.outlook.com (2603:10b6:806:2d3::10)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 09:13:55 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::42) by SA1PR03CA0014.outlook.office365.com
 (2603:10b6:806:2d3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 09:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 09:13:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 03:13:54 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <conor@kernel.org>, <linux-kernel@vger.kernel.org>,
        <monstr@monstr.eu>, <michal.simek@xilinx.com>, <git@xilinx.com>,
        <robh@kernel.org>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 1/2] dt-bindings: soc: xilinx: Move xilinx.yaml from arm to soc
Date:   Wed, 22 Nov 2023 10:13:50 +0100
Message-ID: <ef58475a717c62bc86aeea5148d5b88cdc0cc106.1700644418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1677; i=michal.simek@amd.com; h=from:subject:message-id; bh=WvDO8CRV2FU0nbnpjmTh1AA/+K4uZD4u+ST838uMAwU=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTYY85qYdNZkuc6O9nO//u+ZWHunb8RWcVXI94v+Dt5R vHn1uo9HbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAivC4MC2ZnKSTtvBE1w7Tt 7oO/j9cs7LGbrMAwP42tz2zxoXQby9AoK747Nz1svfrjAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4438c2-cfa9-4bf5-d626-08dbeb3b5a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dpgbWiWWcuEh0VjrhkzXS0M2cmazUbX4RlkaY3ophgKZ6g4cgKmqyMUlgx3zm8TL14MZWKa2FV9Xekmbu+nIczdAobVeQzjYVRmakNrTAVvvGvR+l575TqOKxK3Ww7AmYCA9baS9B/tZ5hLB5//GLA+e86ekGQMBU7bwd1S+KpMwJzVM67zFxSSAsO6Df1dd10X5qtRIVagK0F60bmbNRBK6E6PoGOy0i2zbLxW5joKa95TjEGHO01oszyxcA5CJpP5DzQwnZXp6AaLsGismCXDIHJ4Lh8zT5ry31Vz1UnFMTLkVfaDtDxGN05n/bIW7MDs5RLfFD4Hxar82QUlPLfSpbT4W5bmsUggM3xInW2JatreaAculKwfHVWguZDx6qEig+cPNtNfOtGGHaCy0oGthXWj9TLV93PBq5Iqd7RWidh3Op29cZEsBn5uOOXIfQDLG3NPSI1N4k0B9l1/K6XjF6VwGRhFPOhsIR/pXNjavafTWAdVhBjC8c/ca3WXJqc9oqckc8o72VEHsTwB8pA1/icWtyYx1dsOfPtQpe4jUAYX4uuaD/vqw8YIuc8iP5ViRJpjv2SIlsEmfUXHK9kF6UnKfFNtCsX5manpJkCmbdLYpC3x1hUmiKbVJjYR3cfYq4i/g/x7NshAjclhyD2EmTES1UiI77gYfK5TcJY+YK7l4riFoeigrzNqCHfRd+C1PiuCno6CtorIN9mGT0o+WoYjD0Jmv+kZ8nyXlqugBb2tSAegHBy/6U6TPwJb5U0o6KKfadFmhyi4VdpT5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(40470700004)(46966006)(36840700001)(2616005)(426003)(336012)(26005)(16526019)(36860700001)(81166007)(356005)(36756003)(86362001)(82740400003)(83380400001)(40460700003)(47076005)(54906003)(316002)(8676002)(8936002)(4326008)(110136005)(70586007)(70206006)(41300700001)(44832011)(5660300002)(7416002)(2906002)(6666004)(40480700001)(966005)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:13:55.5833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4438c2-cfa9-4bf5-d626-08dbeb3b5a77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All Xilinx boards can hosts also soft core CPUs like MicroBlaze or
MicroBlaze V (RISC-V ISA) that's why move boar description from arm folder
to soc folder.
Similar chagne was done for Renesas by commit c27ce08b806d ("dt-bindings:
soc: renesas: Move renesas.yaml from arm to soc").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- New patch in the series

Based on discussion here.
https://lore.kernel.org/r/20231108-copper-scoff-b4de5febb954@spud

---
 .../devicetree/bindings/{arm => soc/xilinx}/xilinx.yaml          | 0
 MAINTAINERS                                                      | 1 +
 2 files changed, 1 insertion(+)
 rename Documentation/devicetree/bindings/{arm => soc/xilinx}/xilinx.yaml (100%)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/arm/xilinx.yaml
rename to Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
diff --git a/MAINTAINERS b/MAINTAINERS
index ea790149af79..14ad00009a63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3020,6 +3020,7 @@ F:	Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
 F:	Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
 F:	Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
 F:	Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
+F:	Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
 F:	Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
 F:	arch/arm/mach-zynq/
 F:	drivers/clocksource/timer-cadence-ttc.c
-- 
2.36.1

