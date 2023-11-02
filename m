Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9927DF790
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347648AbjKBQWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbjKBQWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:22:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8484312E;
        Thu,  2 Nov 2023 09:22:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9205E2F4;
        Thu,  2 Nov 2023 09:23:30 -0700 (PDT)
Received: from dsg-hive-n1sdp-01.. (dsg-hive-n1sdp-01.cambridge.arm.com [10.2.2.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D379A3F738;
        Thu,  2 Nov 2023 09:22:46 -0700 (PDT)
From:   Nick Forrington <nick.forrington@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Nick Forrington <nick.forrington@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] perf test: Remove atomics from test_loop to avoid test failures
Date:   Thu,  2 Nov 2023 16:22:24 +0000
Message-ID: <20231102162225.50028-1-nick.forrington@arm.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current use of atomics can lead to test failures, as tests (such as
tests/shell/record.sh) search for samples with "test_loop" as the
top-most stack frame, but find frames related to the atomic operation
(e.g. __aarch64_ldadd4_relax).

This change simply removes the "count" variable, as it is not necessary.

Fixes: 1962ab6f6e0b ("perf test workload thloop: Make count increments atomic")
Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 tools/perf/tests/workloads/thloop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
index af05269c2eb8..457b29f91c3e 100644
--- a/tools/perf/tests/workloads/thloop.c
+++ b/tools/perf/tests/workloads/thloop.c
@@ -7,7 +7,6 @@
 #include "../tests.h"
 
 static volatile sig_atomic_t done;
-static volatile unsigned count;
 
 /* We want to check this symbol in perf report */
 noinline void test_loop(void);
@@ -19,8 +18,7 @@ static void sighandler(int sig __maybe_unused)
 
 noinline void test_loop(void)
 {
-	while (!done)
-		__atomic_fetch_add(&count, 1, __ATOMIC_RELAXED);
+	while (!done);
 }
 
 static void *thfunc(void *arg)
-- 
2.42.0

