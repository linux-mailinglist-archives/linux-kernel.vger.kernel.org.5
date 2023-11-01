Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB3B7DE4F1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344339AbjKAQ7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:59:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BC9FD;
        Wed,  1 Nov 2023 09:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1A1l/g3SigwpborOo7SOJiqTrjB4YbP1VDQz4M+bB835lIexgqlj59owMHpyqZoDFZGnKEOoluqM4I3GTowjyotXQcmxaKUgcxlocZM2aromuX0fMmHPnwy8osh5xHJmAriGvcIqKG6T6YXKV4GLMaNvi3f3mOiWU7gaZhFiBvgzkcJAybw7aW787ZPubU+iL0Y7TythITZt1GYO7+CPEC3mLQvWvZKO1amjoxM6HdbHw6Yp8FSDnrMevVXXoQwcTn7fJzvprtab+Sq3SLZA3680mnSNL3w3Pvj8M34LMjCegBfL+dwMym4OLV+FTKGT6VB4uWfbPaGTCNxI8txDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVzaA7BrwWnDQvpykpXz29UXSTYEL2d/piPnLgI0xGs=;
 b=oQV/wohoLhAHi7kt/nbz3Pg0i/Oq2mW2YYar6ANQiODY3KQIoOA3brYjEMT8cDJut8Uta7Si24YMu+op7DxMp0hSYjqCkyzX4NVN+pywYUjIgKwUSioH4PMu3BCw2tqEvOS/GMYPDJGf5GyUH2cBcXODtfiY5aClAzwDkmB/7YPmta5Z1LeKYRRetcmcmlf/FjZGG5ROpCEMWE06bQbRZdZHiCDoQJiFjkIwDyLx8YnzlgIVT6eSOBvOpQIqdf5uniLWvAtCOMZNJZE0rUeDrizgPuz0jHg1vou2z474NYsWbSd3wncFOrQYobP2oSyerXQQtOAWY0yAEfB6sTZe1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVzaA7BrwWnDQvpykpXz29UXSTYEL2d/piPnLgI0xGs=;
 b=Shz2a5f/ElarS3+7Xkggem3rpiHfm7XLMilQN357kvoW2anf8eE6PssBvVoJ6/vimDjjZPeDvKNzd4ehb8DdFFolNtBME0ipdV3mZEvC+NcvAfgWrbJPLfxAIlJltJ8PbZJIQzP21fERQpRwnZ2p8/ZqiWG0MFDen8QTuonFkbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB4861.namprd17.prod.outlook.com (2603:10b6:510:8a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Wed, 1 Nov
 2023 16:59:03 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 16:59:03 +0000
Date:   Wed, 1 Nov 2023 12:58:55 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, ying.huang@intel.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        weixugc@google.com, apopple@nvidia.com, tim.c.chen@intel.com,
        dave.hansen@intel.com, shy828301@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Message-ID: <ZUKDz5NpMsoyzWtZ@memverge.com>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
 <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
 <ZUCCGJgrqqk87aGN@memverge.com>
 <pmxrljwp4ayl3fcu7rxm6prbumgb5l3lwb75lqfipmxxxwnqfo@nb5qjcxw22gp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pmxrljwp4ayl3fcu7rxm6prbumgb5l3lwb75lqfipmxxxwnqfo@nb5qjcxw22gp>
X-ClientProxiedBy: BY5PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::23) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: ddcdbc4f-d0b9-4aaf-4fb6-08dbdafbda1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4AQhIxQYYLOb5iz97TusxjJU3gjwGhgIMMwxhi/dLXcqcmaCAHMr/Lo1edECFLiBp9V+96ACe2rX7X5jYDEtDfShoMrvycEw4te3bspv47EXMoFM4e2cku/J1zq4cajRJ7XVaS1wxlY7HPcS+MGT4vHvNwAos7u2uzo/HR+Z0iXT4DAJFidpQSN/OUoiIzU3cE6KEveKNUfgYZ5KRynsmWhCiG9UDiknlwg/CaDAYROl2+b7SyGu8llElpc/+9eV7bAU/8djMGJO0/zsw2G8Tzl/B7p69RmwBNSSyd3Vd5QkiL8POFpNof02V+4eR9k3Te8muynHQND91HSXb8nj6Nyu7Xjw74x84YJTvB202qIeWsNeBz1RHo1RBKEQr8hf4PK9hZ4tJ3+Ja4YKTloHXPijtIWlMXDDpj6Z0dfQ2PexGd3sOPjZl2KJ2sRVtVGDw+PspaNVADRMgB1V5EsWlmtIO/0f5T+G2cAOo8qghtMCmK39CenlSpZMVzoQz++aNkrc/25Cm2NDpbtC8NWNu6vPS6RzW4oxcYlSyst/4sMyB40FaxqvzZ10No7c2W5tzQ2Tva6yvXGs59MNTz27AexYflN9mAGPN7U+ORLZUmS74xQjYXZyKwa7n+12YOSSEQMjPB7HaVKDSwHgo7wzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39830400003)(346002)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(966005)(6486002)(478600001)(38100700002)(2616005)(26005)(36756003)(6506007)(83380400001)(6512007)(86362001)(6666004)(44832011)(6916009)(41300700001)(54906003)(66556008)(66946007)(66476007)(316002)(5660300002)(8936002)(4326008)(8676002)(7416002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E8PDCF6nBIIymNsXHd2wYnANgXHXhFdKRKd3u7mNK2n98n1DJpsDhLXCsMPk?=
 =?us-ascii?Q?FYe+mYN7cPVR6XfqVHlTwiV7+gj4ohMCwuOoeXeMiXeH7K+eOkolYj1Z2zBc?=
 =?us-ascii?Q?jGJmPkB6QJHfql2Vyr/z4HPlssSzwkdnaHUBVyMKNNI/AoFD7ex5TJxk4dYa?=
 =?us-ascii?Q?0ZoSGGOMnQa61+aEzJJYAytj7Nqcht47wWIxHvBLpAS/sIpDOytydaZrssCy?=
 =?us-ascii?Q?nYvQmKgtGlewzgWCcEhj7xUxgopeP0bh5SBcmAXlG3iorJb3QjbPmWHR4RdO?=
 =?us-ascii?Q?fmxhO4MRu6he1rJ77rKzPBDdOcA0eulg0re9WOAngRo4922I3xq1lRklaD/1?=
 =?us-ascii?Q?mplkQve4O+YFOIE3IGdEWM9ZgGAdvIF017gd8HqgZPdeGZvX3XXHmcQVLeca?=
 =?us-ascii?Q?Uio4o0f4GDyhtQxYLpGJLkSc15p69WfftYZEgFWDuEAqFA8IHGJeVOm6zHRo?=
 =?us-ascii?Q?9D8h+WRzs8TgHkHF3r+xlsMpfQzFsQuJyE7u1EC85GHsL+5yvZbOOy/UfEjO?=
 =?us-ascii?Q?YIJ//WKFUaQOyurJip6aPTYQzyc7n54oT8IHoYbQrwmP5T8O9gENqIHcgP1o?=
 =?us-ascii?Q?omqV6lrxa2pKgmNWN8ET/g9Ia4cILUdVkfdRMrOolwefdtHp9BQ5qC73Yh7J?=
 =?us-ascii?Q?1N+SMi0zHtEwWdSBioJhBwk1JbXNgPXiNyP0X14FRX1TiQUpTolhrzLArP6v?=
 =?us-ascii?Q?bI94l092g4p+8OeyfR4ImTkmO+F2j1vky6nyI/03/ws7VpX9mDQ22C3hkQZ+?=
 =?us-ascii?Q?5pspeZKycztNyOX76NQnYojUHCUERq6h5vos2k2Fiuq0EJD83SRrUXstYhY5?=
 =?us-ascii?Q?KAaAn8nB2BonGe5QHDEH86RET39PxFvxJdaM+Prma3HuL5HZp/nspQSl1bbT?=
 =?us-ascii?Q?27rmJiigy4GvBKAPS+Nd3+0MMUnC5DBD4FhlGZKaJchyfAKiu2q3Uqkl1IJC?=
 =?us-ascii?Q?CYwM3yiYU1l0tyTNkpsR0lIdDqDR6tF1mmuvlIlVMbNRGm19i+B4uKpuHOTh?=
 =?us-ascii?Q?CV3o9bvQGOW7hufYDiQSaOYgOflxHToUvxaCanhr32mdTXGRJP3OqA12QOGd?=
 =?us-ascii?Q?wKo6QguSZ/sQ4XnQCeXtJpZTdlvMykFtRFdJ+Lo6dJcESTAzGrSrRA+PBhtS?=
 =?us-ascii?Q?GPS7Rv8TiSfpKZDbT+BKHvVG4vAbf7WaCE8WvU0mbBkxpBmnYWimewtqkQNn?=
 =?us-ascii?Q?ZM6qPSqmyYEA3AmGmDr7z/2mFhylHKWUf6QFDP/hG4ECeFS65sFXWHaq87nu?=
 =?us-ascii?Q?OGO2QJvLzRuXFJNQZs2FEiHOce9yJI+6HgfYkZe/PsDiUETjy8pGj53msZKa?=
 =?us-ascii?Q?POd/VrbAh479/Q0ZrPe4f6ubWDDCLkDD3EyjKAxVCXRMtWdUNlPGgg+BqKzT?=
 =?us-ascii?Q?4hzAditxeYCh9XzYoMq2F8/5XczqBIAC6MY75JCUjQ3KkidoiOk7GiFA4Gx/?=
 =?us-ascii?Q?4dQdMcgR2Lp4udcEVStLNnT0uksal6/uW/w0V50nzvZlSSf6jL7lKszoJWVM?=
 =?us-ascii?Q?P9wMXDfvXGnBTxof1CrCrj/rnUfHmRuwBsyNUFKQA3F0sPs4xVmXqPyzsMgo?=
 =?us-ascii?Q?VBcrl0YzLJjUO/WpGlCajD6xtFV9fhD9DqUn3yFFfTl9aCCkvD3UGMCjHWpn?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcdbc4f-d0b9-4aaf-4fb6-08dbdafbda1a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 16:59:03.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6YJggUJHYxCCG/6oD/DzebsOSzU8NPpquIUtCoZdTwVCroTXMFDtcifUxdIqkL65PfwpBpChW1nAv724i0BqG56yx7++XrvjXnyFPvWfcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4861
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 02:45:50PM +0100, Michal Hocko wrote:
> On Tue 31-10-23 00:27:04, Gregory Price wrote:
[... snip ...]
> > 
> > The downside of doing it in mempolicy is...
> > 1) mempolicy is not sysfs friendly, and to make it sysfs friendly is a
> >    non-trivial task.  It is very "current-task" centric.
> 
> True. Cpusets is the way to make it less process centric but that comes
> with its own constains (namely which NUMA policies are supported).
>  
> > 2) Barring a change to mempolicy to be sysfs friendly, the options for
> >    implementing weights in the mempolicy are either a) new flag and
> >    setting every weight individually in many syscalls, or b) a new
> >    syscall (set_mempolicy2), which is what I demonstrated in the RFC.
> 
> Yes, that would likely require a new syscall.
>  
> > 3) mempolicy is also subject to cgroup nodemasks, and as a result you
> >    end up with a rats nest of interactions between mempolicy nodemasks
> >    changing as a result of cgroup migrations, nodes potentially coming
> >    and going (hotplug under CXL), and others I'm probably forgetting.
> 
> Is this really any different from what you are proposing though?
>

