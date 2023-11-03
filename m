Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A657DFE31
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 04:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjKCDA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 23:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKCDAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 23:00:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5662F1A1;
        Thu,  2 Nov 2023 20:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFUMHqpZ4tmWTyny4jHx3Z72E8jq0YcI7UDQBGFZ5GDt/PPmPVRYMEb3TmnA4g+WlsW/d+DrupqJM+RAiMpuGwV5dC3V1pkTd6yQA2/pYLsrEHWGwUFXbClwhZ+DVGr1fVcARsCU6F3++AQlTu9eE+HCjAxaC2r8D3mP2OjGzuBO8NUUoQ6UNNouE806okfi5YhhQD+SIfCLOFo2jVcZ87QrxLXxiP+1pO8OCc/03QdN1eXMhp41DJx68AHjX6nx+v528sc1vt8u/CFI9M5hsLnkP2ECbbzyKsnxybjSA/7S4XHEngDEt2FdL69d9J8Ne8oxmK6QW29mR9snaM6NnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nvC8xVdyWlD9+6+K9LzbLoEZzVFxWPObDtxhqEhns8=;
 b=kCsAJCRSymPBU6pfaz4Pb3bpqCzVA27wu00RspIjl9tlPn2L66N3umsuWqqNhYd0NFp3R1V2qxDfbqpA/gqCXO/JMft/eL4tiOw3j8zQK0sJ6iDcfBSC9ihgoXyzG7VgZueNQspDQsZKuTIGaWJ5/N1dp3UI3WA1jJLp/CBpp99z6MmaKvf23G9eF+dIjl5fjLBFWt5ZjPoYlTQoX3sU1G1s1tjiTR/zZ3wrnH5UFr8auE0XCrw0PO9YefddLwYjdkrsZyDRMzz5/9JyvZdq32W3/RYSG7WBM4IV8LJ0mDJuidyniXjsczUHeqRtNP9EIoTrure8seKUpBQ4zrmV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nvC8xVdyWlD9+6+K9LzbLoEZzVFxWPObDtxhqEhns8=;
 b=U+ez/QQxkbCfNkXMcnBnxU4IwGFX4cN/VWrEl56A4a0gC2zQhFgi6erKYX9/7bJZLj36oVmVIUCR7ELODEo4VHf0BK58z560G/1x3SGjS6IbAOcGU5tiXqCd3S5bRarUqtHi19pTIl4K3yIZCWBSzl9tD2wq4/J72jyzwZxv6lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 03:00:44 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::87d4:680b:51ef:181]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::87d4:680b:51ef:181%7]) with mapi id 15.20.6933.029; Fri, 3 Nov 2023
 03:00:44 +0000
Date:   Fri, 3 Nov 2023 11:00:23 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix scaling_min_freq and
 scaling_max_freq update
