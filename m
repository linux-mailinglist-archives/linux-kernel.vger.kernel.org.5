Return-Path: <linux-kernel+bounces-163147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15168B665B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC6D1F22189
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7797D190696;
	Mon, 29 Apr 2024 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8kK2RHs"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA82194C99
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433689; cv=none; b=XADCnx3+Yy0obz81tzZP52bFDlu7Ul8P0AyItpaFfBjVt7Eo/Smh17o3/uu/UI9NGRtlIy8kEgcXzD4XOI7TgCvl2On/ciME+1OMhAD4EZcWWm2kR8mO9fxDJoKB+LSa7LUPHK394zWOLGpUnonjvq5h4mkq+LFVPblstSk2IxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433689; c=relaxed/simple;
	bh=agPvoDCKDb/l1LUhfaDecXMUrlSWFJ5P9XLjfYuT3kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbW7qXOjYqnx/Fc+zhSONv/E9pYn9IgZ15S8zJT5ONntk888LnV+1lapzaY+p7rmkc+mfDKZrsNDNWvejuyy5fh48eO+opMfxtcj7NSRsgTv7deQoHtBQeT9Vbl7ADjFdmbo5SApEW0jbTW50GjTFGGwPlfjSJUwYzeccw30QiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P8kK2RHs; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43ae23431fbso39201cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714433686; x=1715038486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwG+M5LqhdLnGMNJlzOBnpi/idj4N15kzyq6DN7iw40=;
        b=P8kK2RHsr5DVgAr+BXRWgYHaRjNcq23f/awkFmoC0+k/zJA+dMbewAG46Z/ZVHgbe7
         F4gOzTs3SXdLKwvewGwLjBnvvmR52J5pFkmvlMuund8iHknih8zPuk0l/1WJS8DKAI8x
         HCa+7SctfD/erUc3p3p+wYhrXA5h9yyCwBiizHuYPhx3rsJE4xeIX8kfBPTkhBo36Np2
         vJQxVIexFqn/kpspEUzf78SgGlJgVnv3h/ALcso7GSHS0ns+cexq7IWoF22R0pYnmfy9
         Jl9Wbs2VFEvtsdH0X8MXYWo838+lY16Q/4PSZxehZrJlybtw/B05XL6DjgfdXE6KNfrQ
         P2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714433686; x=1715038486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwG+M5LqhdLnGMNJlzOBnpi/idj4N15kzyq6DN7iw40=;
        b=Hspbpf1oCNqSjjpDuQ6FPVicGdyzpZyf/AkF702XtPTTLZ4eXE0KPk77Kj0gaBCwif
         ugPzEiP5ixvW1ahnODjEVdovf/CIMMpwwD38gABgDe7JepvgmwH7r6584GE88C6ReErH
         gugSeyLcf6cKlP8Pi3qkQWldT3G7j4/lL8dXhWVFxoM4dWsIT6/84sBB6HrxC7h1x9lP
         Tq1DCi0/1mxmUIfX0zG7t0vulDckmUEFIKDhVNgLaAyFdmJALhkIlVwn5TzrnAjzIzHJ
         fGeXmzPJ6AoxsuG+jk99Zmt/WMY+vsQtzh6TkRTIHfpZ7Zkv2hSTaZ3jWqAvLvp6JvRz
         MCYg==
X-Forwarded-Encrypted: i=1; AJvYcCV0HDGYXeaJfAHdYZ5WB3ow3UUB//OA7mlWkgDwmvwn/+k5zp2e4JDNUolua+ibZ/Rt54SbnCYyoYsaKLTdi4NYOss4ZtoShbVVIlDj
X-Gm-Message-State: AOJu0YxH7b1sEVMVGIYMnkYmJdD7xJ3sETwqoH5lqftXC0M6HxENxf1Q
	8zpa2ALKFZ/HxXgdIBxeSo1r0RMFcMWN8/ZPaZ3Dt9nRUi/hjtJRyEzcXZPIuSrwKfbsbx2uDtb
	qYv7ZoPFmoQcVFIg97PIqHybZqctXZxaQXSh4
