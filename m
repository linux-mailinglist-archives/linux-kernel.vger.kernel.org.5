Return-Path: <linux-kernel+bounces-154845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDAC8AE1DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F5DB20F03
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA7F605CE;
	Tue, 23 Apr 2024 10:13:48 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3B254BF7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867227; cv=none; b=tzxM0uX72e+bpu/Kr9oqzFn+0FBA1ciNC97F+DLI/Uwcny26BIYJnn0pK38lflgXcAjFpPVRRb9BfbpL7Wa+Af7k8opKZaZwcCQoDWbabVhSLJh8QbSzj98MZtVmA21n6Y4emjoGHkpT9LBIbZ8w4PYlqjp6DoRCYaug7H0+/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867227; c=relaxed/simple;
	bh=exKsQQI+SVpy3NWrsM6z84rlDwOJ4z0c0uu0gCoMWs8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=E6txadllFYvh7BlOK5mVLCcp1yj3gX1ZjtmxjoYv51PPjNXb/J4bHiUOnaLpRyyZJ25Pk7ZrX6MEqDwzVi+4Pklm3RdN6DnxO97aNQCztpGljAO0VAMonUSWvQ0xEB1Eyh3Gl2WkJQtg6TpnZ4bUfM2GpOB4yplFfr72u/bEUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-a0-662789ce657b
From: Byungchul Park <byungchul@sk.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jbohac@suse.cz,
	dyoung@redhat.com
Cc: kernel_team@skhynix.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/e820: apply 'mem=' boot command while reserving memory using boot_params
Date: Tue, 23 Apr 2024 19:13:23 +0900
Message-Id: <20240423101323.40968-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LhesuzUPdcp3qaQcdMYYvPG/6xWbzY0M5o
	0TCxgcVi2kZxixsHN7NZXN41h83i0oEFTBabN01ltvix4TGrA6fH99Y+Fo9NqzrZPN6dO8fu
	Me9koMf7fVfZPM4sOMLu8XmTnMeJli+sARxRXDYpqTmZZalF+nYJXBnTuo+xF/wQrHj78Ctj
	A+Nlvi5GTg4JAROJiVMmMsHYk25+ZgGx2QTUJW7c+MncxcjFISKwmFHixLt3rCAJZgFriTuH
	u8CKhAViJeZf3sEGYrMIqEqc+3oazOYVMJW49/YyC8RQeYnVGw4wQ9iNbBI33wpB2JISB1fc
	YJnAyL2AkWEVo1BmXlluYmaOiV5GZV5mhV5yfu4mRmAwLav9E72D8dOF4EOMAhyMSjy8DL/U
	0oRYE8uKK3MPMUpwMCuJ8P76o5ImxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6Yklq
	dmpqQWoRTJaJg1OqgXHp0aUVufKHi1wj+jrKohWU/y1kDtR6pXa2/q5UdtHTneWvTNWCW24W
	2qx6PGWaQJAm46OdkxTbI807t6132lLl3fD68fcrJ/O/pjx+es+GY+FJlduHz+283/X+RLbm
	+WoZbUaVhHiryXxSHCeZHlY35Ob4P3/t9fMn4ynmZSU2388qXHqz/JYSS3FGoqEWc1FxIgBt
	LZREIgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOJMWRmVeSWpSXmKPExsXC5WfdrHuuUz3NYPokNovPG/6xWbzY0M5o
	0TCxgcVi2kZxixsHN7NZHJ57ktXi8q45bBaXDixgsti8aSqzxY8Nj1kduDy+t/axeGxa1cnm
	8e7cOXaPeScDPd7vu8rmsfjFByaPMwuOsHt83iTncaLlC2sAZxSXTUpqTmZZapG+XQJXxrTu
	Y+wFPwQr3j78ytjAeJmvi5GTQ0LARGLSzc8sIDabgLrEjRs/mbsYuThEBBYzSpx4944VJMEs
	YC1x53AXWJGwQKzE/Ms72EBsFgFViXNfT4PZvAKmEvfeXmaBGCovsXrDAeYJjBwLGBlWMYpk
	5pXlJmbmmOoVZ2dU5mVW6CXn525iBAbHsto/E3cwfrnsfohRgINRiYf3xye1NCHWxLLiytxD
	jBIczEoivL/+qKQJ8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJx
	cEo1MFr4Xjr43m+DfYNc9ZVFRw7sSud7dHnyf7u7Eac11cXtKxZ+ebf3wPw0mTbPWBnvcxfe
	TN/RoautoSp45bJK4/eYh0yPMia8dQwMcz3rnjh1xV6Wq+1hZrdEDAxmeSy4nZhh/bbtmVtP
	+q6X15iWmLd7nyxTP7yaY9rkI+nLX6V5mO/oEpm3KEOJpTgj0VCLuag4EQChPUY4CgIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

I might miss something.  Please lemme know if I go wrong.  Thanks.

	Byungchul

--->8---
From 51f3b5b9bf9685aa431c00908771151edd702483 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Tue, 23 Apr 2024 18:54:48 +0900
Subject: [PATCH] x86/e820: apply 'mem=' boot command while reserving memory
 using boot_params

When a user specifies 'mem=' boot command, it's expected to limit the
maximum address of usable memory for the kernel no matter what the
memory map source is.  However, 'mem=' boot command doesn't work since
it doesn't respect it when reserving memory using boot_params.

Applied the restriction when reserving memory using boot_params.  While
at it, renamed mem_size to a more specific name, boot_mem_limit.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/kernel/e820.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 6f1b379e3b38..af9d1d95ef5a 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -880,11 +880,11 @@ static void __init early_panic(char *msg)
 
 static int userdef __initdata;
 
+static u64 boot_mem_limit = U64_MAX;
+
 /* The "mem=nopentium" boot option disables 4MB page tables on 32-bit kernels: */
 static int __init parse_memopt(char *p)
 {
-	u64 mem_size;
-
 	if (!p)
 		return -EINVAL;
 
@@ -899,16 +899,16 @@ static int __init parse_memopt(char *p)
 	}
 
 	userdef = 1;
-	mem_size = memparse(p, &p);
+	boot_mem_limit = memparse(p, &p);
 
 	/* Don't remove all memory when getting "mem={invalid}" parameter: */
-	if (mem_size == 0)
+	if (boot_mem_limit == 0)
 		return -EINVAL;
 
-	e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
+	e820__range_remove(boot_mem_limit, ULLONG_MAX - boot_mem_limit, E820_TYPE_RAM, 1);
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-	max_mem_size = mem_size;
+	max_mem_size = boot_mem_limit;
 #endif
 
 	return 0;
@@ -1036,6 +1036,8 @@ void __init e820__reserve_setup_data(void)
 		early_memunmap(data, len);
 	}
 
+	e820__range_remove(boot_mem_limit, ULLONG_MAX - boot_mem_limit,
+			E820_TYPE_RESERVED_KERN, 1);
 	e820__update_table(e820_table);
 
 	pr_info("extended physical RAM map:\n");
-- 
2.17.1


