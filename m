Return-Path: <linux-kernel+bounces-113266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A808882F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49E51C22E64
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98084136E06;
	Sun, 24 Mar 2024 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcNnduTi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E21189A50;
	Sun, 24 Mar 2024 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320065; cv=none; b=CDn1rk2YbC0pLyXGw2Zi14PsQyIGPDj9rInMLZBpol26d2unlHGXWIyZJfdf4jsvbaBrSpblDbubL9l5GHlDBmrSft1ld5P+aRKnl6145y4tUhOtkpAyRhgSSqCOVLfmwX6Um/BqS0OOOWAhpAWpbJP53CWZMlgZnTKGbWnn+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320065; c=relaxed/simple;
	bh=FT+rCKaxioFNKhY6F29SWX7MZZFV7Geg4xGwQ0Qs/Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzMZ9iYUtXvLfbgku5OsJxBuxuEAGlkEZmBOWzxtIktowRKwbemKPwifLRe2xq6qdW/2qVfr521dgw1HO8Tw1iAYdklG4v7X51vhK31vlb9RPOgxPD3+VdvJ8BD1aHGIW6Mwdz58bixkiQTsibHWi3PikbfeLjE0aW8fUdK0XsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcNnduTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045EDC43399;
	Sun, 24 Mar 2024 22:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320065;
	bh=FT+rCKaxioFNKhY6F29SWX7MZZFV7Geg4xGwQ0Qs/Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcNnduTiJ4RP1lYD9xe9e+V14UilEwk1Ph4ZPsWJtMpi2OX9Xgn7EVfKc7d9JZt9+
	 bJyU8xFAnroLsy3SHxvaXAiCfzJq9Ludu5wWYYHA8OMHmrc9C9gtht5nYdkXNOnvqL
	 8HOYkJy9yo6PnxDbIhcgqrMMfyEB/WZCPxy53AnNRRAzWEfsDUrTDcrvH3MTpuhgjO
	 Gs0J9k/TWAVCBsQdVY9hL1D1WlzNKp76MFhpAynjxeUM5Fq2vn5QjDX5Tq1Fe1YdKq
	 HPCsCPXyK8IK/uF8awWGGj/GKocvZ9Mxg3u007i11mY2kgKsbsYdOgoivEGLzizGC5
	 3soV9yGf+I4ww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 375/715] perf record: Fix possible incorrect free in record__switch_output()
Date: Sun, 24 Mar 2024 18:29:14 -0400
Message-ID: <20240324223455.1342824-376-sashal@kernel.org>
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
index 86c9101251726..a8dfa533c1663 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1830,8 +1830,8 @@ static int
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


