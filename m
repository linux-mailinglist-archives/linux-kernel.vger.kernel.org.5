Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EE180C5AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjLKKHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjLKKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:07:09 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8819A11A;
        Mon, 11 Dec 2023 02:07:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PP69ZGdaP8HwhH7m/k+ofsBZTb6q8gObPOQw7cFqnXyR3FZdaIkdV7ojkiBodqw2Yfz5IDoW4swJKp0N0BUaPRohychvvfjKU654N1jM7fRK19OlC6KVUsjk6r+vVUor6s0oibU3Ty9dt8bUgq05SMrvnZcI62cX+Vy34P5zhKDKds6emLlJc2Im1N48vcfTLc+vwkWOPR78Rai6WOvKeV99MCKC93iwDld4l/h5T4gEzNKZQEd9J1wqAjCNrXNC8ij3MJy21S1/tzlBc61qXagYInGTsfDcWxjwCI1WTB+h1c3xgII8WMyI88X4YGvm45ugw+tiFBGq3S7MZjLW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vLpufIyBzwIuJXL0vAOrpP6wH8vbrjdptokescAUYI=;
 b=gp7vyA0MMJUQrq7LMLp+ipY+ardVd8awMA0rt1yoQaGKIN0Z9AZFJmJZMsAOSE1Ybb6EqkC9r2Ug/ADObSjHj2rH7wtSv3SdWLL5CrTnE7OhkkskxO2i85vYHUMQxKndWN0vwS5tIbr/lMHgLPu1z1Dabhoc8OqX7yHRbrWqDs+RfHADL7V9TCuAXxRgt4y3KzXGVZ1AW085A09VdHrDhhpC+jP31akpgqfP4VV6Fy7VaBIYklwV+sVVkMgZ1WhJDkziJPOo8N5pccwJVyeeMP7qk1wGKKwTvKzCkmxMUh+TgVdhgDV5nOKGa2vChn26GL+x5dM9Cnr3IRzShH2IJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vLpufIyBzwIuJXL0vAOrpP6wH8vbrjdptokescAUYI=;
 b=kZFtF+aHQdARm+75jghL7TGHzvysKVH6V5MlX+4ghkLVUrZqLMusmHaRXEM80M97t0/izjuppqSFe/JqgHJw6XVOOnEWAJSsb8gdWr9PQbAkQ5pgfbhuBuKsENPoSxegf4KtY51f9EdIG9ltY10ss4mRv5zLd/kqqFNoOgNG+iU=
Received: from CH2PR20CA0004.namprd20.prod.outlook.com (2603:10b6:610:58::14)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 10:07:08 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:610:58:cafe::7d) by CH2PR20CA0004.outlook.office365.com
 (2603:10b6:610:58::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 10:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.2 via Frontend Transport; Mon, 11 Dec 2023 10:07:07 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 04:07:00 -0600
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <hdegoede@redhat.com>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>,
        <Lijo.Lazar@amd.com>, <mario.limonciello@amd.com>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v16 1/9] Documentation/driver-api: Add document about WBRF mechanism
