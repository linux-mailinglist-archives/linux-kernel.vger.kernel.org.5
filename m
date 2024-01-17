Return-Path: <linux-kernel+bounces-28559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E501D830019
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7B11F25134
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047E3BA53;
	Wed, 17 Jan 2024 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etvt8bjs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECA8F5C;
	Wed, 17 Jan 2024 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472820; cv=none; b=Q4Nn0IEgnUZiHCDINukoS99Vgp0KNRDG7Kn+T/I4RoZYoVXU7YcBZtHertVRhvvUW7w2ir4MkaLiOlwXtF5XDoVLXM9dFYabhZqrxLhijkxdx12mvn8HyN2vYW3VdqbAPcuqGHRrmEVcAIlAQxg/E9lPEBYClhnI7uOVEUx9yis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472820; c=relaxed/simple;
	bh=aLICRa3tZ3ugvUvE2bTbO39XFNiIYiiINyuOvQD/ewA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=IOfTh7wH9Dgztqysono6z8mpjc/Wh5Nc58guSyvNxk9okulPqT6DbDZoRUHSaznHx92LoLVNZt3lImtfBpbBmzyF7eONFMmpahEr2uboNwr3COApv6z+NvCToF44leu4YHiLXXnVAVCHKKkfC1y5F+j7bTJZIuCU2iJ09+aTLf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etvt8bjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4447AC433B1;
	Wed, 17 Jan 2024 06:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705472819;
	bh=aLICRa3tZ3ugvUvE2bTbO39XFNiIYiiINyuOvQD/ewA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=etvt8bjsNndNAe3g6/vWX3jbN2/RfHFlkZ+Dvx76SYfBkm37vAOssbYk1W7sCVOl9
	 0QV9dvXWeJYzyhnEl0yS4C3+VdBDfmoHki/9mep34IBpLV7Cznabt7yXVqG3TmgoBe
	 moBnWmJPiKFwwaRfxbkOvP5RVdlRIIVbzYGUKA90J8naWc1uWq//3EWrn+J3mAl76+
	 //o2snZFI8nDVt7g0CIGfd89wSeHXcA7AkQPBS2KRJGW/o0EoJF8Nn+JTa+c7rD5gY
	 PeM+/Ep53mL5W1KU4iqu4xyZ09+HRnOFQq0ebI0LQ4aqOW1gfQ9dkMHW+48hh+gB12
	 JKT0+ziOdXDkg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org,
	linux-trace-devel@vger.kernel.org
Subject: [PATCH 1/9] perf annotate-data: Parse 'lock' prefix from llvm-objdump
Date: Tue, 16 Jan 2024 22:26:49 -0800
Message-ID: <20240117062657.985479-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
In-Reply-To: <20240117062657.985479-1-namhyung@kernel.org>
References: <20240117062657.985479-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the performance reason, I prefer llvm-objdump over GNU's.  But I
found that llvm-objdump puts x86 lock prefix in a separate line like
below.

  ffffffff81000695: f0                    lock
  ffffffff81000696: ff 83 54 0b 00 00     incl    2900(%rbx)

This should be parsed properly, but I just changed to find the insn
with next offset for now.

This improves the statistics as it can process more instructions.

  Annotate data type stats:
  total 294, ok 144 (49.0%), bad 150 (51.0%)
  -----------------------------------------------------------
          30 : no_sym
          35 : no_mem_ops
          71 : no_var
           6 : no_typeinfo
           8 : bad_offset

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9b70ab110ce7..8d761be1a102 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3660,8 +3660,17 @@ static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip)
 	notes = symbol__annotation(sym);
 
 	list_for_each_entry(dl, &notes->src->source, al.node) {
-		if (sym->start + dl->al.offset == ip)
+		if (sym->start + dl->al.offset == ip) {
+			/*
+			 * llvm-objdump places "lock" in a separate line and
+			 * in that case, we want to get the next line.
+			 */
+			if (!strcmp(dl->ins.name, "lock") && *dl->ops.raw == '\0') {
+				ip++;
+				continue;
+			}
 			return dl;
+		}
 	}
 	return NULL;
 }
@@ -3758,6 +3767,9 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		if (!op_loc->mem_ref)
 			continue;
 
+		/* Recalculate IP since it can be changed due to LOCK prefix */
+		ip = ms->sym->start + dl->al.offset;
+
 		mem_type = find_data_type(ms, ip, op_loc->reg, op_loc->offset);
 		if (mem_type)
 			istat->good++;
-- 
2.43.0.381.gb435a96ce8-goog


