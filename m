Return-Path: <linux-kernel+bounces-57067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF3584D3A2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6811C23EB6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB1D129A78;
	Wed,  7 Feb 2024 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAFYfNq2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB47127B65;
	Wed,  7 Feb 2024 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340907; cv=none; b=fg10CV1SDWkFVDBkf86/4fbXD5sueEA7WRP0J/uCm56Mt1UX/+ipq+J6R9xJfWV0CIDrO60dhvHVqn82Sl9NppX+3C0tfsA4pOkfor7lcNHOJmXxgOcIo3OXQKQwwX8+hURwAda+DAAwrwcxwlm3yL4bjcfUCW6yciIdvMTnZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340907; c=relaxed/simple;
	bh=2LEkafcFSIj0xn1I3aY/1pa7Uaf1dn6f66qCYxrGj+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQgXo1lwKzMKoaR+7roSgPRk6jbxFzCuwi+amm/0NYj/9MotXwOIw0K/uNVl4i0TvS/OIFtyVKIBhxM+b3ixWwuAv5LbG3Nivs6gA3xkm+ZwA2i4JlDt9h0DYam4c6U2qIy1KgTPKMMz4qp43AxYMD2OixU7dQrFwDsldtRjhm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAFYfNq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD56DC433F1;
	Wed,  7 Feb 2024 21:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340906;
	bh=2LEkafcFSIj0xn1I3aY/1pa7Uaf1dn6f66qCYxrGj+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PAFYfNq2KJdn2QUGVbPtq0sZnIBfUp+g7cHOf2+AeaKt/PT+4TttFy3ALmilw+EGE
	 o5M7Jc4hbyMlH9F7VLrrAjJyTdbB03oClLu2LxN7urJQOB8H+mIOr69FdPSg/py7e8
	 DpOhuhGtR5xdUMyntiE2dd6dQeTJrxSC5J+Ct9B6NmNfEN5hTd1k7Lf59uYzZDEeJX
	 HAAjFpKYYgmdYE2SfG67k46nRbgh1bBuh0QwS5rvDToqaZUj3j3bNCLl1L/Wgo3nYA
	 oi/mS0zmlLGrFAuIngU+j7bARwtQKtNTJQONU0Bui6XIqFV5hqJdT+3DX4yLjJ8cVZ
	 2jlaCBCoof9Hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 02/44] ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
Date: Wed,  7 Feb 2024 16:20:29 -0500
Message-ID: <20240207212142.1399-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 4530b3660d396a646aad91a787b6ab37cf604b53 ]

Determine if the group block bitmap is corrupted before using ac_b_ex in
ext4_mb_try_best_found() to avoid allocating blocks from a group with a
corrupted block bitmap in the following concurrency and making the
situation worse.

ext4_mb_regular_allocator
  ext4_lock_group(sb, group)
  ext4_mb_good_group
   // check if the group bbitmap is corrupted
  ext4_mb_complex_scan_group
   // Scan group gets ac_b_ex but doesn't use it
  ext4_unlock_group(sb, group)
                           ext4_mark_group_bitmap_corrupted(group)
                           // The block bitmap was corrupted during
                           // the group unlock gap.
  ext4_mb_try_best_found
    ext4_lock_group(ac->ac_sb, group)
    ext4_mb_use_best_found
      mb_mark_used
      // Allocating blocks in block bitmap corrupted group

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240104142040.2835097-7-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a85017a78fc8..2541647ba5dd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2282,6 +2282,9 @@ void ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		return;
 
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ex.fe_start, ex.fe_len, &ex);
 
 	if (max > 0) {
@@ -2289,6 +2292,7 @@ void ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		ext4_mb_use_best_found(ac, e4b);
 	}
 
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 }
-- 
2.43.0


