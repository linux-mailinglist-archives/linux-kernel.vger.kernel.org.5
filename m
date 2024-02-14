Return-Path: <linux-kernel+bounces-65137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A533885487A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D1A1F21E33
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B77C199C2;
	Wed, 14 Feb 2024 11:35:55 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8CA19475;
	Wed, 14 Feb 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910554; cv=none; b=AjuwRN5nU4tf20dRE77ZbYzRvpzifN6Bb40btlMs0nkx6VblCI61h9cxcFEWeR5UPbcAHiS7XdZZbGlNc2uPN3Ki0m7G1MCqzYIxMQIP9OqjEfNfJiO3fYBNGBd/mWsltEPYJXznx9mhCPmyYgWmxa+cB8bv6MF1rAs8V4uVDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910554; c=relaxed/simple;
	bh=eSoQbLlaL9f781kXxig0KToQ/eN3Fw1j108K7hbPQKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nhcpVSycnODbY/2W2h3ae4+7qoLr/YPelh0AUrw+48wnmn7KafbsSOi3TlB+aKs/EJSGWB+4j/CR2Q6ZievcTqCwL41ifNiKs1rQiVD7p9cDdU36LYAt7MxqVdyeTJPvhUfcyv+pd3gxvEfCAWLKptFSsnwkCk9YrzxJCjpYEEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TZbHb0dXxz9y62N;
	Wed, 14 Feb 2024 19:16:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 18AF81405F3;
	Wed, 14 Feb 2024 19:35:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAHshp7pcxlDJx9Ag--.51624S2;
	Wed, 14 Feb 2024 12:35:39 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Xin Li <xin3.li@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ze Gao <zegao2021@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <jroedel@suse.de>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH v1 0/8] x86_64 SandBox Mode arch hooks
Date: Wed, 14 Feb 2024 12:35:08 +0100
Message-Id: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHshp7pcxlDJx9Ag--.51624S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF1rJw1fGryUuF1fCrg_yoW8ZF1xpF
	9rArs5KF4qga4avFZ3Grn7ZryfAw1kCw4rKFn7W34Yqa4aqa4UJrs3KanrX3yrZ3yUGFyF
	qF1YvF10gw1jyaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU-yCJUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

This patch series implements x86_64 arch hooks for the generic SandBox
Mode infrastructure.

SandBox Mode on x86_64 is implemented as follows:

* The target function runs with CPL 3 (same as user mode) within its
  own virtual address space.
* Interrupt entry/exit paths are modified to let the interrupt handlers
  always run with kernel CR3 and restore sandbox CR3 when returning to
  sandbox mode.
* To avoid undesirable user mode processing (FPU state, signals, etc.),
  the value of pt_regs->cs is temporarily adjusted to make it look like
  coming from kernel mode.
* On a CPU fault, execution stops immediately, returning -EFAULT to
  the caller.

Petr Tesarik (8):
  sbm: x86: page table arch hooks
  sbm: x86: execute target function on sandbox mode stack
  sbm: x86: map system data structures into the sandbox
  sbm: x86: allocate and map an exception stack
  sbm: x86: handle sandbox mode faults
  sbm: x86: switch to sandbox mode pages in arch_sbm_exec()
  sbm: documentation of the x86-64 SandBox Mode implementation
  sbm: x86: lazy TLB flushing

 Documentation/security/sandbox-mode.rst |  25 ++
 arch/x86/Kconfig                        |   1 +
 arch/x86/entry/entry_64.S               | 123 ++++++
 arch/x86/include/asm/page_64_types.h    |   1 +
 arch/x86/include/asm/ptrace.h           |  21 +
 arch/x86/include/asm/sbm.h              |  83 ++++
 arch/x86/include/asm/segment.h          |   7 +
 arch/x86/include/asm/thread_info.h      |   3 +
 arch/x86/kernel/Makefile                |   2 +
 arch/x86/kernel/asm-offsets.c           |  10 +
 arch/x86/kernel/sbm/Makefile            |  16 +
 arch/x86/kernel/sbm/call_64.S           |  95 +++++
 arch/x86/kernel/sbm/core.c              | 499 ++++++++++++++++++++++++
 arch/x86/kernel/traps.c                 |  14 +-
 arch/x86/mm/fault.c                     |   6 +
 15 files changed, 905 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/sbm.h
 create mode 100644 arch/x86/kernel/sbm/Makefile
 create mode 100644 arch/x86/kernel/sbm/call_64.S
 create mode 100644 arch/x86/kernel/sbm/core.c

-- 
2.34.1


