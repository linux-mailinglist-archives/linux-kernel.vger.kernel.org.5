Return-Path: <linux-kernel+bounces-114003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A866B8887E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3F71C26D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99E32251FE;
	Sun, 24 Mar 2024 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eadAWaX6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51FA1F417A;
	Sun, 24 Mar 2024 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321149; cv=none; b=gcQZyAFfcfS+bCL/CRsTcyHDEZPxY8SY38Nbh7woTS1BgT5CeQPEKieO9bR+YkwtY7X8EJXT8HiNowa+32Ba4hHomEeDPQTyr81tpCPjP6lvD1wD01jn+pbqSwbgqLpPbg8OgHRDbT5TGUPXN+jizWDE3wRgcg5aQKW9NXOcvYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321149; c=relaxed/simple;
	bh=i4oQD7gPPqU+H+6Le9nflWOyT+OZ4RvjysxndjtUVLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssnHhAtOTvidir5erivj25DlWgOR3Q3IshkFEvg+prjpi73RJlmi2ucFTT8/ic5tjM4PT4G7ZpgfOBxN6mR/UKwkWGs/Iu9Y4RofTFDNHTod6tNmk42hchQKWlHDdAoi7GBpJVqqQffoNidXhqcXgQixHSNqICiU4oPGxcYj0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eadAWaX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF31FC43394;
	Sun, 24 Mar 2024 22:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321148;
	bh=i4oQD7gPPqU+H+6Le9nflWOyT+OZ4RvjysxndjtUVLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eadAWaX6pRBy1zqej2kAYLUrxpOmhmj8JRZfZbBlwO+/nC2iuspqMrgdc487D2E9m
	 MSgu4NuiKPcBr7Jh+JDZ2JRtqMtSirM/F594tmWJSS88b/TzKuXi9hg5ZkgmAhflnD
	 9jCOni58qIxFyTnhOdQkcjy8YXpU0TIstyhHB5M0rcNf43demMqCSBqK+rOVd5zo50
	 qopk2ZAZijh53K29PeGD+MQIpM3EshxfBgiAMkV9CxSZQAteoHhcOL4K3xoQUsBCHW
	 cZkaAtC3/FMydsRX2eq4KCtbrZlnJMrOO9nXfGLGmFyJHc+PRU9sLMGUAuzV9NPedx
	 8yqPm/CTve4Vg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 710/713] dm-integrity: align the outgoing bio in integrity_recheck
Date: Sun, 24 Mar 2024 18:47:16 -0400
Message-ID: <20240324224720.1345309-711-sashal@kernel.org>
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
index ec8df735077fe..2cc30b9ab232a 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1699,7 +1699,6 @@ static noinline void integrity_recheck(struct dm_integrity_io *dio, char *checks
 	struct bio_vec bv;
 	sector_t sector, logical_sector, area, offset;
 	struct page *page;
-	void *buffer;
 
 	get_area_and_offset(ic, dio->range.logical_sector, &area, &offset);
 	dio->metadata_block = get_metadata_sector_and_offset(ic, area, offset,
@@ -1708,13 +1707,14 @@ static noinline void integrity_recheck(struct dm_integrity_io *dio, char *checks
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
@@ -1727,6 +1727,14 @@ static noinline void integrity_recheck(struct dm_integrity_io *dio, char *checks
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


