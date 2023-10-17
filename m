Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FFB7CB9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjJQFCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQFCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:02:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EFA8F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt7yMFI/Ln/0ZnDQ68a1JPJaLd9xS5iHPdvARN6QZLzfi2DW5W14n4xrTBcL95MCmK4c1wT1twPes7/Ab+0K+uAvEkMummSgo28IrYNYrFhraMiGfc8+OZ+mWTpVytOvgyCOcKYPYCGrFH8TyTJ4QsQ50Pt+FF7TeFVAVuYgtFKD9OQ5La7POvO2WNoK5uKfB5HchA5m6GIL3rAf6D4Z8I7QCENhiqukONfHJk7NnXDhy/B/qs4WuLmeOrjZiU3AUZz4arx5mTXeqrMRZ9gWAgeIWLenMRD33lNUA9oC8U+6WDiZAOTdL0GhQiPM9JQyL+w5eVoXbQZksPm8QLSXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVBXoJocy0T9UusRi3lR/wuTt3xpFvV/q0qu5bbzFNA=;
 b=e5zLBrMtfUjeLhUfMP/wcvSjROMBVtJVY01ks6n+HpoozWLaRm5atENcY04XHdtQk/0yw2EDFkGypSHIMUXLQ3jVJla5YLepYh3jwAHVAMX9lR/2XlX6NKPoqAj7vYO1DPazApf2Go3QKCEVNJc4Pu6OU3r42YnFJDztm93uoY8WfjaJDaCpinrz0G2Vvs+unftCujx8bkFWHurBcWtGydE8oh6jk81xkjWFtNVYt8u52YGxSekoKLP2jeGjcdTZ+pnnQLuHStS6tGli5s21nA3gZqh6gPWLz0LNW7UOn2LsRi+gETBh1tV2sQiTvzgihfSNDkUo7NtQS3Q9+yittg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVBXoJocy0T9UusRi3lR/wuTt3xpFvV/q0qu5bbzFNA=;
 b=dGZvTXpDkWi/kn0Q0Zat0sOpD+dYfu295tBWzQoAdGQtniZqa0kzKGqnBe+Ck+Sezt4+Ib0EIFVi4+/t70f1nEwirp04iwDmGqJg5T5V0TrdE1u26zzU7CscJT4UqKSUAxhzJCyQ1StPnOfUghJBx1+/S8DGsL1iSpdnY+ALZhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 05:02:42 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6387:21f3:cc48:77a2]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6387:21f3:cc48:77a2%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 05:02:42 +0000
Date:   Tue, 17 Oct 2023 10:32:29 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        bsegall@google.com, bristot@redhat.com, prime.zeng@huawei.com,
        yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
        ego@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxarm@huawei.com, 21cnbao@gmail.com, kprateek.nayak@amd.com,
        wuyun.abel@bytedance.com
Subject: Re: [PATCH v10 2/3] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <ZS4VZdT9IADAjWyD@BLR-5CG11610CF.amd.com>
References: <20231012121707.51368-1-yangyicong@huawei.com>
 <20231012121707.51368-3-yangyicong@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012121707.51368-3-yangyicong@huawei.com>
