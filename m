Return-Path: <linux-kernel+bounces-151962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910368AB649
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477E71F213C3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90AF37719;
	Fri, 19 Apr 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHsTN0Us"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240492E3F7;
	Fri, 19 Apr 2024 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561150; cv=none; b=LVeCXOEGiE8G7Xc3X5YyIEKpZO7CYThPMqxybTiKEghHIU615jdl3cocBGDT4884gVeQVXHkEN31TIrQTbOx8aRNa+ZTelwnQJGDgq/ApM5CglebYpx6FDpgiYam0ZjyOUSL7rAiMSqRTH4RsopNKkWgBASusG1Xv8QaNurHsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561150; c=relaxed/simple;
	bh=bxzFISmRswtyjpJTO12vV49A879dOMn/HsvYAlNyRCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ML3ib+tvaRJFozcjN8hP0MkqKjQ8ptthdaGzOMgG3+2XTzQgtyM8+VGNLyDUKoR8UJHLOfcf4dwy/5L6BL6TvO/IW8oDfXoNAx39NZZr+C+iTi5qzeclkfRjS4/IugHrjRLNMCxFZot0rqOgoq8JS0rTXEaTgDV9J6w48d8eocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHsTN0Us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A264C072AA;
	Fri, 19 Apr 2024 21:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713561149;
	bh=bxzFISmRswtyjpJTO12vV49A879dOMn/HsvYAlNyRCw=;
	h=From:To:Cc:Subject:Date:From;
	b=BHsTN0UsUZDf1ugIJAbw1u2WuDnrl+Yb8K6HUfPWTWGLtyMH3XI3e0RNXX2DI6iaG
	 ZQP8ZnD/Aijbx7DpwLHP+wRHh+y0q34YRV410CWkolQiVcZIFQl3kXlsYoOlUn6v/H
	 5+EKLxCA50BpuNdLku6Ax/e86f44q58iXyDp8zcfOUHs2t6AcWlaY3fMMdPz47CItH
	 7TuClbM18/VX1vON14ntR9qd8Ztf0zQe82+hMrnWStB9SHt908eug/SpdSvBJBHjYm
	 EcHdRd2I8MozwZXWbCjD/mmVSVEoYAXiXUCeGtgQ9xFBdXCsY+fL7WFS2sF+I+atNA
	 TRdDBf7mF27+A==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf tools fixes for v6.9
Date: Fri, 19 Apr 2024 14:12:27 -0700
Message-ID: <20240419211227.821832-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.9.

Thanks,
Namhyung


The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.9-2024-04-19

for you to fetch changes up to 1cebd7f74976455ccd89c1dfbcf00bca52d0a512:

  tools/include: Sync arm64 asm/cputype.h with the kernel sources (2024-04-11 10:38:29 -0700)

----------------------------------------------------------------
perf tools fixes for v6.9

A random set of small bug fixes:

 * Fix perf annotate TUI when used with data type profiling
 * Work around BPF verifier about sighand lock checking

And a set of kernel header synchronization.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Namhyung Kim (11):
      perf annotate: Make sure to call symbol__annotate2() in TUI
      perf lock contention: Add a missing NULL check
      tools/include: Sync uapi/drm/i915_drm.h with the kernel sources
      tools/include: Sync uapi/linux/fs.h with the kernel sources
      tools/include: Sync uapi/linux/kvm.h and asm/kvm.h with the kernel sources
      tools/include: Sync uapi/sound/asound.h with the kernel sources
      tools/include: Sync x86 CPU feature headers with the kernel sources
      tools/include: Sync x86 asm/irq_vectors.h with the kernel sources
      tools/include: Sync x86 asm/msr-index.h with the kernel sources
      tools/include: Sync asm-generic/bitops/fls.h with the kernel sources
      tools/include: Sync arm64 asm/cputype.h with the kernel sources

 tools/arch/arm64/include/asm/cputype.h         |   4 +
 tools/arch/arm64/include/uapi/asm/kvm.h        |  15 +-
 tools/arch/powerpc/include/uapi/asm/kvm.h      |  45 +-
 tools/arch/s390/include/uapi/asm/kvm.h         | 315 ++++++++++-
 tools/arch/x86/include/asm/cpufeatures.h       |  17 +-
 tools/arch/x86/include/asm/disabled-features.h |  11 +-
 tools/arch/x86/include/asm/irq_vectors.h       |   2 -
 tools/arch/x86/include/asm/msr-index.h         |  74 ++-
 tools/arch/x86/include/asm/required-features.h |   3 +-
 tools/arch/x86/include/uapi/asm/kvm.h          | 308 ++++++++++-
 tools/include/asm-generic/bitops/__fls.h       |   8 +-
 tools/include/asm-generic/bitops/fls.h         |   8 +-
 tools/include/uapi/drm/i915_drm.h              |  16 +
 tools/include/uapi/linux/fs.h                  |  30 +-
 tools/include/uapi/linux/kvm.h                 | 689 +------------------------
 tools/include/uapi/sound/asound.h              |   4 +-
 tools/perf/ui/browsers/annotate.c              |   2 +-
 tools/perf/util/annotate.c                     |   3 +
 tools/perf/util/bpf_skel/lock_contention.bpf.c |   5 +-
 19 files changed, 817 insertions(+), 742 deletions(-)

