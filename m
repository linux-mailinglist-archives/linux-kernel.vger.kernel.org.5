Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5756B7DF58F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbjKBPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjKBPBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:01:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19A0138;
        Thu,  2 Nov 2023 08:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BftJCjIWJkQL7RG7FS3xGzAACBIMMZ2OmOHU7Tt9iv1WjHmko08lDLSqQhy5XNFeXSo6KJiCfn+cZJrJ8gZcI3ARfiLNIdjGlV9rib3JSEPzazHd1yYHSpzGVgLP5oe3ovs7QV43AKFZxH0Kdn0H0KQQKpzt9aQqPa1nrc8+1IDkbD+Tk4Y0zIrfagvNIxuc+jS28udB128v4s/SRgswZr+5W7chNohMW3EJ4FY/04dYdcrMRHusjQ7zFgH8eX8o3VL+qfuC7CAj2nPJYrzZK9RnIhH+JX7erqUR/vmtJz39014SzrHvdPj2ebr1VsBksD0oznvBzRgtCWAGCGd4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5miL9hnVSQfh+RYw7Plin0/9UfHhWP3kbV5XeMqCaxQ=;
 b=QNMUGS96vhQg2zn4njTcYGy7c7koVvbORx1ZRr+g82gTQN+hhmwFhxPiTd4qsGdoR9PFQn7KICHidgQgj6AEOxVJ0ffRA4xG+LSCMG7dGweGdxH+BVnrTAbTMGqvLZYF0py0sl7o04L6JA7J6+3I1gQmEukawsU8LG+xzTkKQibyVyg7LZ+1bZUBL1pKKH5+8kYB+qkHk3Qmw6SqBZ1HIHtrzoqfl2rELyxjUN34tzoqiYR7GvRkhitZZqbQrBR8w//ehhNpPXi63DCv5fs9w+2rZyEcBIhW3tXhEgnlmXhJGKzTdBWG4B1z7yWAwPhQSOIHqJzoNo/svcHtXlAwxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5miL9hnVSQfh+RYw7Plin0/9UfHhWP3kbV5XeMqCaxQ=;
 b=F04G6zdC/SIOdcVuE2UeHQNiQBud859F4HCrQY1aCyFWeNjWlzkC4XoyGeMn2U6sZD4QDU4M20FLqbwdulTQvbEcUU7wxnwyx931CzeWR5l6c/7SqVmInR1sYrZW6UsoUToveNKyHLTTGoLbHhA2+zmCr6hhTOtlp/B/MzQ1uBc=
