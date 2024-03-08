Return-Path: <linux-kernel+bounces-96986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A7387641A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97611C216A2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06E35675D;
	Fri,  8 Mar 2024 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="XW/ufEFY"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E855E57
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900015; cv=none; b=NBFxoRl8WO7YeQiTRpAJqk+WitD12H+EB1EGNznGIA0mH5fkkgLfqgYmouofGOUnBeRtLGU74N+uRsgtMtd9Ekvk65BpebcPo6kzxVpR4Pi5NcW/ECtzjCaIZrtSLmCtKrslBmao+K6CzpEUrMsFUGZaVJNkQTj0i0WadW60Sb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900015; c=relaxed/simple;
	bh=o0MIa9u9Hqk3ZI02Q4Ut0uAnmSuanvs+Ylycd/Utd04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X1cJXgz7E7hOTgrwlpoQ08TwHWPI0nLWHr3+eK2BGISGy6KPMFGnQd/vC7Ch3JJt2YqAsuLIHBrYax7OwI++rVV7RlwxKc37AoKLwPZb2s1iJd9Nu2EpGDjPgGN4pe2Y7f9jPENw6W31e8ZoEqTmnZ2B+AliQq67b1QElXkMc4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=XW/ufEFY; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C6D4D240103
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:04:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1709899492; bh=o0MIa9u9Hqk3ZI02Q4Ut0uAnmSuanvs+Ylycd/Utd04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=XW/ufEFYmNghRO9/dJpnthQiWG7F4dM+r84VMWzKXpuhutstXjOfZcZVwq8eD5q01
	 t4A8Ln8tyESKKT1F6ZDp2vvod4+GJ7xKCv/k3vNStrYVmHZGYm+8mPempnvYqOJvsy
	 IO9XVYJdX5DGKgBSmWI1didokQ4Zwy6/Yw8gwX+WhVYHBIzKqvPi6WSiMymB3u5izt
	 Yf8NnyPMgTePJtbcEKA4zif/FT+3mHfKD72jAPe46dZ/iqkTenldUYejPs87ZQKjMS
	 l5nLQnXLx/7SfOCKQZl+LRa93RQa0mTE6wLfu1jmAoiwZ5HB6zR5xp54LSrOd1Qs5a
	 PYDPrkir/LokA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TrlGQ6hCkz6tm4;
	Fri,  8 Mar 2024 13:04:46 +0100 (CET)
From: Anne Macedo <retpolanne@posteo.net>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Anne Macedo <retpolanne@posteo.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v0] perf lock contention: skip traceiter functions
Date: Fri,  8 Mar 2024 12:03:31 +0000
Message-Id: <20240308120332.372810-1-retpolanne@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf lock contention program currently shows the caller of the locks
as __traceiter_contention_begin+0x??. This caller can be ignored, as it is
from the traceiter itself. Instead, it should show the real callers for
the locks.

When fiddling with the --stack-skip parameter, the actual callers for
the locks start to show up. However, just ignore the
__traceiter_contention_begin and the __traceiter_contention_end symbols
so the actual callers will show up.

Before this patch is applied:

sudo perf lock con -a -b -- sleep 3
 contended   total wait     max wait     avg wait         type   caller

         8      2.33 s       2.28 s     291.18 ms     rwlock:W   __traceiter_contention_begin+0x44
         4      2.33 s       2.28 s     582.35 ms     rwlock:W   __traceiter_contention_begin+0x44
         7    140.30 ms     46.77 ms     20.04 ms     rwlock:W   __traceiter_contention_begin+0x44
         2     63.35 ms     33.76 ms     31.68 ms        mutex   trace_contention_begin+0x84
         2     46.74 ms     46.73 ms     23.37 ms     rwlock:W   __traceiter_contention_begin+0x44
         1     13.54 us     13.54 us     13.54 us        mutex   trace_contention_begin+0x84
         1      3.67 us      3.67 us      3.67 us      rwsem:R   __traceiter_contention_begin+0x44

Before this patch is applied - using --stack-skip 5

sudo perf lock con --stack-skip 5 -a -b -- sleep 3
 contended   total wait     max wait     avg wait         type   caller

         2      2.24 s       2.24 s       1.12 s      rwlock:W   do_epoll_wait+0x5a0
         4      1.65 s     824.21 ms    412.08 ms     rwlock:W   do_exit+0x338
         2    824.35 ms    824.29 ms    412.17 ms     spinlock   get_signal+0x108
         2    824.14 ms    824.14 ms    412.07 ms     rwlock:W   release_task+0x68
         1     25.22 ms     25.22 ms     25.22 ms        mutex   cgroup_kn_lock_live+0x58
         1     24.71 us     24.71 us     24.71 us     spinlock   do_exit+0x44
         1     22.04 us     22.04 us     22.04 us      rwsem:R   lock_mm_and_find_vma+0xb0

After this patch is applied:

sudo ./perf lock con -a -b -- sleep 3
 contended   total wait     max wait     avg wait         type   caller

         6      5.27 s       1.76 s     878.55 ms     rwlock:W   release_task+0x68
         2      2.99 s       2.99 s       1.50 s      spinlock   do_send_sig_info+0x3c
         2      1.77 s       1.77 s     884.39 ms     spinlock   sigprocmask+0x98
         2      1.76 s       1.76 s     878.56 ms     rwlock:W   do_exit+0x338
         2      1.76 s       1.76 s     878.55 ms     rwlock:W   release_task+0x68
         5      1.76 s       1.76 s     351.41 ms     rwlock:W   do_exit+0x338
         1     48.10 ms     48.10 ms     48.10 ms        mutex   trace_contention_begin+0x84
         4    257.80 us    119.34 us     64.45 us     spinlock   get_signal+0x108
         1      9.33 us      9.33 us      9.33 us     rwlock:W   do_exit+0x338

Signed-off-by: Anne Macedo <retpolanne@posteo.net>
---
 tools/perf/util/machine.c | 10 ++++++++++
 tools/perf/util/machine.h |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 527517db3182..8e729167c1aa 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3266,6 +3266,12 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_end", &kmap);
 		machine->lock.text_end = map__unmap_ip(kmap, sym->start);
+
+		sym = machine__find_kernel_symbol_by_name(machine, "__traceiter_contention_begin", &kmap);
+		machine->traceiter.text_start = map__unmap_ip(kmap, sym->start);
+
+		sym = machine__find_kernel_symbol_by_name(machine, "__traceiter_contention_end", &kmap);
+		machine->traceiter.text_end = map__unmap_ip(kmap, sym->start);
 	}
 
 	/* failed to get kernel symbols */
@@ -3280,5 +3286,9 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 	if (machine->lock.text_start <= addr && addr < machine->lock.text_end)
 		return true;
 
+	/* traceiter functions are in traceiter text section  */
+	if (machine->traceiter.text_start <= addr && addr < machine->traceiter.text_end)
+		return true;
+
 	return false;
 }
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index e28c787616fe..ec51e9b080b9 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -49,7 +49,7 @@ struct machine {
 	struct {
 		u64	  text_start;
 		u64	  text_end;
-	} sched, lock;
+	} sched, lock, traceiter;
 	pid_t		  *current_tid;
 	size_t		  current_tid_sz;
 	union { /* Tool specific area */
-- 
2.39.2


