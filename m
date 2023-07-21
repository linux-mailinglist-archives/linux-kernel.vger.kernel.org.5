Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908E875C2B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjGUJNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGUJNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:13:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFF530FE
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bASHD/LjT2R0F3Br60cruKVml1a5z53WXHqREjxS3tHFTx5JkijJKZ72tzmu7ChnxTOVoFqk0vpQ/MFaQHxHjNvqbMsMWp3HtnKm3bj64xEDq+/mpHetiDY64JUrcur8XugkdbxfTjywE5GHRmhSdLFrw/3J03gg6Vy1BghZfHJIwutPZjFzr57BfE4aqess9hUYVV0k1tHJVDHOQf3JkD61cdnwAt0JPggV3Ehf4zzoRQ1fZyPdET6IoI+mOYPpT//HVxep5e2ELp9C3HIw4LWighJVLoCHgg+LFM1t2denGXc1QDoBHzVPXHOIoGLJ3hM2i9kIHiv/EwaTwbFihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy0tCAozPL4TL3bG7YHck/qnAEPYf71drt2bUh0rJGQ=;
 b=Kj6R1Dp+DXv7XAQUnu7mDrTorJeZYCnBuFhgH/wsLBUfpU4angEhyoy9udeZptOQgS1oyxsitufcvgFAiFlWR4gYyqcuiImPJBUQAFzYFFyxCM1BP1ej7YhOzxcVzcbC+sJgRqSChFrCQ1i6ImjfJltDzR9hbkZNhMqJPv2cXpcKP1M0VRbfBhKk1U5ZGUjreANt1CGhx4Hl4+nTOjf0pn9fhIs4j/q3hpXdSMX0OMRGVtyoBgBLwSBfkZt1P1tHez4k0RlscDIyXaGtTtm57IR0Fe934LwOSJvAzGmZ8t+OSitBrUsv3nKPvDvQo73qfrMphkmqFCh9pPFAf+jS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy0tCAozPL4TL3bG7YHck/qnAEPYf71drt2bUh0rJGQ=;
 b=jsYFEnznx4ijf+rPY8QWXcHElbSNP0DmkcaCdftk++ncdoCW627DzaB76oWmTDTUQA2+VQKPOCJPT+UqjYF4uzVtBjJdjxNRTGFv0onuHLnATvEVm0xFW8IbsFzzzQMhnC+GWSmsUhyt7gg5YcszG2oDmzcorc7m8umjrPEegaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 09:13:11 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2dd6:4ccd:1695:d51f]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2dd6:4ccd:1695:d51f%6]) with mapi id 15.20.6609.024; Fri, 21 Jul 2023
 09:13:10 +0000
Date:   Fri, 21 Jul 2023 14:42:57 +0530
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
Message-ID: <ZLpMGVPDXqWEu+gm@BLR-5CG11610CF.amd.com>
References: <20230710200342.358255-1-void@manifault.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710200342.358255-1-void@manifault.com>
X-ClientProxiedBy: PN2PR01CA0204.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::14) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: a59c811f-ed38-495f-5896-08db89cab43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLIGOZ7VQPEEX1BuCie2bgPy+INXa6DNdY//iiD1exxztJ8l2T7+bhle0XnKVX2f/9DK9EKLf4NygNOvFg1j+B+GqBlB0mWjjqpC2oBb2/NZV4x6n6OcJEKoR/IRu9trW7Tp8BJRt5NrhQgrkIfhPyJZ0MGCTpkPQPFrgOPCj7aFi5l1y2Kun2J2mLt1TwsbCQZENTvq6xD3ojwmpshCuCn85/Cd7EZ8PaKChqBsojiW4rfz2x7bSsxiJWh4huun/PErRoOlkNtpF8wUYvi7PCvtpsmhxJneQAL+5U8Wg89odJvhq4sEYwlP4PPaWq2nfMCgXuenVV/BJf9/C4+sNk0RvuctGy9i/fPoptKNRocIGopdNXk8y5lEa5U9I00B30d7QGfg6iZFV2GIFdsxJnLPbGyRVzZ6qmEJBoLDTlWCsPY37VBaZsWpfQgZSmOG71bU6ZEL6QsEHQl0LQW0CIlAjBDVvKQszISsJ/d3PKKCZ5dR1cih9LYZj78FleuMUQtl7R/lpufMb8hsFJ1fq2jTCTKZSf2ahVw3zqtrY1R1IsSLQG454pfheF7B1PbtUoVSq2Rj5Tb53KK8/w4Iu9h++iUwyjmnc+vQHyjsqRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(186003)(478600001)(2906002)(38100700002)(6512007)(6666004)(83380400001)(26005)(86362001)(5660300002)(8676002)(7416002)(30864003)(4326008)(316002)(6486002)(66946007)(66476007)(8936002)(66556008)(41300700001)(6916009)(6506007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3QwNUHGIPROdUZZzU7ZfD+9AFwQ2pMDUW6wy6WBMxD+85C0B/lRSx1fNie+W?=
 =?us-ascii?Q?fV67i1+MnFkLT5BIfSQ8OOweum4BFE+kEz25VJ3FU5I/La7Q9NNlke5fLwtj?=
 =?us-ascii?Q?OlCQQp77cIG8BWuSPJnnfk0W05Y08L+qrzwT8jZjTx9sqn2KE40xT+us0c0o?=
 =?us-ascii?Q?2z+ms0twQin39ACuOeKgNm04qd7qnBbgiO9uRHI2ybNNQJTizRSJMFUN68VO?=
 =?us-ascii?Q?wKyITmmDXq9XAf4TFRnkSrwTksrbzwVnTZ006gXjrzoGmv/96QRTD3pV9KE6?=
 =?us-ascii?Q?Mljq5nUCBDrSZwaXApT7xenWHo8kGPFxjOFvG+Q3CL3979F7g7ioWuHr7YKm?=
 =?us-ascii?Q?ep8aMooU3YV+KyT7idyRdE02tRwRKPJXudrwQwYAMVbBrRR6ADnUXNgMX5sK?=
 =?us-ascii?Q?tHf+KB21p2dImpAvVjQUMR7Rnc9yefX7yB+pHnCzs9X5GUA6WmXmBNVhvr/X?=
 =?us-ascii?Q?ETTON8W0fz8PdNvHblWHKQ6icCHfaV7i442Hy9wgwxptf8U4BLvalao1s1xU?=
 =?us-ascii?Q?66yisZx6mnQsmt4kHjMtN+r+ajFZ0U7KrI8BXulg5tkTbtpqGmtEvgHbof7e?=
 =?us-ascii?Q?q/5LfPGt8WWZIstXckTPyxSmnW1ZZ9DLCkyzZoSVetaLwbDdH1oGZR6imXGM?=
 =?us-ascii?Q?dbuY9kDrMbq1vyaHlGP+5YwIyfztcD8qIC0n1CWnbW6K7JyRfLKEpVyYncP7?=
 =?us-ascii?Q?6qzyQ9Zx9wbeIvRwQfqEZWE3emXKWJ4rixtrrSy5b3l7bvtqf16BUOV3J6wx?=
 =?us-ascii?Q?9Zq+KBekzwsy9d/uu5DOAtcCWbESHuKLFsGXWFaocNa9MzpSNSQZyiYuUMaW?=
 =?us-ascii?Q?WRR3rw5cyOMoIuF8SAnGf90EfFxRsjCs7RNhFUx8GS3Lg1IWlbzWDrdE2HGB?=
 =?us-ascii?Q?F7rKghrYd5fIPJwKseTuW84oFmbgN3UyZHh3ZdQAigU0Na97UQH4+iHHpjpf?=
 =?us-ascii?Q?2g4YBfpim+HK+Q/Ymtl3dliwpntmQhH4p49chfSGyt+A3U0k3li41q5G1xcZ?=
 =?us-ascii?Q?iriz8RMMk5sE06+9O6sr6J/+WxWocOeFT05QCp17DlBtjO94860MooQqM9l4?=
 =?us-ascii?Q?UFobtONpGkphAZw4q6BwGtqEPI57cdWcVQDu/HE1NXccEZ9DsoV0thwJrk/S?=
 =?us-ascii?Q?z0CPz4iv1RSKXcSLHBmT0+/enpyKPvE2aF7Rv385NZIV6LwtnQOdQ+hZR4v4?=
 =?us-ascii?Q?yrbC+kB6P9PtOdxrb7gDNE6meqP25uaQJo+0vpHKV4RdHGGz5CYkk5wgxPc/?=
 =?us-ascii?Q?0BKqRwsCtD9Tx6LD/p1kQResmRlXr4ck17U2dkKNUTjf3Ud84NS7J77YrumL?=
 =?us-ascii?Q?YX/M22CBogCGWLpYdS7nZLmTZEaZFb93rmhHY1Qo+I6hhZZd8mIF2WaD0viH?=
 =?us-ascii?Q?Z263lgWKD5r4+HGzsdZ51wU/t8ZUN9pA9d9M2+n2keIMhrf1YXZi8R3UtpD7?=
 =?us-ascii?Q?RGs25NgzBEKHCCMYBMiSQgqGwdmRRQTws5aIIdXR8B1baABeZjTUAWp8+NFR?=
 =?us-ascii?Q?xhWTI29tis5hbDVT+/yhg1ZQFUm/sh/TxsSeRvunfru1o4WIHYn0aHeTKNic?=
 =?us-ascii?Q?tQ916hHRCfJWdEFN40YGh6brSpdW3RyOovoyYrz3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59c811f-ed38-495f-5896-08db89cab43a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:13:10.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJ+QrzB5wM/Ytb19Wt5wD5Rbb6x0T80XCN3UToQSlPe5JbV7hJ2QuZWISSuy7RWKcgOeWsVS3TXOppDEdSeCCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Mon, Jul 10, 2023 at 03:03:35PM -0500, David Vernet wrote:
