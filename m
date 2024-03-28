Return-Path: <linux-kernel+bounces-107660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4593787FFB8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97A71F260B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CD7208BA;
	Tue, 19 Mar 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="kdPV7B8o"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4091CD09
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859010; cv=none; b=ODI15VX2zshHvEzTgDmX2IU/HBskFnBmdlVWemd/Gq6CJcNaWaMopKB7kuNqN2ZjqhTRY+YnAQAnLD3BpogynB8T6r+2Z5dG8tujJ+S10lSz3GDxBl4LPuGxdDPdfSY5hRPUL/s2M5zkZdpoq7MOC/Mk5OJ4KMedQjASd++i8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859010; c=relaxed/simple;
	bh=aHOwznPUczTGmDgYQBLLfOi/SdumXUHjOnnmumsSba0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vrq+j9IH/+lxg1g+1CBzHm49K6Yt8HDUvDxdpIWPwBNAg6h3fnyhwDBF6YnX4c9liQ40W8RgNbjaVmEsSQyzBiUau7fhubJGeAX3rsMSxmHscophZDt/9vMDuRZlKKimkiwUHt3m0bGzsftfIMsTaDQ4fOaXiUYnixMHXZyAQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=kdPV7B8o; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id ACA7E24002A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:36:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1710859006; bh=aHOwznPUczTGmDgYQBLLfOi/SdumXUHjOnnmumsSba0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=kdPV7B8o+Q9yyQ2WaknBeSFHeBYsx67LSH0+RJ98fLpxrtglcPk4MToE9+3ABcn7o
	 LwanZ3rsNg5OWOd4zNVcsoWaHaZ2Oj9j6D5q4GzgTFwvKEn5K+1opSdJoRb/FRnT5y
	 FNO70EoQq21r68lolJ5hM3QwZ3cmjH1qXD8bDYkB3nR7B9YPXZqtGQW+4AXA1Qae5i
	 xbCDcpSvrYQCl770/z2KvnTPVvFdsr/imZPHQZdM1NbMNA4d2DzZ3y9CyDi1r2KN5y
	 /LdYkQ9b/LiBYlhr7w7b3v4bG+EPn+eNlVHFIXb9tIdXvpllO/8aIKWpUwqCqqPkii
	 EhwWp7TRCndcg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TzZ6d09LVz6txd;
	Tue, 19 Mar 2024 15:36:40 +0100 (CET)
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
Subject: [PATCH v4] perf lock contention: skip traceiter functions
Date: Tue, 19 Mar 2024 14:36:26 +0000
Message-Id: <20240319143629.3422590-1-retpolanne@posteo.net>
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

changes since v3:

- remove dummy value and assume machine->traceiter and machine->trace
have zero address

changes since v2:

- add dummy value to machine->traceiter and machine->trace to make
necessary checks, fixing possible null pointer access

changes since v1:

- consider trace_contention and __traceiter_contention functions as
optional (i.e. check if sym is null to avoid segfault)

changes since v0:

- skip trace_contention functions
- use sym->end instead of __traceiter_contention_end for text_end

Signed-off-by: Anne Macedo <retpolanne@posteo.net>
---
 tools/perf/util/machine.c | 24 ++++++++++++++++++++++++
 tools/perf/util/machine.h |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 527517db3182..5eb9044bc223 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3266,6 +3266,17 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_end", &kmap);
 		machine->lock.text_end = map__unmap_ip(kmap, sym->start);
+
+		sym = machine__find_kernel_symbol_by_name(machine, "__traceiter_contention_begin", &kmap);
+		if (sym) {
+			machine->traceiter.text_start = map__unmap_ip(kmap, sym->start);
+			machine->traceiter.text_end = map__unmap_ip(kmap, sym->end);
+		}
+		sym = machine__find_kernel_symbol_by_name(machine, "trace_contention_begin", &kmap);
+		if (sym) {
+			machine->trace.text_start = map__unmap_ip(kmap, sym->start);
+			machine->trace.text_end = map__unmap_ip(kmap, sym->end);
+		}
 	}
 
 	/* failed to get kernel symbols */
@@ -3280,5 +3291,18 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 	if (machine->lock.text_start <= addr && addr < machine->lock.text_end)
 		return true;
 
+	/* traceiter functions currently don't have their own section
+	 * but we consider them lock functions
+	 */
+	if (machine->traceiter.text_start != 0) {
+		if (machine->traceiter.text_start <= addr && addr < machine->traceiter.text_end)
+			return true;
+	}
+
+	if (machine->trace.text_start != 0) {
+		if (machine->trace.text_start <= addr && addr < machine->trace.text_end)
+			return true;
+	}
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


