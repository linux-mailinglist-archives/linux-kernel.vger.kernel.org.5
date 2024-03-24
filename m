Return-Path: <linux-kernel+bounces-114712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F9A888BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6B91C27E65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ACD18E0E2;
	Mon, 25 Mar 2024 00:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRzkvRxI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552ED15FD19;
	Sun, 24 Mar 2024 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322367; cv=none; b=W0NVWU6zId7l7Zp/ONVv7ZC4JPCnLfzijimjI5gm++/mSPd7ceDmy3gEjY9Yie5gXMLrZyGZWpND/FkmD33lMNgOv1N8ySg899qCT0V90d4PMLCbXYjhIJj9iONpHWeIRKgX1eJclhpfYc/SI5quqCHz/69w8cmVi8/Ou3wIU+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322367; c=relaxed/simple;
	bh=fE4ZKVB3+ZCv5F/C5Xh6RNMhddjs7YV2Z/yd9kmdMnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOvW2tUvOkk+d74sq/1KI8lfDo78CIYZ/RXsz5NUfJhBtfRjg7M5YiS0+qmqhwS/80Wt+3CkDsqo1sFEt5ZzDmK3mrNqsFgebL1wK4bvmkcCSpjT2wc2g+1wSJOL+mY4WI0e+mKGNaBIOYcpg3zzqICPg5DmaTp4805ozD6DoEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRzkvRxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C579C43399;
	Sun, 24 Mar 2024 23:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322366;
	bh=fE4ZKVB3+ZCv5F/C5Xh6RNMhddjs7YV2Z/yd9kmdMnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRzkvRxINJxCs7ZtrwNOv/Rqbf1I+T+lxPxY2tgbD9KOlmlCCtVNaUIyi7/J5+vWq
	 lIs5fY1tpLfw9ARyzal6SnW2lPT1s24xN7viwdKucCw+ES7uDoZ4je/RD8o2jbLAFo
	 SfoPRoNWqU/GQHxQn64DTj225ZrjMubvimKohataV8mqQDUdXKjjXdPiIt7fT9rvDw
	 uKVo6ZzemNcFSqVK+NUci2JdM2g4IUDCKY38o7ZsK1nyYAiBLpuyHbyLAqbWlU6b/V
	 GbAD4ovZVqF/Y+e6UiiFCVWln5zVkojtW5SlZ+bNRunpBxNSPt/3gD38HM8DjhbKqO
	 14iYsQ/uAyd9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 448/451] dm-integrity: align the outgoing bio in integrity_recheck
Date: Sun, 24 Mar 2024 19:12:04 -0400
Message-ID: <20240324231207.1351418-449-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit b4d78cfeb30476239cf08f4f40afc095c173d6e3 ]

It is possible to set up dm-integrity with smaller sector size than
the logical sector size of the underlying device. In this situation,
dm-integrity guarantees that the outgoing bios have the same alignment as
incoming bios (so, if you create a filesystem with 4k block size,
dm-integrity would send 4k-aligned bios to the underlying device).

This guarantee was broken when integrity_recheck was implemented.
integrity_recheck sends bio that is aligned to ic->sectors_per_block. So
if we set up integrity with 512-byte sector size on a device with logical
block size 4k, we would be sending unaligned bio. This triggered a bug in
one of our internal tests.

This commit fixes it by determining the actual alignment of the
incoming bio and then makes sure that the outgoing bio in
integrity_recheck has the same alignment.

Fixes: c88f5e553fe3 ("dm-integrity: recheck the integrity tag after a failure")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index aff818eb31fbb..9c9e2b50c63c3 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1709,7 +1709,6 @@ static noinline void integrity_recheck(struct dm_integrity_io *dio, char *checks
 	struct bio_vec bv;
 	sector_t sector, logical_sector, area, offset;
 	struct page *page;
-	void *buffer;
 
 	get_area_and_offset(ic, dio->range.logical_sector, &area, &offset);
 	dio->metadata_block = get_metadata_sector_and_offset(ic, area, offset,
@@ -1718,13 +1717,14 @@ static noinline void integrity_recheck(struct dm_integrity_io *dio, char *checks
 	logical_sector = dio->range.logical_sector;
 
 	page = mempool_alloc(&ic->recheck_pool, GFP_NOIO);
-	buffer = page_to_virt(page);
 
 	__bio_for_each_segment(bv, bio, iter, dio->bio_details.bi_iter) {
 		unsigned pos = 0;
 
 		do {
+			sector_t alignment;
 			char *mem;
+			char *buffer = page_to_virt(page);
 			int r;
 			struct dm_io_request io_req;
 			struct dm_io_region io_loc;
@@ -1737,6 +1737,14 @@ static noinline void integrity_recheck(struct dm_integrity_io *dio, char *checks
 			io_loc.sector = sector;
 			io_loc.count = ic->sectors_per_block;
 
+			/* Align the bio to logical block size */
+			alignment = dio->range.logical_sector | bio_sectors(bio) | (PAGE_SIZE >> SECTOR_SHIFT);
+			alignment &= -alignment;
+			io_loc.sector = round_down(io_loc.sector, alignment);
+			io_loc.count += sector - io_loc.sector;
+			buffer += (sector - io_loc.sector) << SECTOR_SHIFT;
+			io_loc.count = round_up(io_loc.count, alignment);
+
 			r = dm_io(&io_req, 1, &io_loc, NULL, IOPRIO_DEFAULT);
 			if (unlikely(r)) {
 				dio->bi_status = errno_to_blk_status(r);
-- 
2.43.0


