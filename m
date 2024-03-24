Return-Path: <linux-kernel+bounces-114562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C86E88905A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FA92919E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D59185208;
	Sun, 24 Mar 2024 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFLZy9ZJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786C22E175;
	Sun, 24 Mar 2024 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322200; cv=none; b=mWMJb6hKRueQLbVdh+hs6NkKY3UWclogN2a+CBLWtmhYA09/9PudcPLEqtjjP85T7M1kdL+6LHSEl3kcdabfWVwZE+Bf5FCC7Q0x6Tov8j+MUUrFRDmKnCGExYlls+fBggsRnKJeB8bbEHxBys/abpE2+kV3TBVuJnB5aGbK7Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322200; c=relaxed/simple;
	bh=ch4msB6QbAfyxOHVuIwLakn8UTa3SdoazWxzYOmU5xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9t6RoaKPkMoBdVHDXzSpV2eYl+sMaJ7TSZXsITY4n92PUMnpPGoXOnYhwUXyJ4i1dcROAmPruknynyxm2poHv2Wdp/sQDKHUT62zTMX3YodB6e2RToNt8V9Q6yKK0hU8d38elk8kZP/XJVGnIalVA340MwRgmcXfvEjFr1I7e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFLZy9ZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF43C433F1;
	Sun, 24 Mar 2024 23:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322199;
	bh=ch4msB6QbAfyxOHVuIwLakn8UTa3SdoazWxzYOmU5xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFLZy9ZJR35oSV1pYcv1gUJAcV8XRE7AZFhgrgEyCL2ZdX8eMT9L+NI7liqq66C76
	 Kji6ZASuS8wlE5v8cFGVqX7Cd/Ry5zPhm6cBkBCHm6SBAJLd+xo1TDf48qTM5SmN41
	 2QHv2RV4YqUv6kjviGhbQ0+Hl63sBkCUNUA+SRV/VPU4+qA1/tT/DFkDLzYjn4o876
	 ahJRJ0wqQbS8HwkkUiFkw3I7slOWeDWg6YU3fMgXDaNdrEIPPE43MaZ7zqemuWEVEJ
	 v+fzanFKLR043lkGxYeheJ9lRNFiKky0ctPQ92WU8LQMQ9a/Teu61WPZUoxo5t3LiZ
	 crqQyE2z4Vh+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 278/451] perf thread_map: Free strlist on normal path in thread_map__new_by_tid_str()
Date: Sun, 24 Mar 2024 19:09:14 -0400
Message-ID: <20240324231207.1351418-279-sashal@kernel.org>
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


