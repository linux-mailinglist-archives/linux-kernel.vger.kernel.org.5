Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E79E812AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443406AbjLNIsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjLNIsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:48:10 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A541C10E;
        Thu, 14 Dec 2023 00:48:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of6kHC21SdPz+OvT/BWgZK6uyyGeoQLsrNTNrIBSkijWLo7or0llEORQKrelqAH2vrcrggUVsRTcCwShX4sxotIWi861jpx3iV0N7A1jwdVbqANv3sZK2jOGI0OZSaVS3S+gEk5g8OTgPiox2zi4+1S+rW5VSp8Hqg4HUEdfqoIjzo5tghwNZqDISmVHhCgcZfdY6ZM2V9i0PSguqZZCtCf7yw663vktB1trbApX/ivZaVINCAq3eKCSeY+ZxeGiF9bN79YkfdN7E77gDaav4fCy8XK6dVEH/7ZSgLOLQxWF2/m4Wy2W8SWpvvayHxXKkWI4OiaRS755atoGZ/ry9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kohp9aovBP8E9tYNNk7NuDHHzoSwuf/H4qwXvD+9frU=;
 b=VBc1GPgm/xVzI/rcbElwIuV+UGfBOZy3zY0xHMZHdnk/lk69UPhAJg0ki4NbdFmooDrCxaY0nZ2O/ei+TgXVgtlov8kG/PYxZjtbJiENEC0oa/utqCRpokmEg89TgqaDta+m1lRtdIH60yAjwAcB73KebIS8ILkJqDwCQ6MNIudEKjnk2JquaIgARXadkZ6VBjP8V78spJCqnhaZOIMA5euh3yL2nDt/H1hhQ0z/4bc8BFGC2Vc0TsDU1XtbwldI01i6u9x5qef69hrbBoJURQZf8LS9z0mb/AR3LAcwC/TjdHZWR5zybOT5BqykGkL6R7MehLUBMXR7pQ+1qdbiPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kohp9aovBP8E9tYNNk7NuDHHzoSwuf/H4qwXvD+9frU=;
 b=tWDjkBA45fEuiG3dGYiu8kNa/i71OhqiN07AP2lV3gf5LMwyOSTI2vPSFFvPeY1bjlfuGJmiXvfEfbCpkAdqHiz8IvRoGI99DYzpprL62Tt6CNkH5q+B6zi3XYHvobaBd7KS0Xl7MbKKqWlFGTB19+BNGazWOPnj3E1hktnafk8=
Received: from SN7P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::14)
 by BL0PR12MB4932.namprd12.prod.outlook.com (2603:10b6:208:1c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 08:48:13 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:123:cafe::d5) by SN7P220CA0009.outlook.office365.com
 (2603:10b6:806:123::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Thu, 14 Dec 2023 08:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 08:48:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 02:48:11 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>
Subject: [PATCH] media: platform: xilinx: Fix Kconfig indentation
Date:   Thu, 14 Dec 2023 09:47:24 +0100
Message-ID: <72c40d216769a97973cac9a347e826b943f71d7f.1702543638.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=michal.simek@amd.com; h=from:subject:message-id; bh=K/jzhQs4kxzyF5WmsxVmH5uT2t1DYAMkZam6F+ygK44=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSqg+JRqz5Gnl9wN0VF5aHjMh/xSw3Gmkv5Lk4SXWG75 +R5rcyvHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiz0UZFkysaV55Z9mp747x DwI8gzSF2t09XjLM07jXt3BhEVMH5yVuj4e260UYMtPTAQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|BL0PR12MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: a350f252-8f23-4f4b-4991-08dbfc81680a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nxfbaFGUnDXYvCsTtCMeEKFtX5VTC+lZKo/T1yzCu3SgJ9LezFQadlXSs8uvJySdBwfFITQ28m36KrxuzBeKXQtoRHsGDrf0ufSRv2uaJvWIeueJd7bdUR1EEPkncLQfX2oArnhj2QuM91BHiD+ONzYPWCFFJOZra03rDdjd15RoRJuSYFnT9gpaOxhVhYO/8fIl6iNFQUvQnHwBy9PZnv1jNjMklJQ0qtMFxVguXSVKBOdmN381CDGK7UccXEaWqOPNAb6RkfbA4q0nj+8ymIeS3QPmbOHxDkxQNe6D/oXR78zI4NqHG5IT3Nec3SM3u5sjIbJM7vWH1RXkjF7zfzI2iICJCKStlhTKlvu/d1rMrsyfqfgWcUvs2Q+41Qacv7ICiapqACT4idZTDGsCfvy2DPtSctDAdLhCPlGUlwGyCnIT1zW5sNJR6l3POlCykSdKnijO7RneZygOTYRneM7jGft0bA2KPu6JYVoMw71bkznA0sVMNPOwkBWoWQL0DispzbBTTNJZQMomV+Phy8P5C4HieuurYSwalmr274fLi+8vSiHAh2DhrOVVEYh2qWsDuIbbID7ZRHn8eV7E1+4FSYX29kos3Wa8EniSkpWNF/hs2f0akM9ieSY4HnchmbQPQ6EkgFrVxWAvDVxZCl/vdftt4CuChxQHDpfanG9CSz8VphsGtxETHQ3MGJhaEzwDoXz/pBIbRL5w/M395YR5pCSe+tQVET2ennLVzWJ5FEBk5o9KMusVnCwHOYHXmHgRIy5JLX+/yKH8DIqqEgCai3juv81QJqF+1asK6A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(86362001)(356005)(36756003)(81166007)(316002)(70206006)(110136005)(70586007)(54906003)(26005)(336012)(426003)(83380400001)(16526019)(2616005)(5660300002)(4326008)(44832011)(8676002)(8936002)(6666004)(478600001)(36860700001)(41300700001)(4744005)(2906002)(47076005)(40460700003)(40480700001)(82740400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 08:48:12.8917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a350f252-8f23-4f4b-4991-08dbfc81680a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4932
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use proper indentation for Kconfig fragments - help part.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/media/platform/xilinx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/xilinx/Kconfig b/drivers/media/platform/xilinx/Kconfig
index 93ef78bf62e6..601edd9acd5b 100644
--- a/drivers/media/platform/xilinx/Kconfig
+++ b/drivers/media/platform/xilinx/Kconfig
@@ -26,10 +26,10 @@ config VIDEO_XILINX_TPG
 	depends on VIDEO_XILINX
 	select VIDEO_XILINX_VTC
 	help
-	   Driver for the Xilinx Video Test Pattern Generator
+	  Driver for the Xilinx Video Test Pattern Generator
 
 config VIDEO_XILINX_VTC
 	tristate "Xilinx Video Timing Controller"
 	depends on VIDEO_XILINX
 	help
-	   Driver for the Xilinx Video Timing Controller
+	  Driver for the Xilinx Video Timing Controller
-- 
2.36.1