Date:   Mon, 11 Dec 2023 18:06:22 +0800
Message-ID: <20231211100630.2170152-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211100630.2170152-1-Jun.Ma2@amd.com>
References: <20231211100630.2170152-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7c7f65-5f8f-49bd-2109-08dbfa30ef28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bbe2+RqZG/XgkUggWa+p3gHD7h76tr5PSzgq5ORHimWW2q2GNf0QE+Mr06B7syNHPcZhhsZ3u+DyK/byVZRZA2hq/AbyCX6mLtIPKsK7avTslRD7/lwHwV2AbTaYlM6CDF2dFcW29YJVa5EQn+XUWb2KZXekvzuWz5j+GBFQYJjx9jxrV0072y1/ipcTCRfoKThrQd56xiCi2Kg2lzNAT8oJw1qgd9+PnlKJZxOScyWONiVh5dSCZSLHI9If7fjLnoNFjOIFhgDVjI746yx8FvPdLYpT7LvdkY1PA10Dmrjddc3mi72gQMClA7uhMsZ1fOmzUgrWUaOmOelSD6dOB/6W2Ms7gzzXdmIKAHs2q9xVmqBPf1K5H9bG1cqZ3RaK/fLlgOd0MF0obRfLQweO809n93EIomn/Qz8GGrY1TDbnl1TNuQL3SxfuTG6EefjjJ4cohTClMQSGI4D0Nqxaaq+PBtjgASEIPMHYbEWAgMqSZvzL0QXnyMhTCFX4z5Aeh78dHwhiukMEdGb008IsRz4+loPaz9kropBoLa4qoQV2adLRPskS6tceyWsyTkbptBc1M4ZbegdTXqIP/peYXWNTjalcXLET+dJoG9IU24eL7OmgH57RRAcFaTSnGLrf/FZtj7rBweTifDiKtJPCXIS1WqGuupiYOkt06U4Ac/dX72aqjLfZSYurcbTj0eCTWKORsfo5xqRh5SuuqqyLNHbD1jrsREVsjsE6l0HLcXBN97kxXgkid+OmwPKgYOm+9zEamJ2GDfsQRr16XPLgBdD3uC5SHAn2VMioTOCKyKU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(5660300002)(7416002)(2906002)(40460700003)(41300700001)(356005)(36860700001)(81166007)(36756003)(921008)(82740400003)(86362001)(2616005)(1076003)(426003)(336012)(16526019)(7696005)(6666004)(26005)(47076005)(478600001)(83380400001)(8676002)(8936002)(4326008)(70206006)(54906003)(110136005)(70586007)(316002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:07:07.9097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7c7f65-5f8f-49bd-2109-08dbfa30ef28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about AMD's Wifi band RFI mitigation (WBRF) mechanism
explaining the theory and how it is used.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

--
v16:
 - Fix the compile warnnings
---
 Documentation/driver-api/index.rst |  1 +
 Documentation/driver-api/wbrf.rst  | 78 ++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/driver-api/wbrf.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index f549a68951d7..8bc4ebe7a36f 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -115,6 +115,7 @@ available subsections can be seen below.
    hte/index
    wmi
    dpll
+   wbrf
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/wbrf.rst b/Documentation/driver-api/wbrf.rst
new file mode 100644
index 000000000000..f48bfa029813
--- /dev/null
+++ b/Documentation/driver-api/wbrf.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=================================
+WBRF - Wifi Band RFI Mitigations
+=================================
+
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
+
+Producer: such component who can produce high-powered radio frequency
+Consumer: such component who can adjust its in-use frequency in
+response to the radio frequencies of other components to mitigate the
+possible RFI.
+
+To make the mechanism function, those producers should notify active use
+of their particular frequencies so that other consumers can make relative
+internal adjustments as necessary to avoid this resonance.
+
+ACPI interface
+==============
+
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
+
+.. kernel-doc:: drivers/platform/x86/amd/wbrf.c
+
+Sample Usage
+=============
+
+The expected flow for the producers:
+1. During probe, call `acpi_amd_wbrf_supported_producer` to check if WBRF
+can be enabled for the device.
+2. On using some frequency band, call `acpi_amd_wbrf_add_remove` with 'add'
+param to get other consumers properly notified.
+3. Or on stopping using some frequency band, call
+`acpi_amd_wbrf_add_remove` with 'remove' param to get other consumers notified.
+
+The expected flow for the consumers:
+1. During probe, call `acpi_amd_wbrf_supported_consumer` to check if WBRF
+can be enabled for the device.
+2. Call `amd_wbrf_register_notifier` to register for notification
+of frequency band change(add or remove) from other producers.
+3. Call the `amd_wbrf_retrieve_freq_band` initally to retrieve
+current active frequency bands considering some producers may broadcast
+such information before the consumer is up.
+4. On receiving a notification for frequency band change, run
+`amd_wbrf_retrieve_freq_band` again to retrieve the latest
+active frequency bands.
+5. During driver cleanup, call `amd_wbrf_unregister_notifier` to
+unregister the notifier.
-- 
2.34.1

