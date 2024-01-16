Return-Path: <linux-kernel+bounces-26735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE82982E5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EC2283DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27212D620;
	Tue, 16 Jan 2024 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYkZn6QS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6EC2D611;
	Tue, 16 Jan 2024 00:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA47C433C7;
	Tue, 16 Jan 2024 00:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364684;
	bh=nJS/xUVs3DVD242EqR2wk6o4QyZNJsOWFys5JzDh3vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYkZn6QS7xVe1PmsrIkymBm0h1kmefl9VR1hNO0XW0BKaF8bxFbCOxYC80uM7h0/f
	 06tJvQ+JrG8RN9WNIe4+mV+Z79n7QVqJ/1gfAj0r5Ir243jYwHo1kYipLimkUcsqXi
	 rbhqmDpfjO7p6BhJPxvGz5T3kT34pAw8V4nTUBXfCFkUDERUh3KcqqfUhYIumryBHW
	 zquuPFpg+kt+QQjOCEkgc73uv4kS6xzAnaZ0Ye/9CM8sr/KWpAxu8fJ3fe0Gl9PFCt
	 JyvS7J7xCY96acH2NCDdD2uYRyvHcz7mRaVuwT47ZGC3aZwRr5xP3JQ87avZr3rU+u
	 d9Vp6jTZTlwCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Sasha Levin <sashal@kernel.org>,
	xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.6 13/19] erofs: fix ztailpacking for subpage compressed blocks
Date: Mon, 15 Jan 2024 19:23:48 -0500
Message-ID: <20240116002413.215163-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002413.215163-1-sashal@kernel.org>
References: <20240116002413.215163-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit e5aba911dee5e20fa82efbe13e0af8f38ea459e7 ]

`pageofs_in` should be the compressed data offset of the page rather
than of the block.

Acked-by: Chao Yu <chao@kernel.org>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20231214161337.753049-1-hsiangkao@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a7e6847f6f8f..c9ae96467d98 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -815,7 +815,6 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 
 	if (ztailpacking) {
 		pcl->obj.index = 0;	/* which indicates ztailpacking */
-		pcl->pageofs_in = erofs_blkoff(fe->inode->i_sb, map->m_pa);
 		pcl->tailpacking_size = map->m_plen;
 	} else {
 		pcl->obj.index = map->m_pa >> PAGE_SHIFT;
@@ -893,6 +892,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 		}
 		get_page(map->buf.page);
 		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
+		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	}
 	/* file-backed inplace I/O pages are traversed in reverse order */
-- 
2.43.0


