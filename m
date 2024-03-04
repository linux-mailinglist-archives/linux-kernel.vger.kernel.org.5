Return-Path: <linux-kernel+bounces-91071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B906E870933
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC881C23CD3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCDA626CC;
	Mon,  4 Mar 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUw/L3NB"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404D626AE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575917; cv=none; b=C6RDmaD4yLTz2ZZfeX/YJs5ydyeTwYAGog/pmcItN5nGIafKRpe3GY6PLjmjO78o7uHj4jjR7+IUfyIOICr5Vmgi13k4qhFyMx05zbuFOqD4zesvyaR827CTtmIFUKd3ZUcc+w2zfLnUAkzfzrk8Zjelsf2J9zKV+7gHXduFqls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575917; c=relaxed/simple;
	bh=MScqXbgh2ejjfIy/Sp3FOyl/aojS0G+mf0C488clcqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gs3C89aH8Hu4Kgx0aAY8e3Ga6e7noDwzFWLy+m6Ja+I90dyICY9beJEZ8JhVngPaewlTug1Vhm1XQDqI5bL+o5R5211UtcW3YGmEvE2cMBu+bCGOQs6xACVxSPIxcsMXosMthCJ63OLBsDDsFqdwbeCbXcVS86b80HRKquon3U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JUw/L3NB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e634f550c4so301579b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709575915; x=1710180715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs5vwdtP3lE2gaF2HIymTQhqiVBDxVfpiBYTXFLcGDM=;
        b=JUw/L3NB0Dee2aoGsJHgkI6pdaKAYqQ7kYe6uYcFEsfnbmbUO1qZSTcaT/6ceXIQbX
         Wj2G39IvAAZTCXjHeP9jTimdSrjExtSPy1UQRL236DqzvxsNRKn7JIRoP5rxYv9LU4Ws
         Rn0GhA5ZeljYKuKHrI8wKEU70rHH+GOklsETM2TZtp+BvJIfblmclfFFmqv/42P+OKOA
         aS8M5GEjNqdPFs61pFShgFbwOSdkxRJREY2CUOhcJzxHFAAotwkUy4w3AQkotPogrYDg
         oH0ltFqhDyl06LA8RE6qATr6XaRclhGzc3M0A6dlp/YtHdVdQ2JPFTCXD0YgPdAFHghq
         mqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575915; x=1710180715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs5vwdtP3lE2gaF2HIymTQhqiVBDxVfpiBYTXFLcGDM=;
        b=llskuEsk+fO4N1hF8G8aox2FdhEl8usUTB1ZSYMjGwcISwt2Svys+JysyT/68CzMYq
         xScU7yehyZM3L5/MAtDEj0Oogad2AeFxqa1EC6YdQH/F1MmxkcArxXfHWEL1O3rbDlpH
         +XgSPXsjNpRWKAUCtt4fTh7vnQzTy5tZEtF7llfgMS65gLJKJLZ5XKqRdRMLVXlPpKiJ
         kdLt5yWow9YmyhRyLuvgSqueF1GUFm5A79hQ2e01q/7j2Z+lZ0K7i+786oblyR05LyTv
         lB/20/eKZWgcjyBUWgXep6ajmCKTPjJR3AIz2qeXhzYcUnNfAMAdZtiTx6XSTRwTsKpu
         mNiw==
X-Gm-Message-State: AOJu0YznYjNfq7Uh8ThJiZUUx8GDMNKVxlLJaFuI4+Wv9S8dgXsgqk1D
	o3gUmIMiMqzaN4Motysa6BTJtv5wZUdkDqAY4wBdL/zUNblUuF7GulmmcJBXWRQpiXO5mGULuSm
	eGAstvlgi1TN/JbMWgJAVMWE6ky9c1frpwQIKSb3qIYzoo1i2SfyZJ6FJB2XsRAeTjuRC4fI8Xq
	TZis9ZGHhpm3pC2Y3HN/8EM4vhILrbMnfikAEz6VG1
X-Google-Smtp-Source: AGHT+IF7KqVnyc41EkIolVtSQO6rbDjjbbUw9e2d1bsUL0JqfeSVikRN4mrRaBo+n6JY/DRESTPhKhoP27U=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:aa7:888a:0:b0:6e6:2541:8b4a with SMTP id
 z10-20020aa7888a000000b006e625418b4amr24416pfe.5.1709575914639; Mon, 04 Mar
 2024 10:11:54 -0800 (PST)
