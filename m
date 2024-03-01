Return-Path: <linux-kernel+bounces-88493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C039086E25C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CECCCB23F2A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8BA6D1D7;
	Fri,  1 Mar 2024 13:39:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5367040BE2;
	Fri,  1 Mar 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300362; cv=none; b=RUzpgFSb7neqzuuub/bPapGEhBm5t3xjlrxeEQm4QYaHiqTA44CPXPBFu/EITylP++iX02hQ5j1bTVh7uM156ND60ORhPDiNhIJQdN8ygGUzjC25a5whO5vlBvTlGszBZ53uOjo/mFpchRjw5liQta4lBiVO4N/TEUlrNGUTfis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300362; c=relaxed/simple;
	bh=3Zqv/QP+qVPDOSk8rV9eN9SJEoX5Dn3fLrlvb7D3tpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fnMRte5DwqRbjp1cADlf2SG1l0rZ10WS5gBjiCS8ao/jI7Bev6zbWr/CldoPI7jXmUADSOg8ZcwR8WDNZHtqUgaWqSTDYdyJO31PJnA6WjSpzIdFUu34t8rstBTPBMfvUTlFnJ/nMa0NXohb+hu/+csH7Cjkn1xTyHG1czuaMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA47B1FB;
	Fri,  1 Mar 2024 05:39:57 -0800 (PST)
Received: from e127643.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90F403F6C4;
	Fri,  1 Mar 2024 05:39:16 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: al.grant@arm.com,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf version: Display availability of OpenCSD support
Date: Fri,  1 Mar 2024 13:38:29 +0000
Message-Id: <20240301133829.346286-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is useful for scripts that work with Perf and ETM trace. Rather
than them trying to parse Perf's error output at runtime to see if it
was linked or not.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-version.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 1bafe5855ae7..398aa53e9e2e 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -84,6 +84,7 @@ static void library_status(void)
 	STATUS(HAVE_LIBTRACEEVENT, libtraceevent);
 	STATUS(HAVE_BPF_SKEL, bpf_skeletons);
 	STATUS(HAVE_DWARF_UNWIND_SUPPORT, dwarf-unwind-support);
+	STATUS(HAVE_CSTRACE_SUPPORT, libopencsd);
 }
 
 int cmd_version(int argc, const char **argv)
-- 
2.34.1


