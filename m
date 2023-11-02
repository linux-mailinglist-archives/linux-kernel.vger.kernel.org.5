Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1997DF507
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjKBO3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjKBO3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:29:47 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FC210EA;
        Thu,  2 Nov 2023 07:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2fGzGD7+3og8eE7m7qqeCjpNw/KYNLfkqQVuO4NgBkQYUbZ2ceY6B/d9x5W2s2x3PiI7fPXmNbw2hjJunEYbfY8yNhykqKggLcnHsmhZx5hTSHufbvrZWm2T9oIhLgXUfmg5wPrUQKSvFU3dnQldgGJGiCmpwKbfFG2lhsmLa5HGq/yU90ONqbAvPtYunSWbrw7hohxwHy2BA1WawdpIvcXfgOPxi8mb2nT0ec8FeIghZCLSu/2Xjgl1GUIu08t8EPiJ4xZiCdNJi7tb65ss4b3yxM2+1YVsw/5ingxumssqMc78ag9GtE81CCPsuaWL1KD04zE6mMJwFfR2ONqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxgxCLupi5kx2yqKWxg2Gyou8EYEW1+y4zHurNCGu74=;
 b=PNjR8UOeyfwnAYSpgKY+dGc0i5dHmVfFrbpeo0G50pFGXEWaKjXSQFmdrDQ/iK7H7HAsZAT8Lv27v5tpd/+sjIvPfbfKoJ84O+eiW0T5AWvYVAlLeHa2pCkWmDDOfykr+VzgZBDEAjDUF7I9enSJ/uBOAA3hjsivwWLk2LXNrotTZWl70peHqwWA5QqIAxWKDSHPMb5HqMqDI6zX7htcUoXLbGbhPwuQDtUXylLHa6BDiHBHTIWmPJxRpA/vcmjI4BcFRKa41FkBHOP+BK01lQ1QY4rGKbc/a+PvKMS8v/F1D5zb8TZOrdQtX9XIrBWNH9jY/BlsxBNpdjqgy+bZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxgxCLupi5kx2yqKWxg2Gyou8EYEW1+y4zHurNCGu74=;
 b=M7s4dd7P8KvJt3KELpk6OWW92/BlMvviXi5KZU5mD5zJUQOO4/GrevWXUz1po7Kc9fYzbx0hFdHLIXPNvXRO7hS6g4J7kQUKjsgGhOOuNCA2OId+AOF/Qv88rBo/bYtLOVcTOgEnjU1iE2EZjB5gerUB46ZAU5WpFXu7D139FQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA1PR17MB5617.namprd17.prod.outlook.com (2603:10b6:806:1cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Thu, 2 Nov
 2023 14:29:18 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 14:29:18 +0000
Date:   Wed, 1 Nov 2023 23:18:59 -0400
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
Message-ID: <ZUMVI4YG7mB54u0D@memverge.com>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
 <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
 <ZUCCGJgrqqk87aGN@memverge.com>
 <pmxrljwp4ayl3fcu7rxm6prbumgb5l3lwb75lqfipmxxxwnqfo@nb5qjcxw22gp>
 <ZUKDz5NpMsoyzWtZ@memverge.com>
 <a4f5das6ckw5lwj3qv2eaygx4nypb762b6mdnxivrjjndqlhjk@zpjao2ewfdoc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4f5das6ckw5lwj3qv2eaygx4nypb762b6mdnxivrjjndqlhjk@zpjao2ewfdoc>
X-ClientProxiedBy: PH7PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:510:323::19) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA1PR17MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: c48adaac-c3b8-4cd9-6443-08dbdbb018cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RN6oLK19j6huK4ztPoUCx4HgI/0JDTTWo1bWO+ArrZWfmpV0AuwPFKNCVtiHHd4unWvpI0INpfC6A3WN/aCBJMMuKYlqDOIo0Ru/u0mpJQuULhMQ8a0BDCt8mk/ZD23wP/aBy7J2FJU9RmvKASqM3865NWl9fZYf2waiavo7Ye21uTYfFELnsLpV/EB2SG8iFrCOkI/ZjqD21ZPcK9Lga929ubbl8RYN+kOem2vAzdA7qdc/t57n71vJZW1lqPYNECTH+vLC0F6HpQvXfR9QuOERojLPkuIseHPosm9xYRP9MHYww7rZ8V2AU4WjX5kmOgr+bxlD5Ig7MPGDs98O0BtjqVjIoujIw1+BTWCNw9tL7bBLEiHB0h12LneDaaBpKFKBxfAc9q3XGs9CsHKHEtS3NLyYwG/EA6MC3FVLJwDnVjAcRLU01YgQmitniRnP/5XTDVWAprDUgocT0jIkvQbkTFhwl2+9a4Ie4J2VYaYj2/gh9V751UCy+AZwsHMI93buS7N9la5FzBlQviKcWmrQMqpoApL1APZyQJuyB/yenuTPPDBxaYssRKkOhscm7FtiCQq/7RP2vnycXOwjXu+EP3rO1Zfe66qGbYU11s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39830400003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(478600001)(316002)(6916009)(6506007)(83380400001)(2906002)(38100700002)(5660300002)(66946007)(7416002)(26005)(54906003)(66556008)(66476007)(4326008)(8676002)(8936002)(44832011)(6486002)(41300700001)(966005)(6512007)(2616005)(6666004)(86362001)(36756003)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4yIodDvUSF9kQ+qH64XDpoSW/1gReBS75O9I1Ar7zI914cwhthV8Z3B1DVud?=
 =?us-ascii?Q?WGatp8uWRqIWFGzrDfo/cLTnCI2JQkB/KdfxMHq8ubjEwUyYSvI/487p6W7o?=
 =?us-ascii?Q?eQW7lvU+szp4SNWu3j0ZHHLji3YeJIFUO+m3HYXKx53WeBqmDQ5//hqVea5/?=
 =?us-ascii?Q?Ihn2+nMNhLDeKm8shtozZ4cuRmiR08eZKtVwg7mjJppFFGRQYDiBbGy5V0H0?=
 =?us-ascii?Q?4adXkc9QayAjwcz0VQizK8/FSsu59yCy3zqKb7B4m03XWHeAnWDxArd/MiJK?=
 =?us-ascii?Q?vr6kocr/JElurMPEipZkyTqQxBHAoQK/PhgjF+gmDjqVdNbZ3iNn+MwuWShn?=
 =?us-ascii?Q?F0VAbrb7dZqQN97q3FzxKPvOeL6m2gYtJqJkiI57olhIVrErVUNAU0V+zfse?=
 =?us-ascii?Q?UGbH7stXtLpAB4YyY5GGN9EClBEkGgV6P9bVq+/p2DH6entTpsvrJWwLrYSd?=
 =?us-ascii?Q?wSAye35Xw7HdZ+9mS/hE0SN5Bc3FJf85QQ+6qwWu8jpSsRRF0z0HEn7SMcL0?=
 =?us-ascii?Q?vb+ZsX0lY/oMsjrC/8ouGIuHClRphgWqeQ8ezFO7t+bnkZxJ/G+9JimRXbmo?=
 =?us-ascii?Q?jhBAU/gwCNpzF2IT719REn49qLDJ6xNO4Mc6Hz9tHbja+B1mj/hrAUBWLVQD?=
 =?us-ascii?Q?HpDrl2SDW7bnCDABm+Po858HbxeaekZeq5lze2J50DILv4B9U9wUws19OH84?=
 =?us-ascii?Q?QRZoWU+ZATCfkKBB+DbFhc0ymNpHSnyRyZNILfo5AOpUknvldAc2YYcRSp4T?=
 =?us-ascii?Q?Ur0n8cVx4Rac6DBJID+9z/LlUaKH1uz0nhIbFZwaq6gm6rfkeZwFom286FTy?=
 =?us-ascii?Q?gwI/dMoz6wKV8wdrUOCBXKtFttBmCD0aj0nPOpGhxwLEtfHRtj+6DyuGaCeK?=
 =?us-ascii?Q?JWcLABKhhf/A7TKz3rEaDCit/0TaX87Z7Pnv800vswqAqjrzL+VKBa0CfnWi?=
 =?us-ascii?Q?wKqiHcoQ2zZiyHa6USffSROtIdElJmBn+WZg5UqrfmhDr4FsxGNzvSqmoO+w?=
 =?us-ascii?Q?XhbZiyzKAKLdcm3hoXlhQsmqjJJf/gkrz9ClnJ/Y//3IseJeUyaedHhRgjHP?=
 =?us-ascii?Q?c0lL+nxzeQttsNkqgDjdX4qF/Ydw2xWPAOqkuLaz/WhLxuyhGk6GTyGnwZwn?=
 =?us-ascii?Q?6tDDW+ELJPsJzUa5co9eYcZ/fAt4TZRBLdB+xP7a24pL8TWgep/sV6Xnh3fi?=
 =?us-ascii?Q?vr0C7ei5SdtUK7sxPgB0L/jCc1JxybWWZcmBGymW9lIoDHwq1CVbR5Wtp5+I?=
 =?us-ascii?Q?wVsNbuFVeXfcr9eCAotKO4oo19971EZIu5PH7J1MphkAxYEtl+0FyOA7Xnoh?=
 =?us-ascii?Q?aF0F/rWODg2Odm4NuALPdtcMlmBEB7T3kzp33qsOLjfoHm3X9x1lqnN4RLDn?=
 =?us-ascii?Q?LP645izIMuIh/asH5oTLv83wW3OXdtWJNPNzbMfL8jW3WE875wRw2wUJFBYu?=
 =?us-ascii?Q?8IrrSOvMRkCj27mR86o06vcRD/MmrXZ+g5XYhSpNJ3G7vVFM7agD8xTLqsc0?=
 =?us-ascii?Q?OCT1W5DT+51v4Lynlym7PXp+k78ctMwAr2cSZgVyHSZ99nzRKXeYhGO/K7hE?=
 =?us-ascii?Q?1eJVKN1P4dMEIIHJzY9s1UTyyGcr4erLYQRMaVDKZXiHqKf9PLbl9WS5XzS4?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48adaac-c3b8-4cd9-6443-08dbdbb018cd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 14:29:18.1687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHcu4b8ixEBZLlXJKCCSJZGp1Kr00DwhFEp3Qd8eDJoKdllkx2qJe2N07qoglI0pPjn7feX8sLBiyyo2n6hImwtWWRka5fJOx1y+6Pyw3U4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5617
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 10:47:33AM +0100, Michal Hocko wrote:
> On Wed 01-11-23 12:58:55, Gregory Price wrote:
> > Basically consider: `numactl --interleave=all ...`
> > 
> > If `--weights=...`: when a node hotplug event occurs, there is no
> > recourse for adding a weight for the new node (it will default to 1).
> 
> Correct and this is what I was asking about in an earlier email. How
> much do we really need to consider this setup. Is this something nice to
> have or does the nature of the technology requires to be fully dynamic
> and expect new nodes coming up at any moment?
>  

