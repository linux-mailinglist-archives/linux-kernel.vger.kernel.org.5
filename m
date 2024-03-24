Return-Path: <linux-kernel+bounces-114571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DC588906A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2872910A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722B713C9B5;
	Sun, 24 Mar 2024 23:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI1TASP/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556DE1FD5BF;
	Sun, 24 Mar 2024 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322209; cv=none; b=CqpP853XPfcSQGH7/kKBjtVooK+nMe2nfTcxGLvr0tf7LHbrERxmYhOYpT4u0AkRkgw952sB/2wdWBe/1jmD1vFJ9guA9L3UPf5j4srOcc7UQCchvPVD4iBYD8dYfk6PW5h+aXqQqctKSIB2TNRIgruBRuw7hnS7MFlO1QUxoUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322209; c=relaxed/simple;
	bh=3Jooysg2d7dUW3AZXTUrMFQ11QszUv+fKMskEuERJz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0xigfLXJOnhCkiML5XqiDQ5+qBaeZopzx/6rD6Y15ys6GFvwsR0kw+Q7gO5JuGeckX7BuP7q3UmqKgkm2qshSooom69F4w4cBC7t5JhmUfULLyWuiNg3HvMmi8XuWbodAZGYoBMW4SMRVqlhcKgLl8LvsXJqQ9751xPCnEWWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI1TASP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2097AC433C7;
	Sun, 24 Mar 2024 23:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322208;
	bh=3Jooysg2d7dUW3AZXTUrMFQ11QszUv+fKMskEuERJz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QI1TASP/iQbggKpA912jHpjwP05ZmVQt7h0n6S+jl7wKEEzAerBb/M3oqCIn4Qcbn
	 Dp0TObQCD0qTFx+DeRX2528u7Rzdcay+R8jaU4N6XApwGsWFiMSfDJpv7bwiBMgPWd
	 qv3WN0IB6Zr8mi4o/GdZ4he2mSidZIUxVQjS3r4uMD7ORMeeZcuVhsN7ddimHILGMq
	 3+yEth31oqyiMU3I+oRYwKFZhc4UP2kQBCOR4Cp7qYVBtqJ6sxCOgCNCpfTckdSn1o
	 0FK4ChtDtwc5UvSX2p91WoLKaNkPCbldKrmx0JsTHs/eeo/1+fCZrfP2UBySpC9PwB
	 J0GhbrwoRVrSQ==
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
Subject: [PATCH 6.1 288/451] perf stat: Avoid metric-only segv
Date: Sun, 24 Mar 2024 19:09:24 -0400
Message-ID: <20240324231207.1351418-289-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index bc866d18973e4..ef9a3df459657 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -366,7 +366,7 @@ static void print_metric_only(struct perf_stat_config *config,
 	if (color)
 		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
 
-	color_snprintf(str, sizeof(str), color ?: "", fmt, val);
+	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
 	fprintf(out, "%*s ", mlen, str);
 }
 
-- 
2.43.0


