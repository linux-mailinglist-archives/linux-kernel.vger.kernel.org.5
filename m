Return-Path: <linux-kernel+bounces-152776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D34D8AC419
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3861F21F95
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CD2405F9;
	Mon, 22 Apr 2024 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jRTcbJQG"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1ADDA3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713766924; cv=none; b=q3TJaKbaaYpYrCDzOhmDdmyBwQueu2TRdtRGu6pnzDprQs017RM29sFXEUwlRxSOb4zfL7qO16nHWIK1g1derPGGtm8R25SKptSsKA4rKiEIowl7aWmLUOWiPKLMiZofmj5+tAF8I50iTPyWv+m6QxlkkTRHXae2jak2CzpTO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713766924; c=relaxed/simple;
	bh=SGZSK0ustsY1Lf9KVstOIQKwZBL7OEMrqFJf4TCxONU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mmfhg+mxVpVEfmV7jrTeFGNALDK6Yg2WSDseJncFe5bDUUSniRFkTCR3S4N1fh3qkKhTu+69NpkUC9AaOOFXtlo7xqwJXs9KFagVbaoeaVoy3tNbPRG9vd3ObvD3UWN5nfDnde1K3Pht5YQUDd4IkayuPPzzcVHX7mp6qUsh6ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jRTcbJQG; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5ca5b61c841so5104329a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 23:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713766921; x=1714371721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BgHnvH0SifwgzbjlbM6L8Ym3RK63epZLUnxr0JyiQ3A=;
        b=jRTcbJQGaunoOGQvCeHdIQpMCAL92UC8oPiuo6XwcMDQD+lMDPqm143TjC/wcb83Jy
         okV0zAUbq74VH4+Tv99GuwuM+CrqDWr+FDgOl6UMPCvJnGQfFaTY4luWfgh9Z7AoI80k
         uF/v+Us0YZrONkl5Slm23pmHNAnTIK5bsCf3cZ9sLJ2TFMItf33Kvftuyh9yTNHAh/xp
         9naCsyAWV95cqGROrCRtImhKcLHZAikYWXQbEO1PTzhurOnhj0+tP/4hmKyX9uYKFVNm
         /DupFhSee9qpkJsRuBv0S3We0Q9lnUDqExpke9SzkvAXkBOAyJd/IImD43/OYN2BA5Y3
         gTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713766921; x=1714371721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgHnvH0SifwgzbjlbM6L8Ym3RK63epZLUnxr0JyiQ3A=;
        b=odDK+FHPfgxzr05kR+59pQ9mWFBn0plVgXOjCJH4yE/+2BAjLWCVQr7FhLf7MSr4Wf
         zppkAE6f9BK0ergcGjQXVZii1LqntvC4EFvelcR6YL0A4VHjpqFb2xpxONCTioqVjHHU
         alhQEdqNpjMkum/8RtaOZ+NXBJZLjpP4OlVvkQl4p6M0xBie7oFCQ0Q+e6Xc92wfd9+/
         ziVDjAxdT9BYimeX3yc/YeIpiNt8GMOsxCHF+RLdEbeep9pRPi7/MTBv+ea4/7Pap18C
         3OnEuG+xMiEDgOAvolh++CjfJkmUvqphowSWIURKCmvLH+mbh6UvK54Jb9s/fspaUCYs
         gpGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm2GIg0atVNzjJAQuS/Tu/K+u1rSbwxEB/EjeeEzoH53BM0JLyzhoM2Gu5LMFOwypdxh+NFVNdekKUkuKHCU+3Z96+KmucjvJQdDxT
X-Gm-Message-State: AOJu0Yza0SSGzFeJbs3n/FJh/e/riguWUew5Azs+TJ/vnfU4S+41qt0s
	NsIwPkTmzE/jFQheW2zcYiGc6AVNP1etSv5RwxSHMR7cxOgZF5nrguBDCVNpTPrOZHvuaNg6ZKV
	qMQ==
X-Google-Smtp-Source: AGHT+IG60hX85zyqhoN/GGQeaHC9TWv2bBTAYTzrGgW8aBKeakB6ufmF0DHNgdD+A/EpTFGn21ykx8dr8NA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:8c3:b0:5fc:52b3:a014 with SMTP id
 ch3-20020a056a0208c300b005fc52b3a014mr21986pgb.4.1713766921226; Sun, 21 Apr
 2024 23:22:01 -0700 (PDT)
Date: Mon, 22 Apr 2024 06:21:43 +0000
In-Reply-To: <2024041509-triangle-parlor-1783@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024041509-triangle-parlor-1783@gregkh>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240422062148.642140-1-edliaw@google.com>
Subject: [PATCH 6.6.y] selftests/timers/posix_timers: Reimplement check_timer_distribution()
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>
Cc: kernel-team@android.com, Oleg Nesterov <oleg@redhat.com>, 
	Edward Liaw <edliaw@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Oleg Nesterov <oleg@redhat.com>

check_timer_distribution() runs ten threads in a busy loop and tries to
test that the kernel distributes a process posix CPU timer signal to every
thread over time.

There is not guarantee that this is true even after commit bcb7ee79029d
("posix-timers: Prefer delivery of signals to the current thread") because
that commit only avoids waking up the sleeping process leader thread, but
that has nothing to do with the actual signal delivery.

As the signal is process wide the first thread which observes sigpending
and wins the race to lock sighand will deliver the signal. Testing shows
that this hangs on a regular base because some threads never win the race.

The comment "This primarily tests that the kernel does not favour any one."
is wrong. The kernel does favour a thread which hits the timer interrupt
when CLOCK_PROCESS_CPUTIME_ID expires.

