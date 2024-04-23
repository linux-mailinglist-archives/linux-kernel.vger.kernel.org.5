Return-Path: <linux-kernel+bounces-155081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69308AE515
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5DD1F21C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B15212FB08;
	Tue, 23 Apr 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+i7ow8Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56712F391;
	Tue, 23 Apr 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872522; cv=none; b=Uw2Fi1abkqNn+DBW9x9Kt4i6v+8LotZVNRzxtiU0DWTc2rX2OCYIJfXolE+Kqm67dQdYFOMWwzELl/I3lkw2CEOK85sdUIgbbMEPhbokDDGhmbYYuQbolpX/RWRP9gA3I839MTVNuE+xD1HQD1ovf12R2BqRVDKpSGblSAmjeVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872522; c=relaxed/simple;
	bh=0Ud8R7l2CREUg8OpwRFygPTfBNVAqjuYQEv9QhtbshA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TKbS77c6ArYyGxTmRIg5zZwFj7wohbXBMmLWdqu2QxfQpvnSEiFGvEGU7F4lLFr4HNsykdkufrxjr7oBeew4uHb5LtF3nJ5TB/MlfHBltxjGVrs7db7nxn5VwVVY6o+M8oyJ+CmMntit+lTfRB79Jc/YfODKLmx0iT7bl6E01xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+i7ow8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F98C116B1;
	Tue, 23 Apr 2024 11:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872521;
	bh=0Ud8R7l2CREUg8OpwRFygPTfBNVAqjuYQEv9QhtbshA=;
	h=From:To:Cc:Subject:Date:From;
	b=u+i7ow8YWVTNSA85iUhyogeEwXDnawg7OI8tsnstqgcVLddwW3wIH/O6eG4c+wvJb
	 +deYdxZiYgKOlQLUcv9eC4CHgRfmpV8QiHT/yws8qdXg/+VzlvgitP14yMiBTTehmS
	 PuGWH3xuZ8G59iGTACNj0QyJIonN/6YZ+IEOeSbsI1q4fsLk4z+p4kzSnuuyEIbiNW
	 rW8D8kx6Vh5Qz6g/hKH9aBkYDlvqbzXyCTk4tw0qypA7h3yWKX1lfZBhOlvK+qLqVj
	 nDUJ1sXsHn3G6RKxCnRE28Ziy9cywc6A02Iusn4FaAUV9vKR4v5OP5sHsLM6leXGfg
	 sVBsotMJlYVYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 4.19 1/7] fs/9p: only translate RWX permissions for plain 9P2000
Date: Tue, 23 Apr 2024 07:03:11 -0400
Message-ID: <20240423110318.1659628-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.312
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
index 72b779bc09422..d1a0f36dcdd43 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -101,7 +101,7 @@ static int p9mode2perm(struct v9fs_session_info *v9ses,
 	int res;
 	int mode = stat->mode;
 
-	res = mode & S_IALLUGO;
+	res = mode & 0777; /* S_IRWXUGO */
 	if (v9fs_proto_dotu(v9ses)) {
 		if ((mode & P9_DMSETUID) == P9_DMSETUID)
 			res |= S_ISUID;
-- 
2.43.0


