Return-Path: <linux-kernel+bounces-127636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6B9894EBB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF07B21509
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB79F58234;
	Tue,  2 Apr 2024 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDoZzXj7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201814F217;
	Tue,  2 Apr 2024 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050388; cv=none; b=rYhpowNBTmab74Yd+7X6AmSH+ggKcowDWJnpoJBguvjbjswY3XQgEi610cjokzZtykdX6CgYaZyP9qFZilNqdYzWTvM+ZjNVSnHFZjBjHaFoZT7u3aO/8iENQI3iDk3F77qmRgRzTMU7v+Mo10Zd/H5Miopt5i7ofxoVIKYOr2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050388; c=relaxed/simple;
	bh=IgkvBtIf+p5gfrHO1hbAPX6VVhQCtHheKJSsq422Ohg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DvRzNtHJoePmtGL03ylLO6DAItCrNKmmzmThTemGFR+RLRD9oprJUAeErAEl65hhiXXFAW5jSBx72aIkaP8/RwaSbGCJNuCxB5P7QuE9o7wAAWTNSC9QeXRiZhRY6BME5iT3VDtLPX/qdxJ69NiLvWT/6R6k33dS2U/cGXn5fOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDoZzXj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B774C433C7;
	Tue,  2 Apr 2024 09:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712050387;
	bh=IgkvBtIf+p5gfrHO1hbAPX6VVhQCtHheKJSsq422Ohg=;
	h=From:To:Cc:Subject:Date:From;
	b=KDoZzXj7dTzuYm1CKMZamE/RUsZY+nMoJkM0O6MFosFfD3Au/4f2WJt0gzBdzNZiP
	 uNRoJa4nYkkEG9PPWUU7YOeWyMNKGErfTl+WXuV4EvO3Xna4mw0Z2n07Pd6sZC4f0o
	 hwlJNlTlDgmyhSkRzLBBLIbE2nxK3kDn30qRO1jwZ/Kjktkco+K/da6nxCTXV2Qxkl
	 7aR+cCU8BJ2RGSP11dhgKaEEiBmPe2C8o77WubOaNvNegTgwg0mfbr7VUyHl/vi9vf
	 hPmDCGBPu84n2pCjdgt8WIjEk5jSkZZGqIXdpSuh2OIu33nVP0nyyP1qFTtXc8TU2f
	 cSR997kVwZseg==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	x86@kernel.org
Subject: [PATCHv2 0/3] uprobe: uretprobe speed up
Date: Tue,  2 Apr 2024 11:32:59 +0200
Message-ID: <20240402093302.2416467-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
as part of the effort on speeding up the uprobes [0] coming with
return uprobe optimization by using syscall instead of the trap
on the uretprobe trampoline.

The speed up depends on instruction type that uprobe is installed
and depends on specific HW type, please check patch 1 for details.

I added extra selftests to check on registers values before and
after uretprobe to make sure the syscall saves all the needed regs
and that uprobe consumer can still change registers.

Patch 1 is based on:
  https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
  probes/for-next

and patches 2,3 are based on bpf-next/master and can be taken
separately through bpf-next tree without patch 1.

v2 changes:
  - reposted to proper tracing mailing list [Masami]
  - renamed selftest trigger functions [Andrii]
  - kept bpf_testmod register call pattern [Andrii]
  - added acks [Andrii/Oleg]

thanks,
jirka


[0] https://lore.kernel.org/bpf/ZeCXHKJ--iYYbmLj@krava/
---
Jiri Olsa (3):
      uprobe: Add uretprobe syscall to speed up return probe
      selftests/bpf: Add uretprobe syscall test for regs integrity
      selftests/bpf: Add uretprobe syscall test for regs changes

 arch/x86/entry/syscalls/syscall_64.tbl                  |   1 +
 arch/x86/kernel/uprobes.c                               |  83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h                                |   2 ++
 include/linux/uprobes.h                                 |   2 ++
 include/uapi/asm-generic/unistd.h                       |   5 +++-
 kernel/events/uprobes.c                                 |  18 +++++++++---
 kernel/sys_ni.c                                         |   2 ++
 tools/include/linux/compiler.h                          |   4 +++
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c   | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 230 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/uprobe_syscall.c      |  15 ++++++++++
 11 files changed, 478 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c

