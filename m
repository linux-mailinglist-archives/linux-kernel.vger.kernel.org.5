Return-Path: <linux-kernel+bounces-155017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ADB8AE469
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369CD281D75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A229131E56;
	Tue, 23 Apr 2024 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJJyCS8q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04DF130E3C;
	Tue, 23 Apr 2024 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872415; cv=none; b=pitPbR3HBNZIsDbMBVC9uN55LSip/JGbJJ/twu/3/HxEUhv2gmEGu3Qwe+AzL9maTphMC6vxoGA0kRoNwa8yn/SNLiX6Vk9WpKdiICPuP5wK0paZCYCja7H9mq2FALn/S+s+qzi2H7bLUf1tOVYFzca3zrF4zNbMymzdZtvzYlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872415; c=relaxed/simple;
	bh=BvNLKMcCWGHoQCy1k1rj+7vqHXefuyqu/ekLhxggMCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guvvlcI03wuHErx++UfIgOEnZC+NxtxG4DKQapTcYEm9VXCXR3wP2cyfM27fUIQsa97B/5a7SEvombBGaQRADmWa8aASf0pthu4Lnkm57DVUIEZDPcagb1kv6NyGYqhbCXq9Ds15L4NLuSuomysdE6FgogtYGyytuCe7O+bbcJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJJyCS8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA017C116B1;
	Tue, 23 Apr 2024 11:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872415;
	bh=BvNLKMcCWGHoQCy1k1rj+7vqHXefuyqu/ekLhxggMCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJJyCS8qRGbbHW+XXVRXVSzqPB5EKIewCpkDK0e8RbG4AUElCu/xo8TpqE6LF2Y/+
	 07JK0r9JlFqVEKN0eQMl3JbaWqoZJYnGJn3ohHWiTNDmjGVCQ2YdKwZEt83zda2FxK
	 Ck62/5x8wnAN3B42z5k7rh7KUsgpARxdgt8G5jBiE6BHF4pQcCCW/GezdFjligItij
	 ZcJlEUJnGCbeFiIt8O2FYtoE4lx8nAPxHDBD67bPkyGzZztSybvIOw06NzDqhJLUX6
	 XVTysYgROkwNeyfHhrTheDDnXwlKbqRS/VnvSotzYfYCqPAkk94GtcQf8TI1tBXPT6
	 zQ41THI+h7xYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 09/18] fs/9p: remove erroneous nlink init from legacy stat2inode
Date: Tue, 23 Apr 2024 07:01:05 -0400
Message-ID: <20240423110118.1652940-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110118.1652940-1-sashal@kernel.org>
References: <20240423110118.1652940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Eric Van Hensbergen <ericvh@kernel.org>

[ Upstream commit 6e45a30fe5e7cf5d42ac07262a3d97644f23dc68 ]

In 9p2000 legacy mode, stat2inode initializes nlink to 1,
which is redundant with what alloc_inode should have already set.
9p2000.u overrides this with extensions if present in the stat
structure, and 9p2000.L incorporates nlink into its stat structure.

At the very least this probably messes with directory nlink
accounting in legacy mode.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index ffb76ec3cd9b3..fa185e50d0fd3 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1148,8 +1148,6 @@ v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
 	struct v9fs_inode *v9inode = V9FS_I(inode);
 
-	set_nlink(inode, 1);
-
 	inode_set_atime(inode, stat->atime, 0);
 	inode_set_mtime(inode, stat->mtime, 0);
 	inode_set_ctime(inode, stat->mtime, 0);
-- 
2.43.0


