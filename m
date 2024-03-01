Return-Path: <linux-kernel+bounces-87931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD7586DB2D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05CF1F229B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C3052F9C;
	Fri,  1 Mar 2024 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yN7KMJk/"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48AE524DC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709271418; cv=none; b=Efr6sdheOtF3iqmS8mAQBxWx5DgFQk4OFMV+UWd8sFzlXFUlh07UYfdvwj2QKNf6z2URytk3CYWxbms54GT/Xi2sJZZV6funUqJ9xYvw/Rmbnvf8W5HHgy1YZTwe0U1zaCNTeqkC+6Q6x6AXnLYjYa+ooBOpz8pkhHNsVCfEHt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709271418; c=relaxed/simple;
	bh=soASIs7D8iQcX2U2s2M4JC6RaqIvyHatWg6UktdKnSI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=H4YqecEeGXRwKqR43M6kApAMjx05amQfi3IonNhTM2nGocxWUURPlTTI1rp4eLRwrOzoHBoObMkfkVSKZCX5X4Y7PpihUwaH5HgyLgLClrvjzX1hsAW9YIyWRRZjVSvx5AYY+sZ9umzpXlWLkUSwB7/7Gy3MYJaMdy8j+/o2AJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yN7KMJk/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607e8e8c2f1so29944327b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709271416; x=1709876216; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHNbX5Xyi/VqeebJOw+lK9eWaYZye24FQe0AyXZlgyM=;
        b=yN7KMJk/IHZ+SdUXNslVSy2elnT6d/xwvd0JH4r6vu66eSR5ydG4HVIi75O3BlwTNL
         Uwbo94ENq5eW5S90oqq09DQW7csC+fcbD8dqOhDKP+bAdOquKxYNlDsJ31AA4iWYxHpY
         W1D5+P9j0ImqaXsUgkbPKGJg5swOOEbWF1oFAqSRG8eOem/TFaqy555JwMvYf7qncDJW
         mI5KM92xfgaLSUDX+B0xaPBjQxAs6Q7kDh8IO3LLUEfRQIlmdfWFnw3ZChKthuNRBMV3
         c4dy8zILmVp+xFYbA4kvg5SYvHtRNbJbPpYaBYqmP8yn3yAQfZ6+1nc3fNnWEp54qiX1
         teIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709271416; x=1709876216;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHNbX5Xyi/VqeebJOw+lK9eWaYZye24FQe0AyXZlgyM=;
        b=FTPQegILu1gsxmPtnbo4EjqimJSzQCvc5wJFw5Z7bxQNW9THP0RdOV6URwq9sPaKKV
         9Dwu3f1PRU+KH9d692AJnwDOf2fEJA+icVTu5iPAJMRl/uxslgEPhVbmM5AAneXV2mpN
         ic+t1R+kFbh2ebQZlk5O/sS2Jqrdbu1nz/Y/oc47CfSy41FJaEIBAu0ONDkyOlfc+U+N
         KwOdilSyFU0zQXwps7DoWR8kn6heEgTqs22cNLMtxv3+2cglRD/XhxQVDkxZ0hCsuGlJ
         R4GTz5fg7CHA20gdaj6KonnUWAhs3oRU8c3bg4FNLEdTz8SEfGiWbUJYdjYs853eInNF
         qcww==
X-Forwarded-Encrypted: i=1; AJvYcCVEjQUkwaoFf60f18mIiWN2g8XZwfKrj5XqWUM8GMVyUq5tuKdBtvXTBYApCYY1mT/tRcimS+jUYNkH+1e05OFKBWof0zv8XJMg6rMh
X-Gm-Message-State: AOJu0YywelTtjFm9mOf7gs7neqOj8bxSnglr9EfU9Egzy3yUOYM1vE7W
	nJh6D0qAZIGl9yszksspJamhRmIaUi1aG1MVWuEGfb0ZM48w+NgNNUedKS/bpySo2SEaeiNKeZ5
	yExcXpQ==
X-Google-Smtp-Source: AGHT+IGn8HoPMAtiLjnOrLidczbr8rHmWkK6qo4EV/60cj9vlFmzMLPXquVyPOjzZ/F3/NRBJNMVTERB35x2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a81:9950:0:b0:609:4d6f:7c0b with SMTP id
 q77-20020a819950000000b006094d6f7c0bmr114933ywg.4.1709271415925; Thu, 29 Feb
 2024 21:36:55 -0800 (PST)
Date: Thu, 29 Feb 2024 21:36:40 -0800
In-Reply-To: <20240301053646.1449657-1-irogers@google.com>
Message-Id: <20240301053646.1449657-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301053646.1449657-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v4 2/7] perf trace: Ignore thread hashing in summary
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
2.44.0.278.ge034bb2e1d-goog


