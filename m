Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A0C7A222C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbjIOPTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjIOPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:18:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDCAE6C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BL9NOjy7oQTk+1AEl2RkADVL67Ds8HGYzB1lr1hQQ+qiAPYAN26Xncns50vOfc5BI+F6OyjdV6POveXDBsvxcFMevSE+yZdqEa6I/An4tPxFkocch/deWZH52Ce6d9vezOKwchcg1Q0zhIDJnylIfT8Bx0S9SBqSeXDQ0Yr9SILSOsupSvGISLbN1rmeN5Ff43Xo4W00AT9S9WOBJAa+v9sUjUZejdB7LWQko0S8lJSExyDTNk/ZrHCwnJeGxTcWDRoJxworfoHyQqjNUW+sXpte++RtpVd1WZ/yymGkpQ02wMonDLaWc2/x0EQYjTK2M/yBLWAGHFUyZ617zLkvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwbizxVtXyG7V5DSK0GcMIRKG34/toa+O8Z9qUuHYfs=;
 b=mpwXdL4WH36wer50e47J49xqNvTIPA5DivT2fskg2A8WpG1fN3MPw4AjMEia9KN7CKUhID1Se2GTz2PKrWjj92/sAkVbRAuZWLIoqJwMJmp0m3mp1UIdG9x3gNmF+ZdtQNhxrd5CZ/he8wLNKXbfjkW+r0KAF9IahTbQlm6NPM3G4u3Udyck2syTtTX4qh/tcUvZQOo0ripDAe0OWY/E+6Kd2+YZH6+YtXVsoD9zH1wFAo9xeA48gv+b9xRL5fTKH4u6bx7NnPZXLwaujRei8tKPk1BpoN/1P+AFe4QF9VEJkYGHOeEME/7OAy1gJYAwWQ7qOjW3YC1fcUoi12pbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwbizxVtXyG7V5DSK0GcMIRKG34/toa+O8Z9qUuHYfs=;
 b=CSwzOU0TEisj50RWTN25TgAv1xWFpZtps5pqUi4XXBQ8LmCoCDSJPzq5js+wbVVFReJ7TOhM1dOyhSbL6KwjXCl1A7VfhKnqGKpZ8DohMlLmgIbZO+mAjOH8PRaERN9QsMfpfj7dzMH2k0FmxBZmViVrbx9uyli1t1loJbCrMiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 15:18:32 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6769:d6da:514c:90ab]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6769:d6da:514c:90ab%7]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 15:18:32 +0000
Date:   Fri, 15 Sep 2023 20:48:14 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Message-ID: <ZQR1tovjkTZ0VcP6@BLR-5CG11610CF.amd.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <20230911072629.GA298322@ziqianlu-dell>
 <ZP7SYu+gxlc/YjHu@chenyu5-mobl2>
 <ZQFVFv4GcPOU+X7N@BLR-5CG11610CF.amd.com>
 <ZQFj2hk4i1QAWEQp@chenyu5-mobl2.ccr.corp.intel.com>
 <ZQKw+W7k+XNweKBu@BLR-5CG11610CF.amd.com>
 <ZQL39qpKQncZWs94@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQL39qpKQncZWs94@chenyu5-mobl2.ccr.corp.intel.com>
