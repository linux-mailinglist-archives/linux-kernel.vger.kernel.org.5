Return-Path: <linux-kernel+bounces-155079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D28AE50F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC721C22C75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1116C149E04;
	Tue, 23 Apr 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWnzDF63"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28C149DE9;
	Tue, 23 Apr 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872516; cv=none; b=l552xAmAGjQivHllqN1Iu+KBQs8MUCwNn/JsZRk5V+46QMjTw4tKRqWvW/UAxnq6nVsAg/bu/Kd8FRkGxqvFyz1x3UIQAZYHSn1qqmsWX/aon6g92zsyS5uK0fqJx43l82IbDIAm6oLP2fdUGHdDIvc1GLhmbkGSnkZsOO36Idc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872516; c=relaxed/simple;
	bh=fg6jESquKhYYZR8V7mh3F9Gr4KLTbMAN5AvyOmROtPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hb47pPkDB+5rOOC15OOUcwyUm7T2yNkTS453kh+L/1Nq+52nL1FIQIsYEM/ndZtcGNgJ4edqgWYSCiQpfeYBsTsx3k/UEHZc47DWJu9O6zhw1yvxWNQDUpZwtKynKCmzAgZ0JKSdCIVfrurOo7Zv9wajMhSz3Rn0TMT0C5lz2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWnzDF63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4027AC2BD11;
	Tue, 23 Apr 2024 11:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872516;
	bh=fg6jESquKhYYZR8V7mh3F9Gr4KLTbMAN5AvyOmROtPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWnzDF638J0T/oL0ecr6mPVvcYsEGxeYVOaNsv3BweB55RLRlvHs2IbdI0j4ovdqG
	 YdnukPAO5XqKnNhu52vZW9Y7TClC1GQMe1Cb+lj4zS8/ZvxUnoeVsR5HbH2tFsLdeD
	 XW54scjF687pqEnezbmx5/zp6dEuYeMbVpRq7O2Akl17uOUAm5A4iNBVFkwypepf4C
	 Z8MkymMn80XXqdUastqLVXyh90I2KuZDITBc/UubWiQkB31VQCzh8RPyYwetTiU2Kf
	 fFiYcy3YSrKkK1lQLiyEW6clrc0SMjJkoNDmYZwcgfmpgT/EVtOXzrLbB7Ro/oNwEq
	 h+ck660KhwRqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 5.4 7/8] fs/9p: drop inodes immediately on non-.L too
Date: Tue, 23 Apr 2024 07:03:02 -0400
Message-ID: <20240423110304.1659456-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110304.1659456-1-sashal@kernel.org>
References: <20240423110304.1659456-1-sashal@kernel.org>
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

[ Upstream commit 7fd524b9bd1be210fe79035800f4bd78a41b349f ]

Signed-off-by: Joakim Sindholt <opensource@zhasha.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 74df32be4c6a5..46e58fdf9ba54 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -335,6 +335,7 @@ static const struct super_operations v9fs_super_ops = {
 	.alloc_inode = v9fs_alloc_inode,
 	.free_inode = v9fs_free_inode,
 	.statfs = simple_statfs,
+	.drop_inode = v9fs_drop_inode,
 	.evict_inode = v9fs_evict_inode,
 	.show_options = v9fs_show_options,
 	.umount_begin = v9fs_umount_begin,
-- 
2.43.0


