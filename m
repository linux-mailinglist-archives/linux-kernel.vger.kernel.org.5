Return-Path: <linux-kernel+bounces-150142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8CF8A9AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF15B220C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3AC15AAB7;
	Thu, 18 Apr 2024 13:13:25 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421513C3FF;
	Thu, 18 Apr 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446004; cv=none; b=Yatd20flO+134NEr/e9dNhqpB3WPndUL3V4sO9uD4DnJVdmww4e3FMr7JdE+CqA1f70aDcW2O9KIRVMU6d65I98pRkrMhCEyRWUhfInd9GAxnuUrXAsIYJZkflXmPyLKJRIPHM1sFevHkn/7RDGfGM2vHtbdYHoiyACaEM3Ixns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446004; c=relaxed/simple;
	bh=FzJPan2NAFjCC04AmFBOdGDeNlf6oAypFIRmzBRbrQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVFBgV+zhA3H8M0oFgzp2LTKNaZDCBd8AYbYd8aa+qE6xQ5UZUGZuX6Tvfz/2ro1eMGJlz476/EeWfbQcNYClMfVHLo8U0OvuRfEtHRHpIqwg0AMHxAJiEGkrLt/dO3k1OYUHJNcB6DzJwN62HDKRnl5wfwD3gFJsJ0DlOR0/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VKynm6RhjzNsWj;
	Thu, 18 Apr 2024 21:10:52 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id D2DF214044F;
	Thu, 18 Apr 2024 21:13:17 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 18 Apr 2024 21:13:16 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Changbin
 Du <changbin.du@huawei.com>
Subject: [PATCH 3/4] perf trace beauty: Always show param if show_zero is set
Date: Thu, 18 Apr 2024 21:13:03 +0800
Message-ID: <20240418131304.3188385-4-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418131304.3188385-1-changbin.du@huawei.com>
References: <20240418131304.3188385-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100011.china.huawei.com (7.221.188.204)

For some parameters, it is best to also display them when they are 0,
e.g. flags.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-trace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 19e81a467d6a..349550b02f79 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2086,9 +2086,9 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			    !trace->show_zeros &&
 			    !(sc->arg_fmt &&
 			      (sc->arg_fmt[arg.idx].show_zero ||
-			       sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAY ||
-			       sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAYS) &&
-			      sc->arg_fmt[arg.idx].parm))
+			        ((sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAY ||
+			          sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAYS) &&
+			         sc->arg_fmt[arg.idx].parm))))
 				continue;
 
 			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
@@ -2790,8 +2790,8 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		 */
 		if (val == 0 &&
 		    !trace->show_zeros &&
-		    !((arg->show_zero ||
-		       arg->scnprintf == SCA_STRARRAY ||
+		    !arg->show_zero &&
+		    !((arg->scnprintf == SCA_STRARRAY ||
 		       arg->scnprintf == SCA_STRARRAYS) &&
 		      arg->parm))
 			continue;
-- 
2.34.1


