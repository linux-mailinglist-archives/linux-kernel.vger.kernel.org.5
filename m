Return-Path: <linux-kernel+bounces-115605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D38088A05A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF2A0B633EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114F5253973;
	Mon, 25 Mar 2024 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUZI2hqU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E96E130AD6;
	Sun, 24 Mar 2024 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321354; cv=none; b=DzIsVTI9q1UhnPaoP95sX//jXv/gDR9uX8tgOzBqnx34+jJ502rBZkVNaSlzppnFtStclcV4AyrmXW9YO3GNSb3FCzUVjPP7Ak2Bh/BzB5DIGqjk60PXm+/UFtSE1h90DNM1ZTCtOGmAC8bnSCf1s678WsPpsZtHhRpbNMlVd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321354; c=relaxed/simple;
	bh=jtxf9O/jwcbFCCjmh74DlbdpYuDebk1mTbL4kpKOfUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXtfhoNiV8WP0bI6s/CgC8bkeP4IAwiTX5Imyds2TyF3FwPHyTD2hRUGA6GepS2v3oiqwNckLuxPwv6zVs0QmutGaTx81HTmxeAwQlWWIUw6vHAaLWvdXIxaB+LHKyUaeOuipeuLLeqhhg9/4ZFR6ejoj5sGMtG6rg04Yffg2Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUZI2hqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B45C43390;
	Sun, 24 Mar 2024 23:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321353;
	bh=jtxf9O/jwcbFCCjmh74DlbdpYuDebk1mTbL4kpKOfUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUZI2hqUONZUinqUSfBHl2R1pY3xEzgXGsxZChry6q1T3I4F6OzzdQKedZAF5lkej
	 gInDjMNvOGCG/K282Fgl+uUnDziCmx55e5+Wtx+oBigp01yf9BfBe2w8t6wAc6FP89
	 xk82vhXT3uqYy5q6b1iuVlWjiaZZlxfc/xFFmxSlP0kimTShN8RNqJQOhuuv9iVnLf
	 m7NiOYa2bsfUiCJvmzEaP05hnvWDFmv6MmhOoFgS3OT22C6i7axqYcN87cJbInvPqN
	 owPD977icRCL0d4moawCulcldAyfEQ0ffQiKbzlueJ3k/R+joEU2HvW1rNRMxcjnfy
	 s+0GydgOC82uQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 078/638] iomap: clear the per-folio dirty bits on all writeback failures
Date: Sun, 24 Mar 2024 18:51:55 -0400
Message-ID: <20240324230116.1348576-79-sashal@kernel.org>
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
index 2bc0aa23fde3b..1c63e48230aed 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1830,16 +1830,10 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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
@@ -1848,6 +1842,16 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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


