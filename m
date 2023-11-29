Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CA87FDF13
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjK2SHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2SHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:07:40 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02hn2203.outbound.protection.outlook.com [52.100.160.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0BFAF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:07:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSF6DbxAGsovnpjpFLyxX8+xUdvxDIqQ45lrFte7HNujxBIzuh91qZELfWoJ5JwiVQbwKoaV++oxlVwgHtvcYsDU7PUF2nrq8MXXQ4BgsqDERJ1Z+LndT8hjPnGis0Zi2UdwK6yUz71C1L3661MNGND1IWFaR/fbxfsNpmL93079rNTQiH239642Lug/b2vzWmiHBIalgqsoUEdzon/RwlYQe0OvCPQm6LjgRhxn97SsMbjGrONagOQJgX9b65DJiGcoKUQNO4lIi+v5MxyS5gSlsVr9jq1EucKJ8JxnaNtnIf7sP4RqtddZc1kLBd0dkvAU7rWTjNEgYwsB0uWTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJzRtKepzC6G7MjhLnASDPMHl3pG2yELqMj+4yHXdHM=;
 b=PRPaAZrPKr2DWC0DQZ6icYLDk8ta0fr8mQjYZ5npugI8W3agGQK9/da+EFYyEojcdCznr+oK5JvqubxOSI10lAoB9Rzv8JDs05Zcepxmcq510sKvebi4HnLMK1N2BqR8Fb6OHmRW6OtfjTmo6VtUzOTKoH3BdWFpy49zHwL6eeyfeOKERPrLCWwkBJQ+85mvCOkskibTy7sKYKT6v8QPEvmN37aYKp0VRFbLLE8f5Gaj/m5JPFQcUyjcRaq5RS99u145kGO+NYO6mKBSbAJfyb8LIrqMRuvaPqrAK1TEGypBLW8opVgYd88LnnstEuYyx8klwAUjWqKfplqQAEPRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJzRtKepzC6G7MjhLnASDPMHl3pG2yELqMj+4yHXdHM=;
 b=kLq0wMyCWL2wKJYWU0iYzEy7EK+In9m8qDN0qxxU0x/7wLXX0xdz+ymkFxcX9IRaZilitiSs3e8RM0xhhxpXlGoQT31ueEzkULzP5znpB4IJoK+XzGc4Ar4l17VvC+S01fO0f2UUgM5hny5KuO6E7RZskCEKt+rtE5O4i5TV61sMN3/K3LLU+LpFrI6+z1l8zuM1mKvxlaAtjO+4w/dAcCE96dxEWVJWY/3GorYohKDusxSuUu80std8W6eWcEgBIip1B9wfGKP8RqjHzxRUKGrX6r/xNAvQiOOC0YCJOpN00EZrGrArsh71mpRmJ5a+F/QWJiXamkDtCx5wnsR4pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 18:07:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 18:07:41 +0000
Date:   Wed, 29 Nov 2023 14:07:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231129180739.GX436702@nvidia.com>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-3-saeed@kernel.org>
 <2023112727-caddie-eardrum-efe8@gregkh>
 <ZWb_l7rC4QK8duU3@x130>
 <2023112938-unhook-defiance-75ed@gregkh>
 <20231129130200.GV436702@nvidia.com>
 <2023112951-civil-risotto-50dc@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112951-civil-risotto-50dc@gregkh>
X-ClientProxiedBy: DM6PR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:5:14c::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a098c9-992b-4028-a0a7-08dbf10613f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D5nNWjTugR7W4w4nx8C8Nq2q6L7em1ZMFFreohsDOVSLPU03EQIrUlaclbGx?=
 =?us-ascii?Q?vltsEvJdJCJ3dcX56rUs7wIE8borjrgZ20kbigcEDjN5OisTj3rASo3wnOhS?=
 =?us-ascii?Q?RUxtjZB/Nwzcm0kGCAvkTSxqKii8/+2nGgvZbI/AbUIU6D/og5OY5L5I+mLZ?=
 =?us-ascii?Q?JdRy6VKN2NEPD6+4lAsi1Qz3RuS7kqck8Nu8RsjzHuijFw6U1XHdJWCoSXHq?=
 =?us-ascii?Q?DoM/7ENjmHX0OLaPlqSuPMc7ZK707T3xad7FlRc51tvN2gfn8femInxG2icS?=
 =?us-ascii?Q?YyPt+dtOF1fQqFmsgUj59VuXtHEOyY+RxjEiXUe8VL3G/PgMW99Oim2H9dMH?=
 =?us-ascii?Q?lBKqtCdbBOLsdiO6uxtRljGpLYPo5yEIRD8Gqj1oGDnWR0N0TfxQGydSkTMM?=
 =?us-ascii?Q?1hBXCZwi77wSOw+tcJhU/I8DcvJpKZd/LCjJdZAYWNgmCXgzHcmD0vLGT4Ib?=
 =?us-ascii?Q?DxpM0VgphTPSwO4BclL+yhmIG5gQ+ecQ79OAuJJehWF0u3sT51vI2jd3ObMv?=
 =?us-ascii?Q?RRDQUvIJ9bjS9Oal8bhdRjzzEiloemEPeKU7ZluI4TWjEfueRzanYT/L8k1d?=
 =?us-ascii?Q?qCbsqtVoom0HrWOSsS2JWbtvkZwdkQBdEFOUbX/yQpNbyys6b5XnxGhN3E3m?=
 =?us-ascii?Q?hX8K8lgZTHoKc+3KwP48gDUNGThVPTA4XgRsGJWfp/gDmn5M21W3K81hPdyj?=
 =?us-ascii?Q?MSKIvkED67J5lSeNKg+Q3e3jchs6S7WIwkvcPzUh0hXXIEv+6YqZz7dS30Vt?=
 =?us-ascii?Q?JnIo8uXo+kQX9kd1xPsvW9totLvToGzgLOth6NF2vRokrpFuhMVNdfZMwfi/?=
 =?us-ascii?Q?9RCGT/rp+uG+nRBOgDdAJFm/fvbTfTF2ZGEL6d2ONYoMDU5nwuRherDFRbA4?=
 =?us-ascii?Q?Gkso/hYsyrQ4UEnFz2BAY1U16wuWIvFpHKGh3Q6GFBsdWKkS3LOsN8u4U1En?=
 =?us-ascii?Q?++4ZjuRNF3PYaVjAgd99SI96w6tswYueRbId3inHuRM10Ekp+akcQ0pPvPqh?=
 =?us-ascii?Q?e74+aG1FWkEbvRLtlC/7HvG4Yg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(478600001)(6486002)(26005)(36756003)(6512007)(33656002)(2616005)(1076003)(107886003)(6506007)(41300700001)(38100700002)(83380400001)(86362001)(2906002)(66946007)(316002)(66556008)(66476007)(54906003)(6916009)(4326008)(8676002)(8936002)(27376004)(42413004);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RAbDmJjbiKpufFLbnRFI5WLk+erxFTaCC7Kv2sglQGBTvjT1KanG7uTwfV8Q?=
 =?us-ascii?Q?NmyHNt+qcE5LXnijse4ikJhnvu9MWvRsRkfgbmHR426pOXEsJ5NVssi2bju5?=
 =?us-ascii?Q?FQpq7kel3dfgrjaXYSI02A8/RnjAn8zYZp6cSPYsUZN8ypAokW0JxDDa5RbI?=
 =?us-ascii?Q?Kc21jCs1jkJUzL613t0maZhaP3r0WoDjLYU3Nt7kkW7R7cDq5s2P7RsuazE/?=
 =?us-ascii?Q?X6xEK1eFVyMMP9EGea64T3okwmc7Wxx4PUsssrzy+0zk9WpLSKR4TrKaG3lj?=
 =?us-ascii?Q?Xl0+h+6qQhlaqO5ltv0YwgnP6fRIQKqJx3McXmJ4O84a5xxO8gfPHuCd0ce7?=
 =?us-ascii?Q?KUvWsOoyCwEKQ5GVfwOwnPGd2LK/XnXrD2F2PXQu0EV2Nccm34HYA4q5WlUm?=
 =?us-ascii?Q?4qIFfT44R64P3GRsINhYaG6zkM7zXXVJUMkokXp35KPtmlXaIi5tjX4i6h1J?=
 =?us-ascii?Q?VEEFWl2y4UuldSvYP9KNtkpVwsgXcrSlids5xesIEg/Qd+BfaVeHLXO0m+Zx?=
 =?us-ascii?Q?RJ4giZEV0ltEuRjF16Z1Ip49+rb1seUT+qIeA4IKiTLPv6urxYtAHLSOSBJq?=
 =?us-ascii?Q?U6nejNlxN80gKa4GdoFeCK6ICHti8Qg9wJfylnUN5XP1cXlbWmSm1Pi17NmM?=
 =?us-ascii?Q?U06vY3YqMY14D75bjlkcz3tur5ciwHeF6k600an+IKjlX54WI68/WYeJJ19g?=
 =?us-ascii?Q?AyIQlzbvHzo9g3lZPOLHp/aEBMdHEz41XQSc1dKcT9sfSfq6N245efd7rU8B?=
 =?us-ascii?Q?lQ0tteaXA7/TqcbEOmSfckeEkMIgk6PMNijLEIF9YCEkKAV+3FJBUKPFR2HU?=
 =?us-ascii?Q?meDZiqsEonc/GcaAK8EQEsxh+Wb7FUybtmFM0ojMiSghp8OWWIi+wuyWq14j?=
 =?us-ascii?Q?X01GZRz1+sGCKsq3UnHWPqEyQPfLmFf5bxngD3fZ367hj9E6bA9b6zK9wwb6?=
 =?us-ascii?Q?QU3yi5xhMdaWFmX0cd5/QVfEEbdiMq0FfXO7njkmzRoFGvnicYj9tgEPIazd?=
 =?us-ascii?Q?CgPryvbYYy0yboSzrzMADG15b3str6kPN1I2bUDex2YrF4MzuMGxJaFf7s2e?=
 =?us-ascii?Q?ZAYNsgMRnNNWqwEx0EK+U/gVZ67nudKR7d80Hbxc/0EjH2if6MkR3tzWtscT?=
 =?us-ascii?Q?fSgFc0FL0j7X9tZpcOJpxTpQLjy0rYnsBHL90VkN2VPGMvNEohz+rBO3r2yH?=
 =?us-ascii?Q?kH3FhWUytja58sVHpmPqk6csZ7Wit/hq73X/rfJLzD4LZBS+xouzLu5NLX6/?=
 =?us-ascii?Q?axpo4FU8oG4qZ4aVmbDeNrd9Vlt1wm569WNpGfD68PRZXWS6EShvmc6wIQni?=
 =?us-ascii?Q?V+TfCTzQFDBQDLusDDZHETY1Ru9VUq26w/bc7vifGoRt/EK7+S7/6gp5ZTKW?=
 =?us-ascii?Q?btllqojhhTT6qgYfnKYJXjMl1ZV7jwXwLsOInbPzI0fRa1K63AuFwy86Imhm?=
 =?us-ascii?Q?li1P/nfYKLOzyCC2JYEx3oJ3VVQQ85LC8GYLf/V3z1sxWFcmVvWAVQuDddwt?=
 =?us-ascii?Q?/ofcT9bK+SYHM021mptbvXf1Z2M6k5xsj97/KVpTuhNEJawCSy/DTydkd5kz?=
 =?us-ascii?Q?hxDddldGQoAq7ZUkAgyG36UcDittzUxLXvkm1Oic?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a098c9-992b-4028-a0a7-08dbf10613f6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 18:07:41.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZMDpIAyLLPA5+bi+uCu+ycSm5LDEQiQSyTM37lIjpmHyzXZbcxwRq5xhd9KeLxU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:41:54PM +0000, Greg Kroah-Hartman wrote:

> Ugh, you are right, I was wrong, there is no reference count here, using
> a miscdevice _requires_ you to have a separate reference count, like you
> all did.  My fault.

I think we did not do a good job conveying that several experienced
people have looked at this internally already. I see you noticed a few
things we missed, but this is not unreviewed garbage code. We have
different opionions on how some of these things should work but none
of them are what I'd consider unlinuxy or wrong.

> > > Just make it simple and use a normal mutex please.
> > 
> > A normal mutex would make the entire ioctl interface single threaded,
> > this is not desirable.
> 
> Why not?  It's an ioctl for a single device, surely this isn't
> performance criticial.  

The RPCs to the FW can take a long time to execute and the "single
device" is really a multi-threaded CPU complex on the other
side. Being able to submit any commands for (say) 0.5s while one
thread chews on something is not desirable.

> And then only grab it when needed, on read/write/ioctl path it
> shouldn't be needed at all due to the proper reference counting of
> the structures.  Only on open/close, right?

No - this lock is protecting the mcdev->mdev from being freed. If the
read side is held then mcdev->mdev cannot be freed. This is not a
fully refcounted object because the mdev is actually the device
underlying the aux device and it will be logically destroyed after the
aux device_driver remove() function returns.

The purpose of the rwlock is to ensure that the remove() function does
not return until all threads have completed using the mdev. Once
remove proceeds the read side of the lock will observe mdev==NULL and
fail all operations until the FD is closed. The refcount keeps the
memory underpinning the basic operation of the FD alive after remove()
until the FD finally closes.

At least for the purposes of this driver it is how it has to be. I
agree the mdev API surface that requires some of this may not be the
best it can be.

> And again, for a rw semaphore, benchmarks matter, often, if not almost
> always, a normal mutex is faster for stuff like this.  If not, then a
> benchmark will show it.

We are not talking about micro differences in lock/unlock cost here.
This is obviously better because of how much time the lock will stay
locked while executing RPCs and sleeping waiting for interrupts back
from FW. We are talking >> 100's of ms of time spent locked while
executing FW RPCs.

> > We've been over this already, the devlink discussion is about some
> > configuration stuff.
> 
> It was?  I see device-specific diagonostic data for the mlx5 driver
> being exported through devlink today, that's not configuration.  Why not
> just add more?

Today mlx5 has a bunch of debuggables:
 - counters, even some device specific counters. Both in RDMA and
   netdev objects exposed through netlink and sysfs
 - A "core dump" mechanism through devlink
 - Some debugfs stuff, but we are now aware of serious problems with it
 - Some "devlink parameters" which configure a limited set of things

These are not "interactive". Yes we can add more counters, more
parameters and more stuff to the core dump, but that isn't what I mean
by debugging.

This is a complex device, it has processors on the other side running
a lot of software. A primary purpose of this design is to allow
bi-directional communication with debug agents in the FW.

Consider, (I'm trying to draw a picture here without disclosing trade
secrets about how the device operates), that one of the debug agents
is a GDB stub. There are many CPUs inside these devices, field
engineers may wish to enter a breakpoint and inspect something. With
this scheme we would put the GDB stub protocol packets into RPC
messages and execute them to the FW.

In the very worst nightmare debug scenario we might build a custom FW
with a custom debug agent targetting the specific problem and use
these generic FW RPCs to communicate however that very special one-off
agent requires.

Notice what such a thing requires: a future compatible channel to
exchange data bi-directionally with the SW components in the FW.

The design here of processing *generic RPCs* is not some dirty nod
toward enterprise distros - it is a sane and logical design to put
things in userspace that the kernel has no value-add to being part
of. This is standard straight-from-Linus design values. It is how
things like nvme built their very similar "vendor commands" system
(see for instance the intel & wd commands in nvmecli).

So, can we run generic opaque RPCs over some TBD devlink interface,
including with DMA? Technologically yes, of course. Practically?
No. Jakub has clearly stated his position on philisophical limits in
netdev and those include devlink. It excludes soemthing so open-ended
and ill-defined. FWIW, I agree with this, devlink should be much more
constrained. It is why we never suggested devlink for this kind of
debugging.

Genericness is also the source of alot of the cross discussion in this
thread.

A generic RPC interface can do *alot*. Actually, it can do *almost
anything* to the device. That is the entire point. What it can't do is
violate the integrity of the kernel - hence why it is a FW RPC
interface and not direct access to device registers.

So when Jakub says we can send configuration values that could also be
sent over devlink parameters, or read counters that could also be read
over netlink, he is not wrong. But we already do all those duplicative
things through the direct PCI access and have for at least 10 years.

I disagree that this duplication is a problem. Re-usable, cross vendor
generic interfaces have merit on their own. mlx5 has long been
implementing a wide selection of them as they are invented. We've been
doing this even though those interfaces duplicate what the raw PCI
tools already did.

This new driver isn't going to change that. We will still participate
in netdev and still implement these other things. We are a big part of
the community, I don't need someone holding a stick over the mlx5
team's head beating them to do the "right" thing.

Jason
