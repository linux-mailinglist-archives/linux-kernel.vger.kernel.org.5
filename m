Return-Path: <linux-kernel+bounces-84784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E610E86AB80
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931231F233D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DE036129;
	Wed, 28 Feb 2024 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M89tswzd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9436103
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113242; cv=none; b=rC1XlYisAMkEZngBWT66A5JVi9z9VVh30LaPF34l7YDYTwdPCt5Zj0hmzF8I+TlfcuiLOiOpTl2QzflVE8y3/O3oCpERgWjZbg29yKvE/SnHzGT4jPqIyB8d4L1ftIWQRvjvn9zBb7P63qgwmqnlMv2h75CrTT8Ti3W/kfj+6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113242; c=relaxed/simple;
	bh=lvoTs/0UXElm44f/AN9pIyL/qzddZIntAlgjTtgGHwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uSGYPvRG261l1KOS/RZEn52Io0AD7qi5WsUhhlpkm0ycHtP/vieF7dWLIYDPffFAAQnwW5aDYg0su1wkFUn74D6Ew18PVTfYVWdaum58pMYUUdaKE3++fXLJ4FLASWURBf/3FPb4RN8xM7yDNL6YyJX79qiqWpoLBDeCDD/ldiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M89tswzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63376C433F1;
	Wed, 28 Feb 2024 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709113241;
	bh=lvoTs/0UXElm44f/AN9pIyL/qzddZIntAlgjTtgGHwc=;
	h=From:To:Cc:Subject:Date:From;
	b=M89tswzdasInlvO4kCicJK0gvJxK5iNT5k2Pzi5h1eJa6leEUEkKjhGDDg8wuX0hq
	 4yuhv7ypmp6YVKnk1yarUuspZBWhdxtLRs5TcpxgznyTKCwdNJiwp/7C0sgcvAlIKn
	 3zUY87S59TPo8j1pfIycdz140Hf99KJJj68f79Ko9lSo1lwhI/kxNdKZ++FMVwmtV4
	 FNynQe2hL4T1n7qOzhoEqB51U9JY5gmftA7YdC4sM8GOgsRVCjnb5inVq9HjT85MMo
	 kw+grGrhicACNWXBYv9emNyTn9vt5C5T4zLepkUcHHYCjjTemcp4Zbx1pkMoKm5WhV
	 FlqPCpg1RqfXQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <zhouchengming@bytedance.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nhat Pham <nphamcs@gmail.com>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/zsmalloc: move get_zspage_lockless into #ifdef
Date: Wed, 28 Feb 2024 10:40:31 +0100
Message-Id: <20240228094036.2267912-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

It's only used from inside of an #ifdef section, causing a warning otherwise:

mm/zsmalloc.c:735:23: error: unused function 'get_zspage_lockless' [-Werror,-Wunused-function]
  735 | static struct zspage *get_zspage_lockless(struct page *page)
      |                       ^~~~~~~~~~~~~~~~~~~

Move it down into that block to avoid adding another #ifdef.

Fixes: 2258bdebb55e ("mm/zsmalloc: don't hold locks of all pages when free_zspage()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/zsmalloc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 1a044690b389..11422305d819 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -731,14 +731,6 @@ static struct zspage *get_zspage(struct page *page)
 	return zspage;
 }
 
-/* Only used in zs_page_migrate() to get zspage locklessly. */
-static struct zspage *get_zspage_lockless(struct page *page)
-{
-	struct zspage __rcu **private = (struct zspage __rcu **)&page->private;
-
-	return rcu_dereference(*private);
-}
-
 static struct page *get_next_page(struct page *page)
 {
 	struct zspage *zspage = get_zspage(page);
@@ -1651,6 +1643,13 @@ static void migrate_write_unlock(struct zspage *zspage)
 }
 
 #ifdef CONFIG_COMPACTION
+/* Only used in zs_page_migrate() to get zspage locklessly. */
+static struct zspage *get_zspage_lockless(struct page *page)
+{
+	struct zspage __rcu **private = (struct zspage __rcu **)&page->private;
+
+	return rcu_dereference(*private);
+}
 
 static const struct movable_operations zsmalloc_mops;
 
-- 
2.39.2


