Return-Path: <linux-kernel+bounces-91070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA06870931
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39951C20E51
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4AD6217E;
	Mon,  4 Mar 2024 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OeBX8bue"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734362152
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575914; cv=none; b=r+Xwe5OcdxoRbnO9KSDceHreUKBwbAuKY12umjn/ZUYA+juEL0ozvGQZizkrvdneF+8B/dwaT7sHu7T6mBOHRv8dDLeZO/1kcWRWCfWuS/SxMSscRKerjvojuRBJaD6TzJBoIXexmZL16cDMIpE2zszncHe6IvLtSSkm1a64Zg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575914; c=relaxed/simple;
	bh=CC+iy3zkI7zBVRFWIq21TO6LNko9XBBY5WLB//p8GHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fo986BRF0RghVELnBcV+TS44QDETAqMW7r6hqOkOQoTDjWfCOboFY3GZ6aZPNiAcjt/O43HZ8V6/tx0RyfUXD4C68e5Mxd0D9X/owwUEv0JWK3Z4QF1rRVkQGRsYWY2Dcca5TkqgT1GKRwqnZB9ABv55+jVZagf4Y0TeYRD+TmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OeBX8bue; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dc4f385c16so47421755ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709575912; x=1710180712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LIR4tpXfm1Zf9xB2dvSMHOKf+DsIJbzUCheSmbqVnZ4=;
        b=OeBX8buewaY1kn0YxAr60HF8GT+bam5EAHRrzD1UD9WzYaAFTdHvLa6G05VdOIyPQ9
         TWy6Eais3lPUwiPxFBeTmXROOqZBFFT175/urypfiVHcZIKKrmfPSFcNJBTADO6I9Hqa
         cT7ZzZvykcGOwL+GFvhGR+cD0H4aPtrNgeh6GlnnyIh2IqZ7ZL665v9/m4/P+wieY140
         MbIetNTiWmm/9LpZ6AIJuI59a8HojXIVC6GsxeWRTLhI3qkESE3Lno9a/lskoSUqL7Fr
         btN/mlWjkWhc5dJs5vpWj2fZa+BxjCEeJDzgAbh7gZlgYgeyu6aRfM/FYnowm3DlxsJw
         40fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575912; x=1710180712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIR4tpXfm1Zf9xB2dvSMHOKf+DsIJbzUCheSmbqVnZ4=;
        b=qm98D4VZjk2XoaXBEtHWiicGcio6Q0exQFwGCUOMK6gAx5oh2LD3soJZjoZntfmgM2
         MMoZziElnEohnG8/MdRqsdLRWrBM3Hr2v9qDeq0wD4b3M0xgGuoDjLvD8qUWHF98mi4h
         N7fdgqsmn4KTvQiiYcE95AjhL+nNjIpzyzwquJrlwMyP+ifJWr+qBKMsyaEH6NuHWkrA
         bfFb0WgAvRbjPV0PDIzxvYawZJRLBzNw486ue92VRM1JseqnMiaSwOVl/Cu8CPbIjtjO
         wNAEHOgpyja9+xPzv5ai6Gb/XBObpNq6sNOVwpZVFEpRgPp+wWckqG7UChB1xpg4Zoqa
         sCGg==
X-Gm-Message-State: AOJu0YzvIuiNXOTiAvxL4tpO4m0z7ZZK+iaqfj1Fe/k5A45d5cFYsqR9
	MOSpcjUvkljr24ZuElezEcQHFHkR1FTNojjDzN1aXENzoE7wT8yOF+fdEGzRJkFBjilDAeNa55P
	/8uwSvun7+HQPGDOeM6oaRuZRonGK9w5nvOoJhqmnShTsBenPXPFASaOAwT2R56WFSWfgZRYSwS
	tKnvKIu5XMiO7TfMudwducctIU1fi/0hBZfwkkVQrr
