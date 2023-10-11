Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB717C4B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344641AbjJKHUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjJKHUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:20:39 -0400
Received: from CO1PR02CU002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7276190
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUM9XsDj0/61Grz83Nl/3JMmk634gMakt1A3uP52awJ9QnoEZIEyDfyrP9N1Jy+wks2zV0MH5V3YiaZRp4tlfX+xEY/cJl2PM51AubWRd5S+RKuSYY5UDdWydxNvVX7ZAN4OfL8iRk4j4y9BpPmlGWa7RE88qUQzi41j5YZG+AZphqRA2nk1S9hrUXukXkY15MKo+vxaaNfBLUeLGzYs4o8l5X2jav+OWR670PD84DKsz83/czaMFqUQuKto2UHL6WtlObkqrVJzCUUMbxTTYsE9PplQP9OU1MkrLtO9xNpMPdrPjZenP7359WrPAbHQrKTtMYACigpVrFYM6PRkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+I74F3AweP5n8SZCyvE2BmA+8HPJn2AL/+N5sFHMNZ8=;
 b=fndCQ3dpysTrTU0coKSOnh5kuk3f66L/1i/iIUbgx4+CbZm5UBOP9hb7Qpc+UnITyoV6ZzbWHRMlz8M9QtmQr7YB5ytXfDPFkl7KTwJbqPoKU6ki2YFm7aQL0R4HLj6myMG5niz+2LQUE28+xFWdVGPVCVRw4GMmBfnnWRQjPjqOsVrk9rGinMZEPYRGvABHB1Ow5k0lIG2GJnMT/yvYUYaFxkxkVh4HtDM52P0eGzxFVXAUGuTer/JOcDoVF6zfAoYAOCsFYuFUCPGM5YzLL/+JoDnl5WUCZlxztMNA1Y7X61nIJvxjQVPbF3nJPawm9wPWOVIeMu2770iyChQrVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+I74F3AweP5n8SZCyvE2BmA+8HPJn2AL/+N5sFHMNZ8=;
 b=HwT50CYhNcRaaBVwk/XlInZ0zAWBObD8u/kptV5Te90Coqp0kXwdCakc1hGiAFF6v3EFn7mD31YcShk+cgJT711IN926y6u0SciJEpkTE7vjPYnxPQHpR2cq9X/Vmt+S0ntUlsiTkjqVyZp7rXSkFo8/rHZGS0FZEdN+cvPZ45o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from SA1PR05MB8311.namprd05.prod.outlook.com (2603:10b6:806:1e2::19)
 by CH3PR05MB10028.namprd05.prod.outlook.com (2603:10b6:610:12a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Wed, 11 Oct
 2023 07:20:34 +0000
Received: from SA1PR05MB8311.namprd05.prod.outlook.com
 ([fe80::cbd2:31a1:4175:2d]) by SA1PR05MB8311.namprd05.prod.outlook.com
 ([fe80::cbd2:31a1:4175:2d%7]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 07:20:34 +0000
From:   Ankit Jain <ankitja@vmware.com>
To:     peterz@infradead.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        qyousef@layalina.io, pjt@google.com, joshdon@google.com,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     namit@vmware.com, amakhalov@vmware.com, srinidhir@vmware.com,
        vsirnapalli@vmware.com, vbrahmajosyula@vmware.com,
        akaher@vmware.com, srivatsa@csail.mit.edu,
        Ankit Jain <ankitja@vmware.com>
Subject: [PATCH RFC] cpumask: Randomly distribute the tasks within affinity mask
Date:   Wed, 11 Oct 2023 12:49:25 +0530
Message-Id: <20231011071925.761590-1-ankitja@vmware.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::12) To SA1PR05MB8311.namprd05.prod.outlook.com
 (2603:10b6:806:1e2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR05MB8311:EE_|CH3PR05MB10028:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a781826-8451-46e4-d56d-08dbca2a8e0a
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j77nDYdiWPMudco2ukCAHs8yqW+ugwPcsCWX0TaPhpinXQNjqYVZ7K0NNB9ulGISLAIAYMTgKk/t0vFtniUfa+efJAYwBIvMy3/mmjizVzhV06Zz0gu7Xq17Pu3emTOuIeyXWolasRicwNKFtriexSTQqlCEHTD5UvfpiyWWu+fxQbG+R1u2P9fD7SpPWqXZw5SKVGdnbznGNvr4kNFwIbovfVnKVALypz/h0jbQqyPTxIQq9fz7dZEclxqIqZL0bj/CxpFPS4rCvhbFNmjH2llhRCL91Bp1vxWh2hi+WhpS0/c/2IA1TEuxWnOdIIX3V2gMtWw+4cHp+OIMw+eK9j4M43eN66c7iAYSwxNSrKkcYag79LebEjZfhWoVcXItOVvqEqAcNIGRP6Jaimwsh0by8vKG0ltwPS1ZJoYNVkJg73Ey0NWzVmbl0YH7i3Z43fdCLcs5224D/iewg8jC4mLolfVDG5x7CGVn6EU3DGbEuffkwuQ0UIu9HVKG6FP9b+fefAzc45vLa/MigxE83I8KsX+WfXUlPe2sQc4KRCgqDBJKUWRB65vmF7TVOXp0zQ87dd8g+USQNP4U/UIFQwA41ACZ6084Vm9V+wgwVZdkYd2G7Bmpzh8CDh5e4fjnrXAGMILmILx4VReiR5/l5T6bX/IaJhN6r7uTHUqJtr8bx1UlOC3YS4Zz+RMfIWme0Jy87udEqK3m2emNlNN+5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR05MB8311.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(6506007)(38350700002)(478600001)(52116002)(6486002)(6666004)(6512007)(1076003)(38100700002)(36756003)(921005)(86362001)(7416002)(316002)(2906002)(107886003)(26005)(2616005)(4326008)(66476007)(41300700001)(8936002)(66946007)(5660300002)(8676002)(66556008)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0E3eTlia1dPVXc2SmNJd08rd21NNVZFQ2lNNVRCYWdhZkdUcmFGK252alNC?=
 =?utf-8?B?UVZtaTZzQWhQNjlNZFVsR25IdmhjdEFteVdVMnkxSGVabisrRDFINzJCajBS?=
 =?utf-8?B?YS9VWTRuN3ZnRS9KdnlqVHlySjFxTjJpYnpROEQ2Ym8vUmNhN2ZOZThvUHg4?=
 =?utf-8?B?L2xsMnVGdnNGMzBzU1liMHZRcFdFMHhqUWprRThLZ2sxQ2dZcFNrS055MzhV?=
 =?utf-8?B?ODEyeW5nOUZBNU5NVU8vWnZYZmZDenlNRFZleWFBU2tUdjcxZFlCNG15eHcy?=
 =?utf-8?B?MmI3dGdsUHM2Z3VyL2FRWk1UZVpwcGNEUWJna1M4VjdQaW5TVWFtWnlHTTFO?=
 =?utf-8?B?bllXKzdGcnpWblgwV1JPU3J1eml0M2tyMVRmVlRydTFzaDVEbmttL0twbmh4?=
 =?utf-8?B?TjVXMGUyeko3WE1GN2ZHR1F2R1A0TkVNeHpFNXlkazdWbjVIcnh0T3J1RDRO?=
 =?utf-8?B?YTFvVVdMRUVVWTlpYlNMK3Q0azQ3ZllxemNDU2krSnl0VkNtcU9mWWJyT1Za?=
 =?utf-8?B?Mm01cHhnVzBwYWd4bHZkVWI0K2M0SHlSc3VOTklCd0owZ0htU3drbWpRbHU3?=
 =?utf-8?B?MTlmYi9sZXM1aVdaWDFFYXFJZlJFNFUrK0hvNW85NTc2aytJUjJxUG5WdkNs?=
 =?utf-8?B?RnA1c1lXZU0yNk1WbHg0RjZkYlBDcXM4NGtwSzN2NFRZVDNLUXNNWUZ5YVJs?=
 =?utf-8?B?ZGVKV1lVMWFkMCtGeEN2WXBmN3lTY3FsMlBSaE9RTlhORVBjL05PcmlYVWpF?=
 =?utf-8?B?MXp5VWVkNlBmZC81MndVcU5FWFN2YjhDb2MxM2ExNUlQLzdnck9TMUx1MkVE?=
 =?utf-8?B?T0YzZG1VZUgydThmd2ZWeFVKalVsOTBQUEZEN1l1bngzZnFLNjVteWwzTDVH?=
 =?utf-8?B?aktKaWhXUTFkRW1HcjdYRTBldE8wWnJUbWc4Q1FCcUNpdEx5Y3B1YkdoRjBr?=
 =?utf-8?B?SE92L3F0Q0JjeVh3eDRmOXM0S3NCZkJ4SHJlbFhtRzBFVWFNRXBLVXEycEgz?=
 =?utf-8?B?UFA1b2V2dEpQRzdJSzFHY2R6c0tvZDFnRU0yMUh6RXI2dDJXTEJzY2RYOENJ?=
 =?utf-8?B?TGxCTE1KdHhDOS9LU3BkdWxZekdqVnhXeC9XUWlyOEpnTEE0RGczbDNBNm5F?=
 =?utf-8?B?blFvb3hsUkNSaTQxU1FGRVJJK1BxYUZTOWIrdnZTdXdRbklkeVJTa3RMYy9w?=
 =?utf-8?B?QzJxeTJySS9JYko0clVFd0ZMZ1VzdFNCanlFRzNNb05LOVBNbjh0VERaZDRU?=
 =?utf-8?B?cEZoYlFQT1pjb0M3bGhrdklobUI1am1VZHh4aXMzZiszTUpURGJXTTNsQnJ2?=
 =?utf-8?B?ZlJaNFEyU2o3TGN0eUtTQ3ZvSTJaeXZodlV1aDlaZXlKNVlxR2ZVUEJUVVI2?=
 =?utf-8?B?L1AyUCs1bFdEYUhRRXZoYzdSUHR4d3Z6akNRaCtmWDBrM2E5YjNwbmVJSDJB?=
 =?utf-8?B?M2JuVzYybXpTN3ZaczdwSjNneHNXWGpINjQzUWVaTFAxdkJiTU1YZEJzaEhn?=
 =?utf-8?B?bndxVm1rNXBjcktyL2ZQanBGd2Q1dGlBcDAwZjFweFFxZ2ZldExoWGlDZHlR?=
 =?utf-8?B?K3hUQXBUR25kUDMya0tyMm1peXhpQm9MNjlwU0VmY2pQenhxV0d2NytLelBO?=
 =?utf-8?B?NXFKQkJzQ3hBZ01UMHMzNHhCV2tJOUNnUUJuQjd2WjlTQmVKZFhibCtUL0ls?=
 =?utf-8?B?dnZVanZEVlN0cjlGSTBVNWJLMUYxL3dNbDF1Tjl5dEMvL1o4QUpCSEJDY3VB?=
 =?utf-8?B?ZHR1QnEvNVRIUytpRjkxVVUxT1lVMTgrbXNZRk5tazhoNDZvN2xMM3ltYU94?=
 =?utf-8?B?bko0a1hxb3VuVVBrWG9OTUV2ZFdkVVh2WlRFZFAxZ0tYY0dHN3hvZ2luK0Fz?=
 =?utf-8?B?WHBrd2xPUU9pRGg0OWt2K2NMVHNWMnh2SzZ0V3E2SW9EekVjYU1Cb0M4Ty9Y?=
 =?utf-8?B?bU9iZ1Q3L0p5b0JCc3RaNkNpblhYTGkxUFVkTGRIelo4WWVYd1B1TWNNUGxW?=
 =?utf-8?B?RFYwTlFRZWMyV3lUb3A0elhQVmZWYnRnUSt3Q2Npa0EwUjByMTFORTBDdVQv?=
 =?utf-8?B?ODZxOThkUG9UZWdUa1N6cGx5dGE3S2JZSnJTMFByMTVUbGxXeThQMURVVkRZ?=
 =?utf-8?Q?0elf7SSw8GUBW96HhO5cFjE20?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a781826-8451-46e4-d56d-08dbca2a8e0a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR05MB8311.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 07:20:33.7049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQffPHAdAEWtFRFLiO3ERauTxjZh/c01ObhB8wx5PtcSMaDJm9loMOKuMfMEeEuw8PtK9xiS7w6k2n3ebCUlKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB10028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 46a87b3851f0 ("sched/core: Distribute tasks within affinity masks")
and commit 14e292f8d453 ("sched,rt: Use cpumask_any*_distribute()")
introduced the logic to distribute the tasks at initial wakeup on cpus
where load balancing works poorly or disabled at all (isolated cpus).

There are cases in which the distribution of tasks
that are spawned on isolcpus does not happen properly.
In production deployment, initial wakeup of tasks spawn from
housekeeping cpus to isolcpus[nohz_full cpu] happens on first cpu
within isolcpus range instead of distributed across isolcpus.

Usage of distribute_cpu_mask_prev from one processes group,
will clobber previous value of another or other groups and vice-versa.

When housekeeping cpus spawn multiple child tasks to wakeup on
isolcpus[nohz_full cpu], using cpusets.cpus/sched_setaffinity(),
distribution is currently performed based on per-cpu
distribute_cpu_mask_prev counter.
At the same time, on housekeeping cpus there are percpu
bounded timers interrupt/rcu threads and other system/user tasks
would be running with affinity as housekeeping cpus. In a real-life
environment, housekeeping cpus are much fewer and are too much loaded.
So, distribute_cpu_mask_prev value from these tasks impacts
the offset value for the tasks spawning to wakeup on isolcpus and
thus most of the tasks end up waking up on first cpu within the
isolcpus set.

Steps to reproduce:
Kernel cmdline parameters:
isolcpus=2-5 skew_tick=1 nohz=on nohz_full=2-5
rcu_nocbs=2-5 rcu_nocb_poll idle=poll irqaffinity=0-1

* pid=$(echo $$)
* taskset -pc 0 $pid
* cat loop-normal.c
int main(void)
{
        while (1)
                ;
        return 0;
}
* gcc -o loop-normal loop-normal.c
* for i in {1..50}; do ./loop-normal & done
* pids=$(ps -a | grep loop-normal | cut -d' ' -f5)
* for i in $pids; do taskset -pc 2-5 $i ; done

Expected output:
* All 50 “loop-normal” tasks should wake up on cpu2-5
equally distributed.
* ps -eLo cpuid,pid,tid,ppid,cls,psr,cls,cmd | grep "^    [2345]"

Actual output:
* All 50 “loop-normal” tasks got woken up on cpu2 only

Analysis:
There are percpu bounded timer interrupt/rcu threads activities
going on every few microseconds on housekeeping cpus, exercising
find_lowest_rq() -> cpumask_any_and_distribute()/cpumask_any_distribute()
So, per cpu variable distribute_cpu_mask_prev for housekeeping cpus
keep on getting set to housekeeping cpus. Bash/docker processes
are sharing same per cpu variable as they run on housekeeping cpus.
Thus intersection of clobbered distribute_cpu_mask_prev and
new mask(isolcpus) return always first cpu within the new mask(isolcpus)
in accordance to the logic mentioned in commits above.

Fix the issue by using random cores out of the applicable CPU set
instead of relying on distribute_cpu_mask_prev.

Fixes: 46a87b3851f0 ("sched/core: Distribute tasks within affinity masks")
Fixes: 14e292f8d453 ("sched,rt: Use cpumask_any*_distribute()")

Signed-off-by: Ankit Jain <ankitja@vmware.com>
---
 lib/cpumask.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index a7fd02b5ae26..95a7c1b40e95 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -155,45 +155,47 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
 }
 EXPORT_SYMBOL(cpumask_local_spread);
 
-static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
-
 /**
  * cpumask_any_and_distribute - Return an arbitrary cpu within src1p & src2p.
  * @src1p: first &cpumask for intersection
  * @src2p: second &cpumask for intersection
  *
- * Iterated calls using the same srcp1 and srcp2 will be distributed within
- * their intersection.
+ * Iterated calls using the same srcp1 and srcp2 will be randomly distributed
+ * within their intersection.
  *
  * Returns >= nr_cpu_ids if the intersection is empty.
  */
 unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p)
 {
-	unsigned int next, prev;
+	unsigned int n_cpus, nth_cpu;
 
-	/* NOTE: our first selection will skip 0. */
-	prev = __this_cpu_read(distribute_cpu_mask_prev);
+	n_cpus = cpumask_weight_and(src1p, src2p);
+	if (n_cpus == 0)
+		return nr_cpu_ids;
 
-	next = find_next_and_bit_wrap(cpumask_bits(src1p), cpumask_bits(src2p),
-					nr_cpumask_bits, prev + 1);
-	if (next < nr_cpu_ids)
-		__this_cpu_write(distribute_cpu_mask_prev, next);
+	nth_cpu = get_random_u32_below(n_cpus);
 
-	return next;
+	return find_nth_and_bit(cpumask_bits(src1p), cpumask_bits(src2p),
+					nr_cpumask_bits, nth_cpu);
 }
 EXPORT_SYMBOL(cpumask_any_and_distribute);
 
+/**
+ * Returns an arbitrary cpu within srcp.
+ *
+ * Iterated calls using the same srcp will be randomly distributed
+ */
 unsigned int cpumask_any_distribute(const struct cpumask *srcp)
 {
-	unsigned int next, prev;
+	unsigned int n_cpus, nth_cpu;
 
-	/* NOTE: our first selection will skip 0. */
-	prev = __this_cpu_read(distribute_cpu_mask_prev);
-	next = find_next_bit_wrap(cpumask_bits(srcp), nr_cpumask_bits, prev + 1);
-	if (next < nr_cpu_ids)
-		__this_cpu_write(distribute_cpu_mask_prev, next);
+	n_cpus = cpumask_weight(srcp);
+	if (n_cpus == 0)
+		return nr_cpu_ids;
 
-	return next;
+	nth_cpu = get_random_u32_below(n_cpus);
+
+	return find_nth_bit(cpumask_bits(srcp), nr_cpumask_bits, nth_cpu);
 }
 EXPORT_SYMBOL(cpumask_any_distribute);
-- 
2.23.1

