Return-Path: <linux-kernel+bounces-79726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E68D88625D8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F091F21B93
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC47C47772;
	Sat, 24 Feb 2024 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGRs+thD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91417E9;
	Sat, 24 Feb 2024 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708789682; cv=none; b=lKt04wTMNV48ZFEy5Le4rnZe4MSV8xuxl724WAA69jujgLvFjXDpPBE+EXXtn7SARWFmVEYwrEt3hqa5XfGtcukbP957VJAy7Ioc416JtTniorBi6qEH6N5XWcm9rfGt4eY71KDKzHbcMXm9HenOxQS1BWEaRD1pbBjpAqV1xEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708789682; c=relaxed/simple;
	bh=AgfceBaBph7sVUR2Dyn5Iudnt1yeQy1TvBMVEfuCNOg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mdgD7E6H9eFC1yhwIiQao3sVT03DghTc58OfHEouJKYSfbkNjXG+3PpZbWo2nAtOsqyGl3ZLpauT+jboLFy7aFdUTb7vvwoGOZ0HyK8lHjZtJszNFiS3ukfUYhiM/yd3AGuiglBtNCzjAxyRGUuaeMsOTEtFMOBWq+SdSzApKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGRs+thD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A62C433F1;
	Sat, 24 Feb 2024 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708789681;
	bh=AgfceBaBph7sVUR2Dyn5Iudnt1yeQy1TvBMVEfuCNOg=;
	h=Date:From:To:Cc:Subject:From;
	b=jGRs+thDgYc2Z/T7N/Fu8f+hNqNixXrAff/1MLj1FSVAkW91gg/HPMawZL5VG0h9a
	 oeb2IPch8CcZI8haaHwOrPyOGcfTTmmCHjdys8lQR6F9hs6SMj+8s3wTTADXg7wFNq
	 lV7Bt4Mgk4KheisZz+8YsA5I5jQbCYXcPLfKpqTtTddSsQOXSq9rOPCHcpaKnRR3Fh
	 6nvIOJgJ080M5x0xaLhjdWUEYuJo9vhR5+GRioqL5oBM66cLAcnD2beU4blxPhqoPh
	 9TL6cgxII40I7E7IDpi5jawHBZMvgFQD8UYfEJaeAVmRd7zbImC8RmXnWdzwA0pDC8
	 amwspg7nh49Ew==
Date: Sat, 24 Feb 2024 12:47:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Ian Rogers <irogers@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf bpf: Check that the minimal vmlinux.h installed is
 the latest one
Message-ID: <ZdoPrWg-qYFpBJbz@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When building BPF skels perf will, by default, install a minimalistic
vmlinux.h file with the types needed by the BPF skels in
tools/perf/util/bpf_skel/ in its build directory.

When 29d16de26df17e94 ("perf augmented_raw_syscalls.bpf: Move 'struct
timespec64' to vmlinux.h") was added, a type used in the augmented_raw_syscalls
BPF skel, 'struct timespec64' was not found when building from a pre-existing
build directory, because the vmlinux.h there didn't contain that type,
ending up with this error, spotted in linux-next:

    CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
  util/bpf_skel/augmented_raw_syscalls.bpf.c:329:15: error: invalid application of 'sizeof' to an incomplete type 'struct timespec64'
    329 |         __u32 size = sizeof(struct timespec64);
        |                      ^     ~~~~~~~~~~~~~~~~~~~
  util/bpf_skel/augmented_raw_syscalls.bpf.c:329:29: note: forward declaration of 'struct timespec64'
    329 |         __u32 size = sizeof(struct timespec64);
        |                                    ^
  util/bpf_skel/augmented_raw_syscalls.bpf.c:350:15: error: invalid application of 'sizeof' to an incomplete type 'struct timespec64'
    350 |         __u32 size = sizeof(struct timespec64);
        |                      ^     ~~~~~~~~~~~~~~~~~~~
  util/bpf_skel/augmented_raw_syscalls.bpf.c:350:29: note: forward declaration of 'struct timespec64'
    350 |         __u32 size = sizeof(struct timespec64);
        |                                    ^
  2 errors generated.
  make[2]: *** [Makefile.perf:1158: /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o] Error 1
  make[2]: *** Waiting for unfinished jobs....
  make[1]: *** [Makefile.perf:261: sub-make] Error 2
  make: *** [Makefile:113: install-bin] Error 2
  make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'

So add a Makefile dependency (Namhyung's suggestion) to make sure that
the new tools/perf/util/bpf_skel/vmlinux/vmlinux.h minimal vmlinux is
updated in the build directory, providing the moved 'struct timespec64'
type.

Fixes: 29d16de26df17e94 ("perf augmented_raw_syscalls.bpf: Move 'struct timespec64' to vmlinux.h")
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/lkml/CAM9d7ciaj80QZL0AS_T2HNBdMOyS-j1wBHQSYs=U3kHQimY1mQ@mail.gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3cecd51b239707ba..33621114135ee2c8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1147,7 +1147,7 @@ ifeq ($(VMLINUX_H),)
   endif
 endif
 
-$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
+$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) $(VMLINUX_H)
 ifeq ($(VMLINUX_H),)
 	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
 else
-- 
2.43.0


