Return-Path: <linux-kernel+bounces-131920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B706F898D93
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FFC1F2B8C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D265130ADD;
	Thu,  4 Apr 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoQweGDv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4654013048D;
	Thu,  4 Apr 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253440; cv=none; b=N4tH1mUqjgFTMkFI80hSTH300aMfbPrMz0FVViEQfX4ApO0QXrVVD1DQne4oz/1pJ4BV/Geo2uh8DyOxtszjUi4d5tEMkmhH/v4IuOp3IjPgAP82DI7Jo2CXbMnHrvuj1NYd3UWBGzOLvKFuBHyi9wGhmv7fug8rXIDeJS5p3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253440; c=relaxed/simple;
	bh=SJjN9aXGnax1R0X3pXFjDpiQ0mqjOWsvypYEn+6C/2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lw19+4S2gUuJSG9UISuBJ/FUqQj15jyzjFlpovXZgiIRZOKYpg/fR/CvPMoEbFuI0DBiYAhqsjAe7gPubuuh0WE6R04kAl6oVysGnHUTUQ6IaHqJCPbCDFClPMCozPC105QJ8QGD8ykkMWaZwRLm6xggkRNFmwH1jdUdEOfr1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoQweGDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823F9C43390;
	Thu,  4 Apr 2024 17:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712253439;
	bh=SJjN9aXGnax1R0X3pXFjDpiQ0mqjOWsvypYEn+6C/2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eoQweGDvM4FNT1XXPnBdQsJCU1szgEFfLDQ7BRWS7gnjWtoMVOc8AmpEfzM4J9uUT
	 RhkIpOiv+u0ShLWupXmvyjf1XLSrjpwjsFDw87WdbBE4AdhqBAZGwD1/fKuGj7ePD0
	 45sxE+QfY6hoQaRpSK4PZb5O0A7ldvA4R1Y7MI7mb+4C25Jjn2jIxyKEEEbXS/Zu7F
	 bh0wBdT6+whJSQeEfUymbgdglOpJXRram/Ib2DRSYRD4QB9W6ui7OGzUIsXKR5My9x
	 psqmMkclPYRpjyj3zqxOBvO0wRZxl+4Oh0Plsm5lXPQ6OetOr5O6i3Uqb9T9ypjQqz
	 CTlUxIAOUlXPw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/9] perf annotate: Staticize some local functions
Date: Thu,  4 Apr 2024 10:57:09 -0700
Message-ID: <20240404175716.1225482-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240404175716.1225482-1-namhyung@kernel.org>
References: <20240404175716.1225482-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found annotation__mark_jump_targets(), annotation__set_offsets()
and annotation__init_column_widths() are only used in the same file.
Let's make them static.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 8 +++++---
 tools/perf/util/annotate.h | 3 ---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a330e92c2552..bbf4894b1309 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1316,7 +1316,8 @@ bool disasm_line__is_valid_local_jump(struct disasm_line *dl, struct symbol *sym
 	return true;
 }
 
-void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
+static void
+annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 {
 	u64 offset, size = symbol__size(sym);
 
@@ -1347,7 +1348,7 @@ void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 	}
 }
 
-void annotation__set_offsets(struct annotation *notes, s64 size)
+static void annotation__set_offsets(struct annotation *notes, s64 size)
 {
 	struct annotation_line *al;
 	struct annotated_source *src = notes->src;
@@ -1404,7 +1405,8 @@ static int annotation__max_ins_name(struct annotation *notes)
 	return max_name;
 }
 
-void annotation__init_column_widths(struct annotation *notes, struct symbol *sym)
+static void
+annotation__init_column_widths(struct annotation *notes, struct symbol *sym)
 {
 	notes->widths.addr = notes->widths.target =
 		notes->widths.min_addr = hex_width(symbol__size(sym));
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index b3007c9966fd..3f383f38f65f 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -340,10 +340,7 @@ static inline bool annotation_line__filter(struct annotation_line *al)
 	return annotate_opts.hide_src_code && al->offset == -1;
 }
 
-void annotation__set_offsets(struct annotation *notes, s64 size);
-void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym);
 void annotation__update_column_widths(struct annotation *notes);
-void annotation__init_column_widths(struct annotation *notes, struct symbol *sym);
 void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *ms);
 
 static inline struct sym_hist *annotated_source__histogram(struct annotated_source *src, int idx)
-- 
2.44.0.478.gd926399ef9-goog


