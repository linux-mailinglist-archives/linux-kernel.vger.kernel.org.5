Return-Path: <linux-kernel+bounces-118903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D544988C0EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1213A1C3CDB8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9BA59150;
	Tue, 26 Mar 2024 11:38:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C68548F5;
	Tue, 26 Mar 2024 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453095; cv=none; b=SdFPqmgJSYe7eRkzR6u1TmbiUqeS60IFij73YwEAC6upZP+YEwtFzq0Ij285VNEcTSxKnu+6a4HW3Uirts2lTGrr6PxfUQ4IVPwGNqiF5sJ8qVCIACljQMlODdbIbtG8GqmVtoi7x6eh+UCuZuaGnGk1vVTWqNM0pvpu4zLy7eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453095; c=relaxed/simple;
	bh=lw2/MHVdNGxwuR1HESLQBQVsZMg/4d22FzVRjET0DfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ejmkFc/mwjKBFgucWvTlftJCXh+jbHamiKW06T1uqnaRFsLVm3mRSyaJJ2mb08VGyR3dZjcCY1TLBrmTkhkNKgGI0p0ucDf+uPDCpbRJMefsOUr4MMLmCMJqk9gznpYdM+M/iMfcK0jk5P5irnt8L/yVG1vHTQX4plSDg7sQ0V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 898932F4;
	Tue, 26 Mar 2024 04:38:45 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D48963F64C;
	Tue, 26 Mar 2024 04:38:09 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf test: Increase buffer size for Coresight basic tests
Date: Tue, 26 Mar 2024 11:37:49 +0000
Message-Id: <20240326113749.257250-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tests record in a mode that includes kernel trace but look for
samples of a userspace process. This makes them sensitive to any kernel
compilation options that increase the amount of time spent in the
kernel. If the trace buffer is completely filled before userspace is
reached then the test will fail. Double the buffer size to fix this.

The other tests in the same file aren't sensitive to this for various
reasons, for example the iterate devices test filters by userspace
trace only. But in order to keep coverage of all the modes, increase the
buffer size rather than filtering by userspace for the basic tests.

Fixes: d1efa4a0a696 ("perf cs-etm: Add separate decode paths for timeless and per-thread modes")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 65dd85207125..3302ea0b9672 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -188,7 +188,7 @@ arm_cs_etm_snapshot_test() {
 
 arm_cs_etm_basic_test() {
 	echo "Recording trace with '$*'"
-	perf record -o ${perfdata} "$@" -- ls > /dev/null 2>&1
+	perf record -o ${perfdata} "$@" -m,8M -- ls > /dev/null 2>&1
 
 	perf_script_branch_samples ls &&
 	perf_report_branch_samples ls &&
-- 
2.34.1