Rewrite the test so it only checks that the group leader sleeping in join()
never receives SIGALRM and the thread which burns CPU cycles receives all
signals.

In older kernels which do not have commit bcb7ee79029d ("posix-timers:
Prefer delivery of signals to the current thread") the test-case fails
immediately, the very 1st tick wakes the leader up. Otherwise it quickly
succeeds after 100 ticks.

CI testing wants to use newer selftest versions on stable kernels. In this
case the test is guaranteed to fail.

So check in the failure case whether the kernel version is less than v6.3
and skip the test result in that case.

[ tglx: Massaged change log, renamed the version check helper ]
[ edliaw: 071af0c9e582 ("selftests: timers: Convert posix_timers test to
  generate KTAP output") wasn't merged to 6.6.y, so resolved merge
  conflicts. ]

Fixes: e797203fb3ba ("selftests/timers/posix_timers: Test delivery of signals across threads")
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240409133802.GD29396@redhat.com
(cherry picked from commit 6d029c25b71f2de2838a6f093ce0fa0e69336154)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/kselftest.h           | 13 +++
 tools/testing/selftests/timers/posix_timers.c | 99 +++++++++----------
 2 files changed, 59 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 529d29a35900..68d5a93dff8d 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -49,6 +49,7 @@
 #include <unistd.h>
 #include <stdarg.h>
 #include <stdio.h>
+#include <sys/utsname.h>
 #endif
 
 #ifndef ARRAY_SIZE
@@ -327,4 +328,16 @@ static inline int ksft_exit_skip(const char *msg, ...)
 	exit(KSFT_SKIP);
 }
 
+static inline int ksft_min_kernel_version(unsigned int min_major,
+					  unsigned int min_minor)
+{
+	unsigned int major, minor;
+	struct utsname info;
+
+	if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
+		ksft_exit_fail_msg("Can't parse kernel version\n");
+
+	return major > min_major || (major == min_major && minor >= min_minor);
+}
+
 #endif /* __KSELFTEST_H */
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 9a42403eaff7..aaec7f9845c5 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -188,78 +188,71 @@ static int check_timer_create(int which)
 	return 0;
 }
 
-int remain;
-__thread int got_signal;
+static pthread_t ctd_thread;
+static volatile int ctd_count, ctd_failed;
 
-static void *distribution_thread(void *arg)
+static void ctd_sighandler(int sig)
 {
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
-	return NULL;
+	if (pthread_self() != ctd_thread)
+		ctd_failed = 1;
+	ctd_count--;
 }
 
-static void distribution_handler(int nr)
+static void *ctd_thread_func(void *arg)
 {
-	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
-		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
-}
-
-/*
- * Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID
- * timer signals. This primarily tests that the kernel does not favour any one.
- */
-static int check_timer_distribution(void)
-{
-	int err, i;
-	timer_t id;
-	const int nthreads = 10;
-	pthread_t threads[nthreads];
 	struct itimerspec val = {
 		.it_value.tv_sec = 0,
 		.it_value.tv_nsec = 1000 * 1000,
 		.it_interval.tv_sec = 0,
 		.it_interval.tv_nsec = 1000 * 1000,
 	};
+	timer_t id;
 
-	printf("Check timer_create() per process signal distribution... ");
-	fflush(stdout);
+	/* 1/10 seconds to ensure the leader sleeps */
+	usleep(10000);
 
-	remain = nthreads + 1;  /* worker threads + this thread */
-	signal(SIGALRM, distribution_handler);
-	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
-	if (err < 0) {
-		perror("Can't create timer\n");
-		return -1;
-	}
-	err = timer_settime(id, 0, &val, NULL);
-	if (err < 0) {
-		perror("Can't set timer\n");
-		return -1;
-	}
+	ctd_count = 100;
+	if (timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id))
+		return "Can't create timer\n";
+	if (timer_settime(id, 0, &val, NULL))
+		return "Can't set timer\n";
 
-	for (i = 0; i < nthreads; i++) {
-		if (pthread_create(&threads[i], NULL, distribution_thread, NULL)) {
-			perror("Can't create thread\n");
-			return -1;
-		}
-	}
+	while (ctd_count > 0 && !ctd_failed)
+		;
 
-	/* Wait for all threads to receive the signal. */
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	if (timer_delete(id))
+		return "Can't delete timer\n";
 
-	for (i = 0; i < nthreads; i++) {
-		if (pthread_join(threads[i], NULL)) {
-			perror("Can't join thread\n");
-			return -1;
-		}
-	}
+	return NULL;
+}
 
-	if (timer_delete(id)) {
-		perror("Can't delete timer\n");
-		return -1;
-	}
+/*
+ * Test that only the running thread receives the timer signal.
+ */
+static int check_timer_distribution(void)
+{
+	const char *errmsg;
 
-	printf("[OK]\n");
+	signal(SIGALRM, ctd_sighandler);
+
+	errmsg = "Can't create thread\n";
+	if (pthread_create(&ctd_thread, NULL, ctd_thread_func, NULL))
+		goto err;
+
+	errmsg = "Can't join thread\n";
+	if (pthread_join(ctd_thread, (void **)&errmsg) || errmsg)
+		goto err;
+
+	if (!ctd_failed)
+		ksft_test_result_pass("check signal distribution\n");
+	else if (ksft_min_kernel_version(6, 3))
+		ksft_test_result_fail("check signal distribution\n");
+	else
+		ksft_test_result_skip("check signal distribution (old kernel)\n");
 	return 0;
+err:
+	ksft_print_msg(errmsg);
+	return -1;
 }
 
 int main(int argc, char **argv)
-- 
2.44.0.769.g3c40516874-goog


