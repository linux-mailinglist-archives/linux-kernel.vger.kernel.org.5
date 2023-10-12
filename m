Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ACC7C76F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442670AbjJLTdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442285AbjJLTcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91162ED
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B0FC43391;
        Thu, 12 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139156;
        bh=u/ByFzD4Ej36/aCXkG6Bkh+tE+GTKi/3gaOUP8BZznA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWRBq9Nq+Thv2/uvAXTFN64r5KeSnfsvdBT6R4eppcwd13qGP3piYHIuw2+706PBV
         TsdQDwBzk4cxCfop380Qb1ywbK9gnAe3r58V3UZdrHKXh0JJmWDwAkL50oJcUhI7XJ
         I/PxY4FtDzihWOBBYxVp2wocg8Xcd/Oc4u4bLc94XUFmTw124E2xHI/qMq7zEa25nB
         t967tALqxD2Z2qpy27HjSzcJlhqbucfxqvwz64ZhEi9Ke7d5K3ZpnASIPvPujBcko9
         IHhPbGAtyiSwNiBjxRehoGXFK+6sCDq8fWayhRla6TsWofhIaQtdC6fxrCedhWgThB
         ZmOjslede4QSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 544B0CE0C3E; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH nolibc 10/19] selftests/nolibc: libc-test: avoid -Wstringop-overflow warnings
Date:   Thu, 12 Oct 2023 12:32:24 -0700
Message-Id: <20231012193233.207857-10-paulmck@kernel.org>
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

Newer versions of glibc annotate the poll() function with
__attribute__(access) which triggers a compiler warning inside the
testcase poll_fault.
Avoid this by using a plain NULL which is enough for the testcase.
To avoid potential future warnings also adapt the other EFAULT
testcases, except select_fault as NULL is a valid value for its
argument.

nolibc-test.c: In function ‘run_syscall’:
nolibc-test.c:338:62: warning: ‘poll’ writing 8 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
  338 |         do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
      |                                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
nolibc-test.c:341:9: note: in expansion of macro ‘EXPECT_SYSER2’
  341 |         EXPECT_SYSER2(cond, expr, expret, experr, 0)
      |         ^~~~~~~~~~~~~
nolibc-test.c:905:47: note: in expansion of macro ‘EXPECT_SYSER’
  905 |                 CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll((void *)1, 1, 0), -1, EFAULT); break;
      |                                               ^~~~~~~~~~~~
cc1: note: destination object is likely at address zero
In file included from /usr/include/poll.h:1,
                 from nolibc-test.c:33:
/usr/include/sys/poll.h:54:12: note: in a call to function ‘poll’ declared with attribute ‘access (write_only, 1, 2)’
   54 | extern int poll (struct pollfd *__fds, nfds_t __nfds, int __timeout)
      |            ^~~~

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index fb3bf91462e2..a3ee4496bf0a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -894,14 +894,14 @@ int run_syscall(int min, int max)
 		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
 		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
 		CASE_TEST(mmap_bad);          EXPECT_PTRER(1, mmap(NULL, 0, PROT_READ, MAP_PRIVATE, 0, 0), MAP_FAILED, EINVAL); break;
-		CASE_TEST(munmap_bad);        EXPECT_SYSER(1, munmap((void *)1, 0), -1, EINVAL); break;
+		CASE_TEST(munmap_bad);        EXPECT_SYSER(1, munmap(NULL, 0), -1, EINVAL); break;
 		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
 		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
 		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
 		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
 		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
-		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll((void *)1, 1, 0), -1, EFAULT); break;
+		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll(NULL, 1, 0), -1, EFAULT); break;
 		CASE_TEST(prctl);             EXPECT_SYSER(1, prctl(PR_SET_NAME, (unsigned long)NULL, 0, 0, 0), -1, EFAULT); break;
 		CASE_TEST(read_badf);         EXPECT_SYSER(1, read(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(rmdir_blah);        EXPECT_SYSER(1, rmdir("/blah"), -1, ENOENT); break;
@@ -910,7 +910,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
 		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
 		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
-		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat((void *)1, &stat_buf), -1, EFAULT); break;
+		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
 		CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
 		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;
-- 
2.40.1

