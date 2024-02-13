Return-Path: <linux-kernel+bounces-62720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA328524C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDC41F23CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983F3249F0;
	Tue, 13 Feb 2024 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQS2LYbx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF80B8662C;
	Tue, 13 Feb 2024 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783821; cv=none; b=MgrdkfasY08GHd/hpmBRcr53t5z5UkrviU6SO3s3iRBSBy5m0XiPwUXgcc2dHV577heRlNlOfULprfATaOV5KerVw0e8bjD54SGgCbZDPLbOsRWFIbpomx6NOmHuGWXPGoMcJwvaOzaoJdh4rT0Am7eMrPzULBbBuNXsRejrfj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783821; c=relaxed/simple;
	bh=UAQ6coV5L356dVNTgRuY/gDz3yQUXHgdubHyhCh4aew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOKJp+PpgeO3I+Z1eQB59hpfzw4bRdlrV6czrHNEpTcZN+DDBqLYWv0V3IpfgyMo7+bRDRVUPZtgt97RUC4JHl1ZNIoEiPzMfuE9S6mJnwuiIiAyRaOTnryhu/4ous9x3RNvU7mVpfXGH48iVFHkzv0r8xeEPa0VOC+8rfWIH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQS2LYbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21B4C433F1;
	Tue, 13 Feb 2024 00:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783821;
	bh=UAQ6coV5L356dVNTgRuY/gDz3yQUXHgdubHyhCh4aew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQS2LYbxikm4F+QmOQjxEI+Hl68Mq85AQxzxuSEc7yyiGVgzE8+mMkYSnR5UcO8Zg
	 sbJz1KBbiyFZhZah3Oc9oQq+7fZqpFdu7dUpIGsBCEZqK6RHTHoyo5xeMSBNy3vA2H
	 rLL0S4T67wSTppBFNyc6yDIo4roQrT06jFGSjMGoMJdmoxQZljvNl6NivHr1VBfpMz
	 ilhVmDR2ullxscLAUey6lxZNn/dfssFwJ113h5IcZy4ZY3fKPD9hO/KLq+LpQkw93K
	 z4KQ7MCywEQB1F4zYhYA0GYv7Z1klujxm5FML7021k2IQQIhy2vnb40woc0oVJRCef
	 wI3yyvKBAhL8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ism Hong <ism.hong@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 08/22] fs/ntfs3: use non-movable memory for ntfs3 MFT buffer cache
Date: Mon, 12 Feb 2024 19:23:10 -0500
Message-ID: <20240213002331.672583-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002331.672583-1-sashal@kernel.org>
References: <20240213002331.672583-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 510ed2ea1c48..713b7e3888bc 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -1014,7 +1014,7 @@ static inline u64 bytes_to_block(const struct super_block *sb, u64 size)
 static inline struct buffer_head *ntfs_bread(struct super_block *sb,
 					     sector_t block)
 {
-	struct buffer_head *bh = sb_bread(sb, block);
+	struct buffer_head *bh = sb_bread_unmovable(sb, block);
 
 	if (bh)
 		return bh;
-- 
2.43.0


