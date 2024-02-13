Return-Path: <linux-kernel+bounces-62574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C16A852320
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109281F216B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA058473;
	Tue, 13 Feb 2024 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX1JRwIg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687996FD1;
	Tue, 13 Feb 2024 00:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783525; cv=none; b=f4NWjzr/edoNT1GwbDEiC26sUloBJKqYffsY2YnmHRmNemYjpUjiWO7Y1/AUVi7V5eXUdHPgveT5pkvsxHIMTxrtjJZqg3ENna9pvHcqYXoA5INbjnKxg7fXPjCjVcFu176J0YgVOnNHQNBAv/J8IJnbt/IDoDyvyOeEwSedcjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783525; c=relaxed/simple;
	bh=uoSj6YHfddaZ734tvM57JwlsidH/pdKa4xw/pYK8Ky4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRm3/WNsl6pSjt7vGAJX0WTqe66GHHF2Y+/WgYuQ4zf6n2YRxlbFrWCAX68x9lgNfL7AxkSC8FBfBSf67pIfq6xifSN37eY9yk2Ghq1P3eNG7GpvB01STOe+FkXbQo7Gs0ZBTvTWpQDa73h1Z9pOa7CJAnwPE345jl3A/nhPi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX1JRwIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B480C433F1;
	Tue, 13 Feb 2024 00:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783524;
	bh=uoSj6YHfddaZ734tvM57JwlsidH/pdKa4xw/pYK8Ky4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JX1JRwIg4KCBaVvhcRd4i0OhHIwoPG5ZGslcBHZWVgMjXs0dMQ6Be8UpN1V/seFGV
	 PuZgIMzCTvGfyhRSEyJ4hnbRIkm1/fzlRW+XabieATwT8r3eSMMReGlU9zwNGUu/vY
	 c3gNxkJkI8rCrCasxse/30jtoV8NVzZ6khJo28L/zU/khiQjYzu4Vttp6T7oxe/0Ta
	 gOfcH59jwxCbjzORHC3XSPrEl4KwxE4aO/TQRDJ+tcuIT4yWl8h+SS2Uum+EP2xUGK
	 CrFdCaSu5QsGio4z5Hj8xKi6XODBL+PniDlPetNm0XbLg7iaTkBdsPlyxHvnzYNu7+
	 fP8r1xOh36crQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 05/58] fs/ntfs3: Print warning while fixing hard links count
Date: Mon, 12 Feb 2024 19:17:11 -0500
Message-ID: <20240213001837.668862-5-sashal@kernel.org>
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

[ Upstream commit 85ba2a75faee759809a7e43b4c103ac59bac1026 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 5e3d71374918..fa6c7965473c 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -412,7 +412,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		goto out;
 
 	if (!is_match && name) {
-		/* Reuse rec as buffer for ascii name. */
 		err = -ENOENT;
 		goto out;
 	}
@@ -427,6 +426,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 
 	if (names != le16_to_cpu(rec->hard_links)) {
 		/* Correct minor error on the fly. Do not mark inode as dirty. */
+		ntfs_inode_warn(inode, "Correct links count -> %u.", names);
 		rec->hard_links = cpu_to_le16(names);
 		ni->mi.dirty = true;
 	}
-- 
2.43.0


