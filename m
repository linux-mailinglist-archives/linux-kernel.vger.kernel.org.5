Return-Path: <linux-kernel+bounces-72504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7524185B45A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54DCDB210A1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFB65BAFA;
	Tue, 20 Feb 2024 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bf2QKl78"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45055BAE9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416184; cv=none; b=O4Dhic/H0194CCDeHVw8rm9e6oXf76Oxi7eFbmxRkMV9hs3PwSgC+7DzVwo6o6mwvNm0cXl9Ly9kx5ujaC0vZRVETfVWZWvOnS63CR/cCRAC+y6YTQjeZ1Zvx4rT8xhuR/L2U5g9pyFVd5TM+3POfijVutbyZlopnbY6CfATxbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416184; c=relaxed/simple;
	bh=U6BfJQ3lOKorfCB2xQScU7DGVW3UzgWVQwNkzflFuAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SvkLC7YUmZ3j+TRFKVWhyrWam7xwzuBLmrpC5E0cDFxS0O0pLpgv1lJzBVjRYf1Pi2MGcJMGuxicWxpp4WSujRcRLE/9tJN1VjleNmSOzjPeNt+DkCnxXLIN7Oxdgu1/60EKedlxd+SK24T92xRQxIaucEDTkkm4z2yex9FosvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bf2QKl78; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708416183; x=1739952183;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=U6BfJQ3lOKorfCB2xQScU7DGVW3UzgWVQwNkzflFuAA=;
  b=bf2QKl78+NnpFFYJ6POzBdNmHJkmLiEJe0+LshorWY9yB0lS3lVNCkNL
   +EW+m6ml+yad4dYYhP5C4xVrr+z3nRJeXRYnyZMvLGaDfzqxl7R0AxRbh
   V5yF2iHoqPsxA4BfTCUFyZFYDHmTYrS21FLhY7jipqEyITmolN3O4cHI5
   GYkb8ZYT0Yssg/bjnsFk43k0sBakIR4FFqbpSrerUZDp8afY4QzmeIlWA
   mm3ZsqN6o0BmuhMMUQdlqU48R9YDMR49QDmWCOMMMg6TvQau2qEVN/DBn
   aSfic1pQP2Nd9jefUbzVOqMGs/gpOLVN9fvNWV/t3GrbMaLvxlJPW8JIV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2965043"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2965043"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 00:03:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4605179"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 00:02:56 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Donet Tom <donettom@linux.ibm.com>,  Michal Hocko <mhocko@suse.com>,
  Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Dave Hansen <dave.hansen@linux.intel.com>,
  Mel Gorman <mgorman@suse.de>,  Feng Tang <feng.tang@intel.com>,  Andrea
 Arcangeli <aarcange@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@redhat.com>,  Rik van Riel <riel@surriel.com>,
  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Mike Kravetz <mike.kravetz@oracle.com>,  Vlastimil
 Babka <vbabka@suse.cz>,  Dan Williams <dan.j.williams@intel.com>,  Hugh
 Dickins <hughd@google.com>,  Kefeng Wang <wangkefeng.wang@huawei.com>,
  Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 3/3] mm/numa_balancing:Allow migrate on protnone
 reference with MPOL_PREFERRED_MANY policy
In-Reply-To: <87v86jzifo.fsf@kernel.org> (Aneesh Kumar K. V.'s message of
	"Tue, 20 Feb 2024 13:16:51 +0530")
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
	<8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
	<ZdNEg_aA0LHJY22T@tiehlicka>
	<e7b138a4-de46-4cb6-94b8-67019e0369e9@linux.ibm.com>
	<87bk8bprpr.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<e88eedb7-cad6-4298-8710-4abc98048529@kernel.org>
	<87y1bfoayd.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<87v86jzifo.fsf@kernel.org>
