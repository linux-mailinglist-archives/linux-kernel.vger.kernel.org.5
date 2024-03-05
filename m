Return-Path: <linux-kernel+bounces-91479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4187121E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D15285F06
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0608DDAD;
	Tue,  5 Mar 2024 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CS8Tnnrb"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1600FC2D0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599939; cv=none; b=DvhqPvG1DwIOP0/vCszloqXc73u7pIhzc7F9XEAA7/f2QwvSmsUPsiEvRUMXQKXRkBXDN/toUIM7fCUJ5AEraF7KSxJxT32eKGVvIMcqkazNx0CkwLdnAbewFTKIDEzty3Ys6XPwRHhrod44YikgRWM3PfUXj8weU2ZthWnJ4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599939; c=relaxed/simple;
	bh=nsSiKTT/7GjOD28FdpADOIytZU+0DEsF20GG9weny04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHhc2cU43/uOlzFkSVQ58/fC+1NUvo5S0Qk3a9aB+nl0omKFrEQ42wKwiC/g37L/cNEips9rXXswdSEVcRqK1gw85EO2yZmAmmAABxu1TXmIhy+bHQwR2Hq5UjNTw3RYPMn9CrJquBVDqqqOm9t60COKpfooMw2KKUXwddvmnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CS8Tnnrb; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-608ceccb5f4so32051297b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 16:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709599936; x=1710204736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bC8009vmqmxkhn+08ky/9wZeeVCG5n7ZEqxpI0ezJCw=;
        b=CS8TnnrbhdcTcQSP4mmP6mbylg+16AozBl5C3FIy43XtRIrDWuWj+3d2uYahNGmT3t
         2elmuMlt0dxEQRmh30Eeax9y2EQhZcb6k9CU30KaTGUb/FUZNe494RX3ckdz6GfxcXwd
         TyoAD8zbDBzjpRtuP0wZ31qambRGODtzwu8sJ/oEInAC0DhgBn2UzwWQ9Qul6yzFajnj
         QEKlzpegRUTcZqXnaStrCy2K1ID1w8LMZDj61iDnBFjtRc1b8ZavsLKFquQM2guUszl/
         iwGdP44LaEDGaVHhj8zxs+IS7aeFqGxSvh9TPWD2hzK6qvhy0C8Zr6/XjwFXdA4LEpN/
         opPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599936; x=1710204736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bC8009vmqmxkhn+08ky/9wZeeVCG5n7ZEqxpI0ezJCw=;
        b=hUW7lmmJq5oK9l/pZMYQNldhPgXL0d481x/pmIUWF5jAzlg+Zbf6HklNX400vTCnb4
         zLvgD6oWlD+uRNP7uF6mO796gbzPBJkbPB+Szc9k4U+fBVvc9FKblA4MfPFUf7KfeO5W
         W/o9KlqlJyrPY0BMhRjBDKV8a/tjNPK+CgbaorfBHB9b0DReGTmHpw2xU/fFiy4x1AUs
         Y4vCtWtLLuemWWscMv8Ggd5KtTUlxigmotJ3S0GEhua2mQfjYr9N1iIvYuUxNzTOVzKi
         H8L0UjHY8bVQ3eGFVmBon5X7fZWE6+/w5coufcjBiNuapdh+5TLoihzFCF5GkqUt/crL
         /2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpQDojvHfBvl9ds1onIN7AN+zxOhhCsUPSMUkoFOe330bUE7DwINeTzZ7WOmxJuZC+rrVowlm9A1J0OTov5K8/21gCz6dH7diagDT3
X-Gm-Message-State: AOJu0Yw9EpIFNI1cIkRPPmoeuwSiAWVmRRzTo/rCQQFpxuIxFwTo452F
	zzZMTS516eLZ0hP/pCyOIqZWTvz4iGU40+ky4tnIubIKUfCLCnYq5+TxyDdN2Xqjv704AxG2Z7F
	u3JJzkG/AiBO8MLycb087BxPIPNd8GX5ASYo3
