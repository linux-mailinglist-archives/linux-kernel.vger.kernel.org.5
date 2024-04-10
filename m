Return-Path: <linux-kernel+bounces-138336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31FD89EFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F811F23197
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A3315991A;
	Wed, 10 Apr 2024 10:35:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255DD159566;
	Wed, 10 Apr 2024 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745337; cv=none; b=Rm+IyYd1d2aHqxws33385p91PfhtoLSVhugEBpw+xbMgM7PezH1/tl8BnWHXxmZobvYe4lF8mWRF7Uh+8N0nAKK2dvn6CFhKo2x2oYOcftJH1DH0OX+HykusEWWmbhQxpMOgC/GdrOx6PPcQffJ1WwjtNtsRKxDgEJPDYjcjek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745337; c=relaxed/simple;
	bh=ypMirJBQln4cahP5+iyf5ns4VS6WkKkpnbUKpCIXRMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r5SCfGFAWixfFpfFPGS23j2SYO3JUW9QnhdbW95O5ZbjAfRJ86CNnSC80+Iz5CLqFD9H5tnryVzGS2e5Gsrk+6NNQ5Keo9llUemiEwGySxv1ltTwG0NErSzr6QPE811D/RGUomnz3wxFd52U+U4S1TGyfc9WjBj+sItPW8fKufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F50B139F;
	Wed, 10 Apr 2024 03:36:05 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 278903F6C4;
	Wed, 10 Apr 2024 03:35:33 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Spoorthy S <spoorts2@in.ibm.com>,
	Leo Yan <leo.yan@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] perf map: Remove kernel map before updating start and end addresses
Date: Wed, 10 Apr 2024 11:34:54 +0100
Message-Id: <20240410103458.813656-4-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410103458.813656-1-james.clark@arm.com>
References: <20240410103458.813656-1-james.clark@arm.com>
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