> Changes
> -------
> 
> This is v2 of the shared wakequeue (now called shared runqueue)
> patchset. The following are changes from the RFC v1 patchset
> (https://lore.kernel.org/lkml/20230613052004.2836135-1-void@manifault.com/).
> 
> v1 -> v2 changes:
> - Change name from swqueue to shared_runq (Peter)
> 
> - Sharded per-LLC shared runqueues to avoid contention on
>   scheduler-heavy workloads (Peter)
> 
> - Pull tasks from the shared_runq in newidle_balance() rather than in
>   pick_next_task_fair() (Peter and Vincent)
> 
> - Rename a few functions to reflect their actual purpose. For example,
>   shared_runq_dequeue_task() instead of swqueue_remove_task() (Peter)
> 
> - Expose move_queued_task() from core.c rather than migrate_task_to()
>   (Peter)
> 
> - Properly check is_cpu_allowed() when pulling a task from a shared_runq
>   to ensure it can actually be migrated (Peter and Gautham)
> 
> - Dropped RFC tag
> 
> This patch set is based off of commit ebb83d84e49b ("sched/core: Avoid
> multiple calling update_rq_clock() in __cfsb_csd_unthrottle()") on the
> sched/core branch of tip.git.

I have evaluated this v2 patchset on AMD Zen3 and Zen4 servers.

tldr:

* We see non-trivial improvements on hackbench on both Zen3 and Zen4
  until the system is super-overloaded, at which point we see
  regressions.

* tbench shows regressions on Zen3 with each client
  configuration. tbench on Zen4 shows some improvements when the system is
  overloaded.

* netperf shows minor improvements on Zen3 when the system is under
  low to moderate load. netperf regresses on Zen3 at high load, and at
  all load-points on Zen4.

* Stream, SPECjbb2015 and Mongodb show no significant difference compared
  to the current tip.

* With netperf and tbench, using the shared-runqueue during
  enqueue_entity performs badly.


Server configurations used:

AMD Zen3 Server:
  * 2 sockets,
  * 64 cores per socket,
  * SMT2 enabled
  * Total of 256 threads.
  * Configured in Nodes-Per-Socket(NPS)=1

AMD Zen4 Server:
  * 2 sockets,
  * 128 cores per socket,
  * SMT2 enabled
  * Total of 512 threads.
  * Configured in Nodes-Per-Socket(NPS)=1


The trends on NPS=2 and NPS=4 are similar. So I am not posting those.


Legend:
tip           : Tip kernel with top commit ebb83d84e49b
                ("sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()")

swqueue_v1    : Your v1 patches applied on top of the aforemenioned tip commit.

noshard       : shared-runqueue v2 patches 1-5. This uses a shared-runqueue
                during wakeup. No sharding.

shard_wakeup  : shared-runqueue v2 patches 1-6. This uses a
                shared-runqueue during wakeup and has shards with
                shard size = 6 (default)

shard_all     : v2 patches 1-7. This uses a sharded shared-runqueue during
                enqueue_entity


==================================================================
Test          : hackbench 
Units         : Normalized time in seconds 
Interpretation: Lower is better 
==================================================================

Zen3, 2 Sockets, 64 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Case:         tip[pct imp](CV)         swqueue_v1[pct imp](CV)  noshard[pct imp](CV)    shard_wakeup[pct imp](CV)   shard_all[pct imp](CV)
 1-groups     1.00 [  0.00]( 4.39)     0.89 [ 11.39]( 6.86)     0.90 [  9.87](12.51)     0.92 [  7.85]( 6.29)     0.91 [  8.86]( 4.67)
 2-groups     1.00 [  0.00]( 1.64)     0.81 [ 18.90]( 2.67)     0.84 [ 15.71]( 5.91)     0.87 [ 12.74]( 2.26)     0.87 [ 12.53]( 2.40)
 4-groups     1.00 [  0.00]( 1.27)     0.89 [ 10.85]( 2.38)     0.94 [  6.20]( 2.99)     0.97 [  2.71]( 2.38)     0.96 [  4.46]( 1.06)
 8-groups     1.00 [  0.00]( 0.72)     0.94 [  6.37]( 2.25)     0.96 [  3.61]( 3.39)     1.09 [ -8.78]( 1.14)     1.06 [ -5.68]( 1.55)
16-groups     1.00 [  0.00]( 4.72)     0.96 [  3.64]( 1.11)     1.01 [ -1.26]( 1.68)     1.07 [ -7.41]( 2.06)     1.10 [ -9.55]( 1.48)

Zen4, 2 Sockets, 128 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Case:         tip[pct imp](CV)         swqueue[pct imp](CV)     noshard[pct imp](CV)    shard_wakeup[pct imp](CV)   shard_all[pct imp](CV)
 1-groups     1.00 [  0.00](13.13)     0.90 [ 10.34](10.27)     0.94 [  6.44](10.99)     0.94 [  6.44](11.45)     0.91 [  9.20](13.31)
 2-groups     1.00 [  0.00](10.27)     0.97 [  2.86]( 6.51)     0.94 [  5.71]( 4.65)     1.00 [ -0.48](10.25)     0.95 [  4.52]( 6.60)
 4-groups     1.00 [  0.00]( 2.73)     0.89 [ 10.80]( 7.75)     0.82 [ 17.61]( 9.57)     0.83 [ 16.67](10.64)     0.81 [ 18.56]( 9.58)
 8-groups     1.00 [  0.00]( 1.75)     0.85 [ 15.22]( 5.16)     0.83 [ 17.01]( 4.28)     0.90 [ 10.45](10.05)     0.79 [ 21.04]( 2.84)
16-groups     1.00 [  0.00]( 0.54)     1.16 [-15.84]( 2.17)     1.16 [-16.09]( 3.59)     1.24 [-24.26]( 4.22)     1.13 [-12.87]( 3.76)


==================================================================
Test          : tbench 
Units         : Normalized throughput 
Interpretation: Higher is better 
==================================================================

Zen3, 2 Sockets, 64 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Clients:    tip[pct imp](CV)      swqueue_v1[pct imp](CV)   noshard[pct imp](CV)    shard_wakeup[pct imp](CV)   shard_all[pct imp](CV)
    1     1.00 [  0.00]( 0.46)     0.99 [ -1.33]( 0.94)     0.98 [ -1.65]( 0.37)     1.00 [ -0.23]( 0.15)     0.95 [ -4.77]( 0.93)
    2     1.00 [  0.00]( 0.35)     0.99 [ -1.00]( 0.41)     1.00 [ -0.12]( 0.45)     0.99 [ -0.62]( 1.43)     0.92 [ -8.48]( 5.19)
    4     1.00 [  0.00]( 2.37)     0.99 [ -0.70]( 0.39)     0.98 [ -2.49]( 0.79)     0.98 [ -1.92]( 0.85)     0.91 [ -8.54]( 0.56)
    8     1.00 [  0.00]( 0.35)     1.01 [  0.88]( 0.21)     0.97 [ -3.13]( 0.96)     0.99 [ -1.44]( 0.96)     0.89 [-11.48]( 1.31)
   16     1.00 [  0.00]( 2.50)     1.00 [  0.34]( 1.34)     0.97 [ -2.96]( 1.17)     0.97 [ -2.88]( 1.85)     0.84 [-16.41]( 1.31)
   32     1.00 [  0.00]( 1.79)     0.98 [ -1.97]( 3.81)     0.99 [ -1.17]( 1.89)     0.95 [ -4.83]( 2.08)     0.52 [-48.23]( 1.11)
   64     1.00 [  0.00]( 5.75)     1.17 [ 17.41]( 0.79)     0.97 [ -3.14](10.67)     1.07 [  6.94]( 3.08)     0.41 [-59.17]( 1.88)
  128     1.00 [  0.00]( 3.16)     0.87 [-13.37]( 7.98)     0.73 [-26.87]( 1.07)     0.74 [-25.81]( 0.97)     0.35 [-64.93]( 0.68)
  256     1.00 [  0.00]( 0.21)     0.93 [ -6.86]( 2.81)     0.85 [-15.26]( 3.17)     0.91 [ -9.39]( 1.05)     0.90 [ -9.94]( 0.97)
  512     1.00 [  0.00]( 0.23)     0.88 [-11.79](15.25)     0.83 [-17.35]( 1.21)     0.87 [-12.96]( 2.63)     0.99 [ -1.18]( 0.80)
 1024     1.00 [  0.00]( 0.44)     0.99 [ -0.98]( 0.43)     0.77 [-23.18]( 5.24)     0.82 [-17.83]( 0.70)     0.96 [ -3.82]( 1.61)

Zen4, 2 Sockets, 128 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Clients:    tip[pct imp](CV)       swqueue[pct imp](CV)     noshard[pct imp](CV)    shard_wakeup[pct imp](CV)   shard_all[pct imp](CV)
    1     1.00 [  0.00]( 0.19)     0.98 [ -1.72]( 0.19)     0.99 [ -1.15]( 0.28)     0.98 [ -1.79]( 0.28)     0.99 [ -1.49]( 0.10)
    2     1.00 [  0.00]( 0.63)     0.98 [ -2.28]( 0.63)     0.98 [ -1.91]( 0.26)     0.97 [ -3.14]( 0.25)     0.98 [ -1.77]( 0.32)
    4     1.00 [  0.00]( 0.22)     1.00 [  0.00]( 1.13)     0.99 [ -0.69]( 0.57)     0.98 [ -1.59]( 0.35)     0.99 [ -0.64]( 0.18)
    8     1.00 [  0.00]( 1.14)     0.99 [ -0.73]( 0.61)     0.98 [ -2.28]( 2.61)     0.97 [ -2.56]( 0.34)     0.98 [ -1.77]( 0.70)
   16     1.00 [  0.00]( 0.98)     0.97 [ -2.54]( 1.24)     0.98 [ -1.71]( 1.86)     0.98 [ -1.53]( 0.62)     0.96 [ -3.56]( 0.93)
   32     1.00 [  0.00]( 0.76)     0.98 [ -2.31]( 1.35)     0.98 [ -2.06]( 0.77)     0.96 [ -3.53]( 1.63)     0.88 [-11.72]( 2.77)
   64     1.00 [  0.00]( 0.96)     0.96 [ -4.45]( 3.53)     0.97 [ -3.44]( 1.53)     0.96 [ -3.52]( 0.89)     0.31 [-69.03]( 0.64)
  128     1.00 [  0.00]( 3.03)     0.95 [ -4.78]( 0.56)     0.98 [ -2.48]( 0.47)     0.92 [ -7.73]( 0.16)     0.20 [-79.75]( 0.24)
  256     1.00 [  0.00]( 0.04)     0.93 [ -7.21]( 1.00)     0.94 [ -5.90]( 0.63)     0.59 [-41.29]( 1.76)     0.16 [-83.71]( 0.07)
  512     1.00 [  0.00]( 3.08)     1.07 [  7.07](17.78)     1.15 [ 15.49]( 2.65)     0.82 [-17.53](29.11)     0.93 [ -7.18](32.23)
 1024     1.00 [  0.00]( 0.60)     1.16 [ 15.61]( 0.07)     1.16 [ 15.92]( 0.06)     1.12 [ 11.57]( 1.86)     1.12 [ 11.97]( 0.21)
 2048     1.00 [  0.00]( 0.16)     1.15 [ 14.62]( 0.90)     1.15 [ 15.20]( 0.29)     1.08 [  7.64]( 1.44)     1.15 [ 14.57]( 0.23)

==================================================================
Test          : stream (10 runs)
Units         : Normalized Bandwidth, MB/s 
Interpretation: Higher is better 
==================================================================

Zen3, 2 Sockets, 64 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Test:           tip[pct imp](CV)    swqueue_v1[pct imp](CV)       noshard[pct imp](CV)    shard_wakeup[pct imp](CV)     shard_all[pct imp](CV)
 Copy     1.00 [  0.00]( 5.30)     1.00 [ -0.09]( 5.26)     1.03 [  2.79]( 2.06)     1.02 [  1.73]( 5.29)     1.03 [  2.92]( 1.82)
Scale     1.00 [  0.00]( 0.27)     0.98 [ -1.98]( 1.82)     0.99 [ -0.62]( 1.24)     1.00 [ -0.26]( 1.42)     1.00 [  0.10]( 0.17)
  Add     1.00 [  0.00]( 0.48)     0.99 [ -0.90]( 1.71)     1.00 [  0.12]( 0.95)     1.00 [  0.18]( 1.45)     1.01 [  0.56]( 0.14)
Triad     1.00 [  0.00]( 1.02)     1.03 [  2.80]( 0.60)     1.02 [  2.18]( 1.96)     1.03 [  2.56]( 2.25)     1.03 [  2.58]( 0.56)

Zen4, 2 Sockets, 128 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Test:           tip[pct imp](CV)       swqueue[pct imp](CV)       noshard[pct imp](CV)    shard_wakeup[pct imp](CV)     shard_all[pct imp](CV)
 Copy     1.00 [  0.00]( 0.79)     0.99 [ -0.65]( 0.83)     1.00 [  0.39]( 0.47)     0.99 [ -1.41]( 1.16)     0.98 [ -1.73]( 1.17)
Scale     1.00 [  0.00]( 0.25)     1.00 [ -0.21]( 0.23)     1.01 [  0.63]( 0.64)     0.99 [ -0.72]( 0.25)     1.00 [ -0.40]( 0.70)
  Add     1.00 [  0.00]( 0.25)     1.00 [ -0.15]( 0.27)     1.00 [  0.44]( 0.73)     0.99 [ -0.82]( 0.40)     0.99 [ -0.73]( 0.78)
Triad     1.00 [  0.00]( 0.23)     1.00 [ -0.28]( 0.28)     1.00 [  0.34]( 0.74)     0.99 [ -0.91]( 0.48)     0.99 [ -0.86]( 0.98)


==================================================================
Test          : stream (100 runs)
Units         : Normalized Bandwidth, MB/s 
Interpretation: Higher is better 
==================================================================
Zen3, 2 Sockets, 64 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Test:           tip[pct imp](CV)    swqueue_v1[pct imp](CV)       noshard[pct imp](CV)    shard_wakeup[pct imp](CV)     shard_all[pct imp](CV)
 Copy     1.00 [  0.00]( 0.58)     0.98 [ -2.05]( 6.08)     1.00 [  0.46]( 0.19)     0.99 [ -0.58]( 1.96)     1.01 [  0.50]( 0.20)
Scale     1.00 [  0.00]( 0.47)     0.97 [ -2.71]( 4.94)     1.00 [ -0.01]( 0.23)     1.00 [ -0.35]( 1.39)     1.00 [  0.10]( 0.20)
  Add     1.00 [  0.00]( 0.18)     0.97 [ -2.77]( 7.30)     1.00 [  0.27]( 0.13)     1.00 [  0.05]( 0.59)     1.00 [  0.19]( 0.15)
Triad     1.00 [  0.00]( 0.77)     0.99 [ -0.59]( 7.73)     1.03 [  2.80]( 0.36)     1.03 [  2.92]( 0.43)     1.02 [  2.23]( 0.38)

Zen4, 2 Sockets, 128 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Test:           tip[pct imp](CV)       swqueue[pct imp](CV)       noshard[pct imp](CV)    shard_wakeup[pct imp](CV)     shard_all[pct imp](CV)
 Copy     1.00 [  0.00]( 1.45)     0.97 [ -2.65]( 2.02)     1.01 [  0.85]( 0.96)     1.00 [ -0.24]( 0.67)     0.97 [ -2.77]( 1.09)
Scale     1.00 [  0.00]( 0.67)     0.99 [ -1.27]( 1.01)     1.01 [  0.93]( 0.95)     1.00 [ -0.08]( 0.46)     0.99 [ -1.23]( 0.35)
  Add     1.00 [  0.00]( 0.46)     0.99 [ -1.28]( 0.54)     1.01 [  0.88]( 0.61)     1.00 [  0.00]( 0.31)     0.98 [ -1.89]( 0.33)
Triad     1.00 [  0.00]( 0.46)     0.98 [ -1.93]( 0.55)     1.01 [  0.80]( 0.59)     1.00 [  0.00]( 0.37)     0.98 [ -2.22]( 0.09)


==================================================================
Test          : netperf 
Units         : Normalized Througput 
Interpretation: Higher is better 
==================================================================
Zen3, 2 Sockets, 64 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Clients:        tip[pct imp](CV)        swqueue_v1[pct imp](CV)   noshard[pct imp](CV)    shard_wakeup[pct imp](CV) shard_all[pct imp](CV)
  1-clients     1.00 [  0.00]( 0.25)     0.99 [ -1.22]( 0.88)     0.99 [ -1.34]( 0.26)     1.01 [  0.65]( 0.44)     0.95 [ -4.71]( 1.14)
  2-clients     1.00 [  0.00]( 0.37)     1.02 [  1.59]( 1.02)     1.03 [  2.62]( 1.77)     1.02 [  2.39]( 1.59)     0.96 [ -4.47]( 0.77)
  4-clients     1.00 [  0.00]( 0.57)     1.03 [  2.79]( 1.21)     1.03 [  2.59]( 1.72)     1.01 [  1.49]( 2.27)     0.92 [ -8.30]( 2.95)
  8-clients     1.00 [  0.00]( 1.09)     1.05 [  4.84]( 0.99)     1.03 [  3.13]( 1.70)     1.02 [  1.53]( 2.25)     0.92 [ -8.23]( 1.64)
 16-clients     1.00 [  0.00]( 1.34)     1.06 [  5.88]( 0.96)     1.04 [  3.52]( 1.99)     0.99 [ -1.10]( 2.28)     0.77 [-22.58]( 0.96)
 32-clients     1.00 [  0.00]( 5.77)     1.08 [  8.30]( 2.26)     1.00 [  0.06]( 2.18)     1.02 [  2.12]( 2.31)     0.44 [-56.08]( 1.50)
 64-clients     1.00 [  0.00]( 3.14)     0.94 [ -5.93]( 3.19)     0.76 [-24.05]( 1.65)     0.85 [-15.44]( 3.05)     0.33 [-66.71]( 7.28)
128-clients     1.00 [  0.00]( 1.74)     0.73 [-26.70]( 3.10)     0.64 [-35.94]( 3.64)     0.73 [-26.93]( 5.07)     0.36 [-63.97]( 7.73)
256-clients     1.00 [  0.00]( 1.50)     0.61 [-38.62]( 1.21)     0.56 [-43.88]( 5.72)     0.59 [-40.60]( 2.26)     0.83 [-17.18]( 5.95)
512-clients     1.00 [  0.00](50.23)     0.66 [-33.66](51.96)     0.47 [-53.21](47.91)     0.50 [-50.22](42.87)     0.89 [-10.89](48.44)

Zen4, 2 Sockets, 128 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Clients:        tip[pct imp](CV)         swqueue[pct imp](CV)     noshard[pct imp](CV)    shard_wakeup[pct imp](CV) shard_all[pct imp](CV)
  1-clients     1.00 [  0.00]( 0.60)     0.99 [ -0.65]( 0.14)     0.99 [ -1.26]( 0.26)     0.99 [ -1.37]( 0.40)     0.99 [ -0.80]( 0.53)
  2-clients     1.00 [  0.00]( 0.57)     0.99 [ -1.07]( 0.40)     0.99 [ -1.46]( 0.22)     0.98 [ -2.07]( 0.15)     0.99 [ -1.38]( 0.25)
  4-clients     1.00 [  0.00]( 0.32)     0.99 [ -0.81]( 0.31)     0.99 [ -1.32]( 0.49)     0.98 [ -1.87]( 0.31)     0.99 [ -1.40]( 0.62)
  8-clients     1.00 [  0.00]( 0.45)     0.99 [ -1.26]( 0.88)     0.98 [ -2.01]( 0.90)     0.98 [ -2.23]( 0.42)     0.98 [ -2.04]( 1.03)
 16-clients     1.00 [  0.00]( 0.49)     0.98 [ -1.91]( 1.54)     0.97 [ -2.86]( 2.41)     0.97 [ -2.70]( 1.39)     0.97 [ -3.30]( 0.78)
 32-clients     1.00 [  0.00]( 1.95)     0.98 [ -2.10]( 2.09)     0.98 [ -2.17]( 1.24)     0.97 [ -2.73]( 1.58)     0.44 [-56.47](12.66)
 64-clients     1.00 [  0.00]( 3.05)     0.96 [ -4.00]( 2.43)     0.95 [ -4.84]( 2.82)     0.97 [ -3.43]( 2.06)     0.24 [-76.24]( 1.15)
128-clients     1.00 [  0.00]( 2.63)     0.86 [-14.02]( 2.49)     0.80 [-19.86]( 2.16)     0.75 [-25.02]( 3.24)     0.14 [-85.91]( 3.76)
256-clients     1.00 [  0.00]( 2.02)     0.75 [-25.02]( 2.59)     0.52 [-47.93]( 2.60)     0.42 [-58.38]( 2.18)     0.11 [-88.59]( 9.61)
512-clients     1.00 [  0.00]( 5.67)     1.20 [ 19.91]( 4.99)     1.22 [ 21.57]( 3.89)     0.92 [ -7.65]( 4.84)     1.07 [  7.22](14.77)


==================================================================
Test          : schbench 
Units         : Normalized 99th percentile latency in us 
Interpretation: Lower is better 
==================================================================
Zen3, 2 Sockets, 64 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#workers: tip[pct imp](CV)       swqueue_v1[pct imp](CV)  noshard[pct imp](CV)    shard_wakeup[pct imp](CV) shard_all[pct imp](CV)
  1     1.00 [  0.00]( 0.00)     1.79 [-78.57]( 4.00)     1.93 [-92.86](13.86)     1.93 [-92.86](17.44)     1.14 [-14.29]( 9.75)
  2     1.00 [  0.00]( 7.37)     1.87 [-86.67]( 5.52)     1.87 [-86.67]( 9.10)     1.87 [-86.67]( 7.14)     1.07 [ -6.67]( 3.53)
  4     1.00 [  0.00]( 4.00)     1.28 [-28.00]( 8.57)     1.40 [-40.00]( 0.00)     1.48 [-48.00]( 6.47)     1.08 [ -8.00]( 7.41)
  8     1.00 [  0.00]( 3.33)     1.21 [-20.59]( 1.42)     1.18 [-17.65]( 3.79)     1.15 [-14.71]( 3.88)     1.09 [ -8.82]( 4.81)
 16     1.00 [  0.00]( 2.11)     1.00 [  0.00]( 2.81)     1.00 [  0.00]( 4.69)     1.04 [ -3.70]( 4.22)     1.04 [ -3.70]( 6.57)
 32     1.00 [  0.00]( 4.51)     0.92 [  7.61]( 1.37)     0.92 [  7.61]( 5.90)     0.93 [  6.52]( 2.91)     0.96 [  4.35]( 1.74)
 64     1.00 [  0.00]( 0.92)     0.95 [  5.45]( 0.37)     0.95 [  5.45]( 0.98)     0.96 [  3.64]( 3.14)     1.00 [  0.00]( 9.05)
128     1.00 [  0.00]( 1.35)     0.93 [  7.16]( 3.88)     0.92 [  7.90]( 2.01)     0.94 [  5.68]( 1.14)     0.94 [  6.42]( 0.95)
256     1.00 [  0.00]( 0.59)     1.00 [  0.00]( 1.53)     1.01 [ -1.16]( 6.79)     0.96 [  4.42]( 5.96)     0.91 [  9.31]( 2.22)
512     1.00 [  0.00]( 4.53)     1.03 [ -3.44]( 2.14)     1.08 [ -7.56]( 0.74)     1.04 [ -3.89]( 2.91)     0.90 [ 10.31](11.51)

Zen4, 2 Sockets, 128 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#workers: tip[pct imp](CV)       swqueue[pct imp](CV)     noshard[pct imp](CV)    shard_wakeup[pct imp](CV) shard_all[pct imp](CV)
  1     1.00 [  0.00](13.36)     0.90 [ 10.00](21.95)     0.87 [ 13.33]( 2.25)     0.83 [ 16.67](25.24)     0.97 [  3.33](20.80)
  2     1.00 [  0.00](15.57)     1.12 [-11.54]( 2.01)     1.04 [ -3.85](11.04)     1.08 [ -7.69](10.66)     1.08 [ -7.69]( 2.09)
  4     1.00 [  0.00]( 3.33)     1.03 [ -3.33]( 9.94)     1.17 [-16.67](16.38)     0.97 [  3.33]( 2.01)     0.97 [  3.33]( 2.01)
  8     1.00 [  0.00]( 3.18)     1.08 [ -8.11]( 5.29)     0.97 [  2.70]( 2.78)     1.00 [  0.00]( 9.79)     1.08 [ -8.11]( 4.22)
 16     1.00 [  0.00](14.63)     0.96 [  3.85]( 7.33)     1.15 [-15.38](13.09)     0.98 [  1.92]( 1.96)     0.96 [  3.85]( 3.40)
 32     1.00 [  0.00]( 1.49)     1.03 [ -2.60]( 3.80)     1.01 [ -1.30]( 1.95)     0.99 [  1.30]( 1.32)     0.99 [  1.30]( 2.25)
 64     1.00 [  0.00]( 0.00)     1.01 [ -0.80]( 1.64)     1.02 [ -1.60]( 1.63)     1.02 [ -2.40]( 0.78)     1.02 [ -1.60]( 1.21)
128     1.00 [  0.00]( 1.10)     0.99 [  0.87]( 0.88)     1.00 [  0.44]( 0.00)     0.98 [  2.18]( 0.77)     1.02 [ -1.75]( 1.96)
256     1.00 [  0.00]( 0.96)     0.99 [  0.76]( 0.22)     0.99 [  1.14]( 1.17)     0.97 [  3.43]( 0.20)     1.18 [-17.90](10.57)
512     1.00 [  0.00]( 0.73)     1.16 [-16.40]( 0.46)     1.17 [-17.45]( 1.38)     1.16 [-16.40]( 0.87)     1.08 [ -8.03]( 1.98)


==================================================================
Test          : new-schbench-requests-per-second 
Units         : Normalized Requests per second 
Interpretation: Higher is better 
==================================================================
Zen3, 2 Sockets, 64 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#workers: tip[pct imp](CV)       swqueue[pct imp](CV)     noshard[pct imp](CV)    shard_wakeup[pct imp](CV) shard_all[pct imp](CV)
  1     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.22)     1.00 [  0.00]( 0.25)     1.00 [  0.00]( 0.22)     1.00 [  0.00]( 0.12)
  2     1.00 [  0.00]( 0.21)     1.00 [  0.24]( 0.50)     1.00 [  0.00]( 0.12)     1.00 [  0.00]( 0.12)     1.00 [  0.24]( 0.12)
  4     1.00 [  0.00]( 0.12)     1.00 [  0.00]( 0.12)     1.00 [  0.24]( 0.12)     1.00 [  0.24]( 0.12)     1.00 [  0.00]( 0.12)
  8     1.00 [  0.00]( 0.12)     1.00 [  0.00]( 0.12)     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.12)     1.00 [  0.00]( 0.12)
 16     1.00 [  0.00]( 0.12)     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.12)     1.00 [ -0.24]( 0.12)     1.00 [ -0.48]( 0.12)
 32     1.00 [  0.00]( 3.00)     0.99 [ -1.38]( 0.25)     0.98 [ -1.93]( 0.14)     0.98 [ -2.20]( 0.15)     0.96 [ -4.13]( 0.39)
 64     1.00 [  0.00]( 3.74)     0.97 [ -3.11]( 0.49)     0.94 [ -5.87]( 1.53)     0.93 [ -7.25]( 2.01)     0.91 [ -8.64]( 0.39)
