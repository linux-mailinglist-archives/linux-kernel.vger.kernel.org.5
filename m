Return-Path: <linux-kernel+bounces-49248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218978467DC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2B228DD42
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B11218E1A;
	Fri,  2 Feb 2024 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwIKQ4lO"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3588618651
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854571; cv=none; b=IY10Yr05jNfhVm7FJK9tQ2gskENBtech51/feaaObXCrmPt8jUmBkoVkc2cTN8ap3kgI4w1zLSlODaE5JCLszjCfWpo7oM0aSD5kAksNlBheuzzz0ll+Of0Bv/1uqtrKPIActQUugYz19JTzIENnMQHUxLk/VK5ff6xFE0w8ljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854571; c=relaxed/simple;
	bh=BXiX9gzQs5k0E5V5XLiwe7g8s/r2aLi/zeI/x5SxZBA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CVGx9ZnVMXYmRo57ZbqZDB3XigrS+xH9KfyIIcdkLNZyVBm27yNTRbDudgLi/z9p4bQPBmUTb17NuKCKDHrOyipRwTkefvrt4jXJZGL1qYJuiQ0uajave0wrn4csdv6sGQWXaZsaLmGhfFLPXVgosbom3lNU98JocPXLTe0mznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bwIKQ4lO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60402c8d651so28172417b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 22:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854567; x=1707459367; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJud4au3Z9PjBuOB/8R+QNGS64GphjM5sRn/EZb5fRM=;
        b=bwIKQ4lOnlXCNbe+z4MZSVuDTdCQLKCcoWXtOf/mVaHtk6rKX+hW4+Pp2KygBDj0fc
         MBiqGQj6DEn9O0GZbgh8mlw+fGkwArNnZOZnN108ePq5b8tpcCiRo60+d0HE3+vU6+it
         wBglhEb+W6MqKDlqff1QfYe9piq4qUwGYOU51yG2GbYK9Y663A7TjxCb24ROcLv0LtoC
         btqLaggyRUqBW7A/VcXIRtV00DSi1rWPKq9gcFrzwQsxV6NK7O0JOr1YLBYomP9B1gaG
         AZHWkWLGehH7DPT+a09klMs3dIq5xBUd9rRIosL598TyECrz72EPeraE1Btj5SIYZZEU
         M0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854567; x=1707459367;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJud4au3Z9PjBuOB/8R+QNGS64GphjM5sRn/EZb5fRM=;
        b=bZ4l37S6FPQCCDX1mZ5PoLaQF/R5VvIs/rEfOz5Yqp4p1o3J99X/8oazn06g6st6EK
         0hGFX5mDd0KQKyFwblRCP6P1N7kcDPeYiruVSFc4MisJeuyyjK2cKTj6HKytmBEbPtPY
         pyLhUE2YuZvxH2/iD+/ndV1afvKClCnO2+QAUdMxXHd+/zlimTy1cu7xlUBnwQbjoNiV
         H/9auBTyDrg52k2P/gsrwnHpUrO1oLscfWEOLgr1pCZUXGc86SzdZ3gNI+TrXneJUOqa
         InKcuIpkuKEhPAwN4bL41/czgENoKiEcN7qrHAa3Kty9jbQ7wtSaodQ4lkhGYzVAY9u6
         gIPA==
X-Gm-Message-State: AOJu0YzkpH0nuwuNvBqoaMyFsaMROZBp3mkqZaFx18ia0RI1Nvf6USjT
	RI7Hmkwr0MkTb42iFGnXNdLBR2bpF3s5LPDByu4K/nkgHS0J6HRpBYc4nl00Qpm71SS2phE9Hzs
	lVog6DQ==
X-Google-Smtp-Source: AGHT+IF3fwmUJIvVLru1MNRh37RduoVDKXVqFJnLRRhw2MixlEtjIscY1fq4DqTcN9/vdkf0L9qEP4PiU4B1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a81:9a47:0:b0:5fb:5605:494a with SMTP id
 r68-20020a819a47000000b005fb5605494amr777271ywg.7.1706854567242; Thu, 01 Feb
 2024 22:16:07 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:16 -0800
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
Message-Id: <20240202061532.1939474-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 09/25] perf trace: Ignore thread hashing in summary
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

