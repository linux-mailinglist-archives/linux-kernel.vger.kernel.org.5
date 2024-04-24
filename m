Return-Path: <linux-kernel+bounces-157055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EF18B0C45
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72166285EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222EB15D5CF;
	Wed, 24 Apr 2024 14:16:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893441E4A9;
	Wed, 24 Apr 2024 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968188; cv=none; b=iyjw6ZdTyTFrBaG/q7kxu/SWAe/iFRqOxPAfC98uYfgOp51TD8S1tYr55Ip7q1ftscZ75usFqy6zDYHYdjYtocztsTYbrl8kKVzSb7ZkflifMbKh4p7oP+oOnrUZmOfF6fET6AWpUlUMOhR2G7zwvmQfEjkgizF5rtrZ0PvI63I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968188; c=relaxed/simple;
	bh=+qaZMJCT4ezZ83UFCEjqAssZXMmkNoIv7Xr9FHreMNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxgg302PVp8823RjmY8vJpcItLb8QBxKrfsL1uXnLR/Y2Pnpnj5A5QGNSwVMurw/b4qmpPPWgkUWOsntKYdERTaKxj4kLOnxfP0eYrrYR9UHvA8yvru8dgchoqAujF7k8LvgkwU2j1F8WnM8gpORaTRBuEpICT2iMgdqjr0LIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64125113E;
	Wed, 24 Apr 2024 07:16:53 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 825383F7BD;
	Wed, 24 Apr 2024 07:16:21 -0700 (PDT)
Date: Wed, 24 Apr 2024 15:16:12 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Moger, Babu" <babu.moger@amd.com>,
	Peter Newman <peternewman@google.com>, corbet@lwn.net,
	fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
	tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
	kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
	jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
	rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
	jithu.joseph@intel.com, kai.huang@intel.com,
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com,
	pbonzini@redhat.com, sandipan.das@amd.com,
	ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	eranian@google.com, james.morse@arm.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
Message-ID: <ZikULOsS+AtXaeQG@e133380.arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <CALPaoCheW=Jz2R3gMKcgwQe6ONDrRqu3tUxeg=A3USg6BC8buA@mail.gmail.com>
 <7ccd59b8-9fe3-4d1f-82f5-f33d96dbf5ac@amd.com>
 <ZiaRewZJnLaDSx3m@e133380.arm.com>
 <004dcaeb-30ae-4b27-895a-4025a670fcbf@amd.com>
 <ZierjRNDMfg5swT8@e133380.arm.com>
 <a5029ad6-3e5e-46bf-881f-950a8a393956@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5029ad6-3e5e-46bf-881f-950a8a393956@intel.com>

On Tue, Apr 23, 2024 at 09:15:07PM -0700, Reinette Chatre wrote:
> 
> 
> On 4/23/2024 5:37 AM, Dave Martin wrote:
> > On Mon, Apr 22, 2024 at 03:44:26PM -0500, Moger, Babu wrote:
> >> Hi Dave,
> >>
> >> On 4/22/24 11:34, Dave Martin wrote:
> >>> Hi Babu,
> >>>
> >>> On Thu, Apr 04, 2024 at 03:02:45PM -0500, Moger, Babu wrote:
> >>>> Hi Peter,
> >>>>
> >>>>
> >>>> On 4/4/24 14:08, Peter Newman wrote:
> >>>>> Hi Babu,
> >>>>>
> >>>>> On Thu, Mar 28, 2024 at 6:07 PM Babu Moger <babu.moger@amd.com> wrote:
> >>>>>>    The list follows the following format:
> >>>>>>
> >>>>>>        * Default CTRL_MON group:
> >>>>>>                "//<domain_id>=<assignment_flags>"
> >>>>>>
> >>>>>>        * Non-default CTRL_MON group:
> >>>>>>                "<CTRL_MON group>//<domain_id>=<assignment_flags>"
> >>>>>>
> >>>>>>        * Child MON group of default CTRL_MON group:
> >>>>>>                "/<MON group>/<domain_id>=<assignment_flags>"
> >>>>>>
> >>>>>>        * Child MON group of non-default CTRL_MON group:
> >>>>>>                "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
> >>>>>>
> >>>>>>        Assignment flags can be one of the following:
> >>>>>>
> >>>>>>         t  MBM total event is assigned
> >>>>>>         l  MBM local event is assigned
> >>>>>>         tl Both total and local MBM events are assigned
> >>>>>>         _  None of the MBM events are assigned
> >>>>>>
> >>>>>>         Examples:
> >>>>>>
> >>>>>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> >>>>>>         non_defult_group//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> >>>>>>         non_defult_group/non_default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> >>>>>>         //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> >>>>>>         /default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> >>>>>>
> >>>>>>         There are four groups and all the groups have local and total event assigned.
> >>>>>>
> >>>>>>         "//" - This is a default CONTROL MON group
> >>>>>>
> >>>>>>         "non_defult_group//" - This is non default CONTROL MON group
> >>>>>>
> >>>>>>         "/default_mon1/"  - This is Child MON group of the defult group
> >>>>>>
> >>>>>>         "non_defult_group/non_default_mon1/" - This is child MON group of the non default group
> >>>>>>
> >>>>>>         =tl means both total and local events are assigned.
> >>>>>
> >>>>> I recall there was supposed to be a way to perform the same update on
> >>>>> all domains together so that it isn't tedious to not do per-domain
> >>>>
> >>>> Yes. Correct. Reinette suggested to have "no domains" means ALL the domains.
> >>>
> >>> Would "*" be more intuitive?
> >>
> >> We could. But I don't see the need for wildcard ("*") or ranges and
> >> complexity that comes with that.
> > 
> > For "*", I mean that this would just stand for "all cpus", not a generic
> > string match; apologies if I didn't make that clear.
> 
> (reading this by replacing "all cpus" with "all domains")
> 
> This sounds reasonable to me. It may indeed make the parsing simpler by
> not needing the ugly checks Babu mentioned in [1].
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/7ccd59b8-9fe3-4d1f-82f5-f33d96dbf5ac@amd.com/

Ack, I meant "all domains", sorry!

Note, should we try to detect things like:

	<resource>:0=fee;1=fie;*=foe;0=fum

.?

Either we treat conflicting assignments as an error, or we do them all
in the order specified, so that assignments on the right override those
on the left (which is what the schemata parsing in ctrlmondata.c:
parse_line() seems to do today if I understand the code correctly).

In the latter case,

	<resource>:*=fee;1=fie

would set all nodes except 1 to "fee", and node 1 to "fie", which might
be useful (or at least, convenient).

If we're worried about that being exposed as ABI and used by userspace,
we might want to disallow it explicitly.

Cheers
---Dave

