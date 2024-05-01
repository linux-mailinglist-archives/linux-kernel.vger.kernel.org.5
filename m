Return-Path: <linux-kernel+bounces-165662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AECE8B8F31
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6728B22717
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0BA13A89C;
	Wed,  1 May 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZGi6Txe"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F632CA40
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585729; cv=none; b=FAHCHreIwfu4HDPHY4q5kJRtwiLxSSQJ2sDwCqC6PyWhDsDadM0Xd55QjJW3cvPoTQJ2c1SOdEUGuXT/EIoA2AbLUABRJPp5ijwXf52+of2k2BdANaHJbkN/+S1VKvW2VMwkSVFBs1ZlUzlB5QkKffzV2c4yWfOlbMj2SUrn+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585729; c=relaxed/simple;
	bh=/xGW7znOLdzOY0WX24JlnO885mm1taJeBbhKcj79fL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9uo9auBbcx3ng342By4KHCqDEfXBCyg84Nz6eqgDh7ybXaKDdBlgprjn3kPqTEZkHVhpxO189HaQv/WMRvG3lQ45KG9eW2E4JLilWNsGPysOhLeWtWsIkRr22nD5k8YbgQGYL4K8mpZha2Gdn55NYPPTLUqmJygfT2pMI7/H9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nZGi6Txe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ec76185cb3so15515ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714585727; x=1715190527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSgYxDDPLjqkX8EyBQbLQKb/QjqGOlLZGZqPCQdQNIo=;
        b=nZGi6Txe3RDM6m03ssJgMfzHAZYTN1/zew5x5MCEzAKtjeu51jmpoAUxAdujUyS9OQ
         tp81rbu8zy7yP/pV3vhIm6IA6+rH3aylRfE0IplXyjNDN9iqGdLyiojg1bvimTeNJAv1
         T55Fif1+k57DdES/2rpPGACYesXhSZ5aqRXZqWJTcgab1TN+RH2vp80bZzPWVkLg0gh/
         zPEwTLp2q7uDhbrYzdLfXKKc4FgJ40EHuUTk7rLL5Y3a91bjkoNoi221th+M8iGq4zY8
         CuVE/PvfroQlFdeJDJ5tqTsDZyexQgwQVjY108WQzGV25H8FKmZJtL0G9JwyPryKtLVS
         I9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714585727; x=1715190527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSgYxDDPLjqkX8EyBQbLQKb/QjqGOlLZGZqPCQdQNIo=;
        b=vV61aY85nkKOF8rh+lW2UFEtxYoJjl1Dxdskcpj7k7CICHizpFni/6yjSlPqz9PZ75
         anm8vcTolDMSU6EC7no6BYv10gkZb1P0p2WexBpsciO9PHx0ZSx7RrmZIpc5we3Ve9YY
         3fd+afwfloakx0DUmYa6ELhJgOVtS+WWXQNWcduQNNJ7enli37IyidILFF9/oxTCB4Bk
         mvkL1qO4uA1MQoHl5nDKiQsNl1cX/pAayhYVDqTk4R2J3aGdImtKU3cKpYi0yQbYUuqx
         OzS5Rb7nRBwGENN1CXPg/5rYou/J3ZYybHks6tEnSe+CXFeWWl0H25ARZC8pqPoP90rw
         UUHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWughzMohkeMJk1FEOdJ7hI2YH5p+x/CWiwmPbDwz4zL14nmzI2KUNUMfJP41VCp4v8UuZ6Opy/dVLQ7BnzMLnz2M3thOdQLSZc8oFS
X-Gm-Message-State: AOJu0YzC1P0o0tAaESsUT5YazsSWCeTzGi00nBlISdHI7ZfmjU0sfObv
	7n9hI/G29Ghr6KygW9KnQPFqJBM3e6zAcxLpiJE89VCFjT8dP2Yy/AVr+Rw2DuHEZ1WERK4xU/h
	WvoYPmpU76mVwbol6YaQX79sZmmvKbwD+8zt4
X-Google-Smtp-Source: AGHT+IEnMcdCsrZoGc3K83qrgNZTW1YYWzYpzYYI7cXK5LyFAuMVjt80FDSn02KAnFK7wZ8HpoZs7/fFq3vB2JbQ8eo=
X-Received: by 2002:a17:902:ef52:b0:1e5:32f5:8f00 with SMTP id
 d9443c01a7336-1ecdb2c147fmr126365ad.0.1714585727211; Wed, 01 May 2024
 10:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711674410.git.babu.moger@amd.com>
In-Reply-To: <cover.1711674410.git.babu.moger@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Wed, 1 May 2024 10:48:35 -0700
Message-ID: <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com, 
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com, 
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com, kai.huang@intel.com, 
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com, 
	pbonzini@redhat.com, sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com, 
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Babu,

