Return-Path: <linux-kernel+bounces-97903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1885987715D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D181C20AFB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6363BBE4;
	Sat,  9 Mar 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="F/iUVdae"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477EB3BBD9
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709990849; cv=none; b=BB17PUnAjdrGYatNDuUKTwrNaItexS2Kof3NPkqwufOAyWzw52HwcjsGWfGZQ5LtjyocGn7TcLWoB8QvP3x8Wm0TH9tlvxLFSqAi+kLkxX8tmgZE1QE8UNMtHbawi13jdXJjCtPzuSSK2e9UfiAehsor/dLFOkqLzLkIc/VUSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709990849; c=relaxed/simple;
	bh=H5KG5JIlYcGKNIUTpGPnJgLheL+UM4pOuIquZzGQ48Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kznsOiXTqSaSBX0eGQvgrHYUKxDFQ6acBcgrIqB+Pl0xQMoggt/4T65Yh1EmUscHumxlK7anzijnvt/b6M0O3Ca/boBvoo4+vYhiT/qPs/ypRnCahZVSLdvie2m1g/gowwSfzQmEDJ9aWFnY/9A/woY6tYh55I7LuaEmxcu7IyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=F/iUVdae; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id CB3D9240028
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 14:27:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1709990843; bh=H5KG5JIlYcGKNIUTpGPnJgLheL+UM4pOuIquZzGQ48Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=F/iUVdae+0D4WrggHOP/rzjqSvD2LbbBugqcZhVMqwxkOH5WfVecY6InQSasLcI3n
	 0TnLTkOOl9+B/FUw3NWKUklGPwo6ijzWydsfiUgNWosAKMOPgsbGcZCyigAJL/puhZ
	 7/+DJ4fmGhxYktbO2cM3urNw4IWjOicENVPfTVoCLY8mRNym+UQSQhbgE3aZhEygVs
	 JxBN4UJz/MM05AsuLrBa2aPzv/8ltF00tSONaCQOSd9aR54zCgm+/Xq/pJ94JtBWUo
	 vHWx7jtqc5j3VK+bVqc8jGrNjDoIpKqcrATlnrpTQSHAw6MF1UzYKNqBmRvtrXgPvw
	 wMSGy+cpLPFXA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TsP394wgsz9rxB;
	Sat,  9 Mar 2024 14:27:17 +0100 (CET)
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
Subject: [PATCH v1] perf lock contention: skip traceiter functions
Date: Sat,  9 Mar 2024 13:27:08 +0000
Message-Id: <20240309132710.1055941-1-retpolanne@posteo.net>
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

changes since v0:

- skip trace_contention functions
- use sym->end instead of __traceiter_contention_end for text_end

Signed-off-by: Anne Macedo <retpolanne@posteo.net>
---
 tools/perf/util/machine.c | 17 +++++++++++++++++
 tools/perf/util/machine.h |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 527517db3182..db443947ccd1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3266,6 +3266,14 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 
 		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_end", &kmap);
 		machine->lock.text_end = map__unmap_ip(kmap, sym->start);
+
+		sym = machine__find_kernel_symbol_by_name(machine, "__traceiter_contention_begin", &kmap);
+		machine->traceiter.text_start = map__unmap_ip(kmap, sym->start);
+		machine->traceiter.text_end = map__unmap_ip(kmap, sym->end);
+
+		sym = machine__find_kernel_symbol_by_name(machine, "trace_contention_begin", &kmap);
+		machine->trace.text_start = map__unmap_ip(kmap, sym->start);
+		machine->trace.text_end = map__unmap_ip(kmap, sym->end);
 	}
 
 	/* failed to get kernel symbols */
@@ -3280,5 +3288,14 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
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


