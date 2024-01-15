Return-Path: <linux-kernel+bounces-25579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B4082D2F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB6E281556
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB7515CE;
	Mon, 15 Jan 2024 01:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akUr5ml6"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17315A8;
	Mon, 15 Jan 2024 01:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705281978; x=1736817978;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=RAN96hU9YlRYVx95l6KQuFTyks7KtMSlSqiqq5bKzoM=;
  b=akUr5ml6h/mmpYIXdPz/3014bTZyZyXayEjUSoDmphoGFLUINd+qyXN1
   3D4IHU3RrrDxmJGPN/gln1y8t8nowqvou2aYN/iewwmq7vcBuezq8Amzl
   o/oa36hHb7jxkssptNxdnCidV3YG6Qbe5YzksOrlEjJuFalqB5Jsld5Zr
   5Ac8eDOY2aezz7bcgUWHlceUUWMXMFsGgMeahylk2KJnVwVSp1DT1fC/B
   v3JMjaYhKkRHX1o4nxurqhADSzJEv7HLX8poJZvJOAGybWUlFfT+bZB5k
   fs9yUgD1n5fqathgDcs2lRVuS0EhAz8o61XRuZpdBSYac8ATX8TeS0CvE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="396653515"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="396653515"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 17:26:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="783653565"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="783653565"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 17:26:11 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,  Jonathan
 Cameron <Jonathan.Cameron@huawei.com>,  Gregory Price
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
In-Reply-To: <CAAYibXh5DWcAJrqXi-V1v61DY_Xeb8BiMGoOxn1fJ_YBc2L8KQ@mail.gmail.com>
	(Hao Xiang's message of "Fri, 12 Jan 2024 00:14:04 -0800")
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
	<87il3z2g03.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAAYibXh5DWcAJrqXi-V1v61DY_Xeb8BiMGoOxn1fJ_YBc2L8KQ@mail.gmail.com>
Date: Mon, 15 Jan 2024 09:24:13 +0800
Message-ID: <871qaj2xtu.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, Jan 11, 2024 at 11:02=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
>>
>> Hao Xiang <hao.xiang@bytedance.com> writes:
>>
>> > On Wed, Jan 10, 2024 at 6:18=E2=80=AFAM Jonathan Cameron
>> > <Jonathan.Cameron@huawei.com> wrote:
>> >>
>> >> On Tue, 9 Jan 2024 16:28:15 -0800
>> >> Hao Xiang <hao.xiang@bytedance.com> wrote:
>> >>
>> >> > On Tue, Jan 9, 2024 at 9:59=E2=80=AFAM Gregory Price <gregory.price=
@memverge.com> wrote:
>> >> > >
>> >> > > On Tue, Jan 09, 2024 at 03:50:49PM +0000, Jonathan Cameron wrote:
>> >> > > > On Tue, 09 Jan 2024 11:41:11 +0800
>> >> > > > "Huang, Ying" <ying.huang@intel.com> wrote:
>> >> > > > > Gregory Price <gregory.price@memverge.com> writes:
>> >> > > > > > On Thu, Jan 04, 2024 at 02:05:01PM +0800, Huang, Ying wrote:
>> >> > > > > It's possible to change the performance of a NUMA node change=
d, if we
>> >> > > > > hot-remove a memory device, then hot-add another different me=
mory
>> >> > > > > device.  It's hoped that the CDAT changes too.
>> >> > > >
>> >> > > > Not supported, but ACPI has _HMA methods to in theory allow cha=
nging
>> >> > > > HMAT values based on firmware notifications...  So we 'could' m=
ake
>> >> > > > it work for HMAT based description.
>> >> > > >
>> >> > > > Ultimately my current thinking is we'll end up emulating CXL ty=
pe3
>> >> > > > devices (hiding topology complexity) and you can update CDAT but
>> >> > > > IIRC that is only meant to be for degraded situations - so if y=
ou
>> >> > > > want multiple performance regions, CDAT should describe them fo=
rm the start.
>> >> > > >
>> >> > >
>> >> > > That was my thought.  I don't think it's particularly *realistic*=
 for
>> >> > > HMAT/CDAT values to change at runtime, but I can imagine a case w=
here
>> >> > > it could be valuable.
>> >> > >
>> >> > > > > > https://lore.kernel.org/linux-cxl/CAAYibXjZ0HSCqMrzXGv62cML=
ncS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com/
>> >> > > > > >
>> >> > > > > > This group wants to enable passing CXL memory through to KV=
M/QEMU
>> >> > > > > > (i.e. host CXL expander memory passed through to the guest)=
, and
>> >> > > > > > allow the guest to apply memory tiering.
>> >> > > > > >
>> >> > > > > > There are multiple issues with this, presently:
>> >> > > > > >
>> >> > > > > > 1. The QEMU CXL virtual device is not and probably never wi=
ll be
>> >> > > > > >    performant enough to be a commodity class virtualization.
>> >> > > >
>> >> > > > I'd flex that a bit - we will end up with a solution for virtua=
lization but
>> >> > > > it isn't the emulation that is there today because it's not pos=
sible to
>> >> > > > emulate some of the topology in a peformant manner (interleavin=
g with sub
>> >> > > > page granularity / interleaving at all (to a lesser degree)). T=
here are
>> >> > > > ways to do better than we are today, but they start to look like
>> >> > > > software dissagregated memory setups (think lots of page faults=
 in the host).
>> >> > > >
>> >> > >
>> >> > > Agreed, the emulated device as-is can't be the virtualization dev=
ice,
>> >> > > but it doesn't mean it can't be the basis for it.
>> >> > >
>> >> > > My thought is, if you want to pass host CXL *memory* through to t=
he
>> >> > > guest, you don't actually care to pass CXL *control* through to t=
he
>> >> > > guest.  That control lies pretty squarely with the host/hyperviso=
r.
>> >> > >
>> >> > > So, at least in theory, you can just cut the type3 device out of =
the
>> >> > > QEMU configuration entirely and just pass it through as a distinc=
t numa
>> >> > > node with specific hmat qualities.
>> >> > >
>> >> > > Barring that, if we must go through the type3 device, the questio=
n is
>> >> > > how difficult would it be to just make a stripped down type3 devi=
ce
>> >> > > to provide the informational components, but hack off anything
>> >> > > topology/interleave related? Then you just do direct passthrough =
as you
>> >> > > described below.
>> >> > >
>> >> > > qemu/kvm would report errors if you tried to touch the naughty bi=
ts.
>> >> > >
>> >> > > The second question is... is that device "compliant" or does it n=
eed
>> >> > > super special handling from the kernel driver :D?  If what i desc=
ribed
>> >> > > is not "compliant", then it's probably a bad idea, and KVM/QEMU s=
hould
>> >> > > just hide the CXL device entirely from the guest (for this use ca=
se)
>> >> > > and just pass the memory through as a numa node.
>> >> > >
>> >> > > Which gets us back to: The memory-tiering component needs a way to
>> >> > > place nodes in different tiers based on HMAT/CDAT/User Whim. All =
three
>> >> > > of those seem like totally valid ways to go about it.
>> >> > >
>> >> > > > > >
>> >> > > > > > 2. When passing memory through as an explicit NUMA node, bu=
t not as
>> >> > > > > >    part of a CXL memory device, the nodes are lumped togeth=
er in the
>> >> > > > > >    DRAM tier.
>> >> > > > > >
>> >> > > > > > None of this has to do with firmware.
>> >> > > > > >
>> >> > > > > > Memory-type is an awful way of denoting membership of a tie=
r, but we
>> >> > > > > > have HMAT information that can be passed through via QEMU:
>> >> > > > > >
>> >> > > > > > -object memory-backend-ram,size=3D4G,id=3Dram-node0 \
>> >> > > > > > -object memory-backend-ram,size=3D4G,id=3Dram-node1 \
>> >> > > > > > -numa node,nodeid=3D0,cpus=3D0-4,memdev=3Dram-node0 \
>> >> > > > > > -numa node,initiator=3D0,nodeid=3D1,memdev=3Dram-node1 \
>> >> > > > > > -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,d=
ata-type=3Daccess-latency,latency=3D10 \
>> >> > > > > > -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,d=
ata-type=3Daccess-bandwidth,bandwidth=3D10485760 \
>> >> > > > > > -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,d=
ata-type=3Daccess-latency,latency=3D20 \
>> >> > > > > > -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,d=
ata-type=3Daccess-bandwidth,bandwidth=3D5242880
>> >> > > > > >
>> >> > > > > > Not only would it be nice if we could change tier membershi=
p based on
>> >> > > > > > this data, it's realistically the only way to allow guests =
to accomplish
>> >> > > > > > memory tiering w/ KVM/QEMU and CXL memory passed through to=
 the guest.
>> >> > > >
>> >> > > > This I fully agree with.  There will be systems with a bunch of=
 normal DDR with different
>> >> > > > access characteristics irrespective of CXL. + likely HMAT solut=
ions will be used
>> >> > > > before we get anything more complex in place for CXL.
>> >> > > >
>> >> > >
>> >> > > Had not even considered this, but that's completely accurate as w=
ell.
>> >> > >
>> >> > > And more discretely: What of devices that don't provide HMAT/CDAT=
? That
>> >> > > isn't necessarily a violation of any standard.  There probably co=
uld be
>> >> > > a release valve for us to still make those devices useful.
>> >> > >
>> >> > > The concern I have with not implementing a movement mechanism *at=
 all*
>> >> > > is that a one-size-fits-all initial-placement heuristic feels gro=
ss
>> >> > > when we're, at least ideologically, moving toward "software defin=
ed memory".
>> >> > >
>> >> > > Personally I think the movement mechanism is a good idea that get=
s folks
>> >> > > where they're going sooner, and it doesn't hurt anything by exist=
ing. We
>> >> > > can change the initial placement mechanism too.
>> >> >
>> >> > I think providing users a way to "FIX" the memory tiering is a back=
up
>> >> > option. Given that DDRs with different access characteristics provi=
de
>> >> > the relevant CDAT/HMAT information, the kernel should be able to
>> >> > correctly establish memory tiering on boot.
>> >>
>> >> Include hotplug and I'll be happier!  I know that's messy though.
>> >>
>> >> > Current memory tiering code has
>> >> > 1) memory_tier_init() to iterate through all boot onlined memory
>> >> > nodes. All nodes are assumed to be fast tier (adistance
>> >> > MEMTIER_ADISTANCE_DRAM is used).
>> >> > 2) dev_dax_kmem_probe to iterate through all devdax controlled memo=
ry
>> >> > nodes. This is the place the kernel reads the memory attributes from
>> >> > HMAT and recognizes the memory nodes into the correct tier (devdax
>> >> > controlled CXL, pmem, etc).
>> >> > If we want DDRs with different memory characteristics to be put into
>> >> > the correct tier (as in the guest VM memory tiering case), we proba=
bly
>> >> > need a third path to iterate the boot onlined memory nodes and also=
 be
