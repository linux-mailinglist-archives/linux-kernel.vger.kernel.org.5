Return-Path: <linux-kernel+bounces-21733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD301829375
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C45C1F26CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B532DF67;
	Wed, 10 Jan 2024 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgtNCpkG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1DDF55;
	Wed, 10 Jan 2024 05:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704865782; x=1736401782;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=dhn8lW2PQSKTBB+E/1ToBYW7OfpllNpuAWbFrFkAQOg=;
  b=lgtNCpkG4mjofaJjaPwyikr0NtD2dAAu4KSLxj6OeuqRbnjbLG8feWvK
   AcOu3ftLJ5sHyEzVyXWe3GaaHra6hRErL74sd0e0LXIRf0633IWqHTT/X
   CcmBZR3CN1LWuEXRLz+yTyJF3xTlB6qOmnWgpsRTmYDxf6EtCo+irULHl
   VSDNGr/f1zzuQI7VorG0cK5aHdW9Pn6/AlTBOShBGnNGmv0n3GXMY/y2I
   LHMIo6cnzMrk+Zf2IGwexXkkOhITvbtGQkrkmOsZvvRO3p09SFnjEYV68
   6NHwDEAsNXk7WZIRZrzj2kWmDIhiEYpNbp1u7W/k80CnRLrlxnHu2MmAQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="19914845"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="19914845"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 21:49:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="901022216"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="901022216"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 21:49:35 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Srinivasulu Thanneeru
 <sthanneeru@micron.com>,  Srinivasulu Opensrc
 <sthanneeru.opensrc@micron.com>,  "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>,  "linux-mm@kvack.org" <linux-mm@kvack.org>,
  "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
  "dan.j.williams@intel.com" <dan.j.williams@intel.com>,  "mhocko@suse.com"
 <mhocko@suse.com>,  "tj@kernel.org" <tj@kernel.org>,
  "john@jagalactic.com" <john@jagalactic.com>,  Eishan Mirakhur
 <emirakhur@micron.com>,  Vinicius Tavares Petrucci
 <vtavarespetr@micron.com>,  Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  "Johannes
 Weiner" <hannes@cmpxchg.org>,  Wei Xu <weixugc@google.com>,  Hao Xiang
 <hao.xiang@bytedance.com>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>
Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
In-Reply-To: <ZZ2Jd7/7rFD0o5S3@memverge.com> (Gregory Price's message of "Tue,
	9 Jan 2024 12:59:19 -0500")
References: <87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87a5pmddl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79552F35351FA57EF4BD64B4A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87wmspbpma.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZwrIoP9+ey7rp3C@memverge.com>
	<87o7dv897s.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240109155049.00003f13@Huawei.com> <ZZ2Jd7/7rFD0o5S3@memverge.com>
Date: Wed, 10 Jan 2024 13:47:38 +0800
Message-ID: <87bk9t91tx.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Jan 09, 2024 at 03:50:49PM +0000, Jonathan Cameron wrote:
>> On Tue, 09 Jan 2024 11:41:11 +0800
>> "Huang, Ying" <ying.huang@intel.com> wrote:
>> > Gregory Price <gregory.price@memverge.com> writes:
>> > > On Thu, Jan 04, 2024 at 02:05:01PM +0800, Huang, Ying wrote:  
>> > It's possible to change the performance of a NUMA node changed, if we
>> > hot-remove a memory device, then hot-add another different memory
>> > device.  It's hoped that the CDAT changes too.
>> 
>> Not supported, but ACPI has _HMA methods to in theory allow changing
>> HMAT values based on firmware notifications...  So we 'could' make
>> it work for HMAT based description.
>> 
>> Ultimately my current thinking is we'll end up emulating CXL type3
>> devices (hiding topology complexity) and you can update CDAT but
>> IIRC that is only meant to be for degraded situations - so if you
>> want multiple performance regions, CDAT should describe them form the start.
>> 
>
> That was my thought.  I don't think it's particularly *realistic* for
> HMAT/CDAT values to change at runtime, but I can imagine a case where
> it could be valuable.
>
>> > > https://lore.kernel.org/linux-cxl/CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com/
>> > >
>> > > This group wants to enable passing CXL memory through to KVM/QEMU
>> > > (i.e. host CXL expander memory passed through to the guest), and
>> > > allow the guest to apply memory tiering.
>> > >
>> > > There are multiple issues with this, presently:
>> > >
>> > > 1. The QEMU CXL virtual device is not and probably never will be
>> > >    performant enough to be a commodity class virtualization.
>> 
>> I'd flex that a bit - we will end up with a solution for virtualization but
>> it isn't the emulation that is there today because it's not possible to
>> emulate some of the topology in a peformant manner (interleaving with sub
>> page granularity / interleaving at all (to a lesser degree)). There are
>> ways to do better than we are today, but they start to look like
>> software dissagregated memory setups (think lots of page faults in the host).
>>
>
> Agreed, the emulated device as-is can't be the virtualization device,
> but it doesn't mean it can't be the basis for it.
>
> My thought is, if you want to pass host CXL *memory* through to the
> guest, you don't actually care to pass CXL *control* through to the
> guest.  That control lies pretty squarely with the host/hypervisor.
>
> So, at least in theory, you can just cut the type3 device out of the
> QEMU configuration entirely and just pass it through as a distinct numa
> node with specific hmat qualities.
>
> Barring that, if we must go through the type3 device, the question is
> how difficult would it be to just make a stripped down type3 device
> to provide the informational components, but hack off anything
> topology/interleave related? Then you just do direct passthrough as you
> described below.
>
> qemu/kvm would report errors if you tried to touch the naughty bits.
>
> The second question is... is that device "compliant" or does it need
> super special handling from the kernel driver :D?  If what i described
> is not "compliant", then it's probably a bad idea, and KVM/QEMU should
> just hide the CXL device entirely from the guest (for this use case)
> and just pass the memory through as a numa node.
>
> Which gets us back to: The memory-tiering component needs a way to
> place nodes in different tiers based on HMAT/CDAT/User Whim. All three
> of those seem like totally valid ways to go about it.
>
>> > >
>> > > 2. When passing memory through as an explicit NUMA node, but not as
>> > >    part of a CXL memory device, the nodes are lumped together in the
>> > >    DRAM tier.
>> > >
>> > > None of this has to do with firmware.
>> > >
>> > > Memory-type is an awful way of denoting membership of a tier, but we
>> > > have HMAT information that can be passed through via QEMU:
>> > >
>> > > -object memory-backend-ram,size=4G,id=ram-node0 \
>> > > -object memory-backend-ram,size=4G,id=ram-node1 \
>> > > -numa node,nodeid=0,cpus=0-4,memdev=ram-node0 \
>> > > -numa node,initiator=0,nodeid=1,memdev=ram-node1 \
>> > > -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=10 \
>> > > -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=10485760 \
>> > > -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=20 \
>> > > -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=5242880
>> > >
>> > > Not only would it be nice if we could change tier membership based on
>> > > this data, it's realistically the only way to allow guests to accomplish
>> > > memory tiering w/ KVM/QEMU and CXL memory passed through to the guest.
>> 
>> This I fully agree with.  There will be systems with a bunch of normal DDR with different
>> access characteristics irrespective of CXL. + likely HMAT solutions will be used
>> before we get anything more complex in place for CXL.
>> 
>
> Had not even considered this, but that's completely accurate as well.
>
> And more discretely: What of devices that don't provide HMAT/CDAT? That
> isn't necessarily a violation of any standard.  There probably could be
> a release valve for us to still make those devices useful.
>
> The concern I have with not implementing a movement mechanism *at all*
> is that a one-size-fits-all initial-placement heuristic feels gross
> when we're, at least ideologically, moving toward "software defined memory".
>
> Personally I think the movement mechanism is a good idea that gets folks
> where they're going sooner, and it doesn't hurt anything by existing. We
> can change the initial placement mechanism too.
>
> </2cents>

It's the last resort to provide hardware information from user space.
We should try to avoid that if possible.

Per my understanding, per-memory-type abstract distance overriding is to
apply specific policy.  While, per-memory-node abstract distance
overriding is to provide missing hardware information.

--
Best Regards,
Huang, Ying

