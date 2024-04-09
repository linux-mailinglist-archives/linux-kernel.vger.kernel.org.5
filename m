Return-Path: <linux-kernel+bounces-136503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB37489D4D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B39283635
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257E67FBB3;
	Tue,  9 Apr 2024 08:48:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300ED75804;
	Tue,  9 Apr 2024 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652497; cv=none; b=ThkyIEkwvml+FiHeumPYWGUXObxBXnSfFQULK+XggsGSMybTPlvDfwuDL2DoaP9qp604enzvPhKe7ttiUM5vXVg4OuZCF6qYPEvgjeT7xntcXWyS3BXMNadls59l5y6ETyPyNWidM5JCrl0r+vztJ2nY/7qGaCHOpHFE34m1FLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652497; c=relaxed/simple;
	bh=BXP5md7/hHHu4h4OFAZPG2kfyxAEBHiOCPm1niu89T8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ag3GAw3aqBNr6LWchYLOOskdPgFtlMAXEw44LdU3IR9BDNbTmoENc699OJOH5/xMJnmyWqGUtDI8/emZMoa/eYMQc/Q8N+yh1qSgQlIKTXNq7oichVHLYJWVSpQXiBVAo8EWRvPJBli1XMgGoIjbH8l4DXsPa8QwzaGFe/AeDWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BE44DA7;
	Tue,  9 Apr 2024 01:48:46 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB3753F6C4;
	Tue,  9 Apr 2024 01:48:13 -0700 (PDT)
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
Subject: [PATCH 3/3] perf tests: Skip "test data symbol" on Neoverse N1
Date: Tue,  9 Apr 2024 09:47:39 +0100
Message-Id: <20240409084741.405433-4-james.clark@arm.com>
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

To prevent anyone from seeing a test failure appear as a regression and
thinking that it was caused by their code change, just skip the test on
N1.

It can be caused by any unrelated change that shifts the loop into an
unfortunate position in the Perf binary which is almost impossible to
debug as the root cause of the test failure. Ultimately it's caused by
the referenced errata.

Fixes: 60abedb8aa90 ("perf test: Introduce script for data symbol testing")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/shell/test_data_symbol.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index 3dfa91832aa8..ffc641d00aa4 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -16,6 +16,12 @@ skip_if_no_mem_event() {
 	return 2
 }
 
+# Skip on Arm N1 due to errata 1694299. Bias exists in SPE sampling
+# which can cause the load and store instructions to be skipped
+# entirely. This comes and goes randomly depending on the offset the
+# linker places the datasym loop at in the Perf binary.
+lscpu | grep -q "Neoverse-N1" && exit 2
+
 skip_if_no_mem_event || exit 2
 
 skip_test_missing_symbol buf1
-- 
2.34.1


