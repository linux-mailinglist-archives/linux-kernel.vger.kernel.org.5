Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA1079DFF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbjIMGWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbjIMGWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:22:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D3B1735
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeTWaPiRhv1WPPRKNoAtuAny1rAEsHlRwYWVUAnXdJYzOKJ0jOKUxghyaQ8wq176h704ytW/bAy6TWsY3rvNpBvgOD0ed8WDzsqAdSl+5afRAAXxt2JBeV7So3bqtESpdiPsD9nlw7IrHwi2B4Jp6iFZAfu0Tn7CHYDaHNiqypKjC5QhFAGrk1JdAmMwpV9qIqY0GBaE8iUmjC9tfoDojQytRxBE3Jui3OP/16YYG9371oPFXyUEB3jWatFWWsKGpJLXiK4ZAvFDo0a66zRWhHbcGl75yQ6hxWUwvo1R6B71q877vgIty//JuBD/I+QO7YN3acBmW+rbJI9LACBydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEYgBdG+JNnaHPUK8yqvu6F1XkzL9Ydu1oIWpjcXpLQ=;
 b=Aitcr/Q5o2mnXBgiFzKn45R6NrQJ+v95vJNFqas/lnOJ08UlWBUBKqn5dcpUvaKwInUXDEjC7qEj5eUOBa0Q9ksDFBj4fJxrCuVx1NGGsLonDc7VhsQn9n2UdMDp6HV60WwZPwfqumk4AIq7ZkWkGjxrX1Qh259rj2O58rAM3eUhQn7U4KSfQLy0jdOCqCGN4B0Yi3qf6B5/s0qkJcGY89h5GjoO12bBtOEBC24UG/JQvAoBscHsvW0u6su5VLUQ1XgK3tYx3Bt581eV3d/SZGKip1E4KK3pYDe+AZrdp6yL0Q/BEwkQ9zwkOhmz8Hd9aIBuuoq2kZZzdODlGFwN/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEYgBdG+JNnaHPUK8yqvu6F1XkzL9Ydu1oIWpjcXpLQ=;
 b=oL29vqGjEGW7PyXEeH5OBBvlH1/GKREABiMmLBYxOYNYZc5/FcwIuZ3/n/4PpskaYlgEzAZjzQeU5UGa61aZ98tEOZ0N33N3TeYwTzqXQcyuBMXfsYQnXop3FYElUhhldpB5nIxcTXXVqf+0I5q5swSasYCAI1BRqEtqq8bQh+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Wed, 13 Sep 2023 06:22:28 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6769:d6da:514c:90ab]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6769:d6da:514c:90ab%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 06:22:28 +0000
Date:   Wed, 13 Sep 2023 11:52:14 +0530
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
Message-ID: <ZQFVFv4GcPOU+X7N@BLR-5CG11610CF.amd.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <20230911072629.GA298322@ziqianlu-dell>
 <ZP7SYu+gxlc/YjHu@chenyu5-mobl2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP7SYu+gxlc/YjHu@chenyu5-mobl2>
