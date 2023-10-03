Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EEA7B6038
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 07:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjJCFIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 01:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjJCFIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 01:08:21 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66D5A9;
        Mon,  2 Oct 2023 22:08:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMOjGpnYYR+RC0s9R2tmflu3g0DbezHa0CBaMSVbOjNwgilDGVdU6z2SuL2TffHkoIGs/DHMfGKtuma2fuf+tVHkBiiK0pcV8++JS4tAc6HBIL/T+YNMHO2FZo+KQEP0SFspuMFl4lL8VU8K/HvArb7O9/aFnmKORCj6QF+ZRzKyQ3KhYHr8BsM4dRB4Fm/cIk6Ff9UTWGZHDRH9aNYFd3AKW+g37P4Kwb5EgHWOnPAcZKNOKQkH0GKo+Lk3BwtPrO0kqe1CZTB60TKhJKwy6oO4kqCYtonHP1mDPgJNeDBFeHmtc1hLzlZuAyjDe36cmSpMpw5aF18sNVM7i5WjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls2njgOD9cfeawnlxD7Qv1Dg6rtvUUrVVuq55rS+C/M=;
 b=GlrNpYBATrrOhFPbIH1o87HODgRnxD7X3nsNsmC8QjOfV3lIDx4LH6bWHj8FmaMY7QPW8EFOSI3cKnH7sbbBQxTeGbKd6FVTLRU3w5SQz+Ahbt/gec+kkvkdFCgT3/7wFDcwWy9xHNHjQDKtRItxppYnkc/5Zmw9Npt0033tHhn/6du+96A/PNkpgeZgLN8AtH152fH+dh1PAX6onvSWcJ8IpJb6kgziuNCSiFu+H4MNi5sWf7AmByjh7h6Zest85URVTpna5IGOvxsxeT658/crxMF4w4sf57QYa9n7+KeTjFcETKazvAT2ofSshw96NsrgDqDd8E+nXfgsyM6VnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls2njgOD9cfeawnlxD7Qv1Dg6rtvUUrVVuq55rS+C/M=;
 b=iRjLPLzvDuJHLikmssbaWtNUwlLBfn6nX8dFq1ceaAhDjD6GrQkZ1dBMgN53DsRB/MyZieZdh6s5s5YQF+UVJ8+feNEzPAXJ8oTWwNK/8VDG2ZtrJu6rnNYuQkhhVJk9mOILtKBhtHeIDSTrVyuUiZpvtlYC/DMlxGNtt2niG4k=
Received: from MW4PR04CA0046.namprd04.prod.outlook.com (2603:10b6:303:6a::21)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 3 Oct
 2023 05:08:13 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::3a) by MW4PR04CA0046.outlook.office365.com
 (2603:10b6:303:6a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34 via Frontend
 Transport; Tue, 3 Oct 2023 05:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 05:08:13 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 00:08:10 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <lenb@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wyes Karny <wyes.karny@amd.com>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH v2] tools/power turbostat: Increase the limit for fd opened
Date:   Tue, 3 Oct 2023 05:07:51 +0000
Message-ID: <20231003050751.525932-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: bca22eee-9ced-4f80-01a7-08dbc3cebec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKV1YD0JCLuts7yGak6p8nO+ncPW+YFMDkHv3INChty2jM5IwNqmURxIhae4JIXu5EiHnmA1gXrY5Cps2/VUFbX6RovwOtIPLZS41Zu/1f06yPyBSWJFKCIpq/bpUKU9nJl+NNWoV/zSPFyXD+zrk+htPyZt+530Q30nOgbeug7Lq9hkReHrRb2gQHc7tuteE9NlpFjzyQVp508iVbE3Z0FaAmYg01B4aQW6JNE7j9kp+ObcPPf3L0hTyjyl4g08k2meabCbMlJfUlMyD0ibRhMKVdyyRQCtZwROv++V/7BghysXeBNkz4f0ONwLL1dNfWvR3UWjJLIhSNnrXtIywB/tEiLyAGhdnoAJlhbMPljYreltWA9Hy/Ep3vTWAsFq/4CaNHAGvCMZWKC2TvaV+Hh2hxWWd0c+lvj4/zbe/7yytoMoOEyOYciv/6pRNK83SZWpaZvsQwnc1LMNEbBO6bFvWHVlCYVxstyYlMYC4vwLOLFhNBW9YqJPN3Q/nz8yGeGabDblsKS/cyyWOPe+DJ1lJc4uCz4qh/uWAf8ADlWe3lpmmlCDzrxWVDxiDkIb9FTC6YM867J2GRlpr1OuO9GIjWAQgjuxFMKaAnBESwyIFNnHkRpB3+52X/x/4MnF1/GR1B6w0SqaZCQ8S1c4pQTLyFqiJdrFjGuwHEd0wOZVvNqsTLlTwc5TKQeSRA2R4gEIVWJFd8kWQlw9NNyEuUEX0qM++ZTP1ukraJU3+73FrE63XxuhaZjDXx2XcBVQoF1/L8Q2o28XFgFxQaGYCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(40470700004)(46966006)(36840700001)(83380400001)(7696005)(2616005)(47076005)(6666004)(36756003)(40140700001)(356005)(478600001)(36860700001)(40480700001)(86362001)(82740400003)(40460700003)(426003)(16526019)(6916009)(41300700001)(26005)(2906002)(8936002)(8676002)(70206006)(1076003)(5660300002)(336012)(4326008)(54906003)(81166007)(70586007)(44832011)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 05:08:13.3108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca22eee-9ced-4f80-01a7-08dbc3cebec8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running turbostat, a system with 512 cpus reaches the limit for
maximum number of file descriptors that can be opened. To solve this
problem, the limit is raised to 2^15, which is a large enough number.

Below data is collected from AMD server systems while running turbostat:

|-----------+-------------------------------|
| # of cpus | # of opened fds for turbostat |
|-----------+-------------------------------|
| 128       | 260                           |
|-----------+-------------------------------|
| 192       | 388                           |
|-----------+-------------------------------|
| 512       | 1028                          |
|-----------+-------------------------------|

So, the new max limit would be sufficient up to 2^14 cpus (but this
also depends on how many counters are enabled).

Reviewed-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
v1 -> v2:
- Take care of already higher rlim_max, rlim_curr
- Minor tweak in commit text

 tools/power/x86/turbostat/turbostat.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9a10512e3407..1563a0ae7e4c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -53,6 +53,8 @@
 #define	NAME_BYTES 20
 #define PATH_BYTES 128
 
+#define MAX_NOFILE 0x8000
+
 enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
 enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC };
 enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT };
@@ -6717,6 +6719,22 @@ void cmdline(int argc, char **argv)
 	}
 }
 
+void set_rlimit(void)
+{
+	struct rlimit limit;
+
+	if (getrlimit(RLIMIT_NOFILE, &limit) < 0)
+		err(1, "Failed to get rlimit");
+
+	if (limit.rlim_max < MAX_NOFILE)
+		limit.rlim_max = MAX_NOFILE;
+	if (limit.rlim_cur < MAX_NOFILE)
+		limit.rlim_cur = MAX_NOFILE;
+
+	if (setrlimit(RLIMIT_NOFILE, &limit) < 0)
+		err(1, "Failed to set rlimit");
+}
+
 int main(int argc, char **argv)
 {
 	outf = stderr;
@@ -6729,6 +6747,9 @@ int main(int argc, char **argv)
 
 	probe_sysfs();
 
+	if (!getuid())
+		set_rlimit();
+
 	turbostat_init();
 
 	msr_sum_record();
-- 
2.34.1