128     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)     0.99 [ -1.11]( 0.19)
256     1.00 [  0.00]( 0.26)     1.13 [ 12.58]( 0.34)     1.12 [ 11.84]( 0.20)     1.08 [  7.89]( 0.82)     1.02 [  1.73]( 1.31)
512     1.00 [  0.00]( 0.11)     1.00 [  0.43]( 0.33)     1.00 [  0.21]( 0.19)     1.00 [  0.21]( 0.29)     1.00 [ -0.43]( 0.11)

Zen4, 2 Sockets, 128 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#workers: tip[pct imp](CV)       swqueue[pct imp](CV)     noshard[pct imp](CV)    shard_wakeup[pct imp](CV) shard_all[pct imp](CV)
  1     1.00 [  0.00]( 0.23)     1.00 [  0.00]( 0.00)     0.99 [ -1.32]( 0.23)     0.98 [ -1.76]( 0.23)     1.00 [  0.00]( 0.00)
  2     1.00 [  0.00]( 0.11)     1.00 [  0.44]( 0.11)     0.99 [ -0.66]( 0.23)     0.98 [ -1.54]( 0.12)     1.00 [  0.22]( 0.11)
  4     1.00 [  0.00]( 0.00)     1.00 [  0.22]( 0.00)     0.99 [ -0.88]( 0.20)     0.99 [ -1.32]( 0.11)     1.00 [  0.22]( 0.00)
  8     1.00 [  0.00]( 0.11)     1.00 [  0.22]( 0.00)     0.99 [ -0.88]( 0.00)     0.98 [ -1.54]( 0.12)     1.00 [  0.22]( 0.00)
 16     1.00 [  0.00]( 0.11)     1.00 [  0.22]( 0.11)     0.99 [ -0.66]( 0.11)     0.99 [ -1.10]( 0.23)     1.00 [  0.22]( 0.00)
 32     1.00 [  0.00]( 0.00)     1.00 [  0.22]( 0.11)     1.00 [ -0.22]( 0.00)     0.99 [ -1.32]( 0.11)     1.00 [  0.44]( 0.11)
 64     1.00 [  0.00]( 0.00)     1.00 [  0.22]( 0.00)     1.00 [ -0.22]( 0.00)     0.99 [ -1.32]( 0.11)     1.00 [  0.22]( 0.00)
