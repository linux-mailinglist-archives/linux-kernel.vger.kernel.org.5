Return-Path: <linux-kernel+bounces-151955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57378AB640
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3AC1F2151D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AEE13C9A9;
	Fri, 19 Apr 2024 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTL+ym4g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D85910961
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713560995; cv=none; b=sBX4iKNnMszjUiCL2csfPP0mhIcn3MDeJNwxXe5QbmGwdE797r3A4CkhMOQLOlj3h4p0+JBt80DG0ctkEXhJ8otspqWmoerUgs1X/cQJJW/0U0677PsFV3GWUqAnAVrxaRAXQhPnKUQ+deVFho1rR7DmIZbJki8PrRnTAVeSkFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713560995; c=relaxed/simple;
	bh=gwfkQSLY0diiDeo9O6hx3l4tKvPOvaOzuzyFQJWuSsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OpdaJIchSGtVmjnocOwegtHl1W6Jlo/6v+GLaM6N7GgklI2Qsnk/CQaDVzR7H2gLbP76tNyDW4YU5V4MJdiLlg3TWgWmW+HOl2Z60wMZDadyf/AYPWTdRYnfV7qVeEBhJtXPoFubrFzCm0i5p9HFy07b6zO4TSWaoGu3hhYmqPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTL+ym4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7299C072AA;
	Fri, 19 Apr 2024 21:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713560995;
	bh=gwfkQSLY0diiDeo9O6hx3l4tKvPOvaOzuzyFQJWuSsQ=;
	h=From:To:Cc:Subject:Date:From;
	b=pTL+ym4gh7JOpxJUOokFTjCYJRjzF4ahFZqRSl34Ai2L/4RzreBYIsZeRJULTU4hd
	 MdVKSR7ZrBwlXEZHDbaD+wXmP6L2FwV1rYGw9whdoErwmKZGZ3Toe3GtW/DM5VC/9x
	 5f0B21FrfTFS/lZqO+WdtVl+qmRHM8WbFgBD8Z4k5KR3/mvOLrEs6Hp2bbb5nwUSRz
	 y8ShPKdZofHo7RO6yyk1+efWjV3YSkzKRo/tP7Zk0B0jh+Y7Xu+Aftgm+epWptRR/5
	 475kYzPPhL30tB20OEI7khRakl3hdY6iH87lniVEVH/xJUa/rpB1WvgDbL+ihYN/Qv
	 s0N+E42jS0tVg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/5] x86/bugs: more BHI fixes
Date: Fri, 19 Apr 2024 14:09:46 -0700
Message-ID: <cover.1713559768.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is another iteration of reducing the scope of syscall hardening
in order to improve performance on some CPUs.  The feature bit has a new
name, and the commit log and comments are much improved.

The rest of the patches are new:

  - Patch 2 fixes the default mitigations for !x86 (reimplementation of
    Sean's fix).

  - Patch 3 fixes some objtool warnings found by Paul.

  - Patch 4 is a documentation cleanup and prep for patch 5.

  - Patch 5 adds a requested spectre_bhi=vmexit option.

Josh Poimboeuf (5):
  x86/bugs: Only harden syscalls when needed
  cpu/speculation: Fix CPU mitigation defaults for !x86
  x86/syscall: Mark exit[_group] syscall handlers __noreturn
  x86/bugs: Remove duplicate Spectre cmdline option descriptions
  x86/bugs: Add 'spectre_bhi=vmexit' cmdline option

 Documentation/admin-guide/hw-vuln/spectre.rst | 84 ++-----------------
 .../admin-guide/kernel-parameters.txt         | 12 ++-
 arch/Kconfig                                  | 10 +++
 arch/x86/Kconfig                              | 15 +---
 arch/x86/entry/common.c                       | 15 +++-
 arch/x86/entry/syscall_32.c                   | 11 +--
 arch/x86/entry/syscall_64.c                   | 10 +--
 arch/x86/entry/syscall_x32.c                  | 11 ++-
 arch/x86/entry/syscalls/syscall_64.tbl        |  6 +-
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/syscall.h                |  8 +-
 arch/x86/kernel/cpu/bugs.c                    | 51 +++++++++--
 arch/x86/um/sys_call_table_32.c               |  1 +
 arch/x86/um/sys_call_table_64.c               |  1 +
 kernel/cpu.c                                  |  4 +-
 scripts/syscalltbl.sh                         |  6 +-
 tools/objtool/noreturns.h                     |  4 +
 17 files changed, 126 insertions(+), 124 deletions(-)

-- 
2.44.0


