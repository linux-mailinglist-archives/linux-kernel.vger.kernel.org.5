Return-Path: <linux-kernel+bounces-114852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCAA8891BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223911F2D1A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2BA27989F;
	Mon, 25 Mar 2024 00:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK1KXTAV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3C5A7AA;
	Sun, 24 Mar 2024 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323495; cv=none; b=nqNaiKII4e69UHBqGUtKAEz5J251uZQWLHevqgPQSu1tA+z8t2poeNs48QHAnSMxBpncg9pFG/1foVHsPcXZl6PnkdDkRB5J8zmlLuYxVhmBFCNZZ9g0hw47ZkNJSYjotYWW7mRRy+gN5OikMaeNT5MflhNm7UFJIaxontzkmM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323495; c=relaxed/simple;
	bh=FR9iFq0oFXyS9NTUKTwHsIX+vwgMzeAlE3rBx35uoko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcSEew5UpFgrTC1yh7/+tWRDcviKq0tZJNO03PjhOXOdt6y99OsQN+qHmXxtmbN9VavO9kCwCDs0eqX87gy1rEhMPoFFU2npgJiDcF5rIy6cVg2sMaWlrQ6LrMGtGcMYkPiYGM6gfnVUPJISgkLbKmiX7Av+2hTyWyHRf1uEHRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK1KXTAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E584FC433C7;
	Sun, 24 Mar 2024 23:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323494;
	bh=FR9iFq0oFXyS9NTUKTwHsIX+vwgMzeAlE3rBx35uoko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fK1KXTAVfOvZe8tOom6ZvL6eRytiTBcmy3DtGj8lM5iW7RZ9yoCM2Zyf7xE0cSw/F
	 S8T5wRjTKAiFVrj+NAAGj0MHZX7M2InGG0AYteylMt/8Q1qwzA3lHKcersUY/CksEF
	 orGcWoINNiOsJ4oxj4Sw1D7QnizqMO2FR3mVyjR46JHalyKpecETD3S+4KG+/5MM8y
	 QaTBPFgSFF05H7LK3w/5AF98hJG3d6iXSWBb5bZ0PNyP0ppz6CTkWd3WB4lq2jELfA
	 XlmS3c9sY8Yb+qDI0fe2iw7/6GB56knBqJ6OI276rDUnE6s5lQfPhkjDEBFjGmJKaP
	 bWNGH1wbJ8PXA==
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
Subject: [PATCH 5.15 199/317] perf stat: Avoid metric-only segv
Date: Sun, 24 Mar 2024 19:32:59 -0400
Message-ID: <20240324233458.1352854-200-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 24e50fabb6c33..5ed20e1e09aef 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -275,7 +275,7 @@ static void print_metric_only(struct perf_stat_config *config,
 	if (color)
 		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
 
-	color_snprintf(str, sizeof(str), color ?: "", fmt, val);
+	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
 	fprintf(out, "%*s ", mlen, str);
 }
 
-- 
2.43.0