Message-ID: <ZURiR+y05DVnSmV8@amd.com>
References: <20230922061229.475966-1-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922061229.475966-1-wyes.karny@amd.com>
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f255c25-11af-43ea-b36d-08dbdc1911f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTebYR1W5DG+uMS94Q1o0kj5cv7zjnxOUVILkVZ2zL1xpb9Ds9n8szpgFuI9DVp2WX2RdxI29LqYdzrj027ZZu1fFUFldjsQImUeksVUGpnmhhhjzyii5BLBKsXaRGbNA2TY0YYZqe8ET5XNlhnJMRZuIFOQZrpaMVgK4QQfNgr0jcfNxO9ZTmpT08u0CQjAwhV3NEO/byWxgyVamB76Nw2AacebyFnu6ZXR7KEI1ry5jf3CoQcxzW+4mC2fMHJkY2gQEG3ghLV+satTdDAaTKxoG6pR2LnPwpv5MO8BYfC+RAPCtzAKH7RvBQKF1nkg5EGsZAhkraSgORs1E0NY18sCK55+7iuPr3QHAr5XP1vA2/TlXBjRTVBUTEYABubS16A8FqIepDaHn1MFtNHtMiEe6rhb88ApxNOIGtxXPCPr1fmijr7QWu2Y9tV4H7OZFY9hjRkQ33kNlmxuSyuc6dc2i0QL4Y8btl+O3kLjQgqoMxwd8n9f6NeMcs77CECatN9+y7ZMMiQzaaE7KiqaLMEWxmoKL1Vw4cv1GXHJzJBT3TR0hvtYwrl1k/tRAjiRm5MM8iIzVSKALdekEpug5Qr5t+r3KlHt7qurxWAUdiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6506007)(26005)(38100700002)(5660300002)(37006003)(66476007)(66946007)(316002)(66556008)(54906003)(6636002)(4326008)(8676002)(8936002)(6666004)(6862004)(41300700001)(15650500001)(2906002)(2616005)(478600001)(6486002)(6512007)(86362001)(36756003)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nh5HyWt6LNypU5fyh36crwocwBt7YrnlEM7WTqoSQgysqvEH+zNn93H6PqIh?=
 =?us-ascii?Q?+il/M3deXpx6ox00qPB1/MCspoY/6R57GtXQyaWJ2T6Ti8iAjOSUJYgp2vsU?=
 =?us-ascii?Q?Ucd2pi8Oz1cgTLgMEDmZMyqEcHvwsJVUAMjw23EZbnkMwTD2oZGd8a47IGRK?=
 =?us-ascii?Q?KRm/FKKahg39DEoDyhtGem7F7pjOcWU5lTAtVWVxaMzDakUL2eOicK1wMuCL?=
 =?us-ascii?Q?RF/rKS6SQtZS/fsU6o65CHpq86YfA2oI7cih0vkI9lGaDe3IYmt+Xt0pPjpl?=
 =?us-ascii?Q?0p2Qw4bhZKGFN1FKU7AZG7Y7u8lnDR2Gd7Q8DBFFakvwhORxkUTMSHeHAbfv?=
 =?us-ascii?Q?EZcOaKA4Dqf2DPG1BKELM2rTfYNU26Sxib/glIkITJKSUguZEG0rkEF6UrJv?=
 =?us-ascii?Q?zhhEwHvGmwUvul9ti3hdy7ifbIKixaUcXuniAju2xGQ9iJDzQpwDDTH3VNgF?=
 =?us-ascii?Q?XvxyyoA9HRsVzplnnaEMD5bt5l5nYiXS/et4tcHTjtTXIv9dUlOXVNjF9Yg4?=
 =?us-ascii?Q?UTBBeTZh3/dC8brH/HWRotURIBIfW3LCfjB7LQXwp1ovVnGtRy/vbBWcAUYb?=
 =?us-ascii?Q?hGtxylDut4bIutX5T+W9I0/LZF2fOHiFC3q3ZOG8NuP5PSOA4HpfNsQYmync?=
 =?us-ascii?Q?btBmoK042xJ8DZln9in1pGFOFEsjGVoZrluWOezl7le2t/kRFdqM0axVrHSi?=
 =?us-ascii?Q?4fyGMD5hR4lgV4xB8RVvvVNEgl5rsUF9diR9/Ud9wXHH67ecq2ln5a9PPRWo?=
 =?us-ascii?Q?CJQyC9qL/2mVJo/FXJOUC3JCaoMSwvLJd3AXJgZ8nzUa9G5mZVijF7x2Na8h?=
 =?us-ascii?Q?uLQIxvwWGmeDyh3LCOgwlrAh+zvR8HwxeDQFLhpMVAlF2vY0DIRxaIbpR1Qn?=
 =?us-ascii?Q?+jx82s3mjrSmSkzbK3z7vSmqIThwJTnhjlPsAXr/yiT2NtePQgY+rRu8rPva?=
 =?us-ascii?Q?M/htFJ4MiGNZ2e9zAH7hEr2DxlhBBewNAq89zh99Qn6pasLSIOrppK1gS4Ni?=
 =?us-ascii?Q?SJUq9wIZ6xctZwI34tHaRsJTkDX8cPO31pPRbginfAjWRg2XYSqD5QQteXeK?=
 =?us-ascii?Q?PqbW01l5E2CwjfUJJwmfjl8BhxTxBXnqG4MdCWov2RnHg+9OfkWCq/a4pgqL?=
 =?us-ascii?Q?iwdlZqBqlI+BVl4jy78C0mqGx55l9Z7qXGNWkKKvPrKAGGL3hvzbSfCrA4Do?=
 =?us-ascii?Q?cD1RqZI4eg7H7K+rGosImvz4nyEl36pifKkFt7Yj/l6ie8w7g1+I1Jq2SJ+j?=
 =?us-ascii?Q?QOJbiexmY6Y1TXa3cNBxoc+BVtuc9zn4EsFxzfbu2hyJThAp0YPauPgt1f8B?=
 =?us-ascii?Q?Wl9aHSJHlvZtiIHgpwQkp9EHOUal3+Y2z6ISuYxAZotW72dUfH89UsGyUnRk?=
 =?us-ascii?Q?l+mKNQZdOByZpIxNKlZfOel3YpgymbHMrsDJODlMN2Z3QMnzU7D3mMRyBedp?=
 =?us-ascii?Q?/bGlxKcdChefFmBUkN6Gk6OfKYHqUIxcpIh1tgKxdCGSHHuRj9RvBsfyMWib?=
 =?us-ascii?Q?cP1lrEpoVHtbfqMTliedcNk38Xb569OgDCbeqb25KJEaToKg+1h+jjW6Zjmm?=
 =?us-ascii?Q?7PVpwmaq6nvkKA5XnQvyZjCcWot/AllX9LSo0Xnk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f255c25-11af-43ea-b36d-08dbdc1911f6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 03:00:43.8730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: js2ioK3HVV92WoqxCTbLEpi/9MupSVDBiMKRE5JjYAVH7LvRMpwMV+B+6WVIrkT1F5l8eLmpo6fb167WSgP9Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 02:12:29PM +0800, Wyes Karny wrote:
