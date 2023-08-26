Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52233789941
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 23:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjHZVdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 17:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjHZVc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 17:32:57 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB8D198
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:32:54 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id a0tiqMyNVntrua0tiqFk2g; Sat, 26 Aug 2023 23:32:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693085573;
        bh=4MX0lTEIfMwloRuVnSSaTXgUJ5kaTWKMUvM8PI8P8MU=;
        h=From:To:Cc:Subject:Date;
        b=q+OVRHG/fVWMNSoIxH972kG2FoUfEJaBwS0VnqcCkbnHkWK6LJsCWvrP2GeHK3PSP
         Blry+75Lk4VRMNTFQCbMNn0jGq3OX3V+6nt0+GfcX9yymtDmUPQY3SpLr9f2dr8Oq4
         aQ0oLs1eXD1V7gs3vDRe5FyLxJ9Nut13C0MkOzKHScGvjhH03UIwnziZ1RsSRqLwRE
         8cLSAi75kN8xMmYZVzjG5eWuwlX0pd/n0/4nQi6NoQ3X93lfexKAJtKUBk1aCKw3mH
         4Z+XE6lvXBaBJO5arKqNjpS44uWnxpDasnbfX8OqbLNnCXb6u7V6UZm2BYPUp9hFjt
         Q6DUtXvWVnXdw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Aug 2023 23:32:53 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf pmu: Fix a potential memory leak in perf_pmu__lookup()
Date:   Sat, 26 Aug 2023 23:32:45 +0200
Message-Id: <9538b2b634894c33168dfe9d848d4df31fd4d801.1693085544.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit in Fixes has reordered some code, but missed an error handling
path.

'goto err' now, in order to avoid a memory leak in case of error.

Fixes: f63a536f03a2 ("perf pmu: Merge JSON events with sysfs at load time")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 tools/perf/util/pmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index bb2ca29cd7bd..8dfce84ad9fe 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1018,10 +1018,9 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	 * type value and format definitions. Load both right
 	 * now.
 	 */
-	if (pmu_format(pmu, dirfd, name)) {
-		free(pmu);
-		return NULL;
-	}
+	if (pmu_format(pmu, dirfd, name))
+		goto err;
+
 	pmu->is_core = is_pmu_core(name);
 	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
 
-- 
2.34.1

