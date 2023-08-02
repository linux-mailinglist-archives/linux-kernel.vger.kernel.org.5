Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8C776C551
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjHBGcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjHBGcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:32:42 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2D62701
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7z6ianeSJV3HAzkq5NGXT9EQrCiDEPU2nKojEGcNqnY6w1pTZOAWz0Uh2IVhK4JqlSOvWXj1i5CwatiAzUVk8Ls59kkP7nm30VeUpiECOtHKUMqMRZi8PzhQXlhGuMcHKBU66oBFbMW4ipGemMyGvUWynIUCbYDC/XqMZTNcePXPSKGBt9hCasacSHgk8VgroeshC8Ei0h7GOcjDqUpRwdmBlkzi/0m3Z1yNLH7OmpH4MrehDhn+OQFciIBmNB9QFXbmW0ckc56SwjkeBkEJyKmyntabKvuyHIN6N6j2XUJUTuWRMoTwlUg0hoZhyjMr98Sw4IZDEX8Em5QIYVl0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKXdfsYSvXTmWoHiV5luMDQ4OlsNMxr+HQ+0bi0gZLY=;
 b=oVX7PdV62X8CRZ8v7o+DS6onoaMCBoEQBaZPJP5VidjexDGQp6pj/DPsdl4MT2UG/M34kg0KixtoC6b9ixcuX+psUtnuP/YdgY8g7tQ4ebCv6TIFeH1OxE7QcBOgGQSL4cu85oGJ/0l7lqpdAs178nFmbZAokL3/mOOJo8ZwHKMeQHagiMpqubOQLBWHDwuuo7rkHb0M+nLDbzWO2C1GmMLZloKQX0Enj62dGvCTL/Dh8v11W6fm87+CWnQNw75WOsht6JtPdMa4eHPBFjjWttbIcrwMdamrGsHDMvrhdiNE019cvmgJZxaRt3S6G8cqliCfCc/MGC9lOjB4A+CZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKXdfsYSvXTmWoHiV5luMDQ4OlsNMxr+HQ+0bi0gZLY=;
 b=ZjmSjhy1+9SvC+0+pK1IK8zL1BhgRK0JTZK71bhSF7qv8crS11Dnx6/YLsDsOWybyy1iBv8S7FcJr/72SByrbMc+PH9/8Eug3XaflHrLRXlkycpNSrl4NYDqM6TK/BwaixoFlXopEcKkJx6ICGvHJTIHFHEQugov1pSJUNTNgm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:32:37 +0000
