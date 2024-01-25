Return-Path: <linux-kernel+bounces-38306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56B783BDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB4B1F30520
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D641C2A3;
	Thu, 25 Jan 2024 09:42:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1FE1D52B;
	Thu, 25 Jan 2024 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175731; cv=none; b=eFvSZns85m+/2s0G6lm7RQ9iH6SubiTjacRmXo3Lw0QMDWrTlghbj4ROckCsakUnH9y5tOkZFQQ7Sb5RHkegmOuYCVtdl677Ez1V8Zg56wwZ3RfF7Q1i9lSfYIJAvwDRn73U9jfbxz1gifPZbW4/fFqTEtdHoIw8mXZTg/wanho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175731; c=relaxed/simple;
	bh=U6BxwWWsO2hrcxqX3UheDtH44VcZe/y/iBmW6rm7qVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A1bYZI10W8EEZFSvkSkYqSCBW1s3gZaNQt2tWyLZ+ZvieHDu/QpEyObcI6fzSqxAoCBouMCynLezePg2Cugkw6gUdt0Oi/DAZ45H1rggLO3UIygOAlfgcaJLBTfiBKOU8XREtekW0+TbyjgmuIMkdzfk2pvsBzRZ2DMsgplA5t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABF481516;
	Thu, 25 Jan 2024 01:42:53 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8FE993F73F;
	Thu, 25 Jan 2024 01:42:04 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Brown <broonie@kernel.org>,
	James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V16 6/8] perf: test: Speed up running brstack test on an Arm model
Date: Thu, 25 Jan 2024 15:11:17 +0530
Message-Id: <20240125094119.2542332-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125094119.2542332-1-anshuman.khandual@arm.com>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

The test runs quite slowly in the model, so replace "xargs -n1" with
"tr ' ' '\n'" which does the same thing but in single digit minutes
instead of double digit minutes.

Also reduce the number of loops in the test application. Unfortunately
this causes intermittent failures on x86, presumably because the
sampling interval is too big to pickup any loops, so keep it the same
there.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 tools/perf/tests/shell/test_brstack.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 5f14d0cb013f..5ea64d0c4a6f 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -18,7 +18,6 @@ fi
 skip_test_missing_symbol brstack_bench
 
 TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
-TESTPROG="perf test -w brstack"
 
 cleanup() {
 	rm -rf $TMPDIR
@@ -26,11 +25,21 @@ cleanup() {
 
 trap cleanup EXIT TERM INT
 
+is_arm64() {
+	uname -m | grep -q aarch64
+}
+
+if is_arm64; then
+	TESTPROG="perf test -w brstack 5000"
+else
+	TESTPROG="perf test -w brstack"
+fi
+
 test_user_branches() {
 	echo "Testing user branch stack sampling"
 
 	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- ${TESTPROG} > /dev/null 2>&1
-	perf script -i $TMPDIR/perf.data --fields brstacksym | xargs -n1 > $TMPDIR/perf.script
+	perf script -i $TMPDIR/perf.data --fields brstacksym | tr ' ' '\n' > $TMPDIR/perf.script
 
 	# example of branch entries:
 	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
@@ -59,7 +68,7 @@ test_filter() {
 	echo "Testing branch stack filtering permutation ($test_filter_filter,$test_filter_expect)"
 
 	perf record -o $TMPDIR/perf.data --branch-filter $test_filter_filter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
-	perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $TMPDIR/perf.script
+	perf script -i $TMPDIR/perf.data --fields brstack | tr ' ' '\n' > $TMPDIR/perf.script
 
 	# fail if we find any branch type that doesn't match any of the expected ones
 	# also consider UNKNOWN branch types (-)
-- 
2.25.1


