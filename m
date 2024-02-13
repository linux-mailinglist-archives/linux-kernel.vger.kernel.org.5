Return-Path: <linux-kernel+bounces-62647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6EC8523F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41551C234BE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E196E605B6;
	Tue, 13 Feb 2024 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OquQQuj5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468E605A1;
	Tue, 13 Feb 2024 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783672; cv=none; b=U+j+69ZmOiENWQBqM7RDOMVxDu99nmnENQbtBHcdgZU2Xo+/z+/N7+5D+lxbcOgK63pcdLn4xSJWH9L2WUXRUVz7P9WF2wXafycq/T04GPp6mSh8pludTSa4Zth9YzM7flptMFWBAgQsvOGrgLH0uRGQ0wtW1L1R9uGBMPHWWpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783672; c=relaxed/simple;
	bh=EwZ+r2sp13Z36WnP68NkaE8aE4xyE7rUwsM87YH7wk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJDOVZSFlxCPMBV0Fv6LfWSMBFaxHVKcUUg6riDexdzOQo2+QVow/ImpqxipzAvLQHbcNeARmoleKp0Uzx1/eKklBujTeNMkU6dSfhdiuO926jU7wJ78R1LfUruN2LJglgtFSKjjktteKyBjYaSeYwP4HkdnUsa5FR9UJKnk8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OquQQuj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23017C433C7;
	Tue, 13 Feb 2024 00:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783671;
	bh=EwZ+r2sp13Z36WnP68NkaE8aE4xyE7rUwsM87YH7wk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OquQQuj5EcPCOpVJ6Dx3GSYl/fKfQ5SerYnzo4839WDNx8n943MAyTrbE84KInO85
	 Fhx4fhOXwrgBZSV0xLWv2DElqpto4UHZRm5bGKqIPjOyi75bJeXJXjFgdyw34lcoTb
	 qJKh5RzG16i2wrs3FR8/SMZksEtQ3FvYR19eLzGD0Bm6iOu+IcyXqBWXrs+D3EDz8i
	 fdQgsda65HwBhUc7tMJzYBPW/cg1k+LYsxEAVld/mH3e89hZHgyAUczQ9O/4PwonDS
	 Utzq8wc3X+4trF0GTxxgEv4qog6X8NyVHlAd9Q0k4cVPViwni6dHH9Ht8ooZR64KPE
	 tlMV9OSfseLag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ism Hong <ism.hong@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 16/51] fs/ntfs3: use non-movable memory for ntfs3 MFT buffer cache
Date: Mon, 12 Feb 2024 19:19:53 -0500
Message-ID: <20240213002052.670571-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Ism Hong <ism.hong@gmail.com>

[ Upstream commit d6d33f03baa43d763fe094ca926eeae7d3421d07 ]

Since the buffer cache for ntfs3 metadata is not released until the file
system is unmounted, allocating from the movable zone may result in cma
allocation failures. This is due to the page still being used by ntfs3,
leading to migration failures.

To address this, this commit use sb_bread_umovable() instead of
sb_bread(). This change prevents allocation from the movable zone,
ensuring compatibility with scenarios where the buffer head is not
released until unmount. This patch is inspired by commit
a8ac900b8163("ext4: use non-movable memory for the ext4 superblock").

The issue is found when playing video files stored in NTFS on the
Android TV platform. During this process, the media parser reads the
video file, causing ntfs3 to allocate buffer cache from the CMA area.
Subsequently, the hardware decoder attempts to allocate memory from the
same CMA area. However, the page is still in use by ntfs3, resulting in
a migrate failure in alloc_contig_range().

The pinned page and allocating stacktrace reported by page owner shows
below:

page:ffffffff00b68880 refcount:3 mapcount:0 mapping:ffffff80046aa828
        index:0xc0040 pfn:0x20fa4
    aops:def_blk_aops ino:0
    flags: 0x2020(active|private)
    page dumped because: migration failure
    page last allocated via order 0, migratetype Movable,
        gfp_mask 0x108c48
        (GFP_NOFS|__GFP_NOFAIL|__GFP_HARDWALL|__GFP_MOVABLE),
    page_owner tracks the page as allocated
     prep_new_page
     get_page_from_freelist
     __alloc_pages_nodemask
     pagecache_get_page
     __getblk_gfp
     __bread_gfp
     ntfs_read_run_nb
     ntfs_read_bh
     mi_read
     ntfs_iget5
     dir_search_u
     ntfs_lookup
     __lookup_slow
     lookup_slow
     walk_component
     path_lookupat

Signed-off-by: Ism Hong <ism.hong@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/ntfs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 67ce2eedc9bd..f4c0a424a0ea 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -1035,7 +1035,7 @@ static inline u64 bytes_to_block(const struct super_block *sb, u64 size)
 static inline struct buffer_head *ntfs_bread(struct super_block *sb,
 					     sector_t block)
 {
-	struct buffer_head *bh = sb_bread(sb, block);
+	struct buffer_head *bh = sb_bread_unmovable(sb, block);
 
 	if (bh)
 		return bh;
-- 
2.43.0


