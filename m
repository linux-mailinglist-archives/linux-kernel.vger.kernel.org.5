Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5537FA4E7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjK0PjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjK0PjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:39:02 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A787C192;
        Mon, 27 Nov 2023 07:39:08 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a3b8b113so5714710e87.0;
        Mon, 27 Nov 2023 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701099547; x=1701704347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V3MQBUG01fxHiGLZ4D7RmeDwk6VeH03hCF588rTXboM=;
        b=GGJlKf5xyhW1yFHSDhi6sOvu7ZBdC41xhbCWaEllRiLPDeMHv0GHGvpkmzWY05/8Ya
         GvsdlKkQO/SjWbz3VXz86WEtE6OFwcGfDpHGszwAXmbMjAEcXhGjXi4g6WBe115sGNTf
         9j5jgIWCnRzCANSjdAkQKWqWRGSRZ7rGweUvjhWWLX7Qmb1/sv3sh3e89nb9OpRQFQsp
         yIpDlyI4N8l4Ls73DGNvyD6wCAZ1ytTRBG6aLrZxms6J3PbItzu2eUiB9SubdPiqbJLi
         xp7ZSt+0dB4nvNRyGUFbn7q4g6wxYzhB/R64p6F7NlcqCWCJxkHr6fG3uhgCZV3k5brr
         kOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701099547; x=1701704347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3MQBUG01fxHiGLZ4D7RmeDwk6VeH03hCF588rTXboM=;
        b=Qxaa51CiiY1zpv/mes9ghQ7o2y2EXLWfHh38j9Deo1QRmXu9lBj71JYmLbRx8rx2OX
         jXCQWOINIGc1B6sFVebL8yAC5tuikNVyk+s+9pSv9dmU8uVKHJ1o6QsxKL4Gp6XRhkYW
         YITA1XdZs8YStB/JLKCsGNf0aV9mjdyC7GZJ9287U7Cxw54v7YFyP8pE2xSQZI1h8x8o
         WKWB93/DEu73qXkiPc3yc8AVKBuUhsC2TrLFS7/gHgmovwfdXJLGBeATr924wp+FJmbS
         JjeNKScf1clh3BAXn68LD/ERvMxTNpuOOnPe6Wh53CM/rS1LcEx8lt2H+SBg94vQZREN
         tTlw==
X-Gm-Message-State: AOJu0YxLhXObUNU7WaxebbLsS47Ii8uQRlfz1uvuTznKRuxYHuADLdO4
        8svz2CMmhTHyfZ620f4ztcs=
X-Google-Smtp-Source: AGHT+IFS4D+nbq8NG4hVN8bh4KPf05QnjYsBVob0KVmVQHPVDSlBpA7GtIVTgx+fdLgHUOVHsJ/zFg==
X-Received: by 2002:ac2:4c46:0:b0:50b:ae1f:ecd8 with SMTP id o6-20020ac24c46000000b0050bae1fecd8mr3848780lfk.41.1701099546495;
        Mon, 27 Nov 2023 07:39:06 -0800 (PST)
Received: from ran.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id j14-20020a056000124e00b00333085ceca5sm984650wrx.64.2023.11.27.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:39:06 -0800 (PST)
From:   Sagi Maimon <maimon.sagi@gmail.com>
To:     richardcochran@gmail.com, reibax@gmail.com, davem@davemloft.net,
        rrameshbabu@nvidia.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maheshb@google.com, maimon.sagi@gmail.com
Subject: [PATCH v2] posix-timers: add multi_clock_gettime system call
Date:   Mon, 27 Nov 2023 17:39:01 +0200
Message-Id: <20231127153901.6399-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Some user space applications need to read some clocks.
 Each read requires moving from user space to kernel space.
 This asymmetry causes the measured offset to have a significant error.

 Introduce a new system call multi_clock_gettime, which can be used to measure
 the offset between multiple clocks, from variety of types: PHC, virtual PHC
 and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
 The offset includes the total time that the driver needs to read the clock
 timestamp.

 New system call allows the reading of a list of clocks - up to PTP_MAX_CLOCKS.
 Supported clocks IDs: PHC, virtual PHC and various system clocks.
 Up to PTP_MAX_SAMPLES times (per clock) in a single system call read.
 The system call returns n_clocks timestamps for each measurement:
 - clock 0 timestamp
 - ...
 - clock n timestamp

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 Addressed comments from:
 - Richard Cochran : https://www.spinics.net/lists/netdev/msg951723.html
          
 Changes since version 1:
 - Change multi PHC ioctl implamantation into systemcall.
 
 arch/x86/entry/syscalls/syscall_32.tbl |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 include/linux/posix-timers.h           | 24 ++++++++++
 include/linux/syscalls.h               |  3 +-
 include/uapi/asm-generic/unistd.h      | 12 ++++-
 kernel/sys_ni.c                        |  1 +
 kernel/time/posix-timers.c             | 62 ++++++++++++++++++++++++++
 7 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c8fac5205803..070efd266e7e 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -461,3 +461,4 @@
 454	i386	futex_wake		sys_futex_wake
 455	i386	futex_wait		sys_futex_wait
 456	i386	futex_requeue		sys_futex_requeue
+457	i386	multi_clock_gettime		sys_multi_clock_gettime32
\ No newline at end of file
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 8cb8bf68721c..f790330244bb 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -378,6 +378,7 @@
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
+457	common	multi_clock_gettime		sys_multi_clock_gettime
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index d607f51404fc..426a45441ab5 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -260,4 +260,28 @@ void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
 int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
 
 void posixtimer_rearm(struct kernel_siginfo *info);
