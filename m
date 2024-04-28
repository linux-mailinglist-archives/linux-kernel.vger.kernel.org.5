Return-Path: <linux-kernel+bounces-161207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D67098B4902
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE161F21B7C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 01:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE1DEC3;
	Sun, 28 Apr 2024 01:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG+ypf0o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456BF64A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 01:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714266768; cv=none; b=c9K2fuuR4OO/Cfr8fzuqZYNsJSGLKPQmm1WAozx23LWq5R0g4zPhgz6JuAA0aV/pZgnYFsfKHsKoGWTgzakZNIPghB1NyBi8ADTIVuM5FqwXSbzd/HhFOJ7+3zT/zSYF0DOPfUDmy8cJLEOoAwoJYGmnmanh+POiLea9nS+5k+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714266768; c=relaxed/simple;
	bh=xjeZ5fQxU+mJQrQpiO4Ugsfp3+1alUdFzcKpzBYO5Dg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m9x2K64DkeFOIU6jbd62j90feg274c73QNS7GbGudEA4IdwOT7QeUyWPy0pEQnrIeO7OFjD+iwaqLXJHGu77l/ySnfAq8YqDV80TXUfOqO4ko2q2ReoGW4KlJFksCs7bXEjbpsrVnwysj5mSdp5A28fCLTsqI+s4su/Fn06o9jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG+ypf0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A105C113CE;
	Sun, 28 Apr 2024 01:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714266767;
	bh=xjeZ5fQxU+mJQrQpiO4Ugsfp3+1alUdFzcKpzBYO5Dg=;
	h=From:To:Cc:Subject:Date:From;
	b=PG+ypf0oJGq4ZZsBiMn8nrZ4uzXKnlxuK8Y7A7mHk2Hspw3OSPaETCMs4uaokKWJq
	 w7BYdvUzhktGl9JuZ4qlXXNamPPwnWDLGwwiJwLZoa+5imsltMhc3jDiNb6IlEZwzc
	 DFKv5tTjfqvxxshjgxNMJRb7oeIdfGh519IV/Pvg5BbEXZUI52AyWVeDNxnnttWnn0
	 0iEsbP2nVO8TLakkB9/AomDcGiJszM89n3P+iCVm4gr6qyjfPJSPix+2jbJt5oI9XR
	 5oTJJu7dRI28s0K1R3U5MjJVIIc+/svLAMToZELoPmcT0xldfIEBxx3TpNHeEYOAuj
	 wCJDj9N2HJksQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daeho43@gmail.com>
Subject: [PATCH v2] f2fs: zone: fix to don't trigger OPU on pinfile for direct IO
Date: Sun, 28 Apr 2024 09:12:36 +0800
Message-Id: <20240428011236.1008917-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise, it breaks pinfile's sematics.

Cc: Daeho Jeong <daeho43@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix to disallow OPU on pinfile no matter what device type f2fs uses.
 fs/f2fs/data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d8e4434e8801..56600dd43834 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1595,8 +1595,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	}
 
 	/* use out-place-update for direct IO under LFS mode */
-	if (map->m_may_create &&
-	    (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO))) {
+	if (map->m_may_create && (is_hole ||
+		(flag == F2FS_GET_BLOCK_DIO && f2fs_lfs_mode(sbi) &&
+		!f2fs_is_pinned_file(inode)))) {
 		if (unlikely(f2fs_cp_error(sbi))) {
 			err = -EIO;
 			goto sync_out;
-- 
2.40.1


