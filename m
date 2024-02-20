Return-Path: <linux-kernel+bounces-72427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 636A085B31A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF291F2280F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B435B5AC;
	Tue, 20 Feb 2024 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuDLj1A4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348845B213
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411498; cv=none; b=gtmFXSRMADGM93gx/g5+883vgaq/fQ+J22Mjk1IK+2yX5Z5i4ANJEBpuXRVgUjrlnSAzLCRZOvnuZsm0ma7PlgcqPZL6ZGLRubuhczsTFOk7dGodDl8tDvcnwERpc+3ZPOM9XvNYexltxlKNG8bW68o1CanONP3Hz8XXSl7bhyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411498; c=relaxed/simple;
	bh=HZHt+3VTF3kLSve2B2NZhic8Pv8cjrm5oG+CZTHgH54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9dT7wX85H3MYOjh+JaAk55+Sr5T9Zx6Ag6ipNxZ7zNs7x3HColAuIGUBLERi8Jpdfx9IsWCMnqylP3m4ajpgn5b9ylPI5ZBMD1ZNNDLmfh79wCyop6L+s9TI8UMoK896d3ksYTRuFnRbWccJaMpnTsaCWlZMhyBLjLCR/9BX+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuDLj1A4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD22C43399;
	Tue, 20 Feb 2024 06:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708411497;
	bh=HZHt+3VTF3kLSve2B2NZhic8Pv8cjrm5oG+CZTHgH54=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BuDLj1A4KudlWPsKqYiWUUm1WA9DRy3e1SYdQF7mnJxP5bDR2NtmBcHltxmE5pg4l
	 1UMBhG0HZT4o+pXZDz9tCkYHlMJfzkmL9/BvI16O6qM2wmzDGRDucYuSKsDbD2ZLON
	 YH0mU5FFevRjJvK7So0KVq5qquwH1P/YBZc3ZIfWsmG3wzdmu5kWq7aIBUC5rVO5gO
	 aWFtfqg6mXGgd/a9aNKabacqKOUJDSDbc+67DFMVeEpmQ8qOhOMruWg5p7srqhA231
	 KnAFWXbMZKOs+Kkwlsr6tUmlWuyXFCnM9wWbcOXdvjq3hkszbzajkRv//Sd6VGIOgc
	 4oKSMnM+J+vWg==
Message-ID: <e88eedb7-cad6-4298-8710-4abc98048529@kernel.org>
Date: Tue, 20 Feb 2024 12:14:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm/numa_balancing:Allow migrate on protnone reference
 with MPOL_PREFERRED_MANY policy
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>, Donet Tom <donettom@linux.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>, Ben Widawsky <ben.widawsky@intel.com>,
 Feng Tang <feng.tang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Matthew Wilcox <willy@infradead.org>, Mike Kravetz
 <mike.kravetz@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 Dan Williams <dan.j.williams@intel.com>, Hugh Dickins <hughd@google.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
 <8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
 <ZdNEg_aA0LHJY22T@tiehlicka>
 <e7b138a4-de46-4cb6-94b8-67019e0369e9@linux.ibm.com>
 <87bk8bprpr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
