Return-Path: <linux-kernel+bounces-62889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C9B852786
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFCD1C231DF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D872581;
	Tue, 13 Feb 2024 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r32NUe2K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168580B;
	Tue, 13 Feb 2024 02:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707791797; cv=none; b=mqnimZcjz8ZAgMOS09HeroaahsD2CWlXmvx2nlVDkbJ9+YawahBNA3tZqgApRZPAFaRKaC61R5gzF4ZMQa7gEeZcZ9XGqCUTQiz1OQ13KqAVWxCPUTD4sZr8zj7ebNDdYb4dsf8Sq005X64cruZoOnAP+KOLdDiY6rM0yanS5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707791797; c=relaxed/simple;
	bh=ygxAPrJD39xiH5jwd8YqQbKkzfX8Q2c/ABdDAusTi5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LWuq9hL6hurhV9IjIrF3pYWzCkUYOu0cR9yGLCRacFuT/TPB8EcOz/AgudAywA5sK48GnfBdYLvV0WZZ4IEtQ4bFZ3Xh7W93eb7iLCwZfQgOq89KEOTb2UQk06p03wJbmMDvXVqVJ5HAqDGXjM8TIGKOsprMcVyitRGmoj05tSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r32NUe2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E05C433C7;
	Tue, 13 Feb 2024 02:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707791796;
	bh=ygxAPrJD39xiH5jwd8YqQbKkzfX8Q2c/ABdDAusTi5o=;
	h=From:To:Cc:Subject:Date:From;
	b=r32NUe2KJbXXRTqUWRebFFRNobzLoFQHk54L4g7kNDtRvv+K2BmRfXejGcfXil1mr
	 7eBc/VFFj54p1Vh2F1wZ119U0a2zXANAqB8EfcWb+uhiJormnSSz5cFihFFHQoejMW
	 b2xZJ7Z0mSDsJWQkUwvJchLsOyJ+Pgsj64J/sbpAFNWZCaKZGxC5l5A6rrEkc3YM+2
	 etT1zQT+IfF+zPCB1NEcE+QogeOfR8d0jYyiH5RTXaCfrwkH8Ofac0D2jxwqA9qqRD
	 v4L1eFTcQz5uvaqOzg1svcEFTGAi9ypQKAv0jV8ZHnVyurDXTPRU5WPQgKA9mdjRS2
	 ey3spt/owX9FQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/sysfs-schemes: handle schemes sysfs dir removal before commit_schemes_quota_goals
Date: Mon, 12 Feb 2024 18:36:32 -0800
Message-Id: <20240213023633.124928-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'commit_schemes_quota_goals' command handler,
damos_sysfs_set_quota_scores() assumes the number of schemes sysfs
directory will be same to the number of schemes of the DAMON context.
The assumption is wrong since users can remove schemes sysfs directories
while DAMON is running.  In the case, illegal memory accesses can
happen.  Fix it by checking the case.

Fixes: d91beaa505a0 ("mm/damon/sysfs-schemes: implement a command for scheme quota goals only commit")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 98c6e5376486..f6c7f43f06cc 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1905,6 +1905,10 @@ void damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
 	damon_for_each_scheme(scheme, ctx) {
 		struct damon_sysfs_scheme *sysfs_scheme;
 
+		/* user could have removed the scheme sysfs dir */
+		if (i >= sysfs_schemes->nr)
+			break;
+
 		sysfs_scheme = sysfs_schemes->schemes_arr[i];
 		damos_sysfs_set_quota_score(sysfs_scheme->quotas->goals,
 				&scheme->quota);
-- 
2.39.2


