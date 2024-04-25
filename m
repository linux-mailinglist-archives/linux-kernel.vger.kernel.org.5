Return-Path: <linux-kernel+bounces-157890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7808B182F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417BE285524
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F177489;
	Thu, 25 Apr 2024 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN6cE9Vb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FEF4C62;
	Thu, 25 Apr 2024 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714006318; cv=none; b=rcpbfcKRYtHss2qArYVwUesdPAlSTqopo3ZKTEoDNb0cME8zUgTdckBgC59XirpVilgKbhCQYYr2+i/LH4UakERAR1efvAyBSClM4bC1reBWJiVn2WtRJWJj79Xg/OFZQqrzMNTaTW9UGTRyrxLKae6Oxsqh86ZQVQCzm+SoIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714006318; c=relaxed/simple;
	bh=xJPhb8n2lxP5Gp+Xbv+wgx1zDYnLgjcoI1fT4bMeiVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dF799HsfMnyaqLfyuj3HV8xIaleS/mx5o4h4/8pPT8eKoT51EdQn5MvTFlJ2yJvG7tqUeyoJhP1UhNGgLvyDyThjw6UZty+DguNuuvsBbBrm5o1tIRenViIv/ysrL8PB+hGQHl1A83uZx0IFDXsO8jxqc5il+55DMuB0/x5NBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CN6cE9Vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB92C113CD;
	Thu, 25 Apr 2024 00:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714006318;
	bh=xJPhb8n2lxP5Gp+Xbv+wgx1zDYnLgjcoI1fT4bMeiVs=;
	h=From:To:Cc:Subject:Date:From;
	b=CN6cE9VbyUTmz/cAIB0/kIIyHc6+ZoUEUD1yt1rDUGoGMjkOhKNjwhiCZ+WrIczQG
	 A8Ss175z44DAuj+v6x/UWpzDsVvcKNb1JLiMy5kfN6Nn9o1o3PZIXbPiKsivApaEb6
	 8ivAFVViuo5nCS1MkTHOO84LoCZgcA/k/r1BGUz/khlrD72AO84zeXqzK126dmGDTr
	 uc9PFVAoKasvn/5xlfamSIjG/WoR13C462n1uMQThJYYGTf0O8DxfmpMO29OR/jP9B
	 Sowx1TU1N2jJrMBW031N04/w84RW73qwjEaBR0w6kD0TiTPJZrytnlcv+T+RX38mI2
	 kn7Jf0GPMQmeg==
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
Subject: [PATCH 1/2] perf annotate: Fallback to objdump when capstone fails
Date: Wed, 24 Apr 2024 17:51:56 -0700
Message-ID: <20240425005157.1104789-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found some cases that capstone failed to disassemble.  Probably my
capstone is an old version but anyway there's a chance it can fail.  And
then it silently stopped in the middle.  In my case, it didn't
understand "RDPKRU" instruction.

Let's check if the capstone disassemble reached to the end of the
function.  And fallback to objdump if not.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/disasm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 92937809be85..412101f2cf2a 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1542,6 +1542,20 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 		offset += insn[i].size;
 	}
 
+	/* It failed in the middle: probably due to unknown instructions */
+	if (offset != len) {
+		struct list_head *list = &notes->src->source;
+
+		/* Discard all lines and fallback to objdump */
+		while (!list_empty(list)) {
+			dl = list_first_entry(list, struct disasm_line, al.node);
+
+			list_del_init(&dl->al.node);
+			disasm_line__free(dl);
+		}
+		count = -1;
+	}
+
 out:
 	if (needs_cs_close)
 		cs_close(&handle);
-- 
2.44.0.769.g3c40516874-goog