> When amd_pstate is running, writing to scaling_min_freq and
> scaling_max_freq has no effect. These values are only passed to the
> policy level, but not to the platform level. This means that the
> platform does not know about the frequency limits set by the user. To
> fix this, update the min_perf and max_perf values at the platform level
> whenever the user changes the scaling_min_freq and scaling_max_freq
> values.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 60 ++++++++++++++++++++++++++++--------
>  include/linux/amd-pstate.h   |  4 +++
>  2 files changed, 51 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..4839cdd2715e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -307,11 +307,11 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>  		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
>  
>  	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> -
> +	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
>  	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
>  	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
> -
> +	WRITE_ONCE(cpudata->min_limit_perf, AMD_CPPC_LOWEST_PERF(cap1));
>  	return 0;
>  }
>  
> @@ -329,11 +329,12 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>  		highest_perf = cppc_perf.highest_perf;
>  
>  	WRITE_ONCE(cpudata->highest_perf, highest_perf);
> -
> +	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
>  	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>  	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
>  		   cppc_perf.lowest_nonlinear_perf);
>  	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> +	WRITE_ONCE(cpudata->min_limit_perf, cppc_perf.lowest_perf);
>  
>  	if (cppc_state == AMD_PSTATE_ACTIVE)
>  		return 0;
> @@ -432,6 +433,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>  	u64 value = prev;
>  
> +	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
> +			cpudata->max_limit_perf);
> +	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
> +			cpudata->max_limit_perf);
>  	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>  
>  	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
> @@ -470,6 +475,22 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
>  	return 0;
>  }
>  
> +static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
> +{
> +	u32 max_limit_perf, min_limit_perf;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
> +	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
> +
> +	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
> +	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
> +	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
> +	WRITE_ONCE(cpudata->min_limit_freq, policy->min);
> +
> +	return 0;
> +}
> +
>  static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>  				  unsigned int target_freq, bool fast_switch)
>  {
> @@ -480,6 +501,9 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>  	if (!cpudata->max_freq)
>  		return -ENODEV;
>  
> +	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
> +		amd_pstate_update_min_max_limit(policy);
> +
>  	cap_perf = READ_ONCE(cpudata->highest_perf);
>  	min_perf = READ_ONCE(cpudata->lowest_perf);
>  	max_perf = cap_perf;
> @@ -532,6 +556,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	unsigned int target_freq;
>  
> +	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
> +		amd_pstate_update_min_max_limit(policy);
> +
> +
>  	cap_perf = READ_ONCE(cpudata->highest_perf);
>  	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
>  	max_freq = READ_ONCE(cpudata->max_freq);
> @@ -745,6 +773,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	/* Initial processor data capability frequencies */
>  	cpudata->max_freq = max_freq;
>  	cpudata->min_freq = min_freq;
> +	cpudata->max_limit_freq = max_freq;
> +	cpudata->min_limit_freq = min_freq;
>  	cpudata->nominal_freq = nominal_freq;
>  	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
>  
> @@ -1183,16 +1213,25 @@ static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static void amd_pstate_epp_init(unsigned int cpu)
> +static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  {
> -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u32 max_perf, min_perf;
> +	u32 max_perf, min_perf, min_limit_perf, max_limit_perf;
>  	u64 value;
>  	s16 epp;
>  
>  	max_perf = READ_ONCE(cpudata->highest_perf);
>  	min_perf = READ_ONCE(cpudata->lowest_perf);
> +	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
> +	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
> +
> +	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
> +			cpudata->max_limit_perf);
> +	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
> +			cpudata->max_limit_perf);
> +
> +	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
> +	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
>  
>  	value = READ_ONCE(cpudata->cppc_req_cached);
>  
> @@ -1210,9 +1249,6 @@ static void amd_pstate_epp_init(unsigned int cpu)
>  	value &= ~AMD_CPPC_DES_PERF(~0L);
>  	value |= AMD_CPPC_DES_PERF(0);
>  
> -	if (cpudata->epp_policy == cpudata->policy)
> -		goto skip_epp;
> -
>  	cpudata->epp_policy = cpudata->policy;
>  
>  	/* Get BIOS pre-defined epp value */
> @@ -1222,7 +1258,7 @@ static void amd_pstate_epp_init(unsigned int cpu)
>  		 * This return value can only be negative for shared_memory
>  		 * systems where EPP register read/write not supported.
>  		 */
> -		goto skip_epp;
> +		return;
>  	}
>  
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> @@ -1236,8 +1272,6 @@ static void amd_pstate_epp_init(unsigned int cpu)
>  
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  	amd_pstate_set_epp(cpudata, epp);
> -skip_epp:
> -	cpufreq_cpu_put(policy);
>  }
>  
>  static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
> @@ -1252,7 +1286,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  
>  	cpudata->policy = policy->policy;
>  
> -	amd_pstate_epp_init(policy->cpu);
> +	amd_pstate_epp_update_limit(policy);
>  
>  	return 0;
>  }
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 446394f84606..6ad02ad9c7b4 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -70,6 +70,10 @@ struct amd_cpudata {
>  	u32	nominal_perf;
>  	u32	lowest_nonlinear_perf;
>  	u32	lowest_perf;
> +	u32     min_limit_perf;
> +	u32     max_limit_perf;
> +	u32     min_limit_freq;
> +	u32     max_limit_freq;
>  
>  	u32	max_freq;
>  	u32	min_freq;
> -- 
> 2.34.1
> 
