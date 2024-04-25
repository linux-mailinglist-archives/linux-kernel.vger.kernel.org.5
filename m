Return-Path: <linux-kernel+bounces-158992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AEA8B27D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6AFF1F21A39
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D50E15217F;
	Thu, 25 Apr 2024 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HpO5+MvI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501801509A0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068365; cv=none; b=VtzXV7B6uPHY2PhghBi49OQksIx0Inm8ElatFBhCByUfZlfVHT0Ac5FPdR78pXKa8NeGhCn4nTCIgDtMB6BC5+yCIiItNfyp8beEvm2SHS0HRWliJXQoE044s1aaPVceFMHRlQ45P8jhsiplk3TJZu9v9mFmastj5+5zM6xBisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068365; c=relaxed/simple;
	bh=ScQJ619y+GLs1OSVTuQky0J/AgX81URn1hBDRJGl+6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oj6Vd8MEghLSkfzbkNP2zKqiIxGUiTKtSlcrSAZ43vtJUI0yAjaA3eTI36dY/KoMfsczxr8u5DGc5GNzAt0zUkTDOXQ8Pfonun88nWuU0b0qzlU45kGAgBEvzAVk0ZxZlwM2XQ0c14hjvIzunskXspfgOIzBQ9fhXHlsl6j+3ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HpO5+MvI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PHNso7016494;
	Thu, 25 Apr 2024 18:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=zhNxV+WkimC8M1gbMsCHT8yixzJzj2YrCmtHjO4v/Co=;
 b=HpO5+MvI243AzogPMgypC63sshnglYSG0ec710GIog4Je+hn1wD4BVZ4wZ40FAAaVMTU
 0auR4p3w5qJxvToaa9xbleEcLJsaXEfElNYPF8Dhbk3FhlqUKztNu5B2dbQKanSmSjcW
 725tVZL8FW1zcAtSdSRSBGJywiiTeuxvyhumF0kSOTMxSTmaIERvrCkM/h2q5lL6K7OF
 aO9ZZ/uvH2JMfdsv5OoyDINEgnjYWkVxY3zH4TTUf/VVLvZTB7lF1Oqjmd1OetTaPq1Y
 SxeSDAVxaOwg3UFygeqH4M38P2BhJWoltOWjvLd9QyQ5FGMv6JiCMxZDZxO2d+t+Pxix fQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4m1ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 18:05:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PGdxmH001947;
	Thu, 25 Apr 2024 18:05:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45be433-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 18:05:50 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43PI20Kl032785;
	Thu, 25 Apr 2024 18:05:49 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xm45be3wd-5;
	Thu, 25 Apr 2024 18:05:49 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: [PATCH v3 4/4] selftests/mm: Add new testcases for pkeys
Date: Thu, 25 Apr 2024 18:05:42 +0000
Message-Id: <20240425180542.1042933-5-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
References: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250131
X-Proofpoint-GUID: IOhGuhS5HPMIqiPCcNMsSQJZf_4h5EzS
X-Proofpoint-ORIG-GUID: IOhGuhS5HPMIqiPCcNMsSQJZf_4h5EzS

This commit adds a few new tests to exercise the signal handler flow,
especially with pkey 0 disabled.

Signed-off-by: Keith Lucas <keith.lucas@oracle.com>
Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 tools/testing/selftests/mm/Makefile           |   2 +
 tools/testing/selftests/mm/pkey-helpers.h     |  11 +-
 .../selftests/mm/pkey_sighandler_tests.c      | 315 ++++++++++++++++++
 tools/testing/selftests/mm/protection_keys.c  |  10 -
 4 files changed, 327 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey_sighandler_tests.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index eb5f39a2668b..2f90344ad11e 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -82,6 +82,7 @@ CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_pr
 CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_program.c -no-pie)
 
 VMTARGETS := protection_keys
+VMTARGETS := pkey_sighandler_tests
 BINARIES_32 := $(VMTARGETS:%=%_32)
 BINARIES_64 := $(VMTARGETS:%=%_64)
 
@@ -100,6 +101,7 @@ else
 
 ifneq (,$(findstring $(ARCH),ppc64))
 TEST_GEN_FILES += protection_keys
+TEST_GEN_FILES += pkey_sighandler_tests
 endif
 
 endif
diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 1af3156a9db8..a0766e3d9ab6 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -79,7 +79,16 @@ extern void abort_hooks(void);
 	}					\
 } while (0)
 
