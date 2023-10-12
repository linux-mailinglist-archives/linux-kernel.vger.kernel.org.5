Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3497C637E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376867AbjJLDyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377376AbjJLDww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:52 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB018D50;
        Wed, 11 Oct 2023 20:51:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c5c91bec75so4321435ad.3;
        Wed, 11 Oct 2023 20:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082705; x=1697687505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dcl2dOAm+mbEonLbxuJ2mMnOeoBphEb+PfyBv0Awdhw=;
        b=WDlwVejZanP1p7v/Je9eoFuQjGwBEbAIGM6e5Zxkmgs2w6FxXmCKNIsOnL8g2E4zB4
         CICLzgdC8ZITPF0qgs1ZuNePCSRui7VmI4+4A1QMp3GPsn0m/LemY1qoXXWvdj2PvpaY
         /BTsiyuz784+Ggy8E1b12n/zXxydfSl2u9YKZP4F02cPbZuBKEpPpMlcreiwERXmsX1c
         Q14OY6AOT8cvi22eJ6DW6gmJ0c+4SIoirbm5kQtTcUZyv+/K1wNcQjdJNLj+x4iR3Doo
         gqDSoyazgjLJgwF3K8pSiA0dL7hP29GkEtCLKxrkf8vzcO5EdKmoRVVyQdjxddUJNMJa
         5ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082705; x=1697687505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dcl2dOAm+mbEonLbxuJ2mMnOeoBphEb+PfyBv0Awdhw=;
        b=qroVUgXp5r3yL5UegoUnJkDXqjqVWd5fbo44OiJIwLoFt8tc0ZSbsYJGqrSRkDTM+n
         HE+0ZeVA8rx+lCta5AHiF4kCUAB3e+9xbZmK5+gvOvGE5Z5HerT3E1x9oI3gVgrlSLv5
         q9IPNTage73+Ax7jQzTcWHLFPDkoW2oLmNxFAwsCg5qiAGSc/w9asP87Ny+iT53dO8ke
         7V9l9iQT/CJmzmgv37L/SDlyoA0h3KB6z36xJ7IdcROpFc0vln9MzOQoZfntb4EMgXe9
         Pa8f1tcv2a6XycuQUOqvsIXhkKOp63buCFscM5/5TfoQ6el7V+5R9uhgwIJJQ2274dCF
         UZYg==
X-Gm-Message-State: AOJu0Yyncpoz4Mn6cLO1dJRXqRkxLtl6PNeqblaY+CSrPKxCG5CJJECw
        m/MTp8+s5Ky8sjUOHkLg1X4=
X-Google-Smtp-Source: AGHT+IGKxSbTaAe5dt8L//qarq34W5C8IjlG6rfr+SNYhEb5O98F/3GnjaSxQQVv5b7iM/nejaRXbA==
X-Received: by 2002:a17:902:6941:b0:1bb:b855:db3c with SMTP id k1-20020a170902694100b001bbb855db3cmr15510847plt.41.1697082704944;
        Wed, 11 Oct 2023 20:51:44 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:44 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 23/48] perf annotate: Add --insn-stat option for debugging
Date:   Wed, 11 Oct 2023 20:50:46 -0700
Message-ID: <20231012035111.676789-24-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is for a debugging purpose.  It'd be useful to see per-instrucion
level success/failure stats.

  $ perf annotate --data-type --insn-stat
  Annotate Instruction stats
  total 264, ok 143 (54.2%), bad 121 (45.8%)

    Name      :  Good   Bad
  -----------------------------------------------------------
    movq      :    45    31
    movl      :    22    11
    popq      :     0    19
    cmpl      :    16     3
    addq      :     8     7
    cmpq      :    11     3
    cmpxchgl  :     3     7
    cmpxchgq  :     8     0
    incl      :     3     3
    movzbl    :     4     2
    incq      :     4     2
    decl      :     6     0
    ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c | 41 +++++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.c    | 39 +++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h    |  8 +++++++
 3 files changed, 88 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 645acaba63f1..a01d5e162466 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -59,6 +59,7 @@ struct perf_annotate {
 	bool	   group_set;
 	bool	   data_type;
 	bool	   type_stat;
+	bool	   insn_stat;
 	float	   min_percent;
 	const char *sym_hist_filter;
 	const char *cpu_list;
@@ -390,6 +391,42 @@ static void print_annotate_data_stat(struct annotated_data_stat *s)
 #undef PRINT_STAT
 }
 
