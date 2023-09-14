Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2B679FCC5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbjINHHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbjINHHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:07:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E30CCD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:07:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcBvTN7RK5ngjtBNt0NJBni95yXenbi6gw6Txuoifw0jjJ+RtpJtymtXrkMOHH3dPcOoFPrXI8RW8ZM7idV9OACL2K4OwtVPdcNFI7uUbp/TfklntMZPFRPyFAziKRpTyDY2iEdy/YDFFv4Ql9hsuU54cAY5oQkePya/VUv7ipgkDuV8t1CPXjCW6+hhLal2v8xPaE39k7A7ihZsOPElZUB14mWS+ttBRWKmN48iuM2IsenJwBYujkZuZ5GP+h0r6PnaMMeCxwXm8cTBM7BqmbHN7Kw3rTOK6Ek/3slfGPL9w6X0uUD77zwNj55wQwF0m2PsoF42Dd8sy3umVSdGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqsDBbnZOKbh80022LJQ2H0pbGVs6cPYq0JFU0ITyXQ=;
 b=Ucg1tCoxlhq2QdL8LGIjKJayzhIaoRlKSUMwZ3eFDv21R4mKnH476VVsP6fYl9s5U0a01fnz926gvjIdcKk7oNlp1QkCLL/AVXGubpQ7xptPc/SCZNCWJEcBowiqlu7Nvo+aYBjWbVFVgXBLwTaJ1RNBBSm1EOqJZb0bPYCv9aoXjIkHgvIq6TwJUk6EKh1RMIR2ci8hdwHVIH0TE02ZnzO7155CSHQx6WG055Yeorjeuu9mD1jJUIFPskPhwBU3q76UPDt3O/oh/Mg461C2wTkTLY6SV/xOL0ybH8082enFGHx2AJlHaxeZ7AH/iMBNCn7XMR5wgLC6ux9tpSPw8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqsDBbnZOKbh80022LJQ2H0pbGVs6cPYq0JFU0ITyXQ=;
 b=5QptD84+DhF05xyvlsJeDdppAaJwkxTB4lIrQ29Oqs2FmdKqyLZcl03cQPOmUbLvvxDb6LUGhwX2zYyHZoYXJPoKd7SYEzdGQ0qhrZF0a4GFyW+OQLi+xSzHApH7Xb45MqHWP5zroI6BuhCxoIG6+XhFh3vyV+S5OH8ovEfLGtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 07:06:59 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6769:d6da:514c:90ab]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6769:d6da:514c:90ab%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 07:06:53 +0000
Date:   Thu, 14 Sep 2023 12:36:33 +0530
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
Message-ID: <ZQKw+W7k+XNweKBu@BLR-5CG11610CF.amd.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <20230911072629.GA298322@ziqianlu-dell>
 <ZP7SYu+gxlc/YjHu@chenyu5-mobl2>
 <ZQFVFv4GcPOU+X7N@BLR-5CG11610CF.amd.com>
 <ZQFj2hk4i1QAWEQp@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQFj2hk4i1QAWEQp@chenyu5-mobl2.ccr.corp.intel.com>
