Return-Path: <linux-kernel+bounces-72491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D4685B42E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F4F281456
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36155BAD5;
	Tue, 20 Feb 2024 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7v4I3ZQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B153611D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708415223; cv=none; b=Vj6IAXth91caSJlLt3eIzP66UjBmjpDQZgWXmVxy3bjWMggQKNIa6EStdmRTotnH3kZQWlJCCjGVL+hUaCqMV06J79OBDfUGim2NLwh5sYMxGob9jRNxF7xhGWRk7lHttcirSPRz9xetKTXoHo4APZYsAkCrYlADjxMUntBO/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708415223; c=relaxed/simple;
	bh=KzR5o052uF6NHep5nn4rBL+2f1ZGfXoJznrTNszQois=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BEznLqFqSQXhx2TX7rbn+6O1BoG81uBfriSPNxYDzhFPJtitemSH6GnK/6a9UYJnZIVIZ8V0qUqJmh3cyTcqvMFKTcJmkeDfvBkinPyvReN/7k4oDp/+LXoqUgQQVzl59TDWzrONsPzjX2rfG+kRRRwuhTXVZ/u4hABdWku1txA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7v4I3ZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801A3C433C7;
	Tue, 20 Feb 2024 07:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708415222;
	bh=KzR5o052uF6NHep5nn4rBL+2f1ZGfXoJznrTNszQois=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h7v4I3ZQ0Bucprxy/pNFWWNkMCm3NrWeeU4B5v00eZvSK5T8fxXG9/a+3dYv3Rn8U
	 3KMdfH7Hg0yXGtGHZnvtjxbDBCBBAn1isSNiSWNjWKn6GVGPLLPuerEhwzWzQwxdEb
	 IDWD90iy/b9I/X1hibGvfnDSMO5NN0UeOMHBN5ZEtXplUK/0pPR9J/gZeLyiynDaQe
	 KC/vpe+DV0Qww6ctT6rPXGN3snWQXHI26M1gidyHSNB0aw9MtvkIgmxSEmNdAQXZB7
	 K3IPtwYXncsfCQHUmCAc2Z1smdkNYnWCiDkDAESOv5TyL+8tOh7wlGsUkHHum/uTKp
	 STD9gysutnGDA==
X-Mailer: emacs 29.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Donet Tom <donettom@linux.ibm.com>, Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mel Gorman <mgorman@suse.de>,
	Ben Widawsky <ben.widawsky@intel.com>,
	Feng Tang <feng.tang@intel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 3/3] mm/numa_balancing:Allow migrate on protnone
 reference with MPOL_PREFERRED_MANY policy
In-Reply-To: <87y1bfoayd.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
 <8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
 <ZdNEg_aA0LHJY22T@tiehlicka>
 <e7b138a4-de46-4cb6-94b8-67019e0369e9@linux.ibm.com>
 <87bk8bprpr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <e88eedb7-cad6-4298-8710-4abc98048529@kernel.org>
 <87y1bfoayd.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date: Tue, 20 Feb 2024 13:16:51 +0530
