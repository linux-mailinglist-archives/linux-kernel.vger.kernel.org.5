Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE2F7A49EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbjIRMmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbjIRMlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:41:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479C6DE;
        Mon, 18 Sep 2023 05:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxAdVNITNA7krwa8ybOA14YNxHTie//vSuTP0YZFTCeOXiOkJmLRCxt9Voy/FyzLBxbKQ0dcsX46bsIPocqbwjMtH+vWIINXD7wsFTICMu2C1QlXpD7KLCWp9Jf1bBG36sbD9X0Re1juo2bTyvkPuO2Fl6Hh1lChkUyvuS5OWYA80cJ6oBVKthEiciLUMZIq8gTk9Q4rcbkoUbQI5nwesW9QQH6Y5PHbtDTX7sb5LRNlRQyTvlJToFffBWXNa6NsSAFw5soQ1sHpIy+cXlV7FbNtN6sogYR+I92/iTJ/W2Rp3iZdhFkZoUH3Y7s/Pv2+leJLwk+2gNWtqLkAgA2MJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msLE9tfTySlD7VOIATgbbapWQYSas/Yy3aNy5jBfp/w=;
 b=RZFezS1s79lpZ76wmyt6zFi7NV193DA26XEyhEgKjCzUZT/B9S7KCkR1Z88USTjatvf8R7ChZD+nq/uur8VwBjO4XMo5bn6AoU4a4A1IqLPi7v9Xr7m5Kx7Ca4IC/QOWJLrEjRqPupbYNZWFjjp9lzjVLJhPa0+pQ5hzAumCdeS9XEIru6H2GEREeQAv/zeZTmHbdstVjFzh6Q3EbXZURcvjxJtPHLbK6zz/7FGwMQ/a5fa4W6DHFJXvar3WnSTg4zu9PM+8vrBTeY+G9o/otcnQGwDoFrOuwQzO2WX+cmqX16V+uFIl0847c2IkqTVUfN1guHKXHX1uUdqATtMKqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msLE9tfTySlD7VOIATgbbapWQYSas/Yy3aNy5jBfp/w=;
 b=KCkKNHOkW7QLfOxV2nVRYJ7dH2bxh+9FeMDIh1skkHl9jOgmy6xBOIHKeQ4WnA/iY9r71FuiZA//QVbKOj233IkCD+LvmlES3XHvHDejLiGY3B3CUJDldD8cK3igSy+9hTkjRVn1dsNUfYN4So5f4QAjd0nQJWvM36Y0Ms6aqs0=
Received: from DS7PR03CA0221.namprd03.prod.outlook.com (2603:10b6:5:3ba::16)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 12:41:26 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::2a) by DS7PR03CA0221.outlook.office365.com
 (2603:10b6:5:3ba::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 12:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 12:41:26 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 07:41:24 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/6] arm64: xilinx: Use lower case for partition address
Date:   Mon, 18 Sep 2023 14:41:13 +0200
Message-ID: <a96ac9a32a363b04958157548f290d480c21590c.1695040866.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695040866.git.michal.simek@amd.com>
References: <cover.1695040866.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=michal.simek@amd.com; h=from:subject:message-id; bh=ffKZKU4flybGnuEk0pI67GEB3qVNOJpxk9T4Driktf8=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQO1wxuu/Jwxlt6ha5LNpxLEE91V1O1Mpp27egVxxmPd J+cXWPSEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACbSfpxhDm+2cVO28qeKGx7P LVJcntV5lbb/ZZif3HNA9OPzgoxLIX8k6qbmPeCecCUfAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: a986c382-7c26-4386-181f-08dbb84492b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owL02Sh5nQx1izTeQ2zVSWsyVnZ2+gka50br6BtDoJHAlTuCMHN+PaDcF/41jS/qFGHzZD4yrBhbETtIUBCt/KVA/S5phiv/+dGG6jf7xbPxLZb8AU7HQD7lBfC12LerWL5Cy/7p7Gi4q34miuI+VsVNeDPZFU/4tvJvrmndEkcP1vSTdDZZlcUBax7bnaZfV1EiTVqmbUWQIsGSeWAUS4PdY/zQ/ZnqVgAud/1jZV0zEXxhbOW2UhwQ0qwiJZIj6Ypy0jkgU0z/YaTSxRyXdSE5XHkz9A/sxF2Yjao8XwrW/h2MK/BCQ87gM3W6VVbVt+VA7gub1BSMRwFklvlg+Me5wLQVUSDFs2TdXILmTttPtEqCZq63skAMkqp/ch/wlK/HzszSgVnA1l084g6HNFURH5euSmcUoIn22EhmkiHVg1NCpXaeORdYbgk6bTd/tRufKVwXd/KJSHcTPIzuQ1/0+wrk5Lpi+cXlC+aEpAt0aPCwE5T/wtuvbrgLng1REEO068Rg3YvsT5XzMUfQZPb7dPlKuF2o0FYE6HaDb7OJ9ewXUlGMmdocbHVH4GYYKfwinS56HgV4Eem70ujJ/+NO2klMlxbTnqZTm3VBPwtWspUX7S9JQh92AKijUVUNWqp2fxaMhH9YrlD8qiLf3oWYjHReU0xB+JpYe+rGJBDaJf8kXDY5xmfykpRJQ3vgHau61u+UyQTu35NF65TWWBW1YQ8gAT9bjw2hPH5CzJDufg8Wss9fV0ePsKchLcGt0f9AJ2C4nAqGfLULSKmfNqs+alEK5vVP5EGRL9EEreQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(1800799009)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(54906003)(70206006)(70586007)(36860700001)(47076005)(316002)(8676002)(4326008)(8936002)(82740400003)(41300700001)(81166007)(356005)(6666004)(478600001)(83380400001)(110136005)(2616005)(26005)(16526019)(426003)(336012)(7416002)(86362001)(4744005)(2906002)(44832011)(5660300002)(36756003)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:41:26.0592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a986c382-7c26-4386-181f-08dbb84492b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lower case should be used for register address.
Issue is reported as:
flash@0: partitions: Unevaluated properties are not allowed
('partition@22A0000' was unexpected)

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index c4774a42d5fc..157dcb4a27a8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -222,9 +222,9 @@ partition@2280000 {
 				label = "Secure OS Storage";
 				reg = <0x2280000 0x20000>; /* 128KB */
 			};
-			partition@22A0000 {
+			partition@22a0000 {
 				label = "User";
-				reg = <0x22A0000 0x1d60000>; /* 29.375 MB */
+				reg = <0x22a0000 0x1d60000>; /* 29.375 MB */
 			};
 		};
 	};
-- 
2.36.1

