Return-Path: <linux-kernel+bounces-62635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CCE8523E1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5E0280DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B177B5F56B;
	Tue, 13 Feb 2024 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUUk2P2L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB745F49D;
	Tue, 13 Feb 2024 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783659; cv=none; b=f6wUt8TNHrzdN/M5Y67kS4HR214A0jWEIiOF590rr47nDP5yb+zLrEFkxbmFZMDBAuGfzRnrXtSzXsTtWuM7IhJbLCm57O27zfWsAstqTiG2Aq9zB3xF4/ZglyWP6GhOKHTicTbQFj4wmMIYHdBjv8texhUXuXpAHRV2dlwWxag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783659; c=relaxed/simple;
	bh=EzQ2KcUnhJXj2Q2vq6bE1COdIka4wDLbwKnLfWJxmyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bn+f85xQVYAxD26FiZRoCkbcEycOudkXmvag1MWxICOAHHol43FSmKD3QHISe3ZFl0mafEx/6uXQqWtz/ca+6tL8ePki0aTdiQ7rg0amXR7MeIXeCexY7IIa2uOGhHVGtRLZ2+r9DWHrw1plf4SiD7IVwjbOhpPo83iu+5mUbGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUUk2P2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EA7C43394;
	Tue, 13 Feb 2024 00:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783658;
	bh=EzQ2KcUnhJXj2Q2vq6bE1COdIka4wDLbwKnLfWJxmyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sUUk2P2LfFWuieSfH3WyZZmAI95UzsRXzzKAtnSFXv7D0ESjA2isxysLqp7sXa+4x
	 O0VRqP+xyOZuIhIRn/Ud6m5R5fQrHLOsJgCJzCjTEwFz1L+cL3ZjA4WBJRz4GU7DFw
	 kKEh9TnhLQDnhLi0kNvsHmpYw6Ib50Vtyy97sVV2kfz6Hgt0tx7GO4XkOqnWj9/vbI
	 drSEcPxxNQDUd9dCataR52cb1rb8641t4NuySjxE1VjVHe1hZWqTe+L4lTS4wKga2g
	 KqAY3T4GJhxrZgrqMX9bEep9l8gdWA9WOXNkyq3710rT2OINFnuidM+lIMCj31KpOG
	 Xdtet1Sztq0tQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 05/51] fs/ntfs3: Print warning while fixing hard links count
Date: Mon, 12 Feb 2024 19:19:42 -0500
Message-ID: <20240213002052.670571-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 85ba2a75faee759809a7e43b4c103ac59bac1026 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index d6d021e19aaa..fb0466c11504 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -410,7 +410,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		goto out;
 
 	if (!is_match && name) {
-		/* Reuse rec as buffer for ascii name. */
 		err = -ENOENT;
 		goto out;
 	}
@@ -425,6 +424,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 
 	if (names != le16_to_cpu(rec->hard_links)) {
 		/* Correct minor error on the fly. Do not mark inode as dirty. */
+		ntfs_inode_warn(inode, "Correct links count -> %u.", names);
 		rec->hard_links = cpu_to_le16(names);
 		ni->mi.dirty = true;
 	}
-- 
2.43.0