Received: from IA1PR12MB8240.namprd12.prod.outlook.com
 ([fe80::f015:8b5:d77d:6fb6]) by IA1PR12MB8240.namprd12.prod.outlook.com
 ([fe80::f015:8b5:d77d:6fb6%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 06:32:37 +0000
Date:   Wed, 2 Aug 2023 12:02:20 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, kprateek.nayak@amd.com,
        aaron.lu@intel.com, clm@meta.com, tj@kernel.org,
        roman.gushchin@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v2 0/7] sched: Implement shared runqueue in CFS
Message-ID: <ZMn4dLePB45M5CGa@BLR-5CG11610CF.amd.com>
References: <20230710200342.358255-1-void@manifault.com>
 <ZLpMGVPDXqWEu+gm@BLR-5CG11610CF.amd.com>
 <20230725202255.GA13618@maniforge>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725202255.GA13618@maniforge>
X-ClientProxiedBy: SL2P216CA0102.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::17) To IA1PR12MB8240.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8240:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6a5b5c-35c1-4dd4-8d79-08db932242d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YCBtPhVmqTw8rwkcFJw/axhwFMXTb5R5zaWT+11L49xcOcRPFtw2T/dZeOlxay+AlTGE+ll5dSbbWoiUAsuqJqYi1LFuTTE8Ga5zHaECaVK85n1C886Y0zbhNd+Kc0AEkjb+Dcb9pvVwi4sAKnm6w1jlASoXs1TsHre0kg/y9YPqA8ko28aWUzkEhE1xIekxsoChLzId1CTnzyiyYf9TEbCvCk0+uq/wk377y7s4fwrgCOb66604sGgjd4nqVjsdsMtJbYUIGakY7Mrxvkq1U8C0T+yhc3dZ4GGJhkhvC6IO6hrHB/4PNUFt8xG4u9EAYmRtsIPTIPyipU21KJcQlwIVVStsb36GROJNIEWldSwn00DPE9GPCnmH2kL2SflEbPnU8ryaVJsS+I/9VtTCsEFkWFbvKxqYs0bgp/Gu6bUs+JUZbhhBo+PEnV+P5wP73Mg27egTmA0JburlCs5ASCzpr91T1SCAQyjVFUV4vb1KS/Y41s1MJYyjDBuT9AFNTcAidK2f60h7IocTfvHpJVPzW7kinExCmct9NgOtf+XEgRhz6gr+ktAi2xe1/gTn++/gx2v3yL8mN+d5fa4nvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8240.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199021)(86362001)(66899021)(478600001)(38100700002)(6506007)(83380400001)(186003)(26005)(41300700001)(8676002)(8936002)(7416002)(966005)(6512007)(6666004)(6486002)(316002)(30864003)(6916009)(66476007)(5660300002)(4326008)(66946007)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kCoJrv+dfMaLCwzRXrPRpA6a5Uhh4uSNlUGFFzwWMRfGOYuIoX1qE3cUsEh2?=
 =?us-ascii?Q?R91viJ938FVlvctILmrd6XGcBfNfywChxjBLYH9YI3sA21CByzUhmS6LnAal?=
 =?us-ascii?Q?ti7NdpAsB9p3o3bxXCHJCwZhUHEDHw286u3vLisv+kts73aB+4xNmzjDyp/2?=
 =?us-ascii?Q?fhr5sgvNts9HVqXHg2YxA/9t7g2iT7gLswQetHLVBo2Oy3K2zdogscGSi5y5?=
 =?us-ascii?Q?Ame2m8DOn/64kHqCVQR/Pv9Ufu86sfSoy6rckFCKMWHF75pMtqLTyaLrMnlK?=
 =?us-ascii?Q?OX0II/soGLEUTevBNABC3myZkzSXi2PQKgdBJM0HAcHG5NL9Lg54lc9ovSMg?=
 =?us-ascii?Q?40kfxzMV9CzU5f9GI7TbxBW9K9uEI+/SWU71GIDmAUI7Lon0HZiNvU1WRVY5?=
 =?us-ascii?Q?HeKV/krShI8nPD1laMImFaqshYLap7xnojx6xtousguIRfTxTwZPwD3ns8H0?=
 =?us-ascii?Q?cBMQl6pLZIev0vMTJ153LNiO7hSGBUaxdwwKZeN3AG/pEnZLiAXMZcYQuu45?=
 =?us-ascii?Q?liXdSTxhaJkMpWTCM21SVsUZ5yDbAaWUT0xFNjxi/AZMv0ssE6Si76PkwhrY?=
 =?us-ascii?Q?T/TXQ6YrMmO+U8gYQjqeyjm7VajnaINKiwsYC5KzPXuSJ6pt52IvUVa4hqx+?=
 =?us-ascii?Q?KRi6lLq2diE0bBqLsCeI2AzZMnQCQNA9B3PE7urZZpzT2RsFPbZ8A05Vvij6?=
 =?us-ascii?Q?M9nSsBbTMEEZfMNv08dgKxQjgTf6/oh5UrulgaXuedCg4WI72cwAg7voj9LU?=
 =?us-ascii?Q?rwAgYqX5iGUhHVYerxNT7uPeGaOxD5FA+rh5jt/JYl+CPZmSJlSPwa2Ln07J?=
 =?us-ascii?Q?UQr7b9ya8lIkXjkgyQYcSFenGzJsyisjZrEq+wJnKW9n7oonDZ577kpvKYOr?=
 =?us-ascii?Q?X9i79MtSihV+2686XOcqWt+rQE9F5/VFmbN/hLYPvpCl743bQ+Io7idv9Ey3?=
 =?us-ascii?Q?a32hVKFEopr08AWCCFEgb6MIj6W7NCDgjWsRJMzWfmoKmg7o+vgoxkua01xg?=
 =?us-ascii?Q?In4FTxud0VQSpl/2y9XbpyUH3of5Uvl6QVhsA7gR5M6cDS38Lv64QiPdQAu4?=
 =?us-ascii?Q?miAvQfXwQYk9qtjRC3myYFltmP37TukzGaLYJ4NKn7JCb8xqaYuey/lO6v50?=
 =?us-ascii?Q?NBTv9iz6Ypva/LwgeqjfgoeFIhQCJUTzLwqKaZSzOF9eTzMLCUigEnft1T77?=
 =?us-ascii?Q?1FTgEa/AFBjSgNN4vyS0vT9sJLa01ZyyCDTyyvfSr96Yz8+ivNqIEBcw6+Fz?=
 =?us-ascii?Q?IKamzIWyqBzotFLg5P3LY50BPQlbrZPEa0N4ECkg2acYRtU2dQWIIfeRKxnY?=
 =?us-ascii?Q?aEPEA5O1jR4MUAwsbCpzMdnZrqcAxpk0NS7r7sSKT6Zp/oArFfW9mII3PUC2?=
 =?us-ascii?Q?kIzdpwRD/GadutQOwJ1NsT7HAKmWW2CD74/wd5c6/vOT2sSmnkRx+1LKD5go?=
 =?us-ascii?Q?vU1y/iZvuPGENmjApT6csJvKQvV8ZEIAxKk4qfamTaCnhVRsdtNynxKzX9U6?=
 =?us-ascii?Q?k7sPVZ8h4AGprxHKCmQyASLlLv+4our2jWQxvLPqBcBZM8SDbU8qBskRRVxG?=
 =?us-ascii?Q?PerL+0z8KGvC9dlo8DVqUIDH9r0gaNLjuE7Y/sRF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6a5b5c-35c1-4dd4-8d79-08db932242d5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8240.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:32:36.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzFdk+wLdf/WbFQzWkCXrgAp16dzudmuRfJUh2GZrMIN/LjMxTBsZPzm/fepgEikwbuDiRBQ9jPDPZeFt4P5Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,


