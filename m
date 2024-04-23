Return-Path: <linux-kernel+bounces-155073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF568AE4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65141F2374D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5307514900F;
	Tue, 23 Apr 2024 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J17tNQI2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333412E1D0;
	Tue, 23 Apr 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872508; cv=none; b=SzSJqDAEktegifsTMRggW/wF9a0yw8R00cMPygxd57DnBhn79LanZvkfvmOwV0//vT0f2pkiiebFwAnRODbR3xBsKGaxWU9wzWZM0SSKgFh0PWWCj6qGdR2fnPzvkzUwrz6xPVgw3ORvHMm2QlIa++Nb6n/ftK9RfUnP0mjj9Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872508; c=relaxed/simple;
	bh=pmImJOr8DDRxhRjMOnn2kZl+bhavqWcU8HHrzgazx14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGNQ6aG8yiz+IsAwcf53/EnsZ8Fq1LqhCXnt8KOHR/C1JPAEkzdqoWDp6Ybykd6TCfPOkpA9/y9wnmMseiYy//yCPF8zkqraw9vIjTdZZdKh4tWUrjM0OI91KZdpEc79kuww+QfaqMYYTzy8eLvR6t/pgSJaLIOnpJshphFaZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J17tNQI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D15BC116B1;
	Tue, 23 Apr 2024 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872508;
	bh=pmImJOr8DDRxhRjMOnn2kZl+bhavqWcU8HHrzgazx14=;
	h=From:To:Cc:Subject:Date:From;
	b=J17tNQI2cHETkjpYJXwrf/9o/HhFNaIaLjd12G5pgbMGOvbqmWVu4lPc7xDR2fe3Z
	 zxc/9/mLkXXjE9SkcoCnKMiX1osB/c8hwIyuG/cHNp6AtCpE0z2azbsEE3mj3Vbtx4
	 ZET3W1489IvNJEXQWhblxzcnDdBuws5jTBq5jtv0RnonYd8P0q1wo2GfsMyl+0Bj0L
	 glCD4kFLPOYuUVPg9/IX+mrEzGajA+EAo8c2vvtTKwpB3nrd9+xynQmxrZbviiDQra
	 6uhwkgamS1ec6TIszZ0hhpRnW2zip+8QijapOPErgzr6AF34Rlg4BhHiqUCm5ZwVjS
	 xyQyVi4SVEgmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 5.4 1/8] fs/9p: only translate RWX permissions for plain 9P2000
Date: Tue, 23 Apr 2024 07:02:56 -0400
Message-ID: <20240423110304.1659456-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
Content-Transfer-Encoding: 8bit

From: Joakim Sindholt <opensource@zhasha.com>

[ Upstream commit cd25e15e57e68a6b18dc9323047fe9c68b99290b ]

Garbage in plain 9P2000's perm bits is allowed through, which causes it
to be able to set (among others) the suid bit. This was presumably not
the intent since the unix extended bits are handled explicitly and
conditionally on .u.

Signed-off-by: Joakim Sindholt <opensource@zhasha.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index b82423a72f685..b1107b424bf64 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -86,7 +86,7 @@ static int p9mode2perm(struct v9fs_session_info *v9ses,
 	int res;
 	int mode = stat->mode;
 
-	res = mode & S_IALLUGO;
+	res = mode & 0777; /* S_IRWXUGO */
 	if (v9fs_proto_dotu(v9ses)) {
 		if ((mode & P9_DMSETUID) == P9_DMSETUID)
 			res |= S_ISUID;
-- 
2.43.0


