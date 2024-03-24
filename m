Return-Path: <linux-kernel+bounces-115472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743418893FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F904280E64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8739223460;
	Mon, 25 Mar 2024 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyPSh0lJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055CF1E962D;
	Sun, 24 Mar 2024 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320895; cv=none; b=Ycp4lHqvBoKS2KMOEjLw+OuGmyV7LXk6ivzYynQ7EALE/pQ9znwG5M9M0jdXuz04WYpobM53pC7auG5JDiUMyt6Tb7ZgvMEIqrTLNf8Gno3mMfjOD3XCy7CcuxUFsXLjegfN0qjLOX7JE6jrdrGlxok8IeXDGcWiBZslfo31HVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320895; c=relaxed/simple;
	bh=GAnoAn7uiepYlDBYHoial6Tx6Aoa33HVjdMC4Xd30z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TD8jruBgQVOan9tZEvpW9J4JY6ZmugEUJ43gs+68jZT5P2EWce5Wu8VUmZl18CuVgX2xc3qNNhkVv3vxP/FTTjEn7KiHeXSWyn+E9fQQkr01oLJtfWGBzlWcijqXkPPqqJXVZXDH+QRjBVBsYKGlKshPYTStbxlfhMZbG8WGnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyPSh0lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607DCC43390;
	Sun, 24 Mar 2024 22:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320893;
	bh=GAnoAn7uiepYlDBYHoial6Tx6Aoa33HVjdMC4Xd30z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PyPSh0lJ7ho6fBaoUe5lMbkYkucRNUC2ywsrsSL/oYMdiFIJ3GX8Tnfy4jBn7GJW4
	 rA3nyn8n2LyT8stNYQLviWP7nESnknt8xbXonH58CgEBFC2InzJR/zOpBY3NcX6iwB
	 l3s9ZVwx4zLlVZhSc5k89yj+Kk0xHIq8GnOQaGcHpPsxhdfdcUAI0ydYpFzJuOLeFH
	 Ou2Yk1GSE0t9PB3LfnpCqf9Ug0U3DmfvTxsH2ZQ2stOgrhFZzjjrRz6P9Chtsq7ZdI
	 MWEiKW/rJYqw8kpeTQF/csnane2e6RUWrgTxlVSzh+FHAwRDxA/ZFToXche0r6pqow
	 fByUmcU9nyNKg==
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
Subject: [PATCH 6.7 457/713] perf stat: Avoid metric-only segv
Date: Sun, 24 Mar 2024 18:43:03 -0400
Message-ID: <20240324224720.1345309-458-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


