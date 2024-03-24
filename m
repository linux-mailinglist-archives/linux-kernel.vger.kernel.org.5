Return-Path: <linux-kernel+bounces-114297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1448889A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91271F32508
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44402613D3;
	Sun, 24 Mar 2024 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4dUv/e5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284C1386D5;
	Sun, 24 Mar 2024 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321670; cv=none; b=fR57oeneilTzkQzdJyucWMv78KeOnOhA+S5zKuJQUGYjP3WZ2EKPIoHuQG4NAQ4BKrlW6YA05D1mIlFoVmayeV2w9SuhB+zyTNfd4w4dhZ2dO8tHMJ2JwvaMeCcTsZGhUGm3V8MRfOfOWO+Hp+yqZbdpptqxADBzL5VVHjhChQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321670; c=relaxed/simple;
	bh=QbjeDjnPkJo+H8tCOpPrb24g83W7AuUV2r8hVSR8c/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8SZ1fr/Fww28dSBZBSYAm7w9sf/Riw0o6nyTRI9j4DcENfjxQoZvhdLo5U31ZD1aevRoYeP8mp3h4YGcZCWXuXJRbmy456Gs+n0NaEL6KKb+ADarK5NQlcLf08WneLJmnIv6CNrLsn1OmPy8zYPb0A+i9lqD2BMCC1/vx2BHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4dUv/e5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CC8C433F1;
	Sun, 24 Mar 2024 23:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321669;
	bh=QbjeDjnPkJo+H8tCOpPrb24g83W7AuUV2r8hVSR8c/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4dUv/e56Xt/b7iLriwAmJXcDOQX62a3htxjN0z9Np9t4iXwYiAPMOnFf2lWB+p5z
	 67w6w1RcgE8b0Y75EqWFhOhLco3Q8b8F5UYnggMuZFYDdswW8bsDl5AJoK5cbECETk
	 gpMZAvh83Ja7rNR0OsHpL1PcRJD+Hmg6r6d1skLTAtz9dgbUEmY4ryYy/vyTp6SHRB
	 2F3r20OtDdCkleHg77t8I7jaJXqu6Bga8IO4+bEBAHueS7+z8uKhTO79a05IY8fbY9
	 R0Tv2xB+Dt4CsY++IWz8SA0Wr7aMfftiWUzuijLxM2p4W5vZ7Iufbz+DlWv22UrjCm
	 /CmiEbssLbpNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 398/638] perf thread_map: Free strlist on normal path in thread_map__new_by_tid_str()
Date: Sun, 24 Mar 2024 18:57:15 -0400
Message-ID: <20240324230116.1348576-399-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


