Return-Path: <linux-kernel+bounces-112906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785CC887FA5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184381F20FBC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A585C903;
	Sun, 24 Mar 2024 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8er6NBE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F55C602;
	Sun, 24 Mar 2024 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319717; cv=none; b=jkrrGcLvIeqYIP8HlqdNHIWEE6W1G9yK25Z0A+3HPf1QqT0okTVfTFOkNRvJMps4e1Dxq3kf3/eKO0U0wT9vGU01AKXVT5cGPirnFimyv7hLj7O2R0uPZtERvk5FSCPjtAHbJp80JampgxwNZR3rAtATYraPq7+zKtZjZdtN+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319717; c=relaxed/simple;
	bh=/MXY001JO4rLNN5N/AiOlea/3bdqF4k05VDdxhv4NLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQbErFdxlE5nQrgvhTpqtkL2i1S+dAf0Jf76f8I3ha1lJ8WP3wGvrmZJPUX/PwPTEBoJMlvsxjNeZJjGJhpdxaaIvHeKldMBI9rlf7evJVbZKACFqL4q0Z0lRjqyCCYCtQM9QiCNJu7vET8BytTtiiEcZGufGI0QdJwanVdx0n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8er6NBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EB6C433A6;
	Sun, 24 Mar 2024 22:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319716;
	bh=/MXY001JO4rLNN5N/AiOlea/3bdqF4k05VDdxhv4NLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8er6NBEFifZqZIJQOVUIakuSeO0p+8wN1pa99/edMtu/n6gwg8wXILTO6VvPJQmd
	 wc1TSXqhJTdlnOwqfEjoXsqizR7OP0z0+ItPcDweOaFfYEdcBXUGqS9ptjMM2QweCk
	 psB4U869rHRaxwPa10Bw1fylXDWqIyrMKhge9btL4j495fjVtOYiEaVgx+r5D0pp/L
	 JzGhXHcoI6U/hCMp9xFAA2x+z0AzPJwtDso1PkEEpXH4m4XznjH5fchomRLNmeCrar
	 g9SkGb/pmzKj9jJiMbCBs/Yxxb/ExDAYV+h+5o2gJeNrADFoR/TYCxE/9IuMxcmrMC
	 3Yu+Dtsjnh2tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 019/715] md: fix kmemleak of rdev->serial
Date: Sun, 24 Mar 2024 18:23:18 -0400
Message-ID: <20240324223455.1342824-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Li Nan <linan122@huawei.com>

[ Upstream commit 6cf350658736681b9d6b0b6e58c5c76b235bb4c4 ]

If kobject_add() is fail in bind_rdev_to_array(), 'rdev->serial' will be
alloc not be freed, and kmemleak occurs.

unreferenced object 0xffff88815a350000 (size 49152):
  comm "mdadm", pid 789, jiffies 4294716910
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc f773277a):
    [<0000000058b0a453>] kmemleak_alloc+0x61/0xe0
    [<00000000366adf14>] __kmalloc_large_node+0x15e/0x270
    [<000000002e82961b>] __kmalloc_node.cold+0x11/0x7f
    [<00000000f206d60a>] kvmalloc_node+0x74/0x150
    [<0000000034bf3363>] rdev_init_serial+0x67/0x170
    [<0000000010e08fe9>] mddev_create_serial_pool+0x62/0x220
    [<00000000c3837bf0>] bind_rdev_to_array+0x2af/0x630
    [<0000000073c28560>] md_add_new_disk+0x400/0x9f0
    [<00000000770e30ff>] md_ioctl+0x15bf/0x1c10
    [<000000006cfab718>] blkdev_ioctl+0x191/0x3f0
    [<0000000085086a11>] vfs_ioctl+0x22/0x60
    [<0000000018b656fe>] __x64_sys_ioctl+0xba/0xe0
    [<00000000e54e675e>] do_syscall_64+0x71/0x150
    [<000000008b0ad622>] entry_SYSCALL_64_after_hwframe+0x6c/0x74

Fixes: 963c555e75b0 ("md: introduce mddev_create/destroy_wb_pool for the change of member device")
Signed-off-by: Li Nan <linan122@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240208085556.2412922-1-linan666@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9e41a9aaba8b5..bfd04a9e80796 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2566,6 +2566,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
  fail:
 	pr_warn("md: failed to register dev-%s for %s\n",
 		b, mdname(mddev));
+	mddev_destroy_serial_pool(mddev, rdev);
 	return err;
 }
 
-- 
2.43.0


