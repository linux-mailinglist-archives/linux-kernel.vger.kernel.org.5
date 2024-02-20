Return-Path: <linux-kernel+bounces-72299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D1A85B1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6C51C21324
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B344535C4;
	Tue, 20 Feb 2024 03:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX/MII87"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9DB482FC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401457; cv=none; b=bLmOoNRvf78H2ve8yWRtcYWbvH4vsQQYSC0naZFfePpt7Vbps7ePGFh+Sdm4fW6vPdgoyVuE+S955J6rDrC336FTiOeAxCL74nATNICdzvoeuwWiwnwJ41Vwv+Wplw2Lrs+oarvgmoxvj6ICKJxanNK5I5xgHVsX7ta1P20jl3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401457; c=relaxed/simple;
	bh=rZPnI4KMugcJSPwPz2HR6/oy8yjLOWhV4hBrxhikVuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFqgLXsZr2+Ron3ne3Z8ZIbAHFgOYNavBsrSGpGMn8odBKyejBdqsZZ8qjjfl5Pl1Jbuq7FBe5OjQhfcOvUrwbbzO5/vamAdLqkKDvb2bV0RaChuK8DP4qp8/KCXA0Z91UHxu90lgljtFED7pBNEgSzhCWQwGXTtLeAtgeCq+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AX/MII87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D584C433F1;
	Tue, 20 Feb 2024 03:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708401457;
	bh=rZPnI4KMugcJSPwPz2HR6/oy8yjLOWhV4hBrxhikVuk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AX/MII87GnTedQL8c8IPeysawr8qITVTJp8VBbL3Wuo0RUQ4DOOhTktQ5ViuGNBXw
	 tYPzTbuQD13aqGbWyDl0x5swwCNeyLcHv/weo+JNydbFaz7lJve504/22ncPNjF9Xo
	 YV0CpohiV1R005N1bjxSCApesHcImfn6aFBuBUcRVbObMaSshxtnLQG71OiDI4Yhz6
	 gqRwAqPUvmqY5Dqn5lXmVtCjPBwRe/MXwZeOu6YM/s2DjhUZu0NN35HtIZmnk0+zMd
	 rfamuRJ3RverZZc7iJWrcrXxKseZ57r0ZD9pZpTdGcQYH9sy9Z5CD5Tnnnu/tVh3NF
	 ZT0zl0GzeEc7A==
Message-ID: <0f0fd8e3-98b2-4001-ba6a-6a8a26a5393f@kernel.org>
Date: Tue, 20 Feb 2024 09:27:25 +0530
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
To: Michal Hocko <mhocko@suse.com>, Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Mel Gorman <mgorman@suse.de>,
 Ben Widawsky <ben.widawsky@intel.com>, Feng Tang <feng.tang@intel.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Matthew Wilcox <willy@infradead.org>, Mike Kravetz
 <mike.kravetz@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 Dan Williams <dan.j.williams@intel.com>, Hugh Dickins <hughd@google.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
 <8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
 <ZdNjmOlkMqEOGci1@tiehlicka>
 <25b420aa-3fe6-40a4-8d60-a46ab61ee7b7@linux.ibm.com>
 <ZdOoF_pMAa-FGN4m@tiehlicka>
From: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
In-Reply-To: <ZdOoF_pMAa-FGN4m@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/24 12:42 AM, Michal Hocko wrote:
> On Mon 19-02-24 20:37:17, Donet Tom wrote:
>>
>> On 2/19/24 19:50, Michal Hocko wrote:
>>> On Sat 17-02-24 01:31:35, Donet Tom wrote:
>>> [...]
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
>>>> +}
>>> I have looked at this again and only now noticed that this doesn't
>>> really work as one would expected.
>>>
>>>          case MPOL_PREFERRED_MANY:
>>>                  /*
>>>                   * use current page if in policy nodemask,
>>>                   * else select nearest allowed node, if any.
>>>                   * If no allowed nodes, use current [!misplaced].
>>>                   */
>>>                  if (node_isset(curnid, pol->nodes))
>>>                          goto out;
>>>                  z = first_zones_zonelist(
>>>                                  node_zonelist(numa_node_id(), GFP_HIGHUSER),
>>>                                  gfp_zone(GFP_HIGHUSER),
>>>                                  &pol->nodes);
>>>                  polnid = zone_to_nid(z->zone);
>>>                  break;
>>>
>>> Will collapse the whole MPOL_PREFERRED_MANY nodemask into the first
>>> notde into that mask. Is that really what we want here? Shouldn't we use
>>> the full nodemask as the migration target?
>>
>> With this patch it will take full nodemask and find out the correct migration target. It will not collapse into first node.
> 
> Correct me if I am wrong, but mpol_misplaced will return the first node
> of the preffered node mask and then migrate_misplaced_folio would use
> it as a target node for alloc_misplaced_dst_folio which performs
> __GFP_THISNODE allocation so it won't fall back to a different node.

I think the confusion is between MPOL_F_MOF (migrate on fault) vs MPOL_F_MORON( protnone fault/numa fault).

With MPOL_F_MOF alone what we wanted to achieve was to have have mbind() lazy migrate the pages based on policy node
mask. The change was introduced in commit commit b24f53a0bea3 ("mm: mempolicy: Add MPOL_MF_LAZY") and later dropped by
commit 2cafb582173f ("mempolicy: remove confusing MPOL_MF_LAZY dead code"). We still have mpol_misplaced changes
to handle the node selection for MPOL_F_MOF flag (this is dead code IIUC). 

MPOL_F_MORON was added in commit 5606e3877ad8 ("mm: numa: Migrate on reference policy") and with currently upstream only
MPOL_BIND support that flag. With that flag specified and with the changes in the patch mpol_misplaced becomes

	case MPOL_PREFERRED_MANY:
		if (pol->flags & MPOL_F_MORON) {
			if (!mpol_preferred_should_numa_migrate(thisnid, curnid, pol))
				goto out;
			break;
		}

		/*
		 * use current page if in policy nodemask,
		 * else select nearest allowed node, if any.
		 * If no allowed nodes, use current [!misplaced].
		 */
		if (node_isset(curnid, pol->nodes))
			goto out;
		z = first_zones_zonelist(
				node_zonelist(thisnid, GFP_HIGHUSER),
				gfp_zone(GFP_HIGHUSER),
				&pol->nodes);
		polnid = zone_to_nid(z->zone);
		break;
 ....
..
       }

	/* Migrate the folio towards the node whose CPU is referencing it */
	if (pol->flags & MPOL_F_MORON) {
		polnid = thisnid;

		if (!should_numa_migrate_memory(current, folio, curnid,
						thiscpu))
			goto out;
	}

	if (curnid != polnid)
		ret = polnid;
out:
	mpol_cond_put(pol);

	return ret;
}




ie, if we can do numa migration, we select the currently executing node as the target node otherwise
we end up returning from the function with ret = NUMA_NO_NODE.

-aneesh




