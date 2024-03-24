Return-Path: <linux-kernel+bounces-114841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0044588926B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A4D1F2EBC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2788127989B;
	Mon, 25 Mar 2024 00:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixw9U5yN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDEF13C662;
	Sun, 24 Mar 2024 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323477; cv=none; b=I2/FnJUJ1EGR3BCEyDcsiDztfXayt+Krim7dSHPDreJI69Ndmn9ymZYWk955FtONRJnygf3aKxGBeiKrAfbSh5rYK83hud/U6MBO/5DW1By3kO9cn6DE00DQjZIGRiC+BPUmzpjv1SYyg53HfdT0wx6VAMWxu8k0BsdTskdM6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323477; c=relaxed/simple;
	bh=lqgJ4pjtgnbZVl4rOq7wjtiKpzEeNfUDxzln4C2LXAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmpwpdyvNnzchxp3QnRCuKfQZsT5YtkAz+1alrUfHZjv472ZWTUZ1tETLEdRHJ3MdwnelvJ1iKU1QzB3mk2ezCEy4iCj4+Xyve4Cf9/Qs50tCzxVkkxS5MCVpSNMcaaUJRHQ270ngJ31e/Rz0A0FmSNuLwB9XSPBcWF1tXdQFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixw9U5yN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E21C433C7;
	Sun, 24 Mar 2024 23:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323476;
	bh=lqgJ4pjtgnbZVl4rOq7wjtiKpzEeNfUDxzln4C2LXAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ixw9U5yNhdfqKo78dN2T+npwgeWflu/Ghl/o8E3l5utHuOkXz6Rw2xcioBu2mHWIa
	 DeNgy562wK4rUTjUkXSevWgF8E9hfHyvAzcaucyqTMjv1fyTwuQG+Bc8SOgaIdCrZi
	 t0Q5ypChB1YiWtDPxdhsZr3EFJjoGm3POrOTrflgVKtyaT/+11krbdclXD96uN84AV
	 yLVJmlUBBn0lJai0ElLOH9UC65o2Lf+c9LTpCAd6VyGf2wq3oXAkp2nQXcAuz9uP/F
	 J32xrxbi/jipJ/s9roOpUcsHh/m4MPB9qAWouES6/GWoFSIzHWu2y8gkGSxAZTL/P9
	 YtW/Pe0mOZKZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 180/317] perf evsel: Fix duplicate initialization of data->id in evsel__parse_sample()
Date: Sun, 24 Mar 2024 19:32:40 -0400
Message-ID: <20240324233458.1352854-181-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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

[ Upstream commit 4962aec0d684c8edb14574ccd0da53e4926ff834 ]

data->id has been initialized at line 2362, remove duplicate initialization.

Fixes: 3ad31d8a0df2 ("perf evsel: Centralize perf_sample initialization")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240127025756.4041808-1-yangjihong1@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/evsel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c87f9974c0c10..c19a583ca9f66 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2252,7 +2252,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->period = evsel->core.attr.sample_period;
 	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
 	data->misc    = event->header.misc;
-	data->id = -1ULL;
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
-- 
2.43.0


