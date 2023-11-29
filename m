Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E3C7FDBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbjK2Prj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbjK2Pr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:47:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E78D48
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:47:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C68C433CC;
        Wed, 29 Nov 2023 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701272854;
        bh=FaUbZPDs3dt6xgm6CO9qGb61yKAwRh5X/pwZrBp62xQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VA1aly/Fp3gSP7LuZ7/s+dY+PMxJDAQaobgrt25L9Z2lj9nKsxjpPMhA4rxS9xxaA
         RwW+biJB+8E0Q2gMYVyOM0fc7v3XJTbW+MGqzxQzcxInr0Uh5lAzNU2upoQSScrtn4
         /4Yy64W9X7bjutY3VQjCvJ/QWQKBqFohG/zGEZgheOe252paZPs/5L/cu13aVU01mh
         YGXSal/qgNGpGrxJFYSTNYDzt7khvS3NW6QwwgAs8HL2DVz9sWbcEwvRoqnBCRs9aA
         CHEP/29AHa7JECcA/V5lpHveTi/s9KDmsVqCQYJBm7hSXlbxquaA1Zr/p/z8EHUNlW
         6CNgEh42SOmnA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/2] perf test sigtrap: Generalize the BTF routine to reuse it in this test
Date:   Wed, 29 Nov 2023 12:47:17 -0300
Message-ID: <20231129154718.326330-2-acme@kernel.org>
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

Move the part that loads the BTF info to a "btf__available()" that will
lazy load the BTF info so that if we need it for some other test, which
we will in the following cset, we can reuse it.

At some point this will move from this specific 'perf test' entry to be
used in other parts of perf, do it when needed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sigtrap.c | 60 +++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
index 1de7478ec1894d77..a1bc7c776254ed2f 100644
--- a/tools/perf/tests/sigtrap.c
+++ b/tools/perf/tests/sigtrap.c
@@ -57,36 +57,51 @@ static struct perf_event_attr make_event_attr(void)
 #ifdef HAVE_BPF_SKEL
 #include <bpf/btf.h>
 
-static bool attr_has_sigtrap(void)
+static struct btf *btf;
+
+static bool btf__available(void)
 {
-	bool ret = false;
-	struct btf *btf;
-	const struct btf_type *t;
+	if (btf == NULL)
+		btf = btf__load_vmlinux_btf();
+
+	return btf != NULL;
+}
+
+static void btf__exit(void)
+{
+	btf__free(btf);
+	btf = NULL;
+}
+
+static const struct btf_member *__btf_type__find_member_by_name(int type_id, const char *member_name)
+{
+	const struct btf_type *t = btf__type_by_id(btf, type_id);
 	const struct btf_member *m;
-	const char *name;
-	int i, id;
+	int i;
+
+	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
+		const char *current_member_name = btf__name_by_offset(btf, m->name_off);
+		if (!strcmp(current_member_name, member_name))
+			return m;
+	}
+
+	return NULL;
+}
+
+static bool attr_has_sigtrap(void)
+{
+	int id;
 
-	btf = btf__load_vmlinux_btf();
-	if (btf == NULL) {
+	if (!btf__available()) {
 		/* should be an old kernel */
 		return false;
 	}
 
 	id = btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_STRUCT);
 	if (id < 0)
-		goto out;
+		return false;
 
-	t = btf__type_by_id(btf, id);
-	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
-		name = btf__name_by_offset(btf, m->name_off);
-		if (!strcmp(name, "sigtrap")) {
-			ret = true;
-			break;
-		}
-	}
-out:
-	btf__free(btf);
-	return ret;
+	return __btf_type__find_member_by_name(id, "sigtrap") != NULL;
 }
 #else  /* !HAVE_BPF_SKEL */
 static bool attr_has_sigtrap(void)
@@ -109,6 +124,10 @@ static bool attr_has_sigtrap(void)
 
 	return ret;
 }
+
+static void btf__exit(void)
+{
+}
 #endif  /* HAVE_BPF_SKEL */
 
 static void
@@ -221,6 +240,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
 	sigaction(SIGTRAP, &oldact, NULL);
 out:
 	pthread_barrier_destroy(&barrier);
+	btf__exit();
 	return ret;
 }
 
-- 
2.41.0

