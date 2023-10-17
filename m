Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F177CB898
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjJQCzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjJQCzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:55:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB8B93;
        Mon, 16 Oct 2023 19:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3TUsHOf1bt3owsxr8u+F1Cwc0qSjiVQNs0nmFXd/0M8nlOtO/+HMvgPnBU6TQ2IBgiTisvsCzSKmSm20IsES1KwkHcTp8ab9Els/HoGq3THR+fVhoqKT33YEt5xMTIgw4NzviUy2in3igNUJ6qRE+D020UtIzdMVNzSg3cYQkIbFQtP1MRveUOARM7RPrXAXk9+HofsfHBBltP0mhpHdUO50wuxV8PQ6hp9W467oDdrgePGZ3OYAXmXC/cdOz9axV3F3FhpluzVMRxndLfEPfJuYMXa0dG9ehcFurfUmmeqONVsNkgd0k7uO5GVu8sq+2XssEzrCu5D6kTXFbRdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0CXVGp2TsFtrJzx6bxn1zqnOahBypOmxG4hohg0alw=;
 b=eN+sOtzmyBkq1uOodzssrsboTYVdPyYLh27DLYljrBk+CJiPjbDcFjpaI1SYCg2p4+N4DuumNaCP+hMAH1SFbbdoi9KrA7YKdLuM9lsORR3sMVnUQdI1ICJgq1klv7BUwG+MrfdyZreR3LoQ0G1SgpfGcBHkFl1yOUDHif8D7HSUstqMsu/5YxpurF0mcugv+nphEoL56hVkDOVmosBpkIoGUAfz4Y+kQLyPKolxr/oIEV25+746EaNIkjApQ3rwiP15EHkBBnkx4PVdaRCBGRi1e0WIsBOWoyTT6xBdXjeUG6GjjlL17tiw40MZhBhBSDgX4RKCycPq6BIr+msi2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0CXVGp2TsFtrJzx6bxn1zqnOahBypOmxG4hohg0alw=;
 b=4nOtV99sXTZF14/yTj66YNYs+tlN36dGhod0GvcyfUdT/qvJeHLYE9Qm1Kt7g7laSwFX042N/BFgf85GtMm9NQQVLz5y5H327UZQ0uWl5+A6Ug0RqyMEug1rnp4fp8CyvAUQBslxVitdPMzbWWSL8ujpjfSsjKbSZpkhZ6Lu1Tc=
