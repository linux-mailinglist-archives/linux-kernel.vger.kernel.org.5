Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4CB7C6372
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377151AbjJLDwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377130AbjJLDwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E1111A;
        Wed, 11 Oct 2023 20:51:34 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2773f776f49so384420a91.1;
        Wed, 11 Oct 2023 20:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082693; x=1697687493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqS3acjNyfHXAKt2i/1MQ99UO2nZZIth1PMAMz3P27M=;
        b=C29ND8KEE5MDVIMfoJfdXWO59SmotPpaHeA47qxLOHhvXOnAZI3kMXWMxT9Hox/S5z
         XJS1s0wyWGkXy7bWHT0eUZgVc8JgjE30oXQ/k8ArVDwEgAzs+IA+QLLpj7NDWhimfsR8
         ZjFzZTDKZf628b9AuNNI2S8oltRKJaucQxmoR7120Xd2Pi4kcSRKThWryEYKF3PC+RyZ
         Dtc9wdee8HOCgdcfQEnCXeGpxamj4x+tBAcRm5SpkaG/yiYiM9fB9u8ZAuPcIS7o6lo0
         jkiaFfepENb4SxSuu+T5kANY+c8uRJu9oHrHbJEIYSkzZzWSrWd+3JyBwJodyvCEmqmq
         pe2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082693; x=1697687493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqS3acjNyfHXAKt2i/1MQ99UO2nZZIth1PMAMz3P27M=;
        b=hRRa4OGA9lBWRDoA1/udlsv4DvUKAq1stiuyKPyJitaUnUJvDc/SQXaOBhqb13s9Rs
         WxGMaRy5oK5fV/vw8xXe55KhHM4CaQ74WnNYSqBhApo/dAwZ1WxsGA8Vna5ml89ttXBU
         mdKh1kkEQeWJBOCItTNIafnNGYq1oeNvdpplochoNqRFRzaJB0mlM66nAFRuBLraQXif
         3Vy6zWa2CBheAm1qP3gsv9kMH9DagkjWmxhlhX0FbemE5ob3AEoAP6cmvwbexDcALOBa
         /XHKywz+1VPFtEg7/xtfiVG5sISzz3qRGTGGuND0zbNwxYZuwu9BUBvMowZpRzPtxsVe
         I7JA==
X-Gm-Message-State: AOJu0YzjC191Ceqznwl3B/H+XW6vXaEy7URyIMfL7PHq/RA7CeIWNC7L
        WGiNPas7gv/geHfTzPgA/Y0=
X-Google-Smtp-Source: AGHT+IHU2Vzhh9c+hkafnr864Gn2ZGcWbCgPbXYDp4+67dqafL09eG+KoUve+ApCUO/3uvOuZCOUIA==
X-Received: by 2002:a17:90a:858b:b0:277:5cd5:6f80 with SMTP id m11-20020a17090a858b00b002775cd56f80mr28649847pjn.16.1697082693327;
        Wed, 11 Oct 2023 20:51:33 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:33 -0700 (PDT)
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
Subject: [PATCH 14/48] perf annotate: Implement hist_entry__get_data_type()
Date:   Wed, 11 Oct 2023 20:50:37 -0700
Message-ID: <20231012035111.676789-15-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's the function to find out the type info from the given sample data
and will be called from the hist_entry sort logic when 'type' sort key
is used.

It first calls objdump to disassemble the instructions and figure out
information about memory access at the location.  Maybe we can do it
better by analyzing the instruction directly, but I'll leave it for
later work.

The memory access is determined by checking instruction operands to
have "(" and then extract register name and offset.  It'll return NULL
if no data type is found.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 85 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h |  4 ++
 2 files changed, 89 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9d653a1e84ce..e5dc3d6fc6d0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -25,6 +25,7 @@
 #include "units.h"
 #include "debug.h"
 #include "annotate.h"
+#include "annotate-data.h"
 #include "evsel.h"
 #include "evlist.h"
 #include "bpf-event.h"
@@ -3591,3 +3592,87 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 
 	return 0;
 }
+
+static void symbol__ensure_annotate(struct map_symbol *ms, struct evsel *evsel)
+{
+	struct disasm_line *dl, *tmp_dl;
+	struct annotation *notes;
+
+	notes = symbol__annotation(ms->sym);
+	if (!list_empty(&notes->src->source))
+		return;
+
+	if (symbol__annotate(ms, evsel, notes->options, NULL) < 0)
+		return;
+
+	/* remove non-insn disasm lines for simplicity */
+	list_for_each_entry_safe(dl, tmp_dl, &notes->src->source, al.node) {
+		if (dl->al.offset == -1) {
+			list_del(&dl->al.node);
+			free(dl);
+		}
+	}
+}
+
+static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip)
+{
+	struct disasm_line *dl;
+	struct annotation *notes;
+
+	notes = symbol__annotation(sym);
+
+	list_for_each_entry(dl, &notes->src->source, al.node) {
+		if (sym->start + dl->al.offset == ip)
+			return dl;
+	}
+	return NULL;
+}
+
+/**
+ * hist_entry__get_data_type - find data type for given hist entry
+ * @he: hist entry
+ *
+ * This function first annotates the instruction at @he->ip and extracts
+ * register and offset info from it.  Then it searches the DWARF debug
+ * info to get a variable and type information using the address, register,
+ * and offset.
+ */
+struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
+{
+	struct map_symbol *ms = &he->ms;
+	struct evsel *evsel = hists_to_evsel(he->hists);
+	struct arch *arch;
+	struct disasm_line *dl;
+	struct annotated_insn_loc loc;
+	struct annotated_op_loc *op_loc;
+	u64 ip = he->ip;
+	int i;
+
+	if (ms->map == NULL || ms->sym == NULL)
+		return NULL;
+
+	if (evsel__get_arch(evsel, &arch) < 0)
+		return NULL;
+
+	/* Make sure it runs objdump to get disasm of the function */
+	symbol__ensure_annotate(ms, evsel);
+
+	/*
+	 * Get a disasm to extract the location from the insn.
+	 * This is too slow...
+	 */
+	dl = find_disasm_line(ms->sym, ip);
+	if (dl == NULL)
+		return NULL;
+
+	if (annotate_get_insn_location(arch, dl, &loc) < 0)
+		return NULL;
+
+	for_each_insn_op_loc(&loc, i, op_loc) {
+		if (!op_loc->mem_ref)
+			continue;
+
+		return find_data_type(ms, ip, op_loc->reg, op_loc->offset);
+	}
+	return NULL;
+}
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 4adda492233d..299b4a18e804 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -23,6 +23,7 @@ struct option;
 struct perf_sample;
 struct evsel;
 struct symbol;
+struct annotated_data_type;
 
 struct ins {
 	const char     *name;
@@ -473,4 +474,7 @@ struct annotated_insn_loc {
 int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 			       struct annotated_insn_loc *loc);
 
+/* Returns a data type from the sample instruction (if any) */
+struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he);
+
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.42.0.655.g421f12c284-goog

