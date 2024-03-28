Return-Path: <linux-kernel+bounces-123819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D85DA890E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D592951E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD5613958C;
	Thu, 28 Mar 2024 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJt6IMpK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C813342A;
	Thu, 28 Mar 2024 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711668012; cv=none; b=QGm6pE+Gg+RQDMbmbzjWaJNP/PP8Om1ldG4p8Jy+FpJhEGaUsm9s9n1mGJzorourZ9s6i7HuvzC8VblXw9XEtR2Q/L5WJ3SJE7Q6ygBOBMBleuoIhRAMFo1vwbXwhTGMDE4jlokcKHsve06325G+CHO5DCsiXkqk6A+S+occk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711668012; c=relaxed/simple;
	bh=ZiizXyn2bC6VPGbKmxLPQFUyNjHtdrZRU65AE4PAyGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMvQ8SfX63bpVRp2EadvI5c42+hOHdBXKuMhlZJKrhVQaJDyQHYqH/UYqQDxA748z3AIm6Jf4VQRoadEAbqbyY69z07hUTDqeExzO/rt+F+qEzxq/6yUX97p8kqwOT7/auru+y+lttFdj2CE5dngb09uVHztc7rYRb+P+zmyE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJt6IMpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64069C4166B;
	Thu, 28 Mar 2024 23:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711668011;
	bh=ZiizXyn2bC6VPGbKmxLPQFUyNjHtdrZRU65AE4PAyGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RJt6IMpKxtDWN3D5qz7Qydv/IuZKZDcogsofP+41D/NErWTECoGp+LY2tRCUF4m29
	 VjiBo280af5VJYit6OmLH5JWf+8CBKybK1y7yUgCC7RaQ9c3xUwzLbo/6Dy0KRslXE
	 FNtwgTYxouHHnAhmvTdBbYj4EGMyiXtuDp76IrM5KzLizQ6V0tv+OPXgAuAe0JLlqP
	 AL8xkQLrpMzymPJn/xc5VjOnFw/me3JWpTmqGgVMWSAxvdURV1qixZ4bEFmCtwvz0i
	 vu1Pt7xH3IdpQ195czjw4cLjWlyh0vrX89DaxST5CohNbsFSvlItiBC9E6QlDFPqS9
	 DEadFXoaRbb5Q==
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
Subject: [PATCH 2/4] perf annotate: Add and use ins__is_nop()
Date: Thu, 28 Mar 2024 16:20:07 -0700
Message-ID: <20240328232009.466018-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240328232009.466018-1-namhyung@kernel.org>
References: <20240328232009.466018-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Likewise, add ins__is_nop() to check if the current instruction is NOP.

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


