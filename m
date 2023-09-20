Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F5D7A7F20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbjITMYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjITMYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:24:17 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C666D93;
        Wed, 20 Sep 2023 05:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oo75ohxZMVnI1eHGIvSaN9ZOWyiWIUY/7itfPHeSHqYmxuN+e3RDMeFlE+on0c0R8bB/Ehk6LrWrzJRBczLCcnESRTBi6eNYkHPs99lzq2tXqo009Ph7XhAcu7n+D8BhOJ0Zzp4OvJrV5geemtZsPotswvibmDxAD06pSHQFInbXo2BzmLnKPi/MS8qFuqLtpi2khNcqfoSRMjtpCUjjqEmoPYdx7f8oJZtOdopxtrE5qii3OyNJT2lZKbPouAvbvO4dAlEzqe0O9zAtRpZb4H1UsCYVMnByypW0UEXeSOOFf9NdszwXRfvcSkIyfBEPsuYplXLvunBZQimFTbX2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sCpGCU3fqgbs5bcyBmaGtePhTvLwP7GlLVCdEJbrug=;
 b=ZedUpx9dqNVAauuxVOTcQ7l9pPtt2+aTyzqa57eOo3aJ7k6gBS35MDoy62RRjENPzmJAH4tEeYoyHg2LVGxlM9qOUBJioEQj6sroYDgxJnVCt00arJDqD2SoMsj4st5mH/tE7IAy5R6TE+lAR64bFTaDCuZoRDhDR0utxF4bETL2438o/eu1vBp/e+2rxKYPZGab71pcUh3s5tj3ZbyROWfdZYWHStwUPccNQljYjFOU0/2UPF1n7a8qQ8IJ3qgG8Hae9eTOjdUg4B2KDyi4gh07hmNvCRBZ2W4fESJ6hlVuMvQ/00UE/tmkrQ89133z38bc9o0DjyDKlAFyEdoyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sCpGCU3fqgbs5bcyBmaGtePhTvLwP7GlLVCdEJbrug=;
 b=Nfl2I5X9jtLJDt8cogqMhButSUO+PiRBCQkjQcYpM0BKE4FD/G0P5NGXSwUcBVBlLMM9NPgFCDlHvnhmBxhXHA6KCWPHb6CnjPHKyg8irUIhGNDPxqzriMoqhtF5b0+B8XqkRTYMkaF4y88PFzvHt+i02VU0Hd+Zb/ejR5Y3nTU=
