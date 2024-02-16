Return-Path: <linux-kernel+bounces-69497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3F7858A57
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1B71F22BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E20B14A4EA;
	Fri, 16 Feb 2024 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av659Inu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295014A0B9;
	Fri, 16 Feb 2024 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127667; cv=none; b=hzUFPtSK3Bn6Ityx+tunkT8JtlP2jsoDvslFmxJTXcBQfekCiWQhb22mcWtkolJWVjiOaskpNF0pZ87GTo3kHcIqfIQ63HEH8XkgUqH++RF3gT7UpWHT7lrlU32+BU0Y1bMwMVLZYhtFIHcE9p4SdYEkvkPgMbC3TVH/sw4ETUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127667; c=relaxed/simple;
	bh=guWfSQhoX6jlJEUVpGGsH55EWxqQ6WRn1lYxZhtk0g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k73XK9EYw1hXDnbYYKaACthaV50Zdx2n8ZIZoSQE50KHi9NFXdRokJJr6fMsyHzxPpU7EX3WeJmk2fgG1DN7POF4dEUgbS3R/6y/2QccmKXLI+kX/byLKkPeZdW8YgMRCtOItK74Raq5zkAo7Vd9f/ZYjZQPml5pLKdncXbTdGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av659Inu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02993C433F1;
	Fri, 16 Feb 2024 23:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708127667;
	bh=guWfSQhoX6jlJEUVpGGsH55EWxqQ6WRn1lYxZhtk0g8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Av659InuKBIH1peQ3YSR4o7AnooIKjsn5U5brRDHW2BxnmzLmyEYHRjWN/G/R0gqH
	 4z5eRT5M6R7PRIpVHrUPsdL3S/CBBec1qaDdpWVfFSkLghSe4AVPFhxPwzvAufO9Yk
	 niXrX9ColBgpzW4dR0Y3J7g3OWJaQkMddGl3b2UBfkAMzmVOwxrKGGujeRvtoEXqUS
	 QlbT4dkBiQTMVvkjhShC4wTvMKDiYb+2byX4uyusPIvrxYd+DfzVd1TEDGWRRb3SI5
	 RB9mD6BzGIZApNhG/7MmMoNikvMPbCq422jevP+EpoCZtsqSxUZqeyMYrUvgTTdeUE
	 DH6+I4D32Rg4Q==
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
Subject: [PATCH 04/14] perf map: Add map__objdump_2rip()
Date: Fri, 16 Feb 2024 15:54:13 -0800
Message-ID: <20240216235423.2343167-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216235423.2343167-1-namhyung@kernel.org>
References: <20240216235423.2343167-1-namhyung@kernel.org>
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
2.44.0.rc0.258.g7320e95886-goog


