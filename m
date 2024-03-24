Return-Path: <linux-kernel+bounces-115279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E688939D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA02B25D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F323E15E218;
	Mon, 25 Mar 2024 02:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qazjXgRv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78797EEFE;
	Sun, 24 Mar 2024 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320474; cv=none; b=JcMsoq4Hn/bUulLbUTc6LRTBMK101e+F1KozR7ipGgPFw9J1k840iQL/lH/3EwNk6Naqq23sRtcRZzfRHGQSI8jnbvregsvUfiMfeTDk5xnJUSA5lL7ouHLztnG/UhsPivnLD3QplZrTFaNuLgBa85VrO61MuR0E7ssu4mxPHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320474; c=relaxed/simple;
	bh=Vo3k/UgoRrmyUGzlldwCCqinbenvGMIr4yM+BJI4MQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZvIQ1X7iOL3MP3E4tXIbeAvaXHjXnbF/NfR/dpmTZLO/jNTUMLn/of2fnwhEwMZ7nwWvnZnh6aQrVJRxaDdvmSpdjDn5B9Cu3njDVRymvYNSkjhob1Jxr9N7xrUcsALGQG2AlA30GvxGfpIkU06BnA/0AXXWtKnsj7Hn9eLdks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qazjXgRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5744CC433C7;
	Sun, 24 Mar 2024 22:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320474;
	bh=Vo3k/UgoRrmyUGzlldwCCqinbenvGMIr4yM+BJI4MQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qazjXgRv7oAG4OxmXfUTnI8s1S43mScRJT/onwIQ38L2d6qW/QcrH+2njcLXrRTn4
	 PUyaPMNuU1OihDiRe+am/fwZAyB8i0t5+YAAutABc7BFuy+ADT8XEBdA505t/emb/2
	 wGqZqzlx9mlcKy/EGetX7jZwjCipow6nuEYLq/Y4+TMZ+E9Hv3zKLTAAn7sWwgav9P
	 PNmXKdd4UFVfI5uHMmnzqwLWNIyLlHUcrKrO2IytiwSGS9xslk2HFdQmhnE6U+eh2y
	 ix7BM30EamoDkg/gUQQyxEcEE0atn98JSF0NnL0Uo/CN9TIqzznz4/cKDV9gdr2jA/
	 eyFceN4QxQ8fg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com,
	xingwei lee <xrivendell7@gmail.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 033/713] x86/mm: Disallow vsyscall page read for copy_from_kernel_nofault()
Date: Sun, 24 Mar 2024 18:35:59 -0400
Message-ID: <20240324224720.1345309-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 32019c659ecfe1d92e3bf9fcdfbb11a7c70acd58 ]

When trying to use copy_from_kernel_nofault() to read vsyscall page
through a bpf program, the following oops was reported:

  BUG: unable to handle page fault for address: ffffffffff600000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 3231067 P4D 3231067 PUD 3233067 PMD 3235067 PTE 0
  Oops: 0000 [#1] PREEMPT SMP PTI
  CPU: 1 PID: 20390 Comm: test_progs ...... 6.7.0+ #58
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
  RIP: 0010:copy_from_kernel_nofault+0x6f/0x110
  ......
  Call Trace:
   <TASK>
   ? copy_from_kernel_nofault+0x6f/0x110
   bpf_probe_read_kernel+0x1d/0x50
   bpf_prog_2061065e56845f08_do_probe_read+0x51/0x8d
   trace_call_bpf+0xc5/0x1c0
   perf_call_bpf_enter.isra.0+0x69/0xb0
   perf_syscall_enter+0x13e/0x200
   syscall_trace_enter+0x188/0x1c0
   do_syscall_64+0xb5/0xe0
   entry_SYSCALL_64_after_hwframe+0x6e/0x76
   </TASK>
  ......
  ---[ end trace 0000000000000000 ]---

The oops is triggered when:

1) A bpf program uses bpf_probe_read_kernel() to read from the vsyscall
page and invokes copy_from_kernel_nofault() which in turn calls
__get_user_asm().

2) Because the vsyscall page address is not readable from kernel space,
a page fault exception is triggered accordingly.

3) handle_page_fault() considers the vsyscall page address as a user
space address instead of a kernel space address. This results in the
fix-up setup by bpf not being applied and a page_fault_oops() is invoked
due to SMAP.

Considering handle_page_fault() has already considered the vsyscall page
address as a userspace address, fix the problem by disallowing vsyscall
page read for copy_from_kernel_nofault().

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/CAG48ez06TZft=ATH1qh2c5mpS5BT8UakwNkzi6nvK5_djC-4Nw@mail.gmail.com
Reported-by: xingwei lee <xrivendell7@gmail.com>
Closes: https://lore.kernel.org/bpf/CABOYnLynjBoFZOf3Z4BhaZkc5hx_kHfsjiW+UWLoB=w33LvScw@mail.gmail.com
Signed-off-by: Hou Tao <houtao1@huawei.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240202103935.3154011-3-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/maccess.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
index 6993f026adec9..42115ac079cfe 100644
--- a/arch/x86/mm/maccess.c
+++ b/arch/x86/mm/maccess.c
@@ -3,6 +3,8 @@
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 
+#include <asm/vsyscall.h>
+
 #ifdef CONFIG_X86_64
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
@@ -15,6 +17,14 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 	if (vaddr < TASK_SIZE_MAX + PAGE_SIZE)
 		return false;
 
+	/*
+	 * Reading from the vsyscall page may cause an unhandled fault in
+	 * certain cases.  Though it is at an address above TASK_SIZE_MAX, it is
+	 * usually considered as a user space address.
+	 */
+	if (is_vsyscall_vaddr(vaddr))
+		return false;
+
 	/*
 	 * Allow everything during early boot before 'x86_virt_bits'
 	 * is initialized.  Needed for instruction decoding in early
-- 
2.43.0