+
+#define MULTI_PTP_MAX_CLOCKS 12 /* Max number of clocks */
+#define MULTI_PTP_MAX_SAMPLES 10 /* Max allowed offset measurement samples. */
+
+struct __ptp_multi_clock_get {
+	unsigned int n_clocks; /* Desired number of clocks. */
+	unsigned int n_samples; /* Desired number of measurements per clock. */
+	const clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock IDs */
+	/*
+	 * Array of list of n_clocks clocks time samples n_samples times.
+	 */
+	struct  __kernel_timespec ts[MULTI_PTP_MAX_SAMPLES][MULTI_PTP_MAX_CLOCKS];
+};
+
+struct __ptp_multi_clock_get32 {
+	unsigned int n_clocks; /* Desired number of clocks. */
+	unsigned int n_samples; /* Desired number of measurements per clock. */
+	const clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock IDs */
+	/*
+	 * Array of list of n_clocks clocks time samples n_samples times.
+	 */
+	struct  old_timespec32 ts[MULTI_PTP_MAX_SAMPLES][MULTI_PTP_MAX_CLOCKS];
+};
+
 #endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index fd9d12de7e92..afcf68e83d63 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1161,7 +1161,8 @@ asmlinkage long sys_mmap_pgoff(unsigned long addr, unsigned long len,
 			unsigned long prot, unsigned long flags,
 			unsigned long fd, unsigned long pgoff);
 asmlinkage long sys_old_mmap(struct mmap_arg_struct __user *arg);
-
+asmlinkage long sys_multi_clock_gettime(struct __ptp_multi_clock_get __user * ptp_multi_clk_get);
+asmlinkage long sys_multi_clock_gettime32(struct __ptp_multi_clock_get32 __user * ptp_multi_clk_get);
 
 /*
  * Not a real system call, but a placeholder for syscalls which are
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 756b013fb832..3ebcaa052650 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -829,8 +829,18 @@ __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_requeue 456
 __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
+#define __NR_multi_clock_gettime 457
+__SC_3264(__NR_multi_clock_gettime, sys_multi_clock_gettime32, sys_multi_clock_gettime)
+#endif
+
+#if defined(__SYSCALL_COMPAT) || __BITS_PER_LONG == 32
+#define __NR_multi_clock_gettime64 458
+__SYSCALL(__NR_multi_clock_gettime64, sys_multi_clock_gettime)
+#endif
+
 #undef __NR_syscalls
-#define __NR_syscalls 457
+#define __NR_syscalls 459
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index e1a6e3c675c0..8ed1c22f40ac 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -335,6 +335,7 @@ COND_SYSCALL(ppoll_time32);
 COND_SYSCALL_COMPAT(ppoll_time32);
 COND_SYSCALL(utimensat_time32);
 COND_SYSCALL(clock_adjtime32);
+COND_SYSCALL(multi_clock_gettime32);
 
 /*
  * The syscalls below are not found in include/uapi/asm-generic/unistd.h
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b924f0f096fa..517558af2479 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1426,6 +1426,68 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 
 #endif
 
+SYSCALL_DEFINE1(multi_clock_gettime, struct __ptp_multi_clock_get __user *, ptp_multi_clk_get)
+{
+	const struct k_clock *kc;
+	struct timespec64 kernel_tp;
+	struct __ptp_multi_clock_get multi_clk_get;
+	int error;
+	unsigned int i, j;
+
+	if (copy_from_user(&multi_clk_get, ptp_multi_clk_get, sizeof(multi_clk_get)))
+		return -EFAULT;
+
+	if (multi_clk_get.n_samples > MULTI_PTP_MAX_SAMPLES)
+		return -EINVAL;
+	if (multi_clk_get.n_clocks > MULTI_PTP_MAX_CLOCKS)
+		return -EINVAL;
+
+	for (j = 0; j < multi_clk_get.n_samples; j++) {
+		for (i = 0; i < multi_clk_get.n_clocks; i++) {
+			kc = clockid_to_kclock(multi_clk_get.clkid_arr[i]);
+			if (!kc)
+				return -EINVAL;
+			error = kc->clock_get_timespec(multi_clk_get.clkid_arr[i], &kernel_tp);
+			if (!error && put_timespec64(&kernel_tp, (struct __kernel_timespec __user *)
+						     &ptp_multi_clk_get->ts[j][i]))
+				error = -EFAULT;
+		}
+	}
+
+	return error;
+}
+
+SYSCALL_DEFINE1(multi_clock_gettime32, struct __ptp_multi_clock_get32 __user *, ptp_multi_clk_get)
+{
+	const struct k_clock *kc;
+	struct timespec64 kernel_tp;
+	struct __ptp_multi_clock_get multi_clk_get;
+	int error;
+	unsigned int i, j;
+
+	if (copy_from_user(&multi_clk_get, ptp_multi_clk_get, sizeof(multi_clk_get)))
+		return -EFAULT;
+
+	if (multi_clk_get.n_samples > MULTI_PTP_MAX_SAMPLES)
+		return -EINVAL;
+	if (multi_clk_get.n_clocks > MULTI_PTP_MAX_CLOCKS)
+		return -EINVAL;
+
+	for (j = 0; j < multi_clk_get.n_samples; j++) {
+		for (i = 0; i < multi_clk_get.n_clocks; i++) {
+			kc = clockid_to_kclock(multi_clk_get.clkid_arr[i]);
+			if (!kc)
+				return -EINVAL;
+			error = kc->clock_get_timespec(multi_clk_get.clkid_arr[i], &kernel_tp);
+			if (!error && put_old_timespec32(&kernel_tp, (struct old_timespec32 __user *)
+							&ptp_multi_clk_get->ts[j][i]))
+				error = -EFAULT;
+		}
+	}
+
+	return error;
+}
+
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_realtime_timespec,
-- 
2.26.3

