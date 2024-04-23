Return-Path: <linux-kernel+bounces-155061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB8A8AE4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA89F283CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B42B1442EF;
	Tue, 23 Apr 2024 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrncRGiv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21E71448F4;
	Tue, 23 Apr 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872484; cv=none; b=M+L1ap5uD0OkyqxZ78hwuPbxaI0k4d4HDjwqi9eDO0j+tstFMjtkcJEGFmV3v9J/8LN6zzZeSd5VFBvHt8n+hYciiRPJs6+UMA4/ggZCh+KrWklqn6+CP1aTpL0kqkSYUhknD+orhnw6zZMHyLkqbWFhrMw+LIkCDNp3tSEgF18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872484; c=relaxed/simple;
	bh=9m8FyTxQoOWe9YS8ZXYB9PO92DE3oC2qzBetu28vvQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/bjL4Tz/NCmNsbxizE9ifGkI9lSBa213/aiQfzKSW4YrDWqWSpB2n5y6ztny/VI8puqJd4cJ6UVFByoLYmPG6N1YTW2i49mdCh5fYf4CC/ME2WaMxBP9jxcwP6z5/hb5U9/gZkXUglhGjFDaMrqs1m2NSmbBQ2FIlU2VZXU66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrncRGiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A206EC3277B;
	Tue, 23 Apr 2024 11:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872484;
	bh=9m8FyTxQoOWe9YS8ZXYB9PO92DE3oC2qzBetu28vvQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UrncRGivnNkVmwU2n/20+UDfX+/eT/9JjXR7IXFbutUM6lh1xdWNsTAOugiLsmS02
	 rU7KvH4NZprdKT03GAAB7t3ylk8LBxRDLLQ94nedz4fryKFqUX/yEYgc29V18HNJow
	 FK6hwXXL5SO2vL8wCs1Xz96UQO2chbs8E1qZAbsUB/05UBenqPNwxGepVLCqxftCwe
	 Zx22GmiiGDSf7RqTJ+uBJhq8F6ghkvKSjUCA+ys+dyZglx/WK9zLWy1xrS7CbwZ1Tj
	 scZWWW+lnIyNbadRR8u5Qa6SpowWcHElnks6H3FlxgnU/hSUDPK4Wn2ZUYWynlQaWr
	 uXNWH1b3Ktufw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 7/9] fs/9p: drop inodes immediately on non-.L too
Date: Tue, 23 Apr 2024 07:02:29 -0400
Message-ID: <20240423110233.1659071-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110233.1659071-1-sashal@kernel.org>
References: <20240423110233.1659071-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.156
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
index 7449f7fd47d22..51ac2653984a7 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -340,6 +340,7 @@ static const struct super_operations v9fs_super_ops = {
 	.alloc_inode = v9fs_alloc_inode,
 	.free_inode = v9fs_free_inode,
 	.statfs = simple_statfs,
+	.drop_inode = v9fs_drop_inode,
 	.evict_inode = v9fs_evict_inode,
 	.show_options = v9fs_show_options,
 	.umount_begin = v9fs_umount_begin,
-- 
2.43.0


