Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F7E7E0960
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377875AbjKCTTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377584AbjKCTTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:19:22 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093FDD47;
        Fri,  3 Nov 2023 12:19:20 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5b9390d6bd3so2854620a12.0;
        Fri, 03 Nov 2023 12:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699039159; x=1699643959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yywd3J3GcYpfirf/JYhCRxsuOyV95p1XP5rtxGSf9EM=;
        b=e4W/fqFkWAz4fEzVc6Obpe4io6nSui3BtbmMuby3Auqc4FjX7kMdN7qzSEvrgwAYdI
         VzpF6O0vtI8fb9QDl4rQWAjt5PdUhwdGWTThZIVQMItOv9bjio9A/KXHOKnFzB+4gMUM
         2QGpO60Ead+yfyl2dQwI85yPOi2lDhJ0jqDMiNvU6L/BXl1SYyjNRnu3bTGGuF/C7Oh4
         vl/VhlSeG+R+yLtCKSo7/bLLWUzVMC4BVgowxLrWdHAGuMhpzJRbdmL3Fs4AjvWziklM
         Sv8Eik4qnGG1lGn19Zl497jMrdqEdbL+PSPpiDSEzYaqSi88eZIkNxmQqAUjosawBlxQ
         tpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699039159; x=1699643959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yywd3J3GcYpfirf/JYhCRxsuOyV95p1XP5rtxGSf9EM=;
        b=RGcdlg/z7PSEcFwcQowGvtFNTRF6nNFZrfzQ+P2NT1KGn15BvRLhKra0GBKxX3vcNo
         HR2H6cM2D9JTd1qViJJEPol2PnZ4da5QnN8EjCxihdqt3j9inGSldUq+1l6H05QsTpGt
         Qcmr0ReuSWs4lqluHlZiD0/OH9NXMmYcJ94BRluv5PhDX5f5NZD5hxZYI/3WWt8kiftg
         42MlvTr2UZdbMMnl6QRCz3/xv7eR0EvvcJ+Kl3f1PAuIJzLRMW6PAIj4kp8tuUtoZt2d
         PDg5ViLh0BZ/oRV1G/3j9eeP/TYh73pRTFJQcZeHyL/Vus7SlEod5+O17cF+0A7xd4Uk
         UEMw==
X-Gm-Message-State: AOJu0YycPvXIlmNpWSgxf4lYKpEbQQtoZO4La+sxntu8t0fkaW3Zy6R7
        0OnWp7nwsbRHOcjdkP1wx/Q=
X-Google-Smtp-Source: AGHT+IFxhZpWmVOdbuEsPwWDwQZXJocc3phYGH/SVnXxwUfQ6Y4n3hxpLdA1QsZfB9KRopeL3nMu3Q==
X-Received: by 2002:a17:90a:9a5:b0:280:47ba:767a with SMTP id 34-20020a17090a09a500b0028047ba767amr4592811pjo.16.1699039159289;
        Fri, 03 Nov 2023 12:19:19 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:8234:4ed3:2635:c9d6])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090aca9100b0027cf4c554dasm1761349pjt.11.2023.11.03.12.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 12:19:18 -0700 (PDT)
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
Subject: [PATCH 5/5] perf annotate: Move offsets to annotated_source
Date:   Fri,  3 Nov 2023 12:19:07 -0700
Message-ID: <20231103191907.54531-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231103191907.54531-1-namhyung@kernel.org>
References: <20231103191907.54531-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The offsets array keeps pointers to struct annotation_line which is
available in the annotated_source.  Let's move it to there.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c |  4 ++--
 tools/perf/util/annotate.c        | 18 +++++++++---------
 tools/perf/util/annotate.h        |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 1b42db70c998..163f916fff68 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -188,7 +188,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	 *  name right after the '<' token and probably treating this like a
 	 *  'call' instruction.
 	 */