X-ClientProxiedBy: PN2PR01CA0202.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::10) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: ceadd5ff-3a5d-4513-c617-08dbb421cd65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8O2fm5hHlqZCD2XVQ6PQMtDiicKsxodY5J2wuDyA5aSd6xVgJ2FJz/et2YiEecJx02O5liayW4pyFsmEgaPgzmrt0D2yyvV+oVyL9gtOwNNijdrlWOZHlDp0JtZV1DDAo+W/gPPkomozMQdPnWosqHcOcPQoyGCVP25IqKs5ikeCoGHJfpp74RiZjQixee51YCWf4T/wWeUI2PcI1aJi8dyV5Sou7PtcCiJyMLqarIG8q1owI5TKKexgkO9CoG/Bnk9B9pcuswAPgK5TQASRVuj2anVMFce8peZEXWtN2tQ+vreo+oFG0yoFF5OiB7PKl9e//gKNeoCYBHprz+zotd8GsBtrQbAxYlKZBRf6k9CUBwdJmet8wn0VWsvq8Aq1Ss9vB2h4wKruCI7NL4kXprodRjct0Rl7crH2KAcEfQ8ETZrT+eX9v7Jbdk3u8a48LRLA8wAL2oaKyOafZRGtLyGjuFrIE39LPBrHXohwKUnpHk9eVPvNcrd48wO1ug+A9LS52VgnB5OzvcEx03e9qj0AplvJU3dkbacBqZ1IbRHm9u3GhmOfqKwt07+ikKL9nw0HqywoLHImgUP5Qdexx/wq3liKQ4s0d6wBNStKJEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(186009)(1800799009)(451199024)(54906003)(66556008)(6486002)(83380400001)(6666004)(38100700002)(6506007)(66946007)(66476007)(6916009)(316002)(478600001)(6512007)(53546011)(26005)(41300700001)(5660300002)(4326008)(8936002)(8676002)(86362001)(2906002)(7416002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nI4+jJqGHYtJVEXY4MUNjr01O6TbyumXbYtZhqPfQqTcLZlvTlsfxdzS9eEb?=
 =?us-ascii?Q?BvYi8fK5b93PBZffx+2zL2Zicw9easEi0lUZgzA71LW1MK0C8nzR7OAYh3wm?=
 =?us-ascii?Q?ryYe1lBFCC5GyyFK4aIkkS9PnqWdeEwIh3dq5barxnfRtVdUr6uhHTmlQRGL?=
 =?us-ascii?Q?dIbE6wrhlcgWNgyv2LKtn1799B76nmlzwk3Cnm078J3e4R1/KIJG32Yjkisn?=
 =?us-ascii?Q?EbVvY8HJN0jAV1lFywpAscgFHZ/Oa9ahRgEQrBTTNoxyWRHiDB/w3X6M6EV7?=
 =?us-ascii?Q?k5ALQGxTTWESBSr+RX5wjcXEYKa9/t/qx0vlbk7EB3vU0kQX1R2kEEIRGF7R?=
 =?us-ascii?Q?fx27j6Mfjp/ojIk5HqTPVIFEdqxpDQt/S55lVIViJo9vYr5T5NiSTUrRvWgw?=
 =?us-ascii?Q?ERCPvocfsXaZn1vhep9nhiU6InMrL3C++LdtPCiXqQ5tIq8FY7yOCnbuh6Kr?=
 =?us-ascii?Q?SFNSDGevy/ELU6cX8aV9HNgNIln0b8uJhoMLwKZYJfbWCtI1EvOahvpCwvPD?=
 =?us-ascii?Q?VNIwT9yPxj3htMOFgrDgJwmetwpsqXjIL83bh/EPenoXyokR3DcB9WcnRH7z?=
 =?us-ascii?Q?NEbY02x4YbLb6h3Rljj8hc/b/rYAOApZoAoSrmnf1pPTPVIXkMH1ATwTrING?=
 =?us-ascii?Q?f3zixzmfmz4SEjlsNkx3lROOS29HvnT4Pxic6Fwkha4rhOWJMnXwDW6G9S1L?=
 =?us-ascii?Q?SuE/HVss9Ajui5UwtJ8oxwzRQwNYZEU4wiq6I1V3T3fHkJxl/4xkR5s8bFxb?=
 =?us-ascii?Q?MklxYd3EHGKRLe0m7ewjwl6ChElu2brSNMkmCNTLkhFl3eB45CAv73tkIYYy?=
 =?us-ascii?Q?iPWTP8N5Ho09MN+8O/I7gUfcvBjvhcrLiBt4XXxlMjsH3IDSh+/x5i75AjGr?=
 =?us-ascii?Q?ywhkEDxy+Ur5srWE10X8xeULAWmeCMKCihf+Od6XsyvoFo07fzjMDngCR4fv?=
 =?us-ascii?Q?QlVVZ5YFtzw92rrW9VR3xYtrvyh7Bz7/jtbsplfhh+uhwM8waFnV/pCKduGp?=
 =?us-ascii?Q?/rMVW/Di+gtcn88xHcaZ8MecACBVpU59m5vkUOZJX+sch2ijnoiZ+CqG/tUA?=
 =?us-ascii?Q?EALSBPyxm8V+IOjRnUiniyEwAbZ2Mn9VkyahAbMl6eXb5CxSAU5LZRWZ2oP0?=
 =?us-ascii?Q?eKTwtZt2ryxFlP59GIv53686lsLymROHkL38IIzZZniKYF4PVm2QJu1RdEtr?=
 =?us-ascii?Q?vjkrGUgRmAwvb7lqF/mqMVzYWAzVCzdUIhd8va2yNkWVkcOg/hPlTbiwT4ro?=
 =?us-ascii?Q?fK1hMF3d+oPjeUlCr2mAU1GW7YdOR33KPG1vD2XZuXU4FFxGY1kx7Dz0NWgA?=
 =?us-ascii?Q?8mPwLYgvgHb8Xd9U2QlRM9hz3uVKWdhNOlOPnYEIXbd6qgqZ4JRbulD2RlXS?=
 =?us-ascii?Q?/8tjpWixA+ibaHAPrpaYqiofr02/sjFgKbTOV8ylQAgQep/Jc8GgAZutEcAX?=
 =?us-ascii?Q?v9JQtgyjlTE9MkxqB96WK08ob607uJsnGV7NNg1H3hCKq0TWf38QDjA+NxKY?=
 =?us-ascii?Q?KxSWI7xlQLCkbCdEyA4XitmHhe/mUVDMsUveuKwK3ju0wyioIqRnNuXaQxzs?=
 =?us-ascii?Q?V3dAae/OlFXK+1LaZo1ECrRandioJMZ1UlE5EJQw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceadd5ff-3a5d-4513-c617-08dbb421cd65
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:22:27.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L18u348KgOUukrbnvOfNoEK5NkUAwYqV8tXhiAaJcZUweouDgJuWpAQKqJmxZ0Zirs2ifilNbQ1ggU7axNZS6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:40:02PM +0800, Chen Yu wrote:
> Hi Aaron,
> 
> thanks for the review,
> 
> On 2023-09-11 at 15:26:29 +0800, Aaron Lu wrote:

