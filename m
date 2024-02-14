Return-Path: <linux-kernel+bounces-64797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE6D8542F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E0E286298
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4458712B96;
	Wed, 14 Feb 2024 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1ONCkJ2"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE7E125D8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892648; cv=none; b=TJoBxJY1Kl5CALnRqUdI0qkZ4jjra+tl2lPNurAWDQRAkAynZ6npq5VmuZJiseIuag2C8E06lqSlcTZefS7Zgs9r3AC6BLszKX4NhfrEQGvZ2ICDk437D5Z+DaJWh37fH0FF019J4TBU/XT7Ea8gdgsDH1VUjOA5wQoCv0fokeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892648; c=relaxed/simple;
	bh=Xqgs303n2TD+hO6ata6FdmAxJD9pFTCMplqiFePigLM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=szM9k9MxuGwsrH/MXp3xDLZ3DuZodTBnUkkOFKLgGAPXoD2TJ3A1qqIAQIcmIAZ1j0OZtMFJXouE20UvIpbIXv11IxlwW8z6JWuIJZKizln8tXKZF801L6fYa6WXfXU+/3/DB88IML0E86IK/11161DXSy7aQG0JigTqfUXMGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1ONCkJ2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso2980463276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707892645; x=1708497445; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZC75fzSKnLOcOdvEmiJR26JJ9Cyn2cw2nBv54DIcSM=;
        b=Y1ONCkJ2OAX+WN00azK6e3AHlxqO+fHpojweUxt07+clWH7PSgGrETM9/2sm+KGohF
         0jYRE6Qj+uE1CDzkgbvlGsM3QB2yHBfOO/Ah4VRhtBYolaqAhxXu0cQMs7UVWUP9rfy0
         yiSxVrNs2SS+rWNSdx934q7umTgZdzeBr9/2GHsdG4avcbR/LdG00G3J2V/4gH2hcNYt
         vjYaQRCaBOC4X267+3I0y3JJikfpqiJ3wMUfOO7BPQ0zRLkJm45Wj63zKpkDFb3+j90a
         YDlxWMlzmhSDBNc//O2H5XN0ooLn1MwxjK1J6fWRSXiA8okiJdw3gnSkbayNSt0FaDJB
         WdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892645; x=1708497445;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZC75fzSKnLOcOdvEmiJR26JJ9Cyn2cw2nBv54DIcSM=;
        b=slYHfAGRMOvgO6RL49FLCEYkDk7ihCGDWr44y7Dcn2qhT3GUL80h8a/hfL0JTGj8Nl
         CQi0osrSQODzK3LdKqVVfa25UkD++yMIdWwTFeo99mP6VOI4MfWl7qxrPkKFPAPfV9NO
         ub44xo28q8ddegnpNtWPnSVApWKsovkkTGwBsbviyGBeLyM/ld25LW5clj1Js74szYQr
         rAs+Y0n/8Nsm4zzkv2/IG5K9pyZH8TRNF60meXHzTNdfc7YyyE21R/g7UhhMGIAQLLhz
         v6Ogn4glmeJhyC38OiO4xygj8VIkTnNfJp0pYqV7jDNgIwYc98Ej3anV/wpZVPp7l/lJ
         gjTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsXS3piuRd/0iCC0YOcvl+G60jfFhgUQzWgsSDhBQvbLw7PCoMFHPyEAP6u3jQg2bM5xgUCBGzZj4tIItWEtxQwWS2jfL5AwFa5+rm
X-Gm-Message-State: AOJu0Ywldk9I4mqVFMNx0TVJWJro8SuLuYOHcVQ80ecSqgGckW2wp8NX
	OHI7jnoZD/dPi0mIMsdafHLNbrTllbFH1VBpnJ1WgW7lmhXoN9870fApLL23LIKIpnzWR75MTgl
	NfUv/6Q==
X-Google-Smtp-Source: AGHT+IGvJVS96aABdEOS9tS4w8Q4cso9jIVj1Kv46sheeCV1N/KHtABTU2xUrbdiKuY6fwIfh+zW0nqes89z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:114d:b0:dc6:d2c8:6e50 with SMTP
 id p13-20020a056902114d00b00dc6d2c86e50mr330849ybu.7.1707892645603; Tue, 13
 Feb 2024 22:37:25 -0800 (PST)
Date: Tue, 13 Feb 2024 22:37:04 -0800
In-Reply-To: <20240214063708.972376-1-irogers@google.com>
Message-Id: <20240214063708.972376-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 2/6] perf trace: Ignore thread hashing in summary
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
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
2.43.0.687.g38aa6559b0-goog


