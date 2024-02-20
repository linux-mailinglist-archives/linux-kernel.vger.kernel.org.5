Return-Path: <linux-kernel+bounces-72416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CA685B2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613401F223C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410641EB44;
	Tue, 20 Feb 2024 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZHmhhZZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B6259C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411116; cv=none; b=NtOL2WUE8pGJvqd2S2AKwNS0Zp2/HkJyffXu01YOvAsROlvl5fFXoejl9LSCOJDv3RXNe79/f06cPO5Ly1EJ7YQMy0VehEuZUDQollYXxehciU9zZGBM520ND0yo1DOcvoOE0z5OFgg1JGlWqKCJCThfmfVc16Y1mi37krhgQxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411116; c=relaxed/simple;
	bh=Klx/nY3WOFzoOE9Y1r2yIIXvxsA5VgjOXmNBewN3N1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qv6zXacicICqQQaeJHZki0gBvZskdg6Huevl1cho/kXVCzsXHMCiPfudXGJHYuD/Hpjx3dsxUn1IdZKBlCUZeeVnQKPv80oROzSazsEPXBca6+Hp9TKDNj86ERtu/WSCnI26ckjkkK5hk13HlxqoZgOKtahLeWZwTUVxSs9ON7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZHmhhZZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708411114; x=1739947114;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Klx/nY3WOFzoOE9Y1r2yIIXvxsA5VgjOXmNBewN3N1Y=;
  b=MZHmhhZZSjCnQSsMSvej2ZqGUR4gqbHsVacJQYmZFHELmdsrO/kYB7c6
   ox3JmmVdxKjB3oKiW4ddiZupM/qMUtWzZDoxW/7sInZsdQfnGFVdM+qUg
   OCRmutrvpwUbTCebFHP0hQlA7A4f4xpKq6AQHRV9HuBVec7Cqz5JMTYmV
   t9b8BqzHm/Eyra1uwRkSbpS4v5SVeqr5BbfvS61UmskpwW4QgKSLjA9op
   x1s+yQqqDRXP3KxPZG+fn28BpR1qkqBtKY0lTFGaOQFxCJ9UX0Tqf5gpv
   1rBVMeO9KTxKHuYtUuzDYkXdJoIqAHwI54VPhrKHp9SWXJ4/G92YrMEib
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2363589"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2363589"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 22:38:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="9379846"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 22:38:28 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Aneesh Kumar <aneesh.kumar@kernel.org>,
  Dave Hansen <dave.hansen@linux.intel.com>,  Mel Gorman <mgorman@suse.de>,
  Ben Widawsky <ben.widawsky@intel.com>,  Feng Tang <feng.tang@intel.com>,
  Andrea Arcangeli <aarcange@redhat.com>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Rik van Riel
 <riel@surriel.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Mike Kravetz <mike.kravetz@oracle.com>,  Vlastimil
 Babka <vbabka@suse.cz>,  Dan Williams <dan.j.williams@intel.com>,  Hugh
 Dickins <hughd@google.com>,  Kefeng Wang <wangkefeng.wang@huawei.com>,
  Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 3/3] mm/numa_balancing:Allow migrate on protnone
 reference with MPOL_PREFERRED_MANY policy
In-Reply-To: <e7b138a4-de46-4cb6-94b8-67019e0369e9@linux.ibm.com> (Donet Tom's
	message of "Mon, 19 Feb 2024 19:14:48 +0530")
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
	<8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
	<ZdNEg_aA0LHJY22T@tiehlicka>
	<e7b138a4-de46-4cb6-94b8-67019e0369e9@linux.ibm.com>
Date: Tue, 20 Feb 2024 14:36:32 +0800
Message-ID: <87bk8bprpr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Donet Tom <donettom@linux.ibm.com> writes:

> On 2/19/24 17:37, Michal Hocko wrote:
>> On Sat 17-02-24 01:31:35, Donet Tom wrote:
>>> commit bda420b98505 ("numa balancing: migrate on fault among multiple b=
ound
>>> nodes") added support for migrate on protnone reference with MPOL_BIND
>>> memory policy. This allowed numa fault migration when the executing node
>>> is part of the policy mask for MPOL_BIND. This patch extends migration
>>> support to MPOL_PREFERRED_MANY policy.
>>>
>>> Currently, we cannot specify MPOL_PREFERRED_MANY with the mempolicy flag
>>> MPOL_F_NUMA_BALANCING. This causes issues when we want to use
>>> NUMA_BALANCING_MEMORY_TIERING. To effectively use the slow memory tier,
>>> the kernel should not allocate pages from the slower memory tier via
>>> allocation control zonelist fallback. Instead, we should move cold pages
>>> from the faster memory node via memory demotion. For a page allocation,
>>> kswapd is only woken up after we try to allocate pages from all nodes in
>>> the allocation zone list. This implies that, without using memory
>>> policies, we will end up allocating hot pages in the slower memory tier.
>>>
>>> MPOL_PREFERRED_MANY was added by commit b27abaccf8e8 ("mm/mempolicy: add
>>> MPOL_PREFERRED_MANY for multiple preferred nodes") to allow better
>>> allocation control when we have memory tiers in the system. With
>>> MPOL_PREFERRED_MANY, the user can use a policy node mask consisting only
>>> of faster memory nodes. When we fail to allocate pages from the faster
>>> memory node, kswapd would be woken up, allowing demotion of cold pages
>>> to slower memory nodes.
>>>
>>> With the current kernel, such usage of memory policies implies we can't
>>> do page promotion from a slower memory tier to a faster memory tier
>>> using numa fault. This patch fixes this issue.
>>>
>>> For MPOL_PREFERRED_MANY, if the executing node is in the policy node
>>> mask, we allow numa migration to the executing nodes. If the executing
>>> node is not in the policy node mask but the folio is already allocated
>>> based on policy preference (the folio node is in the policy node mask),
>>> we don't allow numa migration. If both the executing node and folio node
>>> are outside the policy node mask, we allow numa migration to the
>>> executing nodes.
>> The feature makes sense to me. How has this been tested? Do you have any
>> numbers to present?
>
> Hi Michal
>
> I have a test program which allocate memory on a specified node and
> trigger the promotion or migration (Keep accessing the pages).
>
> Without this patch if we set MPOL_PREFERRED_MANY promotion or migration w=
as not happening
> with this patch I could see pages are getting  migrated or promoted.
>
> My system has 2 CPU+DRAM node (Tier 1) and 1 PMEM node(Tier 2). Below
> are my test results.
>
> In below table N0 and N1 are Tier1 Nodes. N6 is the Tier2 Node.
> Exec_Node is the execution node, Policy is the nodes in nodemask and
> "Curr Location Pages" is the node where pages present before migration
> or promotion start.
>
> Tests Results
> ------------------
> Scenario 1:=C2=A0 if the executing node is in the policy node mask
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> Exec_Node=C2=A0=C2=A0=C2=A0 Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Curr Location Pages       Observations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N0 N1 N6=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N1=
                Pages Migrated from N1 to N0
> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N0 N1 N6=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N6           =
     Pages Promoted from N6 to N0
> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N0 N1=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0  N1 =
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0    Pages Migr=
ated from N1 to N0
> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N0 N1=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=
=A0N6 =C2=A0 =C2=A0            Pages Promoted from N6 to N0
>
> Scenario 2: If the folio node is in policy node mask and Exec node not in=
 policy=C2=A0 node mask
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> Exec_Node=C2=A0=C2=A0=C2=A0 Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Cu=
rr Location Pages=C2=A0=C2=A0=C2=A0  =C2=A0 Observations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0  =C2=A0=C2=A0=C2=A0 N1 N6=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N1               =
Pages are not Migrating to N0
> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N1 N6=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N6   =
            Pages are not migration to N0
> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0N1=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =C2=A0N1 =C2=A0 =C2=A0           Pages are not Migrating to N0
>
> Scenario 3: both the folio node and executing node are outside the policy=
 nodemask
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> Exec_Node=C2=A0 =C2=A0 Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Curr Location Pages=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Observations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 N1=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N6 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 Pages P=
romoted from N6 to N0
> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0N6                     N1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Pages Migrated from N1 to N0
>

Please use some benchmarks (e.g., redis + memtier) and show the
proc-vmstat stats and benchamrk score.

Not part of the kernel series, but don't forget to submit patches to the
man pages project and numactl tool to let users use it.

--
Best Regards,
Huang, Ying

> Thanks
> Donet Tom
>
>>
>>> Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>> ---
>>>   mm/mempolicy.c | 28 ++++++++++++++++++++++++++--
>>>   1 file changed, 26 insertions(+), 2 deletions(-)
>> I haven't spotted anything obviously wrong in the patch itself but I
>> admit this is not an area I am actively familiar with so I might be
>> missing something.