128     1.00 [  0.00]( 4.48)     1.03 [  3.03]( 0.12)     1.01 [  1.17]( 0.24)     1.00 [ -0.47]( 0.32)     0.99 [ -0.70]( 0.21)
256     1.00 [  0.00]( 0.00)     1.01 [  1.06]( 0.00)     1.01 [  0.84]( 0.11)     0.99 [ -1.48]( 0.29)     1.00 [  0.42]( 0.00)
512     1.00 [  0.00]( 0.36)     1.08 [  8.48]( 0.13)     1.08 [  7.68]( 0.13)     1.03 [  2.65]( 0.40)     1.03 [  2.65]( 1.16)

==================================================================
Test          : new-schbench-wakeup-latency 
Units         : Normalized 99th percentile latency in us 
Interpretation: Lower is better 
==================================================================
Zen3, 2 Sockets, 64 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#workers:  tip[pct imp](CV)    swqueue_v1[pct imp](CV)    noshard[pct imp](CV)    shard_wakeup[pct imp](CV) shard_all[pct imp](CV)
  1     1.00 [  0.00](22.13)     1.00 [  0.00](15.49)     1.00 [  0.00]( 8.15)     1.17 [-16.67]( 0.00)     1.50 [-50.00](19.36)
  2     1.00 [  0.00]( 0.00)     0.75 [ 25.00](15.49)     1.00 [  0.00](14.08)     1.00 [  0.00]( 6.74)     1.00 [  0.00]( 6.20)
  4     1.00 [  0.00](14.08)     1.00 [  0.00](14.08)     1.00 [  0.00](14.08)     1.00 [  0.00](14.08)     1.00 [  0.00]( 0.00)
  8     1.00 [  0.00]( 6.74)     0.75 [ 25.00](15.49)     0.88 [ 12.50](12.78)     0.75 [ 25.00](15.49)     1.12 [-12.50]( 5.96)
 16     1.00 [  0.00]( 0.00)     0.78 [ 22.22]( 0.00)     0.78 [ 22.22](13.47)     1.00 [  0.00](12.39)     1.00 [  0.00]( 0.00)
 32     1.00 [  0.00]( 9.94)     1.11 [-11.11](11.07)     1.11 [-11.11]( 5.34)     1.11 [-11.11](11.07)     1.11 [-11.11]( 5.34)
 64     1.00 [  0.00]( 8.37)     1.00 [  0.00]( 4.08)     1.00 [  0.00]( 4.08)     1.00 [  0.00]( 4.08)     1.08 [ -7.69]( 0.00)
