Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0621380FC53
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378022AbjLMANt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377912AbjLMANi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:13:38 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62378112;
        Tue, 12 Dec 2023 16:13:39 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d098b87eeeso56326195ad.0;
        Tue, 12 Dec 2023 16:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426419; x=1703031219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hu4FhpBOZPILh8fziHco9keVgUrcb3i/LhY1Cwkj/nE=;
        b=WaKMdEEylrJ6/OUpJlgn+WROF56jYzmLhFgq57A2N68icSBiLr2PMH5kNQHHRjlaaL
         IvFwM9Dgfx7Ur7Zrb/iasLd/2lRWDI6cawB9s9fn1mRmdDTLlTnfAsn0/Dzau7w2jF4s
         EdLKU1vILCSeDwjJ8pZAvoIIV6QOuo5lY2q0XBAs87o1Rr9WQLk2MQLRniZlhgM61CUf
         Iy1ZWoQrPuQnYFRmL3F7M2dmUuGi+GSr1MfUZw/psQF7KsThFIvfC2IE11idVZh0iwLs
         d7MlcXlypTFJguNkFEVYKZ19RUQe6exS3Db+BYFIv7we/UwtADMKJv2ZxN7CiB6XNeca
         t/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426419; x=1703031219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hu4FhpBOZPILh8fziHco9keVgUrcb3i/LhY1Cwkj/nE=;
        b=MGEF55/xozsd+iYHHfa6p47feVjr5s7lJnoJe4Fuh0/dGJ3/mNUXvmASbG1uhGbytv
         WoToWFj6JTLhniClOiRFIECs20SjsQOdBkqJIRKHkyUPzM71RyHDc2jwY/K3O5jm3KZ9
         hOOlzHkc4nfBgl3Zx7U+gvo3yd3oSLNCxfNQBirjuzbUJj/QLGz+4C20ySYrv4ftAccz
         9CIEdvsNLghjiaiNDVvCgcO5jmht9g5z7ivDSM5H5Vf5Yg4us1O8jUoY1YdNJAXLG2ny
         Gp82CaDf2QX4XQMQoXrvIrZGe70WITX92S6lv2RAzsbewh/VQvkzSG1xSXke6n2QI5G9
         EyNQ==
X-Gm-Message-State: AOJu0Yzb0cS7rg+d9lVU+grYaBPAbz3nIti4tZ6B3ZPP0z4r8JsK+pR6
        XgZW9r8q0bkbqgXDhYPdyYQ=
X-Google-Smtp-Source: AGHT+IGYp55nk0e5Mh4PuJi4qEGEeU+CKxQ5ZtxvickF/7HAYgDjzFk/8HZxPNTYOKKwyG6rRALgUA==
X-Received: by 2002:a17:903:452:b0:1d0:7d9e:e727 with SMTP id iw18-20020a170903045200b001d07d9ee727mr6181201plb.14.1702426418656;
        Tue, 12 Dec 2023 16:13:38 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:38 -0800 (PST)
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
Subject: [PATCH 07/17] perf annotate: Implement hist_entry__get_data_type()
Date:   Tue, 12 Dec 2023 16:13:13 -0800
Message-ID: <20231213001323.718046-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213001323.718046-1-namhyung@kernel.org>
References: <20231213001323.718046-1-namhyung@kernel.org>
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
 tools/perf/util/annotate.c | 88 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h |  4 ++
 2 files changed, 92 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 7c597440dc2e..8673eac4b9df 100644
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
@@ -3625,3 +3626,90 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 
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
+	if (symbol__annotate(ms, evsel, NULL) < 0)
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
+	if (!symbol_conf.init_annotation)
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
index 25ae8893d4f9..6c75b2832286 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -23,6 +23,7 @@ struct option;
 struct perf_sample;
 struct evsel;
 struct symbol;
+struct annotated_data_type;
 
 struct ins {
 	const char     *name;
@@ -475,4 +476,7 @@ struct annotated_insn_loc {
 int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 			       struct annotated_insn_loc *loc);
 
+/* Returns a data type from the sample instruction (if any) */
+struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he);
+
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.43.0.472.g3155946c3a-goog

