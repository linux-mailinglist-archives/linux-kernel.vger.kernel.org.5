Return-Path: <linux-kernel+bounces-26785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534AA82E62C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9FE1C227CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29D55B1ED;
	Tue, 16 Jan 2024 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7MhXIBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7B55B1F8;
	Tue, 16 Jan 2024 00:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E93BC433C7;
	Tue, 16 Jan 2024 00:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364870;
	bh=U1W5pQlj86OTXYyy1mMdpAL+aASIiXWxG7conJBxU/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7MhXIBmZLrwr2fMJxEtW1jWDksUzLEdyigqLCd90+odLWxQoTMidyM3bhRuaaKfc
	 qqoM3ZK07g0Nt6BA7sbdGBQ/MxuNnDTS38tN9fOVo1ja/3BXK8MmyMgR2yiia4kFvC
	 GsNwn+Rgildu7bBaGA0EZrMC0tT3k2rIwrWsmQJicD+IzPD/c7lJYb4gwNjOJdY+RY
	 FOQCshOSGHeSCkRnhTUtnO8c40vfXAzM1ApO+3sVHjqqbKgTjVXTq8g3MViZV8Bjiw
	 DVAQ9wrnkEphxeID6OS6zgwWaZ2aCEF/qqNN0y0fPbdbkwHisH3dGxErbbkhNtbFkc
	 YQsjyVJUtAhjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+01cf2dbcbe2022454388@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 05/12] jfs: fix uaf in jfs_evict_inode
Date: Mon, 15 Jan 2024 19:27:11 -0500
Message-ID: <20240116002731.216549-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002731.216549-1-sashal@kernel.org>
References: <20240116002731.216549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit e0e1958f4c365e380b17ccb35617345b31ef7bf3 ]

When the execution of diMount(ipimap) fails, the object ipimap that has been
released may be accessed in diFreeSpecial(). Asynchronous ipimap release occurs
when rcu_core() calls jfs_free_node().

Therefore, when diMount(ipimap) fails, sbi->ipimap should not be initialized as
ipimap.

Reported-and-tested-by: syzbot+01cf2dbcbe2022454388@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_mount.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index d41733540df9..459324f3570a 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -171,15 +171,15 @@ int jfs_mount(struct super_block *sb)
 	}
 	jfs_info("jfs_mount: ipimap:0x%p", ipimap);
 
-	/* map further access of per fileset inodes by the fileset inode */
-	sbi->ipimap = ipimap;
-
 	/* initialize fileset inode allocation map */
 	if ((rc = diMount(ipimap))) {
 		jfs_err("jfs_mount: diMount failed w/rc = %d", rc);
 		goto err_ipimap;
 	}
 
+	/* map further access of per fileset inodes by the fileset inode */
+	sbi->ipimap = ipimap;
+
 	return rc;
 
 	/*
-- 
2.43.0


