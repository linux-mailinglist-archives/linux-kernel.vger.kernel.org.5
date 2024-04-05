Return-Path: <linux-kernel+bounces-133588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F0E89A602
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C667DB214AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB524176FA9;
	Fri,  5 Apr 2024 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqL9R1aN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66F175560;
	Fri,  5 Apr 2024 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351884; cv=none; b=IIljUsd58MNODHMkhSZT8aaxemvo7H9jJmv0X1stNmHSAjfm9HR9WLHKxnjZCO4AkWKT3Yg3KlJMiFWGz0IJ2weEFiFD2Wg6Z9nslAhYUISJPa8m3Hp6fQyB520yIKvCHi8wfh67UrjxCw4We9CL5Zzd6TXAA1XELVWe1HtA8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351884; c=relaxed/simple;
	bh=ItK41RqmUBjvIaYBvM/7weZYcst7IoTKTUZ5r9Uaq5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F89K/WZrJ/77ZnLKu4K5cClkbwf4UArVfxvXBkpiOtLGG3C6NncJ5vlU8K66HRV1TA053lrzKLJCcMdlNUWDwEVRodecJiDTgdK/YQ0XQR0+tktv91qqfpa22CLfBz71txNyU9PSJb4dt8D7PdMvQAS7V3n8KDEwnLo0YcS8OGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqL9R1aN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20D8C43330;
	Fri,  5 Apr 2024 21:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712351884;
	bh=ItK41RqmUBjvIaYBvM/7weZYcst7IoTKTUZ5r9Uaq5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqL9R1aNx0z3z2Y0rkUr9j5gHKm0DsE1Vsw9uWJhqm6FZsRjllivep+e2PrSjvkTk
	 U99AkUgd+gQPkxrg15+F2yA0DuFy0SQcmQp7byinTYntJSJkDew+z5e5W5nyZ9NjEZ
	 v4zKsrjk79nRJO9tVwHRuqakLBO0BuUfmum5e//SeuT+HVG2mTfmPWVEc7I3s7o6qQ
	 DoOVdLJF7Tk4gJE6c9f5x9fkeRiOXxFgI1sdwp4RJM2wl1uwabMnPbqMjMTgYMqGfo
	 puNHp5XCV/eAeVkKAD/Wb5A3OOhobTDUkNltqEvfqi9wqq4alxxOW05PUZyRJwisRP
	 FNl3hhW6LwhXg==
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
Subject: [PATCH 4/4] perf annotate: Get rid of symbol__ensure_annotate()
Date: Fri,  5 Apr 2024 14:18:00 -0700
Message-ID: <20240405211800.1412920-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240405211800.1412920-1-namhyung@kernel.org>
References: <20240405211800.1412920-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now symbol__annotate() is reentrant and it doesn't need to remove
non-instruction lines.  Let's get rid of symbol__ensure_annotate() and
call symbol__annotate() directly.  Also we can use it to get the arch
pointer instead of calling evsel__get_arch() directly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9df82e58cf6e..903565799d1b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2140,14 +2140,6 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 	return 0;
 }
 
-static void symbol__ensure_annotate(struct map_symbol *ms, struct evsel *evsel)
-{
-	struct annotation *notes = symbol__annotation(ms->sym);
-
-	if (list_empty(&notes->src->source))
-		symbol__annotate(ms, evsel, NULL);
-}
-
 static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
 					    bool allow_update)
 {
@@ -2322,14 +2314,12 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		return NULL;
 	}
 
-	if (evsel__get_arch(evsel, &arch) < 0) {
+	/* Make sure it has the disasm of the function */
+	if (symbol__annotate(ms, evsel, &arch) < 0) {
 		ann_data_stat.no_insn++;
 		return NULL;
 	}
 
-	/* Make sure it runs objdump to get disasm of the function */
-	symbol__ensure_annotate(ms, evsel);
-
 	/*
 	 * Get a disasm to extract the location from the insn.
 	 * This is too slow...
-- 
2.44.0.478.gd926399ef9-goog


