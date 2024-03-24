Return-Path: <linux-kernel+bounces-113973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE38887B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D444B1F262AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A23156665;
	Sun, 24 Mar 2024 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+sWM0D/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25531F23C3;
	Sun, 24 Mar 2024 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321097; cv=none; b=JGm550pZgHHFc0e6+krwQI5d4dxQuh7LDwfbWyk967hby0WHZvwCdEeps5blZFyroWZP6o3+wVwhSql0ZvDe3CulaDM/DCdEXQM/TJjTfOnA9N2PawswlcIetwudK5Ndb5H4SiXfFZ/qVhI/eiCRBo2Iphkkgyh/+qY4urmTOVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321097; c=relaxed/simple;
	bh=2MsH1en75wwKv4amJIJMmpNHNy66nBsPjlTIusOeyOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwIZiVFy3NhRWxsmriJtyVm4UCPLBXnrrqKHNVS5kLRn+FPQSuDNWNK/LYtxcvA1X26VmBhao0IBQYEXwcVIn74BPDa/PAMquAUeoCAZNUv6uPkir8b8cuceSkQ8+gLE5ZDR+AY2UizPMZR3WgoLwEK+x19zFXoh+n8hTGKVxVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+sWM0D/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D722C43394;
	Sun, 24 Mar 2024 22:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321096;
	bh=2MsH1en75wwKv4amJIJMmpNHNy66nBsPjlTIusOeyOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+sWM0D/J8f5pVeKmaIENqxAzLbw7NmUmuF5UCeOh4nYaTVhooEr9t5xKAJYOVVE7
	 WjtGhpvOXJwRX7kUQ9iu79AURWN/EQ2mhTRNiPZT6hMq82cBnOuuLEX3zH92UJUK5Z
	 XwJAa0xfaCv2qAmKpdQn/yxzFf4rNGiVPzFJ5jM4ErpUh6blOcdbV1g+Lta1Y3XwXE
	 F4NisWq1T3rvsaE/55TQSiRR40qSdX1x6J8U/LeRMdi/Uqfn+yQXIJir/DNLT9n3uc
	 n+ygvuKShWfMP36wiV/sNDTQ1Mgzoj8et6uiSdgOkLGsPEwbr/ewDlxGEuXerp/dx8
	 38PR1zKrsMC+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 659/713] io_uring: Fix release of pinned pages when __io_uaddr_map fails
Date: Sun, 24 Mar 2024 18:46:25 -0400
Message-ID: <20240324224720.1345309-660-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 205dad9603733..45d6e440bdc04 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2683,7 +2683,7 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
 	struct page **page_array;
 	unsigned int nr_pages;
 	void *page_addr;
-	int ret, i;
+	int ret, i, pinned;
 
 	*npages = 0;
 
@@ -2697,12 +2697,12 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
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
@@ -2716,7 +2716,7 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
 		 * didn't support this feature.
 		 */
 		if (PageHighMem(page_array[i]))
-			goto err;
+			goto free_pages;
 
 		/*
 		 * No support for discontig pages for now, should either be a
@@ -2725,13 +2725,17 @@ static void *__io_uaddr_map(struct page ***pages, unsigned short *npages,
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