Received: from BL1PR13CA0131.namprd13.prod.outlook.com (2603:10b6:208:2bb::16)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Thu, 2 Nov
 2023 15:01:34 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::eb) by BL1PR13CA0131.outlook.office365.com
 (2603:10b6:208:2bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10 via Frontend
 Transport; Thu, 2 Nov 2023 15:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.21 via Frontend Transport; Thu, 2 Nov 2023 15:01:33 +0000
Received: from BLR-5CG13462PL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 10:01:30 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <lenb@kernel.org>
CC:     Wyes Karny <wyes.karny@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>, <rafael@kernel.org>
Subject: Re: [PATCH v2] tools/power turbostat: Increase the limit for fd opened
Date:   Thu, 2 Nov 2023 20:31:20 +0530
Message-ID: <20231102145915.35yrzu3q72737gez@BLR-5CG13462PL.amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003050751.525932-1-wyes.karny@amd.com>
References: <20231003050751.525932-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c91aff-51e1-4c41-104a-08dbdbb49aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jX2mw0u3PG/2KOf6qQy0VrGifNNpINcMMKyWeQt8f0MJoEJqQTalQ4jzOiA1Zpf5A/VsWyhGwUivPxV09pJEH8VamlXJSj+U9RSuY5KicmbcvSC4G2uGZzco1aKBi8b5k340kOiDi4WNtQuAKL1gQGwNaAyn7mlV6fiuKFHns7y1afzIC5qn5FllOuuJatdFG1OhN33GM9bE1Oj34Qi2A61ZYvsUkXL23R5KmAaAmwZZzgorYlea038YwgFtj+CHxUgMv00poMmd+VcIs5ztwkd8OajdLEcaNRkwcCC/1ZrVHW+P0h65c/ovSK/kSjhY54zGGW/5vPWKy1dL4qz0WSX52vN6vMhqsZ4e4b58SFg8iZM65pSxMth+iI/w5yDDjvUYaSJOKsz1W6g5yvOBF2k2tS55x+QPkLrYkiU94Mc5fJP+LjK7NmkgqkUKi3zIDXN/CYNgH/AtmjZIgSsL/b4zpAvF71/FMJmbgEKu0IfVJQIo5nUKMH+yktDJeF84LJAM6ljHUVCztO5wf5iBqh3CO6+cFAltj1nE/JYX0IA8k3QeNx3qh7q5HNRqDKr5+DE5sJPY9N6BT6vcSj4/L/p1uRmflaTujfi/UoWZ6jGzg4kzOuIOEqnYNyv4m4Y+QgHRYHN0HvIJGUu1fa3Q+ZuTJWUeWB42YFJLWaT2spW/ookOl0vnroG648YZKeRL/DUWKTNb+RXFZcbME75YAi2Dy3GOvVs0TPskZW+VvtYveaKNrGfcDWX2BGotl4ehBjfp5Ns6Caf/U4F3n9+qSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(356005)(81166007)(83380400001)(36860700001)(426003)(26005)(40140700001)(336012)(55016003)(7696005)(1076003)(82740400003)(16526019)(86362001)(47076005)(70206006)(40480700001)(70586007)(44832011)(4326008)(40460700003)(8936002)(8676002)(5660300002)(41300700001)(6666004)(2906002)(54906003)(316002)(478600001)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:01:33.5909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c91aff-51e1-4c41-104a-08dbdbb49aa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009
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

Gentle ping.

Thanks,
Wyes

On 03 Oct 05:07, Wyes Karny wrote:
> When running turbostat, a system with 512 cpus reaches the limit for
> maximum number of file descriptors that can be opened. To solve this
> problem, the limit is raised to 2^15, which is a large enough number.
> 
> Below data is collected from AMD server systems while running turbostat:
> 
> |-----------+-------------------------------|
> | # of cpus | # of opened fds for turbostat |
> |-----------+-------------------------------|
> | 128       | 260                           |
> |-----------+-------------------------------|
> | 192       | 388                           |
> |-----------+-------------------------------|
> | 512       | 1028                          |
> |-----------+-------------------------------|
> 
> So, the new max limit would be sufficient up to 2^14 cpus (but this
> also depends on how many counters are enabled).
> 
> Reviewed-by: Doug Smythies <dsmythies@telus.net>
> Tested-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
> v1 -> v2:
> - Take care of already higher rlim_max, rlim_curr
> - Minor tweak in commit text
> 
>  tools/power/x86/turbostat/turbostat.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 9a10512e3407..1563a0ae7e4c 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -53,6 +53,8 @@
>  #define	NAME_BYTES 20
>  #define PATH_BYTES 128
>  
> +#define MAX_NOFILE 0x8000
> +
>  enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
>  enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC };
>  enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT };
> @@ -6717,6 +6719,22 @@ void cmdline(int argc, char **argv)
>  	}
>  }
>  
> +void set_rlimit(void)
> +{
> +	struct rlimit limit;
> +
> +	if (getrlimit(RLIMIT_NOFILE, &limit) < 0)
> +		err(1, "Failed to get rlimit");
> +
> +	if (limit.rlim_max < MAX_NOFILE)
> +		limit.rlim_max = MAX_NOFILE;
> +	if (limit.rlim_cur < MAX_NOFILE)
> +		limit.rlim_cur = MAX_NOFILE;
> +
> +	if (setrlimit(RLIMIT_NOFILE, &limit) < 0)
> +		err(1, "Failed to set rlimit");
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	outf = stderr;
> @@ -6729,6 +6747,9 @@ int main(int argc, char **argv)
>  
>  	probe_sysfs();
>  
> +	if (!getuid())
> +		set_rlimit();
> +
>  	turbostat_init();
>  
>  	msr_sum_record();
> -- 
> 2.34.1
> 
