Return-Path: <linux-kernel+bounces-24911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FD282C490
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9F02839D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A4F2260F;
	Fri, 12 Jan 2024 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJjpyS+W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6410522603
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 17:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B79C433C7;
	Fri, 12 Jan 2024 17:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705079812;
	bh=lryv/farYg+kjJnYzgoPmLVHiOFuDwPZIzxjpW3gLXk=;
	h=From:To:Cc:Subject:Date:From;
	b=kJjpyS+WcmdNVBnqw2w0+DO9Nx1eDtj14ip+T9pZ4gGXCSR1tgVZBju9cf5qT7JaV
	 TwFkmGRPWyYxGd2Kdz353JHiLwRPBp7mo8biHW+YkVtn3cjgCbIg42f+t6o+cQI220
	 /V7LfJOaA0WIpnGaNuJF5fBFzD5Sb2GIYpL/fxfJBUCIVLt9J+XKHkYY/kYRJZw/CU
	 vZMTFfORwmK+mwkSEsZZD/thYi9ongQqzksdhZ+6wlkrdnTNlMUBbRrfvKvsPiDeY9
	 +eBWAQIrV9YAeLA/E8fkLbRpzxmdp2VFvUxNpU2axoHLnWOspls3U+UmGXeZmbXwhx
	 gJKVx299R+VIQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] f2fs: remove unnecessary f2fs_put_page in f2fs_rename
Date: Fri, 12 Jan 2024 09:16:45 -0800
Message-ID: <20240112171645.3929428-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[1] changed the below condition, which made f2fs_put_page() voided.
This patch reapplies the AL's resolution in -next from [2].

-       if (S_ISDIR(old_inode->i_mode)) {
+       if (old_is_dir && old_dir != new_dir) {
                old_dir_entry = f2fs_parent_dir(old_inode, &old_dir_page);
                if (!old_dir_entry) {
                        if (IS_ERR(old_dir_page))

[1] 7deee77b993a ("f2fs: Avoid reading renamed directory if parent does not change")
[2] https://lore.kernel.org/all/20231220013402.GW1674809@ZenIV/

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b3bb815fc6aa..ba11298b7837 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1105,14 +1105,11 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		iput(whiteout);
 	}
 
-	if (old_is_dir) {
-		if (old_dir_entry)
-			f2fs_set_link(old_inode, old_dir_entry,
-						old_dir_page, new_dir);
-		else
-			f2fs_put_page(old_dir_page, 0);
+	if (old_dir_entry)
+		f2fs_set_link(old_inode, old_dir_entry, old_dir_page, new_dir);
+	if (old_is_dir)
 		f2fs_i_links_write(old_dir, false);
-	}
+
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
 		f2fs_add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
 		if (S_ISDIR(old_inode->i_mode))
-- 
2.43.0.275.g3460e3d667-goog


