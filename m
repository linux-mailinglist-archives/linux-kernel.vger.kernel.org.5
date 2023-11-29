Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0607FE27D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjK2V4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2V4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:56:13 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149DFA0;
        Wed, 29 Nov 2023 13:56:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfHrB24vbVz0N3A04wlJYAlJnoosksPQ22NtlL/tv31tdiR8cu+NsNYBC8NKLlnYtoSV3FZM++Dj5MTs5KEyK32aRxpJdrL2GYD6Cj0xlvHKogF8ekIetfU/uIY8KAH5kNZ+xcCvZLSmAipuPaWJM9dIL2uQOkv3Pv6SGjtYe1D1DJFwUgfNXzpVJY/+L4tDMy63Hfc+IhJ+hBYtuQcru+f94De2Ou6FYtHswt5P50kNTQGxOvJmoeV/L8T4t+zaXhqwzAGFPQls7GnAkoC7EXQomgOxKknsQYBWY9EIPluNTvp+YGCD/kwxPr7WlVFLJOBJJeHENhlL5Wr5Qb0OEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5OPI5ozQAbzkgcc95PLUbkebx5iTynkNhxUxqy++1I=;
 b=fZpz41SaG1RUd9PzVy6zPN8IfG/DNvQnvKGOMLHpqOqBP05QeeKUotK/G2kEjwfKC7phOjJ85i/tf69aG2zbIaV/ozyyV9zp0iRShTGrxCDHDpEv9P/OmRPFHDDGSzdiTRrrmaObEcYa76zlPiRbRonl8C3Z72DE23J2GA1dGMDLbQ6eGU2FT1k4//8uECjmULrdpNWHhKJg5k1ykTsuU4kuYtch8HT74xgGC/Mu4j4i/UGBMR3dOrEOxBODgO2sj/GfxRj9cxXJFXvCeMGmM758qvBKW+b2oSXUh0O49o7w6U8hhmBTE2HX3FxUTf/SyWlvDPTX9VtY7mhfyZ7EMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5OPI5ozQAbzkgcc95PLUbkebx5iTynkNhxUxqy++1I=;
 b=FUsOgrv+oq/n4h7wUNueIbSkkcIku5L6qwxAPvjdY07PnHalQUe0uciQ6oSGz7LeWUNUSNyh3kNfJ1J80zIaUcAIXxnCVdDW6i1qVMNGhoALB9Lce6q3FtzqqXlQ7GakcqIT0IHLV7DqL06T87vdJNnr8ZMYQFhiLnMQCFnMQb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4495.namprd17.prod.outlook.com (2603:10b6:a03:298::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.8; Wed, 29 Nov
 2023 21:56:10 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 21:56:10 +0000
Date:   Wed, 29 Nov 2023 16:56:01 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     gregory.price@memverge.com, hannes@cmpxchg.org,
        hasanalmaruf@fb.com, haowang3@fb.com, ying.huang@intel.com,
        dan.j.williams@intel.com, mhocko@suse.com, tj@kernel.org,
        hezhongkun.hzk@bytedance.com, fvdl@google.com, john@jagalactic.com,
        vtavarespetr@micron.com, sthanneeru@micron.com,
        ravis.opensrc@micron.com, Jonathan.Cameron@huawei.com,
        emirakhur@micron.com, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, linux-api@vger.kernel.org
Subject: [RFC] new mempolicy syscalls (mempolicy2 and pidfd)
Message-ID: <ZWezcQk+BYEq/WiI@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::11) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 639cbad0-879c-4a2a-6cf9-08dbf125fefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YncRA3GoqX0iy25Cj1gIl/r4CItnG8ei/Nx56u5FM6gTAL+ntlbii1XUei3nZ65AtUZ+XY4sRLohF+1hEt7mptUg/XFfb/dfw/i3wf/4r2Io4MheJMcdlOX171SHf9wollYmSAORt3YFFRCusLSubSGWJyP1n2H994SWIuvDA38XfmZEcAZXrFxeBdn/OHgRcoP6JWO1dZzdsozntcNUgfmQ3LYhCYk61RoT29/pr5KmO/DUFpg4TUkoLnAhobYVfVqA4KCyMgfuse4NELNeIX87jyzYBdTSYgtVLZfNzEAiLCYjFlEC+vphQP6skebDpV6TT4isy+JOGmLD/oVDgcb72w8W7527oKNXk8Xk8/mtz1USsyvcAJhfvblfcl2wF9o7L1GIeeVT41eDS9w8MZ1tLofRqxnPi+lxUIVYSv7ZZhWw4bX7QeeNb0dAWFt18gTpP5kI5Mxde0peevnFP+w8nHXjD0vtT5zFACSH8p2R1oeJbUuq/D3NNv+HZ3qbRiQrlKfr4fV5L/BE9VDfvCKEG3EwqllH2QrGR1MLg8JMrdXAJb2qCZ9CFJgJ882HAotKt3zB59C0W6obFElnvFiAHnJ6+rVIqejh4FkBMoO1bPMXP5r2Pk4QmR/Ca+cHYGU8qz/ASkW+BDjksADdAqusGRskXTIt3gZtLPIZMm8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(346002)(366004)(396003)(376002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2616005)(26005)(6512007)(41300700001)(202311291699003)(44832011)(36756003)(6916009)(316002)(66476007)(86362001)(66946007)(6486002)(966005)(5660300002)(7416002)(4326008)(8676002)(8936002)(66556008)(6666004)(83380400001)(38100700002)(6506007)(478600001)(30864003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tvrfp9Mqr9I2Xka6N/jE8lZ2XvY81xCzn3zB80mO/n4FR3ErJE+p++hqZzcQ?=
 =?us-ascii?Q?oYLN3XWKSezqhmR/CK8zELiP2rqm6bqxs/aKUg2bGTsh16EkLU/TPJyjSCLq?=
 =?us-ascii?Q?HOjdNX6Dt0cHeP466m9DcOjQBRWIzIyg3k7MFkKvFvSPikm0cxVzTrAGQf45?=
 =?us-ascii?Q?ayXEJw2OVqp7nQOXaDX/t+yPQp04wMh1gx229Ok8zFEF23IPUHr06kQFwXZR?=
 =?us-ascii?Q?uBcKQog78gDwZDPj1OlTMWIGwC/7Cn4Qba1TJW6FNjlZBIWLsMQSJClXocRj?=
 =?us-ascii?Q?NKq5kT3TwKwUtL0XnnyjnYkHOyVaClUY67nBBm7x4Q4oTbcZtDMi7a1F/oPl?=
 =?us-ascii?Q?WMSZ+entSuXSTpj0Z4qwVW9L9eYLod5UZpoUTdaWBJIQFZqkGswJEd+63c6G?=
 =?us-ascii?Q?PCGHFuurp2YMyycReHIGexidcHw1LyOGdApgDBZe2svYVZi0fk4J5zaRHCki?=
 =?us-ascii?Q?eID1V2a383rcncxQSJNxPBVL2+xxtTZWjrc9yMLt4xu+J52Dvg361u2X0BGO?=
 =?us-ascii?Q?gMip+UKBlqGoRDqIsqh/sRcRsvYLYL0jMjp5OP5AX9pZDq2D0AcKjRxy5kmC?=
 =?us-ascii?Q?PIP5H5jffWPh5/lPkVT7I3WGpCJSN2w3vQFguxcYuLCiBwZPZZWCG6Lec/L9?=
 =?us-ascii?Q?wTNaY+My/rJF9CUBV8JegocuzrDQBbraj5Mg11bQtoueUDFyx7AbcKE+J14A?=
 =?us-ascii?Q?w+hS1RThA9VlgNz8pB4cEUtFgR1k+2nq2ICoE5nfoFhEDLGSBbqWdnHfWlyI?=
 =?us-ascii?Q?6OYpTG8KVZlfrnNBb2lf9Dv20cXUEsqp4HINHO4UYjDgbjBWFQuCJmRoHpe3?=
 =?us-ascii?Q?ljUKulCtzjj6K0mPIrP84BcSe4oqvMvTmUeq/KrCDScRkPoDE9wdjpJK4+7D?=
 =?us-ascii?Q?Msy5gWDX/nanLgK4AYN3Krf7HhoKCmwz9rdOtb7EBsMQQHKoN8bq4cJrIObd?=
 =?us-ascii?Q?KJu2KUJFDGG/tLt5yleMfHUzadmlYjAXDOYERAzWMesuSuZuZ9oh1blgZWZ3?=
 =?us-ascii?Q?VAD/ecnyZtYLGqZAJlPRnBvGNf+TgNE3SICHusk06rbz7pyzOAFRv3TXcRPL?=
 =?us-ascii?Q?JjQb9zmwctgYBF7zpEmGvsOOoZ810Fo+npKrDxClTmg3WzGCZSNvjMhTE97P?=
 =?us-ascii?Q?cLRqXcjigdaxkTDt6esV+d4TEURGSBSdBST+ww6aU9up+nJwYguLEacVdBWb?=
 =?us-ascii?Q?eZUnq4jMe8JK/z7pwAcxFTqrIX+TiSUCP2ZX6N63qwzWuJ2Q1HWqumchGDpQ?=
 =?us-ascii?Q?roS1JFGjGYRmOYE4SzKF0Md7pU+hM3LvkxbTj7xyyOjtvzTIMcZVMYNt3sd0?=
 =?us-ascii?Q?WC2v5moKOwwdCIPkxB9LBac5cWG9Pp4iyVYDGQiBALvvs9JlId0T0yFem2KQ?=
 =?us-ascii?Q?pCmUb5nvaQ2VcDxtSm3Bv4sYT1Tb5uccG/rQRqXy5A8M4bBBlLpmpdCNBsel?=
 =?us-ascii?Q?BgYJrzhh+pQYaqeJvIWnoe0785OG08Tx989aMRqpYnNVGjyXeYM3j4X7Mmkm?=
 =?us-ascii?Q?LPMT2WQa1gWQnGGqPjP7cll6dtLbqYByJ5+IrDDVFXB1kDgi9jm3XoW4nTAJ?=
 =?us-ascii?Q?kAUtXmAfoKAQP7dhtSuDOvUn2iJnUDRlDKK9xA9tt5Gbtw6Jnk3YkbURzs0U?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639cbad0-879c-4a2a-6cf9-08dbf125fefd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 21:56:09.9027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKzEjDPkBDZKAKeKezAdX6cBtfS0H8AljI32A9j2RZ6E2Dl6+VSeAV/DnFr7OPLOgWNVQ4ZRDXoOSSlwoWrWS7o5Q1TblAIsujvn8KaEkP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4495
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am sending this to pull together notes from a few months
of different proposals on mempolicy extensions, and some of
the feedback that has been given.

There has been some consensus on the implementation of new
mempolicy syscalls, which also gives us an opportunity to 
clean up some warts in the old ones.

This summarizes the current plan.

Hoping to get some feedback on the interfaces before we get
too far into building out the whole thing.  Ultimately the
extensions proposed here are not too complicated, but locking
in syscall interfaces is always contentious.

==========================================================
Background:

Presently there exist 4 syscall interfaces with which a user
can interact with the current task mempolicy, or the current
task's vma mempolicies:

set_mempolicy :
        set a task's mempolicy

get_mempolicy :
        4 possible operations w/ some variants
        * fetch task->mems_allowed
        * fetch task->policy (mode, flag, nodemask)
        * fetch vma->policy for address
                * possibly the node for that address as well
        * fetch next interleave node for mempolicy

set_mempolicy_home_node :
        set VMA's home node and possibly migrate

mbind :
        set VMA mempolicy and possibly migrate


There have been a few proposals for extending this:

1) make mempolicies modifiable from external tasks (pidfd)
        - both task and vma policies

