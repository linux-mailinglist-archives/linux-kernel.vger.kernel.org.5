Return-Path: <linux-kernel+bounces-103396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E2087BEDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7CB3B219C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796F06FE30;
	Thu, 14 Mar 2024 14:27:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFE6FE0E;
	Thu, 14 Mar 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426466; cv=none; b=eS5pB4ImN9QaNrXiElX7iGLyE0Vpkxve6VbyyQ7P9d9LT9qvkJA6yGd/VHW+V+rvqi5+j86/qqC0pYkYByhx4EiBpFcu5r3D17WCZG7N7bgG65dpxPNbrXzPKe3y13Hw0oVc1ktTx+AGdNk6LK6WypNcnzhACMP+YiEOZbWreH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426466; c=relaxed/simple;
	bh=QQT9AA2zZonsQUQxARfHUwH+9Hy/0C//Drq/MOzR3pg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sU28tDgfFBjuNU9zNyvV+bWkq1KVUnWknDz4HMUkXmDyUZNNqySaMCv9gBooEth3afk08BVwd7J5E99chAj8uWUqYF+ozhpxtN9MeU+GqvhHbM1zP2+Uh8CEx/dU+xOTwIg2exCL9yUkOWNVD1/3ZywK92Y/tuO7Z9NEAz9iucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0086C433C7;
	Thu, 14 Mar 2024 14:27:41 +0000 (UTC)
From: Anton Altaparmakov <anton@tuxera.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Chen Yu <yu.c.chen@intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-mm@kvack.org,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anton Altaparmakov <anton@tuxera.com>,
	stable@vger.kernel.org
Subject: [PATCH] x86/pm: Fix false positive kmemleak report in msr_build_context().
Date: Thu, 14 Mar 2024 14:26:56 +0000
Message-Id: <20240314142656.17699-1-anton@tuxera.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since

  7ee18d677989 ("x86/power: Make restore_processor_context() sane")

kmemleak reports this issue:

unreferenced object 0xf68241e0 (size 32):
  comm "swapper/0", pid 1, jiffies 4294668610 (age 68.432s)
  hex dump (first 32 bytes):
    00 cc cc cc 29 10 01 c0 00 00 00 00 00 00 00 00  ....)...........
    00 42 82 f6 cc cc cc cc cc cc cc cc cc cc cc cc  .B..............
  backtrace:
    [<461c1d50>] __kmem_cache_alloc_node+0x106/0x260
    [<ea65e13b>] __kmalloc+0x54/0x160
    [<c3858cd2>] msr_build_context.constprop.0+0x35/0x100
    [<46635aff>] pm_check_save_msr+0x63/0x80
    [<6b6bb938>] do_one_initcall+0x41/0x1f0
    [<3f3add60>] kernel_init_freeable+0x199/0x1e8
    [<3b538fde>] kernel_init+0x1a/0x110
    [<938ae2b2>] ret_from_fork+0x1c/0x28

Reproducer:

- Run rsync of whole kernel tree (multiple times if needed).
- start a kmemleak scan
- Note this is just an example: a lot of our internal tests hit these.

The root cause is we expect the same as the equivalent fix in commit
b0b592cf0836, i.e. the alignment within the packed struct saved_context
which has everything unaligned as there is only "u16 gs;" at start of
struct where in the past there were four u16 there thus aligning
everything afterwards.  The issue is with the fact that Kmemleak only
searches for pointers that are aligned (see how pointers are scanned in
kmemleak.c) so when the struct members are not aligned it doesn't see
them.

Note we have picked this up on 5.4, 6.1 and 6.6 kernels but we expect it
is the same on all kernels >= 4.15 as the commit 7ee18d677989 which
changed from having four u16 to a single u16 at the start of the struct
was introduced in 4.15.

Fixes: 7ee18d677989 ("x86/power: Make restore_processor_context() sane")
Signed-off-by: Anton Altaparmakov <anton@tuxera.com>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/suspend_32.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index a800abb1a992..d8416b3bf832 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -12,11 +12,6 @@
 
 /* image of the saved processor state */
 struct saved_context {
-	/*
-	 * On x86_32, all segment registers except gs are saved at kernel
-	 * entry in pt_regs.
-	 */
-	u16 gs;
 	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
 	struct saved_msrs saved_msrs;
@@ -27,6 +22,11 @@ struct saved_context {
 	unsigned long tr;
 	unsigned long safety;
 	unsigned long return_address;
+	/*
+	 * On x86_32, all segment registers except gs are saved at kernel
+	 * entry in pt_regs.
+	 */
+	u16 gs;
 	bool misc_enable_saved;
 } __attribute__((packed));
 
-- 
2.39.3 (Apple Git-146)


