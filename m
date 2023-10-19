Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6547CEFD3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjJSGHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjJSGH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:07:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B95212D;
        Wed, 18 Oct 2023 23:07:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDoMR7myCgBIDJNMU4mXQFc1NZWwolc2Ir4bfpGu9sT2UWM0A+sdoJZBcI5woQ91KOHZaO2TV8mV/hQkyrhIrAuQwYSA1dXRkil1xQQGvrH+hsucisVvojY8QVL9fo8vMCstUyZCYVjXkMvb9tqlL4PTKaqqqPMP4+gc4jwgEWNoxUNe5HYCnEbQT1gwvdjOnDQQb7kT69wo57vpRvvWNdhedihQfC1izqfSeBil+RqOx6hIyNo+/hY5RcvM68j1xlDCGWx2f7EscOYsxZhcFOECeEvIvNOwrsJmeO416zarKemdJRPuQFzFPwEMzyfisfGuK47fRzRelmxQSTubzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/5k9hNy0feuj1WgnI9PSTSCTzRzRCjd++wt5Yq2a9Y=;
 b=DzxFB9B52xFHm+8uiMc3HSkuK0LBoTNX9GxW5TZmeoNhoYRaVnOgClXTHx7r1RR+FuJ95BiiMxlWuK4NCddm88wzJYAzboIspck1GVCvHJu5KBNY90brv1r40quX+fVoz/yQkmn3Q3Kbcx5rX+Y4zGuzkrorFcHhwyvCM4U6Jk5+tpE7htbqJK8naCWSJAo85VryBqHDRZPSKWiXkFsansiHkT96GdjX1DFU9iKItDaF5vLUoBIb0OdMol9A/V66r56C8NYLKhlUtH4GL15p/MZecvOWBGXOWWETEguz2VuD4lG+A/tXFp3Xu7ifQ647Agl57Netax3vtMaWTGlLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/5k9hNy0feuj1WgnI9PSTSCTzRzRCjd++wt5Yq2a9Y=;
 b=5hfgz3AtwzDjDtoZWMjssTW3WgDzEwF7Ze6RB0pT3180HooXV5Tkh3HDetNHlEh8bEW5dXTkZ3m0+KNoXHkeGGGwjV6CJnSz3VI6Rb8RfG5HcXlPa2t+j60Hihzcx0pQbFNdPhV1xOFfdBTRRuOCMjgzBckIp2o+TvdHJLi6d74=
Received: from CH2PR19CA0017.namprd19.prod.outlook.com (2603:10b6:610:4d::27)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 06:07:20 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::a7) by CH2PR19CA0017.outlook.office365.com
 (2603:10b6:610:4d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37 via Frontend
 Transport; Thu, 19 Oct 2023 06:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 06:07:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 01:07:17 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 01:07:15 -0500
From:   Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <praveent@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 0/5] Add ZynqMP efuse access support
Date:   Thu, 19 Oct 2023 11:36:46 +0530
Message-ID: <20231019060651.23341-1-praveen.teja.kundanala@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fcec08-bdcd-42bc-c628-08dbd069a791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILHqAuz/27PKjHjT6DgsIHPYkGxvOGrKxjRL+KrWhDexNGdq9F5OKGRjKmq2NMZ6aTCvBHDnbM/lXcTqZ8FfcjGasZZNhaFjHFx2GcfP7ixMZ6IcYP9ZvjIE/jzqf+DSmO6w+EChsf+OeERaJ8Ijc7hNEJPvS+9V1IfM9uAcKZepYYHnqK79kzyABu7zFd5uTX4CfaG6zfq7QVuSzlNJAht9uCK7PYnG350Zt2wq+tHSm5leOQ3QZgUR3nd+aW/RxNZK/BVBWxctHjS6/Wrl1BMnI01Y3itGDLTb01Us9yVxT4cPPw1chuNFfhlivPn4DhwaBBfQcW8bjimxyuFbJyKgeFS4AQbrKxBzSpuQtXvG3uEWKPD0SMjg8C3eg3h+2zpwiw+pT+aitU7Quig4vK4lOgFR/CaOLTdTtr8GHFD4EGPUJ99FMy1tpXWqAZeBeASiRc83dDH9F1hHKdk7e2J+fxlP3vAd/1GyxMCbZvLPv4o6wXNwaXys/QaPAWOdUsEfrJMrgteVsquN5WWMmAhXTKuaeAS9DiPCb18AV3Z08XccYYOyAX3xA7L56iTGVh2l/+tSoA9jmCjYgSj9eT8hv+YjoGmjVt2H/LqVgOfU0QftUs+kG5YyfQC+zX+Yx6x4EBDeKjEqrI+S2DvIGiyXo3uKLQ1hPN85N5KcMPOvE4G7v8qaGFoZS1ODiErrrJeSEZeZXt1QyE2zNey8L6Lk6utKewhVo97lH6qnLfkUZEfq/A9OAf1TLFJiUl3ZTex6jFa80baAT688uhbYOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(1076003)(2616005)(426003)(336012)(6666004)(83380400001)(2906002)(47076005)(8936002)(8676002)(4326008)(5660300002)(41300700001)(478600001)(70586007)(110136005)(70206006)(316002)(356005)(81166007)(82740400003)(86362001)(26005)(40480700001)(36756003)(103116003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 06:07:20.3611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fcec08-bdcd-42bc-c628-08dbd069a791
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
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

Add following support
 - ZynqMP efuse firmware API for efuse access
 - Convert txt to yaml file
 - Add nodes for ZynqMP efuses in yaml file
 - Add device tree(DT) nodes for nvmem access
 - Update driver to provide support to
    read/write ZynqMP efuse memory
 - Add maintainer list for ZynqMP NVMEM driver

Praveen Teja Kundanala (5):
  firmware: xilinx: Add ZynqMP efuse access API
  dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml
  arm64: zynqmp: Add ZynqnMP nvmem nodes
  nvmem: zynqmp_nvmem: Add support to access efuse
  MAINTAINERS: Add maintainers for ZynqMP NVMEM driver

 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      |  46 ----
 .../bindings/nvmem/xlnx,zynqmp-nvmem.yaml     |  40 ++++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  59 ++++-
 drivers/firmware/xilinx/zynqmp.c              |  25 ++
 drivers/nvmem/zynqmp_nvmem.c                  | 218 +++++++++++++++---
 include/linux/firmware/xlnx-zynqmp.h          |   8 +
 7 files changed, 324 insertions(+), 80 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml

-- 
2.36.1

