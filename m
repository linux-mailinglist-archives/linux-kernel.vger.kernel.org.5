Return-Path: <linux-kernel+bounces-41731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A507783F717
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E912899CD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2BF60887;
	Sun, 28 Jan 2024 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdCFNJED"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF436086D;
	Sun, 28 Jan 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458414; cv=none; b=lLXKT2bUeLaxuqgWxaqt8y9MzfpqUm6225aGO+GOVjn44BWXjePd8lz9EK9tEm6HkCbPBUzIRIwSNzbsLOWsoAQjpjcby+Vu4DfnNYg+sEGjDBt2r7X+/esbpKbUX9CJrYMiOqJPqahoEgObAlRNSELU/zKrRsPfPVNCq8//jtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458414; c=relaxed/simple;
	bh=uMnD0aUO2l3M2khXx2m/8Vx9nla+p5h2CdRabr2cOEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0gGvrX/FVnj+K32mV+jF5lAFyK/wFvvAsoBF3GXjayOlZZDyXOwcFQqDJON3xvMBDBgwodP8DJItRDkx9lB8M5Ep/Vfl0EgqC0MQZBX62uEpVnMfosFjZ77nU43d8vAb2MH3kMA195dNLdfmBz+9IRPsDUCVQ9wbWDyxuOvEXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdCFNJED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF01BC43399;
	Sun, 28 Jan 2024 16:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458413;
	bh=uMnD0aUO2l3M2khXx2m/8Vx9nla+p5h2CdRabr2cOEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdCFNJEDpD11hDgNXw4uPDRcIm+A8+O4e3dLdiKKrD+0dKCnFS19RMF3nkzT58xBr
	 LTzBbEwiN01/Y6/XuWDr/vBDb3JyY8bt9HEErvcgrKKpwdh2SP7H9cSn7xC2CDofzB
	 tUDpwU/za4qA2cBx5PQWbQdGff0zI32c/nOIlfaR43geIx9UxSmKNTEvsyN46rWq3n
	 zTi8l+PsVp65tAKCOvCtQkRAj8BnO3XtlZFXZCeS+g1b+Ojr+VNUYURiLnFJpA2Ex6
	 8tl1aiQkSDHvAwC/mqKZ0nlhDpIdSLnDZFrY15lZTDa9GFiA7RlKFl8fLj7L0QcHE+
	 wzEDEw0erzhtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 10/31] fs/kernfs/dir: obey S_ISGID
Date: Sun, 28 Jan 2024 11:12:40 -0500
Message-ID: <20240128161315.201999-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161315.201999-1-sashal@kernel.org>
References: <20240128161315.201999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
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


