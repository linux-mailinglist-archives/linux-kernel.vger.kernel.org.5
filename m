Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74754786D86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbjHXLOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbjHXLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:14:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D86CE68
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSHKumJZFeO4WB9M/d0af1rR2xT19pD8bAYkdvADmPu1revcKQl1H8T/p4/EFh0RFdM5FnArex5QIq6IE8t0i+yvSgCxBrM2RQLhGY3hrZIbQbJYqWP97f0jZdVflOyH5XGBcqQXmru+bi7zAFb5ETPQv7Kx4EK/Pbfu5JRg76igIFRIvYi9J94Nq9VGoffBddBRNiLNT4oQ6aBjzRf83lYkBlbpW3lW8VRed+t4DSDtZdGZCFy+AeW35U9nmo0MjKL5FV9BHneXHCylxdK4YtmyB51lY02yEQdvDmH/WJdY69zUysRfytGUn1Pt5wQc8q3Pe1B2NAJAn++bqDuYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbYCL+eYwUSudcsn0dyTwQTAm9V4fnvI3BddosHY7tg=;
 b=bfnzn34upc3+GhMLyhHHsMlht+lXnPLa038r3tzygviZQSSPddo1euW8TVwkIbsC0I+OoL8MWVresRLruYRwGoImDwYXH7mnMEM0PJLwv/pcH7UhLJYd5fdn8QiHsvu20Wnqt4zvB29zFd77utRd7dJfKaehJ2q7HMN8D/V/40RoYhW5/D/hT/uaqVwAkHEdD6eHdTsUa6Rp6e/yte9da7LVeTrPxvlQLGKmjihsGk83tmYUomFZcCF4mmD7rxu5C46/cdjiyijBU8JqK3G0GbPMWVp02MLOWfgZV+et8qAquByWnVZtr1z1ijL1PwLHxTVg6eXhCFdtrdkPfWvYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbYCL+eYwUSudcsn0dyTwQTAm9V4fnvI3BddosHY7tg=;
 b=NM7ib7pAaPLjv3sMPi4SvO5O6eYP3466uCEmaETdHP9jPu6+xvo9WzXYPikaY1cXB0jWT0JJAtKhUc7+I8KY/ePUoCpLWA9kAb6NHEb8bKUR5U1yFYC8/YR173DU7c+bp86zR46dQSqLpCmhE1HPcJJv83FBwV25URgdmn0VlgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 11:14:32 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6769:d6da:514c:90ab]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6769:d6da:514c:90ab%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 11:14:32 +0000
Date:   Thu, 24 Aug 2023 16:44:19 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, kprateek.nayak@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: Re: [PATCH v3 0/7] sched: Implement shared runqueue in CFS
Message-ID: <ZOc7i7wM0x4hF4vL@BLR-5CG11610CF.amd.com>
References: <20230809221218.163894-1-void@manifault.com>
 <ZN3dW5Gvcb0LFWjs@BLR-5CG11610CF.amd.com>
 <20230818050355.GA5718@maniforge>
 <ZN8wfiAVttkNnFDe@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN8wfiAVttkNnFDe@BLR-5CG11610CF.amd.com>