X-Google-Smtp-Source: AGHT+IGIW0ufgJvmiSiJkJzOrk9GFG7bJv+6od4sTBFNYKROiEAkCjdjVmtZBIbw5QLdFBP3IxMZvCRuZms=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:db02:b0:1dc:b7d2:453e with SMTP id
 m2-20020a170902db0200b001dcb7d2453emr168006plx.0.1709575911467; Mon, 04 Mar
 2024 10:11:51 -0800 (PST)
Date: Mon,  4 Mar 2024 18:11:32 +0000
In-Reply-To: <20240304181140.644212-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304181140.644212-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240304181140.644212-2-edliaw@google.com>
Subject: [PATCH v1 1/3] selftests/timers/posix_timers: Make signal
 distribution test less fragile
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The signal distribution test has a tendency to hang for a long time as the
signal delivery is not really evenly distributed.

Increasing the timer interval to 10ms makes this less likely. Add a timeout
to catch the case where it hangs and terminate the test gracefully.

While at it get rid of the pointless atomic operation on a the thread local
variable in the signal handler.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[edliaw: Rebase and fix checkpatch recommendations]
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/timers/posix_timers.c | 43 ++++++++++++-------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index d49dd3ffd0d9..03779b6b3c20 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -24,7 +24,8 @@ static volatile int done;
 /* Busy loop in userspace to elapse ITIMER_VIRTUAL */
 static void user_loop(void)
 {
-	while (!done);
+	while (!done)
+		continue;
 }
 
 /*
@@ -184,18 +185,19 @@ static int check_timer_create(int which)
 	return 0;
 }
 
-int remain;
-__thread int got_signal;
+static int remain;
+static __thread int got_signal;
 
 static void *distribution_thread(void *arg)
 {
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED) && !done)
+		continue;
 	return NULL;
 }
 
 static void distribution_handler(int nr)
 {
-	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
+	if (++got_signal == 1)
 		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
 }
 
@@ -205,17 +207,19 @@ static void distribution_handler(int nr)
  */
 static int check_timer_distribution(void)
 {
-	int err, i;
-	timer_t id;
 	const int nthreads = 10;
 	pthread_t threads[nthreads];
 	struct itimerspec val = {
 		.it_value.tv_sec = 0,
-		.it_value.tv_nsec = 1000 * 1000,
+		.it_value.tv_nsec = 20 * 1000 * 1000,
 		.it_interval.tv_sec = 0,
-		.it_interval.tv_nsec = 1000 * 1000,
+		.it_interval.tv_nsec = 20 * 1000 * 1000,
 	};
+	time_t start, now;
+	int err, i;
+	timer_t id;
 
+	done = 0;
 	remain = nthreads + 1;  /* worker threads + this thread */
 	signal(SIGALRM, distribution_handler);
 	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
@@ -240,7 +244,18 @@ static int check_timer_distribution(void)
 	}
 
 	/* Wait for all threads to receive the signal. */
-	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	now = start = time(NULL);
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED)) {
+		now = time(NULL);
+		if (now - start > 5)
+			break;
+	}
+	done = 1;
+
+	if (timer_delete(id)) {
+		ksft_perror("Can't delete timer\n");
+		return -1;
+	}
 
 	for (i = 0; i < nthreads; i++) {
 		err = pthread_join(threads[i], NULL);
@@ -251,12 +266,8 @@ static int check_timer_distribution(void)
 		}
 	}
 
-	if (timer_delete(id)) {
-		ksft_perror("Can't delete timer");
-		return -1;
-	}
+	ksft_test_result((now - start <= 5), "%s\n", __func__);
 
-	ksft_test_result_pass("check_timer_distribution\n");
 	return 0;
 }
 
@@ -265,7 +276,7 @@ int main(int argc, char **argv)
 	ksft_print_header();
 	ksft_set_plan(6);
 
-	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
+	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution\n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
 
 	if (check_itimer(ITIMER_VIRTUAL) < 0)
-- 
2.44.0.rc1.240.g4c46232300-goog


