Return-Path: <linux-kernel+bounces-114277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD33888F83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A758D1F27131
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E029E20DB69;
	Sun, 24 Mar 2024 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB2EJCvz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249120D5D2;
	Sun, 24 Mar 2024 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321649; cv=none; b=kgDQ0bYAKoefGaj5lJGLZds+WIWwiB+8d02F65PZASqPlpCGoRm7BznllfK1RPIfiuModSc0HVo1j2k7NCH9Tj6NRdKYAKEYcYwFVPVI3BYiXxSroHFAlfo23qv7lLeED8T6P1POpsnt8mukl56dmxwvrct2CYIUuBJfEYgsuW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321649; c=relaxed/simple;
	bh=exBUztv4jQiK9QCdarVk8mleKrG+kqbYAMlkM+o7oTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUcqTdmml+jJrPJfHzqxYX/L6z2zU9khyxDMOeVh7+6Pg3NbxHYRWAMkA8PVtXdQJTProXsfLCEGTXcNAV1KO2t3hZzYYvx1K3lwfJb9IerstfRZoxjE+K7RlyMsj6mINCgGo6ODp55hNhO9WF9xO8mopOm4vUg0LEuHli1p5yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB2EJCvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23056C433F1;
	Sun, 24 Mar 2024 23:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321647;
	bh=exBUztv4jQiK9QCdarVk8mleKrG+kqbYAMlkM+o7oTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NB2EJCvzy9jkcPt6MjBOrPoH8RRocFQjFgDsfoCB6LgiUgKlOhUFYOSqKiGtDHjYl
	 ZrvUbt2Dnqi9POW+V4vmbBZCQlY55oLujI8HX+29EhfF0/ngEE5EtKMkBLYUn7goKa
	 z79jP5Ylm0kmX4imcR91KhYav+euZDnhjy410+tvs96VtNy4vdUjZ0Y9OwyrfKuG/x
	 QoYjLe8jQXDx8BcUgTePfqzRrMxX4LEN8B9ozebzpnW/CLgDl5MvhQTtJyiQs52V2o
	 u+eYU9iZOpRAbQlotJemjBfO/BI2Ia4aCJo+tQiP+ZWs57i1tTe7z2Zh3VI2cxxftx
	 e5qyzV62eM5rg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 377/638] perf evsel: Fix duplicate initialization of data->id in evsel__parse_sample()
Date: Sun, 24 Mar 2024 18:56:54 -0400
Message-ID: <20240324230116.1348576-378-sashal@kernel.org>
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
index a8a5ff87cc1f7..6d2b056232f6e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2366,7 +2366,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->period = evsel->core.attr.sample_period;
 	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
 	data->misc    = event->header.misc;
-	data->id = -1ULL;
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 	data->vcpu = -1;
 
-- 
2.43.0


