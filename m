Return-Path: <linux-kernel+bounces-48809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CE28461DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66712B22385
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8D985627;
	Thu,  1 Feb 2024 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBUtnAKk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35E98527E;
	Thu,  1 Feb 2024 20:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818987; cv=none; b=czjTgXT9JxRhJoM85oqMVDnU4cJk/00heApmhHVtFW2x57wgt51eVgEMC9JTxHsZrHxtw3Z4cmNjEqE7eMqG6FD0yEV+qma0UIdEovp4DC0kGRWCilCZXu3xp4NXLbkspxlXnssaV+SbKMbCle1pq/0r/bEdzQk/x97z9nv2JnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818987; c=relaxed/simple;
	bh=R238ACRc7Yd3i4LA4FkGtAqjAgNIiVAR0SlpktbetVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GKA2ifKMhr5+461gfsu+4ReCZWTzYRkQLI2WxMeil1WYnC07YreyzKAYN3O+fRPkydsCRp8jlG5a1XiJPuJbpFJYwiaTfnhHynn4/IBBGCnqmxg+QB6W3IX/0UyOBcG4FR1f7tVj4NSQ3bXmgHOd+6AgYdKdhDedBLV7pTh5wNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBUtnAKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5D4C433C7;
	Thu,  1 Feb 2024 20:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706818987;
	bh=R238ACRc7Yd3i4LA4FkGtAqjAgNIiVAR0SlpktbetVc=;
	h=From:To:Cc:Subject:Date:From;
	b=WBUtnAKkcH6iuep6aNV4f9hAgM6tzS6Ld+j5cblWk1kIiAyEjT9Taksch2kto0iHQ
	 z9tD/bDhBQVtBngZfPoEOXTJ1oyzBplattFQABcQjYymT9zJD6/tqNUECvka+rOClq
	 mxslsZtCIOppAPn5uqxgxPM5guNxQnaCSCrdKYFWnsAxfICQAVOk9K61F0BrsXX+k3
	 vGyVzEKIhQUsf7QNwOaFpCfEm3uB6Y5tyEYYepbkPwerwRyGe73Gj1vyej804sCWTi
	 jO27an+OozYhCaNusMCZiufEais88jB+oc6NoqfT10ePapHn+AMqQL9tNr2+BFQvJ1
	 1GEkfbSmKY4DQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.8
Date: Thu,  1 Feb 2024 17:22:54 -0300
Message-ID: <20240201202254.15588-1-acme@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

	Please consider pulling, mostly 'perf test' issues, which in its
turn are mostly related to myself having Intel hybrid systems at home.

	All in all its about making the build and 'perf test' output
clean in more systems.

	This is being done after a laptop refresh, so maybe something is
out of place, lemme know if you find something broken, last refresh was
before the pandemic, so...

Best regards,

- Arnaldo

The following changes since commit ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7:

  Merge tag 'net-6.8-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-01-25 10:58:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools-fixes-for-v6.8-1-2024-02-01

for you to fetch changes up to fdd0ae72b34e56eb5e896d067c49a78ecb451032:

  perf tools headers: update the asm-generic/unaligned.h copy with the kernel sources (2024-01-31 14:02:41 -0300)

----------------------------------------------------------------
perf tools fixes for v6.8:

Vendor events:

- Intel Alderlake/Sapphire Rapids metric fixes, the CPU type ("cpu_atom", "cpu_core")
  needs to be used as a prefix to be considered on a metric formula, detected via one
  of the 'perf test' entries.

'perf test' fixes:

- Fix the creation of event selector lists on 'perf test' entries, by initializing
  the sample ID flag, which is done by 'perf record', so this fix only the tests,
  the common case isn't affected.

- Make 'perf list' respect debug settings (-v) to fix its 'perf test' entry.

- Fix 'perf script' test when python support isn't enabled.

- Special case 'perf script' tests on s390, where only DWARF call graphs are
  supported and only on software events.

- Make 'perf daemon' signal test less racy.

Compiler warnings/errors:

- Remove needless malloc(0) call in 'perf top' that triggers -Walloc-size.

- Fix calloc() argument order to address error introduced in gcc-14.

Build:

- Make minimal shellcheck version to v0.6.0, avoiding the build to fail with older versions.