[..snip..]

> > > @@ -6982,8 +6997,13 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
> > >  static inline int __select_idle_cpu(int cpu, struct task_struct *p)
> > >  {
> > >  	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
> > > -	    sched_cpu_cookie_match(cpu_rq(cpu), p))
> > > +	    sched_cpu_cookie_match(cpu_rq(cpu), p)) {
> > > +		if (sched_feat(SIS_CACHE) &&
> > > +		    sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout)
> > > +			return -1;
> > > +
> > 
> > Maybe introduce a new function that also considers rq->cache_hot_timeout,
> > like available_idle_cpu_migrate() so that above and below logic can be
> > simplified a bit?
> > 
> 
> Yes, that would be simpler, I'll do in next version.
> 
> > I was thinking to simply add that rq->cache_hot_timeout check to
> > available_idle_cpu() but then a long sleeping task could be forced to
> > migrate if its prev_cpu happens to just deschedule a task that sets rq's
> > cache_hot_timeout. I guess that's why you chose to only change the idle
> > semantic in select_idle_cpu() but not in select_idle_sibling()?
> >
> 
> Yes, sort of. And the reason I did not put this cache hot check in available_idle_cpu()
> or idle_cpu() was mainly because these APIs are generic and could be invoked by select_idle_sibling().
> If the task fall asleep and woken up quickly, its previous idle CPU will also be skipped,
> thus no one could use this CPU within the cache hot period, including the cache-hot task
> itself.

This happens even with this patch right? It is possible for a task p1
whose avg sleep time is "t" to go to sleep which causes its CPU to go
idle. When it wakes up after a time t' < t, the logic above skips the
idle CPU because it is still cache-hot, despite the fact that it is
cache hot for p1!

Have you considered recording p1's identity in the
rq->cache_hot_sleeper so that in select_task_rq_fair(), we can simply
return the previous CPU if it is cache hot and the wakee is
rq->cache_hot_sleeper, thus avoiding the whole select_idle_sibling
scan.

> 
> thanks,
> Chenyu

--
Thanks and Regards
gautham.