In-Reply-To: <87bk8bprpr.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/20/24 12:06 PM, Huang, Ying wrote:
> Donet Tom <donettom@linux.ibm.com> writes:
> 
>> On 2/19/24 17:37, Michal Hocko wrote:
>>> On Sat 17-02-24 01:31:35, Donet Tom wrote:
>>>> commit bda420b98505 ("numa balancing: migrate on fault among multiple bound
>>>> nodes") added support for migrate on protnone reference with MPOL_BIND
>>>> memory policy. This allowed numa fault migration when the executing node
>>>> is part of the policy mask for MPOL_BIND. This patch extends migration
>>>> support to MPOL_PREFERRED_MANY policy.
>>>>
>>>> Currently, we cannot specify MPOL_PREFERRED_MANY with the mempolicy flag
>>>> MPOL_F_NUMA_BALANCING. This causes issues when we want to use
>>>> NUMA_BALANCING_MEMORY_TIERING. To effectively use the slow memory tier,
>>>> the kernel should not allocate pages from the slower memory tier via
>>>> allocation control zonelist fallback. Instead, we should move cold pages
>>>> from the faster memory node via memory demotion. For a page allocation,
>>>> kswapd is only woken up after we try to allocate pages from all nodes in
>>>> the allocation zone list. This implies that, without using memory
>>>> policies, we will end up allocating hot pages in the slower memory tier.
>>>>
>>>> MPOL_PREFERRED_MANY was added by commit b27abaccf8e8 ("mm/mempolicy: add
>>>> MPOL_PREFERRED_MANY for multiple preferred nodes") to allow better
>>>> allocation control when we have memory tiers in the system. With
>>>> MPOL_PREFERRED_MANY, the user can use a policy node mask consisting only
>>>> of faster memory nodes. When we fail to allocate pages from the faster
>>>> memory node, kswapd would be woken up, allowing demotion of cold pages
>>>> to slower memory nodes.
>>>>
>>>> With the current kernel, such usage of memory policies implies we can't
>>>> do page promotion from a slower memory tier to a faster memory tier
>>>> using numa fault. This patch fixes this issue.
>>>>
>>>> For MPOL_PREFERRED_MANY, if the executing node is in the policy node
>>>> mask, we allow numa migration to the executing nodes. If the executing
>>>> node is not in the policy node mask but the folio is already allocated
>>>> based on policy preference (the folio node is in the policy node mask),
>>>> we don't allow numa migration. If both the executing node and folio node
>>>> are outside the policy node mask, we allow numa migration to the
>>>> executing nodes.
>>> The feature makes sense to me. How has this been tested? Do you have any
>>> numbers to present?
>>
>> Hi Michal
>>
>> I have a test program which allocate memory on a specified node and
>> trigger the promotion or migration (Keep accessing the pages).
>>
>> Without this patch if we set MPOL_PREFERRED_MANY promotion or migration was not happening
>> with this patch I could see pages are getting  migrated or promoted.
>>
>> My system has 2 CPU+DRAM node (Tier 1) and 1 PMEM node(Tier 2). Below
>> are my test results.
>>
>> In below table N0 and N1 are Tier1 Nodes. N6 is the Tier2 Node.
>> Exec_Node is the execution node, Policy is the nodes in nodemask and
>> "Curr Location Pages" is the node where pages present before migration
>> or promotion start.
>>
>> Tests Results
>> ------------------
>> Scenario 1:  if the executing node is in the policy node mask
>> ================================================================================
>> Exec_Node    Policy           Curr Location Pages       Observations
>> ================================================================================
>> N0           N0 N1 N6             N1                Pages Migrated from N1 to N0
>> N0           N0 N1 N6             N6                Pages Promoted from N6 to N0
>> N0           N0 N1                N1                Pages Migrated from N1 to N0
>> N0           N0 N1                N6                Pages Promoted from N6 to N0
>>
>> Scenario 2: If the folio node is in policy node mask and Exec node not in policy  node mask
>> ================================================================================
>> Exec_Node    Policy       Curr Location Pages       Observations
>> ================================================================================
>> N0           N1 N6             N1               Pages are not Migrating to N0
>> N0           N1 N6             N6               Pages are not migration to N0
>> N0           N1                N1               Pages are not Migrating to N0
>>
>> Scenario 3: both the folio node and executing node are outside the policy nodemask
>> ==============================================================================
>> Exec_Node    Policy         Curr Location Pages       Observations
>> ==============================================================================
>> N0            N1                     N6          Pages Promoted from N6 to N0
>> N0            N6                     N1          Pages Migrated from N1 to N0
>>
> 
> Please use some benchmarks (e.g., redis + memtier) and show the
> proc-vmstat stats and benchamrk score.


Without this change numa fault migration is not supported with MPOL_PREFERRED_MANY
policy. So there is no performance comparison with and without patch. W.r.t effectiveness of numa
fault migration, that is a different topic from this patch


-aneesh

