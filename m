Return-Path: <linux-kernel+bounces-115215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E03288935B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0951629AA18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8C51CBDEB;
	Mon, 25 Mar 2024 01:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmAUavp5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC322E7F3;
	Sun, 24 Mar 2024 23:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324303; cv=none; b=poCgRhD2Dobz9/YF932BQaljxbVKGU+hDe6u7mtbbuzzbQLSq1FoxPfniDa6pbpsKpAmxTG+bgEEktmIOSERtkIq89qTqKh5YXZaEfmQBpeRtq4BSW0AUJcglG2CdWV0VppimX0EXa5vbP8I3pebyF8i0DphLMQyKGLWdFCezKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324303; c=relaxed/simple;
	bh=6gbpBif9goTkU8krONbkMQJBzcRlkeg/lr9CK6CErfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDU+xAiFA7SuCUKI/1xyorLgcLWynW6g5+OT4bx0lKE4QAFCgIYKx8+6PCugnhe7buUL8/+MEnkRiUX5pYj9d6DYY3ySxw43ec0oh/eBL8edwasWfQaVhbLUUKps8N2L6e5XXJqdTQApgTqWfXqFOMhawwlNeEtZfHnnkvRV87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmAUavp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD52AC433F1;
	Sun, 24 Mar 2024 23:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324303;
	bh=6gbpBif9goTkU8krONbkMQJBzcRlkeg/lr9CK6CErfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmAUavp5225H+Qc6XrjoqP43EfTkxZHXUgs/aGeTwufKoI6/stDrOLJh4DbbjmHLg
	 u7Xjee+O11oJ0Kb5Dn09TJ86OxUgMa/QgszFBKuc6TcKX3UQIjBWg4r+XJJWAW5OpT
	 rqGoyL++FjoSuFanD/YvIH4TqqQIMv1z1r574pLmkMx4iHG/2uoSc/ztQO9f4pLA+f
	 DvGKvs2QoXaCXqGssWFNP7+nQ+C0hNFtp5J3qp3CrL5aBmo4ac29rj10xdVwquYWEI
	 fUIvqvRHijfjeU1GhqwRJn9RhppkyilrPc/pCFpwDmcTmZvidRPmlr8Vx51PG3O1ud
	 rq/2U+SlKlKOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/148] perf evsel: Fix duplicate initialization of data->id in evsel__parse_sample()
Date: Sun, 24 Mar 2024 19:49:00 -0400
Message-ID: <20240324235012.1356413-77-sashal@kernel.org>
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
index 11a2aa80802d5..0644ae23122cd 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2116,7 +2116,6 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 	data->period = evsel->attr.sample_period;
 	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
 	data->misc    = event->header.misc;
-	data->id = -1ULL;
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
-- 
2.43.0