+static void print_annotate_item_stat(struct list_head *head, const char *title)
+{
+	struct annotated_item_stat *istat, *pos, *iter;
+	int total_good, total_bad, total;
+	int sum1, sum2;
+	LIST_HEAD(tmp);
+
+	/* sort the list by count */
+	list_splice_init(head, &tmp);
+	total_good = total_bad = 0;
+
+	list_for_each_entry_safe(istat, pos, &tmp, list) {
+		total_good += istat->good;
+		total_bad += istat->bad;
+		sum1 = istat->good + istat->bad;
+
+		list_for_each_entry(iter, head, list) {
+			sum2 = iter->good + iter->bad;
+			if (sum1 > sum2)
+				break;
+		}
+		list_move_tail(&istat->list, &iter->list);
+	}
+	total = total_good + total_bad;
+
+	printf("Annotate %s stats\n", title);
+	printf("total %d, ok %d (%.1f%%), bad %d (%.1f%%)\n\n", total,
+	       total_good, 100.0 * total_good / (total ?: 1),
+	       total_bad, 100.0 * total_bad / (total ?: 1));
+	printf("  %-10s: %5s %5s\n", "Name", "Good", "Bad");
+	printf("-----------------------------------------------------------\n");
+	list_for_each_entry(istat, head, list)
+		printf("  %-10s: %5d %5d\n", istat->name, istat->good, istat->bad);
+	printf("\n");
+}
+
 static void hists__find_annotations(struct hists *hists,
 				    struct evsel *evsel,
 				    struct perf_annotate *ann)
@@ -399,6 +436,8 @@ static void hists__find_annotations(struct hists *hists,
 
 	if (ann->type_stat)
 		print_annotate_data_stat(&ann_data_stat);
+	if (ann->insn_stat)
+		print_annotate_item_stat(&ann_insn_stat, "Instruction");
 
 	while (nd) {
 		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
@@ -700,6 +739,8 @@ int cmd_annotate(int argc, const char **argv)
 		    "Show data type annotate for the memory accesses"),
 	OPT_BOOLEAN(0, "type-stat", &annotate.type_stat,
 		    "Show stats for the data type annotation"),
+	OPT_BOOLEAN(0, "insn-stat", &annotate.insn_stat,
+		    "Show instruction stats for the data type annotation"),
 	OPT_END()
 	};
 	int ret;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 72b867001e22..3f3cc7ae751f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -100,6 +100,8 @@ static struct ins_ops nop_ops;
 static struct ins_ops lock_ops;
 static struct ins_ops ret_ops;
 
+LIST_HEAD(ann_insn_stat);
+
 static int arch__grow_instructions(struct arch *arch)
 {
 	struct ins *new_instructions;
@@ -3628,6 +3630,30 @@ static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip)
 	return NULL;
 }
 
+static struct annotated_item_stat *annotate_data_stat(struct list_head *head,
+						      const char *name)
+{
+	struct annotated_item_stat *istat;
+
+	list_for_each_entry(istat, head, list) {
+		if (!strcmp(istat->name, name))
+			return istat;
+	}
+
+	istat = zalloc(sizeof(*istat));
+	if (istat == NULL)
+		return NULL;
+
+	istat->name = strdup(name);
+	if (istat->name == NULL) {
+		free(istat);
+		return NULL;
+	}
+
+	list_add_tail(&istat->list, head);
+	return istat;
+}
+
 /**
  * hist_entry__get_data_type - find data type for given hist entry
  * @he: hist entry
@@ -3646,6 +3672,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	struct annotated_insn_loc loc;
 	struct annotated_op_loc *op_loc;
 	struct annotated_data_type *mem_type;
+	struct annotated_item_stat *istat;
 	u64 ip = he->ip;
 	int i;
 
@@ -3674,8 +3701,15 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		return NULL;
 	}
 
+	istat = annotate_data_stat(&ann_insn_stat, dl->ins.name);
+	if (istat == NULL) {
+		ann_data_stat.no_insn++;
+		return NULL;
+	}
+
 	if (annotate_get_insn_location(arch, dl, &loc) < 0) {
 		ann_data_stat.no_insn_ops++;
+		istat->bad++;
 		return NULL;
 	}
 
@@ -3684,6 +3718,10 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 			continue;
 
 		mem_type = find_data_type(ms, ip, op_loc->reg, op_loc->offset);
+		if (mem_type)
+			istat->good++;
+		else
+			istat->bad++;
 
 		if (symbol_conf.annotate_data_sample) {
 			annotated_data_type__update_samples(mem_type, evsel,
@@ -3696,5 +3734,6 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	}
 
 	ann_data_stat.no_mem_ops++;
+	istat->bad++;
 	return NULL;
 }
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 299b4a18e804..5bb831445cbe 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -477,4 +477,12 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 /* Returns a data type from the sample instruction (if any) */
 struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he);
 
+struct annotated_item_stat {
+	struct list_head list;
+	char *name;
+	int good;
+	int bad;
+};
+extern struct list_head ann_insn_stat;
+
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.42.0.655.g421f12c284-goog

