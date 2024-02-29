Return-Path: <linux-kernel+bounces-86173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F35086C0B1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC2AB2217C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5A24174A;
	Thu, 29 Feb 2024 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="si/v60O4"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE45036B0A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188387; cv=none; b=N7XJ4qmtX8SlG2tXkviw06WHTraG7UafwyAI9sbMMiSnVwcNIpbBN+/NXwCEkX7lfahAuBY952+US2ygZxemB0FosecCtIDZnH39RUIPZQ0SI0ZbVs8z1lmCqL7lQGXIyhWrI/10O4hFhxumuL0X87MuUnKDgXGaxjVqopPlHNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188387; c=relaxed/simple;
	bh=soASIs7D8iQcX2U2s2M4JC6RaqIvyHatWg6UktdKnSI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jwEpkgqlAo0ZTIXRroAIlBGFW/jCSkbsRhqTNoht8tWUd+alEmv3RA17dfg5UuTmGRNidWueRV6RVTEfh+JlI3XFkRaQEDNuoV/2LAuwxQehgvKR0+pd5D435nhpprMsvKOr4rEsGOmVlDvgruBi1JwflbAljfl68DGRemTaRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=si/v60O4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608d6ffc64eso8227417b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709188385; x=1709793185; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHNbX5Xyi/VqeebJOw+lK9eWaYZye24FQe0AyXZlgyM=;
        b=si/v60O4T4V4NmN75HXUfiMGRA9yqMoIC6MhzoEKci3e3TsIm5gsdGpa2QMiFDMMl+
         zM0a143rYO7SbCCbaaVEspF6PKF/ZyIsiFkXMLpc0KCMSMMiNvxckdBRkvciWMeJjaUP
         IM2M6rrVRWWTLLZkF75NcuPqsdCstzYZSJLk7XgJZ1pSe1Mk7GpohBbXTJwiq2nVRg29
         V61ypgV4lCsIAjylpjlcNsevdSQoByXqhwdSzF3FawkaR4jYMm2X0yOf9tCmkB62JWJY
         nk6E+A6le+CAMBn36CeMfaxP6V0Y1w5jZB7u8rOwIg2P5UTESCLjcF9Cbm/snbySb+vU
         I3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709188385; x=1709793185;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHNbX5Xyi/VqeebJOw+lK9eWaYZye24FQe0AyXZlgyM=;
        b=Ui+v3lhhzDBWvxZASAGx9p03TtIvb2ftEw/hRvDjaTQc/83Otu58ArpBa1XjEYBD/O
         an0sWRzmSwlmGaqsMO69azpxiv7dDQdNSoVxjaw86ZjaBf4OrkwB0xbKlom4Z9wbaOcI
         IA/+7vxCLDUHnWzNeZgv+EsiH36NjZI2uk3jykMxzLrSjYdjwTqgqlsb3aj1JrSfIX0s
         Ya6XXqf69lPXsK6/HI4Qb+ba4sMOul4bcJ4WCeNwCFAn0NTOADLV9uraySb24EyIj8cM
         ra8n5Rb8rGv+U+ZmAkeAjccMq1WlA4V8SDruGHGp6+eSKit+0JtG15Kj97vIzh+2hdfM
         laJg==
X-Forwarded-Encrypted: i=1; AJvYcCW5oyZuDPyTekv8i9HTFyGo0QFI46mlqO7cDEjFbfb+odRM1Ke0LTX2mgjIheE5rHVjRbWyh0xJh1eWYYwMKaMJj03I0LC0uP1e5htZ
X-Gm-Message-State: AOJu0Yx/XM8iuhh3RG7gPx5KW6AAbWYRim5lQYDCPPTd3sutz3d1bWKd
	uljIPMw5jWjRH7ABloC0krCtLfeCRs/s6XD0Iw64wapbp31QKatTtCOjoVnRrSOvdg54gsh7sxv
	Eoi1LSg==
X-Google-Smtp-Source: AGHT+IHbrMd6slwQeYvMqN/08zqbSC1gNZwN0G1DzdWqDvoRaymALnRDCNTv4Jp+H4HvcIsxQUpc0B2RCQOK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a0d:c346:0:b0:609:3a1f:e852 with SMTP id
 f67-20020a0dc346000000b006093a1fe852mr169734ywd.2.1709188384986; Wed, 28 Feb
 2024 22:33:04 -0800 (PST)
Date: Wed, 28 Feb 2024 22:32:48 -0800
In-Reply-To: <20240229063253.561838-1-irogers@google.com>
Message-Id: <20240229063253.561838-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229063253.561838-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 2/7] perf trace: Ignore thread hashing in summary
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


