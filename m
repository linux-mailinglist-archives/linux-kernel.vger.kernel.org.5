Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD507DFC62
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377519AbjKBW1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377489AbjKBW1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:27:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E9BB7;
        Thu,  2 Nov 2023 15:26:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so1431022a91.3;
        Thu, 02 Nov 2023 15:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698964019; x=1699568819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8tqb2qz0r5dpxN3b4ngTYkFDyTuwNwqrYBhWYtfaoc=;
        b=BwQ3bVxoVagv+itzBp79J2JBIuGlW/q6dPVEp19oqr/HgZL70hXI+zDWdrIH3PgQGv
         otzOXCfesJc4S99G1cpWyEhrvXqVXtFMi+f/cfLD9leG/tFYA8njhBObvy3krBck/LpM
         wH+tAIWGdpJb6ANdBDI/mjPkuHZq4lJ/zRaL9mKtS8EfDX1opX2XC6WjOQfGL8cG3VDS
         dkgAd+wU2+KWJrThfxsakrFE7Xuj6fNmD6MmkXg4gnalOusYYcMOBALFb8S2axP91D5G
         ui3vQZeAHZk7yae9wQdh4rCAa5imNdzfYtCaVOpqSiz0LSB/rTd7U7vbPSSj+K2/yi1y
         a1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698964019; x=1699568819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L8tqb2qz0r5dpxN3b4ngTYkFDyTuwNwqrYBhWYtfaoc=;
        b=CtwjEqy/bslV7+kDwqrYCJlLQ1ZoxTchOBgDk5dw1kBWxZ2Bv+pZiBRZ7b/fTBTNZh
         vZxSt1R948slOaqy7hpOlv+raB/3exlyaG3O2vLa2RjY/SjtJ8Dt9C/TzPZlQdWgMt1K
         Io0LQW1iwuyEhsRK/dqnQLZffr2F6W39el/FVmwE7vDs7C8ubXPrxB4BPd/K8T5EAnl1
         tj5EVPZaV4+tuXU218XSJodNh1t0HjFu1QsrvtnZ4iGUrzSifc7RqXFi0UnQkV36lqrj
         EUe8CLVCGcUP74pY+uromhZt/iFadSK3Q4QGsmoR3Qt7rK+RFo3Rn5IDFMMz5ybGbVB2
         adHA==
X-Gm-Message-State: AOJu0YzvLhE9srO+/gncTQGKX+n7IyLjqDtIlnXgKdvYik87Yxg8N+4o
        lzDsOZAusUYBFUDZ+rdwevw=
X-Google-Smtp-Source: AGHT+IGTUdhSr/I7+UGdEWuXnmeHmoUevjezdr9aSaz4FaC44SGZQFyn/yTLKoJfDE1/0jQ4SJH5Ww==
X-Received: by 2002:a17:90a:c698:b0:280:3772:5c2e with SMTP id n24-20020a17090ac69800b0028037725c2emr14529374pjt.25.1698964018759;
        Thu, 02 Nov 2023 15:26:58 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:ea22:bed1:d67b:af04])
        by smtp.gmail.com with ESMTPSA id cn18-20020a17090af09200b0027d015c365csm309894pjb.31.2023.11.02.15.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 15:26:58 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/5] perf annotate: Move max_coverage to annotated_branch
Date:   Thu,  2 Nov 2023 15:26:51 -0700
Message-ID: <20231102222653.4165959-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231102222653.4165959-1-namhyung@kernel.org>
References: <20231102222653.4165959-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max_coverage is only used when branch stack info is available so
it'd be natural to move to the annotated_branch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c | 7 +++++--
 tools/perf/util/annotate.c    | 2 +-
 tools/perf/util/annotate.h    | 4 +++-
 tools/perf/util/block-range.c | 7 ++++++-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index aeeb801f1ed7..a9129b51d511 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -94,6 +94,7 @@ static void process_basic_block(struct addr_map_symbol *start,
 	struct annotation *notes = sym ? symbol__annotation(sym) : NULL;
 	struct block_range_iter iter;
 	struct block_range *entry;
+	struct annotated_branch *branch;
 
 	/*
 	 * Sanity; NULL isn't executable and the CPU cannot execute backwards
@@ -105,6 +106,8 @@ static void process_basic_block(struct addr_map_symbol *start,
 	if (!block_range_iter__valid(&iter))
 		return;
 
+	branch = annotation__get_branch(notes);
+
 	/*
 	 * First block in range is a branch target.
 	 */
@@ -118,8 +121,8 @@ static void process_basic_block(struct addr_map_symbol *start,
 		entry->coverage++;
 		entry->sym = sym;
 
-		if (notes)
-			notes->max_coverage = max(notes->max_coverage, entry->coverage);
+		if (branch)
+			branch->max_coverage = max(branch->max_coverage, entry->coverage);
 
 	} while (block_range_iter__next(&iter));
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2fa1ce3a0858..92a9adf9d5eb 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -946,7 +946,7 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 	return 0;
 }
 
-static struct annotated_branch *annotation__get_branch(struct annotation *notes)
+struct annotated_branch *annotation__get_branch(struct annotation *notes)
 {
 	if (notes == NULL)
 		return NULL;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 9c199629305d..d8a221591926 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -280,10 +280,10 @@ struct annotated_branch {
 	unsigned int		total_insn;
 	unsigned int		cover_insn;
 	struct cyc_hist		*cycles_hist;
+	u64			max_coverage;
 };
 
 struct LOCKABLE annotation {
-	u64			max_coverage;
 	u64			start;
 	struct annotation_options *options;
 	struct annotation_line	**offsets;
@@ -356,6 +356,8 @@ static inline struct annotation *symbol__annotation(struct symbol *sym)
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
 				 struct evsel *evsel);
 
+struct annotated_branch *annotation__get_branch(struct annotation *notes);
+
 int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 				    struct addr_map_symbol *start,
 				    unsigned cycles);
diff --git a/tools/perf/util/block-range.c b/tools/perf/util/block-range.c
index 680e92774d0c..15c42196c24c 100644
--- a/tools/perf/util/block-range.c
+++ b/tools/perf/util/block-range.c
@@ -311,6 +311,7 @@ struct block_range_iter block_range__create(u64 start, u64 end)
 double block_range__coverage(struct block_range *br)
 {
 	struct symbol *sym;
+	struct annotated_branch *branch;
 
 	if (!br) {
 		if (block_ranges.blocks)
@@ -323,5 +324,9 @@ double block_range__coverage(struct block_range *br)
 	if (!sym)
 		return -1;
 
-	return (double)br->coverage / symbol__annotation(sym)->max_coverage;
+	branch = symbol__annotation(sym)->branch;
+	if (!branch)
+		return -1;
+
+	return (double)br->coverage / branch->max_coverage;
 }
-- 
2.42.0.869.gea05f2083d-goog