X-Google-Smtp-Source: AGHT+IGSxS2y2POIqf3HRmkfD2BbGxCH7Qt1wnRqTF8tBcoqt2Wk6FUF/CjHcakWKew/DFPazs4/eWilzuKakW0v8ZM=
X-Received: by 2002:a05:690c:fcb:b0:607:8c3e:1605 with SMTP id
 dg11-20020a05690c0fcb00b006078c3e1605mr11206179ywb.10.1709599935672; Mon, 04
 Mar 2024 16:52:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215111455.1462-1-shiju.jose@huawei.com> <65d6936952764_1138c7294e@dwillia2-xfh.jf.intel.com.notmuch>
 <54c55412e9374e4e9cacf8410a5a98cb@huawei.com> <65d8f5201f8cc_2509b29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240226102944.000070a3@Huawei.com> <65e0e046a165e_ca001294bc@dwillia2-xfh.jf.intel.com.notmuch>
 <20240301144153.0000133b@Huawei.com>
In-Reply-To: <20240301144153.0000133b@Huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 4 Mar 2024 16:52:03 -0800
Message-ID: <CACw3F50GZDYkW6kUNpB-M7wudzvEzCA8t-7E5M8F+FPDXQWRWg@mail.gmail.com>
Subject: Re: [RFC PATCH v6 00/12] cxl: Add support for CXL feature commands,
 CXL device patrol scrub control and DDR5 ECS control features
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Shiju Jose <shiju.jose@huawei.com>, "tony.luck@intel.com" <tony.luck@intel.com>, 
	Drew Walton <acwalton@google.com>, "duenwen@google.com" <duenwen@google.com>, 
	"rientjes@google.com" <rientjes@google.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>, 
	"alison.schofield@intel.com" <alison.schofield@intel.com>, 
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "david@redhat.com" <david@redhat.com>, 
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>, 
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>, 
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, 
	"james.morse@arm.com" <james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>, 
	"pgonda@google.com" <pgonda@google.com>, "mike.malvestuto@intel.com" <mike.malvestuto@intel.com>, 
	"gthelen@google.com" <gthelen@google.com>, 
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>, 
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>, tanxiaofei <tanxiaofei@huawei.com>, 
	"Zengtao (B)" <prime.zeng@hisilicon.com>, 
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>, 
	Linuxarm <linuxarm@huawei.com>, Vikram Sethi <vsethi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 6:42=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
>
> >
> > > > > Regarding RASF patrol scrub no one cared about it as it's useless=
 and
> > > > > any new implementation should be RAS2.
> > > >
> > > > The assertion that "RASF patrol scrub no one cared about it as it's
> > > > useless and any new implementation should be RAS2" needs evidence.
> > > >
> > > > For example, what platforms are going to ship with RAS2 support, wh=
at
> > > > are the implications of Linux not having RAS2 scrub support in a mo=
nth,
> > > > or in year? There are parts of the ACPI spec that have never been
> > > > implemented what is the evidence that RAS2 is not going to suffer t=
he
> > > > same fate as RASF?
> > >
> > > From discussions with various firmware folk we have a chicken and egg
> > > situation on RAS2. They will stick to their custom solutions unless t=
here is
> > > plausible support in Linux for it - so right now it's a question mark
> > > on roadmaps. Trying to get rid of that question mark is why Shiju and=
 I
