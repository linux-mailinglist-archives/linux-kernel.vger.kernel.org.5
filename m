Return-Path: <linux-kernel+bounces-112074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DE08874E1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E79B21DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7A28288E;
	Fri, 22 Mar 2024 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqM3YORh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB71CD00;
	Fri, 22 Mar 2024 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711147395; cv=none; b=nnh+hHq+NTJOjf3s4MdMKScHvrTJNBLLcgGiuwuU1pcDLBDJAVyBo1geheb4tXk/5++k8UpRSUHDENxA20y3kgNZIx/K7Bvn+T8TcOjEKqbEdClVFu31kA6Ki/VlyMiFVxAwyt/nwPQR5ERIUW7AfGEEccNBGWbBR1UNrdP6ObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711147395; c=relaxed/simple;
	bh=b4WPQIYm0LiVsWLdyPz+BXKQNcM2GtF3moecr3y79iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEQah8QFa1TP4LjstCAReOgONxk8DaRrP8o8adxwAIMKXd2Ajm9LC7Y9giXXqs7o8rqkGFy9Cl7OIYahWiwRiQtolMvlXFQItT9M0iAfHFek5uLitv5EHLjN38YMBxnsMK74CmbPkgpJf1X1th84S9pJPqAMWZhxNfBZspOEpnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqM3YORh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1992DC433F1;
	Fri, 22 Mar 2024 22:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711147394;
	bh=b4WPQIYm0LiVsWLdyPz+BXKQNcM2GtF3moecr3y79iQ=;
	h=From:To:Cc:Subject:Date:From;
	b=UqM3YORhM0DAWz5OLfdhBqBCy4JtQLKQ3luQMCcLB3qMTVK/abbT2QsJh5PMETJIT
	 iNkXGFT2LKy/tEqZ46T1uBBtyle3AOFJMsbW+E2Nf9k0ViEh89OpKERyDh/LbuIiNZ
	 SObGXY6WP1zLv/nr2BytR6y58w4mkEICc/BnkLWoLPF8pB2fIZuunf6Eze+Tu5K3/q
	 uQ6jW324TPDWbbdU+E+BtadeZhBBDMFBF3ANU8eMAH3BcHYLdh/u+qvM/9HV2mXk5b
	 FN0Zo27IZiaOfsBCQa437ADWtQ6zV+jrhvo+JxZrGH+B2qpOXMJGa3Kb814qM63zMx
	 pOgOZpQ/sA0dw==
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
Subject: [PATCH 1/2] perf annotate: Get rid of duplicate --group option item
Date: Fri, 22 Mar 2024 15:43:12 -0700
Message-ID: <20240322224313.423181-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The options array in cmd_annotate() has duplicate --group options.  It
only needs one and let's get rid of the other.

  $ perf annotate -h 2>&1 | grep group
        --group           Show event group information together
        --group           Show event group information together

Fixes: 7ebaf4890f63 ("perf annotate: Support '--group' option")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index f677671409b1..3e9f7e0596e8 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -810,8 +810,6 @@ int cmd_annotate(int argc, const char **argv)
 		    "Enable symbol demangling"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
-	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
-		    "Show event group information together"),
 	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
 		    "Show a column with the sum of periods"),
 	OPT_BOOLEAN('n', "show-nr-samples", &symbol_conf.show_nr_samples,
-- 
2.44.0.396.g6e790dbe36-goog


