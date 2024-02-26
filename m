Return-Path: <linux-kernel+bounces-81125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2380586712A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 646E7B2DAB1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB811F61F;
	Mon, 26 Feb 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JT1H4Mak"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412BF1EB2B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941711; cv=none; b=gCO/N+g8b/GWxAJjyHaIaOse7Z31YOZrsiEZ/51vpTRkY1isdwBMyYrgJnBe8wbCvt1MkMGB01GJ1FubFtMKjBbLflbu342DQVeOn40O58Uqx5SHid48uyrqs4pXj7Nf/reK5AcV06r9j/+yu3sXH/0s/epKrXhoGiupXPuZ3fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941711; c=relaxed/simple;
	bh=W/nEdRu05n//+j4BnofLYmeUB0FRNpUFT1+Eakz+t/A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MWgpkoWpJq9zK0wW1GnOWTuumtlI4/wx6wRdDN1WEzs6c97ia/XwS8aLRwUQ7a77AlnnKvghi/AbkIKmefck+kjkyFfdR41GA+Ayb/48vZui5VeCvsSQeskkhvRNpIl3eg+KRJB7P5nLA4xvWAUPA0KW5Y+uPQwmavIRtQ8o0Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JT1H4Mak; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e4d20632c3so1520916b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708941709; x=1709546509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gyI/MoWdVSABhMtiVRAkTZHZn+lW5oiA7R70q9bef8k=;
        b=JT1H4Mak/f0DteoRvLE7is0PNc5FO0OHrng4Mf9ICcUMUzU4XAXmjYm2otsqhB9pOh
         fWOSux+g9ELQ2+G6i3VJayjSimcEbXfpPuX6/0Mhisyp/Rockfo0Uoy6oYdoZNkQcTuF
         S5lAiTVZts8Trx5cbcm0iBiH9QjSTcKSDjnAfpWpC0PNfQ1v9ji0LfIsAUWMt19YZQBo
         V0dVpVDBWQx6hn8m9aoGqgXK/N2gaV5vUCrvcrFEjAN5bgppygzXcU6nTX6Ew7WoFke3
         lKzQ2MxoFS01GqlauGZy0/rs0nBwy/xPG1rA8UoBSWth2hAAdsadfu8F0uZSTy5vEwQF
         8GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708941709; x=1709546509;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyI/MoWdVSABhMtiVRAkTZHZn+lW5oiA7R70q9bef8k=;
        b=h171XFQ14auhlV7fUIZBSrqQU1cxlJAzG1Ki8VZj5qy5YoxeW5CLsDNnRfBHcn0a1C
         3RN+TIMYVxAsVL3aCGq/STfBxTRiDpvwZWntn++LgnpIGeTyIgsZiW35/xWISl6mSmBa
         d7yAS2RvxpCDSx95rDuTjN5tUUJQ2w5NoBPsOJZFntbiGX+BbLHmzRlF77Tsbb415e5V
         KT8thbRo01IRlW7xe1kJKGNJmUofscUhFhuCb/dofM1YGk9dOcMbTd/FWlBF8RPofmGf
         O1hyZAVOzv4Cq2g3E/JJSdcT+OZADTods4hFpXQCecuEbfcO8g02c6My6/pThmKtZbeo
         bsTw==
X-Forwarded-Encrypted: i=1; AJvYcCVmD6Cgmx8Cq3w7QJ1S95mNfpNTF40gVhQgGMYrcFaY0saA5Dwq2rWhkrtPHG5Pb8amemeiCpqktNb+winovwbcc5HRzOFuvpQc4a55
X-Gm-Message-State: AOJu0Yx3y+hLZSx4lXDRaZqqxrmCccDVQ8QDhp+GCohdN4VahiGwoNPT
	bTfLvi287JrYqH15sJFp/SyV5KaG2Y5TxBVU6aHaw+YdiqX38U/m9PCE3JyprAcryTA7hIdBls+
	TIvd5xmIyL+lw/atf
X-Google-Smtp-Source: AGHT+IHsMsnGd+L6Ih3NO8l76Y1KOj9vYrg8gPa96vnLXi5uITU09PrnBtcNIlKstccydMSWJ4PxB/iLZvaiHzoW
X-Received: from richardycc.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:f5f])
 (user=richardycc job=sendgmr) by 2002:aa7:88d4:0:b0:6e5:3590:5dc3 with SMTP
 id k20-20020aa788d4000000b006e535905dc3mr9037pff.4.1708941709522; Mon, 26 Feb
 2024 02:01:49 -0800 (PST)
Date: Mon, 26 Feb 2024 10:00:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240226100045.2083962-1-richardycc@google.com>
Subject: [PATCH] mm: add alloc_contig_migrate_range allocation statistics
From: Richard Chang <richardycc@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, richardycc@google.com
Cc: liumartin@google.com, surenb@google.com, minchan@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

alloc_contig_migrate_range has every information to be able to
understand big contiguous allocation latency. For example, how many
pages are migrated, how many times they were needed to unmap from
page tables.

This patch adds the trace event to collect the allocation statistics.
In the field, it was quite useful to understand CMA allocation
latency.

