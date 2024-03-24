Return-Path: <linux-kernel+bounces-114991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12AF888C65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D921C29EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CEC282B76;
	Mon, 25 Mar 2024 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8o+nE6M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80257282A91;
	Sun, 24 Mar 2024 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323752; cv=none; b=OxCqYRYv2zP9SZsiGUjY5iV6UiTBzyUJT3uyelxM8BrQ+RERDvI3aHLcO4v7KDpjg4848K1z58tjP8ZcA7HAcxVUrsvFcdMkfCO8GEqXM3wwzlxImRZ3TapoLLOA5mP2efWBR6e/LvJSxysByRJk/LVoTR2/p0MsQgmraRI+m8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323752; c=relaxed/simple;
	bh=BBsdOgI7mqDDEImW93zb/FJvtoIILKLC7lgZTgI7w/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZMaqUAKt5vCk8cYw9X39k/kXSMhK9wiYicUUGf88h5ZQ5MKmPWTeP0w0dU3sH7Zz11qJxcwWZ9wxbjETvN8uDOAoVwgBw+EZWFNgtxgCxhrg2wKlRRJUT/sdmxNw2Ae7VNV0nJ6TJBVFNElMG39CFyd25cX9LJkrjQzvWRaqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8o+nE6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02B3C433C7;
	Sun, 24 Mar 2024 23:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323751;
	bh=BBsdOgI7mqDDEImW93zb/FJvtoIILKLC7lgZTgI7w/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8o+nE6MjFc+WzogSrI0iCWmFBX6ZAocNYcAy4kx3rKogz+5e2Ut8yu3KW06rS8ls
	 nTY+W9drb5f5UIJvPZRM1BGvfY8H2AfjSD0sFGaAe9Mjv4XTTy9vLAsodjF0/6cGG8
	 HNN7htlgVKJ59Gc+RHrLwT39T2dT2eZl6ibWK9DPZM5e/im6/pAeatG3Ktpai+FZrB
	 UVA/z4Ia1lMX4cJhugOu8k+ZvqiDMt0PxGWJjcRcpaES1AOYmv8wjHGz/hPNcvyoBk
	 NitujFheoOhAIcM9tZ93Y1vHv6O0lrI6GMF5mGkVfi6t3ilDAOfXMkRr1MzOwnpThf
	 UBoWnLPPaj30A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 126/238] perf record: Fix possible incorrect free in record__switch_output()
Date: Sun, 24 Mar 2024 19:38:34 -0400
Message-ID: <20240324234027.1354210-127-sashal@kernel.org>
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
index e5c938d538ee5..167cd8d3b7a21 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1264,8 +1264,8 @@ static int
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


