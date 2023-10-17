Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DFA7CC73B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344285AbjJQPPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbjJQPPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:15:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565F09F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU+GV+QK15kpud94Sc+gVJlBb3JQ93JwoAgPQ4eicWVcjeHnTH8IdruN84Fzri7gSkGvT1s0quoQg0Lu4zOcn1q+GWgY9MNYZnbDPu66UhJIZtXmqzUefqH9cdVGu6oywbnS9G/ITvICVUs9UjFh0HnDR4XMwouL8ooX7aX11DHreMpzCc4GGuDCvaw+6cWNVF6Kkd6CsUu7XmXG52DSiOhOeyvNjGQ8PRnJ7TEM0Ay7BHlKDMVKIE4K9ns82AtZ43RhGV3kF1UgeWaS9a+T6taoTAJdjuB+XrDJIxmZsYoX8+8tt+IYyM3qRUAIfneV09HQEbc5pjqqS7gtaPnjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrOShaHwuut1dlGCwnZaKRJQJvCdtw90qfOulpybYx8=;
 b=BX+n79TtoMwnUup4ys2Zd1tCKMquckRMF6Yw9sQ7UTNrw30n9YBX4WVKsrs1SHjKwKa1Aqef6dKXDEKq+0HYE6u64/9SFsRSKwdQMtBBRAJx82ImqYvNrLRwgfAMx6t/mhxdB9OlTFG28t7FzNV6Uu44/YcL/uiyClW2hPC9PyrtxN1Z5Sm57Z17QIjeGdCW+27gDxpkL+IxBaKvocWTEeC+HYjHUyjMC5Gz5f4bciNtnoi1ueFz17JIMsFYtGMIM9k/Al+9YvoZBIAG6qe27OZFyW65f3agNBKfdxOrcqPnVNZihtngQ8NX27DGrAbkj9smAWlEBWjt6/Vcu+P13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrOShaHwuut1dlGCwnZaKRJQJvCdtw90qfOulpybYx8=;
 b=G7wgBXjsACq4IjptnF4AMiIoF+5j/9brgZmiYvPT1p5UxnqYZeens4e4NVbkg0QNZlc/vNsOnW+7dJTx9Lycm5jfZZfDOnh+FS94fvz7VdrhcaYO61oYaB96pkwIHCAJ2Ry9GPh8Cdma9AgJPzfYGgKizD18njQOKUDlNM9t7o4=
Received: from CH0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:610:b3::15)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 17 Oct
 2023 15:15:44 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::33) by CH0PR03CA0040.outlook.office365.com
 (2603:10b6:610:b3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 15:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 15:15:43 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 10:15:43 -0500
From:   Luben Tuikov <luben.tuikov@amd.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/sched: Add description of parameters in job_done
Date:   Tue, 17 Oct 2023 11:15:21 -0400
Message-ID: <20231017151521.12388-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-check-string-leak: v1.1
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ff6dae-2120-4949-cb63-08dbcf23eec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YU9Q0TQnEoPsx/KE99Yfd50A/xdaAFtDbF7b959zBdDoGbdh2e5hPZyMeTkS6sZCO8gsfnlbW38GWRR9+98nyNPyfX7dA/l3mC8qqYM6kYlfxOgoDdNUwx6BYGKnDWwuIMmVS7+h6S0rOhhhzYeRe/G7igzIaNYamWIudxeMMDGVwk/dqFEjQTmIWcQAraAoS5EF+ES8J1MNgeh5NaY6jHouC/CAiqJNZqZDV72K0X6xsCUKpeoTKbILPUtrkiEBmHjyFlwGysMmolAT7JHroi+jkHVME9NM8rJghQQ6fLmyNLNkulPFzNiTeG2FsOxfPbvU2xXk1hgioazSHAlYK556TqKZynKYfr1d5muqlQh9RD/S2g26TAx4/LcL4C9ajkso0u1lxMV84xpLN41O7nDk+NVQOVTMN1SoQ4PTu74BAY6FX8AlQOc91yj3jSVSMP0fjp+0uBv/3z0ZUlE++deEPDPhsvSHyejONKDmSN1LRqsmsx9pAG4gvMbsXUqvg3n25EGuSFzk90/pIqt8aS6f3W1wh8sUR4dvkX+8GRcGWupftFFY4mcntiTQU+j15Q4bgjSW9wDAf7Dj3lRU1Z0+Y6QEzbhEbFW3aSfqxgMYELzoRmLe915tuRuegr1J5ZgYj2KMChtwmFEMC4snIzvU4iBco8sxlyxB9FGDRlb6wIkSjh4qqDG/djASuDEIWqMFmgxEQrPp6jlCfSdpNTlzop/+ge9SEGIeEbtevXb19ZTHkPH36B+9t07DBMachiwAE0MHf60rL3+OdnUCnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(47076005)(7696005)(83380400001)(36860700001)(26005)(16526019)(40460700003)(8936002)(336012)(2616005)(426003)(81166007)(40480700001)(2906002)(86362001)(44832011)(41300700001)(4326008)(36756003)(6666004)(70206006)(54906003)(5660300002)(316002)(70586007)(6916009)(966005)(1076003)(356005)(8676002)(82740400003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 15:15:43.9152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ff6dae-2120-4949-cb63-08dbcf23eec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a kernel test robot complaint that there's no description of the "result"
parameter to drm_sched_job_done() function.

Cc: Christian König <christian.koenig@amd.com>
Fixes: 539f9ee4b52a8b ("drm/scheduler: properly forward fence errors")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310172018.eaPyawVC-lkp@intel.com/
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 5a3a622fc672f3..6f2cf72e79b15e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -259,6 +259,7 @@ drm_sched_rq_select_entity_fifo(struct drm_sched_rq *rq)
 /**
  * drm_sched_job_done - complete a job
  * @s_job: pointer to the job which is done
+ * @result: The result of the finished scheduler fence.
  *
  * Finish the job's fence and wake up the worker thread.
  */

base-commit: 213f891525c222e8ed145ce1ce7ae1f47921cb9c
-- 
2.42.0

