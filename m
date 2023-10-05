Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501AD7BA9C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjJETJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjJETI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:08:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09442CE;
        Thu,  5 Oct 2023 12:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH7qHt7wxjAnHXShQE4E+gP6lR3X/UWCU4INsMDcjrkTAecL8u/xmg3M1YeldsINMnLNupExTTlLcprTBXLUk2XFI3FHRD26DEDe6xLHjZM17t8Y6621qgd3BHpam0SbcQ+o48vYrIXRARC/j+GxMlY4joYgKe/lry6+ANN2MYsQEAmO4Dv4wwbmdJbRtKUmKsksbrm2syAT+aM7Q094KkSJYj2SzPIIF4m/olTyvZyU3vUQKvcV//IY15jNZ0E/UROta13eLNJX24yKx0ViDF1ggRg/bMlDaWrPKSbjvq5IGDMNPWhajoc8loHVgL0aUt6jJCBW69pNpgLaKyKhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp2cTumJVi3mAJgiMV6KE36sBVVzghUTHtsB/+7qgn8=;
 b=iu4VriuXaGZNhKACKCnD2uEE20KYyXsbuD8exbcSuD71Dv7kjZHW3EgrSeymJemelT8ArDt9FaH9xTJP1mkeg/+P40l1iJ2tYkn7nV3eC7l0Hd9RNWl0hdtq3cjP72bEmHdk6Sv0JOoZA0mJufcciQJIrUt6cCRaxWQ6i1E3xhCv7rJu7Ez0Hs6bFe4lZtd/K0qZhDq5RpR2Ip9ZV+b3PLmMN54lnlE4cnk09gK17SyUlpxNppf3zpNj2NaQRjWXq6jMG050X23itSRBehSB1dyN0SUxQSEvcqLXlHeGPajpmMWT5FtOv2DA1xH7G5YXmqgZtEcP1niu28E1S55fXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp2cTumJVi3mAJgiMV6KE36sBVVzghUTHtsB/+7qgn8=;
 b=EWuA/she2SudYt6w99ToJAftXni5+EkpjC5tdaVlx5P1iexmcSJD/xiHo7GHvoYoPVomVyGha8AHNJJH9R9wx8HZjo5xEbTbTwK43ZpUE3aAejHJ2sf8Y30MrOttAuQ4b+YUEJmclCtsK1p2nAwhlU7iFoagop+nIUrTfN+/4lo=
Received: from SA0PR11CA0194.namprd11.prod.outlook.com (2603:10b6:806:1bc::19)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 5 Oct
 2023 19:08:55 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::bb) by SA0PR11CA0194.outlook.office365.com
 (2603:10b6:806:1bc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Thu, 5 Oct 2023 19:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 19:08:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 14:08:53 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@kernel.org>,
        "Sebastian Reichel" <sebastian.reichel@collabora.com>
CC:     Alex Deucher <alexander.deucher@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Richard Gong <Richard.Gong@amd.com>
Subject: [PATCH v2 1/2] usb: typec: ucsi: Use GET_CAPABILITY attributes data to set power supply scope
Date:   Thu, 5 Oct 2023 12:52:29 -0500
Message-ID: <20231005175230.232764-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005175230.232764-1-mario.limonciello@amd.com>
References: <20231005175230.232764-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: fb69c665-55be-41a9-3fae-08dbc5d68521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NutvuUfbq9uKjuNf/ENzKm//W39kZfLC+RPuV+aXc+P1mz3Hnp5mrrR8mbzah61NR6Bz4Bgcx02Z0gCu/as7Zxy/hszyQB+7ZnqRZm5yF2OXHqJRhEnpA5qGXtdtqsCkrHG/1uWhOne5licBS3JCZ5hfkJexmdC7d43Og/ecXEfjDar2EUf8knnkdrRVLW9vhmhBSKpiKPBPHROO6c0ONAzrIOI5bgM/VpJQUCquWfEt6TqehaADbt9X6R+5n1MUz1F+gSjdsxEkMbuB8DdCTcOytPYIwhQfmJekEmC0lU7djWCg3mqfMIbZ/64R/ilpWsumy42zha63JpVkS84WFPsd0b8V2okH6/lMWzRNaKQwfDJnqaWgavolleMOozhE2/xpJvssW+nN+RL+AElOaYYvcNiwM6YtJzPhNUNgzY/HXclilXa+s7OVqn6RwEi763FUH798j7PyBysvWECeU0lN8xDvuZXyeh2LUae+8Z+QS6B+951TQtwQgzbIWVzbM/fYT4VVWQdclHJT5wx5hKrlA0HrVS0xl0NwtIhXKUWKfVHSWqtT6DB0KpNVhSESs995v+M4jtr0XCQ1SfOpYl/KzPl5EdYIrMQDv89+MdIFXYq+J7fiPckRPQifJWm5gpBnYUoAntmcpADkFlFoCVWr8vr18y3/0AVdgkzSG4wk7equnhg8miX9IlAQSxX4YF6HNKZ0j+jjNcjwGLfH/uznmuPfSSzZOEAdTYkpQhAecfOqbktqUsmAS8bDmh89PUbxWpq96nfL0cnbyZHiEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(40470700004)(36840700001)(46966006)(44832011)(5660300002)(8676002)(2906002)(4326008)(8936002)(41300700001)(70206006)(70586007)(2616005)(316002)(40460700003)(54906003)(110136005)(16526019)(36860700001)(40480700001)(26005)(336012)(426003)(6666004)(36756003)(1076003)(7696005)(356005)(81166007)(82740400003)(83380400001)(86362001)(47076005)(478600001)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:08:54.9654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb69c665-55be-41a9-3fae-08dbc5d68521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some OEM systems, adding a W7900 dGPU triggers RAS errors and hangs
at a black screen on startup.  This issue occurs only if `ucsi_acpi` has
loaded before `amdgpu` has loaded.  The reason for this failure is that
`amdgpu` uses power_supply_is_system_supplied() to determine if running
on AC or DC power at startup. If this value is reported incorrectly the
dGPU will also be programmed incorrectly and trigger errors.

power_supply_is_system_supplied() reports the wrong value because UCSI
power supplies provided as part of the system don't properly report the
scope as "DEVICE" scope (not powering the system).

In order to fix this issue check the capabilities reported from the UCSI
power supply to ensure that it supports charging a battery and that it can
be powered by AC.  Mark the scope accordingly.

Fixes: a7fbfd44c020 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")
Link: https://www.intel.com/content/www/us/en/products/docs/io/universal-serial-bus/usb-type-c-ucsi-spec.html p28
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>>
Cc: Richard Gong <Richard.Gong@amd.com>
---
 drivers/usb/typec/ucsi/psy.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 384b42267f1f..b35c6e07911e 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -37,6 +37,15 @@ static int ucsi_psy_get_scope(struct ucsi_connector *con,
 	struct device *dev = con->ucsi->dev;
 
 	device_property_read_u8(dev, "scope", &scope);
+	if (scope == POWER_SUPPLY_SCOPE_UNKNOWN) {
+		u32 mask = UCSI_CAP_ATTR_POWER_AC_SUPPLY |
+			   UCSI_CAP_ATTR_BATTERY_CHARGING;
+
+		if (con->ucsi->cap.attributes & mask)
+			scope = POWER_SUPPLY_SCOPE_SYSTEM;
+		else
+			scope = POWER_SUPPLY_SCOPE_DEVICE;
+	}
 	val->intval = scope;
 	return 0;
 }
-- 
2.34.1

