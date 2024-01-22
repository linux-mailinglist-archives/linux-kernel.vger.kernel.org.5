Return-Path: <linux-kernel+bounces-33429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7880836996
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8831F240D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ED686AEC;
	Mon, 22 Jan 2024 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZd+CdPh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6886ADC;
	Mon, 22 Jan 2024 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936263; cv=none; b=Wox4v+38eVB8AtGN8z8h9YgbCVt+Y4TETMEZ8Jvtoqyf/hNgHN+uiF3U/vrF4qw3wXaR0KlcIs0uJczmtI2QeKBQHBVS/+2jPawYGePWB6BnrOUtRcmao3Ie2nlwbfKF0BoMqCPV8D7SR8Rusbatz6TA0NDoTlrJNKsCY3LeBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936263; c=relaxed/simple;
	bh=Uuq2rRSJLTxs+pWhQ/k6UA6moVrOeLwsL+aGmFLaAy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPW5ybHaLo/jlDDZyauZNrJVt6PKQb5pDEYCvhd5BPhsdjTFx0qCkRrTsxg5FPABTDZtj055/HU8AVmcosMvuJo+bgE0XEaa3L0q6BtlIU2HEaJndcW7MHraAl+JaJ6ZAUB3oVjbqlbILeeSva208Ig61pw0uiWF+Ilc9be85NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZd+CdPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E331CC433A6;
	Mon, 22 Jan 2024 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936262;
	bh=Uuq2rRSJLTxs+pWhQ/k6UA6moVrOeLwsL+aGmFLaAy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZd+CdPhX3vEiBya7N4lS1lUcjSG+gmm1vBXUjMAQrRtrOKIiwxI34M1krQ8Fh+Hv
	 l+7RBW+JS4L4n3/V/QpHQJuVt9OhTJUDWvQpDvxQYcmDV1mEgwKI4Tmp7u+reDAYPm
	 OXXiEq/zo2JKfHXxpSiTpBfwznalZADWO9BF/zHhqPVAlmy5mkGsFI+4ayPk8nUEw4
	 vjpgrnFJj7L6M0HMUyZjvdH1I0fPwqLOgRf6Rwh1N0avIS3UJxyBEdoUw80q/4xhPp
	 3i9Xa1wcKwXt1DW1Bv/AbbHTou69hb82GYgglQeMjrg533wgVYIdKmLhbcn+gQdq0Y
	 xN0nkPa/fw+cg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 29/53] f2fs: fix to tag gcing flag on page during block migration
Date: Mon, 22 Jan 2024 10:08:30 -0500
Message-ID: <20240122150949.994249-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 4961acdd65c956e97c1a000c82d91a8c1cdbe44b ]

It needs to add missing gcing flag on page during block migration,
in order to garantee migrated data be persisted during checkpoint,
otherwise out-of-order persistency between data and node may cause
data corruption after SPOR.

Similar issue was fixed by commit 2d1fe8a86bf5 ("f2fs: fix to tag
gcing flag on page during file defragment").

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 4 +++-
 fs/f2fs/file.c     | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 4cb58e8d699e..3d9f6495a4db 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1026,8 +1026,10 @@ static void set_cluster_dirty(struct compress_ctx *cc)
 	int i;
 
 	for (i = 0; i < cc->cluster_size; i++)
-		if (cc->rpages[i])
+		if (cc->rpages[i]) {
 			set_page_dirty(cc->rpages[i]);
+			set_page_private_gcing(cc->rpages[i]);
+		}
 }
 
 static int prepare_compress_overwrite(struct compress_ctx *cc,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9b9fb3c57ec6..d69abe32d91d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1326,6 +1326,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			}
 			memcpy_page(pdst, 0, psrc, 0, PAGE_SIZE);
 			set_page_dirty(pdst);
+			set_page_private_gcing(pdst);
 			f2fs_put_page(pdst, 1);
 			f2fs_put_page(psrc, 1);
 
@@ -4032,6 +4033,7 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 		f2fs_bug_on(F2FS_I_SB(inode), !page);
 
 		set_page_dirty(page);
+		set_page_private_gcing(page);
 		f2fs_put_page(page, 1);
 		f2fs_put_page(page, 0);
 	}
-- 
2.43.0


