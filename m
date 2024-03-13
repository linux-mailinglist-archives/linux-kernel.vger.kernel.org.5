Return-Path: <linux-kernel+bounces-102211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0EE87AF75
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBE81C25452
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA712150CDB;
	Wed, 13 Mar 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQPhDP7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EAC1A00F5;
	Wed, 13 Mar 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349504; cv=none; b=SkhSk/7ioxKOwzrkz6AhVnx1rm8au+Umhpk9RPmRBAqnuPSaI1GMb8Dj5KH+RfgTQ29OzrTjc3120JfMHr5qlGlpgEec2onE9h/vuBHGNyEgEZsVD+3dMDlFBPkD+PS1NZbnwXy5+Kql1WTRWUvMOaQ2Ws5n3/5vsTf5WwVcf2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349504; c=relaxed/simple;
	bh=TZDlJEb/8+80m/ePRWKRLEtSLba8a1vTL697utev7B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nes8QThh0l71GMQeEJsuSzEXWqE0WZLVj4ZrqlTalT6rLTDLN00h06d19mfxniVpz0dSRic95BmfvaQw6xY5x7uTVd8dFUrgxQECFADJ3MK6sY497lt8uZk0lv1wXCLaVSZLNgVKp5RLrJb6qTeqhGytns6hO1MgOmftvIb6MAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQPhDP7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783F4C43394;
	Wed, 13 Mar 2024 17:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349504;
	bh=TZDlJEb/8+80m/ePRWKRLEtSLba8a1vTL697utev7B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQPhDP7Nuj9Qgji/SwHrCnhTTDwj1839OF2tSRZwoP7mO6vc9G9QTMef70cvJlFgF
	 ER/LhNa6w9IOpQ1BUZ+cXnszmihibVokzoZnJbVrn6+yBS/qaTefkzcWMGrvjd4WiC
	 IoGKTpwY5lrzscElK/PM4Ll7Fu6r2jf/QvOzPMgA8HR9K0u1j0kMANPegdqUoNNg6t
	 GG+4J/9bWlgwyrL8cpkRiAX2rOGTj1nDuYCL2MAEYCWpJduLnL3lPomzcO/4xMOpsy
	 1Zx2MCaGPZlyOI9s8t1dvHsYCKfctggAAJ/uS8mwSHNiV0d8eLzaYdW0+axupetr4M
	 brbmh184SaP8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	syzbot+be14ed7728594dc8bd42@syzkaller.appspotmail.com,
	syzbot+c563a3c79927971f950f@syzkaller.appspotmail.com,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 24/41] btrfs: ref-verify: free ref cache before clearing mount opt
Date: Wed, 13 Mar 2024 13:04:18 -0400
Message-ID: <20240313170435.616724-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit f03e274a8b29d1d1c1bbd7f764766cb5ca537ab7 ]

As clearing REF_VERIFY mount option indicates there were some errors in a
ref-verify process, a ref cache is not relevant anymore and should be
freed.

btrfs_free_ref_cache() requires REF_VERIFY option being set so call
it just before clearing the mount option.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Reported-by: syzbot+be14ed7728594dc8bd42@syzkaller.appspotmail.com
Fixes: fd708b81d972 ("Btrfs: add a extent ref verify tool")
CC: stable@vger.kernel.org # 5.4+
Closes: https://lore.kernel.org/lkml/000000000000e5a65c05ee832054@google.com/
Reported-by: syzbot+c563a3c79927971f950f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/0000000000007fe09705fdc6086c@google.com/
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ref-verify.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index b26739d0e991b..7bb816a6d1e19 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -891,8 +891,10 @@ int btrfs_ref_tree_mod(struct btrfs_root *root, u64 bytenr, u64 num_bytes,
 out_unlock:
 	spin_unlock(&root->fs_info->ref_verify_lock);
 out:
-	if (ret)
+	if (ret) {
+		btrfs_free_ref_cache(fs_info);
 		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
+	}
 	return ret;
 }
 
@@ -1021,8 +1023,8 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		}
 	}
 	if (ret) {
-		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 		btrfs_free_ref_cache(fs_info);
+		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 	}
 	btrfs_free_path(path);
 	return ret;
-- 
2.43.0


