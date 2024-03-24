Return-Path: <linux-kernel+bounces-115120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BDE888D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CAA286F07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3522FD891;
	Mon, 25 Mar 2024 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO6UHQW8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3454181B8E;
	Sun, 24 Mar 2024 23:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324116; cv=none; b=GsUGrEQsozKDkhJcWZsU93KAkF14NZ7nrnRKkN/S421HrcRrY7nG7wrC/RIN/2i8ubfdNA4w4LQHftDes3tRvvxAnPHxosSbyLgUlN0IerIpXR9PKvedCO17wQxZUm/VEe7H+bTWh9exexocKpNQk3BEFktDEjW4Qo0occQI1dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324116; c=relaxed/simple;
	bh=ch4msB6QbAfyxOHVuIwLakn8UTa3SdoazWxzYOmU5xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjiw05bMWz67gNe+3Jkwvh+2bk0XYAYkvgtbBgueWasyMMD7V7hCOqDgSJ7IezuW3zk7h/GbWlzHHppOk6zGdpvGKkk71LtM/UBX76oJ91E0uzaWDogrYqpx9JX2iSBqwMnMbvnW+DPPgvllEAYL79/RVIHgsasNx5ZacZcKXJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RO6UHQW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13589C43390;
	Sun, 24 Mar 2024 23:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324114;
	bh=ch4msB6QbAfyxOHVuIwLakn8UTa3SdoazWxzYOmU5xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RO6UHQW8+83koF5R/hPr26UZj4BbpxSxzL57T0niPnjzuzEWe/PSwhnK/cu57q6BJ
	 qZ26yxB5wYhecDaH2eNOz7Qw9Lp4rKyr97E0zenhpHzMdKEDA/vQbfCtTRk8yXR56R
	 LEyoB3w879CIDJ7kE96Pj6RSU/tM4rX7Xa17mBKBS8a3SdFlqobdgnuZNpGV7kHedr
	 QjKfko7UMERUzTUmRl5m9RmE930Fie8TLhinoEAVL4+OKvm2nzLuA9ipmwDWUNL41r
	 5FLdIUxBgu8KFOkPvbYw420pqqzGNbENEtQHS2R3UyMeLlL64OfHHYnB7nalGDMUNf
	 hkIh3iAftaE4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 113/183] perf thread_map: Free strlist on normal path in thread_map__new_by_tid_str()
Date: Sun, 24 Mar 2024 19:45:26 -0400
Message-ID: <20240324234638.1355609-114-sashal@kernel.org>
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

From: Yang Jihong <yangjihong1@huawei.com>

[ Upstream commit 1eb3d924e3c0b8c27388b0583a989d757866efb6 ]

slist needs to be freed in both error path and normal path in
thread_map__new_by_tid_str().

Fixes: b52956c961be3a04 ("perf tools: Allow multiple threads or processes in record, stat, top")
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240206083228.172607-6-yangjihong1@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/thread_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index c9bfe4696943b..cee7fc3b5bb0c 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -279,13 +279,13 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 		threads->nr = ntasks;
 	}
 out:
+	strlist__delete(slist);
 	if (threads)
 		refcount_set(&threads->refcnt, 1);
 	return threads;
 
 out_free_threads:
 	zfree(&threads);
-	strlist__delete(slist);
 	goto out;
 }
 
-- 
2.43.0