X-ClientProxiedBy: MA0PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: b8603158-d45b-4c1d-62e7-08dbb5ff059a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXjzQEV6HwQdZaEL/PZajtkwI4tpua04/xYoamV2/TrjyYm0MNwYlAqotYWXS2aoqMKb7HXHLI1huTKlpliE6UCfDk/Fmhd4DsQPraaVeIYfgNVTcUJJ5yPjcyyfPINDyefZ1TybNa+O2UMqiq1bWQNyDqc8RSBhLK81T0ao7eTidrrJEzaljMhLfBMAUeB4dkCmt4ceL7GalesIr8sbWW1c/V+tvCDUMTPpdFpXwOBmOVC2xwfElwbnt6z+9DsuxUN3mr6CYEjqpzvwgR6bhv2i7ffQeZzoNap5z2Z0EH5fgIx10htRKa4a4w8YwC+GGqZOOqghUD0nM8Ty5Ikck38a1hNb5JJJCX5DgFrvry0KGtO1mvVvojXX+EIYH2ot8TiSImaNmDw50qg1hVVqInQeGUkdal2jcbxHthn3E/xKJwcV62RAbdk0P5YhmXqeSvlbu61+uS5gF9TBw4aPGQ664+tFXiQfluXffKvokzvG+GsXlhymY5kCxe0lcuHj+45cecWTOOIp9Fm3+k3iYa95R3sd2uYZRYPxH1QDvv22l7HPDrqMnSL29349KVfY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(186009)(1800799009)(451199024)(66899024)(38100700002)(86362001)(2906002)(55236004)(6512007)(316002)(6506007)(6666004)(5660300002)(8676002)(8936002)(66946007)(66556008)(54906003)(4326008)(6486002)(41300700001)(66476007)(6916009)(83380400001)(7416002)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NOmaESDxTLKSfwsR1qML0h2gDIbjkffhTWQExQzlW6UKV4jHOHudAlDG0ITM?=
 =?us-ascii?Q?3OIW5qTtqNAG42jGOLe91cHvHl5DKB3/RNGW7CMi/1UeG5CI6Y7TXjxeXYiD?=
 =?us-ascii?Q?rU25syjbsiGLn0JxXZ73BaiZc3fWMYJaVt9oTfpsdGR8nliBtUylbWFwYXt8?=
 =?us-ascii?Q?F+Rl5EVDUfazSuhPwuPXL5SjHGDrE8ux19TwamCvF2UrtkOw5EPZD+vIGaUK?=
 =?us-ascii?Q?ELrARou9p8ao6dDuNFWkctVpkcUUumFRsJYLbC8jIFeoYKRojwm1pE7HZ6ap?=
 =?us-ascii?Q?96E9kZcdxm/O1ivKNySlkBiXCmLnmDp5EFsH1acMFmVwjtRDcXWo1lmSIi1c?=
 =?us-ascii?Q?l32fdzvcycls9IsvsApd2QGDn4cWAHO5XvGdOTMwYxhmsNu8pNeMOrxIYwoP?=
 =?us-ascii?Q?ge6yWg5nXKtbDnyS1+IJklbZaG/++CK35pdHesuggj68oxH+ApSgMqV5bVD4?=
 =?us-ascii?Q?BVeYr1mAGVLM3bPTeMcWQwLWek4UyWjuTuM1XAQX3ID88GdUB5nYcL5LaCX6?=
 =?us-ascii?Q?RGZjzOwocbXRXis1nxXkdM3RPQ7oI6SBCBRyKAtaoaC9Qb0MGIRLCHuLrcU4?=
 =?us-ascii?Q?3ImEENLiCAoC/C4lOx4jSa/FTjbDS190CNcR6k7Rn0p3ndalXLGnZtQlIgYk?=
 =?us-ascii?Q?BSJ6Zf3Vix7KRQa117mvSKt3sSHnv48hPA7SH3NysyzeTr4nN2qX37NNturf?=
 =?us-ascii?Q?SIEjNWFGNF3v4ZVPwvxB2jmvGoTNCIupYImLswWn12lxm1tNceqIqWQQAgNT?=
 =?us-ascii?Q?+ohrD54GuMeN3NQHrYwXLJHfcn8ggEJwl3EgqrARvoZsN/yRWRYX61c9A/XG?=
 =?us-ascii?Q?ytTOtXQHaCIop22aMVew4y68dS/6fOtCQZcVJJ94ZTj1kW18U8x449KQueyo?=
 =?us-ascii?Q?jgeKTvOzdHoDkUkd8KpoBPge4D7pV5UjpzCcIMsrfH7BDEO+bsyB0cWPcnlc?=
 =?us-ascii?Q?LVamuswcdQEGZfWIS802/w1ELdjw1AXm0IxxjVulQHmPrDGVIaCEc1bDU63h?=
 =?us-ascii?Q?1eKGw/Q8hbQUScvsjgA22EHykBYiHempur3hUSgggrpyE518S0W6nJpB6iaM?=
 =?us-ascii?Q?JojHOdQAaZDnjDbeZsIHpbOkQE3u12oOlNCkLJsMhjgjYzyc8mx4r8nDT0X6?=
 =?us-ascii?Q?RglgslN0tCQZeOB37GOKDzfQx51I3Bjm0EZq68tr5FR52R7vO4NhHLNS4ppl?=
 =?us-ascii?Q?7lPJaf7yccEmK63UEas71bQPqVg0Gd1TYY4W+XtBJX5KCYEFXAIOeUDEMGNA?=
 =?us-ascii?Q?cZSrwhUQYjd6RRMSDaKnuIvb6PkQsfScPTl44uiG9NKAOvhTZXEONUaQOhq6?=
 =?us-ascii?Q?E2i/WCQk8isYRaRliQ8OCVHOwbsY78y+2mqtGTiH+zO7QJeZJz4ZI9v95gLm?=
 =?us-ascii?Q?a0ioVR+z7sIySOBEEyDPc/4FD6lYm6mDoxuO6/Qg/C2nw93XqFdLpZE6rVwG?=
 =?us-ascii?Q?ngngsxCqslWlGj4Fh0Z6RoD/XYFvHCoH4yYuoGaJxbcnk+0/u+575HDEiHVU?=
 =?us-ascii?Q?Ty1VgNMYlWqEjYmjDe/h5L2e48dOXcCch5eNWVwKN8cOelrTgfAFje72+eW2?=
 =?us-ascii?Q?M8qP3Y1ZG27Ns9NsOQQFstPfwFX9oLYEpgZoVlHp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8603158-d45b-4c1d-62e7-08dbb5ff059a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 15:18:32.2608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPa9lHVAJDURoqBP+0mt95aCrZpP/VMOxwbY+BTjvj9NOlL/qDgKgii6ah5R9b+gcJ3XEP6TYQjZUE5o0HioTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chen Yu,

