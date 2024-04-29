Return-Path: <linux-kernel+bounces-163117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A3B8B65F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4062831DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0D554BE0;
	Mon, 29 Apr 2024 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUinoZIO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2EF1E888;
	Mon, 29 Apr 2024 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431460; cv=none; b=tV2H1OfK50FMZm0Fn4HsytjLCJ4y61Zj2hve1sjsDM7PZfAITYks3965PhHQO2HdFWKeBBzvnuzEP0rFJ/3127ssV/r1pMkiBYesn1Rt3NX3wW/mU72FSTodIjsxVadNqSX9cpXcTU4ryEDUkvlhyTAKaFsmYyfsM3G7uB54xN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431460; c=relaxed/simple;
	bh=WIYeIyuZMEic4wS0TYk6SanQeD6+R01+KLorHb/LgME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5GDpLqgkWn7dDi7pZVXtTeNYu5N5vLDcjMPFHX2aWRJJpgBNIQsM6aMH23nFw93FEy0bleWqyXA4G+8KHkMnXnBeQfPe2HWTxz8ZkSE2ErwqGHTMUEdvjehvLwW3Sr8a3RMlNz/DbNJ2QuGgynu5oNt1WnQ03LHRA+PuIoyeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUinoZIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D4BC113CD;
	Mon, 29 Apr 2024 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714431459;
	bh=WIYeIyuZMEic4wS0TYk6SanQeD6+R01+KLorHb/LgME=;
	h=From:To:Cc:Subject:Date:From;
	b=FUinoZIOtEWv0U80gEnwGYCB2S4xw8/q9RAT8i2Tr5YapZIIaH9P6tRkDa78gHKAO
	 xPkgYHLhBYnvtqn5uHSDJTsTM/usXe9tDi3vNE6C7/x1Aom5HghDXF89ttbFvJmKeE
	 wjUODox83ePCmtnwHxsxt4Yx3fDiID5RwOd4vswRZHiCutwsRP1MWqkIc54S3NBqLR
	 FEBgt7u3cDh9gNCW1GuFp8mpmZR0njgO/yHE/cUY2NolHLkFaQlICG5wOb/MUtm768
	 hjAJSIIVops1kh7wnbMwUffHVSC8PHSyt07J+hJekB+RvJAlRY3QdocClZFyR3CgDt
	 UQ7qoP7MIFEJQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf maps: Remove check_invariants() from maps__lock()
Date: Mon, 29 Apr 2024 15:57:38 -0700
Message-ID: <20240429225738.1491791-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found that the debug build was a lot slowed down by the maps lock code
since it checks the invariants whenever it gets the pointer to the lock.
This means it checks twice the invariants before and after the access.

Instead, let's move the checking code within the lock area but after any
modification and remove it from the read paths.  This would remove (more
than) the half of the maps lock overhead.

The time for perf report with a huge data file (200k+ of MMAP2 events).

  Non-debug     Before      After
  ---------   --------   --------
     2m 43s     6m 45s     4m 21s

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/maps.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 725300896f38..61eb742d91e3 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -211,11 +211,6 @@ void maps__set_unwind_libunwind_ops(struct maps *maps, const struct unwind_libun
 
 static struct rw_semaphore *maps__lock(struct maps *maps)
 {
-	/*
-	 * When the lock is acquired or released the maps invariants should
-	 * hold.
-	 */
-	check_invariants(maps);
 	return &RC_CHK_ACCESS(maps)->lock;
 }
 
@@ -358,6 +353,7 @@ static int map__strcmp(const void *a, const void *b)
 static int maps__sort_by_name(struct maps *maps)
 {
 	int err = 0;
+
 	down_write(maps__lock(maps));
 	if (!maps__maps_by_name_sorted(maps)) {
 		struct map **maps_by_name = maps__maps_by_name(maps);
@@ -384,6 +380,7 @@ static int maps__sort_by_name(struct maps *maps)
 			maps__set_maps_by_name_sorted(maps, true);
 		}
 	}
+	check_invariants(maps);
 	up_write(maps__lock(maps));
 	return err;
 }
@@ -502,6 +499,7 @@ int maps__insert(struct maps *maps, struct map *map)
 
 	down_write(maps__lock(maps));
 	ret = __maps__insert(maps, map);
+	check_invariants(maps);
 	up_write(maps__lock(maps));
 	return ret;
 }
@@ -536,6 +534,7 @@ void maps__remove(struct maps *maps, struct map *map)
 {
 	down_write(maps__lock(maps));
 	__maps__remove(maps, map);
+	check_invariants(maps);
 	up_write(maps__lock(maps));
 }
 
@@ -602,6 +601,7 @@ void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data
 		else
 			i++;
 	}
+	check_invariants(maps);
 	up_write(maps__lock(maps));
 }
 
@@ -942,6 +942,8 @@ int maps__copy_from(struct maps *dest, struct maps *parent)
 			map__put(new);
 		}
 	}
+	check_invariants(dest);
+
 	up_read(maps__lock(parent));
 	up_write(maps__lock(dest));
 	return err;
@@ -1097,6 +1099,7 @@ void maps__fixup_end(struct maps *maps)
 		map__set_end(maps_by_address[n - 1], ~0ULL);
 
 	RC_CHK_ACCESS(maps)->ends_broken = false;
+	check_invariants(maps);
 
 	up_write(maps__lock(maps));
 }
@@ -1147,6 +1150,8 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 	    map__start(kmaps_maps_by_address[first_after_]) >= map__end(new_map)) {
 		/* No overlap so regular insert suffices. */
 		int ret = __maps__insert(kmaps, new_map);
+
+		check_invariants(kmaps);
 		up_write(maps__lock(kmaps));
 		return ret;
 	}
@@ -1184,6 +1189,7 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 		map__zput(kmaps_maps_by_address[i]);
 
 	free(kmaps_maps_by_address);
+	check_invariants(kmaps);
 	up_write(maps__lock(kmaps));
 	return 0;
 }
-- 
2.44.0.769.g3c40516874-goog


