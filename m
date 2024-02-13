Return-Path: <linux-kernel+bounces-62646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B508523F6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DCB1C225C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DF9605A3;
	Tue, 13 Feb 2024 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3KnluXU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D69604D1;
	Tue, 13 Feb 2024 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783671; cv=none; b=JaY2Q3u9z22OkM+Shehyd5i2ioi/o8Fta2xzP6yiaSZ9I39U2yJNT09h7D+HdHf7ESZNKgDRgXNkGBsbeST+Xj+qIDS7UWsyAMwxdsgQQzrprJXsqoTYOPjJmao7i2EZVcG5dFpKvChDBkB9oiza5L5YouCe8keF+l2XtRC29PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783671; c=relaxed/simple;
	bh=0Pc+ZPO7XtWj6QXmFhds+FWNY2iqUxxvrPvquViqx3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYd7saoafy+lRVrR3TsS+zd7xkGv+4O1ZTNUkF2OQKQPZG6Wo8dKMUpwuOt7W7aOpkQr+QoOj06cnciVRkHSZ5S1JLZqsT+fN310PyiNdESInaoAgbIPv2blTStz43azN+KMm2u8oEKFJUIOLIQ5SgxT4yHoo4awLOfsu9C9Rzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3KnluXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C77C433F1;
	Tue, 13 Feb 2024 00:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783670;
	bh=0Pc+ZPO7XtWj6QXmFhds+FWNY2iqUxxvrPvquViqx3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3KnluXUFGa/ezlKjYLsI2uBG8Mcj+U/RnNU0KBgglEzLLiDht958g09Qydact9Oj
	 foSaoPNEmYAshGReRMlDxp/GIdNjp7VWiGLdHjSizAjXmKbxTmRRUd3Xez3aCw18gp
	 9KI9nJWdGhQWf9wDAj4jaj4PmdPO/2WuRNOhKtvyrEPVecFvUaHM5voDZvk6FxqPMW
	 bkJ7RY8VnnoOL69m09/1SMQY2SDjTox6vyOK2aD55L5ql6Pfn2+OOjvn4gRKAZnikH
	 fl06TB+9kFlyx0ixxuWVgjaNzxsqhRyl1WsphZpfgXrbZcP5WASCh5Qbm/L4cj8MCY
	 cDhpbE5Y3ZL+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 15/51] fs/ntfs3: Use kvfree to free memory allocated by kvmalloc
Date: Mon, 12 Feb 2024 19:19:52 -0500
Message-ID: <20240213002052.670571-15-sashal@kernel.org>
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
index 86b43051f39c..a918d7283aca 100644
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
index 378e261e23b0..eb5060229740 100644
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