-	target = notes->offsets[cursor->ops.target.offset];
+	target = notes->src->offsets[cursor->ops.target.offset];
 	if (target == NULL) {
 		ui_helpline__printf("WARN: jump target inconsistency, press 'o', notes->offsets[%#x] = NULL\n",
 				    cursor->ops.target.offset);
@@ -1006,6 +1006,6 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 
 out_free_offsets:
 	if(not_annotated)
-		zfree(&notes->offsets);
+		zfree(&notes->src->offsets);
 	return ret;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ee7b8e1848a8..8ab2e1cf63ea 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1075,7 +1075,7 @@ static unsigned annotation__count_insn(struct annotation *notes, u64 start, u64
 	u64 offset;
 
 	for (offset = start; offset <= end; offset++) {
-		if (notes->offsets[offset])
+		if (notes->src->offsets[offset])
 			n_insn++;
 	}
 	return n_insn;
@@ -1105,7 +1105,7 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 			return;
 
 		for (offset = start; offset <= end; offset++) {
-			struct annotation_line *al = notes->offsets[offset];
+			struct annotation_line *al = notes->src->offsets[offset];
 
 			if (al && al->cycles && al->cycles->ipc == 0.0) {
 				al->cycles->ipc = ipc;
@@ -1142,7 +1142,7 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 		if (ch && ch->cycles) {
 			struct annotation_line *al;
 
-			al = notes->offsets[offset];
+			al = notes->src->offsets[offset];
 			if (al && al->cycles == NULL) {
 				al->cycles = zalloc(sizeof(*al->cycles));
 				if (al->cycles == NULL)
@@ -2783,7 +2783,7 @@ void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 		return;
 
 	for (offset = 0; offset < size; ++offset) {
-		struct annotation_line *al = notes->offsets[offset];
+		struct annotation_line *al = notes->src->offsets[offset];
 		struct disasm_line *dl;
 
 		dl = disasm_line(al);
@@ -2791,7 +2791,7 @@ void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 		if (!disasm_line__is_valid_local_jump(dl, sym))
 			continue;
 
-		al = notes->offsets[dl->ops.target.offset];
+		al = notes->src->offsets[dl->ops.target.offset];
 
 		/*
 		 * FIXME: Oops, no jump target? Buggy disassembler? Or do we
@@ -2830,7 +2830,7 @@ void annotation__set_offsets(struct annotation *notes, s64 size)
 			 * E.g. copy_user_generic_unrolled
  			 */
 			if (al->offset < size)
-				notes->offsets[al->offset] = al;
+				notes->src->offsets[al->offset] = al;
 		} else
 			al->idx_asm = -1;
 	}
@@ -3263,8 +3263,8 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	size_t size = symbol__size(sym);
 	int nr_pcnt = 1, err;
 
-	notes->offsets = zalloc(size * sizeof(struct annotation_line *));
-	if (notes->offsets == NULL)
+	notes->src->offsets = zalloc(size * sizeof(struct annotation_line *));
+	if (notes->src->offsets == NULL)
 		return ENOMEM;
 
 	if (evsel__is_group_event(evsel))
@@ -3290,7 +3290,7 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	return 0;
 
 out_free_offsets:
-	zfree(&notes->offsets);
+	zfree(&notes->src->offsets);
 	return err;
 }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 022fa7ea0f22..ddadece4cd5a 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -271,6 +271,7 @@ struct annotated_source {
 	struct list_head	source;
 	size_t			sizeof_sym_hist;
 	struct sym_hist		*histograms;
+	struct annotation_line	**offsets;
 	int    			nr_histograms;
 	int			nr_entries;
 	int			nr_asm_entries;
@@ -289,7 +290,6 @@ struct annotated_branch {
 struct LOCKABLE annotation {
 	u64			start;
 	struct annotation_options *options;
-	struct annotation_line	**offsets;
 	int			nr_events;
 	int			max_jump_sources;
 	struct {
-- 
2.42.0.869.gea05f2083d-goog

