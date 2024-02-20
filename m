Return-Path: <linux-kernel+bounces-72471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB085B3EF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118731C21164
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9C95A4FE;
	Tue, 20 Feb 2024 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bo9M8nSs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D385A4D3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413957; cv=none; b=hQkWgOX0tiIezNZQXSGqna330HXKuqK8EUUqcg27lpOPIaPHMDan3dQC+i1fQD0GYpzDR1whu38U4DBxIl7tUyQ9PJ6vn9NY9lXzECN2ufoQCrGfQVaTfcziOJk/rStczluxLw01/bSdX3RYiPSFT7UVMNVZtgG18Cx1Wr6QlCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413957; c=relaxed/simple;
	bh=Bu7bDg5XnddRWp+AqMHunndsJ8KOIOFxplMKQMYJOoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pVGPQt7jYJrnkEVv/6inZXR6CJOe7Y6yVhUtZBeHux4zeiN/bgaupI5GXUpoe4TTlmS7X04PpKUKTQVWW/LU8+loIPT1m2FQglL1Yd6l39XgrTNMwjW9gKXvfqjsam/dGg3nVifiNrKAFoBgwvsRU99S5KTkyUcC+9QZAnYJtvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bo9M8nSs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708413956; x=1739949956;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Bu7bDg5XnddRWp+AqMHunndsJ8KOIOFxplMKQMYJOoM=;
  b=bo9M8nSsaKybNhWeXG6guIW4QEZ8GtfMTnUTNEi5dxriHBoPCgPsWDvi
   AoXaOaPgTkSAwM+i99dOiIjbcIEPAUUJ15AprSGr0Ip8x9NREL4b7S8DK
   OmPovnn+1ErBhay4LgNcD+VgTHvhG724aQn+uvZ5uKtnOmUnMbR29INjU
   vlLGehX7beE9nmqOihGnKR7G+sC8nh8UqevGpdMYBbZXX9QzMaF71eLla
   yvxIxzL1ypIY7kAHDzlxue3X/jmp9aIW7VoVAXAJ3rzJ7PZOC66MQ9Lkf
   wiLft6ICcVjEq/8f5GbteTO8libRFw25Fxz8GNP9WvDZHw6/+dvO5arTW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2406412"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2406412"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 23:25:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4664185"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 23:25:50 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Donet Tom <donettom@linux.ibm.com>,  Michal Hocko <mhocko@suse.com>,
  Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Dave Hansen <dave.hansen@linux.intel.com>,
  Mel Gorman <mgorman@suse.de>,  Ben Widawsky <ben.widawsky@intel.com>,
  Feng Tang <feng.tang@intel.com>,  Andrea Arcangeli <aarcange@redhat.com>,
  Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Rik van Riel <riel@surriel.com>,  Johannes Weiner <hannes@cmpxchg.org>,
  Matthew Wilcox <willy@infradead.org>,  Mike Kravetz
 <mike.kravetz@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,  Dan
 Williams <dan.j.williams@intel.com>,  Hugh Dickins <hughd@google.com>,
  Kefeng Wang <wangkefeng.wang@huawei.com>,  Suren Baghdasaryan
 <surenb@google.com>
Subject: Re: [PATCH 3/3] mm/numa_balancing:Allow migrate on protnone
 reference with MPOL_PREFERRED_MANY policy
