Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7624C7DF16A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjKBLnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjKBLnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:43:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095C4187;
        Thu,  2 Nov 2023 04:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XU/OOQdYyluK/3ZXPx1uGRkvZH+qNDmri/aYnjWO0eiVsX00DJXwXTgoP1T2oWmkDzzXY9m0YZH3NIV9K1WofOZGxRHMM2YCDUjB7OfQkh5P7iPsTz8LQulSCUfCBWNpKEltGrAF6qtQupfnFm1VYBimPqn4kdhLHjubFWST7CfLAYI3IBC9CTRfS5M23URlOGyESeYB7DraxgW5e51sDb5uAb0JUqrHmc6mJyCs8SqWQJo+K9fooVK3YluODZdeKRvc2gshBfCRKgzOWidOCsco6JW+Sfuh/Mxrs6NSeCW5Tqn+3UzBcT488hBgnVqOeCnRFCb6Hcyj/8Sb21MHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXgJn0z5TX54nuYWT4I7EaFe55aFSy/1UE7zmTeVDok=;
 b=ODwky00HCkM38wfZscjxGgCl/EGqp757W8W6vxPztl3JNYj9DM5fnQK63e2fJb1NRkdVYRMREKCOMvguHsjQreOtjeew7Pi3+lvb1VQUnAK9aNQpiXa7zs1UFvmILqdgw5bdu6+KHPSxefBgefd3GOwC08okZYghOp1csDsN7Li0T6K1QJkF3ckd8LMAYmGf2OSr7AR94sreAWq1x7BRvzZWTBk56DoLwkZS4SDnRuGz+F6u11qD3MaICxWjdEkRRO7nmmgsXAAYxnk9H9ZcRLReUApsNVVg5CX/PKi1RpOxZuYONhD0GOW5JgeNLP2CT6jjiyIHPiUMky7zGcSzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXgJn0z5TX54nuYWT4I7EaFe55aFSy/1UE7zmTeVDok=;
 b=4b8tyMZFGD/sqlEK2UJ7AqMutJvI0DO7Oa+YN7HtEhbJ0SaiXwAxIY+QSP4Xl2NY0KrXgbY+bDrLsClPmMwZRyNRnEGD1yXxEnEyvsbyaJ5dbmA3aZh6ZJPfi85cHYLjt6FynL/dlPeYdgdu0BrqVeVnmZXGCcOrGH9iOwVd6dc=
Received: from CH0PR04CA0036.namprd04.prod.outlook.com (2603:10b6:610:77::11)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Thu, 2 Nov
 2023 11:42:49 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::6e) by CH0PR04CA0036.outlook.office365.com
 (2603:10b6:610:77::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Thu, 2 Nov 2023 11:42:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 11:42:48 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 06:42:47 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v3 0/4] Few cleanups and AMD Family 19h Models 90h-9fh EDAC Support
Date:   Thu, 2 Nov 2023 11:42:21 +0000
Message-ID: <20231102114225.2006878-1-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: bee84b83-118b-4d15-ae64-08dbdb98d6ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YPcl9aVchjZzdEQShxA7MvCeUymYORwJKN7GCPRct79BGzsRGH9IVNvQgE7LGLhLKCOpBYkP4XXXRFg9J0ja1owd2vfblsbzIuNFkBkO5k03YPQD3XX2aKEXzewy33q2k53tmAGqjRJHthV5PrJeJZETc772jRgy1hiTOxLlj1JnwzeTM5M33xJKPsfn55X4vhbU+1Hk00GFE2fEYVyP9XGa5ZKVmIG7uv5KCq/y7xzNuQL7qyzTBzUkCdS8PpW208Ba+ovfwqYr/OWK0FA5Ur5rKfHr+ZpJ8MRf/WKOY4PEvkRfgZzlx78AJVId91h3NjEJ6lzKsIM3F5PunJyVqyrcIcFUCaCilU17ysffTDiIhUd/4uQTlsgKCCOK0kgkmOWLuMLQvjhnqyWSbIETGTJhqZLPQxzR5JKKhS0/FlyiwDe3nqzjn808cOw/1Tc+6ajg7VsBxdbS7ICYpu6zrmQSyC3HFRGYVjLuMy5z4o9KhVqKNG382MFXg2lfWiGFDbU6LLg1Xfnm4WiyeNM3+TlYynmJsnnl1HdKGN5vcCMv02OKa2ds8dMrjKg1A7WYqC4oOmi3JbeBOwYSXqnhCBAFXVYzMGuUZIdNQhne0Te9019IJxwSxDeQNaML4qPFc10cvOz7C7GeUgVSH76EWmwOQhHWNM/bcpJ+3goCKo0CmayZpAwj1hOYV/bCF6fhLc115xxozyw0VmGIj0EUH+pLhPjsSgp/E4+LoJsRqL9OvGEjgKFWnW9V4mxlrb6C
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(36840700001)(46966006)(40470700004)(40460700003)(26005)(1076003)(16526019)(6666004)(47076005)(426003)(7696005)(478600001)(8936002)(8676002)(5660300002)(70206006)(70586007)(966005)(54906003)(6916009)(316002)(4326008)(336012)(36860700001)(41300700001)(2616005)(36756003)(83380400001)(356005)(82740400003)(81166007)(40480700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:42:48.9819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee84b83-118b-4d15-ae64-08dbdb98d6ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

The below patchset is based on previously submitted changes
https://lore.kernel.org/linux-edac/20231025051455.101424-1-muralimk@amd.com/T/#m5834ca7109d159f7fc869031f3603dff8a79633c

Patch 1:
Remove SMCA Extended Error code descriptions, because some of the
existing bit definitions in the CTL register of SMCA bank type are
reassigned without defining new HWID and McaType.

Patch 2:
Add New SMCA bank types MALL, USR_DP, USR_CP.

Patch 3:
Add HBM3 memory in the enum.

Patch 4:
Add Family 19h and Models 90h-9fh Enumeration support.

Muralidhara M K (4):
  EDAC/mce_amd: Remove SMCA Extended Error code descriptions
  x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank types
  EDAC/mc: Add support for HBM3 memory type
  EDAC/amd64: Add support for family 0x19, models 0x90-9f devices

 arch/x86/include/asm/mce.h    |   3 +
 arch/x86/kernel/cpu/mce/amd.c |   6 +
 drivers/edac/amd64_edac.c     |  62 +++--
 drivers/edac/amd64_edac.h     |   1 +
 drivers/edac/edac_mc.c        |   1 +
 drivers/edac/mce_amd.c        | 480 ----------------------------------
 include/linux/edac.h          |   3 +
 7 files changed, 60 insertions(+), 496 deletions(-)

-- 
2.25.1

