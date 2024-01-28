Return-Path: <linux-kernel+bounces-41806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FBF83F7E8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0488286D29
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4870B13DB9C;
	Sun, 28 Jan 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgkwXj0D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8762C4F1FF;
	Sun, 28 Jan 2024 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458575; cv=none; b=nZPAVvb9GCzbu+OYcGGnxf8aVhk/a9TgnBL+vRJy2iegGSM4sW1Ag75fLJ41fHjB6PevwhboNzUrpnULCOBYkqYQHZaloGcErhK0hBN1thlOwLP/5D/ZH6E9fE9CYt3D9QFG7dJdFXH5eU/yv47uPHFNaIhFBBVuhjJY2HgifbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458575; c=relaxed/simple;
	bh=bRb2TgQA90tQ63dWvVFph0qMSAhZizRyeXQGobEQo5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcW7kciQYzQnOhBMJCaPbJTK32P56AX5cHnrdPnCi8QzeY547TAffX62PBAgpM4MPsog/t3mI0HG875T/lN8Xu2eshZCL42wmzSIdHXkyTYX84pbjOfCRYxDGizYmx9e96tq8HxCi6/Yq+FKMDAERvHMdDC5kHiqvGfg3Zllq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgkwXj0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8202C433B1;
	Sun, 28 Jan 2024 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458575;
	bh=bRb2TgQA90tQ63dWvVFph0qMSAhZizRyeXQGobEQo5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YgkwXj0DcTeiuiC6KL5/MXDaCIzb1+3BOlLSiOEzFqGssnCO+SgTBt6vPkCwO+IYB
	 2w4bjVCoUEn5wDFbDWZfpY+UyvUYBRfb/zM/aSZsZfeynWv9dJsMQzDeVBg8+pZmVD
	 VjnGtO1na9mwXeqz8xefbyFMX4UTTYYz9XDKIpCVisbSZr96S/BdsLGYejqI/cLjiB
	 dVB/28AieTKDxXafdVfq8pgT1Yglx4JwCKvdKy+60mrWROSeCcKoGOtnS8GCTFsVB9
	 ej0fUm3HchnkYV/Ea9OKp2Z+2V9mxgXHAWPoC7DDXax+41ZNjMTrj6nvsuqRTrVSrv
	 xAxieQ2TbAcwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 05/13] fs/kernfs/dir: obey S_ISGID
Date: Sun, 28 Jan 2024 11:15:51 -0500
Message-ID: <20240128161606.205221-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161606.205221-1-sashal@kernel.org>
References: <20240128161606.205221-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit 5133bee62f0ea5d4c316d503cc0040cac5637601 ]

Handling of S_ISGID is usually done by inode_init_owner() in all other
filesystems, but kernfs doesn't use that function.  In kernfs, struct
kernfs_node is the primary data structure, and struct inode is only
created from it on demand.  Therefore, inode_init_owner() can't be
used and we need to imitate its behavior.

S_ISGID support is useful for the cgroup filesystem; it allows
subtrees managed by an unprivileged process to retain a certain owner
gid, which then enables sharing access to the subtree with another
unprivileged process.

--
v1 -> v2: minor coding style fix (comment)

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20231208093310.297233-2-max.kellermann@ionos.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/dir.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index c91ee05cce74..0ba056e06e48 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -696,6 +696,18 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 
+	if (parent->mode & S_ISGID) {
+		/* this code block imitates inode_init_owner() for
+		 * kernfs
+		 */
+
+		if (parent->iattr)
+			gid = parent->iattr->ia_gid;
+
+		if (flags & KERNFS_DIR)
+			mode |= S_ISGID;
+	}
+
 	kn = __kernfs_new_node(kernfs_root(parent), parent,
 			       name, mode, uid, gid, flags);
 	if (kn) {
-- 
2.43.0