2) make mempolicy more extensible (weighted interleave)
        - requires new fields, and therefore new syscall

3) Clean up set_mempolicy flag warts

This RFC proposes the following interfaces
        set_mempolicy2
        get_mempolicy2
        get_vma_mempolicy
        process_set_mempolicy
        process_get_mempolicy
        process_get_vma_mempolicy

And implies the eventual creation of the following:
        set_vma_mempolicy
        process_set_vma_mempolicy


This RFC captures 4 different, but related proposals.

Proposal 1: new intefaces should reduce flags
Proposal 2: making the mempolicies externally modifiable
Proposal 3: new syscall interfaces
Proposal 4: weighted interleave


==========================================================
Proposal 1: Reducing flags in favor of explicit interfaces

Right now, set_mempolicy and get_mempolicy are two very different
interfaces with very different behaviors based on mode flags and
syscall flags. Depending on the flags, they may not even access
the mempolicy at all!

For example, the behavior of get_mempolicy can be changed to
retrieve task->mems_allowed, or replace the policy argument
output a node.

Both of these are awful warts.  One expects a get_mempolicy
syscall to... get the mempolicy.  Instead, mems_allowed is more
of a cgroups/cpuset policy - which while related and affects the
mempolicy, is not actually part of (task->mempolicy) or a vma
mempolicy.

