Return-Path: <linux-kernel+bounces-116205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A7F889D86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784702C2E56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F290285281;
	Mon, 25 Mar 2024 03:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDv/P/6p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5455C8EC;
	Sun, 24 Mar 2024 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323815; cv=none; b=WYlt9WmCVuthVCl8b51DUBLC7RJVi2Dx7fm5t9SAV9TULDb6rrj1ZcAKTUt2PTR4f/ajatkSs+fdDgHQzEu4lKFFOmRzoWaGUBhwPhHsJ9bAmjS/yvy6HqpVtDBDFC9vboQ5gfIt2mwjF1fftA/LPEFIacDNx10YX9YKKhz7Hp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323815; c=relaxed/simple;
	bh=lWPRf6moaMYWz9EKtqw8AWmfhvGPBVr8HEaPz5qWn1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZE9nudWYpaYaEUOCx9j5prnR+7oMOuPlNn9W96+j/W+od2EHu4E7/+nV/l0Rn+trcpJvn/Wh5A83G6VLqvjx3pcYOI8V0O0G1cWTcUt+knQz1NVuYUvS3ReFKid4cUvvQUzvFApjP3XlvGrs/OvNiXfDH2kYgU/VReCRilaMRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDv/P/6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AD1C433A6;
	Sun, 24 Mar 2024 23:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323815;
	bh=lWPRf6moaMYWz9EKtqw8AWmfhvGPBVr8HEaPz5qWn1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RDv/P/6prcxRUx+On7caPpCexDyJm63gcd+38FeIr1P26tFUUp2R7n6WOLyyRJFeN
	 bmsmh9GtYB/wZVVhh4XqD4rYLuAoS6cJE7Bj/x6nEVezc4gfOB8I+YtYoKGR0Li+Xx
	 otBjOMEK7GkOcpoYpzBg7kieYCD04TqZjryJcAo4SEM12Aifp4EIRVUF5xJ6peumDn
	 uHy1cy3IeaL85Fyfi60t+VwGSQM6GeQgADkuCcmKWLW5u7Q6Lrv29nNDmS9qbrjeEh
	 OQHz8+LFF0751b4EUBSJt17KHB3cz1zWWYKOrAO9+cFJz2U3Abcly4hC/Ygd+RanqF
	 qvKUcDMVgzbpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sheng Yong <shengyong@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 194/238] f2fs: compress: fix to check unreleased compressed cluster
Date: Sun, 24 Mar 2024 19:39:42 -0400
Message-ID: <20240324234027.1354210-195-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Sheng Yong <shengyong@oppo.com>

[ Upstream commit eb8fbaa53374e0a2d4381190abfe708481517bbb ]

Compressed cluster may not be released due to we can fail in
release_compress_blocks(), fix to handle reserved compressed
cluster correctly in reserve_compress_blocks().

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Sheng Yong <shengyong@oppo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 55818bd510fb0..40e805014f719 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3663,7 +3663,13 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 				goto next;
 			}
 
-			if (__is_valid_data_blkaddr(blkaddr)) {
+			/*
+			 * compressed cluster was not released due to it
+			 * fails in release_compress_blocks(), so NEW_ADDR
+			 * is a possible case.
+			 */
+			if (blkaddr == NEW_ADDR ||
+				__is_valid_data_blkaddr(blkaddr)) {
 				compr_blocks++;
 				continue;
 			}
@@ -3673,6 +3679,11 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 		}
 
 		reserved = cluster_size - compr_blocks;
+
+		/* for the case all blocks in cluster were reserved */
+		if (reserved == 1)
+			goto next;
+
 		ret = inc_valid_block_count(sbi, dn->inode, &reserved);
 		if (ret)
 			return ret;
-- 
2.43.0