Received: from MN2PR18CA0006.namprd18.prod.outlook.com (2603:10b6:208:23c::11)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 12:24:08 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::4c) by MN2PR18CA0006.outlook.office365.com
 (2603:10b6:208:23c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 12:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 20 Sep 2023 12:24:08 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 07:24:03 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <irogers@google.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>
CC:     <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ravi.bangoria@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH] perf pmu: Fix perf stat output with correct scale and unit
Date:   Wed, 20 Sep 2023 12:23:49 +0000
Message-ID: <20230920122349.418673-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|BL1PR12MB5173:EE_
X-MS-Office365-Filtering-Correlation-Id: caf992b9-47ef-4aac-38ff-08dbb9d47ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJLxQVma+OrY/wmf6Fr12F4lGLmpnJFBPNNO2CdpZthV3qnmyGkCnsIRJjF+XTLbNqrsJWepSEw4mRfs89IxklMVk9kV0CJIYdf2NyTEZJ0ItJElfpgxY0M/8sAKxYPidYf88tuvXX03q4YtgPNBlPHXbD/ONEPotsWEzvAbrJMC346HDdmAIV5jolgP2Tbywb+k0YkFnp+jN2bQEFHdYS2vvEKmJ6W72AR39cd0FsNDUV9C56vB/5/4fH1GLxJnyDjoqTTIGL8HVX5DKjKxDwGW4F237VUW1mR9wX2i4PRc+c0/i75m5grSOcJOBraJPDzN2Xc2E39/+RJAfX72p3EOrNIZ74D68dnOng+HvbijM9qYCKC5F+FlyY1XY/VDV0h/ROJO4exEleTg+iKKaCsyuWee8HkWgLYdskmjDHspvj63tNUeQEaXjgs+mR8OF/Dx8tCMK3s9tqGbG7zNCh7YhC8wAkt+FKKVEUX4iRjBdEZ770W6RQheY/FcFr+SMTZ54yVEGrR8Zko9IjZKikwFAEICVskqCiP78jayIh/ft7OaaqXnDtQOpCvOOlGDbOqTbfMHQo6d1AujsAZFc03ZgO1ZmyGRkHQhpOveWCkX/eYOaryxre8oi/z0FqWGxF/CS95svfpVpc87b9Y1AWALlrH0lO3jrmyUyp53kcEXV0ZAkpn04hEfb8EKho3y5Z/oebtf4laRgrFNObapW/fTpSBttQ83QuoB6fZQunZuRla9g3yGgb2xZdkGex93HlfMqXCrAwviaGXXpYIkcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(426003)(36860700001)(40460700003)(47076005)(7416002)(2906002)(86362001)(36756003)(82740400003)(40480700001)(316002)(110136005)(54906003)(70206006)(70586007)(41300700001)(8676002)(2616005)(8936002)(4326008)(1076003)(6666004)(356005)(7696005)(81166007)(83380400001)(478600001)(5660300002)(16526019)(26005)(44832011)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 12:24:08.2321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf992b9-47ef-4aac-38ff-08dbb9d47ce7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf_pmu__parse_* functions for the sysfs files of pmu event’s
scale, unit, per-pkg and snapshot were updated in commit 7b723dbb96e8
("perf pmu: Be lazy about loading event info files from sysfs").
However, the paths for these sysfs files were incorrect. This resulted
in perf stat reporting values with wrong scaling and missing units. This
is fixed by correcting the paths for these sysfs files.

Before this fix:

 $sudo perf stat -e power/energy-pkg/ -- sleep 2

 Performance counter stats for 'system wide':

   351,217,188,864      power/energy-pkg/

          2.004127961 seconds time elapsed

After this fix:

 $sudo perf stat -e power/energy-pkg/ -- sleep 2

 Performance counter stats for 'system wide':

             80.58 Joules power/energy-pkg/

 	     2.004009749 seconds time elapsed

Fixes: 7b723dbb96e8 ("perf pmu: Be lazy about loading event info files from sysfs")
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 tools/perf/util/pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0d81c059c91c..93feee29d054 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -295,7 +295,7 @@ static int perf_pmu__parse_scale(struct perf_pmu *pmu, struct perf_pmu_alias *al
 	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
 	if (!len)
 		return 0;
-	scnprintf(path + len, sizeof(path) - len, "%s/%s.scale", pmu->name, alias->name);
+	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.scale", pmu->name, alias->name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
@@ -330,7 +330,7 @@ static int perf_pmu__parse_unit(struct perf_pmu *pmu, struct perf_pmu_alias *ali
 	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
 	if (!len)
 		return 0;
-	scnprintf(path + len, sizeof(path) - len, "%s/%s.unit", pmu->name, alias->name);
+	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.unit", pmu->name, alias->name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
@@ -364,7 +364,7 @@ perf_pmu__parse_per_pkg(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
 	if (!len)
 		return 0;
-	scnprintf(path + len, sizeof(path) - len, "%s/%s.per-pkg", pmu->name, alias->name);
+	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.per-pkg", pmu->name, alias->name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
@@ -385,7 +385,7 @@ static int perf_pmu__parse_snapshot(struct perf_pmu *pmu, struct perf_pmu_alias
 	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
 	if (!len)
 		return 0;
-	scnprintf(path + len, sizeof(path) - len, "%s/%s.snapshot", pmu->name, alias->name);
+	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.snapshot", pmu->name, alias->name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
-- 
2.34.1

