Return-Path: <linux-kernel+bounces-115100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61336888D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92FEA1C2A989
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752821C5838;
	Mon, 25 Mar 2024 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaP3Ixi3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32228CE58;
	Sun, 24 Mar 2024 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324102; cv=none; b=h/Gp8tNxiZgljKWfedcaIPlhJsJA4kpfxFIxe7qXXyAcgDm5VprDbdUFteXy+hYCuJ+e9cmjPZ5ylorZ4C3M29cFodtDI6UAHE8U1hzpPt+shn3KFMVb52Qknpa7M5ITIxM+UBUCebMZaSMdje5Axq+fvzE+8tUz4HIWgLE6Ecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324102; c=relaxed/simple;
	bh=DM3144Oh7P+rTj9j/aPXAQpmxvre+5VOHDnvu7WjSos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tic8dGaTmDdcR+i33Yyr10KI54IAvPYDqC+T92kl/6Sr4Ov9cES+pTayAsW/xd/8yrYR4bRNLPQRt6b65Ty97qvYpMLDyjMAJ3dnWGD92Obbj85ixVHtpR43e2geCl/qZYU3Q3slM8NcL8/eeZVgz8cOjC2Me9bUDqf3tYHo93Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaP3Ixi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD232C433C7;
	Sun, 24 Mar 2024 23:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324100;
	bh=DM3144Oh7P+rTj9j/aPXAQpmxvre+5VOHDnvu7WjSos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CaP3Ixi3H98OZ1RcpRgEPrUlXb1r/bpt8X7W1fhbzQ+exTFsHMnHBnoBpTdJ92zGs
	 uE0YAcLvCOQwcCZrhgIfJyCofAUIp0U1J/tIdbZzBM3GMFVw8c6IFBydagYHyjt674
	 bGABQWgMnKZ27jdgJNKUMCy6+JM1hhOXszjkS7FLZUxQ7IYYovRWuGZVLEuSWK/CQ+
	 6XrL6NxvVQyWLok/hZTbIpMlUFQBt2ut6dxVFuzDLew3P6UyHO2lldVkJUSByEV6s4
	 gs9wo711Uur/ecR2+wmImVVbzUGJQ/6OghYviJaDc1Fyr+W9wGkM2IniMqmsX3TzAr
	 CWRZWajZjoT3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 099/183] perf evsel: Fix duplicate initialization of data->id in evsel__parse_sample()
Date: Sun, 24 Mar 2024 19:45:12 -0400
Message-ID: <20240324234638.1355609-100-sashal@kernel.org>
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
index 9dd9e3f4ef591..cd1eddf0ab371 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1955,7 +1955,6 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->period = evsel->core.attr.sample_period;
 	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
 	data->misc    = event->header.misc;
-	data->id = -1ULL;
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
-- 
2.43.0