128     1.00 [  0.00]( 1.27)     1.05 [ -4.88]( 1.19)     1.05 [ -4.88]( 2.08)     1.05 [ -4.88]( 0.00)     3.95 [-295.12]( 4.51)
256     1.00 [  0.00]( 0.22)     0.56 [ 43.91]( 1.05)     0.58 [ 42.42]( 1.24)     0.60 [ 40.06]( 9.74)     0.80 [ 20.12]( 1.06)
512     1.00 [  0.00](11.19)     1.14 [-14.13](18.63)     1.30 [-30.50](59.87)     0.98 [  2.25]( 3.40)     1.67 [-66.61](37.87)

Zen4, 2 Sockets, 128 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#workers:  tip[pct imp](CV)    swqueue_v1[pct imp](CV)    noshard[pct imp](CV)    shard_wakeup[pct imp](CV) shard_all[pct imp](CV)
  1     1.00 [  0.00](25.98)     0.85 [ 15.38](38.73)     0.85 [ 15.38](16.26)     0.69 [ 30.77](47.67)     0.85 [ 15.38]( 4.84)
  2     1.00 [  0.00]( 4.43)     1.00 [  0.00]( 4.19)     0.92 [  8.33]( 0.00)     1.00 [  0.00]( 4.43)     1.00 [  0.00]( 4.43)
  4     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 4.19)     0.92 [  8.33]( 0.00)     0.92 [  8.33]( 0.00)     1.00 [  0.00]( 0.00)
  8     1.00 [  0.00]( 0.00)     1.08 [ -8.33]( 0.00)     0.92 [  8.33]( 4.84)     0.92 [  8.33]( 0.00)     1.00 [  0.00]( 0.00)
 16     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)     0.92 [  8.33]( 0.00)     0.92 [  8.33]( 0.00)     1.00 [  0.00]( 0.00)
 32     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)     0.91 [  9.09]( 0.00)     1.00 [  0.00]( 4.84)     1.00 [  0.00]( 0.00)
 64     1.00 [  0.00]( 0.00)     1.10 [-10.00]( 0.00)     1.10 [-10.00]( 4.84)     1.10 [-10.00]( 0.00)     1.20 [-20.00]( 0.00)
