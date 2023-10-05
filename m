Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A771A7BA9C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjJETI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJETI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:08:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869D8D9;
        Thu,  5 Oct 2023 12:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4sBYi1BxXh1+HSMe/Wj8VQpviqjDyB+YmJxv9z24EPvmHkXylHlyyZXLQlDKPWdEvR567ocCpbwCNJhHXtlfC+EltviBBBQbHjXzefSqYhqrO91RpaC4cjK7/y5llvVeyTJeHRNtfDDeDnHsSuvWnYMl2h1R27GZnb0vWs764OgSboP9JY/VZsl5CFDXTX8by6BJwBQTifJ61U7m4siLGo9gyQTI6AA6aRfvqJLvN5WAYbzavYv/uGynfCGI7PG9cQALuAOznCF3Fe/FCfzGE0pKgm9lsp4MkEIlVtPR95MAXixKXk7hjIb6NomS+fhx151FmSuSRh41E0rkVGz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7ct8XEN4sYtDcf7jfUZkbZ6UbDgxrdnVCn2KN3UEeM=;
 b=FxxeM6YSNCEWfPJDF+c4j4iByEs/YnbGNoVUww5n5pf6OXeA6+kvafq2jiTocTvJRpYdCjklkML/6GVjiUan7oDwLkgKrHLg3Xffz9tNh3eSOzoZ89eN3EO8Iv9uPYwR/u61IMg7CmpIQViWAo28lrgkht9Fv3ZPBr4DIeXWC7lmeQlsJln2icTHx5wf5kTdXjvvHcRNUCWl59KdmkqkI+mja76yyLnvFgwbiE9Ad8GYau6iin21IQvdSFiKVADUZS2SOeVWLUmiYojBXVQ8p4VloPt86dj74lEoYaQg5idF0AFOQiBbiSQDOKWt0De3fLeDuD0RK5hPw+gwkobOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7ct8XEN4sYtDcf7jfUZkbZ6UbDgxrdnVCn2KN3UEeM=;
 b=uaZE8jgv4acSwZY9ze2hVmq+dsSliDP3v9mG+aXtpt4jUTY5I2Vnb6iBcXxrCKnZ+V/LOZOMs8d64El1CmMiqs5+YP+bWgwbLIAaJpz+W8g5Swld2u9BkgBArozuYZQQPFg5qqEKN1mIQ4mz3rMtFjdLYZBu24EfqFgqcd3nV7I=
Received: from SA0PR11CA0189.namprd11.prod.outlook.com (2603:10b6:806:1bc::14)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Thu, 5 Oct
 2023 19:08:54 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::7e) by SA0PR11CA0189.outlook.office365.com
 (2603:10b6:806:1bc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Thu, 5 Oct 2023 19:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 19:08:53 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 14:08:52 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@kernel.org>,
        "Sebastian Reichel" <sebastian.reichel@collabora.com>
CC:     Alex Deucher <alexander.deucher@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v2 0/2] Fix Navi3x boot and hotplug problems
Date:   Thu, 5 Oct 2023 12:52:28 -0500
Message-ID: <20231005175230.232764-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f818141-1e9a-4214-bd21-08dbc5d6847c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4O3q2PG7Fg8C0e1nNrfAFwIEBBAoCBLlSbM6+LFSeFcY0Dx2xgiVoMP7zv7YCdftETHOHxljgNo2VgAzijC28g1ZC+1AqULEA6jgWHtS6hPlM/gEzWUfqGuE83r7DgrBoYUpFT9F3DPg44Gm3FODWrmvxipK5/eM7NpVbMH0s/h9nYK3T/k2YCWCn78fiXia4sJ4Gjk7sf4ZZf8KN+Fl7ABDNPbb/vCSsfSH+piCVyh0BqhBsTx4Og0Vv1qgDKlQ+8nXA4zC70e0lwWxsBLk7Etx6K6GOIkI+pKBgpTyqkWoyDykpO0+bDxgN7DDH1vNqwSNDnZgyOKsrQtcpMB26E+614SMcn9AJqvs3T8DNP3PMK/9vPbH3X+cv6vjuDEdcr1EjYv58an2hKT87rhjEhihCbvf/1FpjUXwsUOjoQUe49pzW42qqVZwefswqxpHO62Ey7LvUHCNfLHS+H9hk+SIG3QtRBhnVonnoA2wbUapUZ+uK6kLLxvyqbjoSTcaMu7me7iOYFZjkHS1PYjwTFS+peAK1bEOuB7qg6inAiCdCNY9f3B7ehdXNnso8o/o7zywW2AU9iLLGsUMSBe5P0yzRRcxf7X9KSpfIZirmfyf/T5GbACQDZyE34khIWoqYrlNPMwvHlCu5jVgHa+5ncjOxVXoWqRZftsfqfiuOnUsRazD9//uf7cdFt/b3Nb3G9y9okqRxNmU8leYv5FVrSbdCwBiVa46b+M7q54ThrGQ/QDKN7+QXoICHWOYZj6eiPj+wlBQVSjlMtbgh/MtY6Ni8DsBxpBW9bOVjEYjwkE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(426003)(16526019)(40460700003)(1076003)(478600001)(26005)(2616005)(966005)(336012)(81166007)(82740400003)(40480700001)(7696005)(6666004)(44832011)(4326008)(36860700001)(5660300002)(70206006)(8676002)(110136005)(8936002)(70586007)(41300700001)(36756003)(316002)(86362001)(2906002)(47076005)(54906003)(356005)(83380400001)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:08:53.8872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f818141-1e9a-4214-bd21-08dbc5d6847c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some OEM systems multiple navi3x dGPUS are triggering RAS errors
and BACO errors.

These errors come from elements of the OEM system that weren't part of
original test environment.  This series addresses those problems.

NOTE: Although this series touches two subsystems, I would prefer to
take this all through DRM because there is a workaround in
amd-staging-drm-next that I would like to be reverted at the same
time as picking up the fix.

v1->v2:
 * Drop _PR3 patch from series, it was cherry picked and is on it's way
   to 6.6-rcX already.
 * Rather than changing global policy, fix the problematic power supply
   driver.
v1: https://lore.kernel.org/linux-pm/20230926225955.386553-1-mario.limonciello@amd.com/

Mario Limonciello (2):
  usb: typec: ucsi: Use GET_CAPABILITY attributes data to set power
    supply scope
  Revert "drm/amd/pm: workaround for the wrong ac power detection on smu
    13.0.0"

 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c |  1 +
 drivers/usb/typec/ucsi/psy.c                         | 10 ++++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.34.1

