Return-Path: <linux-kernel+bounces-73491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDAE85C366
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCD628521E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C1377F35;
	Tue, 20 Feb 2024 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnCTH31E"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7D77A05
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452693; cv=none; b=WaZFgYYuuaNLFJ+2Heebd7u9y7L2HDVw7FO9qflOqjTrKUt+odcjgzv41OGQbG6Vp/Oc8apijD+npCCEo/9VojTyp+NnuBYdJrIVQj/92HDt5rvVzYoDBFdbbfQ8U7btXPlrATE9qw9jEjfu20N8xMU91O+HHTac1z4GOkzH154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452693; c=relaxed/simple;
	bh=Jcmd41pe+U9XHcdmhUbtas9UdvHEuh0spYTQz8UpyUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNQed4hV1M0YK4DVCi2MXfpvdGLZnquSXMq/f2ah90M0j1aKY7cO60NWWaUe0uURrhg7dIye0pOhOUDyqj73jgDr2GW7Xl72uimLtlWowjc/WAbb77cxHW6FdWizd2I7YsyCBu2ZqYKpcSoX0KE7yw4w5S6GQa9GB3F7GLM8Z1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnCTH31E; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42e0b1b11bbso11441cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708452689; x=1709057489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jcmd41pe+U9XHcdmhUbtas9UdvHEuh0spYTQz8UpyUA=;
        b=JnCTH31EW1sErmYLpxyI1r06n03jtH0v16CcFYA4HlEB2SvVmqKkP5plx9WzzjGpIX
         3ttdyplZ+z5+oI2cUvK5i06SsOoigA6yf1v/oRlcKyrY4xPCItfVfWvwxVpoPHD5IR1J
         +r+KShOntd5uvqu7+SgJFUnyA2bNKCqrdutV6WO4dcuqyA4eX4LRqledHbs0vVw9N0Y5
         igVVW79Qj3hlkN8UrzGHzR1SIZj2uAd9uoXtX/PJklOgInRTJqflrf1GvU5VsyI1SN27
         TG2CXBfRKzVU1TWPC3mS6t570juzqzj4bgcuX++iT6t/iraGVEBVeWdL0d2W7a4bY+Qq
         A6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452689; x=1709057489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jcmd41pe+U9XHcdmhUbtas9UdvHEuh0spYTQz8UpyUA=;
        b=Qh5DkBlcYLEOPZgl/0ELFctJ1o3IROhk/QAMP55NpuBSCHgRyU48O2kiBTgo48qaax
         ktunQ75kfTbQEER4MH2WIqGoiW+dqfmmSyooYlYbmg3QSjp1xOJe/IiM8/ZsQ5HQvp4S
         NYnyQwcOBMEUJxLk5Srbkt14YNmBZmqvEF/RDnLPHtQWC5o/8QBzFf5Gyh/SxSNmo+JW
         Aa5EdpIFRWmvx2TDhwhxmQZuPsjaZmCap1Jt40i3mmOwkvIFYZydYIjq5+6gfw0rDwif
         kSQ8QGaHwCw421MOaczPXjlkIeHI9MBHqvXPR/3Awoyff7HaLzNPbFKH3Lg2zRrCl5yV
         Y15w==
X-Forwarded-Encrypted: i=1; AJvYcCVr8B63qKwq9ZY2jBsJCYvOm93oIBEDo8B599zh3pj4q8z4myiSVBgN9OEpmnRsSKBGJpLnt9JROHOhtIH3XxkJWM4V/qmid2me1a2N
X-Gm-Message-State: AOJu0Yy4lm8Z7mb2SL0DNiLD9oTF4FE2OZ65TWlBckqXfSQ0I6rtV+FX
	AoUd8LyD42MDG9X+243iqMsv25G9lS1SRCsoTqa73B2opZiCs3MdKoh0rnjTVbNn80KMu8cuFyc
	MeRmZwIbNfjfJADRcMFhIh4++8WWofjgMvpm5
X-Google-Smtp-Source: AGHT+IGlg76R0nwEA2yY2wzV4IpwOT43FMC0yb3BteA2LG3l1hE4F8w2kpfFd2vla/JQ/eQi1ZteqYfyjDx2MHlp56g=
X-Received: by 2002:a05:622a:14cd:b0:42d:fe28:38e5 with SMTP id
 u13-20020a05622a14cd00b0042dfe2838e5mr607470qtx.20.1708452689417; Tue, 20 Feb
 2024 10:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201005720.235639-1-babu.moger@amd.com> <cover.1705688538.git.babu.moger@amd.com>
 <7c26af23-fa1e-4e01-8088-8fbd9be3d6f3@intel.com> <431d6ac4-53cb-2f73-3cda-22616df2f96a@amd.com>
 <4bb63a78-0d0d-47bc-ad65-558af8bc5519@intel.com> <51c60991-eb10-40e8-b3ab-676b92b0c662@amd.com>
 <CALPaoChhKJiMAueFtgCTc7ffO++S5DJCySmxqf9ZDmhR9RQapw@mail.gmail.com> <1a8c1cd6-a1ce-47a2-bc87-d4cccc84519b@arm.com>
In-Reply-To: <1a8c1cd6-a1ce-47a2-bc87-d4cccc84519b@arm.com>
From: Peter Newman <peternewman@google.com>
Date: Tue, 20 Feb 2024 10:11:18 -0800
Message-ID: <CALPaoCgNLtA7E2tgQZ6gmbZ=OF0nE0Lbi=1C7oR3F0wM4YRbjw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: James Morse <james.morse@arm.com>
Cc: babu.moger@amd.com, Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net, 
	fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com, 
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com, 
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com, kai.huang@intel.com, 
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com, 
	pbonzini@redhat.com, sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com, 
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

