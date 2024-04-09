Return-Path: <linux-kernel+bounces-136502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76289D4D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B4AB21C6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB307F7C5;
	Tue,  9 Apr 2024 08:48:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38DD7E77B;
	Tue,  9 Apr 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652493; cv=none; b=VCNLKQY+dmAMj6P3g9auLbsVZxIr4eHBaKNthInmrjeEG4lUrEVV0TkJarRliETL47x2dwsqsIZst9gTCOxIUhBUKkFYbVPlkDD//CPjFkWzICsI0HbT131dMN7lsm5yL5942oMhkv7cL717qq4VG7uhI8iK7KpK80WYw9xHM6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652493; c=relaxed/simple;
	bh=ypMirJBQln4cahP5+iyf5ns4VS6WkKkpnbUKpCIXRMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOQilDrE4205mzrevI5M6Nv/7ll5FtTW76F2UXbn9eWIjm8X/tyF2ybQc5ASDLevKs+M1c46Oxz+3+uYD3rHcCVGw4sl9rvWHgFYm0K0UPiXsOclC+IEO/hLk+e/2SNN4fzHiMpYIc99+NX+jd93SO9NseQFHU/Z7IMGSCK7upY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DD8D12FC;
	Tue,  9 Apr 2024 01:48:41 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2201C3F6C4;
	Tue,  9 Apr 2024 01:48:09 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Leo Yan <leo.yan@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf map: Remove kernel map before updating start and end addresses
Date: Tue,  9 Apr 2024 09:47:38 +0100
Message-Id: <20240409084741.405433-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409084741.405433-1-james.clark@arm.com>
References: <20240409084741.405433-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a debug build there is validation that mmap lists are sorted when
taking a lock. In machine__update_kernel_mmap() the start and end
addresses are updated resulting in an unsorted list before the map is
removed from the list. When the map is removed, the lock is taken which
triggers the validation and the failure:

  $ perf test "object code reading"
  --- start ---
  perf: util/maps.c:88: check_invariants: Assertion `map__start(prev) <= map__start(map)' failed.
  Aborted

Fix it by updating the addresses after removal, but before insertion.
The bug depends on the ordering and type of debug info on the system and
doesn't reproduce everywhere.

Fixes: 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for addresses")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5eb9044bc223..a26c8bea58d0 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1549,8 +1549,8 @@ static int machine__update_kernel_mmap(struct machine *machine,
 	updated = map__get(orig);
 
 	machine->vmlinux_map = updated;
-	machine__set_kernel_mmap(machine, start, end);
 	maps__remove(machine__kernel_maps(machine), orig);
+	machine__set_kernel_mmap(machine, start, end);
 	err = maps__insert(machine__kernel_maps(machine), updated);
 	map__put(orig);
 
-- 
2.34.1


