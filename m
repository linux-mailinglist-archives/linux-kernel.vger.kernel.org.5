Return-Path: <linux-kernel+bounces-143176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5363C8A3563
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098231F229B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B77714EC44;
	Fri, 12 Apr 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8tIr7YP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1114E2ED
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945439; cv=none; b=joyN5Vc5/8pyGyvP79GpxvCJagJs3mYfIwBbMltYJ9Ff8teeAiueJceRDxNE4fTlQJyufAxHCGq9++Qc0cikUPw10S1/92R1LRJxyamz3wJU34b1nkuzdeXM1Ie9O3yOvNOrMyj2ba5SqcEGbYg2w+BWAfr2HnnkzrrNgGBGiW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945439; c=relaxed/simple;
	bh=OVzb40MuAf19OLIDKMX2DbaQqyFY7kzh0AQPb96onAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QntMOGjrppEn1BcajL3/BQjPZpB+6x7PFYcI4jM8bxQxATd6sfgq8F7er9W0SnYIHwGT8iXv9INKx3CsAmqBTW3mf0J4aV/yR/byqbucPl+BHWPy0nqpMz5Evi8P7h2a7aHlvt/dEMFZ2TXdCy/PNwoZzQLXCUmK55xS7f/tQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8tIr7YP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D00C113CC;
	Fri, 12 Apr 2024 18:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712945439;
	bh=OVzb40MuAf19OLIDKMX2DbaQqyFY7kzh0AQPb96onAk=;
	h=From:To:Cc:Subject:Date:From;
	b=O8tIr7YPF8a9IwVX1NB0QZGx/kqwLhiYVOOcg2emiECUjM2qdWj1EQTtGBX+o4eES
	 xYRp5Gcz7OUOvEUT0t4a9nHlJZJB83+RejkhxEkeJAy+w77RI3Nr1PIYo12hX8KBOT
	 BY1gkplUC91nC9tA6vJFsUZWQdNQxt3B9nchgBnxssdvFMzZzHVvy5xcCwkUk6EDOv
	 wVle4eD9JsCz9LZduNzQoSCzjC+DzX+pigigCbVYCch86uxra1SHRrR1u53wexKqS+
	 uV/CUuTPl5b8oT3T1DRYPVW5dnHNgFe4192JM5+l3BjFBb/o9wwuzP4OGv+y44/5Ko
	 LHYQ9s8LREOkA==
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
Subject: [PATCH 0/3] x86/bugs: BHI fixes / improvements - round 2
Date: Fri, 12 Apr 2024 11:10:31 -0700
Message-ID: <cover.1712944776.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BHI fixes round 2:

- An updated version of "Only harden syscalls when needed" with review
  comments addressed

- A BHI retpoline check fix

- Remove the obsolete LFENCE "retpolines"

Josh Poimboeuf (3):
  x86/bugs: Only harden syscalls when needed
  x86/bugs: Fix BHI retpoline check
  x86/bugs: Remove support for Spectre v2 LFENCE "retpolines"

 arch/x86/Makefile                             |  1 -
 arch/x86/entry/common.c                       | 15 +++-
 arch/x86/entry/syscall_32.c                   | 11 +--
 arch/x86/entry/syscall_64.c                   |  6 --
 arch/x86/entry/syscall_x32.c                  |  7 +-
 arch/x86/include/asm/cpufeatures.h            |  2 +-
 arch/x86/include/asm/disabled-features.h      |  3 +-
 arch/x86/include/asm/nospec-branch.h          | 18 +---
 arch/x86/include/asm/syscall.h                |  8 +-
 arch/x86/kernel/alternative.c                 | 17 +---
 arch/x86/kernel/cpu/bugs.c                    | 88 +++++++------------
 arch/x86/kernel/cpu/cpu.h                     |  3 +-
 arch/x86/lib/retpoline.S                      |  5 +-
 arch/x86/net/bpf_jit_comp.c                   |  5 +-
 tools/arch/x86/include/asm/cpufeatures.h      |  1 -
 .../arch/x86/include/asm/disabled-features.h  |  3 +-
 16 files changed, 69 insertions(+), 124 deletions(-)

-- 
2.44.0