X-Google-Smtp-Source: AGHT+IFunVHrk3TThVxNyLGIK7IXo00K5llVekDE3fMeru5zkikQ9BZ+yG3o1FH6lUBKJNK714X60RkiARkp1+qt/OQ=
X-Received: by 2002:ac8:5a82:0:b0:43a:b187:6a7 with SMTP id
 c2-20020ac85a82000000b0043ab18706a7mr115100qtc.28.1714433686106; Mon, 29 Apr
 2024 16:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426150537.8094-1-Dave.Martin@arm.com>
In-Reply-To: <20240426150537.8094-1-Dave.Martin@arm.com>
From: Peter Newman <peternewman@google.com>
Date: Mon, 29 Apr 2024 16:34:34 -0700
Message-ID: <CALPaoCg=Gt6X1wJ+HZLva+eWotDjjKdug9aAiK=gL39gH2FBTQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/35] x86/resctrl: Move the resctrl filesystem code to /fs/resctrl
To: Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	James Morse <james.morse@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, 
	Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com, 
	D Scott Phillips OS <scott@os.amperecomputing.com>, carl@os.amperecomputing.com, 
	lcherian@marvell.com, bobo.shaobowang@huawei.com, 
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>, baolin.wang@linux.alibaba.com, 
	Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com, 
	amitsinght@marvell.com, David Hildenbrand <david@redhat.com>, 
	Rex Nie <rex.nie@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave (and James),

On Fri, Apr 26, 2024 at 8:05=E2=80=AFAM Dave Martin <Dave.Martin@arm.com> w=
rote:
>
> Hi all,
>
> This is a respin of the resctrl refactoring series described below,
> addressing review feedback.  Many thanks to those to responded with
> feedback on the v1 series [2].
>
> See Notes and FYIs in the individual patches for details on the changes
> and outstanding issues.
>
>
> This series has not been rebased since the v1 posting, and remains
> based on the following upstream commit:
>
> commit 23956900041d968f9ad0f30db6dede4daccd7aa9
> Merge tag 'v6.9-rc-smb3-server-fixes' of git://git.samba.org/ksmbd
>
> The actual code changes against v1 are few in number and rather spread
> around.  For reviewer convenience, a diff against v1 is appended to
> this cover letter.
>
> Due to the limited code changes, this series has *not* received any
> additional runtime testing over than done for v1 (other than build
> bisect testing).
>
> Cheers
> ---Dave
>
>
> [2] v1 series:
> [PATCH v1 00/31] x86/resctrl: Move the resctrl filesystem code to /fs/res=
ctrl
> https://lore.kernel.org/all/20240321165106.31602-1-james.morse@arm.com/
>
> --8<-- Original blurb
>
> This is the final series that allows other architectures to implement res=
ctrl.
> The last patch just moves the code, and its a bit of a monster. I don't e=
xpect
> that to get merged as part of this series - we should wait for it to make
> less impact on other series. It's included here to show what gets moved, =
and
> that structures/function-prototypes have the right visibility.
>
> Otherwise this series renames functions and moves code around. With the
> exception of invalid configurations for the configurable-events, there sh=
ould
> be no changes in behaviour caused by this series.
>
> The driving pattern is to make things like struct rdtgroup private to res=
ctrl.
> Features like pseudo-lock aren't going to work on arm64, the ability to d=
isable
> it at compile time is added.
>
> After this, I can start posting the MPAM driver to make use of resctrl on=
 arm64.
