Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8944E7A49F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbjIRMmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241487AbjIRMlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:41:50 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA8B94;
        Mon, 18 Sep 2023 05:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnH42TRMpDJP099FR9sQ3ThJKcmCEXcaaGKKGF8kveBk0h52TQwdXZe7VWY2FHiu5DGyX+uMYkyXiyeG80bI9bvtnwlzFpxl7zxwNI6b1JPNnj6XdA/0QWfuG45Echqyu1//SJh9n/6h5Gh3LO6VsvUtWXh16d/tW9g44+f+tNO22C48P3qnyshrPEMDbnKPUbyF6jIZwnWjkferjAf8fgGJhFXkA1P441wXEqdI3iFzJF0OFEljIsB/eyZqScAY311X8lOhuS4XguyaO4rNVUeEhfOJge/k+oW9J0MaTjQFWw6F3FBR+UZFo8bdmOL9wVk03ofwmZe1P93t3JMj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwex9DUl2ckUQAzA70vP8kXOm+hxFBihQRHFR5HGE4s=;
 b=U9lZiAB2FzkXkIku3VdZ9p2hAuyQXOtT3T0F08K7mdS8YbSyyw82e/9bLcFG5MyWAsljYYiPAVOWZnMJiCMHGbrm7M8EeqAkulzY9vQCV3ulZqZIulpSz6ZYesmBUrtoAeW2JOKF88syHs8Vd7pGV7s83+UUDbw0KOVhaFIG3QPw5WZdCKWqrNXedQyGWlY8PFwl2pJx4vusH6cUgeuVVbqpDsLvqml9D2+4fskjoQmFFtqeCfp5uR++v42dTDR0xohxJKJwWAIs6e/ykAJOxjFYi6hV0C4Tr4Tg339DZLqq0QCWRz5KgEU0SzUv4LEh/ecAsZkLHeTEFVGOvvprEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwex9DUl2ckUQAzA70vP8kXOm+hxFBihQRHFR5HGE4s=;
 b=WZfzgL4l/Z2Fn1rmCyAc3mv5orZoFZAfD8xf4sq8gFMzJz+2ApDMWPab5SnhyQxKbwQTsmsrt/10YXylwfI6QIBwpoopYU7vtAjRaDz9tNYmk+0S9IWanRRuyU2mmpDpvJKwcnRmhS1fX2BNkjFfu2xq6muocZMSKDSM3ti4Dgk=
Received: from CY5PR15CA0054.namprd15.prod.outlook.com (2603:10b6:930:1b::20)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 12:41:39 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::e6) by CY5PR15CA0054.outlook.office365.com
 (2603:10b6:930:1b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 12:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 12:41:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 07:41:32 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 5/6] arm64: xilinx: Remove address/size-cells from flash node
Date:   Mon, 18 Sep 2023 14:41:16 +0200
Message-ID: <c4447028f914e77b8c28640dc458b8409198ee30.1695040866.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695040866.git.michal.simek@amd.com>
References: <cover.1695040866.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=michal.simek@amd.com; h=from:subject:message-id; bh=qblDog3nK/snMwS/IzSu8c64JM6+nf1pBHo99FYr1Ps=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQO18w9F6It46s4QhhjWsRfvpuuqhAwxbJjXluMlOzCx BkHr73riGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABPxcWOYw335/LnD8Y/4Lc7u Cq56lnH8esu0ZQxzZaPO5mjOXBtzYu1MXXc38aMWumtOAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 115a4b05-653c-4ce4-7fb2-08dbb8449a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iptj28lMTtiFJzoV6W2NidnBUZgVPw6D1ErQ9clSTzk7oIeP+XF4OrDSw2WiX1Z0cUrs/H9HV8RV88iXXBz+C+X5/H7wY3qxorTBbKwNhGj/DdHrU9ygvZho2JV2xW5wsWxtHeYbh/MtCuQQT/oenbrAoq6DNYcCnuIeTGmDyQuZiYmK9CVxFCLQ7h9wGFslvVKEq6jd1X/3S+kuzoG6iKuJTBCXdqo9zs2DGR4efb7TJbUKfubJqIovZbGvAKenrq9iMWUw7WegNKo+yYGvPlEkuvzENax8O2T48qYjLBACXAO9Gcf0wV1px3xO4EPxMiyJ4QNu4NKG+UiPX8uAE5h6baLr3R+zymxosQZqozfiHWRPFpR+e4mMQG2qPy/A/wJOW7qQ+tbbhsI+iVnwjI2Pdaetzvf+IvJ2bFLq3qVep8QzBn2mxnEuGcIIf0b7W56LQ1NXm8TDumGzUUYDFhK4JMSgkAyl06PJ9BdQstaG1oqowLvn913qjlLM3CC7obAY59dHUQJuF9+z8XRolQKQKIlLCH1+2zfg3d466RgvAk3Dj0OrNicnHoY3BukNnbk9wGr4sjCAlp1QTCIo9njO2xzIkOFm5V4EEaXC4muge9ODu5Y5SPnE/pPlCwAm7888rfB7wKiNWjv1V42796ATnXUEgFiE3hXPZhqQAUWlK0tEl3WsKTz5LIgCW2y+C7Md94HFIof09p19xStIt/Qnf5PBeIU8DAiKk/4kVB0jie3klJbkttASenMOqHDSmztl5q5R+B+koQwkJaU2l/hhxlL129lfSDsvAH12h3w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(5660300002)(40480700001)(44832011)(86362001)(54906003)(316002)(41300700001)(70586007)(70206006)(110136005)(6666004)(478600001)(2616005)(8936002)(356005)(26005)(81166007)(82740400003)(16526019)(2906002)(36860700001)(36756003)(4744005)(47076005)(426003)(336012)(4326008)(8676002)(40460700003)(83380400001)(7416002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:41:38.6447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 115a4b05-653c-4ce4-7fb2-08dbb8449a35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partitions are described via fixed-partitions that's why there is no need
to have address/size-cells in flash node.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index cd5cd7f3b5ce..51622896b1b1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -132,8 +132,6 @@ &qspi { /* MIO 0-5 - U143 */
 	status = "okay";
 	spi_flash: flash@0 { /* MT25QU512A */
 		compatible = "jedec,spi-nor"; /* 64MB */
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
-- 
2.36.1

