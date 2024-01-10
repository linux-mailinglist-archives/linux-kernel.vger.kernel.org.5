Return-Path: <linux-kernel+bounces-22661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9563482A10E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DB91F2397E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9354EB33;
	Wed, 10 Jan 2024 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WvQqHhrA"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE84E1CD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5585fe04266so1043627a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704914966; x=1705519766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XF/kkrIsaG794mVwrrAfpZE9995QUYT1bMP4o8ReX7Q=;
        b=WvQqHhrARPDegULMf10+YOiuYdEb2EPK7z5S38HyCs3NtQmfXDevGtYsZlw+hSaESo
         V4N8UACkXj5xUauBJRspcEevoPcdnOrN1DCqUMV020H42NnfJ1w++Wf9y09JO6Seppxc
         6MmwPbG30riRLNmjIEBb3dH+y5QjQNybsnKIn/LkWE8kGy4MPIelqX73ek1Wux3fgP8k
         /OIkbAlc9pjJ4VovD2Ay2lMdjA17TZVSeHgAW1XAH+esJOm5VQonxZY58V5jgqo32M/Q
         YAeElTeEVaQFXdbDi+PyISNnkgFvraFP6qSRiKZKc8LVPnrlZ6Tg7U5zhG8tGkITxf9K
         /tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704914966; x=1705519766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XF/kkrIsaG794mVwrrAfpZE9995QUYT1bMP4o8ReX7Q=;
        b=LOo0HG8PB4fG0VZhFYuwbT5FdwH4WbO+XDW8jMR5pO5O0BlMJKcn6PmTTeudow95Ep
         2Fg1HWQZ7h/fViu84/+jz2lj9MbvQi4Bwh7PKH82w2F3GF47E9gedvDkfRGGgOLCc4jg
         hnlL5CYTj2gKVdFg9HhWp/pt4Wd0p6pEtzLMjnggPOsKD8m8K+g2kvvdThx/GbLvJnAG
         +xaxljy5U7qncmzWETfk4CQl4Skadxf9RkMw1dLeEG/N/eWE0GuuISx93BoMX9CxTO3Y
         of0Tu76p5n+5mgRC9Vbtk9V7EPDoSnJlyVtx0O1SQWRIYGxON4sA0ytiiVSsBknojMRx
         zFkQ==
X-Gm-Message-State: AOJu0Yzl3DsksIged2S/P3hCJQyRVpfF1oEsQmuoZgt9iKQ3WeXdjsIU
	6rEk+YYIflA5CJguRpReSWZeTBzA3ZCobklIo46Lpc+cDd7XsA==
X-Google-Smtp-Source: AGHT+IGvbQcEEgvmp16OVS1C36qH64KspcuiSNtSm+dV5L85ETMA6+jldtw2mOoqiHwjDJy0RzCb258FX3Elz9K8krs=
X-Received: by 2002:a17:907:9606:b0:a28:9d4e:f065 with SMTP id
 gb6-20020a170907960600b00a289d4ef065mr16815ejc.13.1704914966385; Wed, 10 Jan
 2024 11:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com> <PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87a5pmddl5.fsf@yhuang6-desk2.ccr.corp.intel.com> <PH0PR08MB79552F35351FA57EF4BD64B4A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87wmspbpma.fsf@yhuang6-desk2.ccr.corp.intel.com> <ZZwrIoP9+ey7rp3C@memverge.com>
 <87o7dv897s.fsf@yhuang6-desk2.ccr.corp.intel.com> <20240109155049.00003f13@Huawei.com>
 <ZZ2Jd7/7rFD0o5S3@memverge.com> <CAAYibXhe81ez06tP5K7zGkX9P=Ot+DcSysVyDvh13aSEDD63aA@mail.gmail.com>
 <20240110141821.0000370d@Huawei.com>
