Return-Path: <linux-kernel+bounces-80454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4245186688F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412A21C213F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB014F61;
	Mon, 26 Feb 2024 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkdIayy8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BA14263
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917562; cv=none; b=d3jX2Tipey6aVmBCkqhfARa+kcndWw984x5m3ixhfxn0gfQAQDa/ABLb++DWqvTNbchzfOotOq0LFisGOYCJG4/bKVqltgPGkLyFozaofxC609IbpsDdK5ihXdqv5LDG2ZKydgFPqhMQMAdRtQk6QCsEC4IuPQMFeQCngkhB9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917562; c=relaxed/simple;
	bh=Sz0jqU0v0tnHzoX+q1gyX1BWNEr6Uw1vZ878UbaRw+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OdDDH8DOpZFSqiuQXlV1q7YdRInld3W6fz4bD5gAOyagnYsKTqy5tpkGgKK6LEF/ww3Mj4fdW5MsklJ+RZ+ufpi31nRvgvqYnZWTbjsw/q1OUKc3wNwk59cBikekxiVPPxjy6L5zxxh64ggE2JnsVimBQHjAqMiNbripqMb96mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkdIayy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7B5C433F1;
	Mon, 26 Feb 2024 03:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708917562;
	bh=Sz0jqU0v0tnHzoX+q1gyX1BWNEr6Uw1vZ878UbaRw+A=;
	h=From:To:Cc:Subject:Date:From;
	b=nkdIayy8WuuXHCfivhW41LDvhKRAvve89Ehr0XoCveRNsV4v4Kelo/ZpsOlV/Eg+r
	 PxoMAuAfgTgOaNX2ibsqQyn0Qz6pgcjNxO3ScsvOQzXVFcUhTMpVV31pG2GelcA8RO
	 wANUevdAV3n5yqwv0PiSMc7qA90+P265iqNOWlxyXIqonAGCoCcF96MIjgzndLcZ4d
	 IO5+xAcdzr7BWd+M0c91iM7LAh0HMaYWwpN2q5g1VFBYc9D8l1KyDHXlmOB+0EMI60
	 pBGfV+D0Bt4GZiqpJbXHeKqgh//InS4JpPxDQusj6OaMacfBQgVYkasLDzpXiHq8nF
	 Zv8nuxqfAbijg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to check return value in f2fs_insert_range()
Date: Mon, 26 Feb 2024 11:19:16 +0800
Message-Id: <20240226031916.2420870-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In f2fs_insert_range(), it missed to check return value of
filemap_write_and_wait_range(), fix it.

Meanwhile, just return error number once __exchange_data_block()
fails.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6ddc2092842b..0a80fdf0cdb8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1679,10 +1679,12 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	}
 	filemap_invalidate_unlock(mapping);
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	if (ret)
+		return ret;
 
 	/* write out all moved pages, if possible */
 	filemap_invalidate_lock(mapping);
-	filemap_write_and_wait_range(mapping, offset, LLONG_MAX);
+	ret = filemap_write_and_wait_range(mapping, offset, LLONG_MAX);
 	truncate_pagecache(inode, offset);
 	filemap_invalidate_unlock(mapping);
 
-- 
2.40.1