X-ClientProxiedBy: MA0PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::19) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1c7c31-f902-4463-78c9-08dbb4f12c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zZ7yNFZxxqNhJeJ3Xg6nsbQ87t/OdatQJTIwu1Dr/lvG+lajxwYqi4abVtJFq5oUIzeuckXHLGBebiCwbMS1WyxTV+dZFfYjVzYZD5IC50/epR6QLWmStolfLvp6fJU8UDc1zBXM6zeYggi7MZ07cVADo4ilYp0K8Fx0gUYJqhe7ZZbRmAn1ZVzAIYHAoSnclJzmNiCPc9+2WU1soK1i6Fyghzeh96aHbrIpGZC/F7lIW4k4wHjJfc3XXwQwmJciTadsA3u0cq7E0Ptniz8hbkCtnNdeWlDRtdIA9W39ozSYo5m2qc/XKf958go11i7nl0v790kIL2RkFMOZxdmIxGiQ/qBLYCpxy3DlO4j8Py1C2aJhJXdwySGNoQgk1RG+BXs7U5GyZ2f8Oip4FKkqczENnion35vaI2ukCWAj2l08TrUIyLLrUFNPEi5O+6tegWQDWmCezewXe1UPbkORW4VVN18v4brhh17C9rrPd39627NUoB+eYDb3unZ8ggM0YbHkL08Lp0hk3AZMK5nrXAtImIwa8QXnxD3rBDLO0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(1800799009)(451199024)(186009)(66899024)(6666004)(55236004)(6486002)(6506007)(53546011)(86362001)(38100700002)(7416002)(2906002)(6512007)(966005)(26005)(478600001)(83380400001)(5660300002)(8936002)(8676002)(4326008)(41300700001)(66556008)(54906003)(6916009)(66946007)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fMmnkhQmlCvxosgxwi82Lsub7jWgK/5iMCWmSFljRcYTBKIYS3I5zGQCZZc4?=
 =?us-ascii?Q?Gfgq59XjqsLQ0mTKNB00rKD2J4sGUrM/YYt09uV5XSbdclKOqLgjqbiZT4hL?=
 =?us-ascii?Q?bGowpMafldyuYK9traNCg23RfQP6dcqu79W5Cm4UWf0DjvbYsm/CqPuOePlt?=
 =?us-ascii?Q?aX5PTXCF1vRGFQgezzO4S9RquohGoH1uMSz9psXPhDBrfOcZoANkSgHIpWU0?=
 =?us-ascii?Q?5hXR6K0SZsYdxlro3cIrJbhxC3vmulmDtW9ggPXn+XC5Aln/GYrdIcM/qoI1?=
 =?us-ascii?Q?5THXbxoxub/aljAsvfwsneJ/byv7C2c85JxfRUI71c0/I9hi5ilGvt0TgWWa?=
 =?us-ascii?Q?/q1Kz7O1I/t+d/duZzx19erVjHGfym7kjhwqMZIdb9E1ETpkXoQiufrUxqQv?=
 =?us-ascii?Q?M//5HtSRRpnLAUdJtlEnqVVZWY50HPtWFVL6lSIP8ftrxHitGf1IShxFKQYR?=
 =?us-ascii?Q?fJlezmXzcPfvZnju/f6+S/z6Q+Tawzx9jBaKVdhS4Jxg5DCiZgr3QiVGzQEQ?=
 =?us-ascii?Q?Kq+VL46fhAJReLHXKssjt59g6Ig15BqecfDxi7SAzJS7A9dATvdcSLpJLgf4?=
 =?us-ascii?Q?kxoBExVudMxHfMl8Fmuk05+T6jKijs1czqCIXvt0L7HWYijOkPKNJ2ml/mmd?=
 =?us-ascii?Q?O+9UP8GVR3dTSH+n2+3jQo4XHrP9GlbiAJ3SIflWT1tlF1K6L6YHfQcmLfoO?=
 =?us-ascii?Q?IRD+JAuKfDhzkRl5rIZ+QGUOtGgNofzAx0K7nPRoDy15Obaykcd0IMZzFmge?=
 =?us-ascii?Q?LTZfryKqy9DT3uuk7SPdndwNBkw84WKIg5tjeIW7Fje08BL/hMvru5d51O/L?=
 =?us-ascii?Q?xW3layYiEGhBxrJIdNKvEH4EqbvRYUyiDSuNR8MTWf1rt+Snnd1GBCrdNfCT?=
 =?us-ascii?Q?z14JVpDP52CPi99SRhMCP19dhGr8mxDLyDK8rAaezo6p1LtWN3NyLGarUebt?=
 =?us-ascii?Q?5VZ9puL5lRdqdO/NRAxYpqDmekK8Sor0nYHwQZ2plgO0ix8ad4P8yjGe+Qmq?=
 =?us-ascii?Q?E4gKeQbHUicpTo2aXC2eh9nTmtyH7hcvd41T8B+aSHtD2bdRwqIxyZteKAhN?=
 =?us-ascii?Q?e2e21RS5uG2S90wYGJUEmUq9r9/4901ihL3BD8oKDG1F66y1Lcek7vdKoQA6?=
 =?us-ascii?Q?PAeHgDPBP4v44h0VQxUZXA6zT5ziOBAh3F4YdYiBf9V2NUti67tgG4/Rzzlx?=
 =?us-ascii?Q?J8n3CqsZAXF1hY0uz8L7TlJ16MZ2xKQDDswrp43Jwsz3rRW2OE1u6+FiNzU9?=
 =?us-ascii?Q?UDQvUeCb5DkXQa9WZtkGjxy/BqYr2uExX3nTFbCQlo8nUX3eoMljh6C4L/1L?=
 =?us-ascii?Q?EOmwgtSqZJ4IzUVd+3cxBRAdgcDoIRCSNRSZePGRtW+i2mvlZ7vxQCu7Ip16?=
 =?us-ascii?Q?AAxM718TjIN22G/HpvZo4SODIfvqIid8bCJwBxFtbiiQTx6eHa0ZMxt12e4Z?=
 =?us-ascii?Q?YKIjOR/uuF3kiBs5vWTwekQwPrbpifqNUTzWquHimBggjkdx2sf6C3ccRQ9r?=
 =?us-ascii?Q?PbPNQbD5MhDtqSo2XoV3iKfijCbj1zCzX9xxHKZB85yRgolktqRMcxkWY4vX?=
 =?us-ascii?Q?YoV7c8jdMMqkjBS/b8vcbo//dqBWMlLu47nD+clf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1c7c31-f902-4463-78c9-08dbb4f12c3f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 07:06:52.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yf6V9QgdKlbF1e/iHWppFyLL40pvf0p4ZFcLmvfPVRfXt+V9XLAxEQ3Z0sViY/QqBwkGjtcxG/lwHHIcKiEPHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chen Yu,

