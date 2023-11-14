Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B1B7EB028
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjKNMsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNMsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:48:40 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B213A;
        Tue, 14 Nov 2023 04:48:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/k2f+aEAKDsc+Hscd6Imqd/z12v11re2vcD775bKNC5axclMmwjsyeguN41cdve7M2zy7rSmyzX0vde+bmwqiyUHtftQEhLpaswI0NHhS1Tm2mopjQtsrr6pKSep5qtmRr2EmFIvVceUNEXv/bBOtmy/ilQqWPKXBwqX7GX3EI9xs48DtwDitIsNecJHtZsPCEuRyXLEQShRhoz8I+7mEX6hBu6LDuY6XGy6+qYp7/3Cv2jfKiNSbZSb6CChWIaHfglwMZMQqqB+pyS9xfCFTGM6JQB2b8o653K9tHoARGEfIF16nisEbcPOMrdfe0PwojJ5Ltawa4C+KiorQ1dKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cVqEYWO+Z8cW3AEkiPy+S/F1V+uR/k0EnPZghsCxRo=;
 b=fk6ykiKDQAH9H8J/ykZBIrObi23zaTE5f1WY3ke1GBA2Ge0i1/FFGu8d0YD17xzTVaOtQK58sZzvHfENSxpeY+rZD4fTOWXsVhio+i+xKleo8Xbq9sZn/qBiCQlR9rK0AV4IItnbMxAz+CxvedX3cNe2EVxQXhXryEyw115m3PU3eA21MylxdTRZhWYbFb480bf+gmSu6CObeLaOh9UAYiRz/qWACXwpM8v5jwO8PC+r/+arG2VK3b49JRUYUI9roIdziSBnSCUQ7OCH9iEp7GcSf0Hypzftc49xrqppleRLzMZgdbYfRAfpXjnZQORlO/+FPfq0Li2aWy6ZGE0GQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cVqEYWO+Z8cW3AEkiPy+S/F1V+uR/k0EnPZghsCxRo=;
 b=GSuT2LhPumT97yGtqFkDhnPsXk0xj6XdixHFDDsPyaRyUBMK6VktFcx539dORdN4T3Ma4fc7MESvjJbNW6lZ2Q0+E0NcA6lyNwyhsxMhPQQrag9YEw/0+50aT9PTKV3yxzb0bN0b6pUlZQgdmMaOEbgyl2mVR0XMKVdEPdKb4yU=
Received: from SA0PR11CA0005.namprd11.prod.outlook.com (2603:10b6:806:d3::10)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.29; Tue, 14 Nov 2023 12:48:34 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::d4) by SA0PR11CA0005.outlook.office365.com
 (2603:10b6:806:d3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Tue, 14 Nov 2023 12:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 12:48:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 06:48:33 -0600
Received: from xhdmubinusm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 14 Nov 2023 06:48:30 -0600
From:   Mubin Sayyed <mubin.sayyed@amd.com>
To:     <krzysztof.kozlowski+dt@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>, <michal.simek@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <git@amd.com>, <mubin10@gmail.com>,
        Mubin Sayyed <mubin.sayyed@amd.com>
Subject: [LINUX PATCH v2 1/3] clocksource: timer-cadence-ttc: Do not probe TTC device configured as PWM
Date:   Tue, 14 Nov 2023 18:17:46 +0530
Message-ID: <20231114124748.581850-2-mubin.sayyed@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114124748.581850-1-mubin.sayyed@amd.com>
References: <20231114124748.581850-1-mubin.sayyed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a22b87-8bd8-456c-3a14-08dbe5100396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEE6rtxE8SVb/6YrTx0VAk89s7ylZ/rpNdtrgR4shIV0qZKDkb0x8XwEvz8RXLZgdN3D2StafJOQetcTPkAWRixjPgLe5TC1tyLGcQAByOvt3zfI6cisvxqSN93qKBEVsAXE7n1Hzdx/pyp5f/fg2Da1e9rNatdIT2hnSrcOtMtn+u+z7Pbfj+WufGYcPx7SZG4bN3T2gYqk2FGKd++nnzAnmjdPNXjCy2XH6M4j/BDnNUwgD239hPpPcFI/o5ZAmtWfkVwP6OcZVunFokHUwWPzhxKmFLP/3josvvNPLTwLW87N05gd+TFlpvvt7AuqCIS1hOKkTK8dzcunZbfm2yLJa6hRvQItqxcNQ5GDzr2LYpe7TWAEUGOkn6dj4CqWpJv/IDC2vevwpi4S9PvFl9PozZetCL66W9uw4yCapC/Z/Pizlkw7kIkn8cgLqMtoFf62wPeAcAPgjwJ5JpmsYWXujrMpLcvEQR1toreSc+fXyhvRudoqETl9fsjt/VX0lfzwYdAxoUKIA2+0mLOj/L/eFnNpVuhkevktopUF5qfhRnl6/7pydbikIIs2BN1PI2xUCXLDhZyd5rJpT62drM+4S21x8EaTkvxlQwIwn9ynXWA9vg/EuFbpTxhxWnvqDiZPdZizyLohJ3PzvppWG+aJfKiIRlKbcljhyMifZE4eiRmSlTUMacJ82RUDl5FGUU4sVOgvKHcf3brpOQ/6gDo7S9PP+FA8KX1fUA55hTI9suYka0C5crpRmbf6uMa7bmVzLh5OaIzirrZAf86gQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(44832011)(478600001)(6666004)(4326008)(8936002)(8676002)(41300700001)(70586007)(6636002)(316002)(70206006)(54906003)(1076003)(110136005)(7416002)(5660300002)(2616005)(26005)(336012)(40480700001)(2906002)(426003)(40460700003)(47076005)(356005)(81166007)(36860700001)(83380400001)(82740400003)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:48:34.4846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a22b87-8bd8-456c-3a14-08dbe5100396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TTC device can act either as clocksource/clockevent or
PWM generator, it would be decided by pwm-cells property.
TTC PWM feature would be supported through separate driver
based on PWM framework.

If pwm-cells property is present in TTC node, it would be
treated as PWM device, and clocksource driver should just
skip it.

Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
---
Changes for v2:
    - Added comment regarding pwm-cells property
---
 drivers/clocksource/timer-cadence-ttc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 32daaac9b132..f8fcb1a4bdd0 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -477,6 +477,13 @@ static int __init ttc_timer_probe(struct platform_device *pdev)
 	u32 timer_width = 16;
 	struct device_node *timer = pdev->dev.of_node;
 
+	/*
+	 * If pwm-cells property is present in TTC node,
+	 * it would be treated as PWM device.
+	 */
+	if (of_property_read_bool(timer, "#pwm-cells"))
+		return -ENODEV;
+
 	if (initialized)
 		return 0;
 
-- 
2.25.1

