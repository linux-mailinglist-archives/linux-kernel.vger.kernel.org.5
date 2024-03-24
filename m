Return-Path: <linux-kernel+bounces-113836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FA98886DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF491C26000
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CEE202B8A;
	Sun, 24 Mar 2024 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAI2Gvcf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D21E85B1;
	Sun, 24 Mar 2024 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320882; cv=none; b=Kp4s+SzO63YVMaSgUR7w9LZ4fZt7JZf12MopwUr0np4bzYp6gJdDckLei/Ahl/FHjXQwDKhkKB9s0C6Kl3MKuP1mHl/ThqjfOVOpYKtvSDyfc2NP11V5Ll9RYv68hxeIJNrmuYeXyz3913ksE2u2LvUrp/i7U04QWbXNN+o34OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320882; c=relaxed/simple;
	bh=QbjeDjnPkJo+H8tCOpPrb24g83W7AuUV2r8hVSR8c/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZtYEHXLh91YB7Oot1lPU3zuuGsM0BO8eUh5kIDrEyESeeeVu1Hd8/8maTbfhefZ/4oAKjBoFd6w4iz/dYAGJ7RSowWsJboqtcfsE/fsGQ+MXfBgtE6z3Of9tFHAN8syc3W4hOKqiqo98SPLp6E8PwXyjS0HzkWOsCUpCj0ZStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAI2Gvcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9CDC433F1;
	Sun, 24 Mar 2024 22:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320881;
	bh=QbjeDjnPkJo+H8tCOpPrb24g83W7AuUV2r8hVSR8c/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAI2Gvcf8B1fatzBc4YOeywJ7PuHlhlZkzCCGoCy3QYGBzTKMyxcJW9Pjlv0aHkYG
	 aB0gYnsH46UXicksT9BDBoFhpEPAfFmd9mUq5TNgqhALFe3WaBLXWLuL3kOXJdbUFq
	 NmUi5tn3Hqxcpa+wc+rdbWDs0zbUIv9axMYD0ovKf6RWtXKVpHDhdShwCMpAmehnxo
	 rJJzsnRO5W7n+Xagcvc8pMWX+kjC+17yNLeetVRG0bweT7up7Gi/lSDIdKY3HV0yET
	 rjHatVLxb7EwJkkl4DdpBDDEGMzvQfiuZz/ZPly9U1DmQsqRxRtJuJrYUfi5z7/Hm5
	 So0K/NmgiX3ow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 445/713] perf thread_map: Free strlist on normal path in thread_map__new_by_tid_str()
Date: Sun, 24 Mar 2024 18:42:51 -0400
Message-ID: <20240324224720.1345309-446-sashal@kernel.org>
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


