Return-Path: <linux-kernel+bounces-115473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316C5889BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B9B1C33BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEE222346C;
	Mon, 25 Mar 2024 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxoX868M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C0B1E9638;
	Sun, 24 Mar 2024 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320896; cv=none; b=Isw03EkZDZeuYyLWvrISrNJhLNAX2K0EjSsZErZzyrSbohJFv0sBvDIVQAyDHJZij7PzyKbjAn2UWaHb6IKBFVuZzKebKje8t2DUkaTPrST9yiWvosiENv04Ol2Im6wcw+Mo5j6uHQe8mPc41IXQkjRVALCyf+QNSCvuU1I+o0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320896; c=relaxed/simple;
	bh=WpXy2LNVlErVoZaptWzqLxI6KmqPSeSQU3Pgz6DJJ3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWaw62wQ4fhVjJYDmxW6TU0XMslgG/mxldhW4B+0SiWw5tC4HZu1chNSzdOYaocjEEB6Sp35QtHlGP5w/CIvkSWhdCJtRYVq51akYoGuARH8m8oriE+g5AlgCWrZA8fPOBOTNu54RIuv/nh6iDWqf9b462Gmbv8BTfZJILIzCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxoX868M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296A1C433B1;
	Sun, 24 Mar 2024 22:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320895;
	bh=WpXy2LNVlErVoZaptWzqLxI6KmqPSeSQU3Pgz6DJJ3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IxoX868MdWqXBhCLh5qvLEvP+FsuuHcaSF7s5qH7SBiHisVm2y8VCO+S0ZO0/z56N
	 M3LMkW529w/U7Oauk+3xaJwKw/X4U/BozlPmsY0JAM8BTix2okGB3+zynAGIm+o1ck
	 DDqobxulQyg0AJahjr/Adv64wv8bpBM3w5l2JXwpeGBgXtMAEsFrbGCSFuzC/vyqYC
	 JvAuSWRTiMyHqlPY1XUi1ihSsLfGv9Jf3L5ZYRsIwJ83WP1CImuOHDE3Fsm8ADycwV
	 Gyaj8D2kPHKpK7HnYej1rqJeP2wLKMaFbC05Q0lISHiuE0VJA6JDmLgrcejVoc4uKu
	 S0+WlGQIKOd+A==
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
Subject: [PATCH 6.7 458/713] perf metric: Don't remove scale from counts
Date: Sun, 24 Mar 2024 18:43:04 -0400
Message-ID: <20240324224720.1345309-459-sashal@kernel.org>
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