Date: Tue, 20 Feb 2024 16:01:01 +0800
Message-ID: <87plwro98i.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> "Huang, Ying" <ying.huang@intel.com> writes:
>
>> "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> writes:
>>
>>> On 2/20/24 12:06 PM, Huang, Ying wrote:
>>>> Donet Tom <donettom@linux.ibm.com> writes:
>>>>=20
>>>>> On 2/19/24 17:37, Michal Hocko wrote:
>>>>>> On Sat 17-02-24 01:31:35, Donet Tom wrote:
>>>>>>> commit bda420b98505 ("numa balancing: migrate on fault among multip=
le bound
>>>>>>> nodes") added support for migrate on protnone reference with MPOL_B=
IND
>>>>>>> memory policy. This allowed numa fault migration when the executing=
 node
>>>>>>> is part of the policy mask for MPOL_BIND. This patch extends migrat=
ion
>>>>>>> support to MPOL_PREFERRED_MANY policy.
>>>>>>>
>>>>>>> Currently, we cannot specify MPOL_PREFERRED_MANY with the mempolicy=
 flag
>>>>>>> MPOL_F_NUMA_BALANCING. This causes issues when we want to use
>>>>>>> NUMA_BALANCING_MEMORY_TIERING. To effectively use the slow memory t=
ier,
>>>>>>> the kernel should not allocate pages from the slower memory tier via
>>>>>>> allocation control zonelist fallback. Instead, we should move cold =
pages
>>>>>>> from the faster memory node via memory demotion. For a page allocat=
ion,
>>>>>>> kswapd is only woken up after we try to allocate pages from all nod=
es in
>>>>>>> the allocation zone list. This implies that, without using memory
>>>>>>> policies, we will end up allocating hot pages in the slower memory =
tier.
>>>>>>>
>>>>>>> MPOL_PREFERRED_MANY was added by commit b27abaccf8e8 ("mm/mempolicy=
: add
>>>>>>> MPOL_PREFERRED_MANY for multiple preferred nodes") to allow better
>>>>>>> allocation control when we have memory tiers in the system. With
>>>>>>> MPOL_PREFERRED_MANY, the user can use a policy node mask consisting=
 only
>>>>>>> of faster memory nodes. When we fail to allocate pages from the fas=
ter
>>>>>>> memory node, kswapd would be woken up, allowing demotion of cold pa=
ges
>>>>>>> to slower memory nodes.
>>>>>>>
>>>>>>> With the current kernel, such usage of memory policies implies we c=
an't
>>>>>>> do page promotion from a slower memory tier to a faster memory tier
>>>>>>> using numa fault. This patch fixes this issue.
>>>>>>>
>>>>>>> For MPOL_PREFERRED_MANY, if the executing node is in the policy node
>>>>>>> mask, we allow numa migration to the executing nodes. If the execut=
ing
>>>>>>> node is not in the policy node mask but the folio is already alloca=
ted
>>>>>>> based on policy preference (the folio node is in the policy node ma=
sk),
>>>>>>> we don't allow numa migration. If both the executing node and folio=
 node
>>>>>>> are outside the policy node mask, we allow numa migration to the
>>>>>>> executing nodes.
>>>>>> The feature makes sense to me. How has this been tested? Do you have=
 any
>>>>>> numbers to present?
>>>>>
>>>>> Hi Michal
>>>>>
>>>>> I have a test program which allocate memory on a specified node and
>>>>> trigger the promotion or migration (Keep accessing the pages).
>>>>>
>>>>> Without this patch if we set MPOL_PREFERRED_MANY promotion or migrati=
on was not happening
>>>>> with this patch I could see pages are getting  migrated or promoted.
>>>>>
>>>>> My system has 2 CPU+DRAM node (Tier 1) and 1 PMEM node(Tier 2). Below
>>>>> are my test results.
>>>>>
>>>>> In below table N0 and N1 are Tier1 Nodes. N6 is the Tier2 Node.
>>>>> Exec_Node is the execution node, Policy is the nodes in nodemask and
>>>>> "Curr Location Pages" is the node where pages present before migration
>>>>> or promotion start.
>>>>>
>>>>> Tests Results
>>>>> ------------------
>>>>> Scenario 1:=C2=A0 if the executing node is in the policy node mask
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>>> Exec_Node=C2=A0=C2=A0=C2=A0 Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Curr Location Pages       Observations
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N0 N1 =
N6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
N1                Pages Migrated from N1 to N0
>>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N0 N1 N6=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N6        =
        Pages Promoted from N6 to N0
>>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N0 N1=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0  =
N1 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0    Pages M=
igrated from N1 to N0
>>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N0 N1=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =
=C2=A0N6 =C2=A0 =C2=A0            Pages Promoted from N6 to N0
>>>>>
>>>>> Scenario 2: If the folio node is in policy node mask and Exec node no=
t in policy=C2=A0 node mask
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>>> Exec_Node=C2=A0=C2=A0=C2=A0 Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Curr Location Pages=C2=A0=C2=A0=C2=A0  =C2=A0 Observations
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0  =C2=A0=C2=A0=C2=A0 N1 N6=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N1         =
      Pages are not Migrating to N0
>>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N1 N6=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N6=
               Pages are not migration to N0
>>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0N=
1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A0N1 =C2=A0 =C2=A0           Pages are not Migrating to N0
>>>>>
>>>>> Scenario 3: both the folio node and executing node are outside the po=
licy nodemask
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>>>> Exec_Node=C2=A0 =C2=A0 Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Curr Location Pages=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Observati=
ons
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 N1=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N6 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 Page=
s Promoted from N6 to N0
>>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0N6                     N1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0Pages Migrated from N1 to N0
>>>>>
>>>>=20
>>>> Please use some benchmarks (e.g., redis + memtier) and show the
>>>> proc-vmstat stats and benchamrk score.
>>>
>>>
>>> Without this change numa fault migration is not supported with MPOL_PRE=
FERRED_MANY
>>> policy. So there is no performance comparison with and without patch. W=
r.t effectiveness of numa
>>> fault migration, that is a different topic from this patch
>>
>> IIUC, the goal of the patch is to optimize performance, right?  If so,
>> the benchmark score will help justify the change.
>>
>
> The objective is to enable the use of the MPOL_PREFERRED_MANY policy,
> which is essential for the correct functioning of memory demotion in
> conjunction with memory promotion. Once we can use memory promotion, we
> should be able to observe the same benefits as those provided by numa
> fault memory promotion. The actual benefit of numa fault migration is
> dependent on various factors such as the speed of the slower memory
> device, the access pattern of the application, etc. We are discussing
> its effectiveness and how to improve numa fault overhead in other
> forums. However, we believe that this discussion should not hinder the
> merging of this patch.
>
> This change is similar to commit bda420b98505 ("numa balancing: migrate
> on fault among multiple bound nodes")

We provide the performance data in the description of that commit :-)

--
Best Regards,
Huang, Ying

