Return-Path: <linux-kernel+bounces-155086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C9F8AE521
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30F2286C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BBF14B08A;
	Tue, 23 Apr 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6WL/1ks"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB537130A6C;
	Tue, 23 Apr 2024 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872528; cv=none; b=NiploOnDzW5WGhjkZhF6pRpqqdvd2Qk5Q0kVTzv+Dmbzqey8eqSTUM2DzEd1fRHUUPjnb19a3PRPQNhykKHS3A3PZwqNcFjVP1AhVM5peKTd/RUhZCmQs+d6ROlaLei/DUYCBhrszn8DHsG91+ay27s1lQ1KUPIjTAYuq2ft04s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872528; c=relaxed/simple;
	bh=Kvm46gz7dc5HjTw0rsOrBcTJgY5BTDwR9R5K2p+PS/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WA184WCZxPAHGp4cXXizpia9E+6OxBt29ZyT/Dof/++uC0rwep+0JLaVEzneSFeH647TCNQp1bEsXIRMeqegdRDNk5MRFb5BIS7+hwoe5xlGUZacIzogCX5raGBXcKJJnOlLnjjjWFCaY1ZTJb9Q3JbJy5QpiKHHHH6lDhPH62g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6WL/1ks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AA7C4AF07;
	Tue, 23 Apr 2024 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872528;
	bh=Kvm46gz7dc5HjTw0rsOrBcTJgY5BTDwR9R5K2p+PS/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6WL/1ksXUSYHs7TvP/sKoM14u9aCeoSFvpF6HuT6fEBK6N7BveiKESvZKBcN2hcx
	 5zBwAbenNM+lO/Sgf6tnE2QR7FOASeqPSSJP40CTV7FeghK/q6tBYBUhm1CUfD5fNU
	 6vnplexRB1/E/Bv9RbKdo0cwQY1qo9sCRvQYZu6wymgGja+TdhfhU/PPq8WaCUZokD
	 aBh+97KSFYnLPioh0kYD88kVwN8qYdIXqJOssUSsdhcpkuloLiuNl8X4J/ct713jYp
	 gFp4Yqov0jsQmhtMuzPTbjPbhUtKcG22SR3odgUVEXhCoRumV7cl+vylSHYP+yPgTR
	 d4tqtBafFeFFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 4.19 6/7] fs/9p: drop inodes immediately on non-.L too
Date: Tue, 23 Apr 2024 07:03:16 -0400
Message-ID: <20240423110318.1659628-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110318.1659628-1-sashal@kernel.org>
References: <20240423110318.1659628-1-sashal@kernel.org>
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

[ Upstream commit 7fd524b9bd1be210fe79035800f4bd78a41b349f ]

Signed-off-by: Joakim Sindholt <opensource@zhasha.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index eeab9953af896..b47c5dea23424 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -346,6 +346,7 @@ static const struct super_operations v9fs_super_ops = {
 	.alloc_inode = v9fs_alloc_inode,
 	.destroy_inode = v9fs_destroy_inode,
 	.statfs = simple_statfs,
+	.drop_inode = v9fs_drop_inode,
 	.evict_inode = v9fs_evict_inode,
 	.show_options = v9fs_show_options,
 	.umount_begin = v9fs_umount_begin,
-- 
2.43.0


