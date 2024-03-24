Return-Path: <linux-kernel+bounces-115010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD725888C82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7271F28FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDAD28454C;
	Mon, 25 Mar 2024 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUtxAvbg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F017C633;
	Sun, 24 Mar 2024 23:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323773; cv=none; b=n8FDOY9K9FxwcWsI0G+HmxhNfOrJIuPUJIMEjRMqNktjzheHrjUQ2oNNDiVqJzbaOHHqeYccy2CSzER/HHe0IQS3p9SvCtzLc/Lvm86sU89LGkAhtTZcFhEioOVN3Pm9wSQt1xuosGmn0JG+2ABSSddpoPsgNkq55etlB1zvVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323773; c=relaxed/simple;
	bh=ca0imnJ0XN7n6zN6CwXaDXAmr8FI9wwTvgmmP41B5Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cknwwCIbShzMhvlKVhIbJ05tMeEeIXgTwaGI5BFlfIKC7+/s6eUxESOpg1YQDOlSPXpjOhfM8AoFYxKX0BrMTrK43RJzIKWA8AfKZ/99VuwaFd7horhqjrYSYueqJZMRa9fLhqhrhlDdAgt4y8uzIYU96VLxHmzDliTPttLrqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUtxAvbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AB4C43399;
	Sun, 24 Mar 2024 23:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323771;
	bh=ca0imnJ0XN7n6zN6CwXaDXAmr8FI9wwTvgmmP41B5Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EUtxAvbgxDTlZQKqge8hGtvJoE0exRDyJ8Ioro3+UNYgCehY91VRvdAzaAorWDdqI
	 jYSlRzcoebEpdZAIx92fTtPvpoxytYG91lWpUsjrqXr3MTIdYrpaIq8d7ukIXyB89m
	 t6bJX0EC7rQ2FfRky24HDq/DXm2HXPhSMxeBLZtfSr2e0GXZa7CdmEXdsxrAkDqbEC
	 Rluq6Lw0Ln5n6So6kVkMTAg5usPQ6gVXy+y1JgFwzYXhJaGAgQhrt2gxycpsein8B1
	 pENLqFk4k/U6VFXY7rhA926RFW3tVst7yhI4GXeZD6iuKKAWGuykxxtAh8okEOt2AF
	 8Wzc1TX8zv4aw==
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
Subject: [PATCH 5.10 147/238] perf stat: Avoid metric-only segv
Date: Sun, 24 Mar 2024 19:38:55 -0400
Message-ID: <20240324234027.1354210-148-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 4688e39de52af..971fd77bd3e61 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -271,7 +271,7 @@ static void print_metric_only(struct perf_stat_config *config,
 	if (color)
 		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
 
-	color_snprintf(str, sizeof(str), color ?: "", fmt, val);
+	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
 	fprintf(out, "%*s ", mlen, str);
 }
 
-- 
2.43.0


