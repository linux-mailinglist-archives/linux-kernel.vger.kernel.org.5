Return-Path: <linux-kernel+bounces-73233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AB685BFC2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E5F1F21FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362C9763EC;
	Tue, 20 Feb 2024 15:21:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3967603D;
	Tue, 20 Feb 2024 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442513; cv=none; b=MJ/o8V5Hi8DYYmLFsYmcY+UZIfy+2kLrcVjyWSRsxsjxlsG71DarhbzeVn1RoTqob5W7TJEftuRmWhJro9KBt19hsF34gqBIp7sSNXuzjFTCDTyJbsuMq9ZmK0bg3ihzOQHR2qopkFLZc6mbqINdS10mNu3EcBWXR4TpgCJNCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442513; c=relaxed/simple;
	bh=j/x7j0zSp0zaeCiGknpLFUi7yYjdhVjWyDUiBYxrBWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyDbgN891bdapwbmPPpmChpS/On/+LWXcaRaRB5DaypAov1BH5C+iBkzgdFC7an1muTwEtl0GhtbnJPqZIigDzYQY+Q8HZOQe3bKLj3y8xnvHMrOeqm7Iso+m9XHiuwoJJcZsugunzv2WW2xuZoEP0BJuNgOUn66Ca/sWr0TIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B8721007;
	Tue, 20 Feb 2024 07:22:29 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93FA63F7F4;
	Tue, 20 Feb 2024 07:21:46 -0800 (PST)
Message-ID: <1a8c1cd6-a1ce-47a2-bc87-d4cccc84519b@arm.com>
Date: Tue, 20 Feb 2024 15:21:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-GB
To: Peter Newman <peternewman@google.com>, babu.moger@amd.com
Cc: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <7c26af23-fa1e-4e01-8088-8fbd9be3d6f3@intel.com>
 <431d6ac4-53cb-2f73-3cda-22616df2f96a@amd.com>
 <4bb63a78-0d0d-47bc-ad65-558af8bc5519@intel.com>
 <51c60991-eb10-40e8-b3ab-676b92b0c662@amd.com>
 <CALPaoChhKJiMAueFtgCTc7ffO++S5DJCySmxqf9ZDmhR9RQapw@mail.gmail.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoChhKJiMAueFtgCTc7ffO++S5DJCySmxqf9ZDmhR9RQapw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Peter, Babu,

On 16/02/2024 20:18, Peter Newman wrote:
> On Thu, Feb 8, 2024 at 9:29 AM Moger, Babu <babu.moger@amd.com> wrote:
>> On 2/5/24 16:38, Reinette Chatre wrote:
>>> You have made it clear on several occasions that you do not intend to support
>>> domain level assignment. That may be ok but the interface you create should
>>> not prevent future support of domain level assignment.
>>>
>>> If my point is not clear, could you please share how this interface is able to
>>> support domain level assignment in the future?
>>>
>>> I am starting to think that we need a file similar to the schemata file
>>> for group and domain level monitor configurations.
>>
>> Something like this?
>>
>> By default
>> #cat /sys/fs/resctrl/monitor_state
>> default:0=total=assign,local=assign;1=total=assign,local=assign
>>
>> With ABMC,
>> #cat /sys/fs/resctrl/monitor_state
>> ABMC:0=total=unassign,local=unassign;1=total=unassign,local=unassign
> 
> The benefit from all the string parsing in this interface is only
> halving the number of monitor_state sysfs writes we'd need compared to
> creating a separate file for mbm_local and mbm_total. Given that our
> use case is to assign the 32 assignable counters to read the bandwidth
> of ~256 monitoring groups, this isn't a substantial gain to help us. I
> think you should just focus on providing the necessary control
> granularity without trying to consolidate writes in this interface. I
> will propose an additional interface below to optimize our use case.
> 
> Whether mbm_total and mbm_local are combined in the group directories
> or not, I don't see why you wouldn't just repeat the same file
> interface in the domain directories for a user needing finer-grained
> controls.

I don't follow why this has to be done globally. resctrl allows CLOSID to have different
configurations for different purposes between different domains (as long as tasks are
pinned to CPUs). It feels a bit odd that these counters can't be considered as per-domain too.

MPAM can equally allocate monitors/counters per-domain. If we are ever going to have
per-domain assignment, I think its worth the extra work to do that now and avoid the extra
user-space interface baggage from the global version.


>>>> Peter, James,
>>>>
>>>> Please comment on what you want achieve in "assignment" based on the features you are working on.
> 
> I prototyped and tested the following additional interface for the
> large-scale, batch use case that we're primarily concerned about:
> 
> info/L3_MON/mbm_{local,total}_bytes_assigned
> 
> Writing a whitespace-delimited list of mongroup directory paths does

| mkdir /sys/fs/resctrl/my\ group

string parsing in the kernel is rarely fun!


> the following:
> 1. unassign all monitors for the given counter
> 2. assigns a monitor to each mongroup referenced in the write
> 3. batches per-domain register updates resulting from the assignments
> into a single IPI for each domain
> 
> This interface allows us to do less sysfs writes and IPIs on systems
> with more assignable monitoring resources, rather than doing more.
> 
> The reference to a mongroup when reading/writing the above node is the
> resctrl-root-relative path to the monitoring group. There is probably
> a more concise way to refer to the groups, but my prototype used
> kernfs_walk_and_get() to locate each rdtgroup struct.

If this file were re-used for finding where the monitors were currently allocated, using
the name would be a natural fit for building a path to un-assign one group.


> I would also like to add that in the software-ABMC prototype I made,
> because it's based on assignment of a small number of RMIDs,
> assignment results in all counters being assigned at once. On
> implementations where per-counter assignments aren't possible,
> assignment through such a resource would be allowed to assign more
> resources than explicitly requested.
> 
> This would allow an implementation only capable of global assignment

Do we know if this exists? Given the configurations have to be different for a domain, I'd
be surprised if counter configuration is somehow distributed between domains.


> to assign resources to all groups when a non-empty string is written
> to the proposed file nodes, and all resources to be unassigned when an
> empty string is written. Reading back from the file nodes would tell
> the user how much was actually assigned.

What do you mean by 'how much', is this allow to fail early? That feels a bit
counter-intuitive. As this starts with a reset, if the number of counters is known - it
should be easy for user-space to know it can only write X tokens into that file.


Thanks,

James