-__attribute__((noinline)) int read_ptr(int *ptr);
+#define barrier() __asm__ __volatile__("": : :"memory")
+__attribute__((noinline)) int read_ptr(int *ptr)
+{
+	        /*
+		 *          * Keep GCC from optimizing this away somehow
+		 *                   */
+	        barrier();
+		        return *ptr;
+}
+
 void expected_pkey_fault(int pkey);
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
new file mode 100644
index 000000000000..eb4155859846
--- /dev/null
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -0,0 +1,315 @@
+#define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
+#include <errno.h>
+#include <sys/syscall.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <limits.h>
+
+#include "pkey-helpers.h"
+
+/*
+ * Compile with:
+ * gcc -mxsave      -o pkey_sighandler_tests -O2 -g -std=gnu99 -pthread -Wall pkey_sighandler_tests.c -lrt -ldl -lm
+ */
+
+#define STACK_SIZE PTHREAD_STACK_MIN
+
+void expected_pkey_fault(int pkey) {}
+
+pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
+pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+siginfo_t siginfo = {0};
+
+static inline __attribute__((always_inline)) long
+syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
+{
+	unsigned long ret;
+	register long r10 asm("r10") = a4;
+	register long r8 asm("r8") = a5;
+	register long r9 asm("r9") = a6;
+	asm volatile ("syscall"
+		      : "=a"(ret)
+		      : "a"(n), "D"(a1), "S"(a2), "d"(a3), "r"(r10), "r"(r8), "r"(r9)
+		      : "rcx", "r11", "memory");
+	return ret;
+}
+
+
+static void sigsegv_handler(int signo, siginfo_t *info, void *ucontext)
+{
+	pthread_mutex_lock(&mutex);
+
+	memcpy(&siginfo, info, sizeof(siginfo_t));
+
+	pthread_cond_signal(&cond);
+	pthread_mutex_unlock(&mutex);
+
+	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+}
+
+static void sigusr1_handler(int signo, siginfo_t *info, void *ucontext)
+{
+	pthread_mutex_lock(&mutex);
+
+	memcpy(&siginfo, info, sizeof(siginfo_t));
+
+	pthread_cond_signal(&cond);
+	pthread_mutex_unlock(&mutex);
+}
+
+static void *thread_segv_with_pkey0_disabled(void *ptr)
+{
+	/* Disable MPK 0 (and all others too) */
+	__write_pkey_reg(0x55555555);
+
+        /* Segfault (with SEGV_MAPERR) */
+	*(int *) (0x1) = 1;
+	return NULL;
+}
+
+static void *thread_segv_pkuerr_stack(void *ptr)
+{
+	/* Disable MPK 0 (and all others too) */
+	__write_pkey_reg(0x55555555);
+
+        /* After we disable MPK 0, we can't access the stack to return */
+	return NULL;
+}
+
+static void *thread_segv_maperr_ptr(void *ptr)
+{
+	stack_t *stack = ptr;
+	int *bad = (int *) 1;
+
+	/*
+	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
+	 * MPK 0. The thread's stack cannot be used for signals because it is
+	 * not accessible by the default init_pkru value of 0x55555554.
+	 */
+        syscall_raw(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
+
+        /* Disable MPK 0.  Only MPK 1 is enabled. */
+	__write_pkey_reg(0x55555551);
+
+        /* Segfault */
+	*bad = 1;
+	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+	return NULL;
+}
+
+/*
+ * Verify that the sigsegv handler is invoked when pkey 0 is disabled.
+ * Note that the new thread stack and the alternate signal stack is
+ * protected by MPK 0.
+ */
+static void test_sigsegv_handler_with_pkey0_disabled(void)
+{
+	struct sigaction sa;
+
+	sa.sa_flags = SA_SIGINFO;
+
+	sa.sa_sigaction = sigsegv_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGSEGV, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	pthread_t thr;
+	pthread_attr_t attr;
+	pthread_attr_init(&attr);
+	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+
+	pthread_create(&thr, &attr, thread_segv_with_pkey0_disabled, NULL);
+
+	pthread_mutex_lock(&mutex);
+	while(siginfo.si_signo == 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	assert(siginfo.si_signo == SIGSEGV);
+	assert(siginfo.si_code == SEGV_MAPERR);
+	assert(siginfo.si_addr == (void *)1);
+	printf("%s passed!\n", __func__);
+}
+
+/*
+ * Verify that the sigsegv handler is invoked when pkey 0 is disabled.
+ * Note that the new thread stack and the alternate signal stack is
+ * protected by MPK 0, which renders them inaccessible when MPK 0
+ * is disabled. So just the return from the thread should cause a
+ * segfault with SEGV_PKUERR.
+ */
+static void test_sigsegv_handler_cannot_access_stack(void)
+{
+	struct sigaction sa;
+
+	sa.sa_flags = SA_SIGINFO;
+
+	sa.sa_sigaction = sigsegv_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGSEGV, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	pthread_t thr;
+	pthread_attr_t attr;
+	pthread_attr_init(&attr);
+	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+
+	pthread_create(&thr, &attr, thread_segv_pkuerr_stack, NULL);
+
+	pthread_mutex_lock(&mutex);
+	while(siginfo.si_signo == 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	assert(siginfo.si_signo == SIGSEGV);
+	assert(siginfo.si_code == SEGV_PKUERR);
+	printf("%s passed!\n", __func__);
+}
+
+/*
+ * Verify that the sigsegv handler that uses an alternate signal stack
+ * is correctly invoked for a thread which uses a non-zero MPK to protect
+ * its own stack, and disables all other MPKs (including 0).
+ */
+static void test_sigsegv_handler_with_different_pkey_for_stack(void)
+{
+	struct sigaction sa;
+	static stack_t sigstack;
+        void *stack;
+	int pkey;
+	int parentPid = 0;
+	int childPid = 0;
+
+	sa.sa_flags = SA_SIGINFO | SA_ONSTACK;
+
+	sa.sa_sigaction = sigsegv_handler;
+
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGSEGV, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	stack = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE,
+		      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	assert(stack != MAP_FAILED);
+
+	/* Allow access to MPK 0 and MPK 1 */
+	__write_pkey_reg(0x55555550);
+
+	/* Protect the new stack with MPK 1 */
+	pkey = pkey_alloc(0, 0);
+	pkey_mprotect(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
+
+        /* Set up alternate signal stack that will use the default MPK */
+	sigstack.ss_sp = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
+			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	sigstack.ss_flags = 0;
+	sigstack.ss_size = STACK_SIZE;
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+        /* Use clone to avoid newer glibcs using rseq on new threads */
+	long ret = syscall_raw(SYS_clone,
+			       CLONE_VM | CLONE_FS | CLONE_FILES |
+			       CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM |
+			       CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID |
+			       CLONE_DETACHED,
+			       (long)((char *)(stack) + STACK_SIZE),
+			       (long)&parentPid,
+			       (long)&childPid, 0, 0);
+
+	if (ret < 0) {
+		errno = -ret;
+		perror("clone");
+	}  else if (ret == 0) {
+		thread_segv_maperr_ptr(&sigstack);
+		syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+	}
+
+	pthread_mutex_lock(&mutex);
+	while(siginfo.si_signo == 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	assert(siginfo.si_signo == SIGSEGV);
+	assert(siginfo.si_code == SEGV_MAPERR);
+	assert(siginfo.si_addr == (void *)1);
+	printf("%s passed!\n", __func__);
+}
+
+/*
+ * Verify that the PKRU value set by the application is correctly
+ * restored upon return from signal handling.
+ */
+static void test_pkru_preserved_after_sigusr1(void)
+{
+	struct sigaction sa;
+	unsigned long pkru = 0x45454544;
+
+	sa.sa_flags = SA_SIGINFO;
+
+	sa.sa_sigaction = sigusr1_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	__write_pkey_reg(pkru);
+
+	raise(SIGUSR1);
+
+	pthread_mutex_lock(&mutex);
+	while(siginfo.si_signo == 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	/* Ensure the pkru value is the same after returning from signal. */
+	assert(pkru == __read_pkey_reg());
+	assert(siginfo.si_signo == SIGUSR1);
+	printf("%s passed!\n", __func__);
+}
+
+
+void (*pkey_tests[])(void)  = {
+	test_sigsegv_handler_with_pkey0_disabled,
+	test_sigsegv_handler_cannot_access_stack,
+	test_sigsegv_handler_with_different_pkey_for_stack,
+	test_pkru_preserved_after_sigusr1,
+};
+
+int main(int argc, char *argv[])
+{
+	size_t i;
+
+	for (i = 0; i < sizeof(pkey_tests)/sizeof(pkey_tests[0]); i++) {
+		(*pkey_tests[i])();
+	}
+
+	printf("All pkey-signal-handling tests PASSED!\n");
+	return 0;
+}
+
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 374a308174d2..ec1e1d30ea6f 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -951,16 +951,6 @@ void close_test_fds(void)
 	nr_test_fds = 0;
 }
 
-#define barrier() __asm__ __volatile__("": : :"memory")
-__attribute__((noinline)) int read_ptr(int *ptr)
-{
-	/*
-	 * Keep GCC from optimizing this away somehow
-	 */
-	barrier();
-	return *ptr;
-}
-
 void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 pkey)
 {
 	int i, err;
-- 
2.39.3


