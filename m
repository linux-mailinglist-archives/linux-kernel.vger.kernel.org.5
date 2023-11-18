Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681F67F026B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjKRTdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjKRTdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:13 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02234182;
        Sat, 18 Nov 2023 11:33:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqyX4kHCZeJYdJeIXIq2drEeVYIctCgD8Pm0BcmUyyuSNgPRl5RkzFb3RYeJGJHnr7UkkDaaeokD/tkOV5eQaOZ6FXAwC3am0lfCD5qzHanmX8dpsP8hzV+ddgLI6BtzXiJ+xEvDylLODUSbb7HTRRqQKihykAznTv59kBBU9PVXnLQUAv6b4DNJ2nOzND+kFxS3If7pmI5Mn8XaSyAGLYCrKPb6KJgjjKSbANBwHhakW9K9pOlKqDjm9H0vWRwl/Q72cOkzgv/9zBjo4V43OMyiDgKsRcq1k6LDXrCnwRtCw3I2b+FZymP+1t4HaSrpoeC2PZ+V0xA4A8LxKJV3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAZWfDa3DgMkRgAynu5l1ASwco90ykFtIFsq8b1RAgo=;
 b=QIom4ZZWczzgFzWurrv6WF3uS74NLBxgrP0Io1BeFk9q/zNxKKUfBbeK9IAoNxoUHMYOoUmxcJkk/DlhXF8Pk8nSz6Ao7/jH6OLaCbZBIqokLE96Ia9NvnRa+B/wWgB3yeroxaZi1sAgo6i+lcArA9r0mKM2icIsAHMWFAw3aGHgBXnUvm3DAXFerr8zpvHCF4YGc2oNTGFNooASjFamE4ajbO6ceEiQxG2TIAiQSvF14GnfUXFaW6KJwREuvulwp9nfjyW4AUWPoGOGBEnf3LNRvhC5jrBvm1zczf0kM+a/krNn4kfKSkHghoOXPtJwY2wo0TbPNaya/DPhKtQobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAZWfDa3DgMkRgAynu5l1ASwco90ykFtIFsq8b1RAgo=;
 b=CcqY5+S35RUKboajHkPAMT62zFEJoBTfZ/78b3GIru2iey46etYXeydRb0IQIlN1c63RES9whF0qFofC5I4/adZUd66xrISLALOvqNM3+wZrRi7u8QR4dpYe6esnhEfasqOct82iSY1hmD0tfiUKREow6hSdFQCwXHykECIQJUA=
Received: from BLAP220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::9)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 19:33:06 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::32) by BLAP220CA0004.outlook.office365.com
 (2603:10b6:208:32c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:06 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:32:59 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 00/20] MCA Updates
Date:   Sat, 18 Nov 2023 13:32:28 -0600
Message-ID: <20231118193248.1296798-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0d9327-91b2-4030-687b-08dbe86d3045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADb94+cvoT9ZzCUU4xEz0Awm1BvRe9enREgnbFoWmO8GdarM6EzeSGIM8J/Hxda9JTKkpbbFIQMdeedS3bJeS9huSMx4PcLRkBHbA8D5gZGw0sD6dl8WqseISoSWUnbgCD4+pMwpWrUtwMDJkXRWLq5i/olsYwYvvZ4uj0IGHZORSw39Jxsqpjk6/s1L3LQ9LSuso1SbumBgGKhjpHJCJlZTUKYKpM1JrNq5WEn1s6ghz6yxvbXbztldZe0w5ebEgmyfoiHixJvHFTlACqkodT0JWcaRXvW6Pk8+eYwE8f7qcngNsUXgHTeHzO2SK9nLsCPZoY14PVC03od33rpweCassEDmHKQlwsoLRuNo/eAmhUXpA0+zmqWB/q9Mp0qAfhZJHK0XqBmKBczv3oE58miO9Ab2qyYDbpnWWKnXQo0ZH+hTXEAbfA/vm1NjJV2dN8ng1N5u3RAdXRKNjmZJXbaGmS/mivrzEnnxR44b0oja8UCuZsBQAlQVS7xOOJpQWxL1PLqCZ8OVQhjE65xxkAbiTwNNvRhGmlL0sObazmFfbgxk9gqpPIicxKV4+J2K6QQu/Og9e7ogrryiJzHb2HM7FE3tO0MJO6XgI6NQndDCqCWS8zF+ytN0M5pUCIqXpFPW8rP6HEuSdY2ZJbtnxxqDE/DKuS1Kida/8orUQ/+OQeNwOjhtIrekoUTns6Kl0VOMo2oKegQYTCdho+MwpuxO0JQAdf7bkJnBszTA2X4nu8MIi8Uc84te/XFMGOC89wDhztWwHggWtXRAoEb9v/fFnJN9Ng+xUOpqvO6RAkI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(66899024)(83380400001)(426003)(336012)(26005)(16526019)(2616005)(1076003)(47076005)(36860700001)(4326008)(8676002)(8936002)(41300700001)(15650500001)(2906002)(44832011)(5660300002)(478600001)(966005)(7696005)(6666004)(70586007)(70206006)(6916009)(54906003)(316002)(36756003)(81166007)(356005)(86362001)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:06.1522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0d9327-91b2-4030-687b-08dbe86d3045
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This set is a collection of logically independent updates that make
changes to common code. I've collected them to resolve conflicts and
ordering. Furthermore, this is the first half of a larger set. The
second half is focused on refactoring the AMD MCA Thresholding feature
support. So I decided to leave out the second half for now. The second
part will include AMD CMCI Storm handling support on top of the
refactored code.