Date: Mon,  4 Mar 2024 18:11:33 +0000
In-Reply-To: <20240304181140.644212-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304181140.644212-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240304181140.644212-3-edliaw@google.com>
Subject: [PATCH v1 2/3] selftests/timers/posix_timers: Use TAP reporting format
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[edliaw: Fix checkpatch recommendations]
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/timers/posix_timers.c | 161 +++++++-----------
 1 file changed, 66 insertions(+), 95 deletions(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 03779b6b3c20..0f550fc9e879 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -10,6 +10,7 @@
 #include <sys/time.h>
 #include <stdio.h>
 #include <signal.h>
+#include <string.h>
 #include <unistd.h>
 #include <time.h>
 #include <pthread.h>
@@ -19,6 +20,20 @@
 #define DELAY 2
 #define USECS_PER_SEC 1000000
 
+static void __fatal_error(const char *test, const char *name, const char *what)
+{
+	char buf[64];
+
+	strerror_r(errno, buf, sizeof(buf));
+
+	if (name && strlen(name))
+		ksft_exit_fail_msg("%s %s %s %s\n", test, name, what, buf);
+	else
+		ksft_exit_fail_msg("%s %s %s\n", test, what, buf);
+}
+
+#define fatal_error(name, what)		__fatal_error(__func__, name, what)
+
 static volatile int done;
 
 /* Busy loop in userspace to elapse ITIMER_VIRTUAL */
@@ -67,15 +82,13 @@ static int check_diff(struct timeval start, struct timeval end)
 	diff = end.tv_usec - start.tv_usec;
 	diff += (end.tv_sec - start.tv_sec) * USECS_PER_SEC;
 
-	if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
-		printf("Diff too high: %lld..", diff);
+	if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2)
 		return -1;
-	}
 
 	return 0;
 }
 