On Thu, Mar 28, 2024 at 6:07=E2=80=AFPM Babu Moger <babu.moger@amd.com> wro=
te:
>
>
> This series adds the support for Assignable Bandwidth Monitoring Counters
> (ABMC). It is also called QoS RMID Pinning feature
>
> The feature details are documented in the  APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC). The documentation is available at
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
>
> The patches are based on top of commit
> cd80c2c94699913f9334414189487ff3f93cf0b5 (tip/master)
>
> # Introduction
>
> AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
> feature only guarantees that RMIDs currently assigned to a processor will
> be tracked by hardware. The counters of any other RMIDs which are no long=
er
> being tracked will be reset to zero. The MBM event counters return
> "Unavailable" for the RMIDs that are not active.
>
> Users can create 256 or more monitor groups. But there can be only limite=
d
> number of groups that can give guaranteed monitoring numbers. With ever
> changing configurations there is no way to definitely know which of these
> groups will be active for certain point of time. Users do not have the
> option to monitor a group or set of groups for certain period of time
> without worrying about RMID being reset in between.
>
> The ABMC feature provides an option to the user to assign an RMID to the
> hardware counter and monitor the bandwidth for a longer duration.
> The assigned RMID will be active until the user unassigns it manually.
> There is no need to worry about counters being reset during this period.
> Additionally, the user can specify a bitmask identifying the specific
> bandwidth types from the given source to track with the counter.
>
> Without ABMC enabled, monitoring will work in current mode without
> assignment option.
>
> # Linux Implementation
>
> Linux resctrl subsystem provides the interface to count maximum of two
> memory bandwidth events per group, from a combination of available total
> and local events. Keeping the current interface, users can assign a maxim=
um
> of 2 ABMC counters per group. User will also have the option to assign on=
ly
> one counter to the group. If the system runs out of assignable ABMC
> counters, kernel will display an error. Users need to unassign an already
> assigned counter to make space for new assignments.
>
>
> # Examples
>
> a. Check if ABMC support is available
>         #mount -t resctrl resctrl /sys/fs/resctrl/
>
>         #cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>         [abmc]
>         legacy_mbm
>
>         Linux kernel detected ABMC feature and it is enabled.
>
> b. Check how many ABMC counters are available.
>
>         #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_cntrs
>         32
>
> c. Create few resctrl groups.
>
>         # mkdir /sys/fs/resctrl/mon_groups/default_mon1
>         # mkdir /sys/fs/resctrl/non_defult_group
>         # mkdir /sys/fs/resctrl/non_defult_group/mon_groups/non_default_m=
on1
>
> d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_=
assign_control
>    to list and modify the group's assignment states.
>
>    The list follows the following format:
>
>        * Default CTRL_MON group:
>                "//<domain_id>=3D<assignment_flags>"
>
>        * Non-default CTRL_MON group:
>                "<CTRL_MON group>//<domain_id>=3D<assignment_flags>"
>
>        * Child MON group of default CTRL_MON group:
>                "/<MON group>/<domain_id>=3D<assignment_flags>"
>
>        * Child MON group of non-default CTRL_MON group:
>                "<CTRL_MON group>/<MON group>/<domain_id>=3D<assignment_fl=
ags>"
>
>        Assignment flags can be one of the following:
>
>         t  MBM total event is assigned
>         l  MBM local event is assigned
>         tl Both total and local MBM events are assigned
>         _  None of the MBM events are assigned
>

I was able to successfully build a kernel where this interface is
adapted to work with both real ABMC on hardware that supports it and
my software workaround for older hardware.

My prototype is based on a refactored version of the codebase
supporting MPAM, but the capabilities of the MPAM hardware look
similar enough to ABMC that I'm not concerned about the feasibility.

The FS layer is informed by the arch layer (through rdt_resource
fields) how many assignable monitors are available and whether a
monitor is assigned to an entire group or a single event in a group.
Also, the FS layer can assume that monitors are indexed contiguously,
allowing it to host the data structures managing FS-level view of
monitor usage.

I used the following resctrl_arch-interfaces to propagate assignments
to the implementation:

void resctrl_arch_assign_monitor(struct rdt_domain *d, u32 mon_id, u32
closid, u32 rmid, int evtid);
void resctrl_arch_unassign_monitor(struct rdt_domain *d, u32 mon_id);

I chose to allow reassigning an assigned monitor without calling
unassign first. This is important when monitors are unassigned and
assigned in a single write to mbm_assign_control, as it allows all
updates to be performed in a single round of parallel IPIs to the
domains.


>
> g. Users will have the option to go back to legacy_mbm mode if required.
>    This can be done using the following command.
>
>         # echo "legacy_mbm" > /sys/fs/resctrl/info/L3_MON/mbm_assign
>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>         abmc
>         [legacy_mbm]

I chose to make this a mount option to simplify the management of the
monitor tracking data structures. They are simply allocated at mount
time and deallocated and unmount.

I called the option "mon_assign": The mount option parser calls
resctrl_arch_mon_assign_enable() to determine whether the
implementation supports assignment in some form. If it returns an
error, the mount fails. When successful, the assignable monitor count
is made non-zero in the appropriate rdt_resource, triggering the
behavior change in the FS layer.

I'm still not sure if it's a good idea to enable monitor assignment by
default. This would be a major disruption in the MBM usage model
triggered by moving software between AMD CPU models. I thought the
safest option was to disallow creating more monitoring groups than
monitors unless the option is selected. Given that nobody else
complained about monitoring HW limitations on the mailing list, I
assumed few users create enough monitoring groups to be impacted.

Thanks!
-Peter

