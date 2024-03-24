Return-Path: <linux-kernel+bounces-113544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC4988852D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5571C24737
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6E31C1C17;
	Sun, 24 Mar 2024 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b65asg9J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A801C2333;
	Sun, 24 Mar 2024 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320346; cv=none; b=WE7pzej9tATNnr2xqOWDwceRsPEP2bPJiAkSURhhgnDNRoim/wPO6UvcwB1i5pDulaPHed/12qqiRdqXYVt35cr8BhCDHzJVcZBlcQjB67T7pXNAVoeHw6gLYMdRG+wqOWh4dikOTQuBQfbGUeQhduo0Bq/dhj8BEnoRKn/dtas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320346; c=relaxed/simple;
	bh=Q6mDEFDDJM5MnBK2grfADOVLskK9JJehYLpuYlRwFyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsppIqO3l+kc85RtG1FtPBbRt2ejVXcPwZTqSkMBIMjA/zvt0G0nQsTYB0Rf8QO5sUI+Agg8KA7n7nMQRkOsNBy/XoNfvdw+UKN9SJLj+Wp8IqZyJcMqP+egp+nqqfgOUCmEG1bi+/dBdBYHRePgQxECJsmvGonp5qpCvyz1lmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b65asg9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54538C43394;
	Sun, 24 Mar 2024 22:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320346;
	bh=Q6mDEFDDJM5MnBK2grfADOVLskK9JJehYLpuYlRwFyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b65asg9JkOmHBjt8YcAlQJRhDKSOiEF4aUu84vX4o7k3nLaTi7yOqdVyRydLvVAuF
	 j9LplR8CHP3OJgTE6+aoYzgdhGazA/7hzjlnsZHwEsyLBWfTmIfCMbHEeG+/vSmU3/
	 vwpJKzbs/wN6w9S9QQLdvcWqPGe2pKP406WD7ZklmwqGk37nXJWmZHabndGLHTyRaa
	 SQP6F06hdAdzN3kgMIj1aALE/yzXwNwW/sGi84ENDoFzxlXSC3h2cgiD/6g3HyCaJH
	 702evJtgJKckz8IfFbz/LhP6CJsX23kMSf/EcnJxNfARUEcyuCKIN4sZ8vD6iYxjQ3
	 vV48Ch3c9uznA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 653/715] io_uring: Fix release of pinned pages when __io_uaddr_map fails
Date: Sun, 24 Mar 2024 18:33:52 -0400
Message-ID: <20240324223455.1342824-654-sashal@kernel.org>
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
index 030cc930d1c6a..9f938874c5e13 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2702,7 +2702,7 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
 	struct page **page_array;
 	unsigned int nr_pages;
 	void *page_addr;
-	int ret, i;
+	int ret, i, pinned;
 
 	*npages = 0;
 
@@ -2716,12 +2716,12 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
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
@@ -2735,7 +2735,7 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
 		 * didn't support this feature.
 		 */
 		if (PageHighMem(page_array[i]))
-			goto err;
+			goto free_pages;
 
 		/*
 		 * No support for discontig pages for now, should either be a
@@ -2744,13 +2744,17 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
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


