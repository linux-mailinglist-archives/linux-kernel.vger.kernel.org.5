Return-Path: <linux-kernel+bounces-115123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D1888DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 012F2B2ADF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A1D1C68BF;
	Mon, 25 Mar 2024 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm4JNcHh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862A181BB0;
	Sun, 24 Mar 2024 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324119; cv=none; b=NU4/Ms9ox2OB5sBRs76AMcTWl85psK5HUa4bn5QethZcNJRpva2aVjT1EIwUE1f7bB845GpQ6qFDAHxPMVCjfwRiQc4VHeuwID7HlCcMOyQqWKdweJ02npcNcsBWFeZARnSs8kGkhbhtg3hAQ9giBMb0bqmSuwlpbQEpZIG6VTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324119; c=relaxed/simple;
	bh=H1DRja2vG1RvFtLkCWz88956tO+zY8aW6fwwiJvu+mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsTPVfovQiS0HBxftSlI901La2o0I/YCJkPGs51HHHUvVdP6uW7PycMVOfTDJOXzom0M8MC2hQgbZBvYpIYWNoV2M82oKBqAEdOcr5JCUbQASz7bUBdQIeuUOmr17r8t6fJ9Yqo2JVyKIz5sM7gZ0boI+VnnLrIowRKuMMDRlOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm4JNcHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC115C433F1;
	Sun, 24 Mar 2024 23:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324118;
	bh=H1DRja2vG1RvFtLkCWz88956tO+zY8aW6fwwiJvu+mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cm4JNcHhiP3gIrKXQeEFtbe13A8bTsM8Ay4b0appCMw9LAqzZZJj42uJ6ZvL3PKLg
	 /B+OhgnxKGzYKEaWDmtfOvhX+L9ON1aywbV9ud7ZhS96kdOZFzsZerzGVk7ymsMjyE
	 6TATYLA88t7dCnVrSeXr8iLo/mwSv5nQBEWLXP7T+9Va3L90mWNCn3tpv4LpZbLcqn
	 p82tv9ZK4kNp6v1owlZT3LoM9iL6qsI5xjeAyJENU4kZ3AciN256LfOeo2a0Bd322c
	 i+9Jt06yE0+S3bFhzEc7DQiP5LzNbyu4Xa1NZwrSwzzp5i8I3SbzbYk/WrANwdkknt
	 3SpysiKMfQEuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	James Clark <james.clark@arm.com>,
	Kaige Ye <ye@kaige.org>,
	John Garry <john.g.garry@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 116/183] perf stat: Avoid metric-only segv
Date: Sun, 24 Mar 2024 19:45:29 -0400
Message-ID: <20240324234638.1355609-117-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

[ Upstream commit 2543947c77e0e224bda86b4e7220c2f6714da463 ]

Cycles is recognized as part of a hard coded metric in stat-shadow.c,
it may call print_metric_only with a NULL fmt string leading to a
segfault. Handle the NULL fmt explicitly.

Fixes: 088519f318be ("perf stat: Move the display functions to stat-display.c")
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: James Clark <james.clark@arm.com>
Cc: Kaige Ye <ye@kaige.org>
Cc: John Garry <john.g.garry@oracle.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240209204947.3873294-4-irogers@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e18c26501a7fe..70612ec583f35 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -263,7 +263,7 @@ static void print_metric_only(struct perf_stat_config *config,
 	if (color)
 		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
 
-	color_snprintf(str, sizeof(str), color ?: "", fmt, val);
+	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
 	fprintf(out, "%*s ", mlen, str);
 }
 
-- 
2.43.0


