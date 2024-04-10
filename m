Return-Path: <linux-kernel+bounces-138338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA05689EFED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9971F2345A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A233E15ADB8;
	Wed, 10 Apr 2024 10:35:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D4A159579;
	Wed, 10 Apr 2024 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745343; cv=none; b=BD8SyZ1FAmfAr5MQ5Iysq+jNlvp/4PAx0szLEbstWqQQ9xWaWwRz8q+qYvqgnN3mshhlpCF3Ymsrrvudz5NFN4VYrHRiKVwOhdZfZQGoY1yguX3v6Bxc70RT4qj51gnYgauFTNxD5H6WWA+z2bPdjFYWtqSpMDOzY2o22HYn1Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745343; c=relaxed/simple;
	bh=9aILlYrIgOm+n9CT/ZjWYY7i2lGa7W4SA++r24ozcDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZVBcDfxCDjeYm9LElEnvocZUB025S49ClchMBMLIYu4JuJzT58HqQy3T1hf7fUZZn2lJorJXPffpf1+ZeXBoOeA7bVE0c3PVydLPNpduQWapNxYu/eXCAdMuJPJS4EQD7KjAong3n9+YHoTn63YHzx/gC7cmMJcArCeXN3wj/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8E0D1480;
	Wed, 10 Apr 2024 03:36:10 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C94E53F6C4;
	Wed, 10 Apr 2024 03:35:38 -0700 (PDT)
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
Subject: [PATCH v2 4/4] perf tests: Remove dependency on lscpu
Date: Wed, 10 Apr 2024 11:34:55 +0100
Message-Id: <20240410103458.813656-5-james.clark@arm.com>
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

This check can be done with uname which is more portable. At the same
time re-arrange it into a standard if statement so that it's more
readable.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/shell/test_arm_callgraph_fp.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
index 83b53591b1ea..61898e256616 100755
--- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
+++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
@@ -6,7 +6,9 @@ shelldir=$(dirname "$0")
 # shellcheck source=lib/perf_has_symbol.sh
 . "${shelldir}"/lib/perf_has_symbol.sh
 
-lscpu | grep -q "aarch64" || exit 2
+if [ "$(uname -m)" != "aarch64" ]; then
+	exit 2
+fi
 
 if perf version --build-options | grep HAVE_DWARF_UNWIND_SUPPORT | grep -q OFF
 then
-- 
2.34.1