In only one manner: An external user can set the weight of a node that
is added later on.  If it is implemented in mempolicy, then this is not
possible.

Basically consider: `numactl --interleave=all ...`

If `--weights=...`: when a node hotplug event occurs, there is no
recourse for adding a weight for the new node (it will default to 1).

Maybe the answer is "Best effort, sorry" and we don't handle that
situation.  That doesn't seem entirely unreasonable.

At least with weights in node (or cgroup, or memtier, whatever) it
provides the ability to set that weight outside the mempolicy context.

> >    weight, or should you reset it? If a new node comes into the node
> >    mask... what weight should you set? I did not have answers to these
> >    questions.
> 
> I am not really sure I follow you. Are you talking about cpuset
> nodemask changes or memory hotplug here.
>

Actually both - slightly different context.

If the weights are implemented in mempolicy, if the cpuset nodemask
changes then the mempolicy nodemask changes with it.

If the node is removed from the system, I believe (need to validate
this, but IIRC) the node will be removed from any registered cpusets.
As a result, that falls down to mempolicy, and the node is removed.

Not entirely sure what happens if a node is added.  The only case where
I think that is relevant is when cpuset is empty ("all") and mempolicy
is set to something like `--interleave=all`.  In this case, it's
possible that the new node will simply have a default weight (1), and if
weights are implemented in mempolicy only there is no recourse for changing
it.

