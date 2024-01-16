Return-Path: <linux-kernel+bounces-26750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD19E82E5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F611C2042E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6CA1F93F;
	Tue, 16 Jan 2024 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJFAW9fq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FA9358A3;
	Tue, 16 Jan 2024 00:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EECC43394;
	Tue, 16 Jan 2024 00:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364738;
	bh=MSEH59YR9chEdOpA6eOIdh14BxQmO+6NTx5igEosLdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJFAW9fqAxqIXMHbGSFefLtIcq6M06AY/K/V+JtkSOB4g1YgwW0EuE3+FFTrIk0pZ
	 KOd7PDvaAmv8oMJRmvCv1hd0cuLoYV0KvNNaCyG0Tc7kV4p75R+3Q7l08zKK5OpWw3
	 Lgc36HFNWJ6rm2o5SAkokftaoQre/UhlytHB0uKZi2wlgAWiHQIfw6D2IEwEz7+Bez
	 CyqlebOeemwe3+PdR3l3leY+46r6Z/1+OSppOSye/d14r69JR1FtoZoY7B1qfppMdc
	 sCEnygueJOVPNqhMnob/Khs5nHLRXqSmumMgK/+wHoBtSfWCUCaHQ5B6VnMZIfI5oX
	 GNdN+vNkQ+2JQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Sasha Levin <sashal@kernel.org>,
	xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.1 09/14] erofs: fix ztailpacking for subpage compressed blocks
Date: Mon, 15 Jan 2024 19:24:51 -0500
Message-ID: <20240116002512.215607-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002512.215607-1-sashal@kernel.org>
References: <20240116002512.215607-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index 1b91ac5be961..914897d9aeac 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -652,7 +652,6 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 
 	if (ztailpacking) {
 		pcl->obj.index = 0;	/* which indicates ztailpacking */
-		pcl->pageofs_in = erofs_blkoff(map->m_pa);
 		pcl->tailpacking_size = map->m_plen;
 	} else {
 		pcl->obj.index = map->m_pa >> PAGE_SHIFT;
@@ -852,6 +851,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		get_page(fe->map.buf.page);
 		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page,
 			   fe->map.buf.page);
+		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	} else {
 		/* bind cache first when cached decompression is preferred */
-- 
2.43.0


