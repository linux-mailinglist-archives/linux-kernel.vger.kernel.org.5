Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA97F58CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344829AbjKWHDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjKWHDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:03:13 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1805FC1;
        Wed, 22 Nov 2023 23:03:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAc5hSIPwXo1YR2M7FOd0Awuj6XHpOY6ArAqsIgPbzAYwvmnsCgBA9dXaaElIyyrRwq5iRiIpvCt2HUGCBvEwy3/MgobI2Vcv5GgrOQd4fYKAb/2l6ugAYTS1xMKkEGbzfBus9ReLBAkTCeMXOJMuicySTXUG8Z+eL9gpUNX62pZCD7vynoj8XNQYNdrsU/UOTNKvUn+mR6yqmS1AIv9B0GWkDlRIbpnh1ZWOvNQwOlfoP+xWEGii+xLasnvzAVe1PNS5ul8rpmxdJznR4GsMZ5wPjqFGMU8GMycHa6wpvP3zGH4UVYdVng4Z6mew2dCMOCu5TRdVmlYxu9N2ZPx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mD+c2Ch50FwLD1kt0lw6hqy1p2hDSJAyZc2eIOD8w70=;
 b=UfmMC3XM1cjOBEfVMrHMFzK58fY1lEhPMvLaCs2C9EalEVPslqwsjgAYWeuhAvqRijrgPvYhFf57RRV3ddvTjZdGk/tP468wW1ha4gzcRscqMu9ixiGbe+yP5MQzRjPqDDIRlDPnR+Val7rkWKh3khmSJolOrbTE2WRSY7t/IC+KACmGNYUvyRjnixe8Tw+gebHRcR30puuTmVxQFsRpotkDMLAW/oML/RolGgt5IXEZU84816EbifTGS5Rc5hoh2fs6pTqS++K0/yCtewjlUpsxnLFDRmsZDm+H1dyldQ1f6cVxE4KAi/b3YoCOMF8dURsgGItWSR2crS+XiiFw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD+c2Ch50FwLD1kt0lw6hqy1p2hDSJAyZc2eIOD8w70=;
 b=qaWtcyuAj4iGvYERN7ETsPvmAlT+ywgbxO0HQl8U+LzKtyqUEV0OOt3N6YQGu2adPujGNMu2FghoEHG+DUprgMMrfDh2JTcp72MxNME0JPWgyMswShME0FPmeBrUFSL7gUb5fujgqFyaerjw/HN8DYI+W9qaS9WDjdzV3YE84Yo=
Received: from CY5PR15CA0206.namprd15.prod.outlook.com (2603:10b6:930:82::20)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 07:03:18 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::16) by CY5PR15CA0206.outlook.office365.com
 (2603:10b6:930:82::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Thu, 23 Nov 2023 07:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.20 via Frontend Transport; Thu, 23 Nov 2023 07:03:17 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 23 Nov
 2023 01:03:11 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <conor@kernel.org>, <linux-kernel@vger.kernel.org>,
        <monstr@monstr.eu>, <michal.simek@xilinx.com>, <git@xilinx.com>,
        <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 2/2] dt-bindings: soc: Add new board description for MicroBlaze V
Date:   Thu, 23 Nov 2023 08:02:28 +0100
Message-ID: <69670e5a46c98a2eb73d4f2e2d571a27c46b4640.1700722941.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <9653338d293c25ff0e591213698d59ac55cf5c27.1700722941.git.michal.simek@amd.com>
References: <9653338d293c25ff0e591213698d59ac55cf5c27.1700722941.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260; i=michal.simek@amd.com; h=from:subject:message-id; bh=ZUJXyA8pnCzU4wI4oYH4NfAEvlZCkCgurxhZDI6ia6U=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtS4n0yXfXzEki7H26uu+sdy/bbBiQPvHUsfSKcbB5lbc 0b+esvREcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACZyzJ9hJqPK2klMi8M3/WNq 6ZtkVJsv9GWBIsOCvghnLusyNd9JC6zEj803tBTwc8gFAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 818b2fa0-ca49-461c-09e0-08dbebf2452b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8VrEwLa/gUJmBviQpvYGHZXh1oJye3BVlb9hQKXOGYeCnn0gls/K1oc8S5kRWoR4sE7S9eH16KOT3K8HpwuYFB1zsgHZfeiweIxTKQoB6RxOv/FMuvZAHV/3Fc0+dgIcdQFkn1HsvbMsawW+HI8mPY76w26AszZu7a2KgnPAYpIR4iXIcKOGX51ADPWZTZq2B5bVTvAaYmuqqnueXbJKoSS4bBXAOMu+ib0sDVx28WvCw5VinQafciiPnOEG8X2CuxtTsgjUFWuzoYPo4yw2xbslqFuxAyjxOMb0fZYLt/EPSvDJi5ek53EAHBadH9PXT8Lq/90C+pZWUPl73LRXhz/Ag7XkjwPcYIHnFPHWsNnKEj1cfPA9wMWWAAq4Hfn189nZEXbnxtMD30Qn0C0Wv2mgL/wkHV2Gx1RPOAQjOK7QyWN46PeB77YFaD5WaG9+lvuXrNUBSSd+cVV41UZOSMGDspLlRLRoWoHulF2Mk6afa1hCJiK4kQpdAXA/+wadIvoUOIQmYfnx977+GA+9Vbn2j9/axzgKSMGd/6WeiTFmz2YIjM5xzFRSftAxJN3rcYmn8Hy6TqACsWszJ5TeJ02Accou/OjyNznTYQQZKmgqiUSz8jqIIklW0pZfHsCgpkMLxy6stdmowgC7UeNTJN4JN7UFVyG32y2d6Vz5opSSqYr9hiAkHrrsPC4PHTeqvP9IIgffFT+aSPd48dVfmCz7z36j9Qucpo6EOp+tH0IwSO3erxru/ivawbd//+ALYTWKhdQFL+gRmmcu2S8w47ZfanKemt+XIeLG8vIvHc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(16526019)(40460700003)(70206006)(54906003)(110136005)(70586007)(82740400003)(36756003)(356005)(81166007)(86362001)(36860700001)(47076005)(2616005)(336012)(6666004)(2906002)(7416002)(26005)(426003)(316002)(478600001)(4326008)(41300700001)(8936002)(44832011)(8676002)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 07:03:17.6399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818b2fa0-ca49-461c-09e0-08dbebf2452b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
It is hardware compatible with classic MicroBlaze processor. Processor can
be used with standard AMD/Xilinx IPs including interrupt controller and
timer.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v4:
- Fix indentation reported by bot

Changes in v3:
- Add Krzysztof's ACK

Changes in v2:
- Put MicroBlaze V description to xilinx.yaml
- Add qemu target platform as platform used for testing.

 Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
index 95758deca325..d4c0fe1fe435 100644
--- a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
+++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
@@ -132,6 +132,11 @@ properties:
           - const: xlnx,zynqmp-smk-k26
           - const: xlnx,zynqmp
 
+      - description: AMD MicroBlaze V (QEMU)
+        items:
+          - const: qemu,mbv
+          - const: amd,mbv
+
 additionalProperties: true
 
 ...
-- 
2.36.1

