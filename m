Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C8D7C76FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442778AbjJLTdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442348AbjJLTcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF658E3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FC6C433B6;
        Thu, 12 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139156;
        bh=TkAOAZUUquEC/SVcrwpY1Lnr3+lwFbze2yyE+P3apL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RsAhwNai9jEsJF0WuQAdObMqc8i/7+jCDlQmFkI3yPc6csW9jO8ZWX9TT6SMOu0Bv
         pnvXJJ/88ZkOs12lZybvCSiiCTgyvp88IiQt9M1e43MPbRhb+Rw7wQm+TRz71P4u0f
         jnVzH/ufeeOH7F0XSff4TvteXRJH/dKVYEmCKDV/BgWT0Io+vYv50lP5hvUXj2K/+Y
         7b0zQNVUVupGMX1nqQHcnrT4YMcpE3gvIHHcnDlEpnAnIrO/a+qNKMqHxXMlfjWHKj
         bbxrm9EtB7c/pUD+nlv+/X0RQa/K/xIbihwViEqzWEyAqsg5rqNBzy3RlGgksiU2Rv
         lxbJTHN4QNKiA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 605C3CE0DEA; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH nolibc 15/19] tools/nolibc: automatically detect necessity to use pselect6
Date:   Thu, 12 Oct 2023 12:32:29 -0700
Message-Id: <20231012193233.207857-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
References: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

We can automatically detect if pselect6 is needed or not from the kernel
headers. This removes the need to manually specify it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/r/20230917-nolibc-syscall-nr-v2-4-03863d509b9a@weissschuh.net
---
 tools/include/nolibc/arch-aarch64.h   |  3 ---
 tools/include/nolibc/arch-loongarch.h |  4 +---
 tools/include/nolibc/arch-riscv.h     |  3 ---
 tools/include/nolibc/sys.h            | 10 +++++-----
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 6c33c46848e3..b23ac1f04035 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -20,10 +20,7 @@
  *   - the arguments are cast to long and assigned into the target registers
  *     which are then simply passed as registers to the asm code, so that we
  *     don't have to experience issues with register constraints.
- *
- * On aarch64, select() is not implemented so we have to use pselect6().
  */
-#define __ARCH_WANT_SYS_PSELECT6
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index bf98f6220195..3f8ef8f86c0f 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -19,10 +19,8 @@
  *   - the arguments are cast to long and assigned into the target
  *     registers which are then simply passed as registers to the asm code,
  *     so that we don't have to experience issues with register constraints.
- *
- * On LoongArch, select() is not implemented so we have to use pselect6().
  */
-#define __ARCH_WANT_SYS_PSELECT6
+
 #define _NOLIBC_SYSCALL_CLOBBERLIST \
 	"memory", "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$t8"
 
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 950cc2283fd7..1927c643c739 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -19,10 +19,7 @@
  *   - the arguments are cast to long and assigned into the target
  *     registers which are then simply passed as registers to the asm code,
  *     so that we don't have to experience issues with register constraints.
- *
- * On riscv, select() is not implemented so we have to use pselect6().
  */
-#define __ARCH_WANT_SYS_PSELECT6
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index f05144e46b67..2f359cb03d10 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -930,7 +930,11 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 		struct timeval *t;
 	} arg = { .n = nfds, .r = rfds, .w = wfds, .e = efds, .t = timeout };
 	return my_syscall1(__NR_select, &arg);
-#elif defined(__ARCH_WANT_SYS_PSELECT6) && defined(__NR_pselect6)
+#elif defined(__NR__newselect)
+	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
+#elif defined(__NR_select)
+	return my_syscall5(__NR_select, nfds, rfds, wfds, efds, timeout);
+#elif defined(__NR_pselect6)
 	struct timespec t;
 
 	if (timeout) {
@@ -938,10 +942,6 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 		t.tv_nsec = timeout->tv_usec * 1000;
 	}
 	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
-#elif defined(__NR__newselect)
-	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
-#elif defined(__NR_select)
-	return my_syscall5(__NR_select, nfds, rfds, wfds, efds, timeout);
 #else
 	return __nolibc_enosys(__func__, nfds, rfds, wfds, efds, timeout);
 #endif
-- 
2.40.1

