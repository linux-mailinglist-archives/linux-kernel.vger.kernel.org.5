Return-Path: <linux-kernel+bounces-117596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1733188AD04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2B51C3D1BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A76512F36D;
	Mon, 25 Mar 2024 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kWuZiHMD"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED98512EBEB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387649; cv=none; b=pvCqNVxoyUKCWqITwENe6ZqPSgdzQKktIiy2BSE/bZJgohQxeQOvTc+PZi+Ap7jSyDOwURxSDZW6sFpxzG7j5WVIIyiHSgjNkqRfuky33cz846L9nYlQQCAN4ccTZBlw3lrop+e4/P7bHexjt0s1tjlArkqsAWJs1JvpFVIHGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387649; c=relaxed/simple;
	bh=ZyQKfQgVVcm6D8/y51apxnHCyNzHTz0AYiX2LXX6Sv4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HPplFmpdjHDUCVqdSertAcGVlnJ1plA5yHJhdmBXGGml2B7CgpioGYCBfNQ+YK7dkSfHdAXa+ovk4plPf2J54DKQm/6VCciKb3XCGLvOtA3mjLsmqUV7RdZ227a7hPTH5A7YfCKxXX0OoEOVBfPeZf0IqNm/VkGPSsM4FukAFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kWuZiHMD; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e6fb338247so5258268b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711387647; x=1711992447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=saZc5uEnhEYYbmJCCiYrgAJ4Dss1LyNX0cyUNmo+/dk=;
        b=kWuZiHMDsNerViXtSPZY0HMrwBxViOIA37oeruwKNt+95xo4i48OLhcNrZKR7r1fB9
         UmDc7pkOAHNyCrGD7t4Ix4ThnmWemRLmueGqHOYMtGNHhDKFQdCDQ6natoCxFf+Hs7gt
         EK85Hs+j1Tgb+1yCrLjOwAOyT8n/nEXGVgR5+gg7+ExYN/ZMLCnEhWy4xojyoH+Qm/j+
         SP0Wl5W0XJRxDLBgN1ObfiFDUbFoouujN2TzzJufXTUwbs3t3rZjZFHCQ6UenFqqT/EJ
         c5fXtgKY5ysV2j4kBzB6SXC5eUbbQrh9x2mm0eUbXe8HoJ/QNhRsIhvZhO6IvNn3QLVc
         5Dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387647; x=1711992447;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=saZc5uEnhEYYbmJCCiYrgAJ4Dss1LyNX0cyUNmo+/dk=;
        b=oa82g+LGFTSTyoI7zLEj7oIfP+GsQky09KyfASFFN2VhJiA2tSAnSaSpjGqHXrRDkv
         dImH/LZ/lOV1qnG4rA6M4umVkZUtLJrnotzPgkWusppJek6F1DhoAmPjrbzlNfErsHAJ
         lIRzSL9dsfx2Zwd06uZUIUflWwQd5JppP7IXZ+K+hxJuGFQR+eN8HVvEZj/xAQzqSIkF
         mKbcZjIUbtsg0cSYjPi9Rke630qD80CeA3GZw8/7Tl0QIbzvQ8ky7+wL9JUaECyJWI9g
         Ms76hXw5MY81TlDWgx3psrBjcNNZfWlj+gJC5hRG/+ZIQTFktnKho8m6YGX4a8WmhOJQ
         OQUA==
X-Forwarded-Encrypted: i=1; AJvYcCXfrSro0uBWzOmdnLoIHMdeplsJmZz0UA5l1rDslckf0lzMdS/OVyEJZAETmhwAeqoKgypXCxJomtGMsUgRP1aP+HaZvrbpIv6bFYzU
X-Gm-Message-State: AOJu0YwtDZ4nsfaqVh9LGEm8ZlKtIQ2ba6BQBxLniWmIMPGhfHDbh0GJ
	xnCG3qVsKBeY43ABERUCCBN6qnAEUv5gJF83QYLpFlYQvz2GfCP21AqCy1gVA68Cvpqy1EunjDt
	cIZzDOy08ypxwHdATqMX1+w==