> > > started looking at this in the first place. To get rid of that questi=
on
> > > mark we don't necessarily need to have it upstream, but we do need
> > > to be able to make the argument that there will be a solution ready
> > > soon after they release the BIOS image.  (Some distros will take year=
s
> > > to catch up though).
> > >
> > > If anyone else an speak up on this point please do. Discussions and
> > > feedback communicated to Shiju and I off list aren't going to
> > > convince people :(
> > > Negatives perhaps easier to give than positives given this is seen as
> > > a potential feature for future platforms so may be confidential.
> >
> > So one of the observations from efforts like RAS API [1] is that CXL is
> > definining mechanisms that others are using for non-CXL use cases. I.e.
> > a CXL-like mailbox that supports events is a generic transport that can
> > be used for many RAS scenarios not just CXL endpoints. It supplants
> > building new ACPI interfaces for these things because the expectation i=
s
> > that an OS just repurposes its CXL Type-3 infrastructure to also drive
> > event collection for RAS API compliant devices in the topology.

Thanks Dan for bringing up [1]. After sending out [2], the proposal of
an in-kernel "memory scrubber" implemented in **software**, I actually
paid more attention to the hardware patro scrubber given it is (at
least should be) programmable in runtime with RASF and RAS2 as
HORIGUCHI pointed out[3]. The idea is, if hardware patrol scrubber can
become as flexible as software, why let the software waste the CPU
cycles and membw? Then I attempted to
1. define the features required to scrub memory efficiently and flexibly
2. get that list of features **standardized** by engaging hw vendors
who make patrol scrubbers in their chips
3. design a Linux interface so that user space can drive **both
software and hardware scrubber** (Turns out software scrubber still
has an advantage over hardware and I will cover it later.)

[2] https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.co=
m/
[3] https://lore.kernel.org/all/20221109050425.GA527418@hori.linux.bs1.fc.n=
ec.co.jp/

The difference between my work and Shiju+Jonathan's RFC is: taking a
bet on RAS2, #1 and #2 is not a problem for them.

I am under the impression that RAS2 is probably going to suffer from
RASF, but at least I hope Shiju/Jonanthan's API can be compatible with
the sw scrubber that I planned to upstream (made some suggestions[4]
for this purpose).

[4] https://lore.kernel.org/linux-mm/CACw3F539gZc0FoJLo6VvYSyZmeWZ3Pbec7Azs=
H+MYUJJNzQbUQ@mail.gmail.com/

**However**, ...

> >
> > [1]: https://www.opencompute.org/w/index.php?title=3DRAS_API_Workstream

.. our hardware RAS team (better expert on fault management and hw
reliability) strongly pushed back some of my proposed feature list and
pointed me exactly to [1].

From my understanding after talking to our RAS people, Open Compute
RAS API is the future to move on. Meanwhile everyone should probably
start to forget about RAS2. The memory interleave issue [5] in RASF
seemed to be carried over to RAS2, making vendors reluctant to adopt.

[5] https://lore.kernel.org/all/SJ1PR11MB6083BF93E9A88E659CED5EC4FC3F9@SJ1P=
R11MB6083.namprd11.prod.outlook.com/

> >
> > So when considering whether Linux should build support for ACPI RASF,
> > ACPI RAS2, and / or Open Compute RAS API it is worthwile to ask if one
> > of those can supplant the others.

I think Open Compute RAS API and RAS2/RASF are probably *incompatible*
from their core. Open Compute RAS API "will likely block any OS access
to the patrol scrubber", in the context of Open Compute RAS API's out
of band solution. While userspace has the need to use patrol scrubber,
"the OS doesn't understand memory enough to drive it".

Taking STOP_PATROL_SCRUBBER as example, while it may make sense to
users, stopping patrol scrubber is unacceptable for platform where OEM
has enabled patrol scrubber, because the patrol scrubber is a key part
of logging and is repurposed for other RAS actions. So from Open
Compute RAS API's perspective, STOP_PATROL_SCRUBBER from RAS2 must be
blocked and, tbh must not be exposed to OS/userspace at all.
"Requested Address Range"/"Actual Address Range" (region to scrub) is
a similarly bad thing to expose in RAS2.

But I am still seeking a common ground between Open Compute RAS API
and my feature wishlist of flexible and efficient patrol scrubber, by
taking a step back and ...

>
> RAS API is certainly interesting but the bit of the discussion
> that matters here will equally apply to CXL RAS controls as of today
> (will ship before OCP) and Open Compute's RAS API (sometime in the future=
).
>
> The subsystem presented here was to address the "show us your code" that
> was inevitable feedback if we'd gone for a discussion Doc style RFC.
>
> What really matters here is whether a common ABI is necessary and what
> it looks like.
> Not even the infrastructure, just whether it's sysfs and what the control=
s)
> Sure there is less code if it all looks like that CXL get feature,
> but not that much less.  + I'm hoping we'll also end up sharing with
> the various embedded device solutions out there today.
>
> I notice a few familiar names in the meeting recordings. Anyone want
> to provide a summary of overlap etc and likely end result?
> I scan read the docs and caught up with some meetings at high speed,
> but that's not the same as day to day involvement in the spec development=
.
> Maybe the lesson to take away from this is a more general interface is
> needed incorporating scrub control (which at this stage is probably
> just a name change!)
>
> I see that patrol scrub is on the RAS actions list which is great.
>
> >
> > Speaking only for myself with my Linux kernel maintainer hat on, I am
> > much more attracted to proposals like RAS API where native drivers can
> > be deployed vs ACPI which brings ACPI static definition baggage and a
> > 3rd component to manage. RAS API is kernel driver + device-firmware
> > while I assume ACPI RAS* is kernel ACPI driver + BIOS firmware +
> > device-firmware.
>
> Not really. The only thing needed from BIOS firmware is a static table
>  to OS to describe where to find the hardware (RAS2 is a header and (1+)
> pointers to the PCCT table entry that tells you where the mailbox(s)
> (PCC Channel) are and their interrupts etc.  It's all of 48 bytes of
> static data to parse.
>
> Could have been done that in DSDT (where you will find other PCC channels
> as many methods can use them under the hood to chat to firmware + there
> are some other users where they are the only option) but my guess is
> assumption is RAS might be needed pre AML interpreter so it's a static ta=
ble.
>
> A PCC channel is the ACPI spec standard mailbox design (well several
> options for how to do it, but given the code is upstream and in use
> for other purposes, no new maintenance burden for us :)
> PCC channels can be shared resources handling multiple protocols.
> They are used for various other things where the OS needs
> to talk to firmware and have been upstream for a while.
>
>
> ACPI driver --------<PCC Mailbox>---> Device Firmware
> vs
> RAS API Driver-----<CXL Mailbox>----> Device Firmware
> or
> CXL Driver --------<CXL Mailbox>----> Device Firmware
>
> The new complexity (much like the CXL solution) lies in the
> control protocol sent over the mailbox (which is pretty simple!)
>
> Some of the complexity in the driver is left over from earlier
> version doing RASF and RAS2 so we'll flatten that layering out
> and it'll be even simpler in next RFC and perhaps not hint at
> false complexity or maintenance burden.
>
> The only significant burden I really see form incorporating RAS2
> is the need for an interface that works for both (very similar)
> configuration control sets.  Once that is defined we need to support
> the ABI for ever anyway so may be sysfs attribute of extra ABI to
> support in current design?
>
>
> >
> > In other words, this patch proposal enables both CXL memscrub and ACPI
> > RAS2 memscrub. It asserts that nobody cares about ACPI RASF memscrub,
> > and your clarification asserts that RAS2 is basically dead until Linux
> > adopts it. So then the question becomes why should Linux breath air int=
o
> > the ACPI RAS2 memscrub proposal when initiatives like RAS API exist?
>
> A fair question and one where I'm looking for inputs from others.
>
> However I think you may be assuming a lot more than is actually
> involved in the RAS2 approach - see below.
>
> >
> > The RAS API example seems to indicate that one way to get scrub support
> > for non-CXL memory controllers would be to reuse CXL memscrub
> > infrastructure. In a world where there is kernel mechanism to understan=
d
> > CXL-like scrub mechanisms, why not nudge the industry in that direction
> > instead of continuing to build new and different ACPI mechanisms?
>
> There may be some shared elements of course (and it seems the RAS API
> stuff has severak sets of proposals for interfacing approaches), but ulti=
mately
> a RAS API element still hangs off something that isn't a CXL device, so
> still demands some common infrastructure (e.g. a class or similar) or
> we are going to find the RAS tools buried under a bunch of different indi=
vidual
> drivers.
> 1) Maybe shared for system components (maybe not from some of the diagram=
s!)
>    But likely 1 interface per socket. Probably PCI, but maybe platform de=
vices
>    (I'd not be surprised to see a PCC channel type added for this mailbox=
)
>    /sys/bus/pci/devices/pcixxx/rasstuff/etc
> 2) CXL devices say /sys/bus/cxl/devices/mem0/rasstuff/etc.
> 3) Other system components such as random PCI drivers.
>
> Like other cases of common infrastructure, I'd argue for a nice class wit=
h
> the devices parentage linking back to the underlying EP driver.
> /sys/class/ras/ras0 parent ->   /sys/bus/cxl/devices/mem0/
> /sys/class/ras/ras1 parent ->   /sys/bus/pci/device/pcixxx/ RAS API devic=
e.
> etc
>
> Same as if we had a bunch of devices that happened to have an LED on them
> and wanted common userspace controls so registered with /sys/class/led
>
> So to me RAS API looks like another user of this proposal that indeed
> shares a bunch of common code with the CXL driver stack (hopefully they'l=
l
> move to PCI MMPT from current definition based on CXL 2.0 mailbox so the
> discoverability isn't CXL spec based. (I may not have latest version of c=
ourse!)
>
> >
> > > > There are parts of the CXL specification that have
> > > > never been implemented in mass market products.
> > >
> > > Obviously can't talk about who was involved in this feature
> > > in it's definition, but I have strong confidence it will get implemen=
ted
> > > for reasons I can point at on a public list.
> > > a) There will be scrubbing on devices.
> > > b) It will need control (evidence for this is the BIOS controls menti=
oned below
> > >    for equivalent main memory).
> > > c) Hotplug means that control must be done by OS driver (or via very =
fiddly
> > >    pre hotplug hacks that I think we can all agree should not be nece=
ssary
> > >    and aren't even an option on all platforms)
> > > d) No one likes custom solutions.
> > > This isn't a fancy feature with a high level of complexity which help=
s.
> >
> > That does help, it would help even more if the maintenance burden of CX=
L
> > scrub precludes needing to carry the burden of other implementations.
>
> I think we disagree on whether the burden is significant - sure
> we can spin interfaces differently to make it easier for CXL and we can
> just stick it on the individual endpoints for now.
>
> Key here is ABI, I don't really care about whether we wrap it up in a sub=
system
> (mostly we do that to enforce compliance with the ABI design as easier th=
an
>  reviewing against a document!)
>
> I want to see userspace ABI that is general enough to extend to other
> devices and doesn't require a horrible hydra of a userspace program on to=
p
> of incompatible controls because everyone wanted to do it slightly
> differently.  The exercise of including RAS2 (and earlier RASF which
> we dropped) was about establishing commonality and I think that was very
> useful.
>
> I'm reluctant to say it will never be necessary to support RAS2 (because
> I want to see solutions well before anyone will have built OCPs proposal
> and RAS2 works on many of today's systems with a small amount of firmware
> work, many have existing PCC channels to appropriate management controlle=
rs
> and as I understand it non standard interfaces to control the scrubbing
> engines).
>
> So I think not considering an ABI that is designed to be general is just
> storing up pain for us in the future.