On Wed, Sep 13, 2023 at 03:25:14PM +0800, Chen Yu wrote:
> Hi Gautham,
> 
> thanks for the review,
> 
> On 2023-09-13 at 11:52:14 +0530, Gautham R. Shenoy wrote:
> > On Mon, Sep 11, 2023 at 04:40:02PM +0800, Chen Yu wrote:
> > > Hi Aaron,
> > > 
> > > thanks for the review,
> > > 
> > > On 2023-09-11 at 15:26:29 +0800, Aaron Lu wrote:
> > 
> > [..snip..]
> > 
> > > > > @@ -6982,8 +6997,13 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
> > > > >  static inline int __select_idle_cpu(int cpu, struct task_struct *p)
> > > > >  {
> > > > >  	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
> > > > > -	    sched_cpu_cookie_match(cpu_rq(cpu), p))
> > > > > +	    sched_cpu_cookie_match(cpu_rq(cpu), p)) {
> > > > > +		if (sched_feat(SIS_CACHE) &&
> > > > > +		    sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout)
> > > > > +			return -1;
> > > > > +
> > > > 
> > > > Maybe introduce a new function that also considers rq->cache_hot_timeout,
> > > > like available_idle_cpu_migrate() so that above and below logic can be
> > > > simplified a bit?
> > > > 
> > > 
> > > Yes, that would be simpler, I'll do in next version.
> > > 
> > > > I was thinking to simply add that rq->cache_hot_timeout check to
> > > > available_idle_cpu() but then a long sleeping task could be forced to
> > > > migrate if its prev_cpu happens to just deschedule a task that sets rq's
> > > > cache_hot_timeout. I guess that's why you chose to only change the idle
> > > > semantic in select_idle_cpu() but not in select_idle_sibling()?
> > > >
> > > 
> > > Yes, sort of. And the reason I did not put this cache hot check in available_idle_cpu()
> > > or idle_cpu() was mainly because these APIs are generic and could be invoked by select_idle_sibling().
> > > If the task fall asleep and woken up quickly, its previous idle CPU will also be skipped,
> > > thus no one could use this CPU within the cache hot period, including the cache-hot task
> > > itself.
> > 
> > This happens even with this patch right? It is possible for a task p1
> > whose avg sleep time is "t" to go to sleep which causes its CPU to go
> > idle. When it wakes up after a time t' < t, the logic above skips the
> > idle CPU because it is still cache-hot, despite the fact that it is
> > cache hot for p1!
> > 
> Not sure if I understand correctly, in select_idle_sibling() p1's previous
> CPU will be checked first, and that check does not involve cache-hot. So if
> p1's previous CPU is idle, it will be picked, no?
> 
>         if (prev != target && cpus_share_cache(prev, target) &&
>             (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>             asym_fits_cpu(task_util, util_min, util_max, prev))
>                 return prev;


You are right, but the "if" condition is the one prior to "if (prev !=
target ...)" which causes p1 can pick the previous CPU here. However,
note that it is not just p1 which can pick the previous CPU as
intended by your patch.

Consider the following case:

* p1' ran on CPUX, and went to sleep. We now update the
  cache_hot_timeout for CPUX based on the sleep-avg of p1'

* When the CPU goes idle, during CPU_NEWLY_IDLE load balancing, (or
  due to shared_runq search), the CPU could pull p1 from another CPU
  Y.

* p1 now runs on CPUX, and goes to sleep.

* We update the cache_hot_timeout for CPUX based on the sleep-avg of p1.

* p1' wakesup and picks prev as the target after doing wake_affine()
  check in select_task_rq_fair().

* In select_idle_sibling() it encounters the following, which checks
  out and thus returns from target.

	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
	    asym_fits_cpu(task_util, util_min, util_max, target))
		return target;

