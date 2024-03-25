Return-Path: <linux-kernel+bounces-116443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC4E889E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02471C33EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1441B132816;
	Mon, 25 Mar 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmWakkdl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB27834DF14
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335059; cv=none; b=eicKOxKY9s+uFAfx2Rsumh+CnmjuvdxqOIuNk+IblXbtIX9yN+OCNMt/Oh9qbdDZFp+UxqzAfq/vISL9WPqOJOBFCtFMuAlKcD5/EY1XDXAz/RAVO9xB7IYuC2FHKp6XUggk+n8VT4R7QE8oaOnOOPL8hb+1KLzNZE8QGFx4qBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335059; c=relaxed/simple;
	bh=KtDX9c5FQBgaoOD7h5ZI/Q8jd/0Y1KkqpSUWOSPHmPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=itl8GmflKlELyxqvkg6mwQ9/5ZMRwzi/mOJ/mYYVR2QKFMl+CBP81PEWR4ZxK+dShXZTb0azKpQSsqOMLJn3cM3P1JSyhp4F1uUQULbG0aCUM1eMvR96X7wT4SAQBBLz49KBQiMAjnm+ZJiVQapfK5EWlKm9m7fdIBS0u9Kz+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmWakkdl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711335058; x=1742871058;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=KtDX9c5FQBgaoOD7h5ZI/Q8jd/0Y1KkqpSUWOSPHmPU=;
  b=ZmWakkdlJGZkaNC62NgFRkPLbUIHTAkOgP0llQfvKjanfGD4ZC2tMnyg
   gFHTg/na2Qz7MGWtWFyfZAPZ9617HHyQ8Xu7nnImEDKXCIjsKsB/JH3wK
   hgcEBXpyZPctmGq9s1G6YZCt/PGRorrRXwxPUa+WDSJl75K/7eLDuvLKg
   AUCgI4mnMy5tVGdEjvdb2If3EsNZsubHnO6nDeadEVYqdCJxSPaLdDkbf
   GF8ZsTXaSlWcRq2ehrrTZSkL4MyGWFh9+iepNsFcpDEis/GwpVY3HExWD
   9UE+MFSeLnQBn4q+l0pPsoCcOQCf+Ebc64Z7aMrwnamWih6o7RC8C4lpq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="10113200"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="10113200"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15358991"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:50:52 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Aneesh Kumar <aneesh.kumar@kernel.org>,
  Michal Hocko <mhocko@kernel.org>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  Mel Gorman <mgorman@suse.de>,  Feng Tang
 <feng.tang@intel.com>,  Andrea Arcangeli <aarcange@redhat.com>,  Peter
 Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Rik van
 Riel <riel@surriel.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew
 Wilcox <willy@infradead.org>,  Vlastimil Babka <vbabka@suse.cz>,  Dan
 Williams <dan.j.williams@intel.com>,  Hugh Dickins <hughd@google.com>,
  Kefeng Wang <wangkefeng.wang@huawei.com>,  Suren Baghdasaryan
 <surenb@google.com>
Subject: Re: [PATCH v3 2/2] mm/numa_balancing:Allow migrate on protnone
 reference with MPOL_PREFERRED_MANY policy
In-Reply-To: <e65b4e89-e8a9-475d-abc7-c63db8af435e@linux.ibm.com> (Donet Tom's
	message of "Fri, 22 Mar 2024 15:35:58 +0530")
References: <cover.1711002865.git.donettom@linux.ibm.com>
	<b1599085e1d2f3e48dc71c7991283b8aaa0fe00c.1711002865.git.donettom@linux.ibm.com>
	<87h6gyr7jf.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<e65b4e89-e8a9-475d-abc7-c63db8af435e@linux.ibm.com>
Date: Mon, 25 Mar 2024 10:48:58 +0800
Message-ID: <875xxbqb51.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 3/22/24 14:02, Huang, Ying wrote:
>> Donet Tom <donettom@linux.ibm.com> writes:
>>
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
>>> node is not in the policy node mask, we do not allow numa migration.
>> Can we provide more information about this?  I suggest to use an
>> example, for instance, pages may be distributed among multiple sockets
>> unexpectedly.
>
> Thank you for your suggestion. However, this commit message explains all =
the scenarios.

Yes.  The commit message is correct and covers many cases.  What I
suggested is to describe why we do that?  An examples can not covers all
possibility, but it is easy to be understood.  For example, something as
below?

For example, on a 2-sockets system, there are N0, N1, N2 in socket 0, N3
in socket 1.  N0, N1, N3 have fast memory and CPU, while N2 has slow
memory and no CPU.  For a workload, we may use MPOL_PREFERRED_MANY with
nodemask with N0 and N1 set because the workload runs on CPUs of socket
0 at most times.  Then, even if the workload runs on CPUs of N3
occasionally, we will not try to migrate the workload pages from N2 to
N3 because users may want to avoid cross-socket access as much as
possible in the long term.

> For example, Consider a system with 3 numa nodes (N0,N1 and N6).
> N0 and N1 are tier1 DRAM nodes=C2=A0 and N6 is tier 2 PMEM node.
>
> Scenario 1: The process is executing on N1,
>             If the executing node is in the policy node mask,
>             Curr Loc Pages - The numa node where page present(folio node)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> Process=C2=A0=C2=A0=C2=A0   Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Curr Loc Pages=C2=A0=C2=A0=C2=A0            =C2=A0 Observat=
ions
> -------------------------------------------------------------------------=
----------
> N1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N0 N1 N6=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Pages Migrated from N0 to N1
> N1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N0 N1 N6=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 N6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Pages Migrated from N6 to N1
> N1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N0 N1=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0N1=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 Pages Migrated from N1 to N6

Pages are not Migrating ?

> N1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N0 N1=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0N6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Pages Migrated=
 from N6 to N1
> -------------------------------------------------------------------------=
-----------
> Scenario 2:=C2=A0 The process is executing on N1,
>              If the executing node is NOT in the policy node mask,
>              Curr Loc Pages - The numa node where page present(folio node)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Process=C2=A0=C2=A0=C2=A0    Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C=
urr Loc Pages=C2=A0=C2=A0=C2=A0    Observations
> -------------------------------------------------------------------------=
----------
> N1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N0 N=
6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N=
0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0Pages are not Migrating
> N1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N0 N=
6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N=
6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0Pages are not migration,
> N1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Pages are not Migrating
> -------------------------------------------------------------------------=
-----------
>
> Scenario 3: The process is executing on N1,
>             If the executing node and folio nodes are=C2=A0 NOT in the po=
licy node mask,
>             Curr Loc Pages - The numa node where page present (folio node)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Thread=C2=A0=C2=A0=C2=A0 Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Curr =
Loc Pages=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0    Observations
> -------------------------------------------------------------------------=
-----------
> N1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0N6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Pages are not Migrating
> N1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N6=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Pages are not Migrating
> -------------------------------------------------------------------------=
-----------
>
> We can conclude that even if the pages are distributed among multiple soc=
kets,
> if the executing node is in the policy node mask, we allow numa migration=
 to the
> executing nodes. If the executing node is not in the policy node mask,
> we do not allow numa migration.
>

[snip]

--
Best Regards,
Huang, Ying

