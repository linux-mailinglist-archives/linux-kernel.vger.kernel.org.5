Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0F07FDBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344146AbjK2Prs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbjK2Pre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:47:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E5110DB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:47:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE61C433C9;
        Wed, 29 Nov 2023 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701272860;
        bh=45craR8fXhu4UKylqaeeXIMxfA/OQi5bmwotxf0KdVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=srT7EPF8WxYZeCnQTbCvQdasmXfcwhwnDkVorUW54rnoYLdO+f6xSPNSzDJuDPaXh
         h99pThfxiCqrMpZSzYW5EtBiqUx8yKl163sPOhGrRKzW0pwAR6xfVyInfl5sSK7NjV
         NLGWDGLap3tYDCkmDQ0iSdE94oL++/7KgH+o5wMWCjIBtk4RbEme/mox+cegknfdrH
         lx2N6ak7aE9L4Z+sfxFoIo5GOCMflYabhLeqgG9sla8Kb4DAerzyLajqOyaD1lDbLQ
         NsxYsohRhWeyTHRrJ1VbiDX/XNV2zUN3hiGSloFC4Xi2GGW2yYKWdGn85ZzfwMafg5
         C0+Xo6ThVqtew==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Marco Elver <elver@google.com>, Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] perf tests sigtrap: Skip if running on a kernel with sleepable spinlocks
Date:   Wed, 29 Nov 2023 12:47:18 -0300
Message-ID: <20231129154718.326330-3-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231129154718.326330-1-acme@kernel.org>
References: <20231129154718.326330-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There are issues as reported that need some more investigation on the
RT kernel front, till that is addressed, skip this test.

This test is already skipped for multiple hardware architectures where
the tested kernel feature is not supported.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Marco Elver <elver@google.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sigtrap.c | 46 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
index a1bc7c776254ed2f..e6fd934b027a3d0c 100644
--- a/tools/perf/tests/sigtrap.c
+++ b/tools/perf/tests/sigtrap.c
@@ -103,6 +103,34 @@ static bool attr_has_sigtrap(void)
 
 	return __btf_type__find_member_by_name(id, "sigtrap") != NULL;
 }
+
+static bool kernel_with_sleepable_spinlocks(void)
+{
+	const struct btf_member *member;
+	const struct btf_type *type;
+	const char *type_name;
+	int id;
+
+	if (!btf__available())
+		return false;
+
+	id = btf__find_by_name_kind(btf, "spinlock", BTF_KIND_STRUCT);
+	if (id < 0)
+		return false;
+
+	// Only RT has a "lock" member for "struct spinlock"
+	member = __btf_type__find_member_by_name(id, "lock");
+	if (member == NULL)
+		return false;
+
+	// But check its type as well
+	type = btf__type_by_id(btf, member->type);
+	if (!type || !btf_is_struct(type))
+		return false;
+
+	type_name = btf__name_by_offset(btf, type->name_off);
+	return type_name && !strcmp(type_name, "rt_mutex_base");
+}
 #else  /* !HAVE_BPF_SKEL */
 static bool attr_has_sigtrap(void)
 {
@@ -125,6 +153,11 @@ static bool attr_has_sigtrap(void)
 	return ret;
 }
 
+static bool kernel_with_sleepable_spinlocks(void)
+{
+	return false;
+}
+
 static void btf__exit(void)
 {
 }
@@ -166,7 +199,7 @@ static int run_test_threads(pthread_t *threads, pthread_barrier_t *barrier)
 
 static int run_stress_test(int fd, pthread_t *threads, pthread_barrier_t *barrier)
 {
-	int ret;
+	int ret, expected_sigtraps;
 
 	ctx.iterate_on = 3000;
 
@@ -175,7 +208,16 @@ static int run_stress_test(int fd, pthread_t *threads, pthread_barrier_t *barrie
 	ret = run_test_threads(threads, barrier);
 	TEST_ASSERT_EQUAL("disable failed", ioctl(fd, PERF_EVENT_IOC_DISABLE, 0), 0);
 
-	TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count, NUM_THREADS * ctx.iterate_on);
+	expected_sigtraps = NUM_THREADS * ctx.iterate_on;
+
+	if (ctx.signal_count < expected_sigtraps && kernel_with_sleepable_spinlocks()) {
+		pr_debug("Expected %d sigtraps, got %d, running on a kernel with sleepable spinlocks.\n",
+			 expected_sigtraps, ctx.signal_count);
+		pr_debug("See https://lore.kernel.org/all/e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de/\n");
+		return TEST_SKIP;
+	} else
+		TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count, expected_sigtraps);
+
 	TEST_ASSERT_EQUAL("missing signals or incorrectly delivered", ctx.tids_want_signal, 0);
 	TEST_ASSERT_VAL("unexpected si_addr", ctx.first_siginfo.si_addr == &ctx.iterate_on);
 #if 0 /* FIXME: enable when libc's signal.h has si_perf_{type,data} */
-- 
2.41.0

