Return-Path: <linux-kernel+bounces-58977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA94884EF56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB451C22680
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EC329D1C;
	Fri,  9 Feb 2024 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvX5ZOHU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDF1B942;
	Fri,  9 Feb 2024 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448498; cv=none; b=Ho3VBPkylD9d/eFT/hNUK/nIh/OL7wKB8Wk9MEYkHaybgvnlStYQ1uHDQzPMfzsHqz0f+nYB9TdpZKFMs+X4ynWzcrWJtqvk8M2Oc+MHOdgW2ZM/Z5mp2vL9JHpXTztq7kOhc0kYFiUHAtC/95qnCCtmJuOSB3m0e9eZCS6KEeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448498; c=relaxed/simple;
	bh=4TtYi0lpyHo54jJPp5QX24oZBCSlhJrdo5RjQxIdVIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvkQRl9fC3Xk/1oWK1mNUi7+Pu5uz7WCaOvEL1grMaa31F3aGWUcXsaS6afKBU08Mwc7hPDjdzDrhqoxaCD0xErQYKC9TRK15GIQrgLMg2VzyFJ8x2z/x58ml4+sxLVe0jBfv7vPnq2z3qOC7wJyv9wqz1C+alb1WOlHiXE4e/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvX5ZOHU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448497; x=1738984497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4TtYi0lpyHo54jJPp5QX24oZBCSlhJrdo5RjQxIdVIQ=;
  b=YvX5ZOHUqwP3G1ate8wcnTfVlfuOyfr7O/qCqXAZ68Ge1r5b3JROXJLf
   7cshPAcNRX5PM87/kclURq/Au/1RcycLx/Xvst0gwZMSDFdcYSrEcTiYr
   SKlNQU2emAolnmSDmFLQrPRiOX7/M8AfTrvDU8gdHsGQJzYZbR78/5Crd
   0iMNelEADLrD6vwffGIj4V7t1WQ6dMrAktEic5y981ZJP2uP8IXgAd84X
   ZO47tYgfliOQ7n202VabwbSTqtzm57wNorgjJVWF3EHuHTNetSDEEIk0q
   HCnhqibMWTcXVnUOt/RhKid6vaUFMggutMT/nPyXBwVrjBoCpHplRPq0K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257945"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257945"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631450"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa002.jf.intel.com with ESMTP; 08 Feb 2024 19:14:48 -0800
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH v4 12/15] perf stat: Handle NMI in hardware-grouping
Date: Thu,  8 Feb 2024 19:14:38 -0800
Message-ID: <20240209031441.943012-13-weilin.wang@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240209031441.943012-1-weilin.wang@intel.com>
References: <20240209031441.943012-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Add an easy nmi watchdog support in grouping. When nmi watchdog is enabled,
we reduce the total num of events could be assigned to one group by 1. A
more efficient solution will be added in later.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 95d3868819e3..f1eb73957765 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1947,6 +1947,10 @@ static int insert_new_group(struct list_head *head,
 			   size_t num_fixed_counters)
 {
 	INIT_LIST_HEAD(&new_group->event_head);
+	if (sysctl__nmi_watchdog_enabled()) {
+		pr_debug("NMI watchdog is enabled. Reduce num of counters by 1\n");
+		num_counters -= 1;
+	}
 	fill_counter_bitmap(new_group->gp_counters, 0, num_counters);
 	fill_counter_bitmap(new_group->fixed_counters, 0, num_fixed_counters);
 	new_group->taken_alone = false;
-- 
2.42.0


