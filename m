Return-Path: <linux-kernel+bounces-141745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B37E68A22E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1991F22AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C13C2D;
	Fri, 12 Apr 2024 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pHbs6rc2"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89E2195;
	Fri, 12 Apr 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712881072; cv=none; b=g8Jpq5cefJTleJc2XmoRcNKJrOWEzrfjfYLIgQ9xIxvZptVxi9aMjmUiRIETjNXLh1hOP7r3prQdxvR7YfxeP0TjAm4HgPLlTb2hYHaBEhA+tSR3R7zd5/8GCTMKjG+QSKHOUnhAs2yeOQPjKLgKyRGnq73VqjUY7vOBc2YcR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712881072; c=relaxed/simple;
	bh=BNNGY5+CHDXfjGHZyVuZHwM0zX798QLsj57JCFZBkCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IQReKa6HK1StAH/phDzT44cvYnP9GFLVYEMHFUqMwV/16R8U17aKrPN92rjcWyPPpeCQGzSCC16R0KjQ1Qk3Fh8yob/sAilomF2oiqFePXq4xqIlAWxd7EoJojanDkChP0Mx8haLDdFz3uk/P7FNPJpKkGoWguqrGyjRWXSJ/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pHbs6rc2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.125])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5443720EC323;
	Thu, 11 Apr 2024 17:17:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5443720EC323
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712881070;
	bh=FcYc71XiBGnC8Gok9z2Cask+yzIzGSZjKrNW1Wp57BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pHbs6rc2Hz4XH0t/RUJ0X9ZWZ6aQbFRsQqZM5mwhNekKT53ImaIjfq95Y5xTO5kAK
	 rdf/MPPBiFUU0FLQXoP2tbi+vFFmc4bTtM3ui0v5lFV6IIFezUdGQrERlGTlzCajVc
	 fP+hQStG4MLRgUfOAtKCdwUC/YAqSKLjDlBC+di4=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	primiano@google.com,
	aahringo@redhat.com,
	dcook@linux.microsoft.com
Subject: [RFC PATCH 1/4] perf/core: Introduce perf_prepare_dump_data()
Date: Fri, 12 Apr 2024 00:17:29 +0000
Message-Id: <20240412001732.475-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412001732.475-1-beaub@linux.microsoft.com>
References: <20240412001732.475-1-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out perf_prepare_dump_data() so that the same logic is used for
dumping stack data as other types, such as TLS.

Slightly refactor perf_sample_ustack_size() to perf_sample_dump_size().
Move reg checks up into perf_ustack_task_size() since the task size
must now be calculated before preparing dump data.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/events/core.c | 79 ++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..07de5cc2aa25 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6912,7 +6912,13 @@ static void perf_sample_regs_intr(struct perf_regs *regs_intr,
  */
 static u64 perf_ustack_task_size(struct pt_regs *regs)
 {
-	unsigned long addr = perf_user_stack_pointer(regs);
+	unsigned long addr;
+
+	/* No regs, no stack pointer, no dump. */
+	if (!regs)
+		return 0;
+
+	addr = perf_user_stack_pointer(regs);
 
 	if (!addr || addr >= TASK_SIZE)
 		return 0;
@@ -6921,42 +6927,35 @@ static u64 perf_ustack_task_size(struct pt_regs *regs)
 }
 
 static u16
-perf_sample_ustack_size(u16 stack_size, u16 header_size,
-			struct pt_regs *regs)
+perf_sample_dump_size(u16 dump_size, u16 header_size, u64 task_size)
 {
-	u64 task_size;
-
-	/* No regs, no stack pointer, no dump. */
-	if (!regs)
-		return 0;
-
 	/*
-	 * Check if we fit in with the requested stack size into the:
+	 * Check if we fit in with the requested dump size into the:
 	 * - TASK_SIZE
 	 *   If we don't, we limit the size to the TASK_SIZE.
 	 *
 	 * - remaining sample size
-	 *   If we don't, we customize the stack size to
+	 *   If we don't, we customize the dump size to
 	 *   fit in to the remaining sample size.
 	 */
 
-	task_size  = min((u64) USHRT_MAX, perf_ustack_task_size(regs));
-	stack_size = min(stack_size, (u16) task_size);
+	task_size  = min((u64) USHRT_MAX, task_size);
+	dump_size = min(dump_size, (u16) task_size);
 
 	/* Current header size plus static size and dynamic size. */
 	header_size += 2 * sizeof(u64);
 
-	/* Do we fit in with the current stack dump size? */
-	if ((u16) (header_size + stack_size) < header_size) {
+	/* Do we fit in with the current dump size? */
+	if ((u16) (header_size + dump_size) < header_size) {
 		/*
 		 * If we overflow the maximum size for the sample,
-		 * we customize the stack dump size to fit in.
+		 * we customize the dump size to fit in.
 		 */
-		stack_size = USHRT_MAX - header_size - sizeof(u64);
-		stack_size = round_up(stack_size, sizeof(u64));
+		dump_size = USHRT_MAX - header_size - sizeof(u64);
+		dump_size = round_up(dump_size, sizeof(u64));
 	}
 
-	return stack_size;
+	return dump_size;
 }
 
 static void
@@ -7648,6 +7647,32 @@ static __always_inline u64 __cond_set(u64 flags, u64 s, u64 d)
 	return d * !!(flags & s);
 }
 
+static inline u16
+perf_prepare_dump_data(struct perf_sample_data *data,
+		       struct perf_event *event,
+		       struct pt_regs *regs,
+		       u16 dump_size,
+		       u64 task_size)
+{
+	u16 header_size = perf_sample_data_size(data, event);
+	u16 size = sizeof(u64);
+
+	dump_size = perf_sample_dump_size(dump_size, header_size,
+					  task_size);
+
+	/*
+	 * If there is something to dump, add space for the dump
+	 * itself and for the field that tells the dynamic size,
+	 * which is how many have been actually dumped.
+	 */
+	if (dump_size)
+		size += sizeof(u64) + dump_size;
+
+	data->dyn_size += size;
+
+	return dump_size;
+}
+
 void perf_prepare_sample(struct perf_sample_data *data,
 			 struct perf_event *event,
 			 struct pt_regs *regs)
@@ -7725,22 +7750,12 @@ void perf_prepare_sample(struct perf_sample_data *data,
 		 * up the rest of the sample size.
 		 */
 		u16 stack_size = event->attr.sample_stack_user;
-		u16 header_size = perf_sample_data_size(data, event);
-		u16 size = sizeof(u64);
-
-		stack_size = perf_sample_ustack_size(stack_size, header_size,
-						     data->regs_user.regs);
+		u64 task_size = perf_ustack_task_size(regs);
 
-		/*
-		 * If there is something to dump, add space for the dump
-		 * itself and for the field that tells the dynamic size,
-		 * which is how many have been actually dumped.
-		 */
-		if (stack_size)
-			size += sizeof(u64) + stack_size;
+		stack_size = perf_prepare_dump_data(data, event, regs,
+						    stack_size, task_size);
 
 		data->stack_user_size = stack_size;
-		data->dyn_size += size;
 		data->sample_flags |= PERF_SAMPLE_STACK_USER;
 	}
 
-- 
2.34.1