In-Reply-To: <20240110141821.0000370d@Huawei.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Wed, 10 Jan 2024 11:29:14 -0800
Message-ID: <CAAYibXgwqY6Og_4NqGGEni=2Xgx=DPxaMc3GdBUE6FREKVCq8w@mail.gmail.com>
Subject: Re: [External] Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration
 between memory tiers
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gregory Price <gregory.price@memverge.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Srinivasulu Thanneeru <sthanneeru@micron.com>, Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>, 
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"tj@kernel.org" <tj@kernel.org>, "john@jagalactic.com" <john@jagalactic.com>, 
	Eishan Mirakhur <emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>, 
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Wei Xu <weixugc@google.com>, "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 6:18=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 9 Jan 2024 16:28:15 -0800
> Hao Xiang <hao.xiang@bytedance.com> wrote:
>
> > On Tue, Jan 9, 2024 at 9:59=E2=80=AFAM Gregory Price <gregory.price@mem=
verge.com> wrote:
> > >
> > > On Tue, Jan 09, 2024 at 03:50:49PM +0000, Jonathan Cameron wrote:
> > > > On Tue, 09 Jan 2024 11:41:11 +0800
> > > > "Huang, Ying" <ying.huang@intel.com> wrote:
> > > > > Gregory Price <gregory.price@memverge.com> writes:
> > > > > > On Thu, Jan 04, 2024 at 02:05:01PM +0800, Huang, Ying wrote:
> > > > > It's possible to change the performance of a NUMA node changed, i=
f we
> > > > > hot-remove a memory device, then hot-add another different memory
> > > > > device.  It's hoped that the CDAT changes too.
> > > >
> > > > Not supported, but ACPI has _HMA methods to in theory allow changin=
g
> > > > HMAT values based on firmware notifications...  So we 'could' make
> > > > it work for HMAT based description.
> > > >
> > > > Ultimately my current thinking is we'll end up emulating CXL type3
> > > > devices (hiding topology complexity) and you can update CDAT but
> > > > IIRC that is only meant to be for degraded situations - so if you
> > > > want multiple performance regions, CDAT should describe them form t=
he start.
> > > >
> > >
> > > That was my thought.  I don't think it's particularly *realistic* for
> > > HMAT/CDAT values to change at runtime, but I can imagine a case where
> > > it could be valuable.
> > >
> > > > > > https://lore.kernel.org/linux-cxl/CAAYibXjZ0HSCqMrzXGv62cMLncS_=
81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com/
> > > > > >
> > > > > > This group wants to enable passing CXL memory through to KVM/QE=
MU
> > > > > > (i.e. host CXL expander memory passed through to the guest), an=
d
> > > > > > allow the guest to apply memory tiering.
> > > > > >
> > > > > > There are multiple issues with this, presently:
> > > > > >
> > > > > > 1. The QEMU CXL virtual device is not and probably never will b=
e
> > > > > >    performant enough to be a commodity class virtualization.
> > > >
> > > > I'd flex that a bit - we will end up with a solution for virtualiza=
tion but
> > > > it isn't the emulation that is there today because it's not possibl=
e to
> > > > emulate some of the topology in a peformant manner (interleaving wi=
th sub
> > > > page granularity / interleaving at all (to a lesser degree)). There=
 are
