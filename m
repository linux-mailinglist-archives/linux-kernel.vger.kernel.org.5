Return-Path: <linux-kernel+bounces-23812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751EF82B215
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2304F285B39
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11394D5AA;
	Thu, 11 Jan 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="N2iGFPVQ"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C94CDE9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1704988169;
	bh=CiSR0Tuk8JBUjA4HrB2X52STAqq56NnAYbyj25ClA9g=;
	h=From:To:Cc:Subject:Date:From;
	b=N2iGFPVQl/3OZWrtZHRqk055f6PMfMCN4b0gU0qjkpId3g1bWEM3Gc4tADi70dNaP
	 6iegc9DBiivGsD1wg6akSh2B209PRfnxDj381hVscFIXHh8pDNWz02gTI00HVaENbo
	 Bazm5fG0PAwtFsL7PAYa53SKValB5TqYfMYdHr+hEk5NCsiYCwZWbvfYpo4+8dAnIa
	 RNHRLwW4IqjtawhzVyQ9l1MFSp4E7onShLuoY1Il6wyANDCJn6BCdb+8jK0XOgwJpy
	 ShZuhBl9Wfm24WiwUDLtH57AUovjm9FbATPS4z6n1He3eZXfb4T/4AaqrUoyIsKvpa
	 EwirL1wEIL+2Q==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4T9py148ypzKTm;
	Thu, 11 Jan 2024 10:49:29 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] selftests/rseq: Do not skip !allowed_cpus for mm_cid
Date: Thu, 11 Jan 2024 10:49:22 -0500
Message-Id: <20240111154922.600919-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indexing with mm_cid is incompatible with skipping disallowed cpumask,
because concurrency IDs are based on a virtual ID allocation which is
unrelated to the physical CPU mask.

These issues can be reproduced by running the rseq selftests under a
taskset which excludes CPU 0, e.g.

  taskset -c 10-20 ./run_param_test.sh

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 .../selftests/rseq/basic_percpu_ops_test.c    | 14 ++++++++++--
 tools/testing/selftests/rseq/param_test.c     | 22 ++++++++++++++-----
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index 887542961968..2348d2c20d0a 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -24,6 +24,11 @@ bool rseq_validate_cpu_id(void)
 {
 	return rseq_mm_cid_available();
 }
+static
+bool rseq_use_cpu_index(void)
+{
+	return false;	/* Use mm_cid */
+}
 #else
 # define RSEQ_PERCPU	RSEQ_PERCPU_CPU_ID
 static
@@ -36,6 +41,11 @@ bool rseq_validate_cpu_id(void)
 {
 	return rseq_current_cpu_raw() >= 0;
 }
+static
+bool rseq_use_cpu_index(void)
+{
+	return true;	/* Use cpu_id as index. */
+}
 #endif
 
 struct percpu_lock_entry {
@@ -274,7 +284,7 @@ void test_percpu_list(void)
 	/* Generate list entries for every usable cpu. */
 	sched_getaffinity(0, sizeof(allowed_cpus), &allowed_cpus);
 	for (i = 0; i < CPU_SETSIZE; i++) {
-		if (!CPU_ISSET(i, &allowed_cpus))
+		if (rseq_use_cpu_index() && !CPU_ISSET(i, &allowed_cpus))
 			continue;
 		for (j = 1; j <= 100; j++) {
 			struct percpu_list_node *node;
@@ -299,7 +309,7 @@ void test_percpu_list(void)
 	for (i = 0; i < CPU_SETSIZE; i++) {
 		struct percpu_list_node *node;
 
-		if (!CPU_ISSET(i, &allowed_cpus))
+		if (rseq_use_cpu_index() && !CPU_ISSET(i, &allowed_cpus))
 			continue;
 
 		while ((node = __percpu_list_pop(&list, i))) {
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 20403d58345c..2f37961240ca 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -288,6 +288,11 @@ bool rseq_validate_cpu_id(void)
 {
 	return rseq_mm_cid_available();
 }
+static
+bool rseq_use_cpu_index(void)
+{
+	return false;	/* Use mm_cid */
+}
 # ifdef TEST_MEMBARRIER
 /*
  * Membarrier does not currently support targeting a mm_cid, so
@@ -312,6 +317,11 @@ bool rseq_validate_cpu_id(void)
 {
 	return rseq_current_cpu_raw() >= 0;
 }
+static
+bool rseq_use_cpu_index(void)
+{
+	return true;	/* Use cpu_id as index. */
+}
 # ifdef TEST_MEMBARRIER
 static
 int rseq_membarrier_expedited(int cpu)
@@ -715,7 +725,7 @@ void test_percpu_list(void)
 	/* Generate list entries for every usable cpu. */
 	sched_getaffinity(0, sizeof(allowed_cpus), &allowed_cpus);
 	for (i = 0; i < CPU_SETSIZE; i++) {
-		if (!CPU_ISSET(i, &allowed_cpus))
+		if (rseq_use_cpu_index() && !CPU_ISSET(i, &allowed_cpus))
 			continue;
 		for (j = 1; j <= 100; j++) {
 			struct percpu_list_node *node;
@@ -752,7 +762,7 @@ void test_percpu_list(void)
 	for (i = 0; i < CPU_SETSIZE; i++) {
 		struct percpu_list_node *node;
 
-		if (!CPU_ISSET(i, &allowed_cpus))
+		if (rseq_use_cpu_index() && !CPU_ISSET(i, &allowed_cpus))
 			continue;
 
 		while ((node = __percpu_list_pop(&list, i))) {
@@ -902,7 +912,7 @@ void test_percpu_buffer(void)
 	/* Generate list entries for every usable cpu. */
 	sched_getaffinity(0, sizeof(allowed_cpus), &allowed_cpus);
 	for (i = 0; i < CPU_SETSIZE; i++) {
-		if (!CPU_ISSET(i, &allowed_cpus))
+		if (rseq_use_cpu_index() && !CPU_ISSET(i, &allowed_cpus))
 			continue;
 		/* Worse-case is every item in same CPU. */
 		buffer.c[i].array =
@@ -952,7 +962,7 @@ void test_percpu_buffer(void)
 	for (i = 0; i < CPU_SETSIZE; i++) {
 		struct percpu_buffer_node *node;
 
-		if (!CPU_ISSET(i, &allowed_cpus))
+		if (rseq_use_cpu_index() && !CPU_ISSET(i, &allowed_cpus))
 			continue;
 
 		while ((node = __percpu_buffer_pop(&buffer, i))) {
@@ -1113,7 +1123,7 @@ void test_percpu_memcpy_buffer(void)
 	/* Generate list entries for every usable cpu. */
 	sched_getaffinity(0, sizeof(allowed_cpus), &allowed_cpus);
 	for (i = 0; i < CPU_SETSIZE; i++) {
-		if (!CPU_ISSET(i, &allowed_cpus))
+		if (rseq_use_cpu_index() && !CPU_ISSET(i, &allowed_cpus))
 			continue;
 		/* Worse-case is every item in same CPU. */
 		buffer.c[i].array =
@@ -1160,7 +1170,7 @@ void test_percpu_memcpy_buffer(void)
 	for (i = 0; i < CPU_SETSIZE; i++) {
 		struct percpu_memcpy_buffer_node item;
 
-		if (!CPU_ISSET(i, &allowed_cpus))
+		if (rseq_use_cpu_index() && !CPU_ISSET(i, &allowed_cpus))
 			continue;
 
 		while (__percpu_memcpy_buffer_pop(&buffer, &item, i)) {
-- 
2.25.1