X-ClientProxiedBy: PN0PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: b4009860-c2ba-4a18-817e-08dba4934a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XMkyii54Q156abeck9+GF0zGoCm+CMSyh9KiC9Pn0E4c0iI1e+Uoy+YRIWZkKM7e9crNF9+rldYrSDgyq7lcQILYJNDi9T/os64UzDPEF4ESkisfwg/N3ZY4ljhHD5jDXlEPpZgh+HyrTFcT03zokI2P1kxfJMl5lwbXHjxP6BEHaAn8vY0uDUt9bxYytTUdSbhaW83htw3yqlJPyqDvD0BBpf4v0/L0FAbqWs9+De0xr0fMfiwgtRE2Vg3oC3e9kcOmPE2DAlBLBwpbtTxJS3KlvLE6t1O3pUSjS5gvjhxCMNvVfAZLuagNDUe013PNeJLkVNvA0PiGDTug4o46NSIH65HG++pH4vxxnt14jpyhDTeYU0G+zBYp4SF9fnBJB8ZdQCkgRoVUZu6e7JHUCfFILxKhmkoYMEetOVQ5FmTcWs8nl1aH4Mhy9+lH3wHaJeqlT54fUygS+M03MSjD4FPgPEhP4oU6o9T0ZoqEdcT33Zhi7PqzFEurC6A0GdzxfNCVFQsrmuD934coWpo6lG45yN+k7M4AH5DZgMS7SFe65zeinKyPtXtHOFaECXn9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(186009)(1800799009)(451199024)(5660300002)(4326008)(8676002)(8936002)(30864003)(83380400001)(7416002)(26005)(6666004)(38100700002)(66556008)(66476007)(66946007)(6916009)(316002)(478600001)(41300700001)(2906002)(6512007)(6506007)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bgmrd9dpWlPwzUH6jJYvwxcfFlVy6fV/9F/w9u9s6+JCPXZ2WZHfCd9SLp3W?=
 =?us-ascii?Q?t+7HlLfy3ff4y8HmK4kCsdJQJ+Ky8RPCIjkkX6MDs7A2cWZ8BcLfBEFe8RMN?=
 =?us-ascii?Q?61Z5LWxIjKi7w+6O/shM4jIuzgQbLrlZy/8ZSz8/JaHOvdzeZ43vfwGksT37?=
 =?us-ascii?Q?s6+rjgsJmcD5xxJtZOcgbGAgZvWZLINUpU2uMQUHvqN3b+1+68T/wnKAJDFW?=
 =?us-ascii?Q?b+zJ1SdrRblqcwEaKHsGONmVnu3cu+fUNX3chqBy86dDomciFZXDq02Z7XFl?=
 =?us-ascii?Q?LPmEIU+QiAyLYkedHfbuyG4u2Rrax5dM3tnAoPwanq6P2OsDJZYWr37QXeps?=
 =?us-ascii?Q?5DcJ/jM42BWLg+2iTC8Gf8OQ/3qtUY7TTaXALAQIh7kD5ipdoKuY1HbIFUXk?=
 =?us-ascii?Q?WX1eSSTB/qNnEMZR6OpdYbdzYjs2JV1ELUO/s5x0zKrc2GtNig8QNUmCXMVz?=
 =?us-ascii?Q?7qmhOgs8993n6GKV99EwM586RG7f67drBt20cZoewc06StWTo2uUdnrh5txR?=
 =?us-ascii?Q?3FcOjDTpA3shuXfUdyd9c/DWBkYoQh3Bi9eHZtCscnPvPrk8HvrFzai9b9th?=
 =?us-ascii?Q?qe/YFkO1dGnXOwge3gQsU0M/N5gGPNuY/7BS5Amumal1eTeiPgp0nEgD6dIG?=
 =?us-ascii?Q?W7J7YlRQVth7dkxPcp9f+URU7paDH4ydefrP4FPFpsn/83PWBKBdO1EBZ9Xw?=
 =?us-ascii?Q?D59eZgCzJmF3n0LSRblheAbGnwRdnsRfe8Wyi3wFVhH6s3//uR4AiAKU4Vbd?=
 =?us-ascii?Q?HvFTTIyi9MUTURdcACjeBzon9RGVvlybOayA8MwrJXFnuLqVRQSiET/dGbGI?=
 =?us-ascii?Q?xr3+w2oeE7lI84KJGf3jNyDFGltqFg7Lm51LgyeZOlUVrz9TWmCeereAkewH?=
 =?us-ascii?Q?Hmb6qU+PbNHiwQyqMc63xQQApoXGqLUbDPmq/HahbqqqXd1z5k0jwrv2dzb5?=
 =?us-ascii?Q?qKpvTge2IS620uExwsVPVSgakY6IrGzFhfva6URfGFPu3+1pyfnvEi2JH7DD?=
 =?us-ascii?Q?jxKFWRHgPFzUesgnxAl7S611pLOXio3/Bc1N3lOiWagAua7DnTIpTLlVWLBe?=
 =?us-ascii?Q?Jw5tCCBboaGulxkSTCi3cfzvg3CKqkrZHJ9lXMdDw7udqz/ZshaJpF6uKPoO?=
 =?us-ascii?Q?gcQowIV8Z0LtZwUAaZU2DkoRZdVUX2GoXRxExr4RGvoprpFNH+k05gbIOZUt?=
 =?us-ascii?Q?TTTElQ0VIFGcmB9IkyYdZl5IYO+rjMbYl737fGMFnpPA0FuP8JFHbupFVp1f?=
 =?us-ascii?Q?IZcRNySptDYEvLltznbRKQC/6cdo31WihjPlutEDqyKkgI78on4kXzmWaZNb?=
 =?us-ascii?Q?ZqCVorJtXKMQoxsqWEFv0uGFUte56Myc+J0cpBD8Pc8NzJx4+HiUnX0ow0cY?=
 =?us-ascii?Q?GwKUkCazOET+FTnVWruT88Y8bI2PKAZzhv6DPW4qm9CNj+LtGBhu03tfjK9Z?=
 =?us-ascii?Q?CCKA0wk35/jUK4qo4a6hivEpYEX18wuBIAzC/nTT250atw3Z4n5qIwWxMoB1?=
 =?us-ascii?Q?m60G/22bwCPdot629Zts5l39pEucE8ESdwXEOKeoZbDkFERelphmDLOe8SA7?=
 =?us-ascii?Q?klDPHZnBfxHO5VRHZzGqBRQcmrsQvXigswZRjX5g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4009860-c2ba-4a18-817e-08dba4934a47
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 11:14:31.8781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dg6nZNE0C4mSvjAf2QYphOgotObKM4L6AJ8TfjXGnDnxTLnk00Ch6dZK4MLd3keVclLp0Dv8xLUxGoRyhzP0DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Fri, Aug 18, 2023 at 02:19:03PM +0530, Gautham R. Shenoy wrote:
> Hello David,
> 
> On Fri, Aug 18, 2023 at 12:03:55AM -0500, David Vernet wrote:
> > On Thu, Aug 17, 2023 at 02:12:03PM +0530, Gautham R. Shenoy wrote:
> > > Hello David,
> > 
> > Hello Gautham,
> > 
> > Thanks a lot as always for running some benchmarks and analyzing these
> > changes.
> > 
> > > On Wed, Aug 09, 2023 at 05:12:11PM -0500, David Vernet wrote:
> > > > Changes
> > > > -------
> > > > 
> > > > This is v3 of the shared runqueue patchset. This patch set is based off
> > > > of commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
> > > > bandwidth in use") on the sched/core branch of tip.git.
> > > 
> > > 
> > > I tested the patches on Zen3 and Zen4 EPYC Servers like last time. I
> > > notice that apart from hackbench, every other bechmark is showing
> > > regressions with this patch series. Quick summary of my observations:
> > 
> > Just to verify per our prior conversation [0], was this latest set of
> > benchmarks run with boost disabled?
> 
> Boost is enabled by default. I will queue a run tonight with boost
> disabled.

