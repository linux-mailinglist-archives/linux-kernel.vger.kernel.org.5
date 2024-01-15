Return-Path: <linux-kernel+bounces-25855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5BC82D6C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A341F2115D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B20EF9C1;
	Mon, 15 Jan 2024 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hn4rX1ua"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E51F4E7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705313260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5T4EASqZP4WNXzIQNT1K4h8oNNu89D6KQhpLw+uTpdE=;
	b=hn4rX1uaRv9UreJ4kBteFDcXAqNXgrYQgPuE+VnmeRdlW5GOlOdl+2iirDEyPxD4EmRvbI
	mB+zw3IPPloHc9cC31FTDCK8LQGzRNGWtV8/S/3Bmz5bxMyQcstUxWcRKwdJwDCZg6dtjV
	shI1IHC4GOJ2Ad9V+PkzAVZdib746PY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-7P3tQoYOPIKCU7iP2YPC5w-1; Mon,
 15 Jan 2024 05:07:37 -0500
X-MC-Unique: 7P3tQoYOPIKCU7iP2YPC5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 653CF38425A0;
	Mon, 15 Jan 2024 10:07:36 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.130])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DFBA040C6E2C;
	Mon, 15 Jan 2024 10:07:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v1] uprobes: use pagesize-aligned virtual address when replacing pages
Date: Mon, 15 Jan 2024 11:07:31 +0100
Message-ID: <20240115100731.91007-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

uprobes passes an unaligned page mapping address to
folio_add_new_anon_rmap(), which ends up triggering a VM_BUG_ON() we
recently extended in commit 372cbd4d5a066 ("mm: non-pmd-mappable, large
folios for folio_add_new_anon_rmap()").

Arguably, this is uprobes code doing something wrong; however,
for the time being it would have likely worked in rmap code because
__folio_set_anon() would set folio->index to the same value.

Looking at __replace_page(), we'd also pass slightly wrong values to
mmu_notifier_range_init(), page_vma_mapped_walk(), flush_cache_page(),
ptep_clear_flush() and set_pte_at_notify(). I suspect most of them are
fine, but let's just mark the introducing commit as the one needed
fixing. I don't think CC stable is warranted.

We'll add more sanity checks in rmap code separately, to make sure that
we always get properly aligned addresses.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Closes: https://lkml.kernel.org/r/ZaMR2EWN-HvlCfUl@krava
Fixes: c517ee744b96 ("uprobes: __replace_page() should not use page_address_in_vma()")
Tested-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 485bb0389b488..929e98c629652 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -537,7 +537,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		}
 	}
 
-	ret = __replace_page(vma, vaddr, old_page, new_page);
+	ret = __replace_page(vma, vaddr & PAGE_MASK, old_page, new_page);
 	if (new_page)
 		put_page(new_page);
 put_old:
-- 
2.43.0