On Thu, Sep 14, 2023 at 08:09:26PM +0800, Chen Yu wrote:
[..snip..]

> > 
> > So despite "reserving" the CPU for p1, which is likely to have its
> > data still hot in the case, we would have scheduled p1', thus
> > defeating the whole purpose of reservation.
> > 
> 
> I see. So you mean, although we reserve the CPU for the wakee,
> the wakee might not choose its previous CPU, which is against our
> goal.


Yes, but only because some other task could have run on the previous
CPU. That other task could be something that was woken up on that CPU
due to:

1) wake-affine choosing that CPU 
2) newidle-balance pulling the other task on that CPU
3) !wake-affine && that CPU was also the other task's previous CPU

It could also be due to this wakee task being woken up on the waker
CPU due to wake-affine.

> 
> The reason to prevent the wakee choosing its previous CPU could be:
> 1. wake_affine() choose the waker's CPU rather the wakee's previous CPU, or
> 2. the wakee's CPU has already been taken by someone else, via newidle_balance().
>


> For 1, I think Prateek has expressed the concern. One mitigation method could be
> that, we give penalty to that wakee, if it decides not to choose its previous CPU:

We would be penalizing the task for something that the scheduler
decides :-)

As you point out below, in the presence of the WF_SYNC flag,
wake_affine_idle() prefer the waker CPU over the previous CPU when
they are on different LLCs and when the waker is the only task.

This strategy makes sense for two reasons:

1) The wakee may be consuming the data produced by the waker.
2) Since the wakeup will happen on the local CPU, there is no risk of
   task-stacking, exactly what your SIS_CURRENT patchset was
   attempting.