X-ClientProxiedBy: PN3PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::19) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: d56ff89b-fc4b-44e6-52b3-08dbcece4b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MqnhyUA7k2EYFOehO043qINPkWiCMyHzMmTJNXnFXBrlvFaeKSBvXGdxb0MQ836MNq3es0f+LgifhuMypDlrmN0eP811hqxa/d7alzjj9VM4F8Es62LNK9QcMz6iF8TRuT3aCzIaybm48hgbXCuWcrgFru9feGfMFKmnlQEdQCTZgJs/eDEt6VqKhX1B1UMckTfTL5kRCSPgxuuC/UMrF92e1wEdkifviBUSuQFG54z12W4ys9e9UkUM+e0SCOqS700Dd8tQA1wqoLjZD0c1k94gIsICmG7G2V/TqBat4G8SgF75KlPnBN0CFvTeCrDUevcB8QsbsniAsVqb4mBIZ4taeiqH/QC8FJjZlakn9i7rjxER+TIsW9tHcKGKpgxb9BWUPIa3wTrJm3BAAHJ4eVXhdMwyJmaLOkERHd0pWIAeNusKdcbnI2wxqNnJ6pS+XTZpqph3BcKK3UbRQme1rlucyy0FJbmekcnNRCZdVahuYRvInLRmpoO25ylSLyr3MDdEm+HYi94y9gQcAiFL4hMVUlcy+vOwUwuLWn/CT7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6506007)(5660300002)(6666004)(2906002)(26005)(83380400001)(38100700002)(86362001)(6512007)(7416002)(478600001)(6486002)(41300700001)(6916009)(316002)(66556008)(66476007)(66946007)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bd/R8Qqbw/Dgg+NR3LTf9v/JwIMveZ7KciRrW7lTcdvsAbn6k+YN08dS0Dxh?=
 =?us-ascii?Q?Bc9ug2MgvOce0vTbqKVt8AlrF3q3xmUSRVNP7JbWtm3BRCNulej33p4yYmN+?=
 =?us-ascii?Q?Snjd7l3nkaoSvizG3PaYHTFhOOrU2qjW7bSNwoHwAv32zvRJg+WCL6gxNqvn?=
 =?us-ascii?Q?2jlTCcZ38oFE3hxdzlSe9mdNkM95ZBgXYfnU/D6gaRHovqSPM8Un9S1DHfUg?=
 =?us-ascii?Q?PXbGnGAuJ3nfEmhaUle/1NGyVYtmZv3rW978lY9yzgvtF6H5LrI4bJczqT/n?=
 =?us-ascii?Q?2QCi5zqpWVq2HBtdL+44AuM4rCSXABJH3gJb13puDZoADoJ2Un7dCeotnqcC?=
 =?us-ascii?Q?pwtga6mZpPVf6tNf0c5IQHksfaeScQtKJwATvLzd1ecc/MJAFgDXki9Ras0O?=
 =?us-ascii?Q?tYzeIe5uYzBO5X+barLDanzQWkRjD5CoCpl+4Tc29xuBJLVAT5eVHjmjYF2h?=
 =?us-ascii?Q?57fs86AW7VzVtR/wKMhEcxuhEsfpz6+QcweliEUBITxvmvYFS8iu9VauJRXE?=
 =?us-ascii?Q?W6CF/+F+bp62vT3zRl/xHpxPri9TDxfHWZw838ZX/YbBWkpa9ZbBLQ5kliwv?=
 =?us-ascii?Q?vmwg3bln53gPC6w9feIN5CBdYDhxtQKQB25O+xIs7MdE+7TpWiymK097zhXT?=
 =?us-ascii?Q?CKsP/FKEQD4VhOGKkYZZOMaqiVspp3YAelJi/pmDvguumIsaqeDQ0NkYALq1?=
 =?us-ascii?Q?efyb8h3P1VHUCwGWWC1QIIxv8HgIz6wHhyQSFbu9lqlCnGnvJl3NSbWUcjEo?=
 =?us-ascii?Q?Z550Zq4ZnEtSr++mskfSP0Ct2qpfaTiWtpJG/J15WoPSLe1CZ4k/cdMJuq+w?=
 =?us-ascii?Q?HNm2wtkPpBsnCRqIZ4rRPe9KnbBMBH5TnVBwhRGv8qWeeQTjyApKBONi02Tv?=
 =?us-ascii?Q?5qA53fkdo3aiqsi0Ibrf+UbWfkemOMS5KKVAgLU3PDyD75fCwrHCL37a+OSA?=
 =?us-ascii?Q?zhy+1Wd6Im7lTYypbVDgsGvit29SSnFqyC+SL8RsgDlGWYX22mLG+LinLNuF?=
 =?us-ascii?Q?ux+xWLR8MJMpVH/8pSz7+5zSy4AwBUkr/N0dQGju1+mfVjXLbBwI1Gg+YBEd?=
 =?us-ascii?Q?vFImMcy26bW0PQL2LQXmWRwmCk70AL9yBKxQ829yEg3vtvrpDhqGxrHtLK2W?=
 =?us-ascii?Q?WOKgejsyJMxMGMFh4O6bPj8ejhmVxzlAIyyickVuizyLAv0B7nvsTds6dvtV?=
 =?us-ascii?Q?PXGeCX3gbdGsSzu4cRqLnaQ8iKUOLnUlkmJIWrhfm5M9fmGScVYYKKbi4tVI?=
 =?us-ascii?Q?CrjHPBRYnd9o7AejTShNoGC0uNfBJ+8f4jFmPvc4xB4QQaEf2V1L9JVVqKTl?=
 =?us-ascii?Q?hUcb3lXSadZtgwHwlVeLFOddMMtrARWL75Zy81A2RkCdIOmn1aiQP4AxyVFC?=
 =?us-ascii?Q?ohmbOZESeot77CpwXM7V5cCALHCGV1UhQIotkZWSXKpRd4yMrCDA04eN3tV/?=
 =?us-ascii?Q?RCEa+EPO85MYvfhLKL9AChGxNnaWkymFQEhet8TpQY+8GBXtF7UtCtQbys+x?=
 =?us-ascii?Q?unTKj42fyc3XaZvFa5oNeHwS+E2p7tMO9Wk1wdBsYGm6A+Pi/id81I6aLYNJ?=
 =?us-ascii?Q?bZfr2MjT/L0Np7nP3HNoeh6MrY99blY9klbJddMx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56ff89b-fc4b-44e6-52b3-08dbcece4b0e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 05:02:42.4308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSGuytI7veEyTxBFz/b4hJW7RELuaSNs63tz+Axvk7dikInTijGdJwPSsw8MVNwhwlIlfOSx1O51ibg6YwXTLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yicong, Barry,