The defines for these flags are also confusing and difficult
not intuitive at a glance:

Mode flags: or'd into the *mode* in set_mempolicy(mode, ...)
#define MPOL_F_STATIC_NODES     (1 << 15)
#define MPOL_F_RELATIVE_NODES   (1 << 14)
#define MPOL_F_NUMA_BALANCING   (1 << 13)

get_mempolicy Syscall flags: passed into get_mempolicy as an arg
#define MPOL_F_NODE     (1<<0)
#define MPOL_F_ADDR     (1<<1)
#define MPOL_F_MEMS_ALLOWED (1<<2)

I'd like to do away with as many of the operations flags as possible,
if not all of them, and define new interfaces with explicit extensions
in an argument structure and/or separate syscalls all together to
separate out the funtionality.

Example:

struct mpol_args {
        int mode;
        unsigned short mode_flags;   /* STATIC/RELATIVE_NODEs, etc */
        unsigned long *policy_nodemask;
        unsigned long policy_maxnode;
        unsigned long *mems_allowed; /* replace MPOL_F_MEMS_ALLOWED */
        unsigned long mems_maxnode;
        unsigned long policy_node;   /* replace MPOL_F_NODE */
        unsigned long vma_node;      /* replace MPOL_F_NODE */
	/* Replace MPOL_F_ADDR with a new syscall */
};