But this strategy would also result in increased task-migration. Which
both Mattieu and you have found is not so beneficial for workloads
such as hackbench. Is it only because task's data is still hot in the
previous CPU's cache ? Or is there more to it ?


It would be good to confirm if this is why lower migration is better
for these kinds of workloads.

> 
> "
> new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> if (new_cpu != prev_cpu)
> 	p->burst_sleep_avg >>= 1;
> So the duration of reservation could be shrinked.
> "
> 
> For 2, maybe inhit the newidle balance, something in my mind:
> 
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12022,6 +12022,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	u64 t0, t1, curr_cost = 0;
>  	struct sched_domain *sd;
>  	int pulled_task = 0;
> +	bool cache_hot = false;
>  
>  	update_misfit_status(NULL, this_rq);
>  
> @@ -12055,8 +12056,19 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	rcu_read_lock();
>  	sd = rcu_dereference_check_sched_domain(this_rq->sd);
>  
> +	if (sched_feat(SIS_CACHE)) {
> +		s64 delta = this_rq->cache_hot_timeout - sched_clock_cpu(this_cpu);
> +
> +		/*
> +		 * If a short time later, a short sleeping task will be woken up
> +		 * on this idle CPU, do not launch the newidle balance.
> +		 */
> +		if (delta > 0 && delta < this_rq->max_idle_balance_cost)
> +			cache_hot = true;
> +	}
> +
>  	if (!READ_ONCE(this_rq->rd->overload) ||
> -	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> +	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost) || cache_hot) {

>  
>  		if (sd)
>  			update_next_balance(sd, &next_balance);

If the benefit that the workload obtains is really due to the data
being hot near its previous CPU, then this seems a sensible thing to
do.

It would be good to confirm this. Let me get some IBS data for
hackbench which is the workload which likes a sticky wakeup.

--
Thanks and Regards
gautham.



> 
> 
> > To be honest, this isn't so bad, because we have been able to avoid a
> > migration in this case.
> > 
> > > 
> > > Or do you mean, in select_idle_cpu(), we will re-check p1's previous
> > > CPU but it is skipped due to cache-hot?
> > 
> > I had originally thought about this, but then as you pointed out we
> > have an opportunity to pick the previous cpu in the early checks
> > inside select_idle_sibling().
> > 
> > > 
> > > > Have you considered recording p1's identity in the
> > > > rq->cache_hot_sleeper so that in select_task_rq_fair(), we can simply
> > > > return the previous CPU if it is cache hot and the wakee is
> > > > rq->cache_hot_sleeper, thus avoiding the whole select_idle_sibling
> > > > scan.
> > > > 
> > > 
> > > Yes this seems to be donable, and one problem would be, if there are
> > > more than 2 dequeued tasks prefer the same (previous) CPU, which task
> > > should be the rq->cache_hot_sleeper. And per Mathieu's feedback[1], we
> > > want to deal with multiple dequeued tasks. If we record all of them,
> > > it might be costly.
> > 
> > If there are multiple dequeued tasks, then it doesn't make sense to
> > record the identity of the tasks. However, we need the bail out to be
> > much earlier, in select_task_rq_fair(), perhaps even before the
> > want_affine() checks.
> > 
> > After all, if the previous CPU is idle, and its cache_hot_timeout
> > hasn't expired, and if the wakee's sleep duration is less than the
> > cache_hot_timeout, why don't we just pick it here and be done with it?
> > 
> 
> Yes we can return the previous CPU earlier, one concern is that, should
> we honor WF_SYNC flag or not,  because in wake_affine_idle(), WF_SYNC
> seems to have a higher priority than available_idle_cpu(prev_cpu). Say,
> if the current CPU has 1 running task, and the previous CPU is idle,
> wake_affine_idle() still prefers the current CPU.
> 
> thanks,
> Chenyu
