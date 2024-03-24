Return-Path: <linux-kernel+bounces-112899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79D7887F98
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98601C2091D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D8454905;
	Sun, 24 Mar 2024 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxv0l1Rx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8845548E3;
	Sun, 24 Mar 2024 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319709; cv=none; b=CHwHHl2uHNU2Lt3WLXxY5fDO3h11wItifn3B7evsUnrpaA+CTb7sCY+A9ir6GnQdtxQnnvMGE93GNvOEkeCEKa5Ii3QJG/keMcBSE2FhJ/rt+NzQks2dc+UBirbsg9dh0dzrjXJFKiYnSJ25uo9KA1J74PYKbLmcAy4iWdgCssM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319709; c=relaxed/simple;
	bh=UZ1IFt2fs6RF2Ir542kA8pBRLhL3MsJPGgyv1aIBtTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKskoOjN0pxxadEruF6WE46baHL8VxiL6FHhA42X/x63EM02x8vQT6XmmBzi3559fmKM+5D41duHFh5GtBxeqkRRcjLGeDN733kyrRuYHk1uIBvhYxOaEyIJyQZVwjsxPGYbyWsU6kVnV+tXwOJiqF8YJJ6XBkYZI8T40NWeHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxv0l1Rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA44C433C7;
	Sun, 24 Mar 2024 22:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319709;
	bh=UZ1IFt2fs6RF2Ir542kA8pBRLhL3MsJPGgyv1aIBtTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mxv0l1RxE1eBJejMbHzZrAV5cYd5P76pIpPvCSCrjM8/Huhw2texGJRpUcsQWmXv0
	 b15y9SM8JfxUuIPrWpMCZGbvzK7zFxGJPkmJqsLL3x5H7sEPMcxuEe42OQNBNy7dFf
	 EKKSJ/Uuddl/lR8Yw7pQTA+DZQc6tOBr5ErRCuvV8wops4YytU+j3rFYV1eiWyzAsX
	 PNQ+Gqx7I/MdgWSBIH0q+ZEhWOSM1Y5vdWk3B8aBomY6h5HNUjtlxn9KQXIvIrsBS2
	 nD0cZsuPedz9mbzGsNexqopIo5cPeZuWZ3MKsr166mtUPLUS4PpRr7bvzr6BrUdnHm
	 /PxqYykk5+Hfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 012/715] iomap: clear the per-folio dirty bits on all writeback failures
Date: Sun, 24 Mar 2024 18:23:11 -0400
Message-ID: <20240324223455.1342824-13-sashal@kernel.org>
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
index 093c4515b22a5..228fd2e05e12f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1833,16 +1833,10 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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
@@ -1851,6 +1845,16 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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