considering user demands. In the end hardware is implemented to
fulfill buyer's needs. I think I should just ask for both
valuable-to-customer and compatible-with-"Open Compute RAS API"
features and drop others (for example, stop is dropped). Given my role
in cloud provider, I wanted to start with two key features:
* Adjust the speed of the scrubbing within vendor defined range.
Adding to Jonathan's reply[6] to Tony, in cloud only the control brain
of the fleet running in userspace or remote knows when performance is
important (a customer VM is present on the host) and when reliability
is important (host is idle but should be well-prepared to serve
customers without memory errors).
* Granularity. Per memory controller control granularity is
unrealistic. How about per NUMA node? Starting with a whole host is
also acceptable right now.

Does these 2 feature requests make sense to people here, and should be
covered by Open Compute RAS API (if they are not)? If both are, then
#1 and #2 are solved by Open Compute RAS API and kernel developer can
start to design OS API.

[6] https://lore.kernel.org/linux-mm/20240220111423.00003eae@Huawei.com/T/#=
m8d0b0737e2e5704529cc13b55008710a928b62b8

>
> I'm not sure the design we have here is the right one which is why it
> was an RFC :)
>
> >
> > [..]
> > > >
> > > > > Previous discussions in the community about RASF and scrub could =
be find here.
> > > > > https://lore.kernel.org/lkml/20230915172818.761-1-shiju.jose@huaw=
ei.com/#r
> > > > > and some old ones,
> > > > > https://patchwork.kernel.org/project/linux-arm-kernel/patch/CS1PR=
84MB0038718F49DBC0FF03919E1184390@CS1PR84MB0038.NAMPRD84.PROD.OUTLOOK.COM/
> > > > >
> > > >
> > > > Do not make people hunt for old discussions, if there are useful po=
ints
> > > > in that discussion that make the case for the patch set include tho=
se in
> > > > the next submission, don't make people hunt for the latest state of=
 the
