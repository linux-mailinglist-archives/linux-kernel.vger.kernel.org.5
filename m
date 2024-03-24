Return-Path: <linux-kernel+bounces-116003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB4788955A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2C41C2F904
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E9D178CE7;
	Mon, 25 Mar 2024 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po35YmbI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A892720F8;
	Sun, 24 Mar 2024 23:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323306; cv=none; b=rxlHktep2/V8BTCC8t+l0FqqjnZwK/1Mpyyid1h5Oy0isVDsjXFRf5HTg0MLYoBaKOXKKQ94uwMSuV6DKT3YtMTBr4Nlzt5AgPQ/3N4qDKygAtTVflTLlSkZwPsbCT+spzHvGkI9lN0IFXah9MS/JYgGuc+TtH6jbGLdJiM+Oe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323306; c=relaxed/simple;
	bh=jyUcNQ9GntSGfERNYUd4qRk75zDk8r3yKu0X3vCk3eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKTUWszvMzkTz+gd292Y2Do9QRj86IxaWP8a/w+YUID4XvJqa7O7trDFSX/OR6qrKWDPAjSfebV7laEp8sF9u8bjkXQLbcTLxdu8fFuDseananRgmrU2lUHY78FIj+qx2x3F42Jby2shzsILB+CokbCHrxSxffHVj4ZmhZzGatA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po35YmbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C66EC43390;
	Sun, 24 Mar 2024 23:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323305;
	bh=jyUcNQ9GntSGfERNYUd4qRk75zDk8r3yKu0X3vCk3eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Po35YmbI1RBBrl3w7JjcGXsa0lPOaHsn4XeLGYlyq2ePr7TKba+Mr/KiicCc3K8OF
	 DfmLNP5/Mm20FZgmkQJolz3uYAaq3Kn7uX5Lq/qHuNXPA8dofUx3eLDX+T8t1JgWQu
	 twVmEkB21AfMPGKH8DHk7MsW+x6SwXPVx+IRjSx+gP9bw6f84nUpAVjKpkcwVlqrl4
	 1BI7zpShvW4k9KBpYt22Bmp3WLHIoepijp/KpFufGeCtBsW1+qi4CgnCJ5yst9DQ5o
	 YwtqqVxNKi6udVk/SQDg1oMl5+6jD6wbQiaGhFzrCcS0LQiia9ruc1STOTb3n+hYI7
	 la6mTH5rCIUhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 005/317] btrfs: add and use helper to check if block group is used
Date: Sun, 24 Mar 2024 19:29:45 -0400
Message-ID: <20240324233458.1352854-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 1693d5442c458ae8d5b0d58463b873cd879569ed ]

Add a helper function to determine if a block group is being used and make
use of it at btrfs_delete_unused_bgs(). This helper will also be used in
future code changes.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 3 +--
 fs/btrfs/block-group.h | 7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 4ca6828586af5..a2bac7196d18b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1330,8 +1330,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		}
 
 		spin_lock(&block_group->lock);
-		if (block_group->reserved || block_group->pinned ||
-		    block_group->used || block_group->ro ||
+		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
 		    list_is_singular(&block_group->list)) {
 			/*
 			 * We want to bail if we made new allocations or have
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index a15868d607a92..f042c1c85a255 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -211,6 +211,13 @@ static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
 	return (block_group->start + block_group->length);
 }
 
+static inline bool btrfs_is_block_group_used(const struct btrfs_block_group *bg)
+{
+	lockdep_assert_held(&bg->lock);
+
+	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0);
+}
+
 static inline bool btrfs_is_block_group_data_only(
 					struct btrfs_block_group *block_group)
 {
-- 
2.43.0


