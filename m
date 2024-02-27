Return-Path: <linux-kernel+bounces-82475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7712C868510
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35221C21910
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D883F17FF;
	Tue, 27 Feb 2024 00:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VF2NvWj5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F76A7FF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994419; cv=none; b=nNX2v1y6oWqqOdSb2+iW/a+NyWrFgZ8nb6gdHnlRn3AhuvXKSCT8qnRLELvKdtHtp0ZA1rjEpXEOO0SVjT/dniP/0H+Az/ZTZOgBnYMTOjUuEYkLEkda2iRgr0VrYCt9U2M8l/aNfZW6s6DkLeJgEJK3lS2yzhfzod6V6pQLPpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994419; c=relaxed/simple;
	bh=XQrJcpKgxIV+gtw9yVUIUl0OVoNPwIVzq5HXcRyo620=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gHLZoe+YB36ntx4KhpaimPgOpBnO4QXdbrjSevZy1mhReekoOaY5YGtiPnPg1lyBdijn0GxCaoBxS5PAVUXwCmIdc32i3gkiDEMmlzTzvTMS6davHxy02/+yey65kSVVBqTSPjFzN2MrOJgNpUaU0qgZs2fdGRHjC++zszjSBUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VF2NvWj5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708994417; x=1740530417;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=XQrJcpKgxIV+gtw9yVUIUl0OVoNPwIVzq5HXcRyo620=;
  b=VF2NvWj5IZsIUiM713z9/qloRcuoYlQEA06HY2IM3M2SMyKhl263NJW6
   Eq2ZOuxlteuX5ISF4AYB+ckElH79rK8xeZiQlK+Q6XaC/aiyfzLUq36Ui
   FCLmGzmXTW65uPo1Gr94RK2S1XOUBOL1BVmHmaApOqbDWYnl+AkFfT4vq
   Zb5ND6PEcQBYncW07xyd+mu0MOigWG5U4jXnNCvyg5Rc6Oa54GZ1lWH0s
   oeCUUDJRAQK3IVSytH5o24IKnsRFDmfD+IroQeu8BNvmCU0FEfXTNCJ5/
   PQghVxomL7tjSilSvj9iLC8/0OzGQDIX++259twwYv0/iIah/zyU/VoZB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7101518"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7101518"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 16:40:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6729837"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 16:40:14 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <hannes@cmpxchg.org>,
  <dan.j.williams@intel.com>,  <dave.jiang@intel.com>
Subject: Re: [RFC 1/1] mm/mempolicy: introduce system default interleave
 weights
