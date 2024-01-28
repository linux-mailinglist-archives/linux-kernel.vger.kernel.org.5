Return-Path: <linux-kernel+bounces-41790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EDA83F7BB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E49B2814C8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE02012CDAE;
	Sun, 28 Jan 2024 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmTNlocl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF3912CD93;
	Sun, 28 Jan 2024 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458538; cv=none; b=ZMuWaVMAYpYur9F1OAyKvYzySdvbcqdvaPGQ4ucXZS2AVvkpv5Cz/HfYT6PFQzyAp37UThKD6CcAqumq+GackLhMg/UWwPVYuddDzpp2w1MhWbyb1c8Gr9obltH7IspxZpgfrBX8UKEDu8l1HtpiG6LryaNSSJLiO6hoZwH5zxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458538; c=relaxed/simple;
	bh=+h8UwIgo2JSvj9tCrTavYxJpiKhEB2zmGZO2EJqh8zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJA4HCa9CRyiGhtLxlJVKqegDY73hzP9koXYsZfTEiEVVOg6OTLmp9xOi/eNNPuMADToBbzyN+wli1RV2UPkMmpUAQpVFgQ+jwchJ8BtwU38QFm1oY4vYvNHtrrH+t6Zz2C/Fq9NnpPaAEfShJmcqOoUwSsn6naYS+zLAqA0FdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmTNlocl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F1BC433C7;
	Sun, 28 Jan 2024 16:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458538;
	bh=+h8UwIgo2JSvj9tCrTavYxJpiKhEB2zmGZO2EJqh8zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GmTNloclwREBjKfnxjekxaWp3hudfeDvd9fcisp4oneUu0ReHN8pI0KksUBq6/8m0
	 OqhTkw1JL3eKS7SpnX39vaxJda79QUC8Px7kdXtApWTIrlHWqfPAxfqGjCisbbnm6C
	 AswKQQ/C5ltagPnVqu/H7TUtTmqOGixNH2tt7JhL3kckt+36A24xpTwT5saC2Dblj9
	 FifCBQVDXiKMY5WTOkDKudhZIL3L9m67efGDCcQrd+z8EsS/4xGM9d+pNnzFFdZyBW
	 QM86R4FC5Lb9b4+4bnvjyYAEucv5w1PxPX1WNq5/2dg0Xsa9OKFG8DPPqbydUYNP2W
	 epOPYPeRcBYGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 08/19] fs/kernfs/dir: obey S_ISGID
Date: Sun, 28 Jan 2024 11:15:05 -0500
Message-ID: <20240128161524.204182-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161524.204182-1-sashal@kernel.org>
References: <20240128161524.204182-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 6a1cb2a182b6..36430bdf9381 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -654,6 +654,18 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
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


