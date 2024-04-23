Return-Path: <linux-kernel+bounces-155052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A038AE4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FE11C22B56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77891420BE;
	Tue, 23 Apr 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y++veuZi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C3A1422C2;
	Tue, 23 Apr 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872470; cv=none; b=tbhmeRjB/Q/rNnB5HoKgPrpNo6Vmd873oCVsahRJ3ZWGenAazusPhabGUJzzKSkat4MK2DDrOSefXXX+40TSs+AN9HcfV7f7m2/gxKWnUfMPkaYkBHoxvkMuqwd/RXjiDXcSTQIg2j+pmEmOel9rYckKbU6FVyMHbn5fI229Z/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872470; c=relaxed/simple;
	bh=HcSBdtjvR/WpiV02VSCCRi6NLGr5CDzNXPkN97owS6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSiCuR7TtvYfpPRpL/C8HH9x+Ao+XKU6ORo8UtzDye1a/fv8X9DxkpfSI+XaMO/2+YF08vpPmPk8pxld5OTHPDHPBFLEQJr+3L8oIm5mYpWpl47GSyCVnN+LhchngKT01RYhRTW3WQEbWJ7AUExwbIebPo3suS7ic7JdXS6aT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y++veuZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D698BC116B1;
	Tue, 23 Apr 2024 11:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872468;
	bh=HcSBdtjvR/WpiV02VSCCRi6NLGr5CDzNXPkN97owS6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y++veuZiAZztmn0y0jwpr9GBRJV+t/Wot3tQ8o5VKixsT7+n3cGSXjI7H6WTl855e
	 yGiokGkn0968lHekB+Zk16YRXnk81m+89pD6y7pk0/vLo8mSbeyj0UHkhGSXXYX2rW
	 U4AELyQN8h5RujXhS7r3A4437oV5+gnyUKC+u7odZwf2TcJr57roLgfmSH2boIAvW1
	 DKnPq14R4nUdn6kO9biEbz/h9zp+2lY7n578I83N0jOZGAbjFl4niAsyFKTHc/mI5c
	 H9udf20FLDvfMD3wr6FexSQaQ9sPFWH4SrVRUiw1ChDmD3FxtpAKIz7bRT1mglib+6
	 nu2tN0UE0oNQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 7/9] fs/9p: drop inodes immediately on non-.L too
Date: Tue, 23 Apr 2024 07:02:13 -0400
Message-ID: <20240423110217.1658879-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110217.1658879-1-sashal@kernel.org>
References: <20240423110217.1658879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
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
index 2d9ee073d12c3..7c35347f1d9be 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -342,6 +342,7 @@ static const struct super_operations v9fs_super_ops = {
 	.alloc_inode = v9fs_alloc_inode,
 	.free_inode = v9fs_free_inode,
 	.statfs = simple_statfs,
+	.drop_inode = v9fs_drop_inode,
 	.evict_inode = v9fs_evict_inode,
 	.show_options = v9fs_show_options,
 	.umount_begin = v9fs_umount_begin,
-- 
2.43.0


