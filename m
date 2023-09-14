Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4315279F697
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjINBzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjINBzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:55:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC031BD5;
        Wed, 13 Sep 2023 18:55:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA75C43140;
        Thu, 14 Sep 2023 01:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694656508;
        bh=t1Pr/RNuBBUYiftS/aXKvA2dyLKFjLPI0RdyqKx26mY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPGreEU6tMMDK9Svk9eRu0j0d8cmMTcjcsBzD9NHwaetOnMkcT6q/ODzUWS6S00Uc
         LEVpLhcGUMDLLJZ0uPZsetwNVFZ1JpRKfIaUsV9fGKkstgZVNqZz9UiAW6gpju2Br4
         EoE9x0gbdiSkY+4Ah51S1PcVSARk3bC36ap1PhyAZptlKOEfLo6cmdJkox+NodTnt0
         +IJbKIBM5Jrsi2YnUNSHRv6z+1znI/LkKUcMWPpGGE+wLnu1alXNB713ja3pOX2hHy
         HCsWMpjTp56fnLm1xlZfAFYHR3gljZjdPc8VcwrPqfxlIBe4RWba2LIIR310R2QhUP
         kXqn9pycDrfDw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        syzbot+97522333291430dd277f@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>,
        Sasha Levin <sashal@kernel.org>, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 4/7] bpf: Annotate bpf_long_memcpy with data_race
Date:   Wed, 13 Sep 2023 21:54:48 -0400
Message-Id: <20230914015459.51740-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914015459.51740-1-sashal@kernel.org>
References: <20230914015459.51740-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.3
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 6a86b5b5cd76d2734304a0173f5f01aa8aa2025e ]

syzbot reported a data race splat between two processes trying to
update the same BPF map value via syscall on different CPUs:

  BUG: KCSAN: data-race in bpf_percpu_array_update / bpf_percpu_array_update

  write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
   bpf_long_memcpy include/linux/bpf.h:428 [inline]
   bpf_obj_memcpy include/linux/bpf.h:441 [inline]
   copy_map_value_long include/linux/bpf.h:464 [inline]
   bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
   bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
   generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
   bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
   __sys_bpf+0x28a/0x780
   __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
   __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
   __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

  write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:
   bpf_long_memcpy include/linux/bpf.h:428 [inline]
   bpf_obj_memcpy include/linux/bpf.h:441 [inline]
   copy_map_value_long include/linux/bpf.h:464 [inline]
   bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
   bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
   generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
   bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
   __sys_bpf+0x28a/0x780
   __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
   __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
   __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

  value changed: 0x0000000000000000 -> 0xfffffff000002788

The bpf_long_memcpy is used with 8-byte aligned pointers, power-of-8 size
and forced to use long read/writes to try to atomically copy long counters.
It is best-effort only and no barriers are here since it _will_ race with
concurrent updates from BPF programs. The bpf_long_memcpy() is called from
bpf(2) syscall. Marco suggested that the best way to make this known to
KCSAN would be to use data_race() annotation.

Reported-by: syzbot+97522333291430dd277f@syzkaller.appspotmail.com
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/bpf/000000000000d87a7f06040c970c@google.com
Link: https://lore.kernel.org/bpf/57628f7a15e20d502247c3b55fceb1cb2b31f266.1693342186.git.daniel@iogearbox.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830adae..eb1bb76e87f8b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -425,7 +425,7 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
 
 	size /= sizeof(long);
 	while (size--)
-		*ldst++ = *lsrc++;
+		data_race(*ldst++ = *lsrc++);
 }
 
 /* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could be one of each. */
-- 
2.40.1