On Tue, Jul 25, 2023 at 03:22:55PM -0500, David Vernet wrote:
> On Fri, Jul 21, 2023 at 02:42:57PM +0530, Gautham R. Shenoy wrote:
> > Hello David,
> 
> Hello Gautham,
> 
> Thank you for taking the time to run these benchmarks. Apologies for the
> delayed response -- I've been traveling this week.

No issues. As you can see, there has been an delay from my end as well.


> 
> > On Mon, Jul 10, 2023 at 03:03:35PM -0500, David Vernet wrote:
> > > Changes
> > > -------
> > > 
> > > This is v2 of the shared wakequeue (now called shared runqueue)
> > > patchset. The following are changes from the RFC v1 patchset
> > > (https://lore.kernel.org/lkml/20230613052004.2836135-1-void@manifault.com/).
> > > 
> > > v1 -> v2 changes:
> > > - Change name from swqueue to shared_runq (Peter)
> > > 
> > > - Sharded per-LLC shared runqueues to avoid contention on
> > >   scheduler-heavy workloads (Peter)
> > > 
> > > - Pull tasks from the shared_runq in newidle_balance() rather than in
> > >   pick_next_task_fair() (Peter and Vincent)
> > > 
> > > - Rename a few functions to reflect their actual purpose. For example,
> > >   shared_runq_dequeue_task() instead of swqueue_remove_task() (Peter)
> > > 
> > > - Expose move_queued_task() from core.c rather than migrate_task_to()
> > >   (Peter)
> > > 
> > > - Properly check is_cpu_allowed() when pulling a task from a shared_runq
> > >   to ensure it can actually be migrated (Peter and Gautham)
> > > 
> > > - Dropped RFC tag
> > > 
> > > This patch set is based off of commit ebb83d84e49b ("sched/core: Avoid
> > > multiple calling update_rq_clock() in __cfsb_csd_unthrottle()") on the
> > > sched/core branch of tip.git.
> > 
> > I have evaluated this v2 patchset on AMD Zen3 and Zen4 servers.
> > 
> > tldr:
> > 
> > * We see non-trivial improvements on hackbench on both Zen3 and Zen4
> >   until the system is super-overloaded, at which point we see
> >   regressions.
> 
> This makes sense to me. SHARED_RUNQ is more likely to help performance
> when the system is not over-utilized, as it has more of a chance to
> actually increase work conservation. If the system is over-utilized,
> it's likely that a core will be able to find a task regardless of
> whether it looks at the shared runq.
> 
> That said, I wasn't able to reproduce the regressions (with --groups 16)
> on my 7950X, presumably because it only has 8 cores / CCX.
> 
> > * tbench shows regressions on Zen3 with each client
> >   configuration. tbench on Zen4 shows some improvements when the system is
> >   overloaded.
> 
> Hmm, I also observed tbench not performing well with SHARED_RUNQ on my
> Zen4 / 7950X, but only with heavy load. It also seems that sharding
> helps a lot for tbench on Zen3, whereas Zen4 performs fine without it.
> I'm having trouble reasoning about why Zen4 wouldn't require sharding
> whereas Zen3 would given that Zen4 has more cores per CCX.

Yes, I have been thinking about it as well. Both Zen3 (Milan) and Zen4
(Bergamo) servers that I ran these tests on have 8 cores per
CCX. Bergamo has 2 CCXes per CCD, whle Milan has 1 CCX per CCD. We
don't model the CCD in the sched-domain hierarchy currently, so from
the point of view of the LLC domain (which is the CCX), the number of
cores between the two systems per LLC are identical.

> 
> Just to verify -- these benchmarks were run with boost disabled,
> correct? Otherwise, there could be a lot of run-to-run variance
> depending on thermal throttling.


Checking my scripts, these benchmarks were run with C2 disabled,
performance governor enabled, and acpi-cpufreq as the scaling
governor. Boost was enabled, so yes, there could be run-to-run
variance. I can rerun them this weekend with boost disabled. I also
need to understand the overloaded cases of tbench and netperf where
the shared-runq is performing better.


> 
> > 
> > * netperf shows minor improvements on Zen3 when the system is under
> >   low to moderate load. netperf regresses on Zen3 at high load, and at
> >   all load-points on Zen4.
> 
> netperf in general seems to regress as the size of the LLC inreases due
> to it relentlessly hammering the runqueue, though it's still surprising
> to me that your Zen4 test showed regressions under low / moderate load
> as well. Was this with -t TCP_RR, or -t UDP_RR? I observed SHARED_RUNQ
> improving performance on my 7950X for -t TCP_RR as described on [0], so
> I'd be curious to better understand where the slowdowns are coming from
> (presumably it's just contending on the shard lock due to having a
> larger CCX?)


I ran netperf with TCP_RR with the server running on localhost. The
exact command is:

netperf -H 127.0.0.1 -t TCP_RR -l 100 -- -r 100 \
-k REQUEST_SIZE,RESPONSE_SIZE,ELAPSED_TIME,THROUGHPUT,THROUGHPUT_UNITS,MIN_LATENCY,MEAN_LATENCY,P50_LATENCY,P90_LATENCY,P99_LATENCY,MAX_LATENCY,STDDEV_LATENCY

I am yet to debug why we are seeing performance drop in the
low-utilization cases. 


> 
> [0]: https://lore.kernel.org/all/20230615000103.GC2883716@maniforge/
> 
> > * Stream, SPECjbb2015 and Mongodb show no significant difference compared
> >   to the current tip.
> > 
> > * With netperf and tbench, using the shared-runqueue during
> >   enqueue_entity performs badly.
> 
> My reading of your Zen4 numbers on tbench seem to imply that it actually
> performs well under heavy load. Copying here for convenience:

> 
> Zen4, 2 Sockets, 128 cores per socket, SMT2:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Clients:    tip[pct imp](CV)       swqueue[pct imp](CV)     noshard[pct imp](CV)    shard_wakeup[pct imp](CV)   shard_all[pct imp](CV)
>     1     1.00 [  0.00]( 0.19)     0.98 [ -1.72]( 0.19)     0.99 [ -1.15]( 0.28)     0.98 [ -1.79]( 0.28)     0.99 [ -1.49]( 0.10)
>     2     1.00 [  0.00]( 0.63)     0.98 [ -2.28]( 0.63)     0.98 [ -1.91]( 0.26)     0.97 [ -3.14]( 0.25)     0.98 [ -1.77]( 0.32)
>     4     1.00 [  0.00]( 0.22)     1.00 [  0.00]( 1.13)     0.99 [ -0.69]( 0.57)     0.98 [ -1.59]( 0.35)     0.99 [ -0.64]( 0.18)
>     8     1.00 [  0.00]( 1.14)     0.99 [ -0.73]( 0.61)     0.98 [ -2.28]( 2.61)     0.97 [ -2.56]( 0.34)     0.98 [ -1.77]( 0.70)
>    16     1.00 [  0.00]( 0.98)     0.97 [ -2.54]( 1.24)     0.98 [ -1.71]( 1.86)     0.98 [ -1.53]( 0.62)     0.96 [ -3.56]( 0.93)
>    32     1.00 [  0.00]( 0.76)     0.98 [ -2.31]( 1.35)     0.98 [ -2.06]( 0.77)     0.96 [ -3.53]( 1.63)     0.88 [-11.72]( 2.77)
>    64     1.00 [  0.00]( 0.96)     0.96 [ -4.45]( 3.53)     0.97 [ -3.44]( 1.53)     0.96 [ -3.52]( 0.89)     0.31 [-69.03]( 0.64)
>   128     1.00 [  0.00]( 3.03)     0.95 [ -4.78]( 0.56)     0.98 [ -2.48]( 0.47)     0.92 [ -7.73]( 0.16)     0.20 [-79.75]( 0.24)
>   256     1.00 [  0.00]( 0.04)     0.93 [ -7.21]( 1.00)     0.94 [ -5.90]( 0.63)     0.59 [-41.29]( 1.76)     0.16 [-83.71]( 0.07)
>   512     1.00 [  0.00]( 3.08)     1.07 [  7.07](17.78)     1.15 [ 15.49]( 2.65)     0.82 [-17.53](29.11)     0.93 [ -7.18](32.23)
>  1024     1.00 [  0.00]( 0.60)     1.16 [ 15.61]( 0.07)     1.16 [ 15.92]( 0.06)     1.12 [ 11.57]( 1.86)     1.12 [ 11.97]( 0.21)
>  2048     1.00 [  0.00]( 0.16)     1.15 [ 14.62]( 0.90)     1.15 [ 15.20]( 0.29)     1.08 [  7.64]( 1.44)     1.15 [ 14.57]( 0.23)
> 
>  I'm also struggling to come up for an explanation for why Zen4 would
>  operate well with SHARED_RUNQ under heavy load. Do you have a theory?

Yes. So, my theory is that with SHARED_RUNQ, we delay entering idle
state due to the checking of the shared runqueue while acquiring a
lock. So perhaps this is helping in an unintended manner. I want to
rerun those parts while collecting the idle-statistics.


> 
> > Server configurations used:
> > 
> > AMD Zen3 Server:
> >   * 2 sockets,
> >   * 64 cores per socket,
> >   * SMT2 enabled
> >   * Total of 256 threads.
> >   * Configured in Nodes-Per-Socket(NPS)=1
> > 
> > AMD Zen4 Server:
> >   * 2 sockets,
> >   * 128 cores per socket,
> >   * SMT2 enabled
> >   * Total of 512 threads.
> >   * Configured in Nodes-Per-Socket(NPS)=1
> >
> > The trends on NPS=2 and NPS=4 are similar. So I am not posting those.
> > 
> > 
> > Legend:
> > tip           : Tip kernel with top commit ebb83d84e49b
> >                 ("sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()")
> > 
> > swqueue_v1    : Your v1 patches applied on top of the aforemenioned tip commit.
> > 
> > noshard       : shared-runqueue v2 patches 1-5. This uses a shared-runqueue
> >                 during wakeup. No sharding.
> > 
> > shard_wakeup  : shared-runqueue v2 patches 1-6. This uses a
> >                 shared-runqueue during wakeup and has shards with
> >                 shard size = 6 (default)
> > 
> > shard_all     : v2 patches 1-7. This uses a sharded shared-runqueue during
> >                 enqueue_entity
> 
> So, what's your overall impression from these numbers? My general
> impression so far is the following:
> 
> - SHARED_RUNQ works best when the system would otherwise be
>   under-utilized. If the system is going to be overloaded, it's unlikely
>   to provide a significant benefit over CFS, and may even just add
>   overhead with no benefit (or just cause worse cache locality).


I agree with you here. The only thing that saw a consistent benefit
was hackbench under moderate load. 

> 
> - SHARED_RUNQ isn't well-suited to workloads such as netperf which
>   pummel the scheduler. Sharding helps a lot here, but doesn't
>   completely fix the problem depending on how aggressively tasks are
>   hammering the runqueue.

Yeah. Even with sharding (which I would assume would definitely help
on platforms with a larger LLC domain), each idle entry would result
in searching the shared-wakequeue and probability of finding something
there is very low if the workload runs for a very short duration.

> 
> - To the point above, using SHARED_RUNQ in __enqueue_entity() /
>   __dequeue_entity(), rather than just on the wakeup path, is a net
>   positive. Workloads which hammer the runq such as netperf or schbench
>   -L -m 52 -p 512 -r 10 -t 1 will do poorly in both scenarios, so we may
>   as well get the better work conservation from __enqueue_entity() /
>   __dequeue_entity(). hackbench is one example of a workload that
>   benefits from this, another is kernel compile, and I strongly suspect
>   that HHVM would similarly benefit.

Well, the magnitude of the performance degradation is much higher for
tbench and netperf when we have shared_runq being used in the
__enqueue_entity()/__dequeue_entity() path. So it is very workload
dependent. I would like to try out with a variant that used
shared_runq() in the __enqueue/__dequeue_entity() path, without
sharding though. Just to see if it makes any difference.



> 
> - Sharding in general doesn't seem to regress performance by much when
>   it wouldn't have otherwise been necessary to avoid contention.
>   hackbench is better without sharding on Zen3, but it's also better
>   with shard_all on Zen4.


> 
>   In general, if our goal is to better support hosts with large CCXs, I
>   think we'll just need to support sharding.

I think the shard size needs to be determined as a function of the LLC
size. Or have the arch specific code pick the size to suit a
particular generation. At least on Zen3, Zen4 servers with 8 cores per
LLC domain, creation of shards was not providing additional benefit.


> 
> Thoughts?
> 
> I have the v3 version of the patch set which properly supports domain
> recreation and hotplug, but I still need to get updated benchmark
> numbers on it, as well as benchmark spreading a shared_runq over
> multiple CCXs per Peter's comment in [1] about the initial motivation
> behind SIS_NODE also applying to SHARED_RUNQ.

> [1]: https://lore.kernel.org/all/20230711114207.GK3062772@hirez.programming.kicks-ass.net/

Based on the various flavors of SIS_NODE that we have experimented
with on the EPYC servers, it seems to work very well when the
probability of finding an idle core/cpu in the wider sched-domain is
higher. In that case, the extra time spent in searching for that idle
core/cpu is justified by the fact that the task gets to run
immediately. However, as the utilization on the system increases, we
are less likely to find an idle core/cpu, the additional time spent
searching does show up as a regression. What we need is a way to limit
the downside in these latter case without lowering that upside that we
see in the low-moderate utilization cases.


> 
> Given the points above, I would ideally like to just run the shard_all
> variant and compare that to the numbers I collected on v2 and shared in
> [2]. What do you think?

Would that be a fair comparison, because SIS_NODE only explores a
wider-search during wakeups while shard_all would add task to the
shared_runq even during a regular enqueue.

> There will be tradeoffs no matter what we choose
> to do, but enqueuing / dequeuing in __enqueue_entity() /
> __dequeue_entity() seems to perform the best for workloads that don't
> hammer the runqueue, and sharding seems like a given if we do decide to
> do that.

Or see if we can avoid using shard_runq/SIS_NODE when the probability
of reducing the scheduling latency and improving utilization is
low. In these case, the default scheduling strategy should just work
fine. However, I don't know of any clean way to detect such a
situation. That quest is still on :-)

> 
> [2]: https://lore.kernel.org/all/20230710200342.358255-1-void@manifault.com/
> 
> Thanks,
> David

--
Thanks and Regards
gautham.
