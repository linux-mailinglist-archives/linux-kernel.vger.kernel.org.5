Return-Path: <linux-kernel+bounces-24352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C04F82BB74
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B683F284B99
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4165C903;
	Fri, 12 Jan 2024 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfZRTwGC"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6BC381B7;
	Fri, 12 Jan 2024 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705042936; x=1736578936;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=OSuL1hJdmHek9yEXuog1b29OXiHJirwFDLGzpcTvJXo=;
  b=TfZRTwGCltPTUz0IkhbH8fiPsDeTXuxNoDoVMBMIm691mQs2rOODRXvE
   G9lQ7TY1QvzPA8Wfo1FgqIJHh/HSMdhYSa+BadVOjMGpbE9RuT4vusQcD
   TDu61EnESLrhQ/ui2Bk9VN1xbu70MN82EHJHblZMS5tHQdYBAztNHC4Bf
   34JrYxfBb5Cml654b6Ubir4TYLlNw2fCj/HPxksQetRIvXGmacRrh5fG7
   Fzay8j1hirinKNr4/6HMM8UlTnLF2cQHRomcMlpvTS6/uav+Gu12lqFQg
   a+uR6F0hMgiKEkK5aa/z1KsAPRDKRvINRiP7f7G7sqCdQ5ya+dyWo/AC4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="465483924"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="465483924"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 23:02:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="759049624"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="759049624"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 23:02:10 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Hao Xiang <hao.xiang@bytedance.com>,  "aneesh.kumar@linux.ibm.com"
 <aneesh.kumar@linux.ibm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Gregory Price
 <gregory.price@memverge.com>,  Srinivasulu Thanneeru
 <sthanneeru@micron.com>,  Srinivasulu Opensrc
 <sthanneeru.opensrc@micron.com>,  "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>,  "linux-mm@kvack.org" <linux-mm@kvack.org>,
  "dan.j.williams@intel.com" <dan.j.williams@intel.com>,  "mhocko@suse.com"
 <mhocko@suse.com>,  "tj@kernel.org" <tj@kernel.org>,
  "john@jagalactic.com" <john@jagalactic.com>,  Eishan Mirakhur
 <emirakhur@micron.com>,  Vinicius Tavares Petrucci
 <vtavarespetr@micron.com>,  Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Wei Xu <weixugc@google.com>,  "Ho-Ren (Jack)
 Chuang" <horenchuang@bytedance.com>
Subject: Re: [External] Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration
 between memory tiers
