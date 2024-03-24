Return-Path: <linux-kernel+bounces-114302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A0F8889A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1400289A06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86DF16FF5B;
	Sun, 24 Mar 2024 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdOBSyyx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7A320FA88;
	Sun, 24 Mar 2024 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321681; cv=none; b=GcKk8pWnIxsrz2SRdeBVnjZbazlgZ01l156qw5cc4tL6mGvSSJcT4y+Q3Hng0ZkAU4XQoBZ+R94pdXlzIFs/iJ+Uyl+bQMdhZUE7sBJ49UT9AYID7PfgvMf3+a1uLfHS3SvXbaWmNjGLULyPV3SqpbxTZ10C39pG7tpv4nHrC9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321681; c=relaxed/simple;
	bh=GAnoAn7uiepYlDBYHoial6Tx6Aoa33HVjdMC4Xd30z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5Hk/vuZ5tb4Ru9G2W97H6VOc6xbMkN0tkR5e2hmAaFAsDWESOpyiJMkQ6Cgtw8Ls2zaFcMCikcVkpDddyy5v94XM0e1jqHS7eHL9l1ynLPnJ0tz+cQ4LuHaSVOT/fsE0avwTjpu5v1KjvH2TrHflCZ9KGUXf8Y4FeXpq7x+yPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdOBSyyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C42C43330;
	Sun, 24 Mar 2024 23:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321680;
	bh=GAnoAn7uiepYlDBYHoial6Tx6Aoa33HVjdMC4Xd30z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TdOBSyyxpGUhVlX7ChkddqjRCo9rcx03/zCegVh0bULvDo9UVHf/lvUTGRZPBE21n
	 OQR8dFV2kmQsbHuJPQB8O0X+csHVM1H+CLJknLx97+25rZxIaaayr0zjjXQFmlEg72
	 +EsyIqnHGm7ytzU44H1noY4SQLSDGfJsmQEL2nSScA90fS0R8wI4YuBOSDNSzuZ4i+
	 AiF9a58lUtlRuaNhAcu7zBG2PyOi7LsKbz71XowKKeyTV4aQTMoCik75jKuY5Wh4kZ
	 VZfllAaf/h2/dp2+ln8QNyka/2vVjPLwu9gStXXzkAlgGsdgDtIT8j7TM+GZaTNryI
	 Zh4SDe0U6aLMw==
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
Subject: [PATCH 6.6 409/638] perf stat: Avoid metric-only segv
Date: Sun, 24 Mar 2024 18:57:26 -0400
Message-ID: <20240324230116.1348576-410-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index afe6db8e7bf4f..969ce40096330 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -560,7 +560,7 @@ static void print_metric_only(struct perf_stat_config *config,
 	if (color)
 		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
 
-	color_snprintf(str, sizeof(str), color ?: "", fmt, val);
+	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
 	fprintf(out, "%*s ", mlen, str);
 	os->first = false;
 }
-- 
2.43.0


