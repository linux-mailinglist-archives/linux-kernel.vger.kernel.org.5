Return-Path: <linux-kernel+bounces-135844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607A689CC02
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD687284D09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E92144D03;
	Mon,  8 Apr 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR/xGlkO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFF75B04F;
	Mon,  8 Apr 2024 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602522; cv=none; b=Flwbgg/4SaN5guO0P1qHmIXKMwNpA/d4f9AEnTliPdiyp6b4mTRHm9rforEO1kzDbTs8G2TlvwItnyHuplCLLpXPSrZH08HfHXXtAp9hX7e7uAaokyKuEeSqu32TeMrOSnIYrYn4XTsvg44x3RMwnGhRLZ0MXOn4Gd9L63IABYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602522; c=relaxed/simple;
	bh=9yWJNhAIPwTeysb1Fo3AduyH0ICpz7q82RX1/sR8Foc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AARkEexeJcZfQlZwsW/5mWD5270JDFFVfuJwuIcjegNT2Fvj9XJ3GP/90DDr7noXaCcPwEbe8qQ9FWoiRGnCqERdsklGjczgiNVHp38bWf8HzJAz2DifN3VqVP0+uvmIgccxBW/V9mZP5Ul58odsloF57C1x208n2vgxtxxmsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR/xGlkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4054C433F1;
	Mon,  8 Apr 2024 18:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712602521;
	bh=9yWJNhAIPwTeysb1Fo3AduyH0ICpz7q82RX1/sR8Foc=;
	h=From:To:Cc:Subject:Date:From;
	b=SR/xGlkO50rXg1tBwhJwBjN8cIZJLBPW2bXEEPQyu1k/bsLHQF5QV/0lIZ8biHfby
	 cN262i/7LX+TrYCQkdvGi0ASVSlrgXgQKprmO6dlcz+iCYx61ZSYgfl56xs3+sGvm/
	 aAFWM8zgxPA7KhV4X5I1eAk93HU669Oib82NlzpW2pEaHPI1xY1CY2tE7cY6TmdFQN
	 D+UHMgZkknMA19YW+Ny4aOL1QgwoMWiwI9jaHvAWyoS4m5t42AeAxKuLhxYo4XDb64
	 apNtZJ+51YjuSujgoMOw389gjC/nmhScVvd+3udzO6epWxYj915lKBaOB21C9VYlIz
	 Vk2AQlKl60IIA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCHSET 0/9] Sync tools headers with the kernel source
Date: Mon,  8 Apr 2024 11:55:11 -0700
Message-ID: <20240408185520.1550865-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I'm gonna carry these changes on the perf tools tree.  I'll update the
vhost.h once it lands on the mainline.

This is the full explanation from Arnaldo:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.


Thanks,
Namhyung


Namhyung Kim (9):
  tools/include: Sync uapi/drm/i915_drm.h with the kernel sources
  tools/include: Sync uapi/linux/fs.h with the kernel sources
  tools/include: Sync uapi/linux/kvm.h and asm/kvm.h with the kernel
    sources
  tools/include: Sync uapi/sound/asound.h with the kernel sources
  tools/include: Sync x86 CPU feature headers with the kernel sources
  tools/include: Sync x86 asm/irq_vectors.h with the kernel sources
  tools/include: Sync x86 asm/msr-index.h with the kernel sources
  tools/include: Sync asm-generic/bitops/fls.h with the kernel sources
  tools/include: Sync arm64 asm/cputype.h with the kernel sources

 tools/arch/arm64/include/asm/cputype.h        |   4 +
 tools/arch/arm64/include/uapi/asm/kvm.h       |  15 +-
 tools/arch/powerpc/include/uapi/asm/kvm.h     |  45 +-
 tools/arch/s390/include/uapi/asm/kvm.h        | 315 +++++++-
 tools/arch/x86/include/asm/cpufeatures.h      |  17 +-
 .../arch/x86/include/asm/disabled-features.h  |  11 +-
 tools/arch/x86/include/asm/irq_vectors.h      |   2 -
 tools/arch/x86/include/asm/msr-index.h        |  74 +-
 .../arch/x86/include/asm/required-features.h  |   3 +-
 tools/arch/x86/include/uapi/asm/kvm.h         | 308 +++++++-
 tools/include/asm-generic/bitops/__fls.h      |   8 +-
 tools/include/asm-generic/bitops/fls.h        |   8 +-
 tools/include/uapi/drm/i915_drm.h             |  16 +
 tools/include/uapi/linux/fs.h                 |  30 +-
 tools/include/uapi/linux/kvm.h                | 689 +-----------------
 tools/include/uapi/sound/asound.h             |   4 +-
 16 files changed, 809 insertions(+), 740 deletions(-)


base-commit: 25e973a0e077da585e472b4cadb1d2f4c1113285
-- 
2.44.0.478.gd926399ef9-goog


