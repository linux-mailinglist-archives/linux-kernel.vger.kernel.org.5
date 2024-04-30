Return-Path: <linux-kernel+bounces-164372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA158B7CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2861C232E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440B2179658;
	Tue, 30 Apr 2024 16:29:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14271175554
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494562; cv=none; b=kHnbHxm5pqEydfzWeWkju1GAs7+984IwdpnPcBgU8KHgoh4+Bsp2d3COeaK8k/ptY/3R6ytWjzJRnnmhZ8lWA6VRuU1xPFvtxC1Wac3POAIhtO4vm9kgZQ6K5tbN8aTxxlZn3YwGiKm78a27QtY072SHqEQOx01TGZgBCDCwgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494562; c=relaxed/simple;
	bh=saCJC4MD1Pr3RCul0Mf+n36UWUbhxdK+RgHta8snZMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7d2q9Mv7FSDvK8T9Sbx1EgNVORu1JEPnpBCz59HvOgGGTSgNnNOqRLjt53KmnSgiSEzNMeJyS/+duEMcLjJvgzXsezL+BIl0OHTDhJSga8Bk/XHfXJAP2J6pkjQMGQyBaKNMVs96hQJHAUszxAouIYX+ai1/4eqbHtaeSYQ09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 900D42F4;
	Tue, 30 Apr 2024 09:29:46 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55F963F73F;
	Tue, 30 Apr 2024 09:29:17 -0700 (PDT)
Date: Tue, 30 Apr 2024 17:29:14 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Peter Newman <peternewman@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com,
	amitsinght@marvell.com, David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v2 00/35] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <ZjEcWvgJ6MG/36ji@e133380.arm.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <CALPaoCg=Gt6X1wJ+HZLva+eWotDjjKdug9aAiK=gL39gH2FBTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCg=Gt6X1wJ+HZLva+eWotDjjKdug9aAiK=gL39gH2FBTQ@mail.gmail.com>

Hi Peter,