In this setup, the following is true:

a) mode and mode_flags operate the same as the original, except
   that the space is no longer shared.  Internally, these fields
   are stored separately in `struct mempolicy` anyway... so why
   is the user interface overloading mode? Fix it.

b) MPOL_F_ADDR (op_flag) is deprecated, instead implment
   get_vma_mempolicy(addr, mpol_args, size) (see next section)

c) MPOL_F_MEMS_ALLOWED is deprecated. Instead, add the field
   (args->mems_allowed).  If the pointer is set, fetch the
   mems allowed. If not, don't!

   (This also lets us refactor the old interface in terms of the
   new one, which is a bonus for maintainability).

d) MPOL_F_NODE is deprecated in favor of adding a policy_node field.
   policy_node is filled based policy.  For example, if the active
   policy is MPOL_INTERLEAVE, we set policy_node to the next node.

   if (pol->mode == MPOL_INTERLEAVE)
     policy_node = next_numa_node(task->il_prev, pol->nodes);

e) vma_node is fetched if a vma policy is accessed.  vma_node is
   otherwise ignored by get_mempolicy2, and is only filled by
   get_vma_mempolicy.

   again, the inclusion in mpol_args allows us to refactor the
   old interface in terms of the new one to reduce maintenance
   issues - but that may come over time.