Signed-off-by: Richard Chang <richardycc@google.com>
---
 include/trace/events/kmem.h | 39 +++++++++++++++++++++++++++++++++++++
 mm/internal.h               |  3 ++-
 mm/page_alloc.c             | 30 +++++++++++++++++++++++-----
 mm/page_isolation.c         |  2 +-
 4 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 58688768ef0f..964704d76f9f 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -304,6 +304,45 @@ TRACE_EVENT(mm_page_alloc_extfrag,
 		__entry->change_ownership)
 );
 
+TRACE_EVENT(mm_alloc_contig_migrate_range_info,
+
+	TP_PROTO(unsigned long start,
+		 unsigned long end,
+		 int migratetype,
+		 unsigned long nr_migrated,
+		 unsigned long nr_reclaimed,
+		 unsigned long nr_mapped),
+
+	TP_ARGS(start, end, migratetype,
+		nr_migrated, nr_reclaimed, nr_mapped),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(int, migratetype)
+		__field(unsigned long, nr_migrated)
+		__field(unsigned long, nr_reclaimed)
+		__field(unsigned long, nr_mapped)
+	),
+
+	TP_fast_assign(
+		__entry->start = start;
+		__entry->end = end;
+		__entry->migratetype = migratetype;
+		__entry->nr_migrated = nr_migrated;
+		__entry->nr_reclaimed = nr_reclaimed;
+		__entry->nr_mapped = nr_mapped;
+	),
+
+	TP_printk("start=0x%lx end=0x%lx migratetype=%d nr_migrated=%lu nr_reclaimed=%lu nr_mapped=%lu",
+		  __entry->start,
+		  __entry->end,
+		  __entry->migratetype,
+		  __entry->nr_migrated,
+		  __entry->nr_reclaimed,
+		  __entry->nr_mapped)
+);
+
 /*
  * Required for uniquely and securely identifying mm in rss_stat tracepoint.
  */
diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..e114c647e278 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -537,7 +537,8 @@ isolate_migratepages_range(struct compact_control *cc,
 			   unsigned long low_pfn, unsigned long end_pfn);
 
 int __alloc_contig_migrate_range(struct compact_control *cc,
-					unsigned long start, unsigned long end);
+					unsigned long start, unsigned long end,
+					int migratetype);
 
 /* Free whole pageblock and set its migration type to MIGRATE_CMA. */
 void init_cma_reserved_pageblock(struct page *page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 150d4f23b010..f840bc785afa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6219,9 +6219,14 @@ static void alloc_contig_dump_pages(struct list_head *page_list)
 	}
 }
 
-/* [start, end) must belong to a single zone. */
+/*
+ * [start, end) must belong to a single zone.
+ * @migratetype: using migratetype to filter the type of migration in
+ *		trace_mm_alloc_contig_migrate_range_info.
+ */
 int __alloc_contig_migrate_range(struct compact_control *cc,
-					unsigned long start, unsigned long end)
+					unsigned long start, unsigned long end,
+					int migratetype)
 {
 	/* This function is based on compact_zone() from compaction.c. */
 	unsigned int nr_reclaimed;
@@ -6232,6 +6237,10 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 		.nid = zone_to_nid(cc->zone),
 		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 	};
+	struct page *page;
+	unsigned long total_mapped = 0;
+	unsigned long total_migrated = 0;
+	unsigned long total_reclaimed = 0;
 
 	lru_cache_disable();
 
@@ -6257,9 +6266,16 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 							&cc->migratepages);
 		cc->nr_migratepages -= nr_reclaimed;
 
+		total_reclaimed += nr_reclaimed;
+		list_for_each_entry(page, &cc->migratepages, lru)
+			total_mapped += page_mapcount(page);
+
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
 			NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE, NULL);
 
+		if (!ret)
+			total_migrated += cc->nr_migratepages;
+
 		/*
 		 * On -ENOMEM, migrate_pages() bails out right away. It is pointless
 		 * to retry again over this error, so do the same here.
@@ -6273,9 +6289,13 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 		if (!(cc->gfp_mask & __GFP_NOWARN) && ret == -EBUSY)
 			alloc_contig_dump_pages(&cc->migratepages);
 		putback_movable_pages(&cc->migratepages);
-		return ret;
 	}
-	return 0;
+
+	trace_mm_alloc_contig_migrate_range_info(start, end, migratetype,
+						 total_migrated,
+						 total_reclaimed,
+						 total_mapped);
+	return (ret < 0) ? ret : 0;
 }
 
 /**
@@ -6355,7 +6375,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * allocated.  So, if we fall through be sure to clear ret so that
 	 * -EBUSY is not accidentally used or returned to caller.
 	 */
-	ret = __alloc_contig_migrate_range(&cc, start, end);
+	ret = __alloc_contig_migrate_range(&cc, start, end, migratetype);
 	if (ret && ret != -EBUSY)
 		goto done;
 	ret = 0;
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index cd0ea3668253..a5c8fa4c2a75 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -434,7 +434,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				}
 
 				ret = __alloc_contig_migrate_range(&cc, head_pfn,
-							head_pfn + nr_pages);
+							head_pfn + nr_pages, page_mt);
 
 				/*
 				 * restore the page's migratetype so that it can
-- 
2.44.0.rc0.258.g7320e95886-goog


