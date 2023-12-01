Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962068005AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjLAIfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377842AbjLAIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:35:03 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460531713;
        Fri,  1 Dec 2023 00:35:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD/Ax/Z5RYjQMZNqeRbZnZVjrp08ER366sU+YBYAqb8+PrbPp1B9qPoKkYqz5rRTygD2cWwohAuWqLRIRLjaq8xk8DJ/u9M8gQ/skSnGGZK7KuPMDpX/X3LA2ivbZTx7DjLTbiYRQk8dZisRumP8Js8utquutIpYMfe99XMRVUHH35uRin7RQwJh+leOS1IMraNFaog69DJHLac80p8D1tWHGFlzUi0sbuTSWscKJJsojT2fQle6LXw1Uvl0qf4Yh96xuFguxrEjEMgCNrM04H4UinM6Hz6gsPmemfNEL2pmhcFgE4g/p3Rc4ysJN7gTO6gfq1bBU/VwOd15/DggxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQO3jU2U4w74d0809v9cFZI851sfm4xMZAoZO/BOlyI=;
 b=gWke0099SFJLal6ErWqhRBTwK7I9daF2Q4zS5h2sHFcUXHsOYpKZB7nUcigczSdtuLCm0q5xvmCOVhPPt7v5Q5FatEN8HEbjjrr1EvtpsGNQhXyNzrxR5HqRJZdIvOKPfKdGLaWDypGtpEdXtmPCObhYVSblCiwi++RCPJl9uLbgGB94vHOQGrZX0482NNyGLGiAA4fkNG/VVzNQKorTCfb5bbFHDJ6ODUBfXkPu5riqC6iwg4dOEhNsL4NyypUb0m4Dm1cnjPJeW46GKPjQCCWHuxap2T/nzp2pwskV3ANi5h0SP/VpRV5yENQDLu31QnIGw6/MWpEvTv1jhMwINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQO3jU2U4w74d0809v9cFZI851sfm4xMZAoZO/BOlyI=;
 b=ilwPbNpnfWfcQxmAppAqv7/qnbhCh9CYfUCSYWdOApCLL17tAn7h9h2C6ThljG7D6wcJKdLmQe1ELdh9GRTlT4v8BOejrp5bZETNkAmJZV9HXfiUyEtajfCf36R5FqmuJyHPDj3wx7M4DeqqcgzHl/jaGynRA8xWvzlbmk2hzSY=
Received: from DM6PR07CA0047.namprd07.prod.outlook.com (2603:10b6:5:74::24) by
 PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 08:35:05 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::47) by DM6PR07CA0047.outlook.office365.com
 (2603:10b6:5:74::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 08:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 08:35:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 02:35:03 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: hwmon: Increase max number of io-channels
Date:   Fri, 1 Dec 2023 09:35:00 +0100
Message-ID: <5110a313a5ce52ce6d7b5cb6b08368d42063dc30.1701419691.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=michal.simek@amd.com; h=from:subject:message-id; bh=D11Ilo0ssCKrOXoMqOB54IpNbAYI60OPiOj+Khvw2jo=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTMWWs+zrMVLmY7oGD5TOXUPBGl98GXnm9ZGKqTbJQm/ au699uTjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRplSGBQ2KRe/0HZ3NlrHz sDNy2LNEpC/3ZZhnvKr6vFaNqs214+XzzZkf/bs7d/c/AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ac305c-051c-40ca-786e-08dbf2486aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDrEOW5E8ReFB+hSJoZKP4NCVwLi+pJqBiTWFcaKsSH+Ou5Y0vZ4qR2e4Xiv9PRprPGPs7TbvkxIu4bCzdpzrTOX8JUltYZUmTmAdfz8aZIFjow3XrUcGen+BcUIQ+u+KW1RPUQ+B7H3II+s7lFJJlvEgsP9PDiMX6qh2XzRplHmWPNsp8JlgY79xVirYi3AWifGM79jXxRvmfSkCwba/H0cSMfFBWwe4Zc+kwbWokPaEs+wB1MFjlB83kZjCXadhclfL4vO4ENSqJFOAX4FjxF5OKTiRjVDUOCmIU8z8POK/STEHrvaiVOIX9NAjSyTxg86NV+XgEv0OdC+MCPOAy3nWiymfZ1f//AY5lSsILSO1/uXLzXZcir4g/MuZ49yvn/3jzvUhXo8ni57Ffmhc6IaOpAKNxpyV4O5o4Cu8rPv/TIBsUwihMp9+J4EqJoD9u4nCvWGtIAluzhaQMcV4tY51SNMGC2joRLxnojRh7nT7C2X8t/pajusLZbBDRfhRWO4tM9mi+ii0tb3xoNSgAgL/vjexLj1CjhPbx3RhZcU6/hJQoPCBmPkNBB4QGytR79nfvizO9RpiAHn1FLuJK/1puaseo2EfaaYusJRqopvlDfssFES1bnLAVfCDTV/Rt4j+WlOT3ZwZVH3e6LiUp9JwKA/+kuKerYQecGpr5YnLWb/PiYCZRyNck2ncH+tx+rqHh88Bv+v+TLbYtwIdfpDtjha39yH7rh6X/tmZo7RNK9ijYUF2wsE52cTZP8MEF+M3Kh9q/l5G3nOUXPRVuR52azwm7jo8GVEe+vmzpk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(46966006)(36840700001)(40470700004)(86362001)(36756003)(44832011)(5660300002)(7416002)(4744005)(40460700003)(2906002)(41300700001)(82740400003)(83380400001)(426003)(110136005)(70206006)(70586007)(54906003)(478600001)(336012)(2616005)(16526019)(26005)(40480700001)(316002)(8936002)(8676002)(4326008)(356005)(47076005)(81166007)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 08:35:04.7700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ac305c-051c-40ca-786e-08dbf2486aee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Analog Monitoring System (AMS) defines 51 channels
(Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml)
that's why increase number to 51.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

Changes in v2:
- Add Conor's ack
- Update commit message

 Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
index e5b24782f448..be5c7d4579bb 100644
--- a/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
+++ b/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
@@ -19,7 +19,7 @@ properties:
 
   io-channels:
     minItems: 1
-    maxItems: 8 # Should be enough
+    maxItems: 51 # Should be enough
     description: >
       List of phandles to ADC channels to read the monitoring values
 
-- 
2.36.1

