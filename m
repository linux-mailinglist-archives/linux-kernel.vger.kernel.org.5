Return-Path: <linux-kernel+bounces-113818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E778886C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE191F253A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641151FEC66;
	Sun, 24 Mar 2024 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr6WlFqm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A161E6F64;
	Sun, 24 Mar 2024 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320860; cv=none; b=gYicsmg1kgkDd8psNP+EhXfCdHZqZzZ0uDhcNXdeChA+3B7VOLQP6VjcH1mq87Ek3MDhCUxCOweBFdJib8bBx4BJLGF3Kq4SQQojN0yjc1zFdBaRIj1W2q8O+oAwjqGStAYeuolSiwcHE0Jir7/OvXCLGWwt+w/Y9rdr0xPYHYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320860; c=relaxed/simple;
	bh=jx0xK9bQSIqIXUTuzqS9ze3n8taOEz3hd/Ivco0cQfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2O/h93hMHmmlwgkYtqo62G6oVJA03tlDkyaCbkdf/mnDBh2+6NxMid/BkCC2fC7vnjC5GKuTtWv3z81v+ciQFnWSkE+6NVUVVoA3KLP5yKpZyd5qiza2dryOVTLlj9baih0CkPZlT5ndrA/Ob4dlavA5YzGYqqYBMYcTxouTW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr6WlFqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A457C433F1;
	Sun, 24 Mar 2024 22:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320860;
	bh=jx0xK9bQSIqIXUTuzqS9ze3n8taOEz3hd/Ivco0cQfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hr6WlFqmvzUteE+tg1DnH4t1M7RR+n0/NshgTFciMMVPnYvX1GglTK9eSmligqoQs
	 th/T4895wKtWE2I5Up7oBde4neKNN0zIHGzQAM0U+zapRWnqvVl1luCysmVSsqwPbi
	 dttmdcmtEdNdn1FyPjlq4RJOoidKp1qt63w9INtsxQzKXJDdwke4FTRFA37AVzK7/I
	 y17+utY9xQeoNeZUeNdpak7arg8wf95F+V9uJf6+c0XiseyShmguV5/S2tqmAJH2k/
	 wFwok1Xz2saUdWtCpsPY/cxjNbCOQ3Gitr1V1t9YjjMYDamB4XNqbt4BHd9vVwH2FT
	 rDsn5jnQlaCSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 424/713] perf evsel: Fix duplicate initialization of data->id in evsel__parse_sample()
Date: Sun, 24 Mar 2024 18:42:30 -0400
Message-ID: <20240324224720.1345309-425-sashal@kernel.org>
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
index 72a5dfc38d380..1fb24ca8aea52 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2340,7 +2340,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->period = evsel->core.attr.sample_period;
 	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
 	data->misc    = event->header.misc;
-	data->id = -1ULL;
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 	data->vcpu = -1;
 
-- 
2.43.0