On Thu, Oct 12, 2023 at 08:17:06PM +0800, Yicong Yang wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> For platforms having clusters like Kunpeng920, CPUs within the same cluster
> have lower latency when synchronizing and accessing shared resources like
> cache. Thus, this patch tries to find an idle cpu within the cluster of the
> target CPU before scanning the whole LLC to gain lower latency. This
> will be implemented in 2 steps in select_idle_sibling():
> 1. When the prev_cpu/recent_used_cpu are good wakeup candidates, use them
>    if they're sharing cluster with the target CPU. Otherwise trying to
>    scan for an idle CPU in the target's cluster.
> 2. Scanning the cluster prior to the LLC of the target CPU for an
>    idle CPU to wakeup.
> 
> Testing has been done on Kunpeng920 by pinning tasks to one numa and two
> numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.
> 
> With this patch, We noticed enhancement on tbench and netperf within one
> numa or cross two numa on top of tip-sched-core commit
> 9b46f1abc6d4 ("sched/debug: Print 'tgid' in sched_show_task()")
> 
> tbench results (node 0):
>             baseline                     patched
>   1:        327.2833        372.4623 (   13.80%)
>   4:       1320.5933       1479.8833 (   12.06%)
>   8:       2638.4867       2921.5267 (   10.73%)
>  16:       5282.7133       5891.5633 (   11.53%)
>  32:       9810.6733       9877.3400 (    0.68%)
>  64:       7408.9367       7447.9900 (    0.53%)
> 128:       6203.2600       6191.6500 (   -0.19%)
> tbench results (node 0-1):
>             baseline                     patched
>   1:        332.0433        372.7223 (   12.25%)
>   4:       1325.4667       1477.6733 (   11.48%)
>   8:       2622.9433       2897.9967 (   10.49%)
>  16:       5218.6100       5878.2967 (   12.64%)
>  32:      10211.7000      11494.4000 (   12.56%)
>  64:      13313.7333      16740.0333 (   25.74%)
> 128:      13959.1000      14533.9000 (    4.12%)
> 
> netperf results TCP_RR (node 0):
>             baseline                     patched
>   1:      76546.5033      90649.9867 (   18.42%)
>   4:      77292.4450      90932.7175 (   17.65%)
>   8:      77367.7254      90882.3467 (   17.47%)
>  16:      78519.9048      90938.8344 (   15.82%)
>  32:      72169.5035      72851.6730 (    0.95%)
>  64:      25911.2457      25882.2315 (   -0.11%)
> 128:      10752.6572      10768.6038 (    0.15%)
> 
> netperf results TCP_RR (node 0-1):
>             baseline                     patched
>   1:      76857.6667      90892.2767 (   18.26%)
>   4:      78236.6475      90767.3017 (   16.02%)
>   8:      77929.6096      90684.1633 (   16.37%)
>  16:      77438.5873      90502.5787 (   16.87%)
>  32:      74205.6635      88301.5612 (   19.00%)
>  64:      69827.8535      71787.6706 (    2.81%)
> 128:      25281.4366      25771.3023 (    1.94%)
> 
> netperf results UDP_RR (node 0):
>             baseline                     patched
>   1:      96869.8400     110800.8467 (   14.38%)
>   4:      97744.9750     109680.5425 (   12.21%)
>   8:      98783.9863     110409.9637 (   11.77%)
>  16:      99575.0235     110636.2435 (   11.11%)
>  32:      95044.7250      97622.8887 (    2.71%)
>  64:      32925.2146      32644.4991 (   -0.85%)
> 128:      12859.2343      12824.0051 (   -0.27%)
> 
> netperf results UDP_RR (node 0-1):
>             baseline                     patched
>   1:      97202.4733     110190.1200 (   13.36%)
>   4:      95954.0558     106245.7258 (   10.73%)
>   8:      96277.1958     105206.5304 (    9.27%)
>  16:      97692.7810     107927.2125 (   10.48%)
>  32:      79999.6702     103550.2999 (   29.44%)
>  64:      80592.7413      87284.0856 (    8.30%)
> 128:      27701.5770      29914.5820 (    7.99%)
> 
> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so the SMT branch
> in the code has not been tested but it supposed to work.
> 
> Chen Yu also noticed this will improve the performance of tbench and
> netperf on a 24 CPUs Jacobsville machine, there are 4 CPUs in one
> cluster sharing L2 Cache.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> [https://lore.kernel.org/lkml/Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net]
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>

This version looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  kernel/sched/fair.c     | 41 +++++++++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h    |  1 +
>  kernel/sched/topology.c | 12 ++++++++++++
>  3 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 666ece65987f..4039f9b348ec 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7259,6 +7259,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  		}
>  	}
>  
> +	if (static_branch_unlikely(&sched_cluster_active)) {
> +		struct sched_group *sg = sd->groups;
> +
> +		if (sg->flags & SD_CLUSTER) {
> +			for_each_cpu_wrap(cpu, sched_group_span(sg), target + 1) {
> +				if (!cpumask_test_cpu(cpu, cpus))
> +					continue;
> +
> +				if (has_idle_core) {
> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> +					if ((unsigned int)i < nr_cpumask_bits)
> +						return i;
> +				} else {
> +					if (--nr <= 0)
> +						return -1;
> +					idle_cpu = __select_idle_cpu(cpu, p);
> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +						return idle_cpu;
> +				}
> +			}
> +			cpumask_andnot(cpus, cpus, sched_group_span(sg));
> +		}
> +	}
> +
>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
>  		if (has_idle_core) {
>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> @@ -7266,7 +7290,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  				return i;
>  
>  		} else {
> -			if (!--nr)
> +			if (--nr <= 0)
>  				return -1;
>  			idle_cpu = __select_idle_cpu(cpu, p);
>  			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> @@ -7395,8 +7419,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	 */
>  	if (prev != target && cpus_share_cache(prev, target) &&
>  	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> -	    asym_fits_cpu(task_util, util_min, util_max, prev))
> -		return prev;
> +	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
> +		if (!static_branch_unlikely(&sched_cluster_active))
> +			return prev;
> +
> +		if (cpus_share_resources(prev, target))
> +			return prev;
> +	}
>  
>  	/*
>  	 * Allow a per-cpu kthread to stack with the wakee if the
> @@ -7423,7 +7452,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
>  	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
>  	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
> -		return recent_used_cpu;
> +		if (!static_branch_unlikely(&sched_cluster_active))
> +			return recent_used_cpu;
> +
> +		if (cpus_share_resources(recent_used_cpu, target))
> +			return recent_used_cpu;
>  	}
>  
>  	/*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 998f03d02de0..ef4fe7bcf740 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1859,6 +1859,7 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>  extern struct static_key_false sched_asym_cpucapacity;
> +extern struct static_key_false sched_cluster_active;
>  
>  static __always_inline bool sched_asym_cpucap_active(void)
>  {
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 48cd88350d18..925cd68abc8b 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -673,7 +673,9 @@ DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> +
>  DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
> +DEFINE_STATIC_KEY_FALSE(sched_cluster_active);
>  
>  static void update_top_cache_domain(int cpu)
>  {
> @@ -2386,6 +2388,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  	struct rq *rq = NULL;
>  	int i, ret = -ENOMEM;
>  	bool has_asym = false;
> +	bool has_cluster = false;
>  
>  	if (WARN_ON(cpumask_empty(cpu_map)))
>  		goto error;
> @@ -2514,12 +2517,18 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  			WRITE_ONCE(d.rd->max_cpu_capacity, capacity);
>  
>  		cpu_attach_domain(sd, d.rd, i);
> +
> +		if (lowest_flag_domain(i, SD_CLUSTER))
> +			has_cluster = true;
>  	}
>  	rcu_read_unlock();
>  
>  	if (has_asym)
>  		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
>  
> +	if (has_cluster)
> +		static_branch_inc_cpuslocked(&sched_cluster_active);
> +
>  	if (rq && sched_debug_verbose) {
>  		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
>  			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
> @@ -2619,6 +2628,9 @@ static void detach_destroy_domains(const struct cpumask *cpu_map)
>  	if (rcu_access_pointer(per_cpu(sd_asym_cpucapacity, cpu)))
>  		static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
>  
> +	if (static_branch_unlikely(&sched_cluster_active))
> +		static_branch_dec_cpuslocked(&sched_cluster_active);
> +
>  	rcu_read_lock();
>  	for_each_cpu(i, cpu_map)
>  		cpu_attach_domain(NULL, &def_root_domain, i);
> -- 
> 2.24.0
> 
