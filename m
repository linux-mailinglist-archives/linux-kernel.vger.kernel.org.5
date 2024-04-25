Return-Path: <linux-kernel+bounces-159201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065E48B2A96
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B491C21923
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0261553BC;
	Thu, 25 Apr 2024 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BL0ymAq0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD1149DE3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079947; cv=none; b=Vd594GRtibGJIziL7CXDvYOCdsOGvVKZBDtEoM3vklb9ApC/RQbofP9siLbDIrjvrNcuvAFku8YPw95beOOJeAkX9g4PtODJKzaRERZw0jmqW4zJa6+XLtJdg0CWtkZMgqSNqO1TzKyL62hHgDklGbu0WTiZa6SgE34N9v/CBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079947; c=relaxed/simple;
	bh=f03FWO3QGytI/s63sia25tBtQ3FBL0DfGAEeg1DeVdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=muPQLbpM/rNSavoYN44NmIAO/wFebQcJ0MHpJdREfx6PjsG0feRY1WwjPowM7GgpeUZhnrNjWQ2lQGq/7FujX0TU48ryJiBWb8nX4UFcrrzauhFH5PR1l3oGBUyO6CX7efiUxAZ6BQm+1bRA+nsktFjpiM2wtF2eiTSmWBWu73A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BL0ymAq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B23CC113CC;
	Thu, 25 Apr 2024 21:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714079946;
	bh=f03FWO3QGytI/s63sia25tBtQ3FBL0DfGAEeg1DeVdQ=;
	h=Date:From:To:Cc:Subject:From;
	b=BL0ymAq0PyY58xec2nDNYdpldltZ5BMV5Y0zc+A/0ALnKCZaZta5BIYUdyvLCKy+N
	 d4bm7On98kTnm09Pk989frKLEjJ5fUUshLNbH+3/+PdFhqWhi5lDtzNpzkrFONM8Tt
	 sZL/BMDnGqwD/RSiamC6iit5Nt4uiPB1Alg5RGbBV/NQLZCNzQclZXtptWQMzX4i1r
	 S5aHBOhehR8JSpG6wH0yuw/wKQzNSYGHYk+UTM1BaMGEruab0G32GAH7uFVLbd0rnn
	 jsuI2ZRm+DJ6kFzPv12+jujGoweZbFMX0BPTWuT0BCkYUHsR+rmlx3kliMsJJenJ0F
	 6vRkGwxCPvatw==
Date: Thu, 25 Apr 2024 18:19:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/1 fyi] tools headers x86 cpufeatures: Sync with the kernel
 sources to pick TDX, Zen, APIC MSR fence changes
Message-ID: <ZirIx4kPtJwGFZS0@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

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

To pick the changes from:

  95a6ccbdc7199a14 ("x86/bhi: Mitigate KVM by default")
  ec9404e40e8f3642 ("x86/bhi: Add BHI mitigation knob")
  be482ff9500999f5 ("x86/bhi: Enumerate Branch History Injection (BHI) bug")
  0f4a837615ff925b ("x86/bhi: Define SPEC_CTRL_BHI_DIS_S")
  7390db8aea0d64e9 ("x86/bhi: Add support for clearing branch history at syscall entry")

This causes these perf files to be rebuilt and brings some X86_FEATURE
that will be used when updating the copies of
tools/arch/x86/lib/mem{cpy,set}_64.S with the kernel sources:

      CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
      CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

And addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index a38f8f9ba6572912..3c7434329661c66e 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -461,11 +461,15 @@
 
 /*
  * Extended auxiliary flags: Linux defined - for features scattered in various
- * CPUID levels like 0x80000022, etc.
+ * CPUID levels like 0x80000022, etc and Linux defined features.
  *
  * Reuse free bits when adding new feature flags!
  */
 #define X86_FEATURE_AMD_LBR_PMC_FREEZE	(21*32+ 0) /* AMD LBR and PMC Freeze */
+#define X86_FEATURE_CLEAR_BHB_LOOP	(21*32+ 1) /* "" Clear branch history at syscall entry using SW loop */
+#define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
+#define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
+#define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
 
 /*
  * BUG word(s)
@@ -515,4 +519,5 @@
 #define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* AMD SRSO bug */
 #define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* AMD DIV0 speculation bug */
 #define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* CPU is vulnerable to Register File Data Sampling */
+#define X86_BUG_BHI			X86_BUG(1*32 + 3) /* CPU is affected by Branch History Injection */
 #endif /* _ASM_X86_CPUFEATURES_H */
-- 
2.44.0