>> >> > able to read their memory attributes. I don't think we can do that =
in
>> >> > 1) because the ACPI subsystem is not yet initialized.
>> >>
>> >> Can we move it later in general?  Or drag HMAT parsing earlier?
>> >> ACPI table availability is pretty early, it's just that we don't both=
er
>> >> with HMAT because nothing early uses it.
>> >> IIRC SRAT parsing occurs way before memory_tier_init() will be called.
>> >
>> > I tested the call sequence under a debugger earlier. hmat_init() is
>> > called after memory_tier_init(). Let me poke around and see what our
>> > options are.
>>
>> This sounds reasonable.
>>
>> Please keep in mind that we need a way to identify the base line memory
>> type(default_dram_type).  A simple method is to use NUMA nodes with CPU
>> attached.  But I remember that Aneesh said that some NUMA nodes without
>> CPU will need to be put in default_dram_type too on their systems.  We
>> need a way to identify that.
>
> Yes, I am doing some prototyping the way you described. In
> memory_tier_init(), we will just set the memory tier for the NUMA
> nodes with CPU. In hmat_init(), I am trying to call back to mm to
> finish the memory tier initialization for the CPUless NUMA nodes. If a
> CPUless numa node can't get the effective adistance from
> mt_calc_adistance(), we will fallback to add that node to
> default_dram_type.

Sound reasonable for me.

> The other thing I want to experiment is to call mt_calc_adistance() on
> a memory node with CPU and see what kind of adistance will be
> returned.

Anyway, we need a base line to start.  The abstract distance is
calculated based on the ratio of the performance of a node to that of
default DRAM node.

--
Best Regards,
Huang, Ying

