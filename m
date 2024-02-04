Return-Path: <linux-kernel+bounces-51365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6581B848A30
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF059280EF5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A17B1115;
	Sun,  4 Feb 2024 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fX5K+xx8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64CEDC
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707010209; cv=none; b=WhwWraZ8rwResbpi2wI6c7+axhjYtgIjjt9xN+p0gKyIXh6QMywGL3d5Yb5mObTKyvr5Slnh4CdiEWNWqbnPUlVXNVejJZWjaUX7BjjmLqX8N7mSzgUVSKrwg8EFd5KvpAErXflnXpeziJ54kZwb77Zvn0LyHnso4vwNSjvIhaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707010209; c=relaxed/simple;
	bh=3JVEZJWbJzYZmG+Q8G50nJcI6E/VXWktEo2IRFBK2Go=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AROsy1XmmdgP5OIOtPTGvWfwU1FigZvDwKaLc033opv2vY2wdkPcb6JjBnH/x1qiBCjUVfisUFCFYEQtUeRwkKzWErHPcy4pV2ugiTTvySPInQFshvwBl4PmJkG65BZXdRknrxUvZi+Jx3+7M8Ju4Zb7j9zK1aXhfmuoWF48DcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fX5K+xx8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707010207; x=1738546207;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3JVEZJWbJzYZmG+Q8G50nJcI6E/VXWktEo2IRFBK2Go=;
  b=fX5K+xx80OW2SiNBdb9yDB9kfuTVb6jXhnfC8oAfyCYPIEplAudvRoxT
   eKopFZC47mhTtOb998G4z4gChcnfqjLIGWIDkXDkQjo1qtz4qJlvI/kSM
   unYcq+eCgrh3tfOWAv0DWRxzW9Cg71x7L+YD2liFU2LB7+3NRzXl6YJg4
   PC9R+/rGAqn7oEG/FsSgdYAcS6ZtG+gNyq44sX2sS6pG2gXjQwqw1l2oH
   hoyAtSY5Hu/L+8Ep7EG2jfrjuFRu9jakzX7EbpbQdm5rrjQwc++p9bjJd
   zuo+HMAM4pWzavPj0hdLj9OSb9q+8MP0So3w3P4ElgqF9nTfM7kFQH8TN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="513781"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="513781"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 17:30:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="908950588"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="908950588"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 17:30:02 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>,  linux-kernel@vger.kernel.org,
  Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,  Ingo Molnar
 <mingo@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,  Juri Lelli
 <juri.lelli@redhat.com>,  Vincent Guittot <vincent.guittot@linaro.org>,
  Dietmar Eggemann <dietmar.eggemann@arm.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Ben Segall <bsegall@google.com>,  Mel Gorman
 <mgorman@suse.de>,  Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2 1/3] sched/topology: Annotate RCU pointers properly
In-Reply-To: <xhsmhsf2ahiqg.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	(Valentin Schneider's message of "Fri, 02 Feb 2024 18:35:35 +0100")
References: <20240115143427.1820628-1-pierre.gondois@arm.com>
	<20240115143427.1820628-2-pierre.gondois@arm.com>
	<8734uy137o.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<xhsmhsf2ahiqg.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Sun, 04 Feb 2024 09:28:06 +0800
Message-ID: <87il359fx5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Valentin Schneider <vschneid@redhat.com> writes:

> On 16/01/24 09:23, Huang, Ying wrote:
>> Pierre Gondois <pierre.gondois@arm.com> writes:
>>
>>> Cleanup RCU-related spare errors by annotating RCU pointers.
>>>
>>> sched_domains_numa_distance:
>>>   error: incompatible types in comparison expression
>>>   (different address spaces):
>>>       int [noderef] __rcu *
>>>       int *
>>>
>>> sched_domains_numa_masks:
>>>   error: incompatible types in comparison expression
>>>   (different address spaces):
>>>       struct cpumask **[noderef] __rcu *
>>>       struct cpumask ***
>>>
>>> The cast to (void *) adds the following sparse warning:
>>>   warning: cast removes address space '__rcu' of expression
>>> but this should be normal.
>>>
>>> Fixes: 0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")
>>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>>> ---
>>>  kernel/sched/topology.c | 12 ++++++------
>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>> index 10d1391e7416..2a2da9b33e31 100644
>>> --- a/kernel/sched/topology.c
>>> +++ b/kernel/sched/topology.c
>>> @@ -1542,8 +1542,8 @@ static int			sched_domains_numa_levels;
>>>  static int			sched_domains_curr_level;
>>>
>>>  int				sched_max_numa_distance;
>>> -static int			*sched_domains_numa_distance;
>>> -static struct cpumask		***sched_domains_numa_masks;
>>> +static int			__rcu *sched_domains_numa_distance;
>>> +static struct cpumask		** __rcu *sched_domains_numa_masks;
>>>  #endif
>>>
>>>  /*
>>> @@ -1988,8 +1988,8 @@ void sched_init_numa(int offline_node)
>>>
>>>  static void sched_reset_numa(void)
>>>  {
>>> -	int nr_levels, *distances;
>>> -	struct cpumask ***masks;
>>> +	int nr_levels, __rcu *distances;
>>> +	struct cpumask ** __rcu *masks;
>>
>> No.  distances and masks are not accessed via RCU in the function.
>> Instead, they should be assigned like below,
>>
>>          distances = rcu_dereference_raw(sched_domains_numa_distance);
>>
>> Because sched_domains_numa_distance is protected by cpu_hotplug_lock,
>> but the lock is static.  Some comments are deserved.
>>
>> Anyway, please read RCU document before making the change.
>>
>
> IIUC, something like so could also do?
>
>   distances = rcu_dereference_check(sched_domains_numa_distance, lockdep_is_cpus_held());

Yes.  You are right.  We should do that.

--
Best Regards,
Huang, Ying