Apologies for the delay. I didn't see any changes with boost-disabled
and with reverting the optimization to bail out of the
newidle_balance() for SMT and MC domains when there was no task to be
pulled from the shared-runq. I reran the whole thing once again, just
to rule out any possible variance. The results came out the same.

With the boost disabled, and the optimization reverted, the results
don't change much.

It doesn't appear that the optimization is the cause for increase in
the number of load-balancing attempts at the DIE and the NUMA
domains. I have shared the counts of the newidle_balance with and
without SHARED_RUNQ below for tbench and it can be noticed that the
counts are significantly higher for the 64 clients and 128 clients. I
also captured the counts/s of find_busiest_group() using funccount.py
which tells the same story. So the drop in the performance for tbench
with your patches strongly correlates with the increase in
load-balancing attempts.

newidle balance is undertaken only if the overload flag is set and the
expected idle duration is greater than the avg load balancing cost. It
is hard to imagine why should the shared runq cause the overload flag
to be set!


Detailed Results are as follows:
=============================================================
Test Machine : 2 Socket Zen4 with 128 cores per socket, SMT enabled.

tip             : commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
v3              : v3 of the shared_runq patch
v3-tgfix        : v3+ Aaron's RFC v1 patch to ratelimit the updates to tg->load_avg
v3-tgfix-no-opt : v3-tgfix + revered the optimization to bail out of
                  newidle-balance for SMT and MC domains when there
                  are no tasks in the shared-runq

