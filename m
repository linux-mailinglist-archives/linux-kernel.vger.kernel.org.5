Return-Path: <linux-kernel+bounces-62587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27462852353
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82E41F21A03
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5755822EEF;
	Tue, 13 Feb 2024 00:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDdwh1Vw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9D22606;
	Tue, 13 Feb 2024 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783540; cv=none; b=BKezg3CPnZQx25V/GuZM7whzKaV4uzEDhzaQq2NNfarjtxWO6ISDJ8pLlJecbD/ninmpbSCdFJ965oF3X3BrsnODU/HW0P1ZY+GEYtp+iwB6us5tbh2PWwn15FutcKfRuPQnMl405jEVE2HNXKpXctAkJHrepTKgHSnRsCGuyxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783540; c=relaxed/simple;
	bh=mY0O5sa5EWaH5Fr+wyBmmGXWKtnAc6Sp50Mm5gXobWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBJYfSiGHn+JLlLyOQNeO6oNuldaLiS7w4irGJkA94Ow6cQ6pMzppXrexdnLNY+jPxIT8t6WgM4w1y7SulDy6OqdgSkqtJ2PztBLJQ6SJUuMKr5mrSsFBnGb1IpOENRR5KyN2ZbqDtzHu9RfLn0IT1CKHCfFhbRXcOtnT5RdMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDdwh1Vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F47C433C7;
	Tue, 13 Feb 2024 00:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783540;
	bh=mY0O5sa5EWaH5Fr+wyBmmGXWKtnAc6Sp50Mm5gXobWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDdwh1VweMA5xKzRA6W1g+ALhGa7LYGyYDGXAWvhmzW/ha3WMhzoEEOLHzB5Als6Z
	 NXAfM+LL0E6AfsgAWkxuZRRn+1VdCuPP5Ud1qtWmghtSS0jDMBXv9NA5RStWYWiQLb
	 pV53D1c0kwtMFZvH4yOojTIynPUMlLEiRqmyuZs+TYPjkcnBHRK/ZQxN13dJi20kcQ
	 dKG7DrNuY75qAjr42c2Ccv6/jd4K/1nqeODS/kTblbCwHRLbVUThRawHvi/r2eUUWP
	 Jg0FUH26zfJCAlc6WOguv4CRu50m9OEzF4QC9L7qQqGbFTDYfObbxuWzhzviq7TJsW
	 JavzxKtZDcC0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 18/58] fs/ntfs3: Use kvfree to free memory allocated by kvmalloc
Date: Mon, 12 Feb 2024 19:17:24 -0500
Message-ID: <20240213001837.668862-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
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

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit ddb17dc880eeaac37b5a6e984de07b882de7d78d ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrlist.c | 4 ++--
 fs/ntfs3/bitmap.c   | 4 ++--
 fs/ntfs3/frecord.c  | 4 ++--
 fs/ntfs3/super.c    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 48e7da47c6b7..9f4bd8d26090 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -29,7 +29,7 @@ static inline bool al_is_valid_le(const struct ntfs_inode *ni,
 void al_destroy(struct ntfs_inode *ni)
 {
 	run_close(&ni->attr_list.run);
-	kfree(ni->attr_list.le);
+	kvfree(ni->attr_list.le);
 	ni->attr_list.le = NULL;
 	ni->attr_list.size = 0;
 	ni->attr_list.dirty = false;
@@ -318,7 +318,7 @@ int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE type, const __le16 *name,
 		memcpy(ptr, al->le, off);
 		memcpy(Add2Ptr(ptr, off + sz), le, old_size - off);
 		le = Add2Ptr(ptr, off);
-		kfree(al->le);
+		kvfree(al->le);
 		al->le = ptr;
 	} else {
 		memmove(Add2Ptr(le, sz), le, old_size - off);
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 63f14a0232f6..845f9b22deef 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -124,7 +124,7 @@ void wnd_close(struct wnd_bitmap *wnd)
 {
 	struct rb_node *node, *next;
 
-	kfree(wnd->free_bits);
+	kvfree(wnd->free_bits);
 	wnd->free_bits = NULL;
 	run_close(&wnd->run);
 
@@ -1360,7 +1360,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 		memcpy(new_free, wnd->free_bits, wnd->nwnd * sizeof(short));
 		memset(new_free + wnd->nwnd, 0,
 		       (new_wnd - wnd->nwnd) * sizeof(short));
-		kfree(wnd->free_bits);
+		kvfree(wnd->free_bits);
 		wnd->free_bits = new_free;
 	}
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 6ff4f70ba077..2636ab7640ac 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -778,7 +778,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 	run_deallocate(sbi, &ni->attr_list.run, true);
 	run_close(&ni->attr_list.run);
 	ni->attr_list.size = 0;
-	kfree(ni->attr_list.le);
+	kvfree(ni->attr_list.le);
 	ni->attr_list.le = NULL;
 	ni->attr_list.dirty = false;
 
@@ -927,7 +927,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	return 0;
 
 out:
-	kfree(ni->attr_list.le);
+	kvfree(ni->attr_list.le);
 	ni->attr_list.le = NULL;
 	ni->attr_list.size = 0;
 	return err;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 65ef4b57411f..c55a29793a8d 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -625,7 +625,7 @@ static void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
 {
 	kfree(sbi->new_rec);
 	kvfree(ntfs_put_shared(sbi->upcase));
-	kfree(sbi->def_table);
+	kvfree(sbi->def_table);
 	kfree(sbi->compress.lznt);
 #ifdef CONFIG_NTFS3_LZX_XPRESS
 	xpress_free_decompressor(sbi->compress.xpress);
-- 
2.43.0


