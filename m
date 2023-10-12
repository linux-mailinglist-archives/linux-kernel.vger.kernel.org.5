Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D6D7C76F3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442688AbjJLTdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442316AbjJLTcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997EFE4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365CAC433AB;
        Thu, 12 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139156;
        bh=D8WmWSdjmqDotCTIny5KPDkHdNvvxPLSrd63TdlisnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RHLwSsGWiK5Auz6rJyJMdNuFODjmPjM93DlLx397AdEO0rjXL7Uj2MSghnQzpNGPX
         QAQ4rEsbUocWvUvcTcKSN3JJith5ORSdH7CmZICqXagBgOpU2yfK8xGagZ9/8S7Ur5
         JedBfkUCXkd3ge7yqnhF0SPaLrEmRcrWLms2uSRdFn144xI/v8uVBvr9jjHwuI/xwl
         dZM5n7tH0/sdHMEc2wYWUdrf5HxdpqU3Yre6CWlDnCvJezSBGIJeh7eIqwDDRCoTGY
         9JHDETK7yVoKrlltr+gJSTgyKRuwkvngmctrmd7ecBlOCkIMHDoEZpZqSoWhiwDvDH
         v5Jb9EOmL+P+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5BBFDCE0DDC; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH nolibc 13/19] tools/nolibc: avoid unused parameter warnings for ENOSYS fallbacks
Date:   Thu, 12 Oct 2023 12:32:27 -0700
Message-Id: <20231012193233.207857-13-paulmck@kernel.org>
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

The ENOSYS fallback code does not use its functions parameters.
This can lead to compiler warnings about unused parameters.

Explicitly avoid these warnings.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/r/20230917-nolibc-syscall-nr-v2-2-03863d509b9a@weissschuh.net
---
 tools/include/nolibc/sys.h | 44 +++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index b478750c9004..8389820e1928 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -43,6 +43,16 @@
 		: __sysret_arg;                         /* return original value */ \
 })
 
+/* Syscall ENOSYS helper: Avoids unused-parameter warnings and provides a
+ * debugging hook.
+ */
+
+static __inline__ int __nolibc_enosys(const char *syscall, ...)
+{
+	(void)syscall;
+	return -ENOSYS;
+}
+
 
 /* Functions in this file only describe syscalls. They're declared static so
  * that the compiler usually decides to inline them while still being allowed
@@ -133,7 +143,7 @@ int sys_chmod(const char *path, mode_t mode)
 #elif defined(__NR_chmod)
 	return my_syscall2(__NR_chmod, path, mode);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, path, mode);
 #endif
 }
 
@@ -156,7 +166,7 @@ int sys_chown(const char *path, uid_t owner, gid_t group)
 #elif defined(__NR_chown)
 	return my_syscall3(__NR_chown, path, owner, group);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, path, owner, group);
 #endif
 }
 
@@ -230,7 +240,7 @@ int sys_dup2(int old, int new)
 #elif defined(__NR_dup2)
 	return my_syscall2(__NR_dup2, old, new);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, old, new);
 #endif
 }
 
@@ -312,7 +322,7 @@ pid_t sys_fork(void)
 #elif defined(__NR_fork)
 	return my_syscall0(__NR_fork);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__);
 #endif
 }
 #endif
@@ -486,7 +496,7 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 #ifdef __NR_gettimeofday
 	return my_syscall2(__NR_gettimeofday, tv, tz);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, tv, tz);
 #endif
 }
 
@@ -563,7 +573,7 @@ int sys_link(const char *old, const char *new)
 #elif defined(__NR_link)
 	return my_syscall2(__NR_link, old, new);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, old, new);
 #endif
 }
 
@@ -584,7 +594,7 @@ off_t sys_lseek(int fd, off_t offset, int whence)
 #ifdef __NR_lseek
 	return my_syscall3(__NR_lseek, fd, offset, whence);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, fd, offset, whence);
 #endif
 }
 
@@ -607,7 +617,7 @@ int sys_mkdir(const char *path, mode_t mode)
 #elif defined(__NR_mkdir)
 	return my_syscall2(__NR_mkdir, path, mode);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, path, mode);
 #endif
 }
 
@@ -629,7 +639,7 @@ int sys_rmdir(const char *path)
 #elif defined(__NR_unlinkat)
 	return my_syscall3(__NR_unlinkat, AT_FDCWD, path, AT_REMOVEDIR);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, path);
 #endif
 }
 
@@ -652,7 +662,7 @@ long sys_mknod(const char *path, mode_t mode, dev_t dev)
 #elif defined(__NR_mknod)
 	return my_syscall3(__NR_mknod, path, mode, dev);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, path, mode, dev);
 #endif
 }
 
@@ -742,7 +752,7 @@ int sys_open(const char *path, int flags, mode_t mode)
 #elif defined(__NR_open)
 	return my_syscall3(__NR_open, path, flags, mode);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, path, flags, mode);
 #endif
 }
 
@@ -842,7 +852,7 @@ int sys_poll(struct pollfd *fds, int nfds, int timeout)
 #elif defined(__NR_poll)
 	return my_syscall3(__NR_poll, fds, nfds, timeout);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, fds, nfds, timeout);
 #endif
 }
 
@@ -934,7 +944,7 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 #endif
 	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, nfds, rfds, wfds, efds, timeout);
 #endif
 }
 
@@ -989,7 +999,7 @@ int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct sta
 #ifdef __NR_statx
 	return my_syscall5(__NR_statx, fd, path, flags, mask, buf);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, fd, path, flags, mask, buf);
 #endif
 }
 
@@ -1047,7 +1057,7 @@ int sys_symlink(const char *old, const char *new)
 #elif defined(__NR_symlink)
 	return my_syscall2(__NR_symlink, old, new);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, old, new);
 #endif
 }
 
@@ -1104,7 +1114,7 @@ int sys_unlink(const char *path)
 #elif defined(__NR_unlink)
 	return my_syscall1(__NR_unlink, path);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, path);
 #endif
 }
 
@@ -1127,7 +1137,7 @@ pid_t sys_wait4(pid_t pid, int *status, int options, struct rusage *rusage)
 #ifdef __NR_wait4
 	return my_syscall4(__NR_wait4, pid, status, options, rusage);
 #else
-	return -ENOSYS;
+	return __nolibc_enosys(__func__, pid, status, options, rusage);
 #endif
 }
 
-- 
2.40.1