Received: from BY5PR17CA0047.namprd17.prod.outlook.com (2603:10b6:a03:167::24)
 by PH8PR12MB8606.namprd12.prod.outlook.com (2603:10b6:510:1ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 02:55:05 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:167:cafe::d8) by BY5PR17CA0047.outlook.office365.com
 (2603:10b6:a03:167::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 02:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 02:55:05 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 21:55:00 -0500
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <alexander.deucher@amd.com>, <Lijo.Lazar@amd.com>,
        <mario.limonciello@amd.com>
CC:     <majun@amd.com>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v12 1/9] Documentation/driver-api: Add document about WBRF mechanism
Date:   Tue, 17 Oct 2023 10:53:50 +0800
Message-ID: <20231017025358.1773598-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017025358.1773598-1-Jun.Ma2@amd.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|PH8PR12MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f56a8cc-26f6-4456-82dd-08dbcebc7775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Drp5nQpGQdpZ0hCYLH4QrDk0kq919+k11/4IyUcarebWEzL/iLPhIG8o1DYVd7M3G1HWpa/5ogzYTd6mMSCWy2Nsr4LPzQaIIv8X78Jy6LhVYVPFyx8ZUr9efNJ1QWhEwi/NwNP1qJBq8Un6tI7Y895lbklpXr/v4TjQGQqec+4G7tkwHLIL0IDrRx1wXv2gS2lsbg70Rn5hJKkttiiE1/8F/6Ppvw9LY3PGyKsXOwSWJcXRVRRNn5b0tFPGVPPEMWB2ZLA8S3UK1jTYS2WTniMiucWE7DoeF7EgTGbwycMdQRM5Hx5JSUpQ6Qd0F8P3XxUNc52JR+Wcz6NkIJvtt4ZOwkOSjW4bMsiENNYgdTl1/8LnnK+FOeKT3ujE/au7wFjNKH3S92IEyC2BNdGiBWoXwnKEfdYzzpE8i19f7tQeXak/f5u6D4IuiL3mYkXRp47tRNB5kTfI9ktNek2ZCc0Fv6jnTnNrLNFg+X6XrxrythrF8KpAneJkOrp0lICoDS8AlZS5FHURolETARehfn++w9fwhr5EJdf5X65iXhVXAIKnOCE+g6z7kcsf7y9QOEH11Hjr97hGGCdssMiCpt+ssQV5qGw5hoAjwG8MhnSHtTRVV9CauF67c70LVkcukpui1icJw4HTorxZftxcqt7gg/mIGh47o40ewVe3ouNN3rMU3qjBYcdvS4mTRbrYMHDdhbudVpanhApm0wIwASvQMABfuyDNpyIs3f7Jj3QDo49EIM3j8vC1l4KucrWYV14lPOBuctrI4ZGyDYSsxFsySC7CxfRbSn02Wmlqm0c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(7416002)(36860700001)(478600001)(26005)(2616005)(16526019)(6666004)(7696005)(4326008)(8936002)(8676002)(83380400001)(5660300002)(41300700001)(47076005)(6636002)(1076003)(316002)(70586007)(70206006)(54906003)(2906002)(82740400003)(110136005)(336012)(426003)(356005)(81166007)(921005)(40460700003)(86362001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 02:55:05.4701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f56a8cc-26f6-4456-82dd-08dbcebc7775
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8606
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about AMD's Wifi band RFI mitigation (WBRF) mechanism
explaining the theory and how it is used.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 Documentation/driver-api/wbrf.rst | 73 +++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/driver-api/wbrf.rst

diff --git a/Documentation/driver-api/wbrf.rst b/Documentation/driver-api/wbrf.rst
new file mode 100644
index 000000000000..8561840263b3
--- /dev/null
+++ b/Documentation/driver-api/wbrf.rst
@@ -0,0 +1,73 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=================================
+WBRF - Wifi Band RFI Mitigations
+=================================
+Due to electrical and mechanical constraints in certain platform designs
+there may be likely interference of relatively high-powered harmonics of
+the GPU memory clocks with local radio module frequency bands used by
+certain Wifi bands.
+
+To mitigate possible RFI interference producers can advertise the
+frequencies in use and consumers can use this information to avoid using
+these frequencies for sensitive features.
+
+When a platform is known to have this issue with any contained devices,
+the platform designer will advertise the availability of this feature via
+ACPI devices with a device specific method (_DSM).
+* Producers with this _DSM will be able to advertise the frequencies in use.
+* Consumers with this _DSM will be able to register for notifications of
+frequencies in use.
+
+Some general terms
+==================
+Producer: such component who can produce high-powered radio frequency
+Consumer: such component who can adjust its in-use frequency in
+           response to the radio frequencies of other components to
+           mitigate the possible RFI.
+
+To make the mechanism function, those producers should notify active use
+of their particular frequencies so that other consumers can make relative
+internal adjustments as necessary to avoid this resonance.
+
+ACPI interface
+==============
+Although initially used by for wifi + dGPU use cases, the ACPI interface
+can be scaled to any type of device that a platform designer discovers
+can cause interference.
+
+The GUID used for the _DSM is 7B7656CF-DC3D-4C1C-83E9-66E721DE3070.
+
+3 functions are available in this _DSM:
+
+* 0: discover # of functions available
+* 1: record RF bands in use
+* 2: retrieve RF bands in use
+
+Driver programming interface
+============================
+.. kernel-doc:: drivers/platform/x86/amd/wbrf.c
+
+Sample Usage
+=============
+The expected flow for the producers:
+1) During probe, call `acpi_amd_wbrf_supported_producer` to check if WBRF
+can be enabled for the device.
+2) On using some frequency band, call `acpi_amd_wbrf_add_remove` with 'add'
+param to get other consumers properly notified.
+3) Or on stopping using some frequency band, call
+`acpi_amd_wbrf_add_remove` with 'remove' param to get other consumers notified.
+
+The expected flow for the consumers:
+1) During probe, call `acpi_amd_wbrf_supported_consumer` to check if WBRF
+can be enabled for the device.
+2) Call `amd_wbrf_register_notifier` to register for notification
+of frequency band change(add or remove) from other producers.
+3) Call the `amd_wbrf_retrieve_freq_band` intentionally to retrieve
+current active frequency bands considering some producers may broadcast
+such information before the consumer is up.
+4) On receiving a notification for frequency band change, run
+`amd_wbrf_retrieve_freq_band` again to retrieve the latest
+active frequency bands.
+5) During driver cleanup, call `amd_wbrf_unregister_notifier` to
+unregister the notifier.
-- 
2.34.1

