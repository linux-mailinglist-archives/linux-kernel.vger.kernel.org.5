Return-Path: <linux-kernel+bounces-113317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228C288835C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73A81F23C25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402A6193FC6;
	Sun, 24 Mar 2024 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWAqSMIs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D427193FB1;
	Sun, 24 Mar 2024 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320119; cv=none; b=RXIFYKUPwv5ig9nevmJe2Bh0Jo3ZuHDsvyrwEtwuq77qvEtWRp/3AYZOgfZDxudMnadExtQlhO1olLel9KU0ZLCkSwZ4KZHfSeFFqKWwZ0CY6dS27xKa3gAYSrIsueuzKzeGyq/Hu8FPzVScKMwluw9W2m7FDAYKqDAFXuMOZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320119; c=relaxed/simple;
	bh=WpXy2LNVlErVoZaptWzqLxI6KmqPSeSQU3Pgz6DJJ3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uu1M0DNmL9G1btSiyM0+Ftsx+YID+RwwDUYgD/OSbg4HaaNQMp7mYQ9lJY33u86DHZSWZopMkXiSwx4fDy8+c0RVjE+pQRhwHoz3KlgwWnHFlOkVuGVM7Glazqd66yhpkW9rh6LlNMZWERFCWazDkeTX9+D9H7FOUpjPAoz/A1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWAqSMIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4103C433A6;
	Sun, 24 Mar 2024 22:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320118;
	bh=WpXy2LNVlErVoZaptWzqLxI6KmqPSeSQU3Pgz6DJJ3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sWAqSMIsHcc08MxhQWa982uH5HtE/qXcypqg7MFJ/ofcN8IgJPdC9SdQWDKRC2l9w
	 KitvpZScrWZLXuZaUVsVcEc4pGxy3Zv/cUMP4zoTkXBmJU6dFokMHe28p3NwPBCBUX
	 B5YG+XpMrxQMr9LDy2T8x/lFduTgdGeGhvs4EHxnExmxL0VA8r4kHjLQWLGvpSSgZI
	 1FMyv4fed8oLv9WmVt0Goqz/3yRYG3Q43nvaOe615dRRB4NUG+cqJzpHk9gHff0EQb
	 mqA8s3QbhEjhGrYEVDnVvu2bMyn/Y7ok/+DpCDOcSwBfGprFU5Y8+4airiee6IswVk
	 rq2TzC2J9onFg==
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
Subject: [PATCH 6.8 426/715] perf metric: Don't remove scale from counts
Date: Sun, 24 Mar 2024 18:30:05 -0400
Message-ID: <20240324223455.1342824-427-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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

[ Upstream commit 6d6be5eb45b423a37d746d3ee0fd0c78f76ead9f ]

Counts were switched from the scaled saved value form to the
aggregated count to avoid double accounting. When this happened the
removing of scaling for a count should have been removed, however, it
wasn't and this wasn't observed as it normally doesn't matter because
a counter's scale is 1. A problem was observed with RAPL events that
are scaled.

Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather than saved_value")
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: James Clark <james.clark@arm.com>
Cc: Kaige Ye <ye@kaige.org>
Cc: John Garry <john.g.garry@oracle.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240209204947.3873294-5-irogers@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/stat-shadow.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index e31426167852a..cf573ff3fa84f 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -414,12 +414,7 @@ static int prepare_metric(struct evsel **metric_events,
 				val = NAN;
 				source_count = 0;
 			} else {
-				/*
-				 * If an event was scaled during stat gathering,
-				 * reverse the scale before computing the
-				 * metric.
-				 */
-				val = aggr->counts.val * (1.0 / metric_events[i]->scale);
+				val = aggr->counts.val;
 				source_count = evsel__source_count(metric_events[i]);
 			}
 		}
-- 
2.43.0