128     1.00 [  0.00]( 7.75)     1.64 [-64.29]( 0.00)     1.50 [-50.00]( 2.42)     1.57 [-57.14]( 4.07)     1.71 [-71.43]( 2.18)
256     1.00 [  0.00]( 1.52)     1.05 [ -5.08]( 2.97)     1.03 [ -3.39](19.10)     1.10 [-10.17](16.79)     3.20 [-220.34](22.22)
512     1.00 [  0.00]( 0.26)     0.63 [ 37.01](48.00)     0.63 [ 36.51]( 4.25)     0.72 [ 28.50]( 4.44)     0.90 [  9.58]( 7.28)

==================================================================
Test          : new-schbench-request-latency 
Units         : Normalized 99th percentile latency in us 
Interpretation: Lower is better 
==================================================================
Zen3, 2 Sockets, 64 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#workers:  tip[pct imp](CV)    swqueue_v1[pct imp](CV)    noshard[pct imp](CV)    shard_wakeup[pct imp](CV) shard_all[pct imp](CV)
  1     1.00 [  0.00]( 0.17)     1.00 [ -0.33]( 0.29)     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.17)     1.00 [  0.00]( 0.17)
  2     1.00 [  0.00]( 0.17)     1.00 [  0.00]( 0.17)     1.00 [  0.00]( 0.17)     1.00 [  0.33]( 0.17)     1.00 [  0.00]( 0.00)
  4     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.29)     1.00 [  0.00]( 0.17)     1.00 [  0.33]( 0.17)     1.00 [  0.00]( 0.17)
  8     1.00 [  0.00]( 0.17)     1.00 [  0.00]( 0.00)     1.00 [  0.33]( 0.17)     1.00 [  0.33]( 0.17)     1.00 [  0.00]( 0.17)
 16     1.00 [  0.00]( 3.93)     0.95 [  4.71]( 0.17)     0.95 [  4.71](11.00)     1.04 [ -3.77]( 4.58)     1.18 [-18.21]( 7.53)
 32     1.00 [  0.00]( 9.53)     1.47 [-46.67](12.05)     1.37 [-36.84](14.04)     1.34 [-34.04]( 5.00)     1.63 [-62.57]( 4.20)
 64     1.00 [  0.00]( 6.01)     1.09 [ -9.29]( 0.22)     1.10 [ -9.76]( 0.11)     1.10 [ -9.99]( 0.11)     1.10 [-10.22]( 0.11)