> > > > story.
> > >
> > > Sure, more of an essay needed along with links given we are talking
> > > about the views of others.
> > >
> > > Quick summary from a reread of the linked threads.
> > > AMD not implemented RASF/RAS2 yet - looking at it last year, but worr=
ied
> > > about inflexibility of RAS2 spec today. They were looking at some spe=
c
> > > changes to improve this + other functions to be added to RAS2.
> > > I agree with it being limited, but think extending with backwards
> > > compatibility isn't a problem (and ACPI spec rules in theory guarante=
e
> > > it won't break).  I'm keen on working with current version
> > > so that we can ensure the ABI design for CXL encompasses it.
> > >
> > > Intel folk were cc'd but not said anything on that thread, but Tony L=
uck
> > > did comment in Jiaqi Yan's software scrubbing discussion linked below=
.
> > > He observed that a hardware implementation can be complex if doing ra=
nge
> > > based scrubbing due to interleave etc. RAS2 and CXL both side step th=
is
> > > somewhat by making it someone elses problem. In RAS2 the firmware get=
s
> > > to program multiple scrubbers to cover the range requested. In CXL
> > > for now this leaves the problem for userspace, but we can definitely
> > > consider a region interface if it makes sense.
> > >
> > > I'd also like to see inputs from a wider range of systems folk + othe=
r
> > > CPU companies.  How easy this is to implement is heavily dependent on
> > > what entity in your system is responsible for this sort of runtime
> > > service and that varies a lot.
> >
> > This answers my main question of whether RAS2 is a done deal with
> > shipping platforms making it awkward for Linux to *not* support RAS2, o=
r
> > if this is the start of an industry conversation that wants some Linux
> > ecosystem feedback. It sounds more like the latter.
>
> I'll let others speak up on this as I was presenting on my current outloo=
k
> and understand others are much further down the path.
>
> >
> > > > > https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@goo=
gle.com/

Last thing about the advantage of the above in-kernel "software
scrubber" vs hardware patrol scrubber. A better way to prevent +
detect memory errors is do a write, followed by a read op. The write
op is very difficult, if not impossible, to be fulfilled by hardware
patrol scrubber at **OS runtime** (during boot time as some sort of
memory test is possible); there must be some negotiations with
userspace. The hw won't even know if a page is free to write (not used
by anything in OS). But I think this write-read-then-check idea is
feasible in the software scrubber. That's why I want a general memory
scrub kernel API for both software and patrol scrubber.

> > > >
> > > > Yes, now that is a useful changelog, thank you for highlighting it,
> > > > please follow its example.
> > >
> > > It's not a changelog as such but a RFC in text only form.

Hopefully the software solution can still be attractive to upstream
after people now pay more attention to the hardware solution (and I
hope to send out new RFC with code).

> > > However indeed lots of good info in there.
> > >
> > > Jonathan
> >
> > Thanks again for taking the time Jonathan.
> >
> You are welcome and thanks for all the questions / pointers.
>
> Jonathan
>
>

Thanks,
Jiaqi

