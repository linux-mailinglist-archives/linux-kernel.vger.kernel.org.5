Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72CD7E095D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377817AbjKCTT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377743AbjKCTTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:19:20 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32B2D52;
        Fri,  3 Nov 2023 12:19:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso2112239b3a.1;
        Fri, 03 Nov 2023 12:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699039156; x=1699643956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AH4BcY7OvGureCnoDMX8kWZUMRQnOTP14Xx7SauGIbU=;
        b=azA0sIVneDywctYo2jY4jPEDJtUdR/5InVa3QcVMn2IcvR0AcbIiz+wpKVUH5yUlqe
         jDVTY/OIt3iiFudRFRf6TUQXpTNadnNLlijWfVvL6LxuDIrOa4tnGBCAesnsHpRYJ1+0
         NrGkAHyqzMluQfUikv6dsXpol/2wBnAZl/o8yfHcYcG29M4i32SnPmjlOxMTFuNRx+VS
         5wTnbjrWAxuT0Sa83x9YjNzH6ihQcmXi/EsuFZ9VeN9yycpPsuIVUwkcIcgxZvVYYez5
         8R8K1jLw2bYC1w5zRluaw8cxXewrm3GmagOzVM03DQbO3GZHuAB7ONJULruto41RaDDi
         blJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699039156; x=1699643956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AH4BcY7OvGureCnoDMX8kWZUMRQnOTP14Xx7SauGIbU=;
        b=ItGSrusWZMuKrZH2OIcMzRzaBfZmmuy8RGclR0RvxmRy1eJWqKYtjrwH8DSi0HBIbP
         OVwZboHSPRWMgjjoVY35NNjtwQEZb55NBHnkqHoBvBWMcW1TwtAJdgnlMduLFqEGlpwU
         hoqLNjK3fLonjDorwDRjTJomhtg8wpA5rN8OZiv/iQkUxOpDhRntaLA7wQHm7Bgg3ip1
         R1rqIUAd38RNqmX/NK51IFO/qoWUTTqyGhXbyvDKnV57PXQXZfNJn+cEl8qUTAnHkY7G
         EnPLS1CsAHThUyelyiO43XIm5NpjV2NtmNkc+2O/G4+JV/yMJ/iUHjRSvuzjFpFxJinQ
         zdaA==
X-Gm-Message-State: AOJu0YwsjGjBYGL5ZewTlcLze5K6/l3H4FJtVmi0rkIc1HuOz/RkKiZR
        /gMGKRfaKbwKEZSWqmOJULQ=
X-Google-Smtp-Source: AGHT+IHhmu+BSJ+beLNYHoa11WKmqC01tMVUpm8pBESM0YRlkuJxHaMyZ3JX5qJN0pgnpHDwF3DOyw==
X-Received: by 2002:a05:6a20:1456:b0:174:63a9:2aa with SMTP id a22-20020a056a20145600b0017463a902aamr23165230pzi.18.1699039156199;
        Fri, 03 Nov 2023 12:19:16 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:8234:4ed3:2635:c9d6])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090aca9100b0027cf4c554dasm1761349pjt.11.2023.11.03.12.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 12:19:15 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/5] perf annotate: Move max_coverage to annotated_branch
Date:   Fri,  3 Nov 2023 12:19:05 -0700
Message-ID: <20231103191907.54531-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231103191907.54531-1-namhyung@kernel.org>
References: <20231103191907.54531-1-namhyung@kernel.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
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