In the results below, I have chosen the first row, first column in the
table as the baseline so that we get an idea of the scalability issues
as the number of groups/clients/workers increase.

==================================================================
Test          : hackbench 
Units         : Normalized time in seconds 
Interpretation: Lower is better 
Statistic     : AMean 
==================================================================
Case:         tip[pct imp](CV)            v3[pct imp](CV)      v3-tgfix[pct imp](CV)    v3-tgfix-no-opt[pct imp](CV)
 1-groups     1.00 [ -0.00]( 4.22)     0.92 [  7.75]( 9.09)     0.88 [ 11.53](10.61)     0.85 [ 15.31]( 8.20)
 2-groups     0.88 [ -0.00](11.65)     0.85 [  2.95](10.77)     0.88 [ -0.91]( 9.69)     0.88 [ -0.23]( 9.20)
 4-groups     1.08 [ -0.00]( 3.70)     0.93 [ 13.86](11.03)     0.90 [ 16.08]( 9.57)     0.83 [ 22.92]( 6.98)
 8-groups     1.32 [ -0.00]( 0.63)     1.16 [ 12.33]( 9.05)     1.21 [  8.72]( 5.54)     1.17 [ 11.13]( 5.29)
16-groups     1.71 [ -0.00]( 0.63)     1.93 [-12.65]( 4.68)     1.27 [ 25.87]( 1.31)     1.25 [ 27.15]( 1.10)


==================================================================
Test          : tbench 
Units         : Normalized throughput 
Interpretation: Higher is better 
Statistic     : AMean 
==================================================================
Clients:   tip[pct imp](CV)            v3[pct imp](CV)      v3-tgfix[pct imp](CV)    v3-tgfix-no-opt[pct imp](CV)
    1      1.00 [  0.00]( 0.18)      0.99 [ -0.99]( 0.18)      0.98 [ -2.08]( 0.10)      0.98 [ -2.19]( 0.24)
    2      1.95 [  0.00]( 0.65)      1.93 [ -1.04]( 0.72)      1.95 [ -0.37]( 0.31)      1.92 [ -1.73]( 0.39)
    4      3.80 [  0.00]( 0.59)      3.78 [ -0.53]( 0.37)      3.73 [ -1.66]( 0.58)      3.77 [ -0.79]( 0.97)
    8      7.49 [  0.00]( 0.37)      7.41 [ -1.12]( 0.39)      7.24 [ -3.42]( 1.99)      7.39 [ -1.39]( 1.53)
   16     14.78 [  0.00]( 0.84)     14.60 [ -1.24]( 1.51)     14.30 [ -3.28]( 1.28)     14.46 [ -2.18]( 0.78)
   32     28.18 [  0.00]( 1.26)     26.59 [ -5.65]( 0.46)     27.70 [ -1.71]( 0.92)     27.08 [ -3.90]( 0.83)
   64     55.05 [  0.00]( 1.56)     18.25 [-66.85]( 0.25)     48.07 [-12.68]( 1.51)     47.46 [-13.79]( 2.70)
  128    102.26 [  0.00]( 1.03)     21.74 [-78.74]( 0.65)     54.65 [-46.56]( 1.35)     54.69 [-46.52]( 1.16)
  256    156.69 [  0.00]( 0.27)     25.47 [-83.74]( 0.07)    130.85 [-16.49]( 0.57)    125.00 [-20.23]( 0.35)
  512    223.22 [  0.00]( 8.25)    236.98 [  6.17](17.10)    274.47 [ 22.96]( 0.44)    276.95 [ 24.07]( 3.37)
 1024    237.98 [  0.00]( 1.09)    299.72 [ 25.94]( 0.24)    304.89 [ 28.12]( 0.73)    300.37 [ 26.22]( 1.16)
 2048    242.13 [  0.00]( 0.37)    311.38 [ 28.60]( 0.24)    299.82 [ 23.82]( 1.35)    291.32 [ 20.31]( 0.66)


