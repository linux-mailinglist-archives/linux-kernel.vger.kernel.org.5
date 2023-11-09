Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12147E6CC3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjKIPAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjKIPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:00:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8293588
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699542015; x=1731078015;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rlC0z7HSBPocvCE4M4HCr4JaDyw1m+YF4V4zfsEHocs=;
  b=mU+a8wc0Lp7C5nP4h242vEzZ8MNZXjGfMZ0r9Hx9i4PAuHR0sSgCfWvb
   zhYC8Q6HgQyQvg2wRZ/AKwPbgyDVwNx3Bou4V1r6MYiB1NNkRDyYJ4G01
   YOFbETRUMiNYx+7EP3mJhsiUPF/HabBrGiw5IuWk3rYtcfcWq3Ps+nxUk
   YmowYRkxi7Irbs21bJX4KbQtgC2seHgcKCoNUDofq6QORlKyvULVzZR03
   7+dGNC6ZL2Jm2YCUMvHmXodXVPadCqSmvkf9mIiiQenURJOME09JY/Mny
   zt0B5y5eL5vawQKjocTPFJjNGhmb6HOrXCFo6ueKDBj2F1WhVX3wXQOOq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="454301087"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="454301087"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 06:58:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="4562021"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 06:58:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 06:58:22 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 06:58:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 06:58:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 06:58:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCSKGTJwl06wq1TjHf/kj4MyHq7MaulKGzuZOQFgIylpmfZbnx5afm5G8GGU1kisZU3FQ3SvgA3NnLY2wGJ3lhO0BPA0ivKoilCUAgQKLnSr5l6e1KrTDZH2XIXtUvDsrSw6dRgXBKSS6Hbpoajf1fW+KazqItEBjQ26UbE9RdRZLTm26qCqTAMJm7m3TwvwWiUKKcsbfQeaAPcohMYJEiYJKG004EXlpFk7NiSphQzf9sk3ZD1upo7uK68o2TrWSAI0WV4xGEb7lpD3s/e0OpYx/Ou2xcEowBI3XxZOqRf3T8cw2r7EhXoNnowHYXu8/a0ieOUVpe2/tJLU2U2h9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sx3NyNb+Ymlz6CGQio2SrmNVN+jdKNIlYzXDrZDR5do=;
 b=YPBKpA9GxmzUHBF3gXwTQT6HpxaJulSAy9GLeZfs4GJn0Lasl3y1rFTFrDxZN6YsTH8tI8eUTRt3YfBIT2CjyEXt6pRU8V/ddB3X4GzLVrxNr5Mrj2xaLPfXKt+ReJ4hgxVp0vllcZHVmvHEbSqYh/0S8YstUccBQ7EfX3zuvBzoaM8Z631LmgOKJZEpmGCJ4M+ep1/yCJ5emiymArWH+lLX0cwWVaRIrL4g9tbRrV6uxyiYhAZNKK73ImKgdhTA8rid5nsQ4iyPRQoYPQSyuCmxUkmO3qcnI+gI15xQiRj94/dHBUs9umKXKc+wHZeXA805fE0pIILzuuiFBptjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB5789.namprd11.prod.outlook.com (2603:10b6:a03:424::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 14:58:19 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e%4]) with mapi id 15.20.6954.019; Thu, 9 Nov 2023
 14:58:18 +0000
