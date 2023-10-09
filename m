Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363077BEA85
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378391AbjJITYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378385AbjJITYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:24:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940BCAF;
        Mon,  9 Oct 2023 12:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8KGXr2DL3YJsdTnStkGnnGtJRSCIWOMEgeCO/Hgg5hXGsBbUrKL0MbL2jzzAzxXyyfqr0qDdbQfEJCI9Usbl1cAu8YmOSsJjLe0HQow4a0B3QOJcgszfQWybjwOuVXm6oQXK2IckE9fKhGmsGuDegpPgLGqCDQxyLVgBFARyrLoTZ7HT7BAI09dj12vmDZ16nMTUqYO2BFqN0zs4hPauCAg0kqbHr54rnVZhf/ZLBIuIsvwhjxsJQoyYtVJ2L1rAptlJMnybj3kt8rSRPxz9QOuBmL6jCo2Nqwc5LmK8aQVvYdEfOtzyRBLGXXb4H6FyFqVg/9z9bHlc1rOGoXrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw+R3r5K6BXXcay1Rryj1r8v2jKH7ogIduw5kZ+F+qM=;
 b=FFYuvIZts2BWZpD22kngxwCcKSvckzeRRzleLMJ8TMq6hiomhwTotLiI63NPHaSjviWHSXHjGnY4Ww3mLW+1mr5E7wjxCGTLZJADYtF3ux8k39UCbxUScFW/hUiEaFAU6T7dxUnJIzKUHx+EwNOPhkYLShCNz52kiCM7es2OLqYnN2sRlkDYoAZDmlopPlqJVZCFEGK/V32cTopAgc9QN9Pvcc+2hMfL3QNp2YNWgcIBe7AUJrUWrcaYw3p5OIdBGWj7emEk7wkpMkDBgsSjuZ75tsJUnOUEL9ClykMWUraqz2fsydQs3k4BtOcNYo4rIdnihec7MLHklzyYmJjBEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw+R3r5K6BXXcay1Rryj1r8v2jKH7ogIduw5kZ+F+qM=;
 b=XGAZHhWqU6ZbxVkEsbhlO7lExWeEaWyTq4nQ0rEXHHLTQ20o8D+mITLKuCtOwOLKo96uuw6LrJLAYT3gGM45MnSlEaAUE5AoV43L2YIXSPP2oAXVifEvf/QEkluBzvisBcQ506ftuKhA4B11AdZVt+Q1LxRXHPEMg3c2I+Lsr+A=
Received: from DS7PR05CA0057.namprd05.prod.outlook.com (2603:10b6:8:2f::21) by
 PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.36; Mon, 9 Oct 2023 19:24:34 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::5) by DS7PR05CA0057.outlook.office365.com
 (2603:10b6:8:2f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.19 via Frontend
 Transport; Mon, 9 Oct 2023 19:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.21 via Frontend Transport; Mon, 9 Oct 2023 19:24:33 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 14:24:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <wsa@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Alexander.Deucher@amd.com>,
        <Richard.Gong@amd.com>, <kai.heng.feng@canonical.com>,
        <sebastian.reichel@collabora.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3] usb: typec: ucsi: Use GET_CAPABILITY attributes data to set power supply scope
Date:   Mon, 9 Oct 2023 13:46:43 -0500
Message-ID: <20231009184643.129986-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: fa96d12b-0d49-4104-2239-08dbc8fd5e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCnPKAIXwLsyKPJ92ClvPkLnTdj9o8uPdgXUuc2ndC1f20hzM0rX0SusrUccqx8QRVCkrq012ZQV1si9oivxh7uMbOUAAOAvOmCZG4Z8LfSVTik96AeFRiHGuW/nUKU+kuVBfTuJ0Dj5NFt//GjZyh7PMEXtkx8MUwNS0dY8NIPXStllhhk6p1hV+eMJW+/TVeNJPjOy0qULqd21L/dVoHW/6qLu2VQdZW3EfELcs7YhBsxeXo0pYqOHMpxRxx3cBh/vdj3zPt/gyTDzWBK4JoW/e/ZoLVFrg462T0+uiJ/0UYADbvGLG5iU3v/v1GO2xE5yv2s8EonbP5Bwc2RbNLzUNSPCq7EmHW07YBzdGFnR3AU8EEur3ttPAJGYeI5Z6fnw9pEFzruuwr5RRVTxwW8vS7gnFkaWQ3XE2DNLIAT0fibpRQ2SkVAG1iD9pQcXAveWuvDVW/dgVcwixddGSAFsRaJain0QwCNhjx27X1SuzeQqEMYMK5jKb9yrGKRBguYixk8HSlBSqMxDmgbbr78aFNak3+4PXjKaBHZ64Mk3jtT6TzHv9pPMU/LBjSHiKY5r+wJ/41WvzKeCcjdETO+86Ye91+iA5/Y2u23EiwvdNxit+Ip3XAZkKVdoy90YFEv36ah5+b0xBDQlvKfMn5/klV80uT9RiTTa5E6YalXfsH6AnZiUzbuVSoxK09BC75C2XDOIPCwyOKetwWPWWZTtVTLgFWgCeACn2hyjGH9KNyMlVZGZ26VMb9tJlN7U5N+A17/UzRhgNxazAFS5hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(82310400011)(451199024)(64100799003)(1800799009)(186009)(36840700001)(40470700004)(46966006)(1076003)(426003)(16526019)(336012)(2616005)(26005)(8936002)(6666004)(8676002)(47076005)(478600001)(36860700001)(4326008)(83380400001)(2906002)(110136005)(54906003)(5660300002)(70206006)(70586007)(44832011)(316002)(966005)(41300700001)(81166007)(36756003)(86362001)(356005)(82740400003)(40480700001)(40460700003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 19:24:33.8717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa96d12b-0d49-4104-2239-08dbc8fd5e71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Cc: stable@vger.kernel.org
Fixes: a7fbfd44c020 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")
Link: https://www.intel.com/content/www/us/en/products/docs/io/universal-serial-bus/usb-type-c-ucsi-spec.html p28
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>>
Cc: Richard Gong <Richard.Gong@amd.com>

v2->v3:
 * Pick up tag
 * Add missing stable tag
 * Drop patch 2, we'll just avoid upstreaming it.
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

