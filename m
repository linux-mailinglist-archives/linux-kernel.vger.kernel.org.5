Return-Path: <linux-kernel+bounces-114837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF81E8891A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5751F2DB1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE29C2C40D9;
	Mon, 25 Mar 2024 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X85ew9iV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928827986B;
	Sun, 24 Mar 2024 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323472; cv=none; b=PT5UiXe7QU7SVOoNJyBuBzcfrRKzclgKcQgfmFsdbHuIis8iCtA9L3meKRVLxwhojr6Ycvif0x3ZyJzlWc6DrxISOyUBby4llliQA1thl10OsGl+okV5Qt5emZENRJKBJ0Hh4HtvGvkFPlVshqZiNtEWFNc+5kM4oyrrh7H2hFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323472; c=relaxed/simple;
	bh=FcV2LyNeS5NvwWQZ7eNEJWAEk+UQUWpI6/3m2Ohd3jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRSogJQtmqPIU7Uqw7080RV+YjGWvhqzQw8DSblGKMD4Ro4tDFn0Zyj9QzbwMExLLoKztU9xPYf0jRLXFQcJ0gGSsnyt5l8I+Zj//13nqbUF0WhwyFmbt/w38doxwRp6YSTZ+zhNiE87Z3nkdKO/zYRyDKmVYxlPF7KGeiKueuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X85ew9iV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AFEC433C7;
	Sun, 24 Mar 2024 23:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323471;
	bh=FcV2LyNeS5NvwWQZ7eNEJWAEk+UQUWpI6/3m2Ohd3jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X85ew9iVlj8+LxYB/HrSmDrJcmjH3CUN9iyQpTFd2EBepWH9YzwCEqsFEHsiZigQy
	 lL+zTJcRU4hmfZDF38ykO9aUslx4+URLP5mtKzWTtDOJwAPR+UA9S40HB8D4t/+fni
	 UGQ2AULXPxKEgVM8vxvHDllA3o6D2ZFvet8II0StDO+IHr1E7BXCtouUZ0Ufnjk8oU
	 rZD7i4wt1sNLGXs0ZUICj4mmzVUXb/jpCSsMQDJ7ErOTlBVQtAsj+RklKVqLSlE+Vf
	 FeazBJhU0wPUvZCx94CqRBsPGEKrBxkHOCHGnx5cfD0SGkaGKOqmRMtWtoPScIG16z
	 PhptrTAqaKBCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 176/317] perf record: Fix possible incorrect free in record__switch_output()
Date: Sun, 24 Mar 2024 19:32:36 -0400
Message-ID: <20240324233458.1352854-177-sashal@kernel.org>
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

[ Upstream commit aff10a165201f6f60cff225083ce301ad3f5d8f1 ]

perf_data__switch() may not assign a legal value to 'new_filename'.
In this case, 'new_filename' uses the on-stack value, which may cause a
incorrect free and unexpected result.

Fixes: 03724b2e9c45 ("perf record: Allow to limit number of reported perf.data files")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240119040304.3708522-2-yangjihong1@huawei.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b3509d9d20cc2..b92c26f6aa1d7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1277,8 +1277,8 @@ static int
 record__switch_output(struct record *rec, bool at_exit)
 {
 	struct perf_data *data = &rec->data;
+	char *new_filename = NULL;
 	int fd, err;
-	char *new_filename;
 
 	/* Same Size:      "2015122520103046"*/
 	char timestamp[] = "InvalidTimestamp";
-- 
2.43.0


