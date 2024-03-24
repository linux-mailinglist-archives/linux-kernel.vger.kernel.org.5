Return-Path: <linux-kernel+bounces-115229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A2889364
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E541F30E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBA5757FE;
	Mon, 25 Mar 2024 01:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6OZGS21"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8643C184EE3;
	Sun, 24 Mar 2024 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324328; cv=none; b=PEefcilEkjU1k5L/A/Vi4PJVoUUCobfj/R5JIsAnnenUGToKTUWSg6kKniynlE6HH7YfyJ0lPf1XsbZOtFxg2gAyR8hMjmmljTcsjW56rea94+AUxwmGIOGys0E6evtM+JUg2odjTkYiB0ENrfUaO5CO+Ib+bSV6vsRnAYk38pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324328; c=relaxed/simple;
	bh=FSd3R12bw/igCt1ElSZBvFnCIQDWQqoLxORK3/TtGwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQ8O3xxoM4NeW9vBdmZbV3axvveieMS5KL6SAnYstnqEl06Ne8O6i9csxngRrLMTig9r4ZZUzZMiFGNP8D4uFu3c/W7yp/m3umlrgQr1AQFYq9fSRyF380liieXpGJ6KSR/3RYTt4V1MDXQMcvA6Ju5V21hlScqHYx8ceOqcl2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6OZGS21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965C7C43390;
	Sun, 24 Mar 2024 23:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324327;
	bh=FSd3R12bw/igCt1ElSZBvFnCIQDWQqoLxORK3/TtGwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6OZGS21zDHzjUL4+Ro1p0+idV9c3t8u92q23rvNDnR2q0bGYBp6UwPeTvi9senaR
	 aCYRX7nvNqJqRS5U6rUh1fu9CCkqYKF+WMNGFpaLiLsyz6/jqBHkonZIBfuupD8Bas
	 11byWe0J968PK84ZHRt4shosXVE3XatLoPfP0HIepRHANRJyfkgJW+43K+Arj6KTmj
	 xqJcX9gcuCzaeYXruvZTfxHaH9V6y7H1lgdKk/X8kM2/CguHln0kZzp3hCPBOH2hAK
	 czLJiKIuzRfxBKTwKq5pHQUz6Vc/7wRqR5+YMQvsVkndH2PlR+0YMI9oxxfbi/7Hfm
	 6KoGTAzoLamnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 098/148] perf thread_map: Free strlist on normal path in thread_map__new_by_tid_str()
Date: Sun, 24 Mar 2024 19:49:22 -0400
Message-ID: <20240324235012.1356413-99-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 5d467d8ae9abf..6ee38f2458040 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -313,13 +313,13 @@ struct thread_map *thread_map__new_by_tid_str(const char *tid_str)
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


