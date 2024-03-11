Return-Path: <linux-kernel+bounces-99637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A24C878B01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF63F2824B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9C058235;
	Mon, 11 Mar 2024 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="hA4zvyWp"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58F15914A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197833; cv=none; b=uH8wLIaH/0ApKQauozyJoqjELHYpLKcEuEKrwslxYPyeDTU1+ly6GBSczLWthHo85ktnos8vbuYuSFubqEj//pgTBTfv1DFQgGarwrV3my4JJfjE30p+IRVH0qbGo2MDSsU7+wopf73/kMCP8soAVIwVFIRa+PKeK9YSqLRpUZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197833; c=relaxed/simple;
	bh=tj9OXdwPc5R1uIG5Y754PbkvA6/O9POegUZKX17YnUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KnwF+dxbfKfg7vdgZC5OaP254pv+vQjdE5AIkdLODxW9FxIGemgTEBWcQ0bfOaLxGlDuTF/EdKmkG4MhRmuNUMXBqDoSDCJi7Jg0Mwigt3L5GYzBXs3Iw421MqQOxvaEJ73zQiqwaVUEmBN/cB8IKj1MzFkB9+u/BrUVXg7mS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=hA4zvyWp; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DF948240105
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:57:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1710197827; bh=tj9OXdwPc5R1uIG5Y754PbkvA6/O9POegUZKX17YnUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=hA4zvyWpgvA44JZh9C1zQ9ncrOI1K+z7HxwBhj6nVSt5qS4bNkMAEBNF+VtluLKVh
	 Rg/w4KRoToOmxUXLtk5fzmhq3uQLd0e6g6BzwGJeOD8sotVXoX+aWoOi3pM2ynf98E
	 nvY4wWPDnJBzV4ujU2aUt1CAD2epEILjpVYIiFmpacBy6rQ33ZuOe9l8lF+oizccoO
	 /2E6yI6C6deEFzfl4DylK+Cmj7R+qMPR9vuEq1Kwapr30SkTsGaqY78H4RoFA4Vefv
	 ECsiPU6j59N6b9uTRLe/8nGKhBQUJKLFYdr18Mw59gT2F3gDKER1Qr4wlnqYQ3w//b
	 Rk3xapT7LPbfg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Ttsbd5kSNz9rxD;
	Mon, 11 Mar 2024 23:57:01 +0100 (CET)
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
Subject: [PATCH v2] perf lock contention: skip traceiter functions
Date: Mon, 11 Mar 2024 22:56:15 +0000
Message-Id: <20240311225617.179184-1-retpolanne@posteo.net>
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

         4      4.13 s       2.07 s       1.03 s      rwlock:W   release_task+0x68
         2      2.07 s       2.07 s       1.03 s      rwlock:R   mm_update_next_owner+0x50
         2      2.07 s       2.07 s       1.03 s      rwlock:W   do_exit+0x338
         1     41.56 ms     41.56 ms     41.56 ms        mutex   cgroup_kn_lock_live+0x58
         2     36.12 us     18.83 us     18.06 us     rwlock:W   do_exit+0x338

changes since v1:

- consider trace_contention and __traceiter_contention functions as
optional (i.e. check if sym is null to avoid segfault)

changes since v0:

- skip trace_contention functions
- use sym->end instead of __traceiter_contention_end for text_end

Signed-off-by: Anne Macedo <retpolanne@posteo.net>
---
 tools/perf/util/machine.c | 21 +++++++++++++++++++++
 tools/perf/util/machine.h |  2 +-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 527517db3182..968f69364f9a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3266,6 +3266,18 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_end", &kmap);
 		machine->lock.text_end = map__unmap_ip(kmap, sym->start);
+
+		sym = machine__find_kernel_symbol_by_name(machine, "__traceiter_contention_begin", &kmap);
+		if (sym) {
+			machine->traceiter.text_start = map__unmap_ip(kmap, sym->start);
+			machine->traceiter.text_end = map__unmap_ip(kmap, sym->end);
+		}
+
+		sym = machine__find_kernel_symbol_by_name(machine, "trace_contention_begin", &kmap);
+		if (sym) {
+			machine->trace.text_start = map__unmap_ip(kmap, sym->start);
+			machine->trace.text_end = map__unmap_ip(kmap, sym->end);
+		}
 	}
 
 	/* failed to get kernel symbols */
@@ -3280,5 +3292,14 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 	if (machine->lock.text_start <= addr && addr < machine->lock.text_end)
 		return true;
 
+	/* traceiter functions currently don't have their own section
+	 * but we consider them lock functions
+	 */
+	if (machine->traceiter.text_start <= addr && addr < machine->traceiter.text_end)
+		return true;
+
+	if (machine->trace.text_start <= addr && addr < machine->trace.text_end)
+		return true;
+
 	return false;
 }
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index e28c787616fe..4312f6db6de0 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -49,7 +49,7 @@ struct machine {
 	struct {
 		u64	  text_start;
 		u64	  text_end;
-	} sched, lock;
+	} sched, lock, traceiter, trace;
 	pid_t		  *current_tid;
 	size_t		  current_tid_sz;
 	union { /* Tool specific area */
-- 
2.39.2


