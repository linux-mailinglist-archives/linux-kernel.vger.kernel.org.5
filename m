Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CBE7E7583
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345681AbjKJACj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345550AbjKJABp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:01:45 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CB8479C;
        Thu,  9 Nov 2023 16:00:57 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-280260db156so1276059a91.2;
        Thu, 09 Nov 2023 16:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574456; x=1700179256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IiGmHiFZ7D8eBmQHmks1FISgbWWSEVYxrId79vUA9A=;
        b=Eq0rnRphh4YG20cPFNmkcSzETaKJt8nd1qDchWfJkuOKY1lxl7LPLrdDPykuWpVVp2
         /IFc4KxpsdYlMok88fTnJL4Kr0Abtvr6AyKpdPHnTXTG+KDgg6B1O0J8AdwhaR1uiicE
         2X0WdbZTMjRCZLtbX0t5VU6NpoECsLZaEec9zVmDeg+Z9ineF/r6g88Z5iVhefitxWvP
         phUj0/mH1SUlNVFM0zxTsXB5qEnXnVHKsbRt62332NuvVMG/GTYinEC2qRugk/ayCOVI
         6FtE0JKbzBjKl32y52UF2nWeJxqUOw219jINWiV1S9dJ4I9qlbCuU20XpCdIbab4GAsD
         mpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574456; x=1700179256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0IiGmHiFZ7D8eBmQHmks1FISgbWWSEVYxrId79vUA9A=;
        b=cmM9sqsRONLFZEhj2n745mYwc5HUltQiM4jCDK2AudVBas8vQb9Hv6hCGq2Pq6i+EA
         hrj33m8+XeUbmfsVNrFkUGoAZfjX0YLVKoWnF5ulOzvWjeBo8lfnc0C8kbzRm7ozJ6Od
         92Ozuyyq9z9uf9tUFcEoE5F3FjBnHKEH5fDa8DzvdlNbA9KleHU8p4nOmQjJ0YQ8Hjzi
         Cg/IDQGSmxEa/snwZe1ZUGRdA/AmtI63gDL5hSvNG9OS+OXfH+/fAz/ws0F4ME1NlHFk
         LCJgvZE7ZKo1ajEd7IaF2mcp2soyB7csI3PaCSPKzgBh9AONCCdsCBUjo3u5HwSI0yzU
         4bbA==
X-Gm-Message-State: AOJu0YyUzgNNZZgW+jXavps+P8Ewt+UYNEtTSISKjfFqkSOtWUvOSBVC
        t3HGGvUXlwOqRtvzh56uafs=
X-Google-Smtp-Source: AGHT+IGCWjduWpdUVjZXB56YDufm3cDQsD1BO7u6omVdHPoZzDMh6CJF+QlEpOMhRhOf5B+X6hWE3g==
X-Received: by 2002:a17:90b:4d0f:b0:281:a69:4430 with SMTP id mw15-20020a17090b4d0f00b002810a694430mr3219663pjb.42.1699574456512;
        Thu, 09 Nov 2023 16:00:56 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:56 -0800 (PST)
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 27/52] perf annotate: Add --insn-stat option for debugging
Date:   Thu,  9 Nov 2023 15:59:46 -0800
Message-ID: <20231110000012.3538610-28-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 tools/perf/util/annotate.c    | 38 ++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h    |  8 +++++++
 3 files changed, 87 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index e4fc00bc8fdf..9516d2dbc488 100644
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
@@ -439,6 +440,42 @@ static void print_annotate_data_stat(struct annotated_data_stat *s)
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
@@ -448,6 +485,8 @@ static void hists__find_annotations(struct hists *hists,
 
 	if (ann->type_stat)
 		print_annotate_data_stat(&ann_data_stat);
+	if (ann->insn_stat)
+		print_annotate_item_stat(&ann_insn_stat, "Instruction");
 
 	while (nd) {
 		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
@@ -798,6 +837,8 @@ int cmd_annotate(int argc, const char **argv)
 			    parse_data_type),
 	OPT_BOOLEAN(0, "type-stat", &annotate.type_stat,
 		    "Show stats for the data type annotation"),
+	OPT_BOOLEAN(0, "insn-stat", &annotate.insn_stat,
+		    "Show instruction stats for the data type annotation"),
 	OPT_END()
 	};
 	int ret;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c284a29979d6..3ac601d70f61 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -102,6 +102,7 @@ static struct ins_ops ret_ops;
 
 /* Data type collection debug statistics */
 struct annotated_data_stat ann_data_stat;
+LIST_HEAD(ann_insn_stat);
 
 static int arch__grow_instructions(struct arch *arch)
 {
@@ -3669,6 +3670,30 @@ static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip)
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
@@ -3687,6 +3712,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	struct annotated_insn_loc loc;
 	struct annotated_op_loc *op_loc;
 	struct annotated_data_type *mem_type;
+	struct annotated_item_stat *istat;
 	u64 ip = he->ip;
 	int i;
 
@@ -3715,8 +3741,15 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
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
 
@@ -3725,6 +3758,10 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 			continue;
 
 		mem_type = find_data_type(ms, ip, op_loc->reg, op_loc->offset);
+		if (mem_type)
+			istat->good++;
+		else
+			istat->bad++;
 
 		if (symbol_conf.annotate_data_sample) {
 			annotated_data_type__update_samples(mem_type, evsel,
@@ -3737,5 +3774,6 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	}
 
 	ann_data_stat.no_mem_ops++;
+	istat->bad++;
 	return NULL;
 }
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 06281a50ecf6..2cef96859e45 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -485,4 +485,12 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
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
2.42.0.869.gea05f2083d-goog

