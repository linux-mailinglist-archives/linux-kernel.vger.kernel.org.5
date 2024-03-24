Return-Path: <linux-kernel+bounces-114443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA23D888A86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB58BB24A12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7335927F08D;
	Sun, 24 Mar 2024 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASdEFgsb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7121E330;
	Sun, 24 Mar 2024 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321861; cv=none; b=tfGQqEJEM7eo0x2qo9KzlGw4scmbriygPppucid6ExkuotukAJCyjqpolFKwtz/sLPyuPUsJIFdH6BuHa0KclSqHERwH1vKhkKofkD6qXOtPB6JrjHmjTIDqnq42dQgC0HhUYKzHkG6f3jyOCOpa0usIyL0Co9aZJe4H7IKA87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321861; c=relaxed/simple;
	bh=t5D36AWpjxnCUoWLwEy7A++KapNSrJXpR2LRoOjdK8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAwcjfpj2nrH/wM8Llz1nnUXePRQior0m3/Tw5An6pHBZIDtVC8jwC+b1iKtv3gIOdxtnw/IYi7o7IjkwTCGTPcRDDZ+B+u3SNPLJkuIQTPq++oujgwb59dxw7/uIfA+Auwra4Vxf/RUIfZGndj5ln8JGXhspCtv024fDXtxtk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASdEFgsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DECEC433C7;
	Sun, 24 Mar 2024 23:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321859;
	bh=t5D36AWpjxnCUoWLwEy7A++KapNSrJXpR2LRoOjdK8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ASdEFgsbCPDzAlV8aSvitsrpaPOCwTeJ/W3sFO9qHyLMC3xOhUpSROaDVy9mJo4nt
	 af6gxQg7yLmzXiv0Nw5sPGk/u1HCieKlSluSot1FCD7db0+fqWHYWkK0AjxpHTt5gO
	 gFq7jvzw6Yl+1EzAU5QDEOoj9ieLf6dZCEPSzzR0ouf36ZrV+hXs9lwAsU2C6mORJN
	 bDQqA3y2T14S/F39XfC3CeI4u9Ru990SvokaPyN1aF03oCNvqCIXOzr4dqQqenvLMx
	 hMw/38U+JCAg7OUKfiHF0b21D5nEXKqF0PiQzCyoVQ1+BR33S6VCMPp6PIhslR1nXy
	 akG3ATxydLblw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 588/638] io_uring: Fix release of pinned pages when __io_uaddr_map fails
Date: Sun, 24 Mar 2024 19:00:25 -0400
Message-ID: <20240324230116.1348576-589-sashal@kernel.org>
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

From: Gabriel Krisman Bertazi <krisman@suse.de>

[ Upstream commit 67d1189d1095d471ed7fa426c7e384a7140a5dd7 ]

Looking at the error path of __io_uaddr_map, if we fail after pinning
the pages for any reasons, ret will be set to -EINVAL and the error
handler won't properly release the pinned pages.

I didn't manage to trigger it without forcing a failure, but it can
happen in real life when memory is heavily fragmented.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Fixes: 223ef4743164 ("io_uring: don't allow IORING_SETUP_NO_MMAP rings on highmem pages")
Link: https://lore.kernel.org/r/20240313213912.1920-1-krisman@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 25e2893320342..aabb367b24bc0 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2676,7 +2676,7 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
 	struct page **page_array;
 	unsigned int nr_pages;
 	void *page_addr;
-	int ret, i;
+	int ret, i, pinned;
 
 	*npages = 0;
 
@@ -2690,12 +2690,12 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
 	if (!page_array)
 		return ERR_PTR(-ENOMEM);
 
-	ret = pin_user_pages_fast(uaddr, nr_pages, FOLL_WRITE | FOLL_LONGTERM,
-					page_array);
-	if (ret != nr_pages) {
-err:
-		io_pages_free(&page_array, ret > 0 ? ret : 0);
-		return ret < 0 ? ERR_PTR(ret) : ERR_PTR(-EFAULT);
+
+	pinned = pin_user_pages_fast(uaddr, nr_pages, FOLL_WRITE | FOLL_LONGTERM,
+				     page_array);
+	if (pinned != nr_pages) {
+		ret = (pinned < 0) ? pinned : -EFAULT;
+		goto free_pages;
 	}
 
 	page_addr = page_address(page_array[0]);
@@ -2709,7 +2709,7 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
 		 * didn't support this feature.
 		 */
 		if (PageHighMem(page_array[i]))
-			goto err;
+			goto free_pages;
 
 		/*
 		 * No support for discontig pages for now, should either be a
@@ -2718,13 +2718,17 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
 		 * just fail them with EINVAL.
 		 */
 		if (page_address(page_array[i]) != page_addr)
-			goto err;
+			goto free_pages;
 		page_addr += PAGE_SIZE;
 	}
 
 	*pages = page_array;
 	*npages = nr_pages;
 	return page_to_virt(page_array[0]);
+
+free_pages:
+	io_pages_free(&page_array, pinned > 0 ? pinned : 0);
+	return ERR_PTR(ret);
 }
 
 static void *io_rings_map(struct io_ring_ctx *ctx, unsigned long uaddr,
-- 
2.43.0


