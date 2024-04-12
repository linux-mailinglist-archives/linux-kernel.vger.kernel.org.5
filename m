Return-Path: <linux-kernel+bounces-141746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18698A22E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5EC1C22B80
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DDA3D71;
	Fri, 12 Apr 2024 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gxbzRCXd"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC5036C;
	Fri, 12 Apr 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712881072; cv=none; b=MAGFfNK6AqOshpk/B0SHANbvZtmq3JceTwfYzLy4eKScjxSIix08IQZG8pzShTYQ/oj4hVTjpH3xEAiI0msuK7/WpR6uIeyBSwA7YTx8STTET2lUAC5sQ1notSXuCStNakT1ogz8vSs6iqR1lhkz2y3jnTzkrJrdT6bv9X5KG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712881072; c=relaxed/simple;
	bh=50OZ7JlsHKGdWRWX51fnAYktmg1ytZjQKr9Ej9/1m/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rKNgtWFSq9CPjk3Y0juLQLHIgTGlHDYAYxDh4SMGSWmuNEd+jDi1maXsEZasDIt0A/uMaoAgC3mkkRt1lyFTpaMK06W+sLfHfAjCd0TMBPTn0TeJp34R7Y37Aa41XjcIF4DIT7PVjJWaQDKUA3BoHzfEmQgOBEOqD0j7hIeTRp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gxbzRCXd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.125])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8EAF620EC32A;
	Thu, 11 Apr 2024 17:17:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8EAF620EC32A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712881070;
	bh=Zf+HTFpj8I9//v34h6ZpxRqKnTpj+6KrGfJr8S0wU4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxbzRCXdxkh7guY72Vjlr4GXwwDz/oDF8Eatxa7mIohHFZCqOF9dasRz5CahhOdqi
	 a+8VRDzXhA0FsgyMBsGIknlRahgQwf0bnfrLiLb8atgrXcjG3UXDNxjEPaNZAjBDLK
	 /zJyh+x1chEATmdXUDtzUh9r2iSb+YAUi/o+IBYI=
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
Subject: [RFC PATCH 3/4] perf/core: Factor perf_output_sample_udump()
Date: Fri, 12 Apr 2024 00:17:31 +0000
Message-Id: <20240412001732.475-4-beaub@linux.microsoft.com>
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

We now have two user dump sources (stack and tls). Both are doing the
same logic to ensure the user dump ABI output is properly handled. The
only difference is one gets the address within the method, and the other
is passed the address.

Add perf_output_sample_udump() and utilize it for both stack and tls
sample dumps. The sp register is now fetched outside of this method and
passed to it. This allows both stack and tls to utilize the same code.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/events/core.c | 68 +++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 49 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f848bf4be9bd..6b3cf5afdd32 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6998,47 +6998,10 @@ perf_sample_dump_size(u16 dump_size, u16 header_size, u64 task_size)
 }
 
 static void
-perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
-			  struct pt_regs *regs)
-{
-	/* Case of a kernel thread, nothing to dump */
-	if (!regs) {
-		u64 size = 0;
-		perf_output_put(handle, size);
-	} else {
-		unsigned long sp;
-		unsigned int rem;
-		u64 dyn_size;
-
-		/*
-		 * We dump:
-		 * static size
-		 *   - the size requested by user or the best one we can fit
-		 *     in to the sample max size
-		 * data
-		 *   - user stack dump data
-		 * dynamic size
-		 *   - the actual dumped size
-		 */
-
-		/* Static size. */
-		perf_output_put(handle, dump_size);
-
-		/* Data. */
-		sp = perf_user_stack_pointer(regs);
-		rem = __output_copy_user(handle, (void *) sp, dump_size);
-		dyn_size = dump_size - rem;
-
-		perf_output_skip(handle, rem);
-
-		/* Dynamic size. */
-		perf_output_put(handle, dyn_size);
-	}
-}
-
-static void
-perf_output_sample_utls(struct perf_output_handle *handle, u64 addr,
-			u64 dump_size, struct pt_regs *regs)
+perf_output_sample_udump(struct perf_output_handle *handle,
+			 unsigned long addr,
+			 u64 dump_size,
+			 struct pt_regs *regs)
 {
 	/* Case of a kernel thread, nothing to dump */
 	if (!regs) {
@@ -7054,7 +7017,7 @@ perf_output_sample_utls(struct perf_output_handle *handle, u64 addr,
 		 *   - the size requested by user or the best one we can fit
 		 *     in to the sample max size
 		 * data
-		 *   - user tls dump data
+		 *   - user dump data
 		 * dynamic size
 		 *   - the actual dumped size
 		 */
@@ -7507,9 +7470,16 @@ void perf_output_sample(struct perf_output_handle *handle,
 	}
 
 	if (sample_type & PERF_SAMPLE_STACK_USER) {
-		perf_output_sample_ustack(handle,
-					  data->stack_user_size,
-					  data->regs_user.regs);
+		struct pt_regs *regs = data->regs_user.regs;
+		unsigned long sp = 0;
+
+		if (regs)
+			sp = perf_user_stack_pointer(regs);
+
+		perf_output_sample_udump(handle,
+					 sp,
+					 data->stack_user_size,
+					 regs);
 	}
 
 	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
@@ -7551,10 +7521,10 @@ void perf_output_sample(struct perf_output_handle *handle,
 		perf_output_put(handle, data->code_page_size);
 
 	if (sample_type & PERF_SAMPLE_TLS_USER) {
-		perf_output_sample_utls(handle,
-					data->tls_addr,
-					data->tls_user_size,
-					data->regs_user.regs);
+		perf_output_sample_udump(handle,
+					 data->tls_addr,
+					 data->tls_user_size,
+					 data->regs_user.regs);
 	}
 
 	if (sample_type & PERF_SAMPLE_AUX) {
-- 
2.34.1


