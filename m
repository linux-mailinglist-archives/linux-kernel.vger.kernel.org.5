Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4307E058A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjKCP1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjKCP1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:27:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F804D51;
        Fri,  3 Nov 2023 08:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf1M7g4NY13endnNpQtBVt0w+BZFrbrbt/3w4r3xznmPSGm9mA/vdarts+/6zEbxyYC+RqkBFbWjV2M8X5OloZqJ3/LOQ9K10IcWxz3Lh6HfmW9IB9Uh1VGv44s/Wh9rp2vZqS5Q5iAQ11T5O6e2nq+/F9RUnag7ZSfueg9PYprgCAuQKG1fjjUK1v/JZc9Dfz0DNiW7v1/Rt2kTstxEwu/6utTjgu782VH8F9FYP3QbbCGr1EFsP9LDZMhTVTRpR0iZxkYnZaq4a5EupAgX0sUi0a+V8B7UfX4//s3iUidhXkuq7z6aU2K4BJmJBwdhisbXsDC2/gxrMkBwofZRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erKD9e9YYvAzjw1g8dYQKNf3Jg3HnQzpRy77M9I5UVs=;
 b=TTRVUZMU2ntsqLJlpFjWYjnXIfzr61BS/pKCOj66IkADagfEEglhOntUmYuiFM2NBWigDUfTLCNhO/Y9CEb2sAlf03b9XFN9APrzngtdzW/xg2CbXQCJL7Ra8/I1vG6Ou8av4Xc6WsKHcPd1tz5ujbJlmHtABHvF2lYA06eKlClDt/jM5ofWjLoayGDw4wy1f/JG8VO/5pxwnAIlUkxRXUHbdppOxmB2pj4Y6C2pq1UPlp99cRDqD4lowK7PcVWJhLxDeymhHKx4EPNNsY2g2lZbIaX02nAiLm55CbH3VMmEIY414gVonT9BkFNmsBn+OyGRyDDCvae/vjffkA+hvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erKD9e9YYvAzjw1g8dYQKNf3Jg3HnQzpRy77M9I5UVs=;
 b=sSwMUr1jWMgataVtpGC+AnEp0it4FCujPJR01oo2eQ9WPrxHgaHiA67DCAbu5SMX64BwpdW6PeZp0fa+6so805eYgXi9iV9ZWY0yUGveiCrOGbvoQzJ4HO3QVzYCJjHIl9AT8PxFYMbHMiIsRsDdkGt0BDzUFsxZaEpon0XPfCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4319.namprd17.prod.outlook.com (2603:10b6:a03:298::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 15:27:08 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 15:27:07 +0000
Date:   Thu, 2 Nov 2023 14:21:14 -0400
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
Message-ID: <ZUPomvqNwZgDbo51@memverge.com>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
 <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
 <ZUCCGJgrqqk87aGN@memverge.com>
 <pmxrljwp4ayl3fcu7rxm6prbumgb5l3lwb75lqfipmxxxwnqfo@nb5qjcxw22gp>
 <ZUKDz5NpMsoyzWtZ@memverge.com>
 <a4f5das6ckw5lwj3qv2eaygx4nypb762b6mdnxivrjjndqlhjk@zpjao2ewfdoc>
 <ZUMVI4YG7mB54u0D@memverge.com>
 <s72oio7nmez565i7h6fb4bdnhqkcablr34rz5gqteyrrf7yeux@lqrztvy35si5>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s72oio7nmez565i7h6fb4bdnhqkcablr34rz5gqteyrrf7yeux@lqrztvy35si5>
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: e428d061-19bc-4b71-84be-08dbdc815735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NO3vXn8npYD3WcNxLeZuTjWSM8h9m4LRMscEAupeUoI/YNtOzP+/34Svvi3lsI4UeSqt+SxUHMWLDuzOyVERrRmn2VLw46IBhc2khmiK3/042tbFjIOBMJOzz7K0kO3i0OVLeXIUnSQgnCLCQqyynAKUEsTwPLcO7iijTWIrw6g4qz79Dbs4Q7waMg8iQAUAZX8BWMnofBMQZY+NTtA46QyaMfCCzqbqojJ/bEhORksDYl0fEWvqx9T2wluHsyhqUWe3aMYQIedcjGAW+fpTn+eqS+Gltgti2+PRNh5qUwfIrOd5JE2KuPSvpwCCjadTzrnhZyc0JYOIZYVZ3smOkqFAjwPhQgyayLM2kXMhOgpgM8WEsBxAC9B4VVynVy9nu2DrkHy0aRqPBazaNv6YDH8iC0U+WKv/EM7+D1QWSIy2jS5U7Nfg3Wo70mtqZfcH/h5aVmBiwXK1PPREvSKFv0GrjrO1G4Ngztiu/RB87/iWQStJwTWO3BJrg8gH43ST/Wve7I9tCkS36kErqD2UeSKBh8BlHXeXStQWuK2FQSbXC3Rv3EokrOjFSC/USxNkvzHArgyysIuX6qbch4nfY9LVdgMmJhjJtCXr2c/1Jc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39840400004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(86362001)(2906002)(26005)(2616005)(6512007)(6666004)(478600001)(83380400001)(6506007)(8676002)(66946007)(41300700001)(8936002)(54906003)(316002)(6486002)(4326008)(44832011)(6916009)(7416002)(66556008)(66476007)(38100700002)(966005)(36756003)(5660300002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rdTJEG6NxJPNFCmp5LXuYv8+8vvnagMCxdn1bYv13a6+CyPHCb9HlVqt10+J?=
 =?us-ascii?Q?IuNhHLRlQzHOKm3fujThqtqEs5KMicJro4TbKswQ72EIkqyojaCu2MX+YYet?=
 =?us-ascii?Q?TbmatQryfsrT2171Xmyf7fASDnwASK6f0XlVS5gMxWNTdcHNy6xp4eDgR6wt?=
 =?us-ascii?Q?E/wn832nGXv2aGYK54Y7ro+tuTbinXz61o5TkwWLYSNlF3DVPeNaGp5RtTHn?=
 =?us-ascii?Q?I8bjRaY/Kr3UA/gfc51hDtF6K9goDjdvXAyEJ3Hr66ZRKl1lmzygCMku22Bh?=
 =?us-ascii?Q?26+wHo4js2psvxtMYcEfw1zdGkQhAlUQKlSM25DNqS4PG5kXIaj3LTv2aakO?=
 =?us-ascii?Q?ksMHrFlqx8aHU3L+j/3l5gzJRhKtZ1l9FRKaB1+SW4qyxEypEbBwxY6i37g+?=
 =?us-ascii?Q?rs5yWEafGb1nLtXuPJEtWxq4QuykAphv+tnfXoakR/AahGbN0Kij9cJjP5lY?=
 =?us-ascii?Q?lAUGGDRSl1da3mgfJe/Wx+Q/5loODZ5SpLJL5P0zuiQHT/Mll84G6BwcrwpV?=
 =?us-ascii?Q?RCHtS30/87ImsGnrZl5ipoQISuDxd624Gf5DxhT3k7lWjQ6Qvm3CyvGgsvMs?=
 =?us-ascii?Q?2UV6F6m/YeAIobvvVdojky/VgzP+1ZKwXg/ZDb0sawgHEV6jSNHLnsrak31B?=
 =?us-ascii?Q?WPQUkr7qgRSwv84A7RQzYFUd0eNGcoonfWyb4YtDjd3/lgkf50kyNON73Kx0?=
 =?us-ascii?Q?VQ+jfjMsqpXE8RamVJMhi+qBfmWwPRZpxZWKDoQtYfE31MoAJsFb6rqctoJP?=
 =?us-ascii?Q?UKO+DXwCBOR8AxMhOJ/fgQSXyT1VmeIw0vH88/5d29X9yPDk0GEdsLIuIDIE?=
 =?us-ascii?Q?OI2QICEzoZHzWlctppYx0PLZ0DRoroGdVfAJPybESl31M5t7CPx5jPP7+Qwg?=
 =?us-ascii?Q?+fYATXgJn/7VKxIzVSXuYLtvhR2H9noiO0FndnTQO/ZBLvlZK+AC4M4zHzuA?=
 =?us-ascii?Q?DzAf0zusjKzH/d2gJL1rKr06uTIhaOtaYgGuq3KAQh7PUaCES9hWfL8VOxeB?=
 =?us-ascii?Q?bh9KBTZ+1kV5bO0oo3MF+/3nEMdUhMAzuseZrbllkcVmtHasJ3+2N9FcPmZa?=
 =?us-ascii?Q?2cGSIukJlI9wXTJSKD10m6+NU600tzwJ/hOw5kZ4HxuvK1tj/tO+MasTEU3A?=
 =?us-ascii?Q?wgtFmlbL3I4RARqSqPqcG/T0xaBv9CmotR+/aZwvVrmUpKfmCsSQq5+EFSKe?=
 =?us-ascii?Q?hdYnVfLgc9lWf6aw4+fGjXqdI1yynSNDRwDaWPBXE1j2bkdRQzRK2+9Rte0X?=
 =?us-ascii?Q?3foCvGoYO/BPN6LwMPNQmbm2meB8LXpHkjHE4AjV7B7BQQnuNKOsYwwp4Ly1?=
 =?us-ascii?Q?oDgM76mURsw9ElkbOWPecEZdT2W1V6b3EeFFsUm7mBYesLqdwCrGTQHTiAmj?=
 =?us-ascii?Q?QPx0zBY7/pcFIlKxilZ7DlGEeFIA+3skSoP0POOfpRLbUs9NEmLFAgbLo3iB?=
 =?us-ascii?Q?knhse9CaoXnTn9Ht57MbUV3OFgqIOFP25/bXs/Y7dB8MPSmA9kfXY0aD9imA?=
 =?us-ascii?Q?q2S2RkFsqYx5Ma22i7zkTEBpGXy6850aHo4b57odLDBtZEX8uvVTU29TMg2D?=
 =?us-ascii?Q?KqSuH3e6OxrpWxJWef5N6An6EwouCnpKoZBhxD6TADJAxz3MW1Th2hiR12x/?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e428d061-19bc-4b71-84be-08dbdc815735
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 15:27:07.7353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vl7z4qLkLB0/ZREtajeq+a7QhFDsg+LVi2k1Duv1KDLR0X2lwliCJuAWq9+BZ8vZcdQjSG1i28kMFS/XpfNe1M5+tWCriw78BsO1uIIQK+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4319
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 10:56:01AM +0100, Michal Hocko wrote:
> On Wed 01-11-23 23:18:59, Gregory Price wrote:
> > On Thu, Nov 02, 2023 at 10:47:33AM +0100, Michal Hocko wrote:
> > > On Wed 01-11-23 12:58:55, Gregory Price wrote:
> > > > Basically consider: `numactl --interleave=all ...`
> > > > 
> > > > If `--weights=...`: when a node hotplug event occurs, there is no
> > > > recourse for adding a weight for the new node (it will default to 1).
> > > 
> > > Correct and this is what I was asking about in an earlier email. How
> > > much do we really need to consider this setup. Is this something nice to
> > > have or does the nature of the technology requires to be fully dynamic
> > > and expect new nodes coming up at any moment?
> > >  
> > 
> > Dynamic Capacity is expected to cause a numa node to change size (in
> > number of memory blocks) rather than cause numa nodes to come and go, so
> > maybe handling the full node hotplug is a bit of an overreach.
> > 
> > Good call, I'll stop considering this problem for now.
> > 
> > > > If the node is removed from the system, I believe (need to validate
> > > > this, but IIRC) the node will be removed from any registered cpusets.
> > > > As a result, that falls down to mempolicy, and the node is removed.
> > > 
> > > I do not think we do anything like that. Userspace might decide to
> > > change the numa mask when a node is offlined but I do not think we do
> > > anything like that automagically.
> > >
> > 
> > mpol_rebind_policy called by update_tasks_nodemask
> > https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L319
> > https://elixir.bootlin.com/linux/latest/source/kernel/cgroup/cpuset.c#L2016
> > 
> > falls down from cpuset_hotplug_workfn:
> > https://elixir.bootlin.com/linux/latest/source/kernel/cgroup/cpuset.c#L3771
> 
> Ohh, have missed that. Thanks for the reference. Quite honestly I am not
> sure this code is really a) necessary and b) ever exercised. For the
> former I would argue that offline node could be treated as completely
> depleted one. From the correctness POV it shouldn't make any difference
> and I am rather skeptical it would have performance improvements. 

