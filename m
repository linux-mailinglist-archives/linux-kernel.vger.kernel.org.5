Return-Path: <linux-kernel+bounces-114927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130FE888C07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5321F28BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BC72D6F0C;
	Mon, 25 Mar 2024 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fgx1sQ1B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BCF280206;
	Sun, 24 Mar 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323635; cv=none; b=DSZo3O6/PCaLS+CP6xGw+Vti4hq5RojBFIISMZM/Oq6TkqNo//+nNWGXjjOpboCAU6812FyDR1da+BO2N//lS12h74OTKNBfceGrFqyo6HrMWzQ22C+D9cQBXiOIgAylVlqlkiw3vA1wg+JA+ow+ufArDjTK0XSepTxGeozmewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323635; c=relaxed/simple;
	bh=W7EFPrddAiARLEIxEX/jN7SMYuIy9OT780TTtwsJlAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5qyY9r2ABA88lajLaPhGn4gUDa/OyLMyem5tiPDOv4yzCJIhtcJnNaJQu7Gz6DE5P+sqHkaU0E4AppAz3xl5orPfYUcZc/g8844YOD6m+10/aeGwIolJ+h3h9ir5iMupioJSwmcVpMXhj8T/hg+7bzVxk/vFPMXOWZLSpz1yJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fgx1sQ1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E80C43390;
	Sun, 24 Mar 2024 23:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323634;
	bh=W7EFPrddAiARLEIxEX/jN7SMYuIy9OT780TTtwsJlAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fgx1sQ1BIn1VV4XNaxQ4Ws8WTDJ9mdA+BsALOGIRlA/iAzst5JIQUv8Br72n9VHdG
	 LRD+pkTXS4/tFcbYjCs1UDKR+Orcj62s2oq4Q1c6dxvlMPSAxMoywbrI3S6Fy0TaKl
	 83MwBsPi9BiHTKp8t5IH8zvbsFKxvNrFZ0EuNc9zD41wI6V/38N+wy1C7d3kY8n1H/
	 89YErQ/hg8U7v4m9Pxl2lqqiYC9D9QG/ex5nt5lb4IReU4oY0ZCsgo1lxafIBWpkSK
	 rJ9jT2z53xUYG/RmO/rozKXCqF6BucNAHi/BGlAU+l0kVlBMb+aYrXhFWhl3hfuMMt
	 73+MiqE5s9NGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 005/238] btrfs: add and use helper to check if block group is used
Date: Sun, 24 Mar 2024 19:36:33 -0400
Message-ID: <20240324234027.1354210-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 1693d5442c458ae8d5b0d58463b873cd879569ed ]

Add a helper function to determine if a block group is being used and make
use of it at btrfs_delete_unused_bgs(). This helper will also be used in
future code changes.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 3 +--
 fs/btrfs/block-group.h | 7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c4e3c1a5de059..9a7c7e0f7c233 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1393,8 +1393,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		}
 
 		spin_lock(&block_group->lock);
-		if (block_group->reserved || block_group->pinned ||
-		    block_group->used || block_group->ro ||
+		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
 		    list_is_singular(&block_group->list)) {
 			/*
 			 * We want to bail if we made new allocations or have
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 4c7614346f724..0d02b75f9e7e3 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -196,6 +196,13 @@ static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
 	return (block_group->start + block_group->length);
 }
 
+static inline bool btrfs_is_block_group_used(const struct btrfs_block_group *bg)
+{
+	lockdep_assert_held(&bg->lock);
+
+	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0);
+}
+
 static inline bool btrfs_is_block_group_data_only(
 					struct btrfs_block_group *block_group)
 {
-- 
2.43.0