Dynamic Capacity is expected to cause a numa node to change size (in
number of memory blocks) rather than cause numa nodes to come and go, so
maybe handling the full node hotplug is a bit of an overreach.

Good call, I'll stop considering this problem for now.

> > If the node is removed from the system, I believe (need to validate
> > this, but IIRC) the node will be removed from any registered cpusets.
> > As a result, that falls down to mempolicy, and the node is removed.
> 
> I do not think we do anything like that. Userspace might decide to
> change the numa mask when a node is offlined but I do not think we do
> anything like that automagically.
>

mpol_rebind_policy called by update_tasks_nodemask
https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L319
https://elixir.bootlin.com/linux/latest/source/kernel/cgroup/cpuset.c#L2016

falls down from cpuset_hotplug_workfn:
https://elixir.bootlin.com/linux/latest/source/kernel/cgroup/cpuset.c#L3771

/*
 * Keep top_cpuset.mems_allowed tracking node_states[N_MEMORY].
 * Call this routine anytime after node_states[N_MEMORY] changes.
 * See cpuset_update_active_cpus() for CPU hotplug handling.
 */
static int cpuset_track_online_nodes(struct notifier_block *self,
				unsigned long action, void *arg)
{
	schedule_work(&cpuset_hotplug_work);
	return NOTIFY_OK;
}