Patch 1 is a small, standalone fix for an issue I noticed during testing
of this set.

Patches 2-3 are a redo of a previous set dealing with BERT MCA decode
and preemption.
https://lore.kernel.org/r/20230622131841.3153672-1-yazen.ghannam@amd.com

Patches 4-12 are general refactoring in preparation for later patches in
this set and the second planned set. The overall theme is to simplify
the AMD MCA init flow and to remove unnecessary data caching in per-CPU
variables. The init flow refactor will be completed in the second patch
set, since much of the cached data is used to set up MCA Thresholding.

Patches 13-14 unify the AMD THR and DFR interrupt handlers with MCA
polling.

Patch 15 is a small fix for the MCA Thresholding init path.

Patch 16 adds support for a new Corrected Error Interrupt on Scalable
MCA systems.

Patches 17-20 add support for new Scalable MCA registers and FRU Text
decoding feature. This is a follow up to a previous set.
https://lore.kernel.org/r/20220418174440.334336-1-yazen.ghannam@amd.com

Thanks,
Yazen

Avadhut Naik (2):
  x86/mce: Add wrapper for struct mce to export vendor specific info
  x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers

Yazen Ghannam (18):
  x86/mce/inject: Clear test status value
  x86/mce: Define mce_setup() helpers for global and per-CPU fields
  x86/mce: Use mce_setup() helpers for apei_smca_report_x86_error()
  x86/mce/amd, EDAC/mce_amd: Move long names to decoder module
  x86/mce/amd: Use helper for UMC bank type check
  x86/mce/amd: Use helper for GPU UMC bank type checks
  x86/mce/amd: Use fixed bank number for quirks
  x86/mce/amd: Look up bank type by IPID
  x86/mce/amd: Clean up SMCA configuration
  x86/mce/amd: Prep DFR handler before enabling banks
  x86/mce/amd: Simplify DFR handler setup
  x86/mce/amd: Clean up enable_deferred_error_interrupt()
  x86/mce: Unify AMD THR handler with MCA Polling
  x86/mce/amd: Unify AMD DFR handler with MCA Polling
  x86/mce: Skip AMD threshold init if no threshold banks found
  x86/mce/amd: Support SMCA Corrected Error Interrupt
  x86/mce/apei: Handle variable register array size
  EDAC/mce_amd: Add support for FRU Text in MCA

 arch/x86/include/asm/mce.h              |  30 +-
 arch/x86/kernel/cpu/mce/amd.c           | 534 +++++++++++++-----------
 arch/x86/kernel/cpu/mce/apei.c          | 125 ++++--
 arch/x86/kernel/cpu/mce/core.c          | 243 +++++++----
 arch/x86/kernel/cpu/mce/genpool.c       |  20 +-
 arch/x86/kernel/cpu/mce/inject.c        |   5 +-
 arch/x86/kernel/cpu/mce/internal.h      |  11 +-
 drivers/edac/amd64_edac.c               |   2 +-
 drivers/edac/mce_amd.c                  |  70 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   9 +-
 include/trace/events/mce.h              |  47 ++-
 11 files changed, 671 insertions(+), 425 deletions(-)


base-commit: 35f30e2dfdccfba60c413248e03782b8793f92e6
-- 
2.34.1