I reran tbench for v3-tgfix-no-opt, to collect the newidle balance
counts via schedstat as well as the find_busiest_group() counts via
funccount.py.

Comparison of the newidle balance counts across different
sched-domains for "v3-tgfix-no-opt" kernel with NO_SHARED_RUNQ vs
SHARED_RUNQ. We see a huge blowup for the DIE and the NUMA domains
when the number of clients are 64 and 128. The value within |xx.yy|
indicates the percentage increase when the difference is significant.

============== SMT load_balance with CPU_NEWLY_IDLE ===============================
   1 clients: count : 1986, 1960 
   2 clients: count : 5777, 6543     |  13.26|
   4 clients: count : 16775, 15274   |  -8.95|
   8 clients: count : 37086, 32715   | -11.79|
  16 clients: count : 69627, 65652   |  -5.71|
  32 clients: count : 152288, 42723  | -71.95|
  64 clients: count : 216396, 169545 | -21.65|
 128 clients: count : 219570, 649880 | 195.98|
 256 clients: count : 443595, 951933 | 114.60|
 512 clients: count : 5498, 1949     | -64.55|
1024 clients: count : 60, 3          | -95.00|
================ MC load_balance with CPU_NEWLY_IDLE ===============================
   1 clients: count : 1954, 1943
   2 clients: count : 5775, 6541      |  13.26|
   4 clients: count : 15468, 15087 
   8 clients: count : 31941, 32140 
  16 clients: count : 57312, 62553    |   9.14|
  32 clients: count : 125791, 34386   | -72.66|
  64 clients: count : 181406, 133978  | -26.14|
 128 clients: count : 191143, 607594  | 217.87|
 256 clients: count : 388696, 584568  |  50.39| 
 512 clients: count : 2677, 218       | -91.86|
1024 clients: count : 22, 3           | -86.36|
=============== DIE load_balance with CPU_NEWLY_IDLE ===============================
   1 clients: count : 10, 15          |   50.00|
   2 clients: count : 15, 56          |  273.33|
   4 clients: count : 65, 149         |  129.23|
   8 clients: count : 242, 412        |   70.25|
  16 clients: count : 509, 1235       |  142.63|
  32 clients: count : 909, 1371       |   50.83|
  64 clients: count : 1288, 59596     | 4527.02| <===
 128 clients: count : 666, 281426     |42156.16| <===
 256 clients: count : 213, 1463       |  586.85|
 512 clients: count : 28, 23          |  -17.86|
1024 clients: count : 10, 3           |  -70.00|
============== NUMA load_balance with CPU_NEWLY_IDLE ===============================
   1 clients: count : 9, 9 
   2 clients: count : 13, 14
   4 clients: count : 21, 21
   8 clients: count : 27, 29
  16 clients: count : 29, 50         |   72.41|
  32 clients: count : 29, 67         |  131.03|
  64 clients: count : 28, 9138       |32535.71|  <===
 128 clients: count : 25, 24234      |96836.00|  <===
 256 clients: count : 12, 11
 512 clients: count : 7, 3  
1024 clients: count : 4, 3 


Further, collected the find_busiest_group() count/s using
funccount.py.