128     1.00 [  0.00]( 0.28)     1.00 [  0.21]( 0.32)     1.00 [  0.00]( 0.11)     1.00 [  0.21]( 0.32)     1.85 [-84.79]( 0.11)
256     1.00 [  0.00]( 2.80)     1.02 [ -2.26]( 1.76)     1.07 [ -6.54]( 1.12)     1.19 [-19.37]( 7.04)     1.06 [ -5.79]( 1.55)
512     1.00 [  0.00]( 0.36)     1.02 [ -1.79]( 0.90)     1.00 [  0.20]( 1.63)     1.01 [ -1.39]( 0.37)     0.99 [  1.00]( 1.40)

Zen4, 2 Sockets, 128 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#workers:  tip[pct imp](CV)    swqueue_v1[pct imp](CV)    noshard[pct imp](CV)    shard_wakeup[pct imp](CV) shard_all[pct imp](CV)
  1     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.18)     1.01 [ -0.71]( 0.18)     1.01 [ -0.71]( 0.18)     1.00 [  0.35]( 0.32)
  2     1.00 [  0.00]( 0.18)     0.99 [  0.71]( 0.18)     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.18)     1.00 [  0.35]( 0.00)
  4     1.00 [  0.00]( 0.18)     1.00 [  0.35]( 0.00)     1.00 [ -0.35]( 0.00)     1.00 [ -0.35]( 0.00)     1.00 [  0.35]( 0.18)
  8     1.00 [  0.00]( 0.18)     0.99 [  0.71]( 0.18)     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)     1.00 [  0.35]( 0.00)
 16     1.00 [  0.00]( 0.00)     0.99 [  0.71]( 0.18)     1.00 [  0.00]( 0.18)     1.00 [  0.00]( 0.18)     1.00 [  0.35]( 0.00)
 32     1.00 [  0.00]( 0.00)     0.99 [  0.71]( 0.18)     1.00 [  0.00]( 0.00)     1.00 [ -0.35]( 0.00)     1.00 [  0.35]( 0.00)
 64     1.00 [  0.00]( 0.00)     1.00 [  0.35](31.00)     1.00 [ -0.35](29.77)     1.00 [ -0.35]( 0.18)     1.05 [ -5.11](30.08)