In-Reply-To: <CAAYibXgwqY6Og_4NqGGEni=2Xgx=DPxaMc3GdBUE6FREKVCq8w@mail.gmail.com>
	(Hao Xiang's message of "Wed, 10 Jan 2024 11:29:14 -0800")
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
	<CAAYibXhe81ez06tP5K7zGkX9P=Ot+DcSysVyDvh13aSEDD63aA@mail.gmail.com>
	<20240110141821.0000370d@Huawei.com>
	<CAAYibXgwqY6Og_4NqGGEni=2Xgx=DPxaMc3GdBUE6FREKVCq8w@mail.gmail.com>
Date: Fri, 12 Jan 2024 15:00:12 +0800
Message-ID: <87il3z2g03.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hao Xiang <hao.xiang@bytedance.com> writes:

> On Wed, Jan 10, 2024 at 6:18=E2=80=AFAM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>>
>> On Tue, 9 Jan 2024 16:28:15 -0800
>> Hao Xiang <hao.xiang@bytedance.com> wrote:
>>
>> > On Tue, Jan 9, 2024 at 9:59=E2=80=AFAM Gregory Price <gregory.price@me=
mverge.com> wrote:
>> > >
>> > > On Tue, Jan 09, 2024 at 03:50:49PM +0000, Jonathan Cameron wrote:
>> > > > On Tue, 09 Jan 2024 11:41:11 +0800
>> > > > "Huang, Ying" <ying.huang@intel.com> wrote:
>> > > > > Gregory Price <gregory.price@memverge.com> writes:
>> > > > > > On Thu, Jan 04, 2024 at 02:05:01PM +0800, Huang, Ying wrote:
>> > > > > It's possible to change the performance of a NUMA node changed, =
if we
>> > > > > hot-remove a memory device, then hot-add another different memory
>> > > > > device.  It's hoped that the CDAT changes too.
>> > > >
>> > > > Not supported, but ACPI has _HMA methods to in theory allow changi=
ng
>> > > > HMAT values based on firmware notifications...  So we 'could' make
>> > > > it work for HMAT based description.
>> > > >
>> > > > Ultimately my current thinking is we'll end up emulating CXL type3
>> > > > devices (hiding topology complexity) and you can update CDAT but
>> > > > IIRC that is only meant to be for degraded situations - so if you
>> > > > want multiple performance regions, CDAT should describe them form =
the start.
>> > > >
>> > >
>> > > That was my thought.  I don't think it's particularly *realistic* for
>> > > HMAT/CDAT values to change at runtime, but I can imagine a case where
>> > > it could be valuable.
>> > >
>> > > > > > https://lore.kernel.org/linux-cxl/CAAYibXjZ0HSCqMrzXGv62cMLncS=
_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com/
>> > > > > >
>> > > > > > This group wants to enable passing CXL memory through to KVM/Q=
EMU
>> > > > > > (i.e. host CXL expander memory passed through to the guest), a=
nd
>> > > > > > allow the guest to apply memory tiering.
>> > > > > >
>> > > > > > There are multiple issues with this, presently:
>> > > > > >
>> > > > > > 1. The QEMU CXL virtual device is not and probably never will =
be
>> > > > > >    performant enough to be a commodity class virtualization.
>> > > >
>> > > > I'd flex that a bit - we will end up with a solution for virtualiz=
ation but
>> > > > it isn't the emulation that is there today because it's not possib=
le to
>> > > > emulate some of the topology in a peformant manner (interleaving w=
ith sub
>> > > > page granularity / interleaving at all (to a lesser degree)). Ther=
e are
>> > > > ways to do better than we are today, but they start to look like
>> > > > software dissagregated memory setups (think lots of page faults in=
 the host).
>> > > >
>> > >
>> > > Agreed, the emulated device as-is can't be the virtualization device,
>> > > but it doesn't mean it can't be the basis for it.
>> > >
>> > > My thought is, if you want to pass host CXL *memory* through to the
>> > > guest, you don't actually care to pass CXL *control* through to the
>> > > guest.  That control lies pretty squarely with the host/hypervisor.
>> > >
>> > > So, at least in theory, you can just cut the type3 device out of the
>> > > QEMU configuration entirely and just pass it through as a distinct n=
uma
>> > > node with specific hmat qualities.
>> > >
>> > > Barring that, if we must go through the type3 device, the question is
>> > > how difficult would it be to just make a stripped down type3 device
>> > > to provide the informational components, but hack off anything
>> > > topology/interleave related? Then you just do direct passthrough as =
you
>> > > described below.
>> > >
>> > > qemu/kvm would report errors if you tried to touch the naughty bits.
>> > >
>> > > The second question is... is that device "compliant" or does it need
>> > > super special handling from the kernel driver :D?  If what i describ=
ed
>> > > is not "compliant", then it's probably a bad idea, and KVM/QEMU shou=
ld
>> > > just hide the CXL device entirely from the guest (for this use case)
>> > > and just pass the memory through as a numa node.
>> > >
>> > > Which gets us back to: The memory-tiering component needs a way to
>> > > place nodes in different tiers based on HMAT/CDAT/User Whim. All thr=
ee
>> > > of those seem like totally valid ways to go about it.
>> > >
>> > > > > >
>> > > > > > 2. When passing memory through as an explicit NUMA node, but n=
ot as
>> > > > > >    part of a CXL memory device, the nodes are lumped together =
in the
>> > > > > >    DRAM tier.
>> > > > > >
>> > > > > > None of this has to do with firmware.
>> > > > > >
>> > > > > > Memory-type is an awful way of denoting membership of a tier, =
but we
>> > > > > > have HMAT information that can be passed through via QEMU:
>> > > > > >
>> > > > > > -object memory-backend-ram,size=3D4G,id=3Dram-node0 \
>> > > > > > -object memory-backend-ram,size=3D4G,id=3Dram-node1 \
>> > > > > > -numa node,nodeid=3D0,cpus=3D0-4,memdev=3Dram-node0 \
>> > > > > > -numa node,initiator=3D0,nodeid=3D1,memdev=3Dram-node1 \
>> > > > > > -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data=
-type=3Daccess-latency,latency=3D10 \
>> > > > > > -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data=
-type=3Daccess-bandwidth,bandwidth=3D10485760 \
>> > > > > > -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data=
-type=3Daccess-latency,latency=3D20 \
>> > > > > > -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data=
-type=3Daccess-bandwidth,bandwidth=3D5242880
>> > > > > >
>> > > > > > Not only would it be nice if we could change tier membership b=
ased on
>> > > > > > this data, it's realistically the only way to allow guests to =
accomplish
>> > > > > > memory tiering w/ KVM/QEMU and CXL memory passed through to th=
e guest.
>> > > >
>> > > > This I fully agree with.  There will be systems with a bunch of no=
rmal DDR with different
>> > > > access characteristics irrespective of CXL. + likely HMAT solution=
s will be used
>> > > > before we get anything more complex in place for CXL.
>> > > >
>> > >
>> > > Had not even considered this, but that's completely accurate as well.
>> > >
>> > > And more discretely: What of devices that don't provide HMAT/CDAT? T=
hat
>> > > isn't necessarily a violation of any standard.  There probably could=
 be
>> > > a release valve for us to still make those devices useful.
>> > >
>> > > The concern I have with not implementing a movement mechanism *at al=
l*
>> > > is that a one-size-fits-all initial-placement heuristic feels gross
>> > > when we're, at least ideologically, moving toward "software defined =
memory".
>> > >
>> > > Personally I think the movement mechanism is a good idea that gets f=
olks
>> > > where they're going sooner, and it doesn't hurt anything by existing=
 We
>> > > can change the initial placement mechanism too.
>> >
>> > I think providing users a way to "FIX" the memory tiering is a backup
>> > option. Given that DDRs with different access characteristics provide
>> > the relevant CDAT/HMAT information, the kernel should be able to
>> > correctly establish memory tiering on boot.
>>
>> Include hotplug and I'll be happier!  I know that's messy though.
>>
>> > Current memory tiering code has
>> > 1) memory_tier_init() to iterate through all boot onlined memory
>> > nodes. All nodes are assumed to be fast tier (adistance
>> > MEMTIER_ADISTANCE_DRAM is used).
>> > 2) dev_dax_kmem_probe to iterate through all devdax controlled memory
>> > nodes. This is the place the kernel reads the memory attributes from
>> > HMAT and recognizes the memory nodes into the correct tier (devdax
>> > controlled CXL, pmem, etc).
>> > If we want DDRs with different memory characteristics to be put into
>> > the correct tier (as in the guest VM memory tiering case), we probably
>> > need a third path to iterate the boot onlined memory nodes and also be
>> > able to read their memory attributes. I don't think we can do that in
>> > 1) because the ACPI subsystem is not yet initialized.
>>
>> Can we move it later in general?  Or drag HMAT parsing earlier?
>> ACPI table availability is pretty early, it's just that we don't bother
>> with HMAT because nothing early uses it.
>> IIRC SRAT parsing occurs way before memory_tier_init() will be called.
>
> I tested the call sequence under a debugger earlier. hmat_init() is
> called after memory_tier_init(). Let me poke around and see what our
> options are.

This sounds reasonable.

Please keep in mind that we need a way to identify the base line memory
type(default_dram_type).  A simple method is to use NUMA nodes with CPU
attached.  But I remember that Aneesh said that some NUMA nodes without
CPU will need to be put in default_dram_type too on their systems.  We
need a way to identify that.

--
Best Regards,
Huang, Ying