-static int check_itimer(int which)
+static void check_itimer(int which)
 {
 	const char *name;
 	int err;
@@ -91,7 +104,7 @@ static int check_itimer(int which)
 	else if (which == ITIMER_REAL)
 		name = "ITIMER_REAL";
 	else
-		return -1;
+		ksft_exit_fail_msg("Unknown setitimer() type %d\n", which);
 
 	done = 0;
 
@@ -103,16 +116,12 @@ static int check_itimer(int which)
 		signal(SIGALRM, sig_handler);
 
 	err = gettimeofday(&start, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(name, "gettimeofday()");
 
 	err = setitimer(which, &val, NULL);
-	if (err < 0) {
-		ksft_perror("Can't set timer");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(name, "setitimer()");
 
 	if (which == ITIMER_VIRTUAL)
 		user_loop();
@@ -122,19 +131,15 @@ static int check_itimer(int which)
 		idle_loop();
 
 	err = gettimeofday(&end, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(name, "gettimeofday()");
 
-	ksft_test_result(check_diff(start, end) == 0, "%s\n", name);
-
-	return 0;
+	ksft_test_result(!check_diff(start, end), "%s %s\n", __func__, name);
 }
 
-static int check_timer_create(int which)
+static void check_timer_create(int which)
 {
-	const char *type;
+	const char *name;
 	int err;
 	timer_t id;
 	struct timeval start, end;
@@ -142,47 +147,37 @@ static int check_timer_create(int which)
 		.it_value.tv_sec = DELAY,
 	};
 
-	if (which == CLOCK_THREAD_CPUTIME_ID) {
-		type = "thread";
-	} else if (which == CLOCK_PROCESS_CPUTIME_ID) {
-		type = "process";
-	} else {
-		ksft_print_msg("Unknown timer_create() type %d\n", which);
-		return -1;
-	}
+	if (which == CLOCK_THREAD_CPUTIME_ID)
+		name = "thread";
+	else if (which == CLOCK_PROCESS_CPUTIME_ID)
+		name = "process";
+	else
+		ksft_exit_fail_msg("Unknown timer_create() type %d\n", which);
 
 	done = 0;
 	err = timer_create(which, NULL, &id);
-	if (err < 0) {
-		ksft_perror("Can't create timer");
-		return -1;
-	}
-	signal(SIGALRM, sig_handler);
+	if (err < 0)
+		fatal_error(name, "timer_create()");
+
+	if (signal(SIGALRM, sig_handler) == SIG_ERR)
+		fatal_error(name, "signal()");
 
 	err = gettimeofday(&start, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(name, "gettimeofday()");
 
 	err = timer_settime(id, 0, &val, NULL);
-	if (err < 0) {
-		ksft_perror("Can't set timer");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(name, "timer_settime()");
 
 	user_loop();
 
 	err = gettimeofday(&end, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(name, "gettimeofday()");
 
 	ksft_test_result(check_diff(start, end) == 0,
-			 "timer_create() per %s\n", type);
-
-	return 0;
+			 "%s %s\n", __func__, name);
 }
 
 static int remain;
@@ -205,7 +200,7 @@ static void distribution_handler(int nr)
  * Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID
  * timer signals. This primarily tests that the kernel does not favour any one.
  */
-static int check_timer_distribution(void)
+static void check_timer_distribution(void)
 {
 	const int nthreads = 10;
 	pthread_t threads[nthreads];
@@ -221,26 +216,20 @@ static int check_timer_distribution(void)
 
 	done = 0;
 	remain = nthreads + 1;  /* worker threads + this thread */
-	signal(SIGALRM, distribution_handler);
+	if (signal(SIGALRM, distribution_handler) == SIG_ERR)
+		fatal_error(NULL, "signal()");
+
 	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
-	if (err < 0) {
-		ksft_perror("Can't create timer");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(NULL, "timer_create()");
+
 	err = timer_settime(id, 0, &val, NULL);
-	if (err < 0) {
-		ksft_perror("Can't set timer");
-		return -1;
-	}
+	if (err < 0)
+		fatal_error(NULL, "timer_settime()");
 
 	for (i = 0; i < nthreads; i++) {
-		err = pthread_create(&threads[i], NULL, distribution_thread,
-				     NULL);
-		if (err) {
-			ksft_print_msg("Can't create thread: %s (%d)\n",
-				       strerror(errno), errno);
-			return -1;
-		}
+		if (pthread_create(&threads[i], NULL, distribution_thread, NULL))
+			fatal_error(NULL, "pthread_create()");
 	}
 
 	/* Wait for all threads to receive the signal. */
@@ -252,23 +241,15 @@ static int check_timer_distribution(void)
 	}
 	done = 1;
 
-	if (timer_delete(id)) {
-		ksft_perror("Can't delete timer\n");
-		return -1;
-	}
+	if (timer_delete(id))
+		fatal_error(NULL, "timer_delete()");
 
 	for (i = 0; i < nthreads; i++) {
-		err = pthread_join(threads[i], NULL);
-		if (err) {
-			ksft_print_msg("Can't join thread: %s (%d)\n",
-				       strerror(errno), errno);
-			return -1;
-		}
+		if (pthread_join(threads[i], NULL))
+			fatal_error(NULL, "pthread_join()");
 	}
 
 	ksft_test_result((now - start <= 5), "%s\n", __func__);
-
-	return 0;
 }
 
 int main(int argc, char **argv)
@@ -279,17 +260,10 @@ int main(int argc, char **argv)
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution\n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
 
-	if (check_itimer(ITIMER_VIRTUAL) < 0)
-		return ksft_exit_fail();
-
-	if (check_itimer(ITIMER_PROF) < 0)
-		return ksft_exit_fail();
-
-	if (check_itimer(ITIMER_REAL) < 0)
-		return ksft_exit_fail();
-
-	if (check_timer_create(CLOCK_THREAD_CPUTIME_ID) < 0)
-		return ksft_exit_fail();
+	check_itimer(ITIMER_VIRTUAL);
+	check_itimer(ITIMER_PROF);
+	check_itimer(ITIMER_REAL);
+	check_timer_create(CLOCK_THREAD_CPUTIME_ID);
 
 	/*
 	 * It's unfortunately hard to reliably test a timer expiration
@@ -300,11 +274,8 @@ int main(int argc, char **argv)
 	 * to ensure true parallelism. So test only one thread until we
 	 * find a better solution.
 	 */
-	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
-		return ksft_exit_fail();
-
-	if (check_timer_distribution() < 0)
-		return ksft_exit_fail();
+	check_timer_create(CLOCK_PROCESS_CPUTIME_ID);
+	check_timer_distribution();
 
 	ksft_finished();
 }
-- 
2.44.0.rc1.240.g4c46232300-goog