Only thing I'm not sure of is what happens if mempolicy is allowed to
select a node that doesn't exist.  I could hack up a contrived test, but
i don't think the state is reachable at the moment.

More importantly, the rebind code is needed for task migration and for
allowing the cpusets to be change-able.  From the perspective of
mempolicy, a node being hotplugged and the nodemask being changed due to
cgroup cpuset changing looks very similar and comes with the same
question:  What do i do about weights when a change to the effective
nodemask is made.

This is why i'm falling toward "cgroups seem about right", because we
can make mempolicy ask cgroups for the weight, and also allow mempolicy
to carry its own explicit weight array - which allows for flexiblity.

I think this may end up generalizing to a cgroup-wide mempolicy interface
ala cgroup/mempolicy/[policy, nodemask, weights, ...]

but one thing as a time :]

> for the latter, full node offlines are really rare from experience. I
> would be interested about actual real life usecases which do that

yeah i'm just going to drop this from my requirement list and go OBO,
for areas where i see it may cause an issue (potential for 0-weights) i
will do something simple (initialize weights to 1), but otherwise I
think it's too much to expect from the kernel.

> > 
> > As a user I would assume it would operate much the same way as other
> > nested cgroups, which is inherit by default (with subsets) or an
> > explicit overwrite that can't exceed the higher level settings.
> 
> This would make it rather impractical because a default (everything set
> to 1) would be cast in stone. As mentioned above this this not an
> enforcement limit. So I _think_ that a simple hierarchical rule like
> 	cgroup_interleaving_mask(cgroup)
> 		interleaving_mask = (cgroup->interleaving_mask) ? : cgroup_interleaving_mask(parent_cgroup(cgroup))
> 
> So child cgroups could overwrite parent as they wish. If there is any
> enforcement (like a cpuset) that would filter useable nodes and the
> allocation policy would simply apply weights on those.
> 

Sorry yes, this is what I intended, I'm just bad at words.

~Gregory