Date:   Thu, 9 Nov 2023 22:58:00 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        "Tim Chen" <tim.c.chen@intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH v2 0/2] sched/fair migration reduction features
Message-ID: <ZUzzeEptTlgalJIc@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <85b710a9-5b26-b0df-8c21-c2768a21e182@amd.com>
 <909fd5b2-a1c6-49cf-8efa-c71affb1a4fe@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <909fd5b2-a1c6-49cf-8efa-c71affb1a4fe@efficios.com>
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc31292-1738-4160-c595-08dbe1344f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxC+fgByb8vudq4VcNzHSJVr7yujgUGXEBEA02Y7A9IYYdSTb+ahD+vQsxLlRKi4NjNKeCRCIzpU6w2gJLQO2B7Y9i7NpTREkthXVrDEAUpKTANWnhisPc8tfPe4Ka5uHp498W47YEmeC8X/4JPLC7Cd3gRXIfwC/O9gsxvgGrpTqjI2F8FkcnD/HoXsUw1kLLGHQi8dxHByvxH8sA28RO/luxAN51nrpmNqpm8WaNtkxOrK8LpQMhEOYEsiqSkfMHwr7nfclry4/fcfJZuGWawcnONDe+o64/E3l6gDH2ZVV16TP2ai77eeH5qLABn6aE9ga+uxw3ZEu/onjFcB32S+RR/GpbzMQM+Ph/7HowI2FitaBU9A85RoyOCeOv8GzbEb4hkay7dLbdfanfapacT+pA4G+gJV3t8kaEHqcuAyz28nXk5V7Y61nMJVNGYTHCNBMAPqRl8mmZYW3mNpfChQhxmCYnnz8FKruAHTTCoSDkSsivNJpQqqyaBKikZ1lVvARalQbdeWTifkbf3gyb+rPCBb68KUStGLi4DGwXUmTYsgrgKtIoIdREZWrQ56
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6666004)(6512007)(53546011)(6486002)(6506007)(38100700002)(82960400001)(478600001)(5660300002)(2906002)(4001150100001)(7416002)(26005)(83380400001)(4326008)(8676002)(86362001)(8936002)(66946007)(6916009)(66556008)(41300700001)(316002)(54906003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GBSenvo5aXaLfoyY1sJofw56iHAumm01Nayf55TJ/9LQyT0GrMA27OgVGQBB?=
 =?us-ascii?Q?kmL4YIsjsX0LAgU4/zHUy0JJBc7xikaj6wJWMlwDqtQ5Qm89gky6xYoUwnk3?=
 =?us-ascii?Q?asMuEVOdrFIYxB6YrZtzxApDkb3j38rnm+K808Odo13TB7NjJLRKLpimv7Vg?=
 =?us-ascii?Q?lpv8EWFE4URXNVSZ+F6mlLf1U1bKul1ODIa5U93bwZHrf9P6/+TaTv5Cj9By?=
 =?us-ascii?Q?gnytJEyrU/ngkJc4q6m1VDo1CwNkxGW18nWfhxNw9C0c74zpWAhk7rvb2esV?=
 =?us-ascii?Q?6vfbYaDIVZDTnSLTP67iNSJ09S8YhezKsyJVxeUSZwQAbuhlGzUd1HjrJnSR?=
 =?us-ascii?Q?VbjY8BJ137C+Evvztb0fVSGOBd0VPkTOuFGe0EXeEC7DmKw0JgagO0c516BE?=
 =?us-ascii?Q?FB9H/UzTJ305Az1Wx12QLrlrrB/wzjKTW/nvj3ODveXtdLHFTAWc+/PHvvtO?=
 =?us-ascii?Q?YiRecjgXRxgpiB1Id9NFhCczTKanJG+vQ7cI6oWQZO57RwRvD6c53ofCKSDD?=
 =?us-ascii?Q?pGpWa/TansYI16MBMgx7J2Rvauq0PDf59i5u0bT6cpuktSIhILkgfzYAr3EG?=
 =?us-ascii?Q?m4iL+hzDKjmK4aEWKpyWd8dcBS3SY1L2m0axICJxERbiIeSaKCnYXJzO7vpS?=
 =?us-ascii?Q?1VAkg2YFXXMkLGEFtY3Ta1JDK5XcW8+Pc46PVAbw7Ok11dfs+st6zj1iQ1Xz?=
 =?us-ascii?Q?ZS5OeAZRKP2n/I1ow9majt6oRu7Enu5w7O91p+YaVwsvRfM/NWbOYDu7rYq9?=
 =?us-ascii?Q?jNkViOzwN0qYpPI1wVS5tRUqpLK77QnZUFzjI0HGx234JcYFF4ni449+ciBh?=
 =?us-ascii?Q?KrN1MhV1lc5KzQTRT5ZteqDz1Ma8l11j4VxqWUDf/ltcaHvFr0wtvE8JWCbQ?=
 =?us-ascii?Q?7S/B/e9kv2Hp03DSQUaDjXaVPDBts3A/eqsDakerLELAok2W1+7b7dEK1TLw?=
 =?us-ascii?Q?Ok8JXMaHhtJQaPSlVRZUMql/oTtH81zgiGUwrUgN+xFjB2m8hQ/Ys1G70Lre?=
 =?us-ascii?Q?wZmlFiNV+hh3LOjFdEc3dE2wFgLjPubwwKjiaDboyA8rlrXHVmvbfKCCTdrc?=
 =?us-ascii?Q?KgJL8mObVE4zwKHXHo0kADmVRgUMEpiKzGGndZpP7B7vvd8/nbeN0jfpTdc/?=
 =?us-ascii?Q?8y6y7onipn9zhz3EBgpwJrZe7WtYSHij5COgFo2KfuZo8v9xI9B7lLWH0tYv?=
 =?us-ascii?Q?JGcW3AMwYfor7Wa4zszi1AZ39vYloCc151oj84KRYUdBHkCCelxErvFMuqfC?=
 =?us-ascii?Q?yzPijFBipIV8Fy2pxNAAJNg2ByKcYX0hG1oesmIDOHZoWucU0mVOExFMzG1m?=
 =?us-ascii?Q?Ll13J5L2gRtdWE2ok5zXz/F+BG38YNagwzLbHb/dwj+8yfKud1MeTYNtwdA3?=
 =?us-ascii?Q?4cPtpuu+5ZOfvnvimdaBcxz0ABoPJOUbqa+WkfvxKC2wB/89If97+Pjy+hFn?=
 =?us-ascii?Q?uSh0C3btYwHvwcWRijSr20wzFnXlQYePCzIRb1YJAxozL0y6Sjud+Ja30JbP?=
 =?us-ascii?Q?HDg1D3JiDEE1nwDmIFiG4uog+KkrlBagRtC5Bc5tmA6FdbGdmXi/+mBz4DHr?=
 =?us-ascii?Q?43Knwy4AR9+EuYR6ccJ6LO9R07elmqZDgKbI8L6b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc31292-1738-4160-c595-08dbe1344f2e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 14:58:18.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dNniE1Fp5r7ES+PiKlihbsypeyItmYjKDcgkCKP+bFjjELRs2Ibvmhu9ueNOb+mPzIhzESy8eyqOVOmAoLgDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5789
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-06 at 11:32:02 -0500, Mathieu Desnoyers wrote:
> On 2023-10-26 23:27, K Prateek Nayak wrote:
> [...]
> > --
> > It is a mixed bag of results, as expected. I would love to hear your
> > thoughts on the results. Meanwhile, I'll try to get some more data
> > from other benchmarks.
> 
> I suspect that workloads that exhibit a client-server (1:1) pairing pattern
> are hurt by the bias towards leaving tasks on their prev runqueue: they
> benefit from moving both client/server tasks as close as possible so they
> share either the same core or a common cache.

Yes, this should be true if the wakee's previous runqueue is not idle, at least
on Prateek's machine. Does it mean, the change in PATCH 2/2 that "chooses previous
CPU over target CPU when all CPUs are busy" might not be a universal win for the
1:1 workloads?

> 
> The hackbench workload is also client-server, but there are N-client and
> N-server threads, creating a N:N relationship which really does not work
> well when trying to pull tasks on sync wakeup: tasks then bounce all over
> the place.
> 
> It's tricky though. If we try to fix the "1:1" client-server pattern with a
> heuristic, we may miss scenarios which are close to 1:1 but don't exactly
> match.
> 
> I'm working on a rewrite of select_task_rq_fair, with the aim to tackle the
> more general task placement problem taking into account the following:
> 
> - We want to converge towards a task placement that moves tasks with
>   most waker/wakee interactions as close as possible in the cache
>   topology,
> - We can use the core util_est/capacity metrics to calculate whether we
>   have capacity left to enqueue a task in a core's runqueue.
> - The underlying assumption is that work conserving [1] is not a good
>   characteristic to aim for, because it does not take into account the
>   overhead associated with migrations, and thus lack of cache locality.

Agree, one pain point is how to figure out the requirement of a wakee.
Does the wakee want an idle CPU, or want cache locality? One heuristic
I'm thinking of to predict if a task is cache sensitive: check both the task's
average runtime, and its average sleep time. If the runtime is long, it usually
indicates that this task has large cache footprint, in terms of icache/dcache.
If the sleep time is short, it means that this task is likely to revisit its hot
cache soon.

thanks,
Chenyu
