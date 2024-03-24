Return-Path: <linux-kernel+bounces-116176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3959889A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83DF1F2ECC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D46D3B7186;
	Mon, 25 Mar 2024 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTdsDpZ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E217C18C;
	Sun, 24 Mar 2024 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323757; cv=none; b=m+OiBS/Yg00jF2opejbcoKL7v2YaN2MmVmScVHMGFfFkZyNYl9O82ZxA6GgPcq/TiZsFOW72O3QFqUBpZ4auuRhgWlwSpleHdyY9Cqh5b78LDbg5PwgQo5rG6eyzJPjPZQoXKlqUdl6hQ91F9vmu261y1QuZHxBLFwY5K7a9JVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323757; c=relaxed/simple;
	bh=3vXI18eSmx91c3I9eECkPkzDJfQ1uc8BQ8OqRe3Mojw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0ZsX+CT8OD+KGQ4aSpmyP+9M+Wv/tXi5kxI2G//bTtmtI7rgf7Bn+P850z5vni8Z1jfv2t1+hcSJW7B0asqhErKzu7lYOUlPSr5TD8MLCXOWwHNiLCTUmu1h3wEkyx+vWGfpagBFA51rFgapO/SZSABjhjy18HblggAR8CXxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTdsDpZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D58EC43394;
	Sun, 24 Mar 2024 23:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323756;
	bh=3vXI18eSmx91c3I9eECkPkzDJfQ1uc8BQ8OqRe3Mojw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTdsDpZ00zDNGuWC+MNSgKpL/5z6OvOVJy2Pos4F3dYVLnQ8KTBcPVkQdPrgkp2Dk
	 3LbEqKdlTR04rqcKdvpRZAXglWms4JpqwvozS4OdedMd/05xJ1Q25UIDDYqu41n+KZ
	 YtSBiP80IdihOf1ngnmanZ9bwpBpdjFypLY3kOUQf5VxYYItTHQ8/GKbrhWBfyRYBf
	 emb+jRILDVS3eSpYRag1dw41acIdpLE50jW7A90gppJka4xmJxtTFicmm5nJcxx8uw
	 NoOs5U5/d+kSl4RXy16GT+jArcOpQzHpUClt099GZksJ1/ZpvT46lww9MFDLHc9XFw
	 bUn8ohK7ZkpUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 130/238] perf evsel: Fix duplicate initialization of data->id in evsel__parse_sample()
Date: Sun, 24 Mar 2024 19:38:38 -0400
Message-ID: <20240324234027.1354210-131-sashal@kernel.org>
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
index 1a1cbd16d76d4..d9a4c0202a8c3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2109,7 +2109,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->period = evsel->core.attr.sample_period;
 	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
 	data->misc    = event->header.misc;
-	data->id = -1ULL;
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
-- 
2.43.0