128     1.00 [  0.00]( 2.35)     0.98 [  1.52]( 0.35)     1.00 [  0.38]( 0.34)     1.03 [ -3.05]( 0.19)     1.01 [ -0.76]( 0.59)
256     1.00 [  0.00]( 0.18)     0.98 [  2.14]( 0.19)     0.99 [  1.43]( 0.19)     1.01 [ -1.07]( 0.18)     1.45 [-44.56](18.01)
512     1.00 [  0.00]( 0.55)     1.09 [ -9.45]( 1.79)     1.12 [-12.35]( 2.39)     1.15 [-14.93]( 1.68)     1.21 [-21.37]( 8.03)


==================================================================
Test          : SPECjbb2015
Units         : maxJOPs and critJOPs
Interpretation: Higher is better 
==================================================================
Zen3, 2 Sockets, 64 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Metric:    tip[pct imp]    swqueue_v1[pct imp] noshard[pct imp]  shard_wakeup[pct imp]  shard_all[pct imp]
maxJOPS    1.00 [  0.00]   1.00 [  0.00]       1.00 [  0.08]     1.01 [  1.42]           1.00 [  0.08]
critJOPS   1.00 [  0.00]   0.97 [ -3.43]       0.98 [ -2.38]     0.98 [ -1.82]           0.99 [ -0.96]

==================================================================
Test          : YCSB + Mongodb
Units         : Throughput
Interpretation: Higher is better 
==================================================================
Zen3, 2 Sockets, 64 cores per socket, SMT2:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Metric:    tip[pct imp](CV)       swqueue[pct imp](CV)  noshard[pct imp](CV) shard_wakeup[pct imp](CV)  shard_all[pct imp](CV)
Throughput 1.00 [  0.00]( 0.33)   0.99 [ -0.77]( 0.81)  0.99 [ -1.04](2.14)  0.99 [ -1.04]( 0.36)       0.99 [ -1.46]( 1.29)


Please let me know if you need any other data.

--
Thanks and Regards
gautham.
