Return-Path: <linux-kernel+bounces-115006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7BE888C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC7B292354
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742E91C0C1A;
	Mon, 25 Mar 2024 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnwZR92C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B7817BB3F;
	Sun, 24 Mar 2024 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323769; cv=none; b=YoqmUTzEu1XwQCDT0+/mumuv69FIVnfW9KQDpvI9AhepYiDrW1J2h95XK8YlFOouzJzOfIAjSOfWLCb9skBgFP+KF+f5Jiw00NRGJFFN/UOPct8CFdEZIM6e3sOCoUmQ2yRRruOQ2sqNX6KPmlhLHRqhSJp4VXcD6YnKdHz1Fw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323769; c=relaxed/simple;
	bh=ch4msB6QbAfyxOHVuIwLakn8UTa3SdoazWxzYOmU5xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6pUJBPHH/HkKVEsKGmf9n3/VtIv+9XHxXXC1AStMPkR9ZJwhbP4LzgOehSvxZc7KSFu87PLJfOrxXezK/xNGPrTpC4tVFE9ZDrgECBAYUMSXwzVyFTe0XqBJnzYfkf2rmc/+vF5CDMzKRSpyIw7E68gNFHqpqdvBFJV9qPDybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnwZR92C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10F0C43394;
	Sun, 24 Mar 2024 23:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323768;
	bh=ch4msB6QbAfyxOHVuIwLakn8UTa3SdoazWxzYOmU5xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnwZR92C2GP5EfL8mdj3TBE1MtIYrBcGljlZjRyso7bzMswZ7Tmw8cVN4GtAUs4F+
	 XDXMS7y8ShCKjLdR/aWebmGAQaRJ+jn2bwe1xOcBwwAor2tZHCzaUtd24ex33p7cP4
	 VlIuiIiggznSS9DIjpdE6nYQrrSn8cDpBbO/YzCmViCCu9NpJy49LgbQwnLnGEq7xM
	 gzGNgkH0bMHOqaBwxr49ra6lMc4IuGaaWtbht1cHmbw1eN/ngReFUliw5xVBbC2wbo
	 A3vppgc2qToC1RnmzmWlk/t5oiraq1mPUeprm4xtgfX0YbsgzTgegNJh6PSxR8gsbP
	 lmCTg3rV4iqlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 144/238] perf thread_map: Free strlist on normal path in thread_map__new_by_tid_str()
Date: Sun, 24 Mar 2024 19:38:52 -0400
Message-ID: <20240324234027.1354210-145-sashal@kernel.org>
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