X-Google-Smtp-Source: AGHT+IFD2ubxlA+xO/2SIehYZMmarvB/eCpHRW0qbyXPi+zpkaEfLhYS4zDT3Tuh1U4zh+Htc8YEWXmRerNwM/yGLA==
X-Received: from peternewman-us.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3dcc])
 (user=peternewman job=sendgmr) by 2002:a05:6a00:a27:b0:6ea:8a0d:185f with
 SMTP id p39-20020a056a000a2700b006ea8a0d185fmr460545pfh.2.1711387647060; Mon,
 25 Mar 2024 10:27:27 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:27:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325172707.73966-1-peternewman@google.com>
Subject: [PATCH v1 0/6] x86/resctrl: Avoid searching tasklist during mongrp_reparent
From: Peter Newman <peternewman@google.com>
To: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	James Morse <james.morse@arm.com>
Cc: Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Reinette,

I've been working with users of the recently-added mongroup rename
operation[1] who have observed the impact of back-to-back operations on
latency-sensitive, thread pool-based services. Because changing a
resctrl group's CLOSID (or RMID) requires all task_structs in the system
to be inspected with the tasklist_lock read-locked, a series of move
operations can block out thread creation for long periods of time, as
creating threads needs to write-lock the tasklist_lock.

To avoid this issue, this series replaces the CLOSID and RMID values
cached in the task_struct with a pointer to the task's rdtgroup, through
which the current CLOSID and RMID can be obtained indirectly during a
context switch. Updating a group's ID then only requires the current
task to be switched back in on all CPUs. On server hosts with very large
thread counts, this is much less disruptive than making thread creation
globally unavailable. However, this is less desirable on CPU-isolated,
realtime workloads, so I am interested in suggestions on how to reach a
compromise for the two use cases.

Also note that the soft-ABMC[2] proposal is based on swapping the RMID
values in mongroups when monitors are assigned to them, which will
result in the same slowdown as was encountered with re-parenting
monitoring groups.

Using pointers to rdtgroups from the task_struct been used internally at
Google for a few years to support an alternate CLOSID management
technique[3], which was replaced by mongroup rename. Usage of this
technique during production revealed an issue where threads in an
exiting process become unreachable via for_each_process_thread() before
destruction, but can still switch in and out. Consequently, an rmdir
operation can fail to remove references to an rdtgroup before it frees
it, causing the pointer to freed memory to be dereferenced after the
structure is freed. This would result in invalid CLOSID/RMID values
being written into MSRs, causing an exception. The workaround for this
is to clear a task's rdtgroup pointer when it exits.

As a benefit, pointers to rdtgroups are architecture-independent,
resulting in __resctrl_sched_in() and more of the task assignment code
becoming portable, simplifying the effort of supporting MPAM. Using a
single pointer allows the task's current monitor and control groups to
be determined atomically.

Similar changes have been used internally on a kernel supporting MPAM.
Upon request, I can provide the required changes to the MPAM-resctrl
interface based on James Morse's latest MPAM snapshot[4] for reference.

Thanks!
-Peter

[1] https://lore.kernel.org/r/20230419125015.693566-3-peternewman@google.com
[2] https://lore.kernel.org/lkml/CALPaoChhKJiMAueFtgCTc7ffO++S5DJCySmxqf9ZDmhR9RQapw@mail.gmail.com
[3] https://lore.kernel.org/lkml/CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com
[4] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/v6.7-rc2

Peter Newman (6):
  x86/resctrl: Move __resctrl_sched_in() out-of-line
  x86/resctrl: Add hook for releasing task_struct references
  x86/resctrl: Disallow mongroup rename on MPAM
  x86/resctrl: Use rdtgroup pointer to indicate task membership
  x86/resctrl: Abstract PQR_ASSOC from generic code
  x86/resctrl: Don't search tasklist in mongroup rename

 arch/x86/include/asm/resctrl.h            |  93 --------
 arch/x86/kernel/cpu/resctrl/core.c        |  14 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |  17 ++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 279 +++++++++++++---------
 arch/x86/kernel/process_32.c              |   2 +-
 arch/x86/kernel/process_64.c              |   2 +-
 include/linux/resctrl.h                   |  38 +++
 include/linux/sched.h                     |   3 +-
 kernel/exit.c                             |   3 +
 10 files changed, 239 insertions(+), 216 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.44.0.396.g6e790dbe36-goog


