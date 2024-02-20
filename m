Return-Path: <linux-kernel+bounces-72318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DF885B1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3B81C21976
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F075466C;
	Tue, 20 Feb 2024 04:30:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BB7365;
	Tue, 20 Feb 2024 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708403423; cv=none; b=uWGMPW013sIx6OYatnvKD1mIpqZ3YLQTiGmp/r0EdUNLdAigVPQnag9Tf+mWUPTfIfhqaPVa+0+l5e+vYh3Y7FzZdsQn/SOBTQ2h3q5xSkf52uf6kX3nFriA/h2+l9huJNp3h4MPPEwqwUzbvil+fd7kQ446KrHlVaP2GE+uDW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708403423; c=relaxed/simple;
	bh=mq5mrVpVyAOV28vf8AdIRYf3Jzv4NPm8VDU3ouFB9LM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SRSAJ9t6FcLdDCAWchChXNWTn2YsF7ysHmtREdcfmglwfuy1ttvlUS71mQywDWQXKRoxUIw2gw1tGvldMkIORxZF8CdCDoTZgyefxFQjB7PTb3sJO872nshipIsWTBWC09xtg8pMEoiaD9L4fTqF0cM9daS5I6qPqHLuVCN6aaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BDA7FEC;
	Mon, 19 Feb 2024 20:30:59 -0800 (PST)
Received: from a079740.blr.arm.com (a079740.arm.com [10.162.43.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 617253F762;
	Mon, 19 Feb 2024 20:30:14 -0800 (PST)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf tools: Fix test "perf probe of function from different CU" 
Date: Tue, 20 Feb 2024 09:59:54 +0530
Message-Id: <20240220042957.2022391-1-ChaitanyaS.Prakash@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>

Defconfig doesn't provide all the necessary configs required for the
test "perf probe of function from different CU" to run successfully on
all platforms. Therefore the required configs have been added to
config fragments to resolve this issue. On further investigation it was
seen that the Perf treated all files beginning with "/tmp/perf-" as a
map file despite them always ending in ".map", this caused the test to
fail when Perf was built with NO_DWARF=1. As the file was parsed as a
map file, the probe...--funcs command output garbage values instead of
listing the functions in the binary. After fixing the issue an
additional check to test the output of the probe...--funcs command has
been added.

This patch series has been tested on 6.8-rc3 mainline kernerl, both on
arm64 and x86 platforms.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Georg Müller <georgmueller@gmx.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Chaitanya S Prakash (3):
  perf tools: Enable configs required for
    test_uprobe_from_different_cu.sh
  perf tools: Only treat files as map files when they have the extension
    .map
  perf test: Check output of the probe ... --funcs command

 tools/perf/builtin-script.c                    | 15 +--------------
 tools/perf/tests/config-fragments/config       |  3 +++
 .../shell/test_uprobe_from_different_cu.sh     |  2 +-
 tools/perf/util/string.c                       | 18 ++++++++++++++++++
 tools/perf/util/string2.h                      |  1 +
 tools/perf/util/symbol.c                       |  5 ++++-
 6 files changed, 28 insertions(+), 16 deletions(-)

-- 
2.34.1


