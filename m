Return-Path: <linux-kernel+bounces-89660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68A986F3CA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 07:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AABFB229B0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 06:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8EA8BE7;
	Sun,  3 Mar 2024 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ9cnsRb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D156FD5
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709446580; cv=none; b=p/Z8K1Oyzt/HBA9P/bO091duKypQGBsAtUR+a8CztrKlYfJRiW1oCh7GMg6AysH66oBgJTVGVYM+vP4EX6qJJDgaG4IEq8MTfiboji9q/MMotB95jmDUXyF0hDcvkwlDraYBkg8S5I67JiLdclRDMP4xXzIwEqdrTGy//XGn7yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709446580; c=relaxed/simple;
	bh=MDmzk7Y7KLtXakpc0plr7MLSv8GCZZhHgELtbBb0gkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CS25WocL1L+nORh0u7t0fstSztd30uDxbnUuAwj13P54rRRGetrhVayVUriparAnHm37xvEXZwlx6jv3Slo/7l/y5oH2R0nDeT62cwlQYnCDPjjyGMfoimAZP5fhKCzu6EcPw4dpkRw4xrE67epcWD7NE8FBcfEI+X60jVt0rQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ9cnsRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F7CC433C7;
	Sun,  3 Mar 2024 06:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709446580;
	bh=MDmzk7Y7KLtXakpc0plr7MLSv8GCZZhHgELtbBb0gkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UJ9cnsRb+a3U174a3rkoQfxHjDrXCoBZhX0+pkdVH0UHSThiVUBw4jPa1RwdDTsmz
	 S5hgzAK3iT9jFwvlZV3A9//21O/Ds8VVrewEMWxgJk98TJ9oCNjypmTUxlab+YpqK1
	 lMCnr1NIrmHXXx+UJcVWPVlwS48Qok73quDT1MVCin36PadrCGLPg7WZsbn8Nl7oKP
	 /uKWHUJjHWCqOji9hhC1kqmRfM/l1dkwod2J27GiIM97xYRpvz9a8ocKYishmm9D8u
	 682Nvj/5mxSeufo1MPlv4GztaH/PyhS6ENtzCZhSvMWnfzcBpIjmTV4Z8+mzTDxsw2
	 gdYmmZxXmVL+A==
X-Mailer: emacs 29.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Donet Tom <donettom@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mel Gorman <mgorman@suse.de>,
	Ben Widawsky <ben.widawsky@intel.com>,
	Feng Tang <feng.tang@intel.com>, Michal Hocko <mhocko@kernel.org>,
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
In-Reply-To: <87ttm3o9db.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
 <8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
 <877cizppsa.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87sf1nzi3s.fsf@kernel.org>
 <87ttm3o9db.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date: Sun, 03 Mar 2024 11:46:09 +0530
Message-ID: <878r2zlu1i.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Huang, Ying" <ying.huang@intel.com> writes:

> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
>
>> "Huang, Ying" <ying.huang@intel.com> writes:
>>
>>> Donet Tom <donettom@linux.ibm.com> writes:
>>>
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
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
>>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>>> ---
>>>>  mm/mempolicy.c | 28 ++++++++++++++++++++++++++--
>>>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>>>> index 73d698e21dae..8c4c92b10371 100644
>>>> --- a/mm/mempolicy.c
>>>> +++ b/mm/mempolicy.c
>>>> @@ -1458,9 +1458,10 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
>>>>  	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
>>>>  		return -EINVAL;
>>>>  	if (*flags & MPOL_F_NUMA_BALANCING) {
>>>> -		if (*mode != MPOL_BIND)
>>>> +		if (*mode == MPOL_BIND || *mode == MPOL_PREFERRED_MANY)
>>>> +			*flags |= (MPOL_F_MOF | MPOL_F_MORON);
>>>> +		else
>>>>  			return -EINVAL;
>>>> -		*flags |= (MPOL_F_MOF | MPOL_F_MORON);
>>>>  	}
>>>>  	return 0;
>>>>  }
>>>> @@ -2463,6 +2464,23 @@ static void sp_free(struct sp_node *n)
>>>>  	kmem_cache_free(sn_cache, n);
>>>>  }
>>>>  
>>>> +static inline bool mpol_preferred_should_numa_migrate(int exec_node, int folio_node,
>>>> +					    struct mempolicy *pol)
>>>> +{
>>>> +	/* if the executing node is in the policy node mask, migrate */
>>>> +	if (node_isset(exec_node, pol->nodes))
>>>> +		return true;
>>>> +
>>>> +	/* If the folio node is in policy node mask, don't migrate */
>>>> +	if (node_isset(folio_node, pol->nodes))
>>>> +		return false;
>>>> +	/*
>>>> +	 * both the folio node and executing node are outside the policy nodemask,
>>>> +	 * migrate as normal numa fault migration.
>>>> +	 */
>>>> +	return true;
>>>
>>> Why?  This may cause some unexpected result.  For example, pages may be
>>> distributed among multiple sockets unexpectedly.  So, I prefer the more
>>> conservative policy, that is, only migrate if this node is in
>>> pol->nodes.
>>>
>>
>> This will only have an impact if the user specifies
>> MPOL_F_NUMA_BALANCING. This means that the user is explicitly requesting
>> for frequently accessed memory pages to be migrated. Memory policy
>> MPOL_PREFERRED_MANY is able to allocate pages from nodes outside of
>> policy->nodes. For the specific use case that I am interested in, it
>> should be okay to restrict it to policy->nodes. However, I am wondering
>> if this is too restrictive given the definition of MPOL_PREFERRED_MANY.
>
> IMHO, we can start with some consecutive way and expand it if it's
> proved necessary.
>

Is this good?

1 file changed, 14 insertions(+), 34 deletions(-)
mm/mempolicy.c | 48 ++++++++++++++----------------------------------

modified   mm/mempolicy.c
@@ -2464,23 +2464,6 @@ static void sp_free(struct sp_node *n)
 	kmem_cache_free(sn_cache, n);
 }
 
-static inline bool mpol_preferred_should_numa_migrate(int exec_node, int folio_node,
-					    struct mempolicy *pol)
-{
-	/* if the executing node is in the policy node mask, migrate */
-	if (node_isset(exec_node, pol->nodes))
-		return true;
-
-	/* If the folio node is in policy node mask, don't migrate */
-	if (node_isset(folio_node, pol->nodes))
-		return false;
-	/*
-	 * both the folio node and executing node are outside the policy nodemask,
-	 * migrate as normal numa fault migration.
-	 */
-	return true;
-}
-
 /**
  * mpol_misplaced - check whether current folio node is valid in policy
  *
@@ -2533,29 +2516,26 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
 		break;
 
 	case MPOL_BIND:
-		/* Optimize placement among multiple nodes via NUMA balancing */
+	case MPOL_PREFERRED_MANY:
+		/*
+		 * Even though MPOL_PREFERRED_MANY can allocate pages outside
+		 * policy nodemask we don't allow numa migration to nodes
+		 * outside policy nodemask for now. This is done so that if we
+		 * want demotion to slow memory to happen, before allocating
+		 * from some DRAM node say 'x', we will end up using a
+		 * MPOL_PREFERRED_MANY mask excluding node 'x'. In such scenario
+		 * we should not promote to node 'x' from slow memory node.
+		 */
 		if (pol->flags & MPOL_F_MORON) {
+			/*
+			 * Optimize placement among multiple nodes
+			 * via NUMA balancing
+			 */
 			if (node_isset(thisnid, pol->nodes))
 				break;
 			goto out;
 		}
 
-		if (node_isset(curnid, pol->nodes))
-			goto out;
-		z = first_zones_zonelist(
-				node_zonelist(thisnid, GFP_HIGHUSER),
-				gfp_zone(GFP_HIGHUSER),
-				&pol->nodes);
-		polnid = zone_to_nid(z->zone);
-		break;
-
-	case MPOL_PREFERRED_MANY:
-		if (pol->flags & MPOL_F_MORON) {
-			if (!mpol_preferred_should_numa_migrate(thisnid, curnid, pol))
-				goto out;
-			break;
-		}
-
 		/*
 		 * use current page if in policy nodemask,
 		 * else select nearest allowed node, if any.

[back]
.

