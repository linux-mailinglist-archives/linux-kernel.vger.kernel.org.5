Return-Path: <linux-kernel+bounces-160510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047CE8B3E75
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57200B22E74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1960615E5D0;
	Fri, 26 Apr 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Alc/Ff+z"
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29C01DDF8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714153248; cv=none; b=uxP954Ux7PeIUmhu/695WScww4yBGIn5cP++5pNUENfv9XoYcrSRKfss1xIhCoMRuAtemK9yPSHJ92xu07OFh6NoCz7mKiY/WbwWIaihuVrWfVFJ9POFq6rtNoPQ3XfOIpRobT86uVFzgPHZL/jv3UXvxEnUI7nnZBvZuMCtOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714153248; c=relaxed/simple;
	bh=CQBiIeVTKBpDd91iYuqIIzq3XnC8Q4yWuXaprTtqOFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhRLQdS2beLrgx6Mw9YGAPbrRJGWORMPy1tjIi14gDp3ErwSVpr8z8bUnIP9VoN09LKrKLfLEBPFka0z1BeRZwqronJjZWm7O1qHMzJjga1CI0X2Cev8oXwdH7r4IasmFEJMk/w1pAFAoq1Q+9/+SDYz7h/u9G46I+EaXcCawTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Alc/Ff+z; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VR0184XrKzXZt;
	Fri, 26 Apr 2024 19:23:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714152188;
	bh=CQBiIeVTKBpDd91iYuqIIzq3XnC8Q4yWuXaprTtqOFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Alc/Ff+zUYtVfEFUxhg2vFb0uqi/XpKcMtiYKj4YgB1ib4V5/Gn7UNS6e2YElnRB6
	 E6OHfBsMEwtyMjvV3Skj5ZboRIibBCXgaF7IAA6PRVLnnUbGANaSXTa18se2aVVlL1
	 r1F5gksDlqVRyUnqobnTpbMn9RPIu/B8E8B5BVRg=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VR0180Yq0zgR1;
	Fri, 26 Apr 2024 19:23:08 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v1 4/5] selftests/harness: Fix interleaved scheduling leading to race conditions
Date: Fri, 26 Apr 2024 19:22:51 +0200
Message-ID: <20240426172252.1862930-5-mic@digikod.net>
In-Reply-To: <20240426172252.1862930-1-mic@digikod.net>
References: <20240426172252.1862930-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Fix a race condition when running several FIXTURE_TEARDOWN() managing
the same resource.  This fixes a race condition in the Landlock file
system tests when creating or unmounting the same directory.

Using clone3() with CLONE_VFORK guarantees that the child and grandchild
test processes are sequentially scheduled.  This is implemented with a
new clone3_vfork() helper replacing the fork() call.

This avoids triggering this error in __wait_for_test():
  Test ended in some other way [127]

Cc: Christian Brauner <brauner@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Günther Noack <gnoack@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Drewry <wad@chromium.org>
Fixes: 41cca0542d7c ("selftests/harness: Fix TEST_F()'s vfork handling")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240426172252.1862930-5-mic@digikod.net
---
 tools/testing/selftests/kselftest_harness.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 73491efbae9e..d2dd246a3843 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -67,6 +67,8 @@
 #include <sys/wait.h>
 #include <unistd.h>
 #include <setjmp.h>
+#include <syscall.h>
+#include <linux/sched.h>
 
 #include "kselftest.h"
 
@@ -81,6 +83,17 @@
 #  define TH_LOG_ENABLED 1
 #endif
 
+/* Wait for the child process to end but without sharing memory mapping. */
+static pid_t __attribute__((__unused__)) clone3_vfork(void)
+{
+	struct clone_args args = {
+		.flags = CLONE_VFORK,
+		.exit_signal = SIGCHLD,
+	};
+
+	return syscall(__NR_clone3, &args, sizeof(args));
+}
+
 /**
  * TH_LOG()
  *
@@ -1180,7 +1193,7 @@ void __run_test(struct __fixture_metadata *f,
 	fflush(stdout);
 	fflush(stderr);
 
-	t->pid = fork();
+	t->pid = clone3_vfork();
 	if (t->pid < 0) {
 		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
 		t->exit_code = KSFT_FAIL;
-- 
2.44.0


