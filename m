Return-Path: <linux-kernel+bounces-107031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC8787F6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556222825DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBA17D3F8;
	Tue, 19 Mar 2024 05:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dl2o4ui5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F17CF0F;
	Tue, 19 Mar 2024 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827480; cv=none; b=E4n19kSIkQZXEhytjo9YwdDna34WQG2bcT2JeJGRd+ZUEnO9JVtg22+fZ5urwm+/1YVSbqs3e1MUYVMX83CEV5duy6wp8ckwsQLRNV4Srml7GaFq9Vx7MDW0+s3B0oFcIvl2eC+xjFikQSEn9gcQA66onA28pFVodMKLDuyEDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827480; c=relaxed/simple;
	bh=bAEbqgWbLQcfN0MLUSyPEU2jzHHBr14ThaOBDSWbtkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWz7TVejQcyRhuYOEUQr9eJbS/A0AlqsBZQ97eQOT9IxSUTtyOq/RLNMI+TlRkZDTpuP0j+E0xEtZ1DolF09KVhjZsq72VxsRDLymTauKlDAaytnhrMWeiqUgqp/lLzspsVaQWGcNxaK4Pm+2WoLSXoaU2TcrIYxNCWWSwNSMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dl2o4ui5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1ACC43142;
	Tue, 19 Mar 2024 05:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827480;
	bh=bAEbqgWbLQcfN0MLUSyPEU2jzHHBr14ThaOBDSWbtkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dl2o4ui5dqaiRWRM0Z5GOkX7RV6mXREl6wRfu+BD5PuBKCYiJZB8vD1hsD5yVmr5s
	 D1J5wM2qgWjuUFABe32ywmnp8SovoSUpAgBjbIG5/XfxRqE5QGqcr1SjMPd+7D5/jg
	 mbzclIly5Lki1PhigV2HqucZcpx04jUXJAzogdl2ltrW+GDrs/xOM4IbfORppN3Q+z
	 Mkf5AV7xkW/kzTKyuIhv+XCgQr26aGEwqJ6/mSDCBFmBferaNKyvSq+PTXiJDWRbgq
	 MlEmihcKYEaVBDV16EDUPW8eO4U+ED9KwDMzfhUySqfdPmLElOSUp2BYqOnvNz6a9i
	 D7POQN3mWNTuw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org,
	linux-trace-devel@vger.kernel.org
Subject: [PATCH 05/23] perf map: Add map__objdump_2rip()
Date: Mon, 18 Mar 2024 22:50:57 -0700
Message-ID: <20240319055115.4063940-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240319055115.4063940-1-namhyung@kernel.org>
References: <20240319055115.4063940-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes we want to convert an address in objdump output to
map-relative address to match with a sample data.  Let's add
map__objdump_2rip() for that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/map.c | 17 +++++++++++++++++
 tools/perf/util/map.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 14a5ea70d81e..a5d57c201a30 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -587,6 +587,23 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 	return ip + map__reloc(map);
 }
 
+/* convert objdump address to relative address.  (To be removed) */
+u64 map__objdump_2rip(struct map *map, u64 ip)
+{
+	const struct dso *dso = map__dso(map);
+
+	if (!dso->adjust_symbols)
+		return ip;
+
+	if (dso->rel)
+		return ip + map__pgoff(map);
+
+	if (dso->kernel == DSO_SPACE__USER)
+		return ip - dso->text_offset;
+
+	return map__map_ip(map, ip + map__reloc(map));
+}
+
 bool map__contains_symbol(const struct map *map, const struct symbol *sym)
 {
 	u64 ip = map__unmap_ip(map, sym->start);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 49756716cb13..65e2609fa1b1 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -132,6 +132,9 @@ u64 map__rip_2objdump(struct map *map, u64 rip);
 /* objdump address -> memory address */
 u64 map__objdump_2mem(struct map *map, u64 ip);
 
+/* objdump address -> rip */
+u64 map__objdump_2rip(struct map *map, u64 ip);
+
 struct symbol;
 struct thread;
 
-- 
2.44.0.291.gc1ea87d7ee-goog