In-Reply-To: <ZdygZ8ZidfaORg8F@memverge.com> (Gregory Price's message of "Mon,
	26 Feb 2024 09:29:59 -0500")
References: <20240220202529.2365-1-gregory.price@memverge.com>
	<20240220202529.2365-2-gregory.price@memverge.com>
	<87wmqxht4c.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZdgxaLSBznupVmJK@memverge.com>
	<87sf1jh7es.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZdygZ8ZidfaORg8F@memverge.com>
Date: Tue, 27 Feb 2024 08:38:19 +0800
Message-ID: <87edcyeo78.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Fri, Feb 23, 2024 at 05:11:23PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>>
>
> (sorry for the re-send, error replying to list)
>
>> >> > +	/* If node is not set or has < 1% of total bw, use minimum value of 1 */
>> >> > +	for (i = 0; i < nr_node_ids; i++) {
>> >> > +		if (new_bw[i])
>> >> > +			new_iw[i] = max((100 * new_bw[i] / ttl_bw), 1);
>> 
>> IIUC, the sum of interleave weights of all nodes will be 100.  If there
>> are more than 100 nodes in the system, this doesn't work properly.  How
>> about use some fixed number like "16" for DRAM node?
>>
>
> I suppose we could add a "type" value into the interface that says
> what approximate "tier" a node is in, or we could ask the tiering
> component for that information.  But what does this actually change?
>
> You still calculate the percentage of bandwidth provided by each node,
> and then just apply that to the larger default number. I don't see the
> point in that - if each node provides less than 1% of the overall system
> bandwidth, and larger numbers won't do much. In fact, we want smaller
> numbers to spread spacially local data out more aggressively.
>
> More important question: In what world is a large numa system liabile
> to use this interface to any real benefit?
>
>
> I'd briefly considered this, but I strayed away from supporting that
> case.  Probably worth documenting, at the very least.
>
> We had the cross-socket interleave discussion previously in the prior
> series.  The question above simplifies (complicates?) to:  How useful
> is interleave (weighted or not) in cross-socket workloads.
>
> Consider the following configuration:
>
>
>  ---------   A  --------    C    -------- D  ---------
>  | DRAM0 | ---- | cpu0 |---UPI---| cpu1 |----| DRAM1 |
>  ---------      --------         --------    ---------
> 	           | B              | E
>                 --------         --------
>                 | cxl0 |         | cxl1 |
>                 --------         --------
>
> Theoretical throughputs
>
> A&D: 512GB/s  (8 channel DDR5)
> B&E: 64GB/s   (1 CXL/PCIe5 link)
> C  : 62.4GB/s (3x UPI links)
>
> Where are the 100 nodes coming from?

If you have a real large machine with more than 100 nodes, and some of
them are CXL memory nodes, then it's possible that most nodes will have
interleave weight "1" because the sum of all interleave weights is
"100".  Then, even if you use only one socket, the interleave weight of
DRAM and CXL MEM could be all "1", lead to useless default value.  So, I
suggest don't cap the sum of interleave weights.

> If it's across interconnects (UPI), then the throughput to remote
> DRAM is better described by C, not A or D. However, we don't have
> that information (maybe we should?).  More importantly... is
> interleaving across these links even useful?  I suppose if you did
> sub-numa clustering stuff and had an ultra-super-numa-aware piece
> of software capable of keeping certain chunks of memory in certain
> cores that might be useful.... but then you probably actually want
> task-local weights as opposed to using the system default.
>
> Otherwise, does a UPI link actually get the full throughput? Probably
> only if the remote memory bus is unloaded.  If the remote bus is
> loaded, then link C performance information is basically a lie.
>
> I've been convinced (so far) that cross-socket interconnect
> interleaving is not a real use-case unless you intend to only run
> your software on a single socket and use the remote socket for
> whatever you can swipe over the interconnect. In that case, you're
> probably smart enough to set the interleave weights manually.
>
>
> So what if the nodes are coming from many memory sources down one
> or more local CXL links (link B from cpu0).
>
>  ---------   A  --------
>  | DRAM0 | ---- | cpu0 |
>  ---------      --------
> 	           | B 
>       ----------------------------
>       |                          |
>   --------                    --------
>   | cxl0 |       ......       | cxlN |
>   --------                    --------
>
> In that case it would be better for many reasons to reconfigure the
> system to combine those nodes into fewer nodes via a hardware interleave
> set.  This can be done in hardware (at a switch), in BIOS (at the root
> complex), or by the CXL Driver.  The result is fewer nodes, and the real
> performance of that node can be calculated by the drivers and repoted
> accordingly.
>
>
>
> So coming back to this code:  Then why am I doing GCD across all
> nodes, rather than taking the full topology into account?  Mostly
> because the topological information is not easily available, would
> be complex to communicate across components, and the full reduction
> is a decent approximation anyway.
>
> Example from above using real HMAT reported numbers
>
> A&D: 176100
> B&E: 60000
> C:   Not a node, no information available.
>
> Produces Node Weights
>
> Calculating total system weighted averagee
> A:37  D:37  B:12  E:12  (37 is prime so no reductions possible)
>
> Calculating local-node relationships only
> A:74--B:25  D:74--E:25  (GCD is 1, so no reductions possible)
>
> Notice that 12+37 = 49 -  12/49 = 24%
>
> So the ratios end up working out basically the same anyway, but
> the smaller numbers produced by averaging over the entire system
> are preferable to the "topologically aware" numbers anyway.
>
>
> Obviously this breaks in a "large numa system" - but again...
> is this even useful for those systems anyway? I contend: No.
>
>
> This is still reasonable accurate in non-hogeneous systems
>
>  ---------   A  --------    C    -------- D  ---------
>  | DRAM0 | ---- | cpu0 |---UPI---| cpu1 |----| DRAM1 |
>  ---------      --------         --------    ---------
> 	           | B
>                 --------
>                 | cxl0 |
>                 --------
>
> In this system the numbers work out to:
>
> Global:  A:42  B:14  D: 42  (GCD: 14)
> Reduce:  A:3   B:1   D: 3
>
> A user doing `-w --interleave=A,B` will get a ratio of 3:1, which
> is pretty much spot on.
>
>
> So, long winded winded way of saying:
> - Could we use a larger default number? Yes.
> - Does that actually help us? Not really, we want smaller numbers.

The larger number will be reduced after GCD.

> - Does this reduce to normal-interleave under large-numa systems? Yes.
> - Does that matter? Probably not. It doesn't seem like a real use case.
> - What if it is?  The workloads probably want task-local weights anyway.
>
>> >
>> > In this scenario, I'm not sure what to do.  We must have a non-0 value
>> > for that device (to avoid div-by-0), but setting an abitrarily large
>> > value also seems bad.
>> 
>> I think that it's kind of reasonable to use DRAM bandwidth for device
>> without data.  If there are only DRAM nodes and nodes without data, this
>> will make interleave weight to "1".
>>
>
> Yes, those nodes would reduce to 1.  Which is pretty much the best we can
> do without accounting for interconnects - which as discussed above is not
> really useful anyway.
>
>
>
> I think I'll draft up an LSF/MM chat to see if we can garner more input.
> If large-numa systems are a real issue, then yes we need to address it.

Sounds good to me!

--
Best Regards,
Huang, Ying

> ~Gregory

