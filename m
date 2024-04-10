Return-Path: <linux-kernel+bounces-138334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651AD89EFE8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6B8286965
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AAB15920E;
	Wed, 10 Apr 2024 10:35:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99DA1581E5;
	Wed, 10 Apr 2024 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745326; cv=none; b=XNMIhZ/9gym1+7wLypib5VPAtfnBlSwmW6eGpd3AMuU8uZdz1jcLHWpqy02Ah/CuPJMDAqn7HKTpGUVjc01ode1Id3aIfx6YsQIYyJCs5Xlt0eHONeiz/Q8N0ivHvGKSTvv50C+kIpLIXP2syaFHvwCq1RJYeOslFl+D/r/G3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745326; c=relaxed/simple;
	bh=A4edVE/D8u1t1sQx4i9oqjQfzNIjaTh9JSqLAHcrSms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nkgPJ0TahU/SL6qA1x312ptKpldmP/0W3aYI6XyDPQps69ZLm1o1GUPW+ErYBsX299TmYYNHb1bxyt6WYALQjJnWhdcoNzBvqfllTngT059aYHb1/SioZyxFZJ8Mi0HY08EJgGv4V+XzJ55M5+aae3mXcGZMiYJaq78U14GijW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1038B1480;
	Wed, 10 Apr 2024 03:35:54 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A34263F6C4;
	Wed, 10 Apr 2024 03:35:21 -0700 (PDT)
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
Subject: [PATCH v2 1/4] perf tests: Make "test data symbol" more robust on Neoverse N1
Date: Wed, 10 Apr 2024 11:34:52 +0100
Message-Id: <20240410103458.813656-2-james.clark@arm.com>
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

To prevent anyone from seeing a test failure appear as a regression and
thinking that it was caused by their code change, insert some noise into
the loop which makes it immune to sampling bias issues (errata 1694299).

The "test data symbol" test can fail with any unrelated change that
shifts the loop into an unfortunate position in the Perf binary which is
almost impossible to debug as the root cause of the test failure.
Ultimately it's caused by the referenced errata.

Fixes: 60abedb8aa90 ("perf test: Introduce script for data symbol testing")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/workloads/datasym.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/tests/workloads/datasym.c b/tools/perf/tests/workloads/datasym.c
index ddd40bc63448..8e08fc75a973 100644
--- a/tools/perf/tests/workloads/datasym.c
+++ b/tools/perf/tests/workloads/datasym.c
@@ -16,6 +16,22 @@ static int datasym(int argc __maybe_unused, const char **argv __maybe_unused)
 {
 	for (;;) {
 		buf1.data1++;
+		if (buf1.data1 == 123) {
+			/*
+			 * Add some 'noise' in the loop to work around errata
+			 * 1694299 on Arm N1.
+			 *
+			 * Bias exists in SPE sampling which can cause the load
+			 * and store instructions to be skipped entirely. This
+			 * comes and goes randomly depending on the offset the
+			 * linker places the datasym loop at in the Perf binary.
+			 * With an extra branch in the middle of the loop that
+			 * isn't always taken, the instruction stream is no
+			 * longer a continuous repeating pattern that interacts
+			 * badly with the bias.
+			 */
+			buf1.data1++;
+		}
 		buf1.data2 += buf1.data1;
 	}
 	return 0;
-- 
2.34.1