> > It was recommended to explore placing it in tiers instead, so I took a
> > crack at it here: 
> > 
> > https://lore.kernel.org/linux-mm/20231009204259.875232-1-gregory.price@memverge.com/
> > 
> > This had similar issue with the idea of hotplug nodes: if you give a
> > tier a weight, and one or more of the nodes goes away/comes back... what
> > should you do with the weight?  Split it up among the remaining nodes?
> > Rebalance? Etc.
> 
> How is this any different from node becoming depleted? You cannot
> really expect that you get memory you are asking for and you can easily
> end up getting memory from a different node instead.
>  
... snip ... 
> Maybe I am missing something really crucial here but I do not see how
> this fundamentally changes anything.
> 
> Memory hotremove
... snip ... 
> Memory hotadd
... snip ...
> But, that requires that interleave policy nodemask is assuming future
> nodes going online and put them to the mask.
> 

The difference is the nodemask changes in mempolicy and cpuset.  If a
node is removed entirely from the nodemask, and then it comes back
(through cpuset or something), then "what do you do with it"?

If memory is depleted but opens up later - the interleave policy starts
working as intended again.  If a node disappears and comes back... that
bit of plumbing is a bit more complex.

So yes, the "assuming future nodes going online and put them into the
mask" is the concern I have.  A node being added/removed from the
nodemask specifically different plumbing issues than just depletion.

If that's really not a concern and we're happy to just let it be OBO
until an actual use case for handling node hotplug for weighting, then
mempolicy-based-weighting alone seems more than sufficient.

> > I am not against implementing it in mempolicy (as proof: my first RFC).
> > I am simply searching for the acceptable way to implement it.
> > 
> > One of the benefits of having it set as a global setting is that weights
> > can be automatically generated from HMAT/HMEM information (ACPI tables)
> > and programs already using MPOL_INTERLEAVE will have a direct benefit.
> 
> Right. This is understood. My main concern is whether this is outweights
> the limitations of having a _global_ policy _only_. Historically a single
> global policy usually led to finding ways how to make that more scoped
> (usually through cgroups).
>

Maybe the answer here is put it in cgroups + mempolicy, and don't handle
hotplug?  This is an easy shift my this patch to cgroups, and then
pulling my syscall patch forward to add weights directly to mempolicy.

I think the interleave code stays pretty much the same, the only
difference would be where the task gets the weight from:

if (policy->mode == WEIGHTED_INTERLEAVE)
  weight = pol->weight[target_node]
else
   cgroups.get_weight(from_node, target_node)

~Gregory