On Mon, Apr 29, 2024 at 04:34:34PM -0700, Peter Newman wrote:
> Hi Dave (and James),
> 
> On Fri, Apr 26, 2024 at 8:05 AM Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > Hi all,
> >
> > This is a respin of the resctrl refactoring series described below,
> > addressing review feedback.  Many thanks to those to responded with
> > feedback on the v1 series [2].
> >
> > See Notes and FYIs in the individual patches for details on the changes
> > and outstanding issues.
> >
> >
> > This series has not been rebased since the v1 posting, and remains
> > based on the following upstream commit:
> >
> > commit 23956900041d968f9ad0f30db6dede4daccd7aa9
> > Merge tag 'v6.9-rc-smb3-server-fixes' of git://git.samba.org/ksmbd
> >
> > The actual code changes against v1 are few in number and rather spread
> > around.  For reviewer convenience, a diff against v1 is appended to
> > this cover letter.
> >
> > Due to the limited code changes, this series has *not* received any
> > additional runtime testing over than done for v1 (other than build
> > bisect testing).
> >
> > Cheers
> > ---Dave
> >
> >
> > [2] v1 series:
> > [PATCH v1 00/31] x86/resctrl: Move the resctrl filesystem code to /fs/resctrl
> > https://lore.kernel.org/all/20240321165106.31602-1-james.morse@arm.com/
> >
> > --8<-- Original blurb
> >
> > This is the final series that allows other architectures to implement resctrl.
> > The last patch just moves the code, and its a bit of a monster. I don't expect
> > that to get merged as part of this series - we should wait for it to make
> > less impact on other series. It's included here to show what gets moved, and
> > that structures/function-prototypes have the right visibility.
> >
> > Otherwise this series renames functions and moves code around. With the
> > exception of invalid configurations for the configurable-events, there should
> > be no changes in behaviour caused by this series.
> >
> > The driving pattern is to make things like struct rdtgroup private to resctrl.
> > Features like pseudo-lock aren't going to work on arm64, the ability to disable
> > it at compile time is added.
> >
> > After this, I can start posting the MPAM driver to make use of resctrl on arm64.
> > (What's MPAM? See the cover letter of the first series. [1])
> >
> > This series is based on Linus' commit 23956900041d and can be retrieved from:
> > https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> > mpam/move_to_fs/v1
> >
> > Sorry for the mid-merge window base, I'm away for a few weeks - this should
> > rebase trivially onto rc1.
> >
> > As ever - bugs welcome,
> > Thanks,
> >
> > James
> >
> > [1] https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/
> >
> > -->8--
> >
> >
> > Dave Martin (4):
> >   x86/resctrl: Squelch whitespace anomalies in resctrl core code
> >   x86/resctrl: Prefer alloc(sizeof(*foo)) idiom in rdt_init_fs_context()
> >   x86/resctrl: Relax some asm #includes
> >   [SQUASHME] x86/resctrl: Move the resctrl filesystem code to
> >     /fs/resctrl
> >
> > James Morse (31):
> >   x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no
> >     monitors
> >   x86/resctrl: Add a helper to avoid reaching into the arch code
> >     resource list
> >   x86/resctrl: Move ctrlval string parsing policy away from the arch
> >     code
> >   x86/resctrl: Add helper for setting CPU default properties
> >   x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
> >   x86/resctrl: Export resctrl fs's init function
> >   x86/resctrl: Wrap resctrl_arch_find_domain() around rdt_find_domain()
> >   x86/resctrl: Move resctrl types to a separate header
> >   x86/resctrl: Add a resctrl helper to reset all the resources
> >   x86/resctrl: Move monitor init work to a resctrl init call
> >   x86/resctrl: Move monitor exit work to a resctrl exit call
> >   x86/resctrl: Move max_{name,data}_width into resctrl code
> >   x86/resctrl: Stop using the for_each_*_rdt_resource() walkers
> >   x86/resctrl: Export the is_mbm_*_enabled() helpers to asm/resctrl.h
> >   x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
> >   x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
> >   x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
> >   x86/resctrl: Allow resctrl_arch_mon_event_config_write() to return an
> >     error
> >   x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
> >   x86/resctrl: Allow an architecture to disable pseudo lock
> >   x86/resctrl: Make prefetch_disable_bits belong to the arch code
> >   x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
> >   x86/resctrl: Move thread_throttle_mode_init() to be managed by resctrl
> >   x86/resctrl: Move get_config_index() to a header
> >   x86/resctrl: Claim get_domain_from_cpu() for resctrl
> >   x86/resctrl: Describe resctrl's bitmap size assumptions
> >   x86/resctrl: Rename resctrl_sched_in() to begin with "resctrl_arch_"
> >   x86/resctrl: Drop __init/__exit on assorted symbols
> >   fs/resctrl: Add boiler plate for external resctrl code
> >   x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
> >   x86/resctrl: Move the resctrl filesystem code to /fs/resctrl
> >
> >  MAINTAINERS                               |    2 +
> >  arch/Kconfig                              |    8 +
> >  arch/x86/Kconfig                          |    5 +-
> >  arch/x86/include/asm/resctrl.h            |   45 +-
> >  arch/x86/kernel/cpu/resctrl/Makefile      |    5 +-
> >  arch/x86/kernel/cpu/resctrl/core.c        |  119 +-
> >  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  506 +--
> >  arch/x86/kernel/cpu/resctrl/internal.h    |  436 +--
> >  arch/x86/kernel/cpu/resctrl/monitor.c     |  813 +---
> >  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 1130 +-----
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 4205 +--------------------
> >  arch/x86/kernel/process_32.c              |    2 +-
> >  arch/x86/kernel/process_64.c              |    2 +-
> >  fs/Kconfig                                |    1 +
> >  fs/Makefile                               |    1 +
> >  fs/resctrl/Kconfig                        |   36 +
> >  fs/resctrl/Makefile                       |    3 +
> >  fs/resctrl/ctrlmondata.c                  |  527 +++
> >  fs/resctrl/internal.h                     |  338 ++
> >  fs/resctrl/monitor.c                      |  843 +++++
> >  fs/resctrl/pseudo_lock.c                  | 1122 ++++++
> >  fs/resctrl/rdtgroup.c                     | 4013 ++++++++++++++++++++
> >  include/linux/resctrl.h                   |  157 +-
> >  include/linux/resctrl_types.h             |   98 +
> >  24 files changed, 7402 insertions(+), 7015 deletions(-)
> >  create mode 100644 fs/resctrl/Kconfig
> >  create mode 100644 fs/resctrl/Makefile
> >  create mode 100644 fs/resctrl/ctrlmondata.c
> >  create mode 100644 fs/resctrl/internal.h
> >  create mode 100644 fs/resctrl/monitor.c
> >  create mode 100644 fs/resctrl/pseudo_lock.c
> >  create mode 100644 fs/resctrl/rdtgroup.c
> >  create mode 100644 include/linux/resctrl_types.h
> 
> I was able to build a kernel with the changes and ran through our
> internal suite of functional tests on the following implementations:
> 
> - AMD EPYC 7B12 64-Core Processor
> - Intel(R) Xeon(R) Platinum 8581C
> 
> and the results looked good.
> 
> Tested-by: Peter Newman <peternewman@google.com>
> 
> Thanks!
> 

Great, thanks for the testing!

Cheers
---Dave