Sync kernel header copies:

  - stat.h to pick STATX_MNT_ID_UNIQUE.

  - msr-index.h to pick IA32_MKTME_KEYID_PARTITIONING.

  - drm.h to pick DRM_IOCTL_MODE_CLOSEFB.

  - unistd.h to pick {list,stat}mount, lsm_{[gs]et_self_attr,list_modules} syscall numbers.

  - x86 cpufeatures to pick TDX, Zen, APIC MSR fence changes.

  - x86's mem{cpy,set}_64.S used in 'perf bench'.

  - Also, without tooling effects: asm-generic/unaligned.h, mount.h, fcntl.h, kvm headers.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (10):
      tools headers uapi: Sync linux/stat.h with the kernel sources to pick STATX_MNT_ID_UNIQUE
      tools arch x86: Sync the msr-index.h copy with the kernel sources to pick IA32_MKTME_KEYID_PARTITIONING
      tools headers UAPI: Sync linux/fcntl.h with the kernel sources
      tools headers UAPI: Update tools's copy of drm.h headers to pick DRM_IOCTL_MODE_CLOSEFB
      tools headers UAPI: Sync kvm headers with the kernel sources
      tools headers UAPI: Sync unistd.h to pick {list,stat}mount, lsm_{[gs]et_self_attr,list_modules} syscall numbers
      tools headers x86 cpufeatures: Sync with the kernel sources to pick TDX, Zen, APIC MSR fence changes
      tools headers: Update the copy of x86's mem{cpy,set}_64.S used in 'perf bench'
      tools include UAPI: Sync linux/mount.h copy with the kernel sources
      perf tools headers: update the asm-generic/unaligned.h copy with the kernel sources

Ian Rogers (6):
      perf list: Switch error message to pr_err() to respect debug settings (-v)
      perf list: Add output file option
      perf test: Workaround debug output in list test
      perf test shell script: Fix test for python being disabled
      perf test shell daemon: Make signal test less racy
      perf vendor events intel: Alderlake/sapphirerapids metric fixes

James Clark (1):
      perf evlist: Fix evlist__new_default() for > 1 core PMU

Sun Haiyong (2):
      perf top: Remove needless malloc(0) call that triggers -Walloc-size
      perf tools: Fix calloc() arguments to address error introduced in gcc-14

Thomas Richter (1):
      perf test: Fix 'perf script' tests on s390

Yicong Yang (1):
      perf build: Make minimal shellcheck version to v0.6.0

 tools/arch/x86/include/asm/cpufeatures.h           |   8 +-
 tools/arch/x86/include/asm/msr-index.h             |   8 +
 tools/arch/x86/include/uapi/asm/kvm.h              |   3 +
 tools/arch/x86/lib/memcpy_64.S                     |   4 +-
 tools/arch/x86/lib/memset_64.S                     |   4 +-
 tools/include/asm-generic/unaligned.h              |  24 +-
 tools/include/uapi/asm-generic/unistd.h            |  15 +-
 tools/include/uapi/drm/drm.h                       |  72 +++++-
 tools/include/uapi/drm/i915_drm.h                  |  12 +-
 tools/include/uapi/linux/fcntl.h                   |   3 +
 tools/include/uapi/linux/kvm.h                     | 140 ++++--------
 tools/include/uapi/linux/mount.h                   |  70 ++++++
 tools/include/uapi/linux/stat.h                    |   1 +
 tools/perf/Documentation/perf-list.txt             |   4 +
 tools/perf/Makefile.perf                           |  10 +
 tools/perf/builtin-list.c                          | 211 ++++++++++-------
 tools/perf/builtin-record.c                        |   4 +-
 tools/perf/builtin-top.c                           |   2 +-
 .../pmu-events/arch/x86/alderlake/adl-metrics.json | 254 ++++++++++-----------
 .../arch/x86/alderlaken/adln-metrics.json          |   4 -
 .../arch/x86/sapphirerapids/spr-metrics.json       |  25 +-
 tools/perf/tests/shell/daemon.sh                   |  34 ++-
 tools/perf/tests/shell/list.sh                     |  21 +-
 tools/perf/tests/shell/script.sh                   |  12 +-
 tools/perf/trace/beauty/statx.c                    |   1 +
 tools/perf/util/evlist.c                           |   9 +-
 tools/perf/util/hist.c                             |   4 +-
 tools/perf/util/include/linux/linkage.h            |   4 +
 tools/perf/util/metricgroup.c                      |   2 +-
 tools/perf/util/print-events.c                     |   2 +-
 tools/perf/util/synthetic-events.c                 |   4 +-
 31 files changed, 588 insertions(+), 383 deletions(-)

