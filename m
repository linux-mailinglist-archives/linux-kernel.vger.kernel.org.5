Return-Path: <linux-kernel+bounces-119477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029F188C97E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3479F1C38C04
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA76F10A2A;
	Tue, 26 Mar 2024 16:36:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DECC15B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470996; cv=none; b=Z9lUd+RdXS690f4vgfplFChVnf1Zo/JM5Ba3jaoOqJeccWUYd43pQE46nc8a+fAGeBJsiMvwi+LnmE15zwjDsALInJ4ZMCHSL8HbXB27/dSkv5Hj1y67P9GvUdBZgU7HzFTe2zrPCle6++JiRnTr2wLGY0/29MnzEoqPjPsVgKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470996; c=relaxed/simple;
	bh=PejW/i2//sUXvd2SBKyPfJZm6tRqlFMVRc12j8yK8rA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AHKLCsG1TueMJw4jm/HLV5IPpiBPd2uwVpqUxYllAk3FmgDme2XlRjawcO5DysijB5h0srWvodehfXMb1+8tq+Sxrxg6nEy8uSOcN2dY8Dr8F8UnB91X/wvZcZWyuHVuChkB4XSzOxJ6IYmbniPkNZrKqbaG8Gqa4OwEQhJbsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 007332F4;
	Tue, 26 Mar 2024 09:37:07 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B057C3F694;
	Tue, 26 Mar 2024 09:36:30 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: agordeev@linux.ibm.com,
	anil.s.keshavamurthy@intel.com,
	aou@eecs.berkeley.edu,
	bp@alien8.de,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	jarkko@kernel.org,
	jcalvinowens@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	mark.rutland@arm.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	tglx@linutronix.de,
	will@kernel.org
Subject: [PATCH 0/4] kprobes: permit use without modules
Date: Tue, 26 Mar 2024 16:36:20 +0000
Message-Id: <20240326163624.3253157-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently KPROBES depends on MODULES and cannot be built when support
for modules is not enabled. This is largely an artifact of the
default/generic code for allocating insn pages using module_alloc(),
though several architectures do not use this and have no strict
dependency on MODULES. It would be nice to allow KPROBES to be used
without MODULES, as this can be useful for testing and/or in certain
constrained environments.

This series (based on v6.9-rc1) removes the artificial dependency on
MODULES. This permits (but does not require) that architectures which
don't use module_alloc() to allocate kprobe insn pages can support
kprobes when module support is not enabled.

The series deliberately avoids adding a common text allocator, as the
requirements for allocating kprobe memory van vary by architecture, and
can differ from other text allocations. However, architectures can
easily call a common allocator if they wish, and this series does not
preclude using common allocators immediately or in future.

The key change is in patch 3. This requires that architectures which
provide their own alloc function must provide the corresponding free
function and select HAVE_KPROBES_ALLOC with any appropriate dependencies
for their implementation. Architectures which use the generic functions
are left as-is with a dependency on MODULES.

The final patch allows the core kprobes code to be built without
MODULES, and removes the explicit dependency from Kconfig. This is
derived from Jarkko's recent v6 attempt:

  https://lore.kernel.org/lkml/20240326012102.27438-1-jarkko@kernel.org/
 
With the series applied, arm64 and riscv can enable KPROBES without
MODULES, while powerpc/s390/x86 are still depend on MODULES as their
alloc functions currently use module_alloc(), and all other
architectures with KPROBES uses the generic implementation that depends
on MODULES. I believe it should be relatively easy to enable
powerpc/s390/x86 to not depend on MODULES.

Mark.

Jarkko Sakkinen (1):
  kprobes: Remove core dependency on modules

Mark Rutland (3):
  arm64: patching: always use fixmap
  kprobes/treewide: Add kprobes_ prefix to insn alloc/free functions
  kprobes/treewide: Explicitly override alloc/free functions

 arch/Kconfig                       |  5 ++++-
 arch/arm64/Kconfig                 |  1 +
 arch/arm64/kernel/patching.c       | 10 +++------
 arch/arm64/kernel/probes/kprobes.c |  7 +++++-
 arch/powerpc/Kconfig               |  3 ++-
 arch/powerpc/kernel/kprobes.c      |  7 +++++-
 arch/powerpc/kernel/optprobes.c    |  4 ++--
 arch/riscv/Kconfig                 |  1 +
 arch/riscv/kernel/probes/kprobes.c |  7 +++++-
 arch/s390/Kconfig                  |  3 ++-
 arch/s390/kernel/kprobes.c         |  7 +++++-
 arch/x86/Kconfig                   |  3 ++-
 arch/x86/kernel/kprobes/core.c     |  7 +++++-
 include/linux/kprobes.h            |  7 +++---
 kernel/kprobes.c                   | 34 ++++++++++++++++++++----------
 kernel/trace/trace_kprobe.c        | 15 +++++++++++--
 16 files changed, 87 insertions(+), 34 deletions(-)

-- 
2.30.2