> (What's MPAM? See the cover letter of the first series. [1])
>
> This series is based on Linus' commit 23956900041d and can be retrieved f=
rom:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> mpam/move_to_fs/v1
>
> Sorry for the mid-merge window base, I'm away for a few weeks - this shou=
ld
> rebase trivially onto rc1.
>
> As ever - bugs welcome,
> Thanks,
>
> James
>
> [1] https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.=
com/
>
> -->8--
>
>
> Dave Martin (4):
>   x86/resctrl: Squelch whitespace anomalies in resctrl core code
>   x86/resctrl: Prefer alloc(sizeof(*foo)) idiom in rdt_init_fs_context()
>   x86/resctrl: Relax some asm #includes
>   [SQUASHME] x86/resctrl: Move the resctrl filesystem code to
>     /fs/resctrl
>
> James Morse (31):
>   x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no
>     monitors
>   x86/resctrl: Add a helper to avoid reaching into the arch code
>     resource list
>   x86/resctrl: Move ctrlval string parsing policy away from the arch
>     code
>   x86/resctrl: Add helper for setting CPU default properties
>   x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
>   x86/resctrl: Export resctrl fs's init function
>   x86/resctrl: Wrap resctrl_arch_find_domain() around rdt_find_domain()
>   x86/resctrl: Move resctrl types to a separate header
>   x86/resctrl: Add a resctrl helper to reset all the resources
>   x86/resctrl: Move monitor init work to a resctrl init call
>   x86/resctrl: Move monitor exit work to a resctrl exit call
>   x86/resctrl: Move max_{name,data}_width into resctrl code
>   x86/resctrl: Stop using the for_each_*_rdt_resource() walkers
>   x86/resctrl: Export the is_mbm_*_enabled() helpers to asm/resctrl.h
>   x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
>   x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
>   x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
>   x86/resctrl: Allow resctrl_arch_mon_event_config_write() to return an
>     error
>   x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
>   x86/resctrl: Allow an architecture to disable pseudo lock
>   x86/resctrl: Make prefetch_disable_bits belong to the arch code
>   x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
>   x86/resctrl: Move thread_throttle_mode_init() to be managed by resctrl
>   x86/resctrl: Move get_config_index() to a header
>   x86/resctrl: Claim get_domain_from_cpu() for resctrl
>   x86/resctrl: Describe resctrl's bitmap size assumptions
>   x86/resctrl: Rename resctrl_sched_in() to begin with "resctrl_arch_"
>   x86/resctrl: Drop __init/__exit on assorted symbols
>   fs/resctrl: Add boiler plate for external resctrl code
>   x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
>   x86/resctrl: Move the resctrl filesystem code to /fs/resctrl
>
>  MAINTAINERS                               |    2 +
>  arch/Kconfig                              |    8 +
>  arch/x86/Kconfig                          |    5 +-
>  arch/x86/include/asm/resctrl.h            |   45 +-
>  arch/x86/kernel/cpu/resctrl/Makefile      |    5 +-
>  arch/x86/kernel/cpu/resctrl/core.c        |  119 +-
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  506 +--
>  arch/x86/kernel/cpu/resctrl/internal.h    |  436 +--
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  813 +---
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 1130 +-----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 4205 +--------------------
>  arch/x86/kernel/process_32.c              |    2 +-
>  arch/x86/kernel/process_64.c              |    2 +-
>  fs/Kconfig                                |    1 +
>  fs/Makefile                               |    1 +
>  fs/resctrl/Kconfig                        |   36 +
>  fs/resctrl/Makefile                       |    3 +
>  fs/resctrl/ctrlmondata.c                  |  527 +++
>  fs/resctrl/internal.h                     |  338 ++
>  fs/resctrl/monitor.c                      |  843 +++++
>  fs/resctrl/pseudo_lock.c                  | 1122 ++++++
>  fs/resctrl/rdtgroup.c                     | 4013 ++++++++++++++++++++
>  include/linux/resctrl.h                   |  157 +-
>  include/linux/resctrl_types.h             |   98 +
>  24 files changed, 7402 insertions(+), 7015 deletions(-)
>  create mode 100644 fs/resctrl/Kconfig
>  create mode 100644 fs/resctrl/Makefile
>  create mode 100644 fs/resctrl/ctrlmondata.c
>  create mode 100644 fs/resctrl/internal.h
>  create mode 100644 fs/resctrl/monitor.c
>  create mode 100644 fs/resctrl/pseudo_lock.c
>  create mode 100644 fs/resctrl/rdtgroup.c
>  create mode 100644 include/linux/resctrl_types.h

I was able to build a kernel with the changes and ran through our
internal suite of functional tests on the following implementations:

- AMD EPYC 7B12 64-Core Processor
- Intel(R) Xeon(R) Platinum 8581C

and the results looked good.

Tested-by: Peter Newman <peternewman@google.com>

Thanks!

