Return-Path: <linux-kernel+bounces-94896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF41874672
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7089B217A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A89DDC3;
	Thu,  7 Mar 2024 03:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xfvl0OYl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4EB5C82;
	Thu,  7 Mar 2024 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780419; cv=none; b=OIHB7HQdWlmUn9HyGeEWaWoEG03ByJWmkU7iRY2ZGP5XQpT4jx0CXf0ee7N1x/xGodxSwKdS23oORrGoWW0tvMmoAYxFYJee31aNCjznVOTNxT2GI8nb3ciF6J+UlYl+s/0cgNAx5ggNTOd/maagGCZ0O0BiVZkogTZhjA+JV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780419; c=relaxed/simple;
	bh=LO88k+dd/BebwXvUzvdC1iypWVc1Mb6U9juVYlKD5Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r4lnhhcKpsfvQbPy3pMx09kcZIRTbuLqMla5/mjjY/fdTEow8WM4tdjn5jnqT4H2Sg0gsqBOQlXxuLyHiNqlF+KuMFTToZfdLSIKkUuBNiTIdY8HUURKpm6JCXzIt+cmQJxY9L81WXmf0Ddgx1wsB/Kk4o1u5Zd55lcBJo4LC08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xfvl0OYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52C9C433F1;
	Thu,  7 Mar 2024 03:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709780419;
	bh=LO88k+dd/BebwXvUzvdC1iypWVc1Mb6U9juVYlKD5Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xfvl0OYlXalMPZ5OQy3u2by1UcGM63J6lYhw6OnPh5BnjI7XbNx9yehBIe98iibpT
	 mVEKZQGkrZK0nQgcWw/M7VsDKZGgiUz/6W5vvgcZScmUgyu7T75nOC9STn59mm8Bte
	 mJfbJOPDheRHml1ByYZpQbHQdeRj120Sjddcr/1nHUd70BI54sCBVgXEXYJketb0Jt
	 z9IUEX3UDo9GyhOR8XDgyW5k+0gxOUQs29Ld4RSIAngv7MO0XbF7f8apdD49lPDFvA
	 NZyTKlEO/ta8kLgllFMMiE92wUPs0XsSDFR+vGs9TLrlKLcicF3HkPvRcWv7Ffq43e
	 QpdZFfAX9k+5Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] mm/damon: add DAMOS filter type YOUNG
Date: Wed,  6 Mar 2024 19:00:11 -0800
Message-Id: <20240307030013.47041-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307030013.47041-1-sj@kernel.org>
References: <20240307030013.47041-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define yet another DAMOS filter type, YOUNG.  Like anon and memcg, the
type of filter will be applied to each page in the memory region, and
check if the page is accessed since the last check.

Note that this commit is only defining the type.  Implementation of it
should be made on DAMON operations sets.  A couple of commits for the
implementation on 'paddr' DAMON operations set will follow.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    | 2 ++
 mm/damon/sysfs-schemes.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 886d07294f4e..f7da65e1ac04 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -297,6 +297,7 @@ struct damos_stat {
  * enum damos_filter_type - Type of memory for &struct damos_filter
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
+ * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
@@ -315,6 +316,7 @@ struct damos_stat {
 enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
 	DAMOS_FILTER_TYPE_MEMCG,
+	DAMOS_FILTER_TYPE_YOUNG,
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	NR_DAMOS_FILTER_TYPES,
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 53a90ac678fb..bea5bc52846a 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -343,6 +343,7 @@ static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(void)
 static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
 	"memcg",
+	"young",
 	"addr",
 	"target",
 };
-- 
2.39.2


