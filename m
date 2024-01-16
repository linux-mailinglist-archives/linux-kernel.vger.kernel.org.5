Return-Path: <linux-kernel+bounces-26871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9832F82E730
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3053B1F238B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D72D2C68C;
	Tue, 16 Jan 2024 01:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJHvFIvA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689962C1AB;
	Tue, 16 Jan 2024 01:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F5DC43394;
	Tue, 16 Jan 2024 01:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367267;
	bh=oEjV2xh5760T10+916bQRYqAKJfi9+GPgkG1q+OikOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJHvFIvADAP++cy2fRbadnpvzbi7Wh+cUsTU3FG25vh3aJv1LbDi+jMIq9shDGxBo
	 PQKGaKmBQCjxtyFhoehk4HMmnVH3ouzeFdcMa6j4VrHlznZNsDRdlGTCX0F+tni48W
	 9LzekXpqmazxswLl8Q/y2F+AfiCU4yLm4h+kvNrZeT69bPrB4Zx4KLds6Fjgae+grS
	 1IZ9BJXmgClyGuoHuh5AJcI9uXMb2CuNl4NBldOvGkvBsLwnz13Ig6AUQ0Ilo9IZBR
	 JuqE5lKcR8uamq0dwlnNk9l+W3nfI62qfykHnz56nh39LPFrSqyqmw7hk8ZvAkZJO0
	 b09rLDEYyYRWw==
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
	stefanb@linux.ibm.com,
	walmeida@microsoft.com,
	ecryptfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 07/11] ecryptfs: Reject casefold directory inodes
Date: Mon, 15 Jan 2024 20:07:07 -0500
Message-ID: <20240116010729.219219-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010729.219219-1-sashal@kernel.org>
References: <20240116010729.219219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index 16d50dface59..bea4c2b0cd6b 100644
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


