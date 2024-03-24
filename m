Return-Path: <linux-kernel+bounces-114549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C67F888B03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB84628B982
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D4184322;
	Sun, 24 Mar 2024 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxp0kCJu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CABD1FC97E;
	Sun, 24 Mar 2024 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322185; cv=none; b=a+teTTb9aDUdvDfDYX0sgwH1hPSf5yZvUYv2PNq02nIB9FIjoHrIsGdqEXn6y51Mtca0QW5Ywp/OFhIgPScomtYfLJv3GT0L8sobCCMy51pox1rSPEu9xwD6mdK+ZaKhzDDt9NoDiwr0aBekbhoFuAOPZuoqsd98+vfEVvq5GDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322185; c=relaxed/simple;
	bh=s5G9SyYvaSF3IDSDoqV16NIoamNss3JTyRG4TX3xICY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bACjBIA3GpJ03EhzRQqqiskb0m8muScp7fXirXCGw0mYXZsvDwm1IozH17RGJLfVPgV4IzCX21v87Ziolx2KciPSbRDqnIobS86d7XcTvdwgn9/qJumk0zpHZhQ6gqALRAPpdzsYPTuxLVIUkWvnl59nuchd8aaJdsaqrsD7mpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxp0kCJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2A4C43399;
	Sun, 24 Mar 2024 23:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322183;
	bh=s5G9SyYvaSF3IDSDoqV16NIoamNss3JTyRG4TX3xICY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxp0kCJuXzTZEoyGy82JceiGyTCHj+95wUeBS1ogrgeJWDHUeFoJJnHLobSp9b2St
	 MqyEPO5YeG/WQRzXTUHV1jiQav9JJeLGeuoQNbQ8s06o5QN3QNQzc2gzwKoT1Foc3+
	 l7uXmJjzLyi9NYQqQ9iBe5ypPJaax8z+IH+Ov7KgfvnRnh2AAGzytvQwMGNNLXC3wq
	 +9Y7SYczemxZ1z5AFnClQz2yAkxdFz35FqhDj7be+gSdCNYYYbQONzWxga4lWtJtoz
	 0wBfHF11qZ6EMsTejR8PYHCw6cGAO12N/a38NZWELklGd99x1j7jPee2I8/webO33c
	 HG5vcQ14sHhTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 262/451] perf evsel: Fix duplicate initialization of data->id in evsel__parse_sample()
Date: Sun, 24 Mar 2024 19:08:58 -0400
Message-ID: <20240324231207.1351418-263-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 76605fde35078..7db35dbdfcefe 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2375,7 +2375,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->period = evsel->core.attr.sample_period;
 	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
 	data->misc    = event->header.misc;
-	data->id = -1ULL;
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 	data->vcpu = -1;
 
-- 
2.43.0