Ultimately this gives us a single extensible struct with flexiblity
on how to develop new interfaces around it.

Questions:
1) Do we use 1 struct (mpol_args), or multiple.  Specifically do
   we define different structures for get/set, and do we define
   different structures for task vs vma mempolicies?

   Here i'm proposing 1 structure, because the core output (mode,
   flags, nodemask) is the same, but the location from where
   the data is fetched is different (task vs vma).

   Additionally, get/set can take the same arg structure and
   simply ignore the non-relevant fields. For example, the
   set_* interfaces would ignore (args->mems_allowed), because
   that's not mutable from this interface.

2) Having handled F_NODE, F_ADDR, and F_MEMS_ALLOWED like above,
   I don't see the need for (args->op_flags), or a flags argument
   as part of the syscall interface -  but folks love their flag
   fields - should it stay or be omitted?

   Personally i think this should be omitted, as it can always
   be appended later if really needed.


==========================================================
Proposal 2: Making mempolicy externally modifiable

This has been proposed and suggeted by a variety of sources

pidfd_set_mempolicy
https://lore.kernel.org/linux-mm/20221010094842.4123037-1-hezhongkun.hzk@bytedance.com/

process_mbind
https://lore.kernel.org/linux-mm/ZV50MX4STKRCohiB@r13-u19.micron.com/

*_task_mempolicy syscalls
https://lore.kernel.org/linux-mm/20231122211200.31620-1-gregory.price@memverge.com/
https://lore.kernel.org/linux-mm/20231122211200.31620-8-gregory.price@memverge.com/

Unfortunately the mbind/home_node interfaces have to be deferred to
a later patch set, due to the complexities of plumbing the task
reference through multiple sub-systems, but this does not majorly
affect the interface itself or its arguments, just the internal
plumbing.

Context on process_set_mempolicy_home_node and process_mbind:
https://lore.kernel.org/linux-mm/ZWYsth2CtC4Ilvoz@memverge.com/

For this reason, I would forego the implementation of set_vma_mempolicy
for the time-being - especially since mbind and set_mempolicy_home_node
already exist.  The real value here is the process variant, which we
can take time to implement separately.

So the initial proposal is for the following:

/* Set the target task mempolicy */
process_set_mempolicy(int pidf, struct mpol_args *args, size_t size);

/* Get the target task mempolicy */
process_get_mempolicy(int pidf, struct mpol_args *args, size_t size);

/* Get the target task's vma mempolicy for address */
process_get_vma_mempolicy(int pidf, unsigned long addr,
			  struct mpol_args *args, size_t size);

==========================================================
Proposal 3: New Syscalls

We are proposing the addition of 6 total new syscall interfaces
in the initial RFC, with some implications that we may add 2 more
in the future.

Current task interfaces:

set_mempolicy2(struct mpol_args *args, size_t usize);
get_mempolicy2(struct mpol_args *args, size_t usize);
get_vma_mempolicy(unsigned long addr, struct mpol_args *args, size_t usize);

Remote task interfaces:

process_set_mempolicy(int pidfd, struct mpol_args *args, size_t usize);
process_get_mempolicy(int pidfd, struct mpol_args *args, size_t usize);
process_get_vma_mempolicy(int pidfd, unsigned long addr,
                          struct mpol_args *args, size_t usize);

These interfaces allow for the retrieval of task or vma policies, but
only allow for the modification of *task* policies.

mbind/set_mempolicy_home_node allow for the mempolicy of VMA's to be
set for the current task, and the plumbing of remote-task vma policy
modification requires much deeper consideration (see proposal 2).

