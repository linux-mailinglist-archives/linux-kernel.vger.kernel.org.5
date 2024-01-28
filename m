Return-Path: <linux-kernel+bounces-41693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE9383F68C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B0C1F22A15
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8198645BEA;
	Sun, 28 Jan 2024 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaGLwdWW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D345979;
	Sun, 28 Jan 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458311; cv=none; b=dNuGQN+EaKC8MoK06FSN2gmNKMXH1mXxbejgIpsIGtpYfO+L/QknIKRGiLhmtoReYi5K4fUyqMMFzQuQdvr5u0ltsyHLIwYBvJP4WPTalgJ4LICmVxPzub9OJ28UV647A1BjSQByt7oSr8NxcubnlEVUqxNKCi2YcgZU7yNQr0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458311; c=relaxed/simple;
	bh=uMnD0aUO2l3M2khXx2m/8Vx9nla+p5h2CdRabr2cOEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2t0N4dlCT3VCul1VWPc+zIg3+V3DcJFNoV4ZKTZk3cupg+HBgbupLh50jJs/2YUapdAtkWLZCK1DZZX7HP5ff7IJVkW4JQ9G+DHulsQLHcKah1njZz5O3zX1EwPYgEDacrKGbK6G/CTkvi/MLwiua6zuZN35GIPh3lCXK/dmJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaGLwdWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2DAC433F1;
	Sun, 28 Jan 2024 16:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458311;
	bh=uMnD0aUO2l3M2khXx2m/8Vx9nla+p5h2CdRabr2cOEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LaGLwdWWi9AL7Y3QMPGSS8GQ1hOKKUTXpo311vhBalW/LC0tsIUfU4AIymZ4w1S/6
	 Pe0j2kFwQoiPPeWFGwSkOPoApcft+h05zoDHawbZiCe3TnH1DuPj8c9IvNV2yGJ47g
	 BqiSHM+4sLXaC2Ps9FAkIsaOE1CYjZtr1yes0SzvOKlsKe6rkiTamrrKzy9/uAVGC9
	 ju8uwEn6JhZLZNt3x5eqh/GLaeFaV8Kv7Y7LwEjkLDlhx28dhWRO08YT3hekgeIIWB
	 NR9qp73j3fOC8L6IlDMSIozTDKWgoCpNnnHPhxdk3xk9SE5LyspnO3frtGcmTWddh4
	 zQ6+oojchV+Wg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.7 11/39] fs/kernfs/dir: obey S_ISGID
Date: Sun, 28 Jan 2024 11:10:31 -0500
Message-ID: <20240128161130.200783-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
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
index 8b2bd65d70e7..62d39ecf0a46 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -676,6 +676,18 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
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


