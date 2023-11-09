Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287917E7577
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345432AbjKJABo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345497AbjKJAA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:58 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE3D49F2;
        Thu,  9 Nov 2023 16:00:41 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2809414efa9so1374609a91.1;
        Thu, 09 Nov 2023 16:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574441; x=1700179241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWaJqhvBxoi7J2eAsBrbo6D+bveraN1II1Qf4G2yQhQ=;
        b=T8A+2BvSqJDGq3/J6//XCLN+CFW9DkBCZhGzZxNdUdAUGzoD0mMNqQhxE051ogGkB+
         WutjLVHyFMdoAN0NjJhgHNcVP3BGW+te93Z1hQL2THfOm0NL9zXtHNcDunH2Nn1morU2
         /m1KKhSl70RvBJVNJE9eMXavO4oyKmQmUh2+ZAXro6BJxBQGHNCdvxo4zGbQN+ATQ++v
         CdGjup9fFyhRVpBH/prLPG7k6YPcqWO9sd7PxQ5EJXl8a7TE+rIRc87HwTG550MeQcMx
         nMShZN21b/QCrX6Up3/kSxUaD63JGDcZrLjhO6SHcT1RIEXpO9HmUDVfakaLgxQqsOrb
         EFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574441; x=1700179241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mWaJqhvBxoi7J2eAsBrbo6D+bveraN1II1Qf4G2yQhQ=;
        b=L3AVkSZ2IfM9eX6ZiVijfWPhMflZA7ihtRiN4mERE7IoD+X6BURMhglzQnVDB3oINH
         7vYpl72lu3Ii4p2BVqMACR6GFBqXxXHOjKTM7GKtDSGTLyhtLcIMojRYOmQzoa7lDr69
         5PZPbsp+Fe1rvGuHTYDPm3CAIqLWioT3ASVBkb+PYAlkHyiFoyVLq3cqJpSoVdzb8Qni
         w0lNTWSjp0PVrs32ZyBPnPquU+DzCZ74QgeAPXE5K+9MPlzC2tDX1rK74dUyFXJgoFWH
         DlOeQzTKlJS56JDbeJfSuWdHk8PfcKtdELkvGvC2XUQJingnby0jhI3IZExJtpMT/s+A
         Jgjg==
X-Gm-Message-State: AOJu0YzhGsWzQKYu5Tb93rHKF0dj+eggq/01awLnhLdw+BSygjDipsgK
        e+FKMnYXrxmlacHX9Izl/q4=
X-Google-Smtp-Source: AGHT+IEaSPKnPWXbekCEG6WprIPDnyGu0sJhPrEKmU0oNGqnlyjFqH8YvOy0pQ5PGLU8quUnxGVLrA==
X-Received: by 2002:a17:90b:314e:b0:280:39f2:2f12 with SMTP id ip14-20020a17090b314e00b0028039f22f12mr3388244pjb.26.1699574440731;
        Thu, 09 Nov 2023 16:00:40 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:40 -0800 (PST)
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
Subject: [PATCH 17/52] perf annotate: Implement hist_entry__get_data_type()
Date:   Thu,  9 Nov 2023 15:59:36 -0800
Message-ID: <20231110000012.3538610-18-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index f0c89552087d..c08686b91861 100644
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
@@ -3629,3 +3630,87 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 
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
index 10eefecf49c4..06281a50ecf6 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -23,6 +23,7 @@ struct option;
 struct perf_sample;
 struct evsel;
 struct symbol;
+struct annotated_data_type;
 
 struct ins {
 	const char     *name;
@@ -481,4 +482,7 @@ struct annotated_insn_loc {
 int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 			       struct annotated_insn_loc *loc);
 
+/* Returns a data type from the sample instruction (if any) */
+struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he);
+
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.42.0.869.gea05f2083d-goog

