Return-Path: <linux-kernel+bounces-159353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02568B2D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD60E1C21D06
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C02156657;
	Thu, 25 Apr 2024 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us0d8LYI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49B156230;
	Thu, 25 Apr 2024 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087019; cv=none; b=I37wACBaJw00yTP9mbdWI2Hj0TmMjpnw8G1mgGUkrxQzLHUu2uUukiecui72blCOXYSYXFASCCHlAMil/76OB0mC6vNPGKvUm84T1o1+RRu3QWyxZtrn4u9c9632V3t5ApKCwmOH7GYQYvIqZiETA5Pq09gCsnjaTlzqdiZWa/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087019; c=relaxed/simple;
	bh=nvOjsG5VqPWXEiyRE20YY+xwf8zVmtXTntJ6G4y6H7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vk7AQ5nAHSpG6lbW878NSpcUrQpmeRfYS0ZhP6+cylX0MhxamBheVPJtMwUPk+zSNlJucKgEMrppGUIa0MhDAVXlzRmyvEMAGtJSwPv2r4hgO/YCrxyYEmBxRTKyS3lqdxvNZIpat0MWDBIaXLt4PBwJM9adaIuHQf8SjJKgU/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us0d8LYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F1FC113CC;
	Thu, 25 Apr 2024 23:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714087019;
	bh=nvOjsG5VqPWXEiyRE20YY+xwf8zVmtXTntJ6G4y6H7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=Us0d8LYI5olvRkRcs+ySMzvA7NvNkty+iIfcZzJuFzHG/C/Da0GjIJgZv/QJWpFe+
	 DNm0CLQ12UyhSG7/50LDwEeUeKPoof0wjNb0v06RT7k6JhAvMcfIlQAMIk2XZk4sPu
	 xdv5lOfYqpyOSuJajAaTJl/dy4N101PjIqcGn3x8vaDv6mjDySKNIcfc0pf9ipQLQC
	 XQ4tis0Uf9pC9xr2kPoo5JtO4FmD4F0SJjGRR4v7Kowd9OPlchJbqbQ+HU9M2obKiE
	 j+b0kgJfNPvQBB/VFWtDoBu9YKiEjcxfuiNaOMoNy0z00yqRANtmrAupWHV9/Q7Th9
	 gGU6O4fOzZfFw==
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
Subject: [PATCH] perf report: Fix condition in sort__sym_cmp()
Date: Thu, 25 Apr 2024 16:16:58 -0700
Message-ID: <20240425231658.1201237-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's expected that both hist entries are in the same hists when
comparing two.  But the current code in the function checks one without
dso sort key and other with the key.  This would make the condition true
in any case.

I guess the intention of the original commit was to add '!' for the
right side too.  But as it should be the same, let's just remove it.

Fixes: 69849fc5d2119 ("perf hists: Move sort__has_dso into struct perf_hpp_list")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 704664e5b4ea..af845d0d418d 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -333,7 +333,7 @@ sort__sym_cmp(struct hist_entry *left, struct hist_entry *right)
 	 * comparing symbol address alone is not enough since it's a
 	 * relative address within a dso.
 	 */
-	if (!hists__has(left->hists, dso) || hists__has(right->hists, dso)) {
+	if (!hists__has(left->hists, dso)) {
 		ret = sort__dso_cmp(left, right);
 		if (ret != 0)
 			return ret;
-- 
2.44.0.769.g3c40516874-goog


