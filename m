Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1358A7FEBA7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjK3JPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjK3JPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:15:40 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2C394;
        Thu, 30 Nov 2023 01:15:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odu4uZeer1OyuBl5TH9lqEPtYsoZ2B+pM/ip0gqfkxxw5RE82vh1CqiVqjEQFK8d59+BXH0EsHd0alB2QAGdMAdhbQq4E6urHKdcXJ3i8pHtr6layylT4x7/7OodSVxsHGyMelYy0I0jnYuJmxAzq+gumkPsRSacMeRNHb7rgIcLsBy4VBzgkeG7vUVPnKgWTm+iHpfWyT+8Oao+2ZgQOIQDwtHvTwWeIy6K5juWo7yIkbM3yZCPb/PULBILSNX3/HeaAArR/NlCleF9badbEtJlbyxwqjhloBBeY0ibZZjWdgxzGducbWz5is6j6n66irvgmLLPKnnBsoODYwsc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeoSEjVcrvJzIjxTwr1J307RFmXYvnzxGBT0ehbB9co=;
 b=NguFe9uCgS2CpeJUA2HLCtQm5qR5nnIBFCU5EdTHIDJI7izk6xpT8ebGg8y881EJaOzC/ygbk6tGvDtVtiMOPphHupdem0FYKc9+sKeVOBk2iZraC3TIeJckY/oLE8Ix+asiL1bg0KElc8FHo86CuL6vqFOIVANHXZIuUItPYszacQN7grnQgkxsSt9vUx54OIhsASuL3D+qkYeijs16G+PEr0Me8cG5wmQfEPrnIXmD5mKx/4Pte8o1lTzl3cCE8UhjLV7UCv61c0HjJNhCnBuBCgHnVMqL6uw81lyae75iZdyunW6SC8Ucng9MMVWmOaASsMjVXQ6cAWWYuB6i+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeoSEjVcrvJzIjxTwr1J307RFmXYvnzxGBT0ehbB9co=;
 b=WupfGTpFdUYHjtO760rlnUkpg+Z+as6nmJFtLmCumeh7FXtCYUomLn2t19wFXdWFAoc5p0HH9iU6EUMVeCuZiSQqsofQg0T9KDg+H+p8uK4Y6Gid4RrgQnHwaQ06QKMfQ+Jwcmp6xhUZiZPRTwraWb327L8p2FFTfuRcHk7RQgc=
Received: from BL0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:207:3c::14)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 09:15:43 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::54) by BL0PR02CA0001.outlook.office365.com
 (2603:10b6:207:3c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 09:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 09:15:43 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 03:15:41 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH] dt-bindings: gpio: modepin: Describe label property
Date:   Thu, 30 Nov 2023 10:15:38 +0100
Message-ID: <10db3021e8617c1f98eca51e26d350dc4b51b53c.1701335736.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=michal.simek@amd.com; h=from:subject:message-id; bh=zpXLDTWTh2ozZ8XN51LzCP+B4tG8B4inI6OnqgeeDr0=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSMoB2xOe85G7InaXeockUplU96OONqOE/vlTDfwsZzE 5Zymf3viGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABOxSmCYydhXccyk9oRSXQwj e+i5B56LWGa1Mswv/aJw7TFbxqGOVYK+JxZy/vziwxcJAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e80decf-4761-42f7-4327-08dbf184edd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FjCbcc0Z/2znHxW+Dzj8InSEld/jqPbPZcwyU35ulh7Z/GdiT6l3N9wusJGIzYFF+G0T/iB7jW8WJESYDz2E83HyD93kWMkbSYMfo93xmajS7bnb0Rr5xEGofE6+sYGj7wb/gHQJkUdBORZH2aZ+x8R9FXoz8m3R7btsorUF7ltMJUa5r2WZGcLQO3y3ID25x8kTT7ToASL7xhHSrHWQrzj0GIj9jH4W0R3CPV6sPC9DZTr8ZtGzPjOE7c0VvkdgWOK8tMNBboPHcZrsDJPOp0UNcQL869f49SYZHIEguRp0uEEhhCzUyrzOLFiWEfYABszBJDt/GrRLRfZS/ST7098fbgNmIlxSnEg0+2+Db9oPK4D6SVhHwy8zp7ttnotAHYVsohPRGDjq2dsblfMtyh2+LVIAnrYah2pZSt5+JJBhaTfYPwa419lga8Ez5IEgXBelTruftaF0tjgCIcKKN9qMQg9t6NSfexpbJUWYTZA0azDdKz7r4YOMRm6asEpncRRQMjBnC2Se8Wc/uS4pJTTy6fF2ZAD6PK+Wmj9aXtZ9CU0fuicXYJysYEzSiAIFmdfvobAxxIKa8GONbfxwCcVYbuWaZERwy6r7Z4CiLlL7u4rnvgdizQz3OH1ELUkb9xIOwsId6921h1szC0wSwuVNDEecwe9Du6O1mySgouNTz76IeqJrYLCjkrWAXavPTcBbDuvNL8PRzdP4U/M4DnXB2LTC1yBOXIgoUcmbXvVRsxQlSg95bbkfqH+dWB2LDQx8PpBW7UHlQkMNwv7EdW09UOdmbwmoFgfkxFHxd/9lJfc8Zn6OJOCj2lD+mrN3zp7PDg43x6HT1RPrPdIjxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(44832011)(81166007)(82740400003)(478600001)(4326008)(54906003)(316002)(36756003)(8676002)(8936002)(86362001)(70206006)(110136005)(26005)(16526019)(356005)(336012)(426003)(2616005)(70586007)(47076005)(36860700001)(41300700001)(6666004)(202311291699003)(40480700001)(2906002)(4744005)(5660300002)(7416002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 09:15:43.0570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e80decf-4761-42f7-4327-08dbf184edd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe optional label property which can be used for better gpio
identification.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml b/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml
index 56143f1fe84a..b1fd632718d4 100644
--- a/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml
+++ b/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml
@@ -23,6 +23,8 @@ properties:
   "#gpio-cells":
     const: 2
 
+  label: true
+
 required:
   - compatible
   - gpio-controller
@@ -37,6 +39,7 @@ examples:
             compatible = "xlnx,zynqmp-gpio-modepin";
             gpio-controller;
             #gpio-cells = <2>;
+            label = "modepin";
         };
     };
 
-- 
2.36.1