Notice that with 128 clients, most samples with SHARED_RUNQ fall into
the bucket which is > 2x of the buckets where we have most of the
samples of NO_SHARED_RUNQ runs.

128 clients: find_busiest_group() count/s
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fbg count bucket       NO_SHARED_RUNQ   SHARED_RUNQ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[2000000 - 2500000) :     23
[2500000 - 3000000) :     19               
[3000000 - 3500000) :     19               1
[3500000 - 4000000) :      3               3
[7500000 - 8000000) :                      5
[8000000 - 8500000) :                     54   <===

With 1024 clients, there is not a whole lot of difference in the
find_busiest_group() distribution with and without the SHARED_RUNQ.

1024 clients: find_busiest_group() count/s
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fbg count bucket       NO_SHARED_RUNQ   SHARED_RUNQ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[  4000 -   5000) :      1
[  7000 -   8000) :      2                  2
[  8000 -   9000) :      1                  2
[  9000 -  10000) :     57                 44  <===
[ 10000 -  11000) :      3                 13
[ 18000 -  19000) :      1                  1



==================================================================
Test          : stream (10  Runs)
Units         : Normalized Bandwidth, MB/s 
Interpretation: Higher is better 
Statistic     : HMean 
==================================================================
Test:     tip[pct imp](CV)            v3[pct imp](CV)      v3-tgfix[pct imp](CV)    v3-tgfix-no-opt[pct imp](CV)
 Copy     1.00 [  0.00]( 0.53)     1.00 [  0.01]( 0.77)     1.00 [ -0.22]( 0.55)     1.00 [  0.12]( 0.71)
Scale     0.95 [  0.00]( 0.23)     0.95 [  0.21]( 0.63)     0.95 [  0.13]( 0.22)     0.95 [  0.02]( 0.87)
  Add     0.97 [  0.00]( 0.27)     0.98 [  0.40]( 0.59)     0.98 [  0.52]( 0.31)     0.98 [  0.16]( 0.85)
Triad     0.98 [  0.00]( 0.28)     0.98 [  0.33]( 0.55)     0.98 [  0.34]( 0.29)     0.98 [  0.05]( 0.96)


==================================================================
Test          : stream (100 Runs)
Units         : Normalized Bandwidth, MB/s 
Interpretation: Higher is better 
Statistic     : HMean 
==================================================================
Test:     tip[pct imp](CV)            v3[pct imp](CV)      v3-tgfix[pct imp](CV)    v3-tgfix-no-opt[pct imp](CV)
 Copy     1.00 [  0.00]( 1.01)     1.00 [ -0.38]( 0.34)     1.00 [  0.08]( 1.19)     1.00 [ -0.18]( 0.38)
Scale     0.95 [  0.00]( 0.46)     0.95 [ -0.39]( 0.52)     0.94 [ -0.72]( 0.34)     0.94 [ -0.66]( 0.40)
  Add     0.98 [  0.00]( 0.16)     0.98 [ -0.40]( 0.53)     0.97 [ -0.80]( 0.26)     0.97 [ -0.79]( 0.34)
Triad     0.98 [  0.00]( 0.14)     0.98 [ -0.35]( 0.54)     0.97 [ -0.79]( 0.17)     0.97 [ -0.79]( 0.28)


==================================================================
Test          : netperf 
Units         : Normalized Througput per client
Interpretation: Higher is better 
Statistic     : AMean 
==================================================================
Clients:        tip[pct imp](CV)            v3[pct imp](CV)      v3-tgfix[pct imp](CV)    v3-tgfix-no-opt[pct imp](CV)
 1-clients      1.00 [  0.00]( 0.84)     0.99 [ -0.64]( 0.10)     0.97 [ -2.61]( 0.29)     0.98 [ -2.24]( 0.16)
 2-clients      1.00 [  0.00]( 0.47)     0.99 [ -1.07]( 0.42)     0.98 [ -2.27]( 0.33)     0.97 [ -2.75]( 0.24)
 4-clients      1.01 [  0.00]( 0.45)     0.99 [ -1.41]( 0.39)     0.98 [ -2.82]( 0.31)     0.97 [ -3.23]( 0.23)
 8-clients      1.00 [  0.00]( 0.39)     0.99 [ -1.95]( 0.29)     0.98 [ -2.78]( 0.25)     0.97 [ -3.62]( 0.39)