void __init cpuset_init_smp(void)
{
...
	hotplug_memory_notifier(cpuset_track_online_nodes, CPUSET_CALLBACK_PRI);
}


Causes 1 of 3 situations:
MPOL_F_STATIC_NODES:   overwrite with (old & new)
MPOL_F_RELATIVE_NODES: overwrite with a "relative" nodemask (fold+onto?)
Default:               either does a remap or replaces old with new.

My assumption based on this is that a hot-unplugged node would completely
be removed.  Doesn't look like hot-add is handled at all, so I can just
drop that entirely for now (except add default weight of 1 incase it is
ever added in the future).

I've been pushing agianst the weights being in memory-tiers.c for this
reason, as a weight set per-tier is meaningless if a node disappears.

Example: Tier has 2 nodes with some weight N split between them, such
that interleave gives each node N/2 pages.  If 1 node is removed, the
remaining node gets N pages, which is twice the allocation. Presumably
a node is an abstraction of 1 or more devices, therefore if the node is
removed, the weight should change.

You could handle hotplug in tiers, but if a node being hotplugged forcibly
removes the node from cpusets and mempolicy nodemasks, then it's
irrelevant since the node can never get selected for allocation anyway.

It's looking more like cgroups is the right place to put this.

> 
> Moving the global policy to cgroups would make the main cocern of
> different workloads looking for different policy less problamatic.
> I didn't have much time to think that through but the main question is
> how to sanely define hierarchical properties of those weights? This is
> more of a resource distribution than enforcement so maybe a simple
> inherit or overwrite (if you have a more specific needs) semantic makes
> sense and it is sufficient.
>

As a user I would assume it would operate much the same way as other
nested cgroups, which is inherit by default (with subsets) or an
explicit overwrite that can't exceed the higher level settings.

Weights could arguably allow different settings than capacity controls,
but that could be an extension.

> This is not as much about the code as it is about the proper interface
> because that will get cast in stone once introduced. It would be really
> bad to realize that we have a global policy that doesn't fit well and
> have hard time to work it around without breaking anybody.

o7 I concur now.  I'll take some time to rework this into a
cgroups+mempolicy proposal based on my earlier RFCs.

~Gregory
