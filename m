Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84BB7DFC5F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377516AbjKBW1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377509AbjKBW1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:27:04 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26FD138;
        Thu,  2 Nov 2023 15:27:01 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5b9390d6bd3so2093584a12.0;
        Thu, 02 Nov 2023 15:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698964021; x=1699568821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lcxJn56vYeVd7h+U3NtVdyMbKNFOVxA21AaKaNaS0g=;
        b=fxI/K0eUfCjc8wkzZYneCznDqOtstoteIipECHHVnZKUulTGI82oAyKneWl6x48gr3
         040F5jLfihojj35uYC1aezntDg/b25+CF7P+Uj9paXqVnFz45twwO8f9Q4cm36e8O2iP
         V/8S1tbwDEShFIzMxSfNyTxiZf14wWX9W59VGuG0WXYcRpoIGyvthzAl08fMN3aCGyz0
         xUuCW/uT0ZLateq5RNjw//blDAm7532HSlSz1GWWjhGG3n2gHX2ZpT9/X4MxnGXz8V/9
         3lhLanMGU3RIWUVaybrDXeeC6fR2a1IAh1ilg0QcFoqghmQpu8RMj2t8OH/kwGNPGzN4
         QjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698964021; x=1699568821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2lcxJn56vYeVd7h+U3NtVdyMbKNFOVxA21AaKaNaS0g=;
        b=wLGkI1tLYtylVHHgiEP6f+Ys7kT41eNLQsGgNkHB9C2ll8V+dXjYmdJx9taA3PTIoX
         uM9E8DtnM/YqyMq8rYE+iM/K4A1JUnpG7gb9eGk5CFDN9BVKPXszxL7Qp2S6769YCd7h
         VhopUX6NnsoI/ActtAcUmaCIM6Pb9/tZXeG0EVrdoAaTqpUGfgV/GTj8oIJy1lsMihPC
         ar16Wi/5KaU+pFhKZguh+0HwixD/yqZJiycRqLMvgR67fCj3MsxYFL7FZPUAzjurCrQM
         4DQUcCIvZDitje9ff/Vbk8bFGehSNFEjhd0xY/YMI7TgNeFxiC8DZIRGapWNrwExgTJt
         K71w==
X-Gm-Message-State: AOJu0Yxl8uMaDcRfa1P1lRM7PoTDo8Kdltrc14osYUlL5Cm+rFtk7+dg
        tciGEsrQoPoIdRB0b095iMA=
X-Google-Smtp-Source: AGHT+IGoAFnPTV82jzNleeEAr38dIJIev6KfebPPaJm2N4e4uKwmLnfigLnGe6POFjoFKHbsDJnJyA==
X-Received: by 2002:a17:90b:3e88:b0:27c:df02:88b3 with SMTP id rj8-20020a17090b3e8800b0027cdf0288b3mr1310728pjb.8.1698964021032;
        Thu, 02 Nov 2023 15:27:01 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:ea22:bed1:d67b:af04])
        by smtp.gmail.com with ESMTPSA id cn18-20020a17090af09200b0027d015c365csm309894pjb.31.2023.11.02.15.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 15:27:00 -0700 (PDT)
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
Subject: [PATCH 5/5] perf annotate: Move offsets to annotated_source
Date:   Thu,  2 Nov 2023 15:26:53 -0700
Message-ID: <20231102222653.4165959-6-namhyung@kernel.org>
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

The offsets array keeps pointers to struct annotation_line which is
available in the annotated_source.  Let's move it to there.

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
index c51ceb857bd6..44af7e71a204 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -272,6 +272,7 @@ struct annotated_source {
 	int    			nr_histograms;
 	size_t			sizeof_sym_hist;
 	struct sym_hist		*histograms;
+	struct annotation_line	**offsets;
 	int			nr_entries;
 	int			nr_asm_entries;
 	u16			max_line_len;
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

