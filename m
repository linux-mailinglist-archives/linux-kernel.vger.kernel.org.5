Return-Path: <linux-kernel+bounces-77984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5BB860DB2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829C31C21893
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CF82942D;
	Fri, 23 Feb 2024 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+19aXd5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED981AAD2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679603; cv=none; b=AofswP7e3vnTnKRqUNKufU6T9j8hL4Ph2PcPYeyAIBya7B8Koau9753mNLE+KioylFFgnNQZSPPhn6IK5zNnDMr7Cd6M2YZKkJj0vQ0JAu3Q7V75A8jGaXnuxLclB/Rhni4lPUlVGvAzOwKwVIxI9YiMsJdYDsTa76VybrtVk+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679603; c=relaxed/simple;
	bh=kzyPxl6FFtEMwo9BLpblajQlnHk8PAW/3PJxzfSjh1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g20hVjEqS4NQsX4WGwtg/gfcqnYy+gcBoP4CmOqCKRJ+XEh6bgd1etn0cW4cDovQykjeriw/4BD7OcKDR3S7p6ixl3w/6l1b5TN3eG16JINYb1l4y5s63JpMCQd1xcLaNWnCZ39IqoI3Iy1EZYIiLvdp/f1IoIrkW/lYOKgB0Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+19aXd5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708679601; x=1740215601;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=kzyPxl6FFtEMwo9BLpblajQlnHk8PAW/3PJxzfSjh1k=;
  b=M+19aXd5+ClHAcLd0qpj6njXFRvUJaxRTjLlSfGutEKS37ogEkpBZl41
   vmpXwuifzpKkQH8r5sNTJgwDu0d29hDXDR5U+Gca8LS1l8Oh22R8gTghb
   MJbLUzTg51ynGcMdlJBtQ2PTIChwZW1nOyKL/5Tq7Tfq5qkvOnwabcQP9
   usEiFR76mqEQzYEJziVDhaMBZj7G5bdXlwTDoNgkt+7JnhmTWWc/JmNpt
   GTm/xACgSFBwJ3nb4H2Ss+4Q5h4qgbIDbmXusDtDAb09YcNsZPk/quaNL
   0lPi5uwTaSFYte7v89XsdJ2xng2EN6asIJ5ax5uKHD391W1mexEBxa4cu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13625343"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13625343"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 01:13:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5825428"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 01:13:18 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <hannes@cmpxchg.org>,
  <dan.j.williams@intel.com>,  <dave.jiang@intel.com>
Subject: Re: [RFC 1/1] mm/mempolicy: introduce system default interleave
 weights