Commit 91e467bc568f ("perf machine: Use hashtable for machine
threads") made the iteration of thread tids unordered. The perf trace
--summary output sorts and prints each hash bucket, rather than all
threads globally. Change this behavior by turn all threads into a
list, sort the list by number of trace events then by tids, finally
print the list. This also allows the rbtree in threads to be not
accessed outside of machine.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c  | 41 +++++++++++++++++++++----------------
 tools/perf/util/rb_resort.h |  5 -----
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 109b8e64fe69..90eaff8c0f6e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -74,6 +74,7 @@
 #include <linux/err.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
+#include <linux/list_sort.h>
 #include <linux/random.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
@@ -4312,34 +4313,38 @@ static unsigned long thread__nr_events(struct thread_trace *ttrace)
 	return ttrace ? ttrace->nr_events : 0;
 }
 
-DEFINE_RESORT_RB(threads,
-		(thread__nr_events(thread__priv(a->thread)) <
-		 thread__nr_events(thread__priv(b->thread))),
-	struct thread *thread;
-)
+static int trace_nr_events_cmp(void *priv __maybe_unused,
+			       const struct list_head *la,
+			       const struct list_head *lb)
 {
-	entry->thread = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
+	struct thread_list *a = list_entry(la, struct thread_list, list);
+	struct thread_list *b = list_entry(lb, struct thread_list, list);
+	unsigned long a_nr_events = thread__nr_events(thread__priv(a->thread));
+	unsigned long b_nr_events = thread__nr_events(thread__priv(b->thread));
+
+	if (a_nr_events != b_nr_events)
+		return a_nr_events < b_nr_events ? -1 : 1;
+
+	/* Identical number of threads, place smaller tids first. */
+	return thread__tid(a->thread) < thread__tid(b->thread)
+		? -1
+		: (thread__tid(a->thread) > thread__tid(b->thread) ? 1 : 0);
 }
 
 static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp)
 {
 	size_t printed = trace__fprintf_threads_header(fp);
-	struct rb_node *nd;
-	int i;
-
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		DECLARE_RESORT_RB_MACHINE_THREADS(threads, trace->host, i);
+	LIST_HEAD(threads);
 
-		if (threads == NULL) {
-			fprintf(fp, "%s", "Error sorting output by nr_events!\n");
-			return 0;
-		}
+	if (machine__thread_list(trace->host, &threads) == 0) {
+		struct thread_list *pos;
 
-		resort_rb__for_each_entry(nd, threads)
-			printed += trace__fprintf_thread(fp, threads_entry->thread, trace);
+		list_sort(NULL, &threads, trace_nr_events_cmp);
 
-		resort_rb__delete(threads);
+		list_for_each_entry(pos, &threads, list)
+			printed += trace__fprintf_thread(fp, pos->thread, trace);
 	}
+	thread_list__delete(&threads);
 	return printed;
 }
 
diff --git a/tools/perf/util/rb_resort.h b/tools/perf/util/rb_resort.h
index 376e86cb4c3c..d927a0d25052 100644
--- a/tools/perf/util/rb_resort.h
+++ b/tools/perf/util/rb_resort.h
@@ -143,9 +143,4 @@ struct __name##_sorted *__name = __name##_sorted__new
 	DECLARE_RESORT_RB(__name)(&__ilist->rblist.entries.rb_root,		\
 				  __ilist->rblist.nr_entries)
 
-/* For 'struct machine->threads' */
-#define DECLARE_RESORT_RB_MACHINE_THREADS(__name, __machine, hash_bucket)    \
- DECLARE_RESORT_RB(__name)(&__machine->threads[hash_bucket].entries.rb_root, \
-			   __machine->threads[hash_bucket].nr)
-
 #endif /* _PERF_RESORT_RB_H_ */
-- 
2.43.0.594.gd9cf4e227d-goog


