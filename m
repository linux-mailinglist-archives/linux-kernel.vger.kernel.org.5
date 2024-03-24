Return-Path: <linux-kernel+bounces-113281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C60D888311
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABAD28693B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0EE18C9E1;
	Sun, 24 Mar 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOUY25by"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1C18C9CA;
	Sun, 24 Mar 2024 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320081; cv=none; b=ViIz8Xg5ArxbTF3NAJHBUABYGNPedELGHYULlH8DKnUg8M7z4tpQGS2q8zt1r0S5JiFgmI3x/4wiBj6l0VMff9ZVuL9M/aHBl6tWC1NNqH/7/4ZKEYaeIkeLieGc6y6kBL4sSNLaVfhL4fmtrq+XDpQKq+HFIrxlAxDTFe6dqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320081; c=relaxed/simple;
	bh=PoyZnFczcwt9O6M6VXmc7lHJigt0cR0l+Qp9md3dErc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqNGUmn78g4I2cg80unTIqHv7LJJOJk1g82q/YpDd88cxPLa0z4eGGBub7k54Me3jnGCw+9Hdw79pDgOKef52Q7Z4A6f8BJQtiGDeltQaDCg+AJQQBqzfoG1X64X5o6j6J0AqI++H3XwN/XhNupNXEjIGwgaUvsQhCVuU6k5Ax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOUY25by; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56BCC43390;
	Sun, 24 Mar 2024 22:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320081;
	bh=PoyZnFczcwt9O6M6VXmc7lHJigt0cR0l+Qp9md3dErc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OOUY25by674rOdH3uLeGdijZkulZd09uNyGF+ARvsKI+3Kc9AxQhKuJ6JJHrHNI58
	 GoxnItkG7r6Z7hjyZK67eQFUgzsurV76V3SqNMU/qgLLkB0sTeOpGEl1v2jD7nyEVM
	 mR1wZo9cYsAQpEdkAyWhWtIpdpe03sYmUYO5109hlyEhbWDahCL9VcHnnAS2EerLM1
	 tnEbMRMcSW9DjDYo8/jnqCf6Bq7VFmrXfsZ4aiOfncw2T9t8aDbtiBmClEurl0Jq2T
	 YXWZZA26Q4klQ0mMXmX7YVN+uEfawksUfaQjqgE5/K+OZZFhQ+tfOnxM+arUWU+dCp
	 9+UUljAIx/zJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 390/715] perf evsel: Fix duplicate initialization of data->id in evsel__parse_sample()
Date: Sun, 24 Mar 2024 18:29:29 -0400
Message-ID: <20240324223455.1342824-391-sashal@kernel.org>
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
index 6d7c9c58a9bcb..727dae445da9f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2363,7 +2363,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->period = evsel->core.attr.sample_period;
 	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
 	data->misc    = event->header.misc;
-	data->id = -1ULL;
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 	data->vcpu = -1;
 
-- 
2.43.0