> > > > ways to do better than we are today, but they start to look like
> > > > software dissagregated memory setups (think lots of page faults in =
the host).
> > > >
> > >
> > > Agreed, the emulated device as-is can't be the virtualization device,
> > > but it doesn't mean it can't be the basis for it.
> > >
> > > My thought is, if you want to pass host CXL *memory* through to the
> > > guest, you don't actually care to pass CXL *control* through to the
> > > guest.  That control lies pretty squarely with the host/hypervisor.
> > >
> > > So, at least in theory, you can just cut the type3 device out of the
> > > QEMU configuration entirely and just pass it through as a distinct nu=
ma
> > > node with specific hmat qualities.
> > >
> > > Barring that, if we must go through the type3 device, the question is
> > > how difficult would it be to just make a stripped down type3 device
> > > to provide the informational components, but hack off anything
> > > topology/interleave related? Then you just do direct passthrough as y=
ou
> > > described below.
> > >
> > > qemu/kvm would report errors if you tried to touch the naughty bits.
> > >
> > > The second question is... is that device "compliant" or does it need
> > > super special handling from the kernel driver :D?  If what i describe=
d
> > > is not "compliant", then it's probably a bad idea, and KVM/QEMU shoul=
d
> > > just hide the CXL device entirely from the guest (for this use case)
> > > and just pass the memory through as a numa node.
> > >
> > > Which gets us back to: The memory-tiering component needs a way to
> > > place nodes in different tiers based on HMAT/CDAT/User Whim. All thre=
e
> > > of those seem like totally valid ways to go about it.
> > >
> > > > > >
> > > > > > 2. When passing memory through as an explicit NUMA node, but no=
t as
> > > > > >    part of a CXL memory device, the nodes are lumped together i=
n the
> > > > > >    DRAM tier.
> > > > > >
> > > > > > None of this has to do with firmware.
> > > > > >
> > > > > > Memory-type is an awful way of denoting membership of a tier, b=
ut we
> > > > > > have HMAT information that can be passed through via QEMU:
> > > > > >
> > > > > > -object memory-backend-ram,size=3D4G,id=3Dram-node0 \
> > > > > > -object memory-backend-ram,size=3D4G,id=3Dram-node1 \
> > > > > > -numa node,nodeid=3D0,cpus=3D0-4,memdev=3Dram-node0 \
> > > > > > -numa node,initiator=3D0,nodeid=3D1,memdev=3Dram-node1 \
> > > > > > -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-=
type=3Daccess-latency,latency=3D10 \
> > > > > > -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-=
type=3Daccess-bandwidth,bandwidth=3D10485760 \
> > > > > > -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-=
type=3Daccess-latency,latency=3D20 \
> > > > > > -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-=
type=3Daccess-bandwidth,bandwidth=3D5242880
> > > > > >
> > > > > > Not only would it be nice if we could change tier membership ba=
sed on
> > > > > > this data, it's realistically the only way to allow guests to a=
ccomplish
> > > > > > memory tiering w/ KVM/QEMU and CXL memory passed through to the=
 guest.
> > > >
> > > > This I fully agree with.  There will be systems with a bunch of nor=
mal DDR with different
> > > > access characteristics irrespective of CXL. + likely HMAT solutions=
 will be used
> > > > before we get anything more complex in place for CXL.
> > > >
> > >
> > > Had not even considered this, but that's completely accurate as well.
> > >
> > > And more discretely: What of devices that don't provide HMAT/CDAT? Th=
at
> > > isn't necessarily a violation of any standard.  There probably could =
be
> > > a release valve for us to still make those devices useful.
> > >
> > > The concern I have with not implementing a movement mechanism *at all=
*
> > > is that a one-size-fits-all initial-placement heuristic feels gross
> > > when we're, at least ideologically, moving toward "software defined m=
emory".
> > >
> > > Personally I think the movement mechanism is a good idea that gets fo=
lks
> > > where they're going sooner, and it doesn't hurt anything by existing.=
 We
> > > can change the initial placement mechanism too.
> >
> > I think providing users a way to "FIX" the memory tiering is a backup
> > option. Given that DDRs with different access characteristics provide
> > the relevant CDAT/HMAT information, the kernel should be able to
> > correctly establish memory tiering on boot.
>
> Include hotplug and I'll be happier!  I know that's messy though.
>
> > Current memory tiering code has
> > 1) memory_tier_init() to iterate through all boot onlined memory
> > nodes. All nodes are assumed to be fast tier (adistance
> > MEMTIER_ADISTANCE_DRAM is used).
> > 2) dev_dax_kmem_probe to iterate through all devdax controlled memory
> > nodes. This is the place the kernel reads the memory attributes from
> > HMAT and recognizes the memory nodes into the correct tier (devdax
> > controlled CXL, pmem, etc).
> > If we want DDRs with different memory characteristics to be put into
> > the correct tier (as in the guest VM memory tiering case), we probably
> > need a third path to iterate the boot onlined memory nodes and also be
> > able to read their memory attributes. I don't think we can do that in
> > 1) because the ACPI subsystem is not yet initialized.
>
> Can we move it later in general?  Or drag HMAT parsing earlier?
> ACPI table availability is pretty early, it's just that we don't bother
> with HMAT because nothing early uses it.
> IIRC SRAT parsing occurs way before memory_tier_init() will be called.

I tested the call sequence under a debugger earlier. hmat_init() is
called after memory_tier_init(). Let me poke around and see what our
options are.

>
> Jonathan
>
>
>
> >
> > >
> > > </2cents>
> > >
> > > ~Gregory
>

