Return-Path: <linux-kernel+bounces-128709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F695895E7A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0509D1F24A29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E98B15E5B4;
	Tue,  2 Apr 2024 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ouhGV+Ur"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1704B15E200;
	Tue,  2 Apr 2024 21:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092249; cv=none; b=oXDZH6gLFEJgzPw+j6jx1Y9+3dOHxQrGplm174+PiCvn+cSF9nBWIiWDfGlI1++bEbZRz9q3TWJsr4w2JxxHSt3vRhRN50x5NsDEi7UbaxSYiivcYl876ITlH3PFrfX3wdlmSKUlcpUtBuyeJjLs8+zQJwcLfTWIbLrRtaanwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092249; c=relaxed/simple;
	bh=VDHNmPR75jbDet7a94lKLLoM+37d0gOeLXruir8XK2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SWVoWDI05FQN3AAi/N5w6p2iK4RwiqwvkWe7ESJmHp2pem7WfBKYf1OfA4MCAke0sE+Qkwc2Ffiq7LpNCoqmPf8+tstNcjHnikqTTOwb/J5pd9i+fgPqRxccS9c+onBkGCvfswRDnNeeo9L79GvvZDRtvk0s4WH5uUG2B7HNihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ouhGV+Ur; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1712092237;
	bh=VDHNmPR75jbDet7a94lKLLoM+37d0gOeLXruir8XK2A=;
	h=From:Date:Subject:To:Cc:From;
	b=ouhGV+Ur5q0YndpUrFAr27tDCG1tuKQAg9UnTFJAPvzzIlnqC7JjFI815/PLm/gfY
	 SVJGRCCQOLhzA8TAZcrvUehXey9aSfv9CEpsKozc04HlDkBvBlOLpOwgBRe5r+TewW
	 QkHZqz1n/ztFgrQaTJEtrmrW+jUc0SSywo/0Rdbo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 02 Apr 2024 23:10:34 +0200
Subject: [PATCH v3] fs/proc/proc_sysctl.c: always initialize i_uid/i_gid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240402-sysctl-net-ownership-v3-1-366b1a76d48a@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAEl0DGYC/4XNzw6CMAwG8FchOzvDuoF/Tr6H8TBmdU3MICsOC
 eHdHZxMjLG3r/n66yQYIyGLYzGJiImY2pCD3hTCeRvuKOmas4ASTKlVJXlk1z9kwF62Q8DInjr
 ZOINqhxbR1iKfdhFv9FrZ8yVnT9y3cVy/JLVs/4BJSSWhMXWVx8IBTgMSMzv/9NtcFYua4EMC+
 CFBluy+MVbrsq7MtzTP8xtc/CpwBwEAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "Eric W. Biederman" <ebiederm@xmission.com>, 
 Joel Granados <j.granados@samsung.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luis Chamberlain <mcgrof@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712092237; l=1832;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=VDHNmPR75jbDet7a94lKLLoM+37d0gOeLXruir8XK2A=;
 b=3d5SEnUKrYRSHwfNL8QNXWIJisGyNdAhCaS42oJchWZe5GQKUgQbWYtuL17x95HYYGZcRbduG
 8n9cGvk/GywCBxXzn+SvcMiKIUCHN38TRshTmCCzOFnyqo79kyiotjx
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Commit 5ec27ec735ba ("fs/proc/proc_sysctl.c: fix the default values of i_uid/i_gid on /proc/sys inodes.")
added defaults for i_uid/i_gid when set_ownership() is not implemented.
It missed to also adjust net_ctl_set_ownership() to use the same default
values in case the computation of a better value fails.

Instead always initialize i_uid/i_gid inside the sysfs core so
set_ownership() can safely skip setting them.

Fixes: 5ec27ec735ba ("fs/proc/proc_sysctl.c: fix the default values of i_uid/i_gid on /proc/sys inodes.")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Rebase onto v6.9-rc1
- Reword commit message and mention correct fixed commit
- Link to v2: https://lore.kernel.org/r/20240322-sysctl-net-ownership-v2-1-a8b4a3306542@weissschuh.net

Changes in v2:
- Move the fallback logic to the sysctl core
- Link to v1: https://lore.kernel.org/r/20240315-sysctl-net-ownership-v1-1-2b465555a292@weissschuh.net
---
 fs/proc/proc_sysctl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 37cde0efee57..9e34ab9c21e4 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -479,12 +479,10 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 			make_empty_dir_inode(inode);
 	}
 
+	inode->i_uid = GLOBAL_ROOT_UID;
+	inode->i_gid = GLOBAL_ROOT_GID;
 	if (root->set_ownership)
 		root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
-	else {
-		inode->i_uid = GLOBAL_ROOT_UID;
-		inode->i_gid = GLOBAL_ROOT_GID;
-	}
 
 	return inode;
 }

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240315-sysctl-net-ownership-bc4e17eaeea6

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


