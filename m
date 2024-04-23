Return-Path: <linux-kernel+bounces-155070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C638AE4F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C65284722
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C21F1487CB;
	Tue, 23 Apr 2024 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdmEEgFz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB758148307;
	Tue, 23 Apr 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872500; cv=none; b=BRBCN2pv0apu8jYDy4SHgmEteR1cuzTipVAl5FLBWfZMVJuGL3qCFxVh2/1t/c3JLrsSXswvU77BzGvsoc0qF1FE45vpEHqNIOo9BPMp5TBOm8fIWgtWrT2bLJntBHnWd1kqiXeoXjZHQTcGXPqn+9gSHhfg1BSH4hI7YBWh3rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872500; c=relaxed/simple;
	bh=t23TwOi5w+bP522WTVJSXeuUPILhCzD3wkjfJBovz78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebfV5RkRUyiD6PP+jBzRVQoWWNZmVIEiT8XtgOFiiACo02Bf+UyuQpmeOw17HTV3fXOHAb8IDaLYp7t9Lk6dMzYdSqM/fxa6kxLUeLUQoEa+e7ukcpgdCmye4HV4xuOfVhqSstFyHzLsM3EmiDXy64hZYidA3JdhB+f6ntWHj4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdmEEgFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F70BC2BD11;
	Tue, 23 Apr 2024 11:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872500;
	bh=t23TwOi5w+bP522WTVJSXeuUPILhCzD3wkjfJBovz78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jdmEEgFzHRCDqrweUJhLRsBGSgwVN4VLy+WNqFSlaOOBH0puA9+SS/tLVD22VgOCP
	 fgTmP5BYgh9KKkyr2plSYPx97VnXKblUCJwWXdq5yYtYVqi8Wt69HPYci0wGgjtSGv
	 snDjhk0hExzfvls3u0m3qelhuLxOki6aU15Da8P7mnNwV9YDNjkg2ioLz4OIAy/S2n
	 UGQGHv6bz58T6ENOo4ZDsKGbzBKMq3ZpyBZj9RWAH4pK7VyfVLLO5UWQMQrbWVdRJO
	 G/yLPZHZURThm/BBm63TZnduJRhkocXXvTP5Sia+VTOaP83Ea99ldfCgVlUIdLG5/L
	 8jLe0TXGwyOXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 7/9] fs/9p: drop inodes immediately on non-.L too
Date: Tue, 23 Apr 2024 07:02:45 -0400
Message-ID: <20240423110249.1659263-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110249.1659263-1-sashal@kernel.org>
References: <20240423110249.1659263-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
Content-Transfer-Encoding: 8bit

From: Joakim Sindholt <opensource@zhasha.com>

[ Upstream commit 7fd524b9bd1be210fe79035800f4bd78a41b349f ]

Signed-off-by: Joakim Sindholt <opensource@zhasha.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 9a21269b72347..69e7f88a21e7f 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -336,6 +336,7 @@ static const struct super_operations v9fs_super_ops = {
 	.alloc_inode = v9fs_alloc_inode,
 	.free_inode = v9fs_free_inode,
 	.statfs = simple_statfs,
+	.drop_inode = v9fs_drop_inode,
 	.evict_inode = v9fs_evict_inode,
 	.show_options = v9fs_show_options,
 	.umount_begin = v9fs_umount_begin,
-- 
2.43.0


