Return-Path: <linux-kernel+bounces-125466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 184E1892682
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A661C2120A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49013D288;
	Fri, 29 Mar 2024 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEWoUclj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386C713C3C5;
	Fri, 29 Mar 2024 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749495; cv=none; b=jJeB563R1ilmR5QfN3zIsYLljXbXiVOeX1dk0x0k1l1FfffMY45HUtE2WCv4RhZqIiyZmjDlzlsEBsIrrAxCfwObjUtab/kwnyWKS7TUgUcy9ShX89cN1Leg0etwh7ZQzrfZ1lN++1z3wO3kEqBgN3oTtX9egvjCCe/ubTWmu8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749495; c=relaxed/simple;
	bh=UvaA7BRgw7vdNNiWdsV21ScZVQR/gOFfTgj7FTu8ZyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPqVeZlVoxpBQMBNeRGQkjf+d2mxZH5uf5mHhdhqiUJ/gmmf6PUbJ/kG1rdudaWFyGkDLezihJzx6KYggPV+S8xhxHMnZvZO/9BfBdH2o6bJxXaDS6pUtM1R/cAGlrpqMEThtI5pDl16YobqjewgZ/pzEtqr61pZPoUDCAF/cQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEWoUclj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73861C433B1;
	Fri, 29 Mar 2024 21:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711749494;
	bh=UvaA7BRgw7vdNNiWdsV21ScZVQR/gOFfTgj7FTu8ZyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fEWoUcljKPFGFZDhUB5C6dt3JqlfJIvvJqrjiCsOmAVtVdz9MQiFu48/lNSiV5RjZ
	 oOM3rj5b1AO4/voR/MH+sLPImwHJk1Cl0ejA7BQqasV20gPPbKsoySx4HfSs7MLoEG
	 uBgZhMlcDyu83RfPPEzWQoMqB5FzLOOK2rtwCq0jomR2gG9XxzfVtBQ28kw4FkDwnP
	 8CSUokIwAUv4A/BUqigPWkWEhyYL+tVfl+kAFr5c14Ow0Ncvsxx03SJbVPUyMc5tWp
	 5T/OlpsRxXnEDE/8ETbXSTQNJSn6YCC19fg9qJBm2u76z8UWr8Bqn41Q1ESJcupzNB
	 10DKE/2QoY71g==
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
Subject: [PATCH v2 2/5] perf annotate: Add and use ins__is_nop()
Date: Fri, 29 Mar 2024 14:58:09 -0700
Message-ID: <20240329215812.537846-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240329215812.537846-1-namhyung@kernel.org>
References: <20240329215812.537846-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Likewise, add ins__is_nop() to check if the current instruction is NOP.

Tested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 7 ++++++-
 tools/perf/util/annotate.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 986c499150ef..5d0ca004dcfb 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -757,6 +757,11 @@ static struct ins_ops ret_ops = {
 	.scnprintf = ins__raw_scnprintf,
 };
 
+bool ins__is_nop(const struct ins *ins)
+{
+	return ins->ops == &nop_ops;
+}
+
 bool ins__is_ret(const struct ins *ins)
 {
 	return ins->ops == &ret_ops;
@@ -1785,7 +1790,7 @@ static void delete_last_nop(struct symbol *sym)
 		dl = list_entry(list->prev, struct disasm_line, al.node);
 
 		if (dl->ins.ops) {
-			if (dl->ins.ops != &nop_ops)
+			if (!ins__is_nop(&dl->ins))
 				return;
 		} else {
 			if (!strstr(dl->al.line, " nop ") &&
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 14980b65f812..98f556af637c 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -74,6 +74,7 @@ struct ins_ops {
 
 bool ins__is_jump(const struct ins *ins);
 bool ins__is_call(const struct ins *ins);
+bool ins__is_nop(const struct ins *ins);
 bool ins__is_ret(const struct ins *ins);
 bool ins__is_lock(const struct ins *ins);
 int ins__scnprintf(struct ins *ins, char *bf, size_t size, struct ins_operands *ops, int max_ins_name);
-- 
2.44.0.478.gd926399ef9-goog


