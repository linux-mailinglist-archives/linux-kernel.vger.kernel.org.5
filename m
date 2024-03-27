Return-Path: <linux-kernel+bounces-120398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AD188D6D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D248E29EC97
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D1622089;
	Wed, 27 Mar 2024 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OM7GjAr1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1861C11
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522183; cv=none; b=dGbsjlQP8wukBwiz3d613bXeWWBfy+xi7pi9mTnE/6CE4ccPCooytQeCbPinGlVHxucHduv5IwcdQYX+a1sJCACeJ/wi8t4TbQ9vqzFfGPueI4uBjr0aD1g7yB7pU/gDBv6t1ndCLEhP16aDQ3FfhVEgm4L9EjCAegIMg6aUW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522183; c=relaxed/simple;
	bh=NpBdR2o53eZcSNfBWFivW7bvko295qnK4Dgh0nt/fNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=byCn5aOTa2QLDgsSNeFX02R4Ghd93+JMluIfyvLkkRDuLSt4hSXAl4bE/EguyW9bawmCqFnWlhYctQ45GBE7xTK5nylSyRTdreSJtDyxFnZFLir0ivp+7Jg7lFa+jwaDgGFUI9zRR1NVKf5vIcWvl5sD5sNOOQXfvjTrWDrpwWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OM7GjAr1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711522182; x=1743058182;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=NpBdR2o53eZcSNfBWFivW7bvko295qnK4Dgh0nt/fNc=;
  b=OM7GjAr1ocZSg2KQ0tR41dYV+C1SyI07QkFxdp6J1y7ayStrByoajC6B
   sdoP7eDVKECq9dYlJJGPecDu+Fng3gbNViLmtZRzd7T2DfmgguCsh4jOo
   ATsRrg2y98YMYmhj51ixA9iqhHtJoG0WipjZuiyYt4PmtEydqFpgxTN9u
   O+VlVSSqPPr7/MhKWyP/ukdhtJ5BoMFmuLEA0HSS8+Ufltxu4c9FVtJh3
   qMfYBbYhvZmqvhJNgiPf+QhI0meHJmeyIZYVKaNixCXsPVylRy2UxlLLn
   H3cYznEAeNWsig3EzGi6mY0YggzGIHEJ+qtRVejr28V4NiMl6bddU8+ix
   w==;
X-CSE-ConnectionGUID: xIxvcPRxR4aI5QIdJL2YKQ==
X-CSE-MsgGUID: Aunz6d88RQKq4oQalBslKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6462094"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6462094"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 23:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16185085"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 23:49:37 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Chris Li <chrisl@kernel.org>,  Minchan Kim
 <minchan@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Yu Zhao <yuzhao@google.com>,  SeongJae Park
 <sj@kernel.org>,  David Hildenbrand <david@redhat.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew
 Wilcox <willy@infradead.org>,  Nhat Pham <nphamcs@gmail.com>,  Chengming
 Zhou <zhouchengming@bytedance.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 10/10] mm/swap: optimize synchronous swapin
In-Reply-To: <CAMgjq7A-TxWkNKz0wwjaf0C-KZgps-VdPG+QcpY9tMmBY04TNA@mail.gmail.com>
	(Kairui Song's message of "Wed, 27 Mar 2024 14:37:27 +0800")
References: <20240326185032.72159-1-ryncsn@gmail.com>
	<20240326185032.72159-11-ryncsn@gmail.com>
	<87zfukmbwz.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7A-TxWkNKz0wwjaf0C-KZgps-VdPG+QcpY9tMmBY04TNA@mail.gmail.com>
Date: Wed, 27 Mar 2024 14:47:43 +0800
Message-ID: <87r0fwmar4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> writes:

> On Wed, Mar 27, 2024 at 2:24=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Kairui Song <ryncsn@gmail.com> writes:
>>
>> > From: Kairui Song <kasong@tencent.com>
>> >
>> > Interestingly the major performance overhead of synchronous is actually
>> > from the workingset nodes update, that's because synchronous swap in
>>
>> If it's the major overhead, why not make it the first optimization?
>
> This performance issue became much more obvious after doing other
> optimizations, and other optimizations are for general swapin not only
> for synchronous swapin, that's also how I optimized things step by
> step, so I kept my patch order...
>
> And it is easier to do this after Patch 8/10 which introduces the new
> interface for swap cache.
>
>>
>> > keeps adding single folios into a xa_node, making the node no longer
>> > a shadow node and have to be removed from shadow_nodes, then remove
>> > the folio very shortly and making the node a shadow node again,
>> > so it has to add back to the shadow_nodes.
>>
>> The folio is removed only if should_try_to_free_swap() returns true?
>>
>> > Mark synchronous swapin folio with a special bit in swap entry embedded
>> > in folio->swap, as we still have some usable bits there. Skip workings=
et
>> > node update on insertion of such folio because it will be removed very
>> > quickly, and will trigger the update ensuring the workingset info is
>> > eventual consensus.
>>
>> Is this safe?  Is it possible for the shadow node to be reclaimed after
>> the folio are added into node and before being removed?
>
> If a xa node contains any non-shadow entry, it can't be reclaimed,
> shadow_lru_isolate will check and skip such nodes in case of race.

In shadow_lru_isolate(),

	/*
	 * The nodes should only contain one or more shadow entries,
	 * no pages, so we expect to be able to remove them all and
	 * delete and free the empty node afterwards.
	 */
	if (WARN_ON_ONCE(!node->nr_values))
		goto out_invalid;
	if (WARN_ON_ONCE(node->count !=3D node->nr_values))
		goto out_invalid;

So, this isn't considered normal and will cause warning now.

>>
>> If so, we may consider some other methods.  Make shadow_nodes per-cpu?
>
> That's also an alternative solution if there are other risks.

This appears a general optimization and more clean.

--
Best Regards,
Huang, Ying