On Tue, Feb 20, 2024 at 7:21=E2=80=AFAM James Morse <james.morse@arm.com> w=
rote:
> On 16/02/2024 20:18, Peter Newman wrote:
> > On Thu, Feb 8, 2024 at 9:29=E2=80=AFAM Moger, Babu <babu.moger@amd.com>=
 wrote:
> >> On 2/5/24 16:38, Reinette Chatre wrote:
> >>> You have made it clear on several occasions that you do not intend to=
 support
> >>> domain level assignment. That may be ok but the interface you create =
should
> >>> not prevent future support of domain level assignment.
> >>>
> >>> If my point is not clear, could you please share how this interface i=
s able to
> >>> support domain level assignment in the future?
> >>>
> >>> I am starting to think that we need a file similar to the schemata fi=
le
> >>> for group and domain level monitor configurations.
> >>
> >> Something like this?
> >>
> >> By default
> >> #cat /sys/fs/resctrl/monitor_state
> >> default:0=3Dtotal=3Dassign,local=3Dassign;1=3Dtotal=3Dassign,local=3Da=
ssign
> >>
> >> With ABMC,
> >> #cat /sys/fs/resctrl/monitor_state
> >> ABMC:0=3Dtotal=3Dunassign,local=3Dunassign;1=3Dtotal=3Dunassign,local=
=3Dunassign
> >
> > The benefit from all the string parsing in this interface is only
> > halving the number of monitor_state sysfs writes we'd need compared to
> > creating a separate file for mbm_local and mbm_total. Given that our
> > use case is to assign the 32 assignable counters to read the bandwidth
> > of ~256 monitoring groups, this isn't a substantial gain to help us. I
> > think you should just focus on providing the necessary control
> > granularity without trying to consolidate writes in this interface. I
> > will propose an additional interface below to optimize our use case.
> >
> > Whether mbm_total and mbm_local are combined in the group directories
> > or not, I don't see why you wouldn't just repeat the same file
> > interface in the domain directories for a user needing finer-grained
> > controls.
>
> I don't follow why this has to be done globally. resctrl allows CLOSID to=
 have different
> configurations for different purposes between different domains (as long =
as tasks are
> pinned to CPUs). It feels a bit odd that these counters can't be consider=
ed as per-domain too.

Assigning to all domains at once would allow us to better parallelize
the resulting IPIs when we do need to iterate a small set of monitors
over a large list of groups.


> > I prototyped and tested the following additional interface for the
> > large-scale, batch use case that we're primarily concerned about:
> >
> > info/L3_MON/mbm_{local,total}_bytes_assigned
> >
> > Writing a whitespace-delimited list of mongroup directory paths does
>
> | mkdir /sys/fs/resctrl/my\ group
>
> string parsing in the kernel is rarely fun!

Hopefully restricting to a newline-delimited list will keep this fun
and easy then.

Otherwise if referring to many groups in a single write isn't a viable
path forward, I'll still need to find a way to address the
fs/syscall/IPI overhead of measuring the bandwidth of a large number
of groups.

>
>
> > the following:
> > 1. unassign all monitors for the given counter
> > 2. assigns a monitor to each mongroup referenced in the write
> > 3. batches per-domain register updates resulting from the assignments
> > into a single IPI for each domain
> >
> > This interface allows us to do less sysfs writes and IPIs on systems
> > with more assignable monitoring resources, rather than doing more.
> >
> > The reference to a mongroup when reading/writing the above node is the
> > resctrl-root-relative path to the monitoring group. There is probably
> > a more concise way to refer to the groups, but my prototype used
> > kernfs_walk_and_get() to locate each rdtgroup struct.
>
> If this file were re-used for finding where the monitors were currently a=
llocated, using
> the name would be a natural fit for building a path to un-assign one grou=
p.
>
>
> > I would also like to add that in the software-ABMC prototype I made,
> > because it's based on assignment of a small number of RMIDs,
> > assignment results in all counters being assigned at once. On
> > implementations where per-counter assignments aren't possible,
> > assignment through such a resource would be allowed to assign more
> > resources than explicitly requested.
> >
> > This would allow an implementation only capable of global assignment
>
> Do we know if this exists? Given the configurations have to be different =
for a domain, I'd
> be surprised if counter configuration is somehow distributed between doma=
ins.

It's currently only a proposal[1] for mitigating the context switch
overhead cost of soft RMIDs. I'm looking at the other alternative
first, though.


> > to assign resources to all groups when a non-empty string is written
> > to the proposed file nodes, and all resources to be unassigned when an
> > empty string is written. Reading back from the file nodes would tell
> > the user how much was actually assigned.
>
> What do you mean by 'how much', is this allow to fail early? That feels a=
 bit
> counter-intuitive. As this starts with a reset, if the number of counters=
 is known - it
> should be easy for user-space to know it can only write X tokens into tha=
t file.

I was referring to the operation assigning more groups than requested
if the implementation is only capable of a master enable/disable for
all monitoring: reading back would indicate that all monitoring groups
are in the assigned list.

There would otherwise be an interface telling the user how many
monitors can be assigned, so there's no reason to expect this
operation to fail, short of the user doing something silly like
deleting a group while it's concurrently being assigned.

-Peter

[1] https://lore.kernel.org/lkml/CALPaoCiRD6j_Rp7ffew+PtGTF4rWDORwbuRQqH2i-=
cY5SvWQBg@mail.gmail.com/

