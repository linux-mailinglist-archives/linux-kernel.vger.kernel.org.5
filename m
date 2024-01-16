Return-Path: <linux-kernel+bounces-26716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FD982E584
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511CCB23729
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FAA1BC46;
	Tue, 16 Jan 2024 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKfdsbmc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF9F1BC35;
	Tue, 16 Jan 2024 00:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E900C433C7;
	Tue, 16 Jan 2024 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364622;
	bh=nJS/xUVs3DVD242EqR2wk6o4QyZNJsOWFys5JzDh3vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKfdsbmcaUyZDxcU6GKzTqb7Xtdf2s7pPz0UJtzuYqs6he3DIPtOcTy02Hdz7LzaE
	 8RRxBgNn6xODzSg5V50CSVCYVWSLBvTNoTNQW9ekcTksH/3BpkN87NUTrbLQ4QOq2K
	 1LKryXot41ewC1CQaUJR3J8q7lvYJLP2krPkTXsoBYTE0XpETNOZ+zqETYcead3Oqz
	 8PCpfrYAT3zmvjTaiggtf4/y8j6iOSdRttjjI+GiS5TZyMYasetHg4jsKp5Khdl5YN
	 JEaOrA4l/MxJiJ/dumpNXWX4giid+K7ZiGdnubrtB9sOlKlxDRypaCsBR03ZJag/tS
	 K45k629gmpdIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Sasha Levin <sashal@kernel.org>,
	xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.7 13/19] erofs: fix ztailpacking for subpage compressed blocks
Date: Mon, 15 Jan 2024 19:22:49 -0500
Message-ID: <20240116002311.214705-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002311.214705-1-sashal@kernel.org>
References: <20240116002311.214705-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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


