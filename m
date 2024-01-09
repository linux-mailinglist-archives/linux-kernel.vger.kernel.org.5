Return-Path: <linux-kernel+bounces-20334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A25827D6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADACF1C231D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14044698;
	Tue,  9 Jan 2024 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2U4OK4A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F1633EE;
	Tue,  9 Jan 2024 03:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704771806; x=1736307806;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=EXGALg+04GjIg7VHmOoodLCutmjxuq5kzaEUQbcbKOQ=;
  b=i2U4OK4AWF4jDzopy9a6L83jkXF73pBoJlGBP5YVSVek8R95HXeSbxwr
   UJwEZnHEEggC9wmORgOwh1QhMgAMuQIV7trO2Ekiba1HOg1Z2JN/sbIaS
   aovjtMfAqOcr3Q2SZ1tAOLCkxNFRXDQUNSUAvPv+ABpSI5OPs1Idei3Fr
   ZEUey4tnVqkL0NfxASU0gA9JoWy76lA/nUvzBBrP/B3Fz6EYdsdTrp73c
   zypIj5jEcC8SoFD8APNTFP0ucm2teGFPlPgzeS0LGkmwKf2pHW4WmX8Gm
   0yg/i64gkCQsbPbWtJfcH564qVBK7lYxBoVJWkjgGTHg4/NrNakODrHeM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4833825"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="4833825"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 19:43:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="872099709"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="872099709"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 19:43:09 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Srinivasulu Thanneeru <sthanneeru@micron.com>,  Srinivasulu Opensrc
 <sthanneeru.opensrc@micron.com>,  "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>,  "linux-mm@kvack.org" <linux-mm@kvack.org>,
  "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
  "dan.j.williams@intel.com" <dan.j.williams@intel.com>,  "mhocko@suse.com"
 <mhocko@suse.com>,  "tj@kernel.org" <tj@kernel.org>,
  "john@jagalactic.com" <john@jagalactic.com>,  Eishan Mirakhur
 <emirakhur@micron.com>,  "Vinicius Tavares Petrucci"
 <vtavarespetr@micron.com>,  Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
  "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Wei Xu <weixugc@google.com>,  Hao Xiang
 <hao.xiang@bytedance.com>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>
Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
In-Reply-To: <ZZwrIoP9+ey7rp3C@memverge.com> (Gregory Price's message of "Mon,
	8 Jan 2024 12:04:34 -0500")
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
	<87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZXyQIJOim1+tE0Qr@memverge.com>
	<87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87a5pmddl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79552F35351FA57EF4BD64B4A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87wmspbpma.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZwrIoP9+ey7rp3C@memverge.com>
Date: Tue, 09 Jan 2024 11:41:11 +0800
Message-ID: <87o7dv897s.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Thu, Jan 04, 2024 at 02:05:01PM +0800, Huang, Ying wrote:
>> >
>> > From  https://lpc.events/event/16/contributions/1209/attachments/1042/1995/Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf
>> > abstract_distance_offset: override by users to deal with firmware issue.
>> >
>> > say firmware can configure the cxl node into wrong tiers, similar to
>> > that it may also configure all cxl nodes into single memtype, hence
>> > all these nodes can fall into a single wrong tier.
>> > In this case, per node adistance_offset would be good to have ?
>> 
>> I think that it's better to fix the error firmware if possible.  And
>> these are only theoretical, not practical issues.  Do you have some
>> practical issues?
>> 
>> I understand that users may want to move nodes between memory tiers for
>> different policy choices.  For that, memory_type based adistance_offset
>> should be good.
>> 
>
> There's actually an affirmative case to change memory tiering to allow
> either movement of nodes between tiers, or at least base placement on
> HMAT information. Preferably, membership would be changable to allow
> hotplug/DCD to be managed (there's no guarantee that the memory passed
> through will always be what HMAT says on initial boot).

IIUC, from Jonathan Cameron as below, the performance of memory
shouldn't change even for DCD devices.

https://lore.kernel.org/linux-mm/20231103141636.000007e4@Huawei.com/

It's possible to change the performance of a NUMA node changed, if we
hot-remove a memory device, then hot-add another different memory
device.  It's hoped that the CDAT changes too.

So, all in all, HMAT + CDAT can help us to put the memory device in
appropriate memory tiers.  Now, we have HMAT support in upstream.  We
will working on CDAT support.

--
Best Regards,
Huang, Ying

> https://lore.kernel.org/linux-cxl/CAAYibXjZ0HSCqMrzXGv62cMLncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com/
>
> This group wants to enable passing CXL memory through to KVM/QEMU
> (i.e. host CXL expander memory passed through to the guest), and
> allow the guest to apply memory tiering.
>
> There are multiple issues with this, presently:
>
> 1. The QEMU CXL virtual device is not and probably never will be
>    performant enough to be a commodity class virtualization.  The
>    reason is that the virtual CXL device is built off the I/O
>    virtualization stack, which treats memory accesses as I/O accesses.
>
>    KVM also seems incompatible with the design of the CXL memory device
>    in general, but this problem may or may not be a blocker.
>
>    As a result, access to virtual CXL memory device leads to QEMU
>    crawling to a halt - and this is unlikely to change.
>
>    There is presently no good way forward to create a performant virtual
>    CXL device in QEMU.  This means the memory tiering component in the
>    kernel is functionally useless for virtual CXL memory, because...
>
> 2. When passing memory through as an explicit NUMA node, but not as
>    part of a CXL memory device, the nodes are lumped together in the
>    DRAM tier.
>
> None of this has to do with firmware.
>
> Memory-type is an awful way of denoting membership of a tier, but we
> have HMAT information that can be passed through via QEMU:
>
> -object memory-backend-ram,size=4G,id=ram-node0 \
> -object memory-backend-ram,size=4G,id=ram-node1 \
> -numa node,nodeid=0,cpus=0-4,memdev=ram-node0 \
> -numa node,initiator=0,nodeid=1,memdev=ram-node1 \
> -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=10 \
> -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=10485760 \
> -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=20 \
> -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=5242880
>
> Not only would it be nice if we could change tier membership based on
> this data, it's realistically the only way to allow guests to accomplish
> memory tiering w/ KVM/QEMU and CXL memory passed through to the guest.
>
> ~Gregory

