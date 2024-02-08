Return-Path: <linux-kernel+bounces-58516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E420A84E76D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1309BB20800
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B977F84FCF;
	Thu,  8 Feb 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzYbapY4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0978E82874;
	Thu,  8 Feb 2024 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415828; cv=none; b=uIAGhnSTx/qMNGD8q2TKanq/fWwyst2m+D8H3eFsTB7s/FzD4TVUnpOWeIeYYZIncKdDUeZ5iiTv+FlP7JtucxpZP+YzzWNl2hZvtr9N04DXQA78BzkfZmY8IB/Mzif6qZPuFUrweQYF+haE1Y1KW3c2tADuGS5mTwUmydQo06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415828; c=relaxed/simple;
	bh=eQyIxKVP5DgJx/KOhgg4TQvfeRw6XlPrn08qg5cmN/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGeOyzfRN0OsLUJkqcDyWNuIpZJyv4GQUohJUB2KrnXt61Cm8gP26zhGHbpv0gYkeq0EJV9uJrEmEVJGOyfBYIO+n+s7e8clvqDKIsDCOMDoqA0STwLl5gtN9f87YNz5y89lROLMepcV47es4KOYMO3z4xR1y1Qy9zLI8CXqLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzYbapY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CD0C433C7;
	Thu,  8 Feb 2024 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707415827;
	bh=eQyIxKVP5DgJx/KOhgg4TQvfeRw6XlPrn08qg5cmN/E=;
	h=From:To:Cc:Subject:Date:From;
	b=tzYbapY4lgYyq276P4mqyg/VNN1w6rbElCtcA7rX6GpTnepoSY5QwH9o4Hoc9dgj/
	 QRr4u+4Tc8x9CvPn5yWfhr5Nf7qsyMcUNHXs/JroNiglLzLT7T7kVhAn6JWrlkUezh
	 0+C9NYtEobgL/BTB0NuDHVF/ebVvTyQyA25xPqvSM00IvdJqvOHBB6LwsOsGyrrnxN
	 j5N+WLT5ojxCdw9LHFOvuwuVeaNxLh8j+jAjPK28pWjXF+CttoXb1A/OyL0ZpPkwwA
	 Cp9Os+2/QNIZx45P7LvavxwkImg3UXZR8ZV0JSC3dtPFNowTAhLSRebMGqCl4XTu35
	 5w4O1rUda/aEg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf tools: Remove misleading comments on map functions
Date: Thu,  8 Feb 2024 10:10:25 -0800
Message-ID: <20240208181025.1329645-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When it converts sample IP to or from objdump-capable one, there's a
comment saying that kernel modules have DSO_SPACE__USER.  But commit
02213cec64bb ("perf maps: Mark module DSOs with kernel type") changed
it and makes the comment confusing.  Let's get rid of it.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/map.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index cf5a15db3a1f..14a5ea70d81e 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -553,10 +553,6 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
 	if (dso->rel)
 		return rip - map__pgoff(map);
 
-	/*
-	 * kernel modules also have DSO_TYPE_USER in dso->kernel,
-	 * but all kernel modules are ET_REL, so won't get here.
-	 */
 	if (dso->kernel == DSO_SPACE__USER)
 		return rip + dso->text_offset;
 
@@ -585,10 +581,6 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 	if (dso->rel)
 		return map__unmap_ip(map, ip + map__pgoff(map));
 
-	/*
-	 * kernel modules also have DSO_TYPE_USER in dso->kernel,
-	 * but all kernel modules are ET_REL, so won't get here.
-	 */
 	if (dso->kernel == DSO_SPACE__USER)
 		return map__unmap_ip(map, ip - dso->text_offset);
 
-- 
2.43.0.687.g38aa6559b0-goog