In-Reply-To: <e88eedb7-cad6-4298-8710-4abc98048529@kernel.org> (Aneesh Kumar
	K. V.'s message of "Tue, 20 Feb 2024 12:14:48 +0530")
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
	<8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
	<ZdNEg_aA0LHJY22T@tiehlicka>
	<e7b138a4-de46-4cb6-94b8-67019e0369e9@linux.ibm.com>
	<87bk8bprpr.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<e88eedb7-cad6-4298-8710-4abc98048529@kernel.org>
Date: Tue, 20 Feb 2024 15:23:54 +0800
Message-ID: <87y1bfoayd.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Aneesh Kumar K.V" <aneesh.kumar@kernel.org> writes:

> On 2/20/24 12:06 PM, Huang, Ying wrote:
>> Donet Tom <donettom@linux.ibm.com> writes:
>>=20
>>> On 2/19/24 17:37, Michal Hocko wrote:
>>>> On Sat 17-02-24 01:31:35, Donet Tom wrote:
>>>>> commit bda420b98505 ("numa balancing: migrate on fault among multiple=
 bound
>>>>> nodes") added support for migrate on protnone reference with MPOL_BIND
>>>>> memory policy. This allowed numa fault migration when the executing n=
ode
>>>>> is part of the policy mask for MPOL_BIND. This patch extends migration
>>>>> support to MPOL_PREFERRED_MANY policy.
>>>>>
>>>>> Currently, we cannot specify MPOL_PREFERRED_MANY with the mempolicy f=
lag
>>>>> MPOL_F_NUMA_BALANCING. This causes issues when we want to use
>>>>> NUMA_BALANCING_MEMORY_TIERING. To effectively use the slow memory tie=
r,
>>>>> the kernel should not allocate pages from the slower memory tier via
>>>>> allocation control zonelist fallback. Instead, we should move cold pa=
ges
>>>>> from the faster memory node via memory demotion. For a page allocatio=
n,
>>>>> kswapd is only woken up after we try to allocate pages from all nodes=
 in
>>>>> the allocation zone list. This implies that, without using memory
>>>>> policies, we will end up allocating hot pages in the slower memory ti=
er.
>>>>>
>>>>> MPOL_PREFERRED_MANY was added by commit b27abaccf8e8 ("mm/mempolicy: =
add
>>>>> MPOL_PREFERRED_MANY for multiple preferred nodes") to allow better
>>>>> allocation control when we have memory tiers in the system. With
>>>>> MPOL_PREFERRED_MANY, the user can use a policy node mask consisting o=
nly
>>>>> of faster memory nodes. When we fail to allocate pages from the faster
>>>>> memory node, kswapd would be woken up, allowing demotion of cold pages
>>>>> to slower memory nodes.
>>>>>
>>>>> With the current kernel, such usage of memory policies implies we can=
't
>>>>> do page promotion from a slower memory tier to a faster memory tier
>>>>> using numa fault. This patch fixes this issue.
>>>>>
>>>>> For MPOL_PREFERRED_MANY, if the executing node is in the policy node
>>>>> mask, we allow numa migration to the executing nodes. If the executing
>>>>> node is not in the policy node mask but the folio is already allocated
>>>>> based on policy preference (the folio node is in the policy node mask=
),
>>>>> we don't allow numa migration. If both the executing node and folio n=
ode
>>>>> are outside the policy node mask, we allow numa migration to the
>>>>> executing nodes.
>>>> The feature makes sense to me. How has this been tested? Do you have a=
ny
>>>> numbers to present?
>>>
>>> Hi Michal
>>>
>>> I have a test program which allocate memory on a specified node and
>>> trigger the promotion or migration (Keep accessing the pages).
>>>
>>> Without this patch if we set MPOL_PREFERRED_MANY promotion or migration=
 was not happening
>>> with this patch I could see pages are getting  migrated or promoted.
>>>
>>> My system has 2 CPU+DRAM node (Tier 1) and 1 PMEM node(Tier 2). Below
>>> are my test results.
>>>
>>> In below table N0 and N1 are Tier1 Nodes. N6 is the Tier2 Node.
>>> Exec_Node is the execution node, Policy is the nodes in nodemask and
>>> "Curr Location Pages" is the node where pages present before migration
>>> or promotion start.
>>>
>>> Tests Results
>>> ------------------
>>> Scenario 1:=C2=A0 if the executing node is in the policy node mask
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>> Exec_Node=C2=A0=C2=A0=C2=A0 Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Curr Location Pages       Observations
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N0 N1 N6=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N1=
                Pages Migrated from N1 to N0
>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N0 N1 N6=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N6        =
        Pages Promoted from N6 to N0
>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N0 N1=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0  =
N1 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0    Pages M=
igrated from N1 to N0
>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N0 N1=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =
=C2=A0N6 =C2=A0 =C2=A0            Pages Promoted from N6 to N0
>>>
>>> Scenario 2: If the folio node is in policy node mask and Exec node not =
in policy=C2=A0 node mask
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>> Exec_Node=C2=A0=C2=A0=C2=A0 Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Curr Location Pages=C2=A0=C2=A0=C2=A0  =C2=A0 Observations
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0  =C2=A0=C2=A0=C2=A0 N1 N6=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N1            =
   Pages are not Migrating to N0
>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N1 N6=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N6   =
            Pages are not migration to N0
>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0N1=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0N1 =C2=A0 =C2=A0           Pages are not Migrating to N0
>>>
>>> Scenario 3: both the folio node and executing node are outside the poli=
cy nodemask
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>> Exec_Node=C2=A0 =C2=A0 Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Curr Location Pages=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Observations
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 N1=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N6 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 Pages P=
romoted from N6 to N0
>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0N6                     N1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Pages Migrated from N1 to N0
>>>
>>=20
>> Please use some benchmarks (e.g., redis + memtier) and show the
>> proc-vmstat stats and benchamrk score.
>
>
> Without this change numa fault migration is not supported with MPOL_PREFE=
RRED_MANY
> policy. So there is no performance comparison with and without patch. W.r=
t effectiveness of numa
> fault migration, that is a different topic from this patch

IIUC, the goal of the patch is to optimize performance, right?  If so,
the benchmark score will help justify the change.

--
Best Regards,
Huang, Ying