==========================================================
Proposal 4: Weighted Interleave

This proposal is to create a weighted interleave policy, either as an
extension of MPOL_INTERLEAVE, or separetly  (MPOL_WEIGHTED_INTERLEAVE).

The default weight would be 1 for all possible nodes, so the default
behavior of MPOL_WEIGHTED_INTERLEAVE would be MPOL_INTERLEAVE, which
was why we eventually chose to implement this just an extension of
MPOL_INTERLEAVE in some of the later RFC's below.

Basically this is summarized as two basic additions:

struct mempolicy {
        ...
        unsigned char cur_weight; /* weight of current il node */
        unsigned char *interleave_weights; /* size: MAX_NUMNODES */
};

and

struct mpol_args {
        ...
        unsigned char *interleave_weights;
};

By setting the weights of each node in nodemask, it's possible to
distribute allocations across those nodes based on the available
bandwidth of those nodes.

For example node 0 may provide 100GB/s of bandwidth, while node 1
may only provide 50GB/s of bandwidth.  In this case, traditional
1:1 interleave is a sub-optimal distribution of memory.  Setting
the weights to 2:1 would match the bandwidth distribution between
nodes (100:50) and therefore be closer to the optimal distribution.

Original N:M implementation:
https://lore.kernel.org/linux-mm/YqD0%2FtzFwXvJ1gK6@cmpxchg.org/T/

original mempolicy RFC:
https://lore.kernel.org/linux-mm/20231003002156.740595-1-gregory.price@memverge.com/

memtier implementation:
https://lore.kernel.org/linux-mm/20231009204259.875232-1-gregory.price@memverge.com/

node-weight implementation:
https://lore.kernel.org/linux-mm/20231031003810.4532-1-gregory.price@memverge.com/

cgroups/memcg implementation:
https://lore.kernel.org/linux-mm/20231109002517.106829-1-gregory.price@memverge.com/

Summary of some of this work on LWN:
https://lwn.net/Articles/948037/

The general feedback across these RFC's has been that there is no
consensus on where/whether "global weights" should exist, but consistent
consensus that mempolicy->weights seems like a reasonable idea.

So we are proposing this extension first, before exploring a global
setting more generally.

Open Questiosn
1) MPOL_INTERLEAVE extension or new MPOL_WEIGHTED_INTERLEAVE ?
2) Global weight location (not relevant for this set of poposals)
        cgroup/memcg   - "doesn't belong"
        cgroup/cpusets - locking contension issue
        node - "too broad"
        memtier - "doesn't make sense / too broad"
        new sysfs entry entirely separate from the above?

==========================================================

Summarizing Open questions:

1) single arg struct (struct mpol_args) or multiple?

2) do away with operation flags (F_NODE, F_ADDR, F_MEMS_ALLOWED), or keep
   them?  (retained for old interface, just deprecated on new one).

3) Should these syscalls take a flags argument (outside mode_flags)

4) split task and vma mempolicy operations, or single interface for both?

5) Are you grossly offended by any of this? Do you have specific
   recommendations?

6) Any specific testing requirements you would like to see to make
   this quick an painless? (ktest, ltp somewhat implied).

==========================================================

Capturing all the suggested-by tags for folks who chimed in on
prior RFCs and Patches.

Suggested-by: Gregory Price <gregory.price@memverge.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Hasan Al Maruf <hasanalmaruf@fb.com>
Suggested-by: Hao Wang <haowang3@fb.com>
Suggested-by: Ying Huang <ying.huang@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Suggested-by: tj <tj@kernel.org>
Suggested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
Suggested-by: Frank van der Linden <fvdl@google.com>
Suggested-by: John Groves <john@jagalactic.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Suggested-by: Srinivasulu Thanneeru <sthanneeru@micron.com>
Suggested-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>

Signed-off-by: Gregory Price <gregory.price@memverge.com>

Kind Regards,
Gregory Price