16-clients      1.00 [  0.00]( 1.81)     0.97 [ -2.77]( 0.41)     0.97 [ -3.26]( 0.35)     0.96 [ -3.99]( 1.45)
32-clients      1.00 [  0.00]( 1.87)     0.39 [-60.63]( 1.29)     0.95 [ -4.68]( 1.45)     0.95 [ -4.89]( 1.41)
64-clients      0.98 [  0.00]( 2.70)     0.24 [-75.29]( 1.26)     0.66 [-33.23]( 0.99)     0.65 [-34.05]( 2.39)
128-clients     0.90 [  0.00]( 2.48)     0.14 [-84.47]( 3.63)     0.36 [-60.00]( 1.37)     0.36 [-60.36]( 1.54)
256-clients     0.67 [  0.00]( 2.91)     0.08 [-87.79]( 9.27)     0.54 [-20.38]( 3.69)     0.52 [-22.94]( 3.81)
512-clients     0.36 [  0.00]( 8.11)     0.51 [ 39.96]( 4.92)     0.38 [  5.12]( 6.24)     0.39 [  5.88]( 6.13)


==================================================================
Test          : schbench throughput
Units         : Normalized Requests per second 
Interpretation: Higher is better 
Statistic     : Median 
==================================================================
#workers: tip[pct imp](CV)          v3[pct imp](CV)      v3-tgfix[pct imp](CV)    v3-tgfix-no-opt[pct imp](CV)
  1      1.00 [  0.00]( 0.24)      1.01 [  0.93]( 0.00)      1.01 [  0.93]( 0.24)      1.00 [  0.47]( 0.24)
  2      2.01 [  0.00]( 0.12)      2.03 [  0.93]( 0.00)      2.03 [  1.16]( 0.00)      2.01 [  0.00]( 0.12)
  4      4.03 [  0.00]( 0.12)      4.06 [  0.70]( 0.00)      4.07 [  0.93]( 0.00)      4.02 [ -0.23]( 0.24)
  8      8.05 [  0.00]( 0.00)      8.12 [  0.93]( 0.00)      8.14 [  1.16]( 0.00)      8.07 [  0.23]( 0.00)
 16     16.17 [  0.00]( 0.12)     16.24 [  0.46]( 0.12)     16.28 [  0.69]( 0.00)     16.17 [  0.00]( 0.12)
 32     32.34 [  0.00]( 0.12)     32.49 [  0.46]( 0.00)     32.56 [  0.69]( 0.00)     32.34 [  0.00]( 0.00)
 64     64.52 [  0.00]( 0.12)     64.82 [  0.46]( 0.00)     64.97 [  0.70]( 0.00)     64.52 [  0.00]( 0.00)
128    127.25 [  0.00]( 1.48)    121.57 [ -4.47]( 0.38)    120.37 [ -5.41]( 0.13)    120.07 [ -5.64]( 0.34)
256    135.33 [  0.00]( 0.11)    136.52 [  0.88]( 0.11)    136.22 [  0.66]( 0.11)    136.52 [  0.88]( 0.11)
512    107.81 [  0.00]( 0.29)    109.91 [  1.94]( 0.92)    109.91 [  1.94]( 0.14)    109.91 [  1.94]( 0.14)


==================================================================
Test          : schbench wakeup-latency 
Units         : Normalized 99th percentile latency in us 
Interpretation: Lower is better 
Statistic     : Median 
==================================================================

