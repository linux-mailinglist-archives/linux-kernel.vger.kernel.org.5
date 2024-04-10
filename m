Return-Path: <linux-kernel+bounces-139222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C358A0009
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E642287660
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B52172BBA;
	Wed, 10 Apr 2024 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlIJSi6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC4215B553;
	Wed, 10 Apr 2024 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775078; cv=none; b=E+aWiiBw4JGgrJ64lx3knFixreBYnPkHO7qizl+MD8DL3Qk98mTt3JVEzS0DCMO9X8KvBpeJype7NUIm5LrMlrmjkLRXoFhvsqe2xGF08WbJpPQBvplIU9kdu1shxrHe2J5eTxvvYUUTtCH8yOsraXy7qh6JygeqLHwSp1LZQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775078; c=relaxed/simple;
	bh=uk6YkMUxJv7HaSVCQDn74ZjZOlGw6gZ/lMU0WUZv8wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njVkklJqx01swx+Yz03+ftQMhY7tPohj2P/48UjBw/ly/F2ovHg2ymcxH1JSK4LVSQKr99B2VuZw6wE+vH4B1mKJo6JRheGJ9Vqbq9qcm4Zpn4uABX4XmRfFT6KLThWLKguzEes6+JdPhaDrsuevJXcoM/B2tGR3v2wIIzsm19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlIJSi6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1486C433C7;
	Wed, 10 Apr 2024 18:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712775078;
	bh=uk6YkMUxJv7HaSVCQDn74ZjZOlGw6gZ/lMU0WUZv8wc=;
	h=From:To:Cc:Subject:Date:From;
	b=AlIJSi6EVyRPBDTwk89QTm3T25I2dRXoRynSPHKZacJN9n4FGA79xwE143AjcMFIW
	 q2/6N1vg11ojb+fbfxo5fYQs9AqFPzwM54vPk6BVkwIPz/FMSft5AMZoW4e1snzUch
	 415Qt5kiQeJZoy9HmFTQBQIExQxVXIQQ39DaLeRVjTqUwlexc3xylI+HhB9MM6GRxt
	 IeYwsA/LMviGhW/OiQ7omPMH65B4eZQ7RZnYlrbabwrI0d/S3B74lrxC9GBpLerprO
	 twZulNVcD0KOZVl3ZtzVvpbXwMer7mnEatC7d9hX+7FJCG8qFBq1YirzYLTb9hN96N
	 nmzCAAxS91jFQ==
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
Subject: [PATCH] perf annotate: Skip DSOs not found
Date: Wed, 10 Apr 2024 11:51:17 -0700
Message-ID: <20240410185117.1987239-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some data file, I see the following messages repeated.  It seems it
doesn't have DSOs in the system and the dso->binary_type is set to
DSO_BINARY_TYPE__NOT_FOUND.  Let's skip them to avoid the followings.

  No output from objdump  --start-address=0x0000000000000000 --stop-address=0x00000000000000d4  -d --no-show-raw-insn       -C "$1"
  Error running objdump  --start-address=0x0000000000000000 --stop-address=0x0000000000000631  -d --no-show-raw-insn       -C "$1"
  ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/disasm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index a1219eb930aa..92937809be85 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1669,6 +1669,8 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		return symbol__disassemble_bpf(sym, args);
 	} else if (dso->binary_type == DSO_BINARY_TYPE__BPF_IMAGE) {
 		return symbol__disassemble_bpf_image(sym, args);
+	} else if (dso->binary_type == DSO_BINARY_TYPE__NOT_FOUND) {
+		return -1;
 	} else if (dso__is_kcore(dso)) {
 		kce.kcore_filename = symfs_filename;
 		kce.addr = map__rip_2objdump(map, sym->start);
-- 
2.44.0.478.gd926399ef9-goog


