Return-Path: <linux-kernel+bounces-115302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6D1889A85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8221F33E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36401D5676;
	Mon, 25 Mar 2024 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drkJB0sr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E437F7D6;
	Sun, 24 Mar 2024 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320492; cv=none; b=Hi7alKC/cfx2nL+IXouuikTbsU2wG/9rWRvVBmOKIe3fmR8KJTmAVw2pX2OQ/XQLFqH0ciBXcIhkBlQvlMrS5wWg+uOH4PsWx9JFH51tkDsU+rKJVkEkAjGeXPHlgnV4lYMzBQP/Auh0yZNQ4GXBWJdoOtHl1A18NvKj0trSaDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320492; c=relaxed/simple;
	bh=vOIDdeDxdOI0karp+xCw4ebzSWVXYKI3oMsxVYitKmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7UnEx/gJUTzXO2qB844ee7/77JKHf4YKErIPKMso+wXIuq/HsWX4l6PZCRjeijjTBhcQC9eBtjjeAMkXefiZHmqHfPpf6iphFgiC8w+A9G1WrwC0lEmqGIynJxTOPgZbi6Kj6YbC92jhvHo8j1ZVR+3D1TdIMRdJKNU6Cd3tN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drkJB0sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CEFC43390;
	Sun, 24 Mar 2024 22:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320492;
	bh=vOIDdeDxdOI0karp+xCw4ebzSWVXYKI3oMsxVYitKmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=drkJB0srBDBGlhAsUfB5261i06MGd9xWqMUuVxuaGRLBCG4EYloNUZD3GUH6b/z+D
	 mfJQIREIpO4s5PotHeBUlW+lL4yYoJ5Jvoub2zPxCzGCWxridROwJ/OMghTHGjA+Dj
	 U+Bfe50ny1tJs4VGu0i4vQDvQMQSDHB4HmdokvpjyESc30aA0I1ql1AAmyvBfoVgLN
	 tqqO0JeJjwLfStJk6+fXIPJtTCV5jGPoZAcwzr0VL1MizKjKPSyfu+0uXSw5ZYO8b5
	 XHklKD28EghH2dt0NiPklm5Rxx2YK0+f+69Rx/XOWP9pps2mbwjn+z/+LL6CH/FFbo
	 0R10p43mbytJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	HAN Yuwei <hrx@bupt.moe>,
	Boris Burkov <boris@bur.io>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 051/713] btrfs: zoned: don't skip block group profile checks on conventional zones
Date: Sun, 24 Mar 2024 18:36:17 -0400
Message-ID: <20240324224720.1345309-52-sashal@kernel.org>
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

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit 5906333cc4af7b3fdb8cfff1cb3e8e579bd13174 ]

On a zoned filesystem with conventional zones, we're skipping the block
group profile checks for the conventional zones.

This allows converting a zoned filesystem's data block groups to RAID when
all of the zones backing the chunk are on conventional zones.  But this
will lead to problems, once we're trying to allocate chunks backed by
sequential zones.

So also check for conventional zones when loading a block group's profile
on them.

Reported-by: HAN Yuwei <hrx@bupt.moe>
Link: https://lore.kernel.org/all/1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe/#t
Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/zoned.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3779e76a15d64..524532f992746 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1661,6 +1661,15 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 
 out:
+	/* Reject non SINGLE data profiles without RST */
+	if ((map->type & BTRFS_BLOCK_GROUP_DATA) &&
+	    (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
+	    !fs_info->stripe_root) {
+		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
+			  btrfs_bg_type_to_raid_name(map->type));
+		return -EINVAL;
+	}
+
 	if (cache->alloc_offset > cache->zone_capacity) {
 		btrfs_err(fs_info,
 "zoned: invalid write pointer %llu (larger than zone capacity %llu) in block group %llu",
-- 
2.43.0


