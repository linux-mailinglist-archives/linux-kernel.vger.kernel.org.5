Return-Path: <linux-kernel+bounces-113304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F94C888342
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBF52847B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE209191790;
	Sun, 24 Mar 2024 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9XGTGUz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B34191774;
	Sun, 24 Mar 2024 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320105; cv=none; b=liLxz8c9vWDXK3AjiU1yB0icG5HoX+WmvBkXmoUWkSB/I9rXJXfQZ1iKPKbrk1L8JPM9zcqKCqE1bGQOGfVV5ClwOgmAJ+untpjYcXzdiuvjiDlmISekyZ/UEZGM+HRag+P31mJHA5+bzP31D66YuqPIJmgaMN8Wh2uNHCuOjm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320105; c=relaxed/simple;
	bh=QbjeDjnPkJo+H8tCOpPrb24g83W7AuUV2r8hVSR8c/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tV1IJsS9hQqv45Aspdj7xYPilBwDlZkzt+ng4147zEDIFRUpDCVD9vj26BxQ7oH+S8jUKCfSzMJkmYaV3ZXMCe52LQxKMU6FoVm+5iQrM1ZwXMUc8r/jdjmRUC/fGnPbhepDg4Mh1SCv2cn20tAgS3oCJ4yV7m2fZMZQ3P7+pX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9XGTGUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCC2C43394;
	Sun, 24 Mar 2024 22:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320105;
	bh=QbjeDjnPkJo+H8tCOpPrb24g83W7AuUV2r8hVSR8c/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9XGTGUzsrNCLqNTw1FjT/8KGYHcZ7YVV2nV3DdtXbgP+aa7jrCXJTMGR69Ebtq7X
	 qPFP6FjsuMr7r4O/7nbFq5ErzVUT0W0mRkSZ4Hisgn7YrbejpRw/8XrbeqU0NquKkT
	 N/WZDWJ0jAxTHX5BxR6SSV6ZRZmCBC8sfnIaBqgMsiWhJizWVaRSWSh/Dihj5eQpYr
	 Pc58JeeA4gI4+0UwLF4z3p2zBVQpvZ5HjTa6if7KOxpyup+BtxH8ftOLqOaJDI7sVr
	 oJDuGonF29+k9IJ73JGYE0JJ2irHF2B3dJTBUuAO3fD5iWkffSvziIqSLT2g/QBfta
	 wijCoOcjjhEbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 413/715] perf thread_map: Free strlist on normal path in thread_map__new_by_tid_str()
Date: Sun, 24 Mar 2024 18:29:52 -0400
Message-ID: <20240324223455.1342824-414-sashal@kernel.org>
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
index e848579e61a86..ea3b431b97830 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -280,13 +280,13 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
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


