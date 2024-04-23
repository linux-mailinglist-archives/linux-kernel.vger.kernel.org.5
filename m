Return-Path: <linux-kernel+bounces-155035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CA18AE49A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC7D1C21F40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51BE13C9DB;
	Tue, 23 Apr 2024 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuAa3sBt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3C13C90D;
	Tue, 23 Apr 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872446; cv=none; b=bmDN1HMHimdba4ghr2SKBR0LcaadirJfELu2UCLlQfYErK6TSZcdDSZ/B96ONt/VcrAGCguZctDi5WCvKwWXW3d7Q574I3kzcZgI3x/9SXNElKVZtcJxRandCDzq6eAUj/y+nTTfsVl7mdad7vzDU+XkepwL4/Mbk900dEz72iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872446; c=relaxed/simple;
	bh=Ob2pg1U19ulU6JyplQ7wVAGZ3N/W8N42ahSg0TngTHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LogZpkfFbk+SF+buMU32kz6ilEuSpHYiQ7MXRwIko4Vt1JHpcxF3RY7S57pLad2d4fUv0zWiw6TwwUb38JYx8Wh1uGImd3wGniK+necpMkFLdnOP+5qZaKv8ehTDLMpf618IS8wYSlFiJpLWXKgYK1av5MID7ieLfYeh7ZVOkrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuAa3sBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4605C32783;
	Tue, 23 Apr 2024 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872445;
	bh=Ob2pg1U19ulU6JyplQ7wVAGZ3N/W8N42ahSg0TngTHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XuAa3sBtVAmhFxQE2AXmj/QSZig+HI7c79KTZhG+Xn+OavESO8Syf6hRYSj3hNQk8
	 K6n2li/l967UmbyQn9T8NoZd03ghKnAzb7GZYD88E7cX2Mjq9vzgsqv1Bv/ap95Unc
	 0a3uiyMQ4jPLOoip0W3hKtA/bxSZLSlWiFpomI2vsynCgjrYruU5IABxWGWxmFDGOm
	 oW/SdfZ5G7fPjBC/umRkiT5/Td7p6eW2D5Abb9XrxA2ya1YzcP/0FjIXhJfl8pfxo2
	 lBRbXYwjaFDYutgXxshkK+LaUIcJLOV2QjD36WLSkeaz+Xyc6oQSmeEDC1CGGjwmH0
	 FLfkrj/DDdFMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 09/16] fs/9p: drop inodes immediately on non-.L too
Date: Tue, 23 Apr 2024 07:01:42 -0400
Message-ID: <20240423110151.1658546-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110151.1658546-1-sashal@kernel.org>
References: <20240423110151.1658546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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
index 73db55c050bf1..958efc8423334 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -320,6 +320,7 @@ static const struct super_operations v9fs_super_ops = {
 	.alloc_inode = v9fs_alloc_inode,
 	.free_inode = v9fs_free_inode,
 	.statfs = simple_statfs,
+	.drop_inode = v9fs_drop_inode,
 	.evict_inode = v9fs_evict_inode,
 	.show_options = v9fs_show_options,
 	.umount_begin = v9fs_umount_begin,
-- 
2.43.0


