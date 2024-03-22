Return-Path: <linux-kernel+bounces-112005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA60887406
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5670B283781
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E8C7F483;
	Fri, 22 Mar 2024 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JQXN5m+Q"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426C117589;
	Fri, 22 Mar 2024 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711137098; cv=none; b=VcHCx07/II5wxoRC7U5G4cWaL5F9tNTwQG0izpSb6JbKyMqGKYZN0YcJCwbuWODwJy7wqloADWz2iJlNFl7FTfwCK/i5bzFngtta+khPLYK/zf9rZQ4xYKkrIrhufh9JihTU3tUNW3KR96arElzeYj/gZKxxDRxnO6effKtFV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711137098; c=relaxed/simple;
	bh=72Kdlh+PeCaC0JgXHs4uX5Eocp2863XVaM6CXcHJbm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pOwddbuJYdgwO0TMi8dEqfmG541d2PxAOKDAVFG2ZgE766IdNjjXveySESVKHK/DsS6FEVdTbytQBDWs28tageOPQe2uof76TY/mnGlY+XR3LP8jcK3QpVmraIFUAxkqnV/xqahH5JQWPoEsh/LmytrL09ZZ0IsXvj60J24YDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JQXN5m+Q; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1711137092;
	bh=72Kdlh+PeCaC0JgXHs4uX5Eocp2863XVaM6CXcHJbm0=;
	h=From:Date:Subject:To:Cc:From;
	b=JQXN5m+QdMw2QCyoPeGUyDWN4k0AuD4kkKnRMVw2J3dfukKHyBg5fCK7KJ1tNcvnl
	 +YYTt8d4PKeK32kHn8ri0RBbPfvSNY7QIvFyjQb6dA/EvOhg9FKMTc8+8tteoWfcfc
	 2hYeWAKVqxWNuXukXzYhOOpm3kaD61HL2fYyAVTI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 22 Mar 2024 20:51:11 +0100
Subject: [PATCH v2] fs/proc/proc_sysctl.c: always initialize i_uid/i_gid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240322-sysctl-net-ownership-v2-1-a8b4a3306542@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAC7h/WUC/4WNTQ6CMBCFr0Jm7RhaAaMr7mFYlDraSUxLOlgkp
 He3cgHf7nt5PxsIRSaBa7VBpMTCwRfQhwqsM/5JyPfCoGvd1CfVoqxi5xd6mjEsnqI4nnC0Dak
 zGSLTQalOkR782WdvQ2HHMoe47i9J/dw/g0mhQj02XVtk9EX3C7GIWPd2xxKFIef8BQ8u26K9A
 AAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711137092; l=1753;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=72Kdlh+PeCaC0JgXHs4uX5Eocp2863XVaM6CXcHJbm0=;
 b=AHfmIoxytnUEQFA5MfwfoRoRpJGA6Tspr/zU56SHlqDFrZZns1LRwaTeQ2kMKUFXfoZ2WdVNY
 1dXk+g3rws6Des2y4Y15HNbuCrGUHEf/A3U5trLOQcAYOMXSovp96ut
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Commit e79c6a4fc923 ("net: make net namespace sysctls belong to container's owner")
added default values for i_uid/i_gid.
These however are only used when ctl_table_root->set_ownership is not
implemented.
But the callbacks themselves could fail to compute i_uid/i_gid and they
all need to have the same fallback logic for this case.

This is unnecessary code duplication and prone to errors.
For example net_ctl_set_ownership() missed the fallback.

Instead always initialize i_uid/i_gid inside the sysfs core so
set_ownership() can safely skip setting them.

Fixes: e79c6a4fc923 ("net: make net namespace sysctls belong to container's owner")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
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
base-commit: ff9c18e435b042596c9d48badac7488e3fa76a55
change-id: 20240315-sysctl-net-ownership-bc4e17eaeea6

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


