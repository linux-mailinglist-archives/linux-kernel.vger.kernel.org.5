Return-Path: <linux-kernel+bounces-26860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF5882E70C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 661BFB2108B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692E250F4;
	Tue, 16 Jan 2024 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I71KF8eC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10C424B34;
	Tue, 16 Jan 2024 01:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4812C433F1;
	Tue, 16 Jan 2024 01:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367225;
	bh=/WAHI9k0/jbUSpT8uafSK1Q7FDl154jdzd0/RW07pfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I71KF8eC8YX1yRb1SxtEw/ubaA84bOwmhiGzTaTb2QaCMGmTlx7h84clX0pXmzemN
	 UFfY5LCtnXg+7Oe41xBQkLSaMLzUfEJBzooHzgGF0RJhfK7Y30YksC4D2gnuuHn464
	 n1ZhZklw/TpL70mPQNf+n3XdXQib4PlIgmD4H8FZwxyUryNUO4ffN/pRfzxv7ffrl+
	 631/BE+etY+Ov5AYYKCZpyxLnPKRFRyqFMzb+zEOlFcGCeFQVwtFQjK5eMnwr+17aZ
	 5O5tGIhyYKVcMX9xKlZoy8G7JeAmNAoBix/bmDaPnKl15MqBsDitnWpSojlOW+fGRw
	 0K4SrP3L7K23g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Eric Biggers <ebiggers@google.com>,
	Sasha Levin <sashal@kernel.org>,
	code@tyhicks.com,
	brauner@kernel.org,
	dchinner@redhat.com,
	jack@suse.cz,
	jlayton@kernel.org,
	walmeida@microsoft.com,
	stefanb@linux.ibm.com,
	viro@zeniv.linux.org.uk,
	ecryptfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/14] ecryptfs: Reject casefold directory inodes
Date: Mon, 15 Jan 2024 20:06:12 -0500
Message-ID: <20240116010642.218876-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010642.218876-1-sashal@kernel.org>
References: <20240116010642.218876-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@suse.de>

[ Upstream commit cd72c7ef5fed44272272a105b1da22810c91be69 ]

Even though it seems to be able to resolve some names of
case-insensitive directories, the lack of d_hash and d_compare means we
end up with a broken state in the d_cache.  Considering it was never a
goal to support these two together, and we are preparing to use
d_revalidate in case-insensitive filesystems, which would make the
combination even more broken, reject any attempt to get a casefolded
inode from ecryptfs.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ecryptfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index c214fe0981bd..55340ac61456 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -76,6 +76,14 @@ static struct inode *__ecryptfs_get_inode(struct inode *lower_inode,
 
 	if (lower_inode->i_sb != ecryptfs_superblock_to_lower(sb))
 		return ERR_PTR(-EXDEV);
+
+	/* Reject dealing with casefold directories. */
+	if (IS_CASEFOLDED(lower_inode)) {
+		pr_err_ratelimited("%s: Can't handle casefolded directory.\n",
+				   __func__);
+		return ERR_PTR(-EREMOTE);
+	}
+
 	if (!igrab(lower_inode))
 		return ERR_PTR(-ESTALE);
 	inode = iget5_locked(sb, (unsigned long)lower_inode,
-- 
2.43.0


