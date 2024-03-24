Return-Path: <linux-kernel+bounces-114343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADB2888FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E955A2902B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38204171667;
	Sun, 24 Mar 2024 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTjQBoNk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C041213453;
	Sun, 24 Mar 2024 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321731; cv=none; b=L/L/9iOR/Fa8TJTmyN0lX3ULhLJ9nPZ8JL2yFcmS3LDH2RCFdbyq8LERs3xQ0hwQQ/9zYCul9LtrnLhFbvvffBq7lHASTGb6FcaWVB+uAaYb8EJQCBnpbjTuV4a8hXEy2nitEh0eMhOaHMce4plLhZ1no1pEf+P+q6jMurCL7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321731; c=relaxed/simple;
	bh=0AF15nQ0mPwJN2Ne43cMsDMShEoe33XKgcwOIbXWDkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WI01+ZaOXMuhXRanaWYruyF2Vfgee+Z6y3TM22wb3ScalVWRuI4BLre8JvIhXkrarMWQSvJqAH0cLBwCjjKMdTZdkG0J87fvcoNafvMtw/+QvgxD3LYc5pt3a3q3qEHf3Xz4SPzbYyebYT68FMh/MCCjEnyRvk632ATadAAiFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTjQBoNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19758C43390;
	Sun, 24 Mar 2024 23:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321730;
	bh=0AF15nQ0mPwJN2Ne43cMsDMShEoe33XKgcwOIbXWDkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TTjQBoNkJgmgwBqA7MtQstLeQJqISxUiKgEpUT2vzLkiDsC2dIARq9+SNHzBJWX/R
	 0XKFF+TpXuFlVIvfYgF8fe0QYYl45uSpCe9ZYOvGagorsAHHuywtRlme+/55gJm74w
	 mimFBYXQlYteVWXVaA9LjwEeK2CQxuW/Phfs3iX+CEox5WeIcW9gJ0m8pAIs+bTNWl
	 EbWeNqIpBcw3Ip6BUqSfF9H/4duA4G0lKXm3YpitReNkN5ZI81NOlS3zkIV2DJjjYr
	 oSu80vFwdZibhzKJNne0zi/DzK0Ip4UhsxKRTxDqzWikg6ERJlUKNhHCyZqKJz0ovF
	 EUviF4Vj1rhVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Ian Rogers <irogers@google.com>,
	kernel-janitors@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 458/638] perf pmu: Fix a potential memory leak in perf_pmu__lookup()
Date: Sun, 24 Mar 2024 18:58:15 -0400
Message-ID: <20240324230116.1348576-459-sashal@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit ef5de1613d7d92bdc975e6beb34bb0fa94f34078 ]

The commit in Fixes has reordered some code, but missed an error handling
path.

'goto err' now, in order to avoid a memory leak in case of error.

Fixes: f63a536f03a2 ("perf pmu: Merge JSON events with sysfs at load time")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: kernel-janitors@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/9538b2b634894c33168dfe9d848d4df31fd4d801.1693085544.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/pmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a3c7814116c7c..86bfdf5db2135 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -992,10 +992,9 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	 * type value and format definitions. Load both right
 	 * now.
 	 */
-	if (pmu_format(pmu, dirfd, name)) {
-		free(pmu);
-		return NULL;
-	}
+	if (pmu_format(pmu, dirfd, name))
+		goto err;
+
 	pmu->is_core = is_pmu_core(name);
 	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
 
-- 
2.43.0


