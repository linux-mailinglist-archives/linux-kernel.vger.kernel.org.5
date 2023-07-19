Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAECE75A02A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGSUtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGSUti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:49:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348AA2110;
        Wed, 19 Jul 2023 13:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80C14617D6;
        Wed, 19 Jul 2023 20:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADD4C433C8;
        Wed, 19 Jul 2023 20:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689799774;
        bh=TSAUEsjKipWRQRCBkVitDwEGleao6uFXPDlBRtKZDMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpQv1z4IO7BiRIUvVWopfhw3MykuFZpy3RXqTvmrt7KISq9+8J4SU5/PmtjFvUJuS
         OtstdL3dcbNi4uW1/Ol+zhIJ4DAxjmPTRtHZNCqtlmi1PXEMxJv3cnRBrnXua5+DzX
         Xo19PPG66VTGCv3+V6tX9esKr2qEd0wG2Xy/216H7vXKOKRjBkJOIVeZom7T5cquPb
         1wH1awSkRnN2LDamE1Ma4+ZBNXcLBddmSQWF3w7Ut6vYHYb1cGHJZWUV3tYeIir7X6
         49ZemQSPku2IYoHz/RvGZhT0El8eFlUtPT1R2IG5f8hkdOSdU2OujZyh9qXyHFKc2L
         9f0TbJRReTKvQ==
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
        Andre Fredette <anfredet@redhat.com>,
        Dave Tucker <datucker@redhat.com>,
        Derek Barbosa <debarbos@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/5] perf bench uprobe: Show diff to previous
Date:   Wed, 19 Jul 2023 17:49:08 -0300
Message-ID: <20230719204910.539044-4-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719204910.539044-1-acme@kernel.org>
References: <20230719204910.539044-1-acme@kernel.org>
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

Will be useful to show the incremental overhead as we do more stuff in
the BPF program attached to the uprobes.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andre Fredette <anfredet@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Dave Tucker <datucker@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/uprobe.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index 60e7c43298d8cf56..a90e09f791c540a9 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -36,24 +36,35 @@ static const char * const bench_uprobe_usage[] = {
 
 static int bench_uprobe_format__default_fprintf(const char *name, const char *unit, u64 diff, FILE *fp)
 {
-	static u64 baseline;
-	s64 diff_to_baseline = diff - baseline;
+	static u64 baseline, previous;
+	s64 diff_to_baseline = diff - baseline,
+	    diff_to_previous = diff - previous;
 	int printed = fprintf(fp, "# Executed %'d %s calls\n", loops, name);
 
 	printed += fprintf(fp, " %14s: %'" PRIu64 " %ss", "Total time", diff, unit);
 
-	if (baseline)
+	if (baseline) {
 		printed += fprintf(fp, " %s%'" PRId64 " to baseline", diff_to_baseline > 0 ? "+" : "", diff_to_baseline);
 
+		if (previous != baseline)
+			fprintf(stdout, " %s%'" PRId64 " to previous", diff_to_previous > 0 ? "+" : "", diff_to_previous);
+	}
+
 	printed += fprintf(fp, "\n\n %'.3f %ss/op", (double)diff / (double)loops, unit);
 
-	if (baseline)
+	if (baseline) {
 		printed += fprintf(fp, " %'.3f %ss/op to baseline", (double)diff_to_baseline / (double)loops, unit);
-	else
+
+		if (previous != baseline)
+			printed += fprintf(fp, " %'.3f %ss/op to previous", (double)diff_to_previous / (double)loops, unit);
+	} else {
 		baseline = diff;
+	}
 
 	fputc('\n', fp);
 
+	previous = diff;
+
 	return printed + 1;
 }
 
-- 
2.41.0