In-Reply-To: <ZdgxaLSBznupVmJK@memverge.com> (Gregory Price's message of "Fri,
	23 Feb 2024 00:47:20 -0500")
References: <20240220202529.2365-1-gregory.price@memverge.com>
	<20240220202529.2365-2-gregory.price@memverge.com>
	<87wmqxht4c.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZdgxaLSBznupVmJK@memverge.com>
Date: Fri, 23 Feb 2024 17:11:23 +0800
Message-ID: <87sf1jh7es.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Thu, Feb 22, 2024 at 03:10:11PM +0800, Huang, Ying wrote:
>> Hi, Gregory,
>> 
>> Thanks a lot for working on this!
>> 
>
> It's worth doing :]
>
>> > +	new_bw = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
>> > +	if (!new_bw)
>> > +		return -ENOMEM;
>> 
>> We only use "node_bw_table" in this function with "default_iwt_lock"
>> held.  So, we don't need to copy-on-write?  Just change in place?
>> 
>
> I'd originally planned to add a sysfs entry for the data, which would
> have added RCU to this, but i realized it's just duplicating the
> node/accessX/initiator information, so i'll rip this out and just do in
> place changes.
>
>> > +	new_iw = kzalloc(nr_node_ids, GFP_KERNEL);
>> > +	if (!new_iw) {
>> > +		kfree(new_bw);
>> > +		return -ENOMEM;
>> > +	}
>> > +
>> > +	mutex_lock(&default_iwt_lock);
>> > +	old_bw = node_bw_table;
>> > +	old_iw = rcu_dereference_protected(default_iw_table,
>> > +					   lockdep_is_held(&default_iwt_lock));
>> > +
>> > +	if (old_bw)
>> > +		memcpy(new_bw, old_bw, nr_node_ids*sizeof(unsigned long));
>> > +	new_bw[node] = min(coords->read_bandwidth, coords->write_bandwidth);
>> 
>> We need to compress two bandwidth data into one.  The possible choice
>> could be,
>> 
>> - min(coords->read_bandwidth, coords->write_bandwidth), that is, your code
>> 
>> - coords->read_bandwidth + coords->write_bandwidth
>> 
>> I don't know which one is better.  Do you have some use cases to help to
>> determine which one is better?
>
> More generally:  Are either read_bandwidth or write_bandwidth values
> even worth trusting as-is?  Should they be combined? Averaged?
> Minimumed? Maximumed?  Should they be floored to some reasonably round
> number?  These are the comments i'm hoping to garner :].
>
> I've also considered maybe adding a weighted_interleave/read_write_ratio
> sysfs entry that informs the system on how to treat the incoming
> numbers.  This would require us to cache more information, obviously.
>
> I have limited access to hardware, but here is one datum from an Intel
> platform w/ a sample CXL memory expander.
>
> # DRAM on node0
> cat /sys/bus/node/devices/node0/access0/initiators/*bandwidth
> 262100 < read
> 176100 < write
>
> Notice the 90GB/s difference between read and write, and the trailing
> 100! That doesn't look to be good for a clean reduction :[
>
> # CXL 1.1 device on node2
> cat /sys/bus/node/devices/node2/access0/initiators/*bandwidth
>  60000 < read
>  60000 < write
>
> These are pretty un-even distributions, and we may want to consider
> forcing numbers to be a little more round - otherwise we're doomed to
> just end up with whatever the ~/100 value is. Or we need to come up with
> some reduction that gets us down to reasonable small interleave values.
>
> In this scenario, we end up with:
>>>> 60000+176100
> 236100
>>>> 60000/236100
> 0.25412960609911056
>>>> 176100/236100
> 0.7458703939008895
>
> Which turns into 25:74 if you jsut round down, or 25:75 if you round up.
>
> The problem is that any heuristic you come up with for rounding out the
> bandwidth values is bound to have degenerate results. What happens if I
> add another CXL memory expander? What happens with 2DPC? etc.
>
> I wanted to collect some thoughts on this.  I'm not sure what the best
> "General" approach would be, and we may need some more data from people
> with access to more varied hardware.
>
> Maybe worth submitting to LSF/MM for a quick discussion, but I think
> we'll need some help figuring this one out.
>
>> > +
>> > +	/* New recalculate the bandwidth distribution given the new info */
>> > +	for (i = 0; i < nr_node_ids; i++)
>> > +		ttl_bw += new_bw[i];
>> > +
>> > +	/* If node is not set or has < 1% of total bw, use minimum value of 1 */
>> > +	for (i = 0; i < nr_node_ids; i++) {
>> > +		if (new_bw[i])
>> > +			new_iw[i] = max((100 * new_bw[i] / ttl_bw), 1);

IIUC, the sum of interleave weights of all nodes will be 100.  If there
are more than 100 nodes in the system, this doesn't work properly.  How
about use some fixed number like "16" for DRAM node?

>> > +		else
>> > +			new_iw[i] = 1;
>> 
>> If we lacks performance data for some node, it will use "1" as default
>> weight.  It doesn't look like the best solution for me.  How about use
>> the average available bandwidth to calculate the default weight?  Or use
>> memory bandwidth of node 0 if performance data is missing?
>> 
>
> If we lack performance data for a node, it's one of 3 cases
>
> 1) The device did not provide HMAT information
> 2) We did not integrate that driver into the system yet.
> 3) The node is not online yet (therefore the data hasn't been reported)
>
> #2 and #3 are not issues, the only real issue is #1.
>
> In this scenario, I'm not sure what to do.  We must have a non-0 value
> for that device (to avoid div-by-0), but setting an abitrarily large
> value also seems bad.

I think that it's kind of reasonable to use DRAM bandwidth for device
without data.  If there are only DRAM nodes and nodes without data, this
will make interleave weight to "1".

> My thought was that if you are using weighted interleave, you're
> probably already pretty confident that your environment is reasonably
> sane - i.e. HMAT is providing the values.
>
>> > +	}
>> > +	/*
>> > +	 * Now attempt to aggressively reduce the interleave weights by GCD
>> > +	 * We want smaller interleave intervals to have a better distribution
>> > +	 * of memory, even on smaller memory regions. If weights are divisible
>> > +	 * by each other, we can do some quick math to aggresively squash them.
>> > +	 */
>> > +reduce:
>> > +	gcd_val = new_iw[i];
>> 
>> "i" will be "nr_node_ids" in the first loop.  Right?
>> 
>
> ah good catch, this should be new_iw[node_being_updated], will update
>
>> > -		weight = table ? table[nid] : 1;
>> > -		weight = weight ? weight : 1;
>> > +		weight = table ? table[nid] : 0;
>> > +		weight = weight ? weight :
>> > +				  (default_table ? default_table[nid] : 1);
>> 
>> This becomes long.  I think that we should define a help function for this.
>
> Maybe? I didn't bother since it's not replicated elsewhere.  It does
> look similar to the help function which fetches the node weight, but
> that function itself calls rcu_read_lock() since it is called during the
> bulk allocator.
>
> I think probably some more thought could be put into this interaction,
> this was just a first pass.  Certainly could be improved.
>
> Thanks for the feedback, will chew on it a bit.  Let me know your
> thoughts on the bandwidth examples above if you have any.

--
Best Regards,
Huang, Ying