#workers: tip[pct imp](CV)          v3[pct imp](CV)      v3-tgfix[pct imp](CV)    v3-tgfix-no-opt[pct imp](CV)
  1       1.00 [ -0.00](14.08)       0.80 [ 20.00](11.92)       1.00 [ -0.00]( 9.68)       1.40 [-40.00](18.75)
  2       1.20 [ -0.00]( 4.43)       1.10 [  8.33]( 4.84)       1.10 [  8.33]( 0.00)       1.10 [  8.33]( 4.56)
  4       1.10 [ -0.00]( 0.00)       1.10 [ -0.00]( 4.56)       1.10 [ -0.00]( 0.00)       1.10 [ -0.00]( 0.00)
  8       1.10 [ -0.00]( 0.00)       1.10 [ -0.00]( 4.56)       1.10 [ -0.00]( 0.00)       1.10 [ -0.00]( 0.00)
 16       1.10 [ -0.00]( 4.84)       1.20 [ -9.09]( 0.00)       1.10 [ -0.00]( 0.00)       1.10 [ -0.00]( 0.00)
 32       1.00 [ -0.00]( 0.00)       1.10 [-10.00]( 0.00)       1.10 [-10.00]( 0.00)       1.00 [ -0.00]( 0.00)
 64       1.00 [ -0.00]( 5.34)       1.10 [-10.00]( 0.00)       1.10 [-10.00]( 0.00)       1.10 [-10.00]( 0.00)
128       1.20 [ -0.00]( 4.19)       2.10 [-75.00]( 2.50)       2.10 [-75.00]( 2.50)       2.10 [-75.00]( 0.00)
256       5.90 [ -0.00]( 0.00)      12.10 [-105.08](14.03)     11.10 [-88.14]( 4.53)      12.70 [-115.25]( 5.17)
512    2627.20 [ -0.00]( 1.21)    2288.00 [ 12.91]( 9.76)    2377.60 [  9.50]( 2.40)    2281.60 [ 13.15]( 0.77)


==================================================================
Test          : schbench request-latency 
Units         : Normalized 99th percentile latency in us 
Interpretation: Lower is better 
Statistic     : Median 
==================================================================
#workers: tip[pct imp](CV)          v3[pct imp](CV)      v3-tgfix[pct imp](CV)    v3-tgfix-no-opt[pct imp](CV)
  1     1.00 [ -0.00]( 0.35)     1.00 [  0.34]( 0.17)     0.99 [  0.67]( 0.30)     1.00 [ -0.34]( 0.00)
  2     1.00 [ -0.00]( 0.17)     1.00 [  0.34]( 0.00)     0.99 [  1.01]( 0.00)     1.00 [ -0.34]( 0.17)
  4     1.00 [ -0.00]( 0.00)     1.00 [  0.34]( 0.00)     0.99 [  1.01]( 0.00)     1.00 [ -0.00]( 0.17)
  8     1.00 [ -0.00]( 0.17)     1.00 [  0.34]( 0.17)     0.99 [  1.34]( 0.18)     1.00 [  0.34]( 0.17)
 16     1.00 [ -0.00]( 0.00)     1.00 [  0.67]( 0.17)     0.99 [  1.34]( 0.35)     1.00 [ -0.00]( 0.00)
 32     1.00 [ -0.00]( 0.00)     1.00 [  0.67]( 0.00)     0.99 [  1.34]( 0.00)     1.00 [ -0.00]( 0.00)
 64     1.00 [ -0.00]( 0.00)     1.00 [  0.34]( 0.17)     1.00 [  0.67]( 0.00)     1.00 [ -0.00]( 0.17)
128     1.82 [ -0.00]( 0.83)     1.85 [ -1.48]( 0.00)     1.85 [ -1.85]( 0.37)     1.85 [ -1.85]( 0.19)
256     1.94 [ -0.00]( 0.18)     1.96 [ -1.04]( 0.36)     1.95 [ -0.69]( 0.18)     1.95 [ -0.35]( 0.18)
512    13.27 [ -0.00]( 5.00)    16.32 [-23.00]( 8.33)    16.16 [-21.78]( 1.05)    15.46 [-16.51]( 0.89)

 
 --
 Thanks and Regards
 gautham.