* p1 now wakes up, picks the previous cpu as the target. However,
  available_idle_cpu() is no longer true.

So despite "reserving" the CPU for p1, which is likely to have its
data still hot in the case, we would have scheduled p1', thus
defeating the whole purpose of reservation.

To be honest, this isn't so bad, because we have been able to avoid a
migration in this case.

> 
> Or do you mean, in select_idle_cpu(), we will re-check p1's previous
> CPU but it is skipped due to cache-hot?

I had originally thought about this, but then as you pointed out we
have an opportunity to pick the previous cpu in the early checks
inside select_idle_sibling().

> 
> > Have you considered recording p1's identity in the
> > rq->cache_hot_sleeper so that in select_task_rq_fair(), we can simply
> > return the previous CPU if it is cache hot and the wakee is
> > rq->cache_hot_sleeper, thus avoiding the whole select_idle_sibling
> > scan.
> > 
> 
> Yes this seems to be donable, and one problem would be, if there are
> more than 2 dequeued tasks prefer the same (previous) CPU, which task
> should be the rq->cache_hot_sleeper. And per Mathieu's feedback[1], we
> want to deal with multiple dequeued tasks. If we record all of them,
> it might be costly.

If there are multiple dequeued tasks, then it doesn't make sense to
record the identity of the tasks. However, we need the bail out to be
much earlier, in select_task_rq_fair(), perhaps even before the
want_affine() checks.

After all, if the previous CPU is idle, and its cache_hot_timeout
hasn't expired, and if the wakee's sleep duration is less than the
cache_hot_timeout, why don't we just pick it here and be done with it?

> 
> [1] https://lore.kernel.org/lkml/2a47ae82-b8cd-95db-9f48-82b3df0730f3@efficios.com/
> 
> thanks,
> Chenyu

--
Thanks and Regards
gautham.
