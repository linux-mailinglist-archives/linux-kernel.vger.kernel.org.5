Return-Path: <linux-kernel+bounces-115332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BC3889AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6191F2E563
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D6D1E5860;
	Mon, 25 Mar 2024 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7+7wRMs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB01D1D50;
	Sun, 24 Mar 2024 22:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320531; cv=none; b=eBC/BvHpKHC7sLqh/tpgLZL/k3CQLic2dUry/quSc8b8o6F3TepmN5vsnF8DIctGlIZLGlpY/ICqJBRe0kEu6Bv/flC0AGDSMO/bHrkAwRkZsGtZrRJJfGi6oLzS/6FWLMJkGc6cDrq4o3F4qvtjcaFwTlAnxZvsQeKDQTLEGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320531; c=relaxed/simple;
	bh=Vk4HTc/xRaVdkDvNcdfvdHv7Ol25Px/EUYYf8d2Z9es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAknNExHsyNVflEkFN/DQjXW8U5mKIxYwAeexll/WWYx411bEei62ynjfmxvSpL2Bkdjm49OhJbH1StFS3A+aJv58AEwcqHl5KAC5sZqIa7KT3JHyaBRvwtgi6kukFEZMkHdsOhm5s1P+A1VK6YMpgaGzxTn+1cyITg4caWa/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7+7wRMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D467EC433A6;
	Sun, 24 Mar 2024 22:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320530;
	bh=Vk4HTc/xRaVdkDvNcdfvdHv7Ol25Px/EUYYf8d2Z9es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7+7wRMscMY0O3YollNuqTrM8dhJve9wHnQ7syTlL18OalNagT0XyLM+bu46vSnPH
	 0DnnYGMFidFjfm5F25yTklt/C1M2xauSy6h83dsKlUJtI2Q3NQKhSbhSx85o8RLfjs
	 BX10a3tCbzbcUVSF6xd5vM6zQLNOrj8fs6hUwerzB9bP+mzxF9LWqwqOjHHxcwQ5lZ
	 MXm0bF+M0mZZAISPNuBbAoIwDoTuEfLJUJC//iGoTRuh68sp2jlXn/FYwvpgccvV2F
	 mb33k0Dtq/Ws19CVH+inKyzIXA4wpQyEK6dtzXPd9Ap51VG4tDeNMRVCWrWC+yxxhB
	 lsUM4+mnRszBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 092/713] iomap: clear the per-folio dirty bits on all writeback failures
Date: Sun, 24 Mar 2024 18:36:58 -0400
Message-ID: <20240324224720.1345309-93-sashal@kernel.org>
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 7ea1d9b4a840c2dd01d1234663d4a8ef256cfe39 ]

write_cache_pages always clear the page dirty bit before calling into the
file systems, and leaves folios with a writeback failure without the
dirty bit after return.  We also clear the per-block writeback bits for
writeback failures unless no I/O has submitted, which will leave the
folio in an inconsistent state where it doesn't have the folio dirty,
but one or more per-block dirty bits.  This seems to be due the place
where the iomap_clear_range_dirty call was inserted into the existing
not very clearly structured code when adding per-block dirty bit support
and not actually intentional.  Switch to always clearing the dirty on
writeback failure.

Fixes: 4ce02c679722 ("iomap: Add per-block dirty state tracking to improve performance")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20231207072710.176093-2-hch@lst.de
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f72df2babe561..fc5c64712318a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1843,16 +1843,10 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	if (unlikely(error)) {
 		/*
 		 * Let the filesystem know what portion of the current page
-		 * failed to map. If the page hasn't been added to ioend, it
-		 * won't be affected by I/O completion and we must unlock it
-		 * now.
+		 * failed to map.
 		 */
 		if (wpc->ops->discard_folio)
 			wpc->ops->discard_folio(folio, pos);
-		if (!count) {
-			folio_unlock(folio);
-			goto done;
-		}
 	}
 
 	/*
@@ -1861,6 +1855,16 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * all the dirty bits in the folio here.
 	 */
 	iomap_clear_range_dirty(folio, 0, folio_size(folio));
+
+	/*
+	 * If the page hasn't been added to the ioend, it won't be affected by
+	 * I/O completion and we must unlock it now.
+	 */
+	if (error && !count) {
+		folio_unlock(folio);
+		goto done;
+	}
+
 	folio_start_writeback(folio);
 	folio_unlock(folio);
 
-- 
2.43.0