Message-ID: <87v86jzifo.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Huang, Ying" <ying.huang@intel.com> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> writes:
>
>> On 2/20/24 12:06 PM, Huang, Ying wrote:
>>> Donet Tom <donettom@linux.ibm.com> writes:
>>>=20
>>>> On 2/19/24 17:37, Michal Hocko wrote:
>>>>> On Sat 17-02-24 01:31:35, Donet Tom wrote:
>>>>>> commit bda420b98505 ("numa balancing: migrate on fault among multipl=
e bound
>>>>>> nodes") added support for migrate on protnone reference with MPOL_BI=
ND
>>>>>> memory policy. This allowed numa fault migration when the executing =
node
>>>>>> is part of the policy mask for MPOL_BIND. This patch extends migrati=
on
>>>>>> support to MPOL_PREFERRED_MANY policy.
>>>>>>
>>>>>> Currently, we cannot specify MPOL_PREFERRED_MANY with the mempolicy =
flag
>>>>>> MPOL_F_NUMA_BALANCING. This causes issues when we want to use
>>>>>> NUMA_BALANCING_MEMORY_TIERING. To effectively use the slow memory ti=
er,
>>>>>> the kernel should not allocate pages from the slower memory tier via
>>>>>> allocation control zonelist fallback. Instead, we should move cold p=
ages
>>>>>> from the faster memory node via memory demotion. For a page allocati=
on,
>>>>>> kswapd is only woken up after we try to allocate pages from all node=
s in
>>>>>> the allocation zone list. This implies that, without using memory
>>>>>> policies, we will end up allocating hot pages in the slower memory t=
ier.
>>>>>>
>>>>>> MPOL_PREFERRED_MANY was added by commit b27abaccf8e8 ("mm/mempolicy:=
 add
>>>>>> MPOL_PREFERRED_MANY for multiple preferred nodes") to allow better
>>>>>> allocation control when we have memory tiers in the system. With
>>>>>> MPOL_PREFERRED_MANY, the user can use a policy node mask consisting =
only
>>>>>> of faster memory nodes. When we fail to allocate pages from the fast=
er
>>>>>> memory node, kswapd would be woken up, allowing demotion of cold pag=
es
>>>>>> to slower memory nodes.
>>>>>>
>>>>>> With the current kernel, such usage of memory policies implies we ca=
n't
>>>>>> do page promotion from a slower memory tier to a faster memory tier
>>>>>> using numa fault. This patch fixes this issue.
>>>>>>
>>>>>> For MPOL_PREFERRED_MANY, if the executing node is in the policy node
>>>>>> mask, we allow numa migration to the executing nodes. If the executi=
ng
>>>>>> node is not in the policy node mask but the folio is already allocat=
ed
>>>>>> based on policy preference (the folio node is in the policy node mas=
k),
>>>>>> we don't allow numa migration. If both the executing node and folio =
node
>>>>>> are outside the policy node mask, we allow numa migration to the
>>>>>> executing nodes.
>>>>> The feature makes sense to me. How has this been tested? Do you have =
any
>>>>> numbers to present?
>>>>
>>>> Hi Michal
>>>>
>>>> I have a test program which allocate memory on a specified node and
>>>> trigger the promotion or migration (Keep accessing the pages).
>>>>
>>>> Without this patch if we set MPOL_PREFERRED_MANY promotion or migratio=
n was not happening
>>>> with this patch I could see pages are getting  migrated or promoted.
>>>>
>>>> My system has 2 CPU+DRAM node (Tier 1) and 1 PMEM node(Tier 2). Below
>>>> are my test results.
>>>>
>>>> In below table N0 and N1 are Tier1 Nodes. N6 is the Tier2 Node.
>>>> Exec_Node is the execution node, Policy is the nodes in nodemask and
>>>> "Curr Location Pages" is the node where pages present before migration
>>>> or promotion start.
>>>>
>>>> Tests Results
>>>> ------------------
>>>> Scenario 1:=C2=A0 if the executing node is in the policy node mask
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>> Exec_Node=C2=A0=C2=A0=C2=A0 Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Curr Location Pages       Observations
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N0 N1 N=
6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N=
1                Pages Migrated from N1 to N0
>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N0 N1 N6=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N6        =
        Pages Promoted from N6 to N0
>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N0 N1=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0  =
N1 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0    Pages M=
igrated from N1 to N0
>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 N0 N1=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =
=C2=A0N6 =C2=A0 =C2=A0            Pages Promoted from N6 to N0
>>>>
>>>> Scenario 2: If the folio node is in policy node mask and Exec node not=
 in policy=C2=A0 node mask
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>> Exec_Node=C2=A0=C2=A0=C2=A0 Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Curr Location Pages=C2=A0=C2=A0=C2=A0  =C2=A0 Observations
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0  =C2=A0=C2=A0=C2=A0 N1 N6=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N1            =
   Pages are not Migrating to N0
>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N1 N6=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N6=
               Pages are not migration to N0
>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0N1=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0N1 =C2=A0 =C2=A0           Pages are not Migrating to N0
>>>>
>>>> Scenario 3: both the folio node and executing node are outside the pol=
icy nodemask
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>>> Exec_Node=C2=A0 =C2=A0 Policy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Curr Location Pages=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Observati=
ons
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 N1=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N6 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 Page=
s Promoted from N6 to N0
>>>> N0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0N6                     N1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0Pages Migrated from N1 to N0
>>>>
>>>=20
>>> Please use some benchmarks (e.g., redis + memtier) and show the
>>> proc-vmstat stats and benchamrk score.
>>
>>
>> Without this change numa fault migration is not supported with MPOL_PREF=
ERRED_MANY
>> policy. So there is no performance comparison with and without patch. W.=
r.t effectiveness of numa
>> fault migration, that is a different topic from this patch
>
> IIUC, the goal of the patch is to optimize performance, right?  If so,
> the benchmark score will help justify the change.
>

The objective is to enable the use of the MPOL_PREFERRED_MANY policy,
which is essential for the correct functioning of memory demotion in
conjunction with memory promotion. Once we can use memory promotion, we
should be able to observe the same benefits as those provided by numa
fault memory promotion. The actual benefit of numa fault migration is
dependent on various factors such as the speed of the slower memory
device, the access pattern of the application, etc. We are discussing
its effectiveness and how to improve numa fault overhead in other
forums. However, we believe that this discussion should not hinder the
merging of this patch.

This change is similar to commit bda420b98505 ("numa balancing: migrate
on fault among multiple bound nodes")

-aneesh

