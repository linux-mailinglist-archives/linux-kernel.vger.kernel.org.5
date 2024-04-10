Return-Path: <linux-kernel+bounces-138333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FC289EFE7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7807B1C2194B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066E15921D;
	Wed, 10 Apr 2024 10:35:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FC9158D90;
	Wed, 10 Apr 2024 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745320; cv=none; b=kHw/zJ+iKicS8koXyxokZov4++CfB0f8oIknoCu33+jUfuRGkCz/zy5bCTGz6fqit+Mf2UZp1Kp/GztB1KHIm1Sp3DdJp0FDWnxJ/8ZfvlOnPUz5BQK/VCCguH0c1Gltcc0uJnIBhFzNoaT2FXbL1vN3uR4U1yF3ZkA4R+qHLXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745320; c=relaxed/simple;
	bh=8bkaWMTv1hj0uymsN4BUTip+hQwDJQf07JlqWmIcooo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q7zFpgbkeJ/zZuCgERuF+ZkakUBFJTHaKcG1YpxFk3iHwSErKPjtva1aHq4ZmTZxc6jhfJWH3DcCJi8iDvftG6I0bRxtG4UFK/qXVafOq3/Gla8KnSkMv8KgNy4P3nR22cBSDPDsRqVr36ZKgAjtClU1IM2e5nsdZz81dSCy69w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45629139F;
	Wed, 10 Apr 2024 03:35:48 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 69FF53F6C4;
	Wed, 10 Apr 2024 03:35:15 -0700 (PDT)
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
Subject: [PATCH v2 0/4] perf test: "object code reading" test fixes
Date: Wed, 10 Apr 2024 11:34:51 +0100
Message-Id: <20240410103458.813656-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few fixes around the object code reading test. The first patch
appears to be unrelated, but in this case the data symbol test is
broken on Arm N1 by the second commit.

Changes since V1:
  * Put data symbol test fix first so that bisecting still works on N1
  * Instead of skipping "test data symbol" on N1, add some noise into
    the loop.
  * Add a commit to replace the only usage of lscpu in the tests with
    uname

James Clark (4):
  perf tests: Make "test data symbol" more robust on Neoverse N1
  perf tests: Apply attributes to all events in object code reading test
  perf map: Remove kernel map before updating start and end addresses
  perf tests: Remove dependency on lscpu

 tools/perf/tests/code-reading.c                 | 10 +++++-----
 tools/perf/tests/shell/test_arm_callgraph_fp.sh |  4 +++-
 tools/perf/tests/workloads/datasym.c            | 16 ++++++++++++++++
 tools/perf/util/machine.c                       |  2 +-
 4 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.34.1


