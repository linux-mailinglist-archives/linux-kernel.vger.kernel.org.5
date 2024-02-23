Return-Path: <linux-kernel+bounces-78027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A72860E21
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231A31F2690F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD2E5C91C;
	Fri, 23 Feb 2024 09:37:39 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 17BDC18B04;
	Fri, 23 Feb 2024 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681049; cv=none; b=Rnm7fFuWyqY2jZ9JflKzsJwAuPUOwYwBe3J4V7OPtitRzSrDyeVaqTEo+1/vo4tauQKDDJv2vIa8rLUe037795zf7ZHbX7blPmYL59maptHjqlILWYPcYV+8sXlPNBCHtdp17QMhxVE3scQCQLtbigLpDQ/lA04AgpBLxaaq3Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681049; c=relaxed/simple;
	bh=jzGH6BnS+LEtgknawVwnW9qhr2Z/pUoY5FYpMz3a70E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tPv5BmAHy/nGQOggmd/ymo1A1VHPsGrnJAC33umROUe0UN6BsgR9JZfEPbDQvBwqk86yPhs4oZFQ+53njuLFwUKvE0xJk5FsNZY0DY3vM0MNYNCBirqZArbL0B/P9y1vL5E2GL1TUKbH2WIJn5XWf+pnz+4vXO8YQm+EwsN7UBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id A61F2604A6F93;
	Fri, 23 Feb 2024 17:37:11 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Su Hui <suhui@nfschina.com>
Subject: [PATCH next] orangefs: re-fix sb refcount leak when allocate sb info failed.
Date: Fri, 23 Feb 2024 17:36:41 +0800
Message-Id: <20240223093639.1794556-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This problem was previously fixed by commit ac2c63757f4f ("orangefs: Fix sb
refcount leak when allocate sb info failed.").
Add a judgement to fix NULL deference problem and also avoid refcount
leak problem.

Fixes: 9bf93dcfc453 ("Julia Lawall reported this null pointer dereference, this should fix it.")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
ps: Thanks for Dan's suggestion[1].
[1]: https://lore.kernel.org/all/c4bf77fb-c289-4f5d-9f20-e0861a543d91@moroto.mountain/
 fs/orangefs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 34849b4a3243..e189e1aae00b 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -527,7 +527,7 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 	sb->s_fs_info = kzalloc(sizeof(struct orangefs_sb_info_s), GFP_KERNEL);
 	if (!ORANGEFS_SB(sb)) {
 		d = ERR_PTR(-ENOMEM);
-		goto free_op;
+		goto free_sb_and_op;
 	}
 
 	ret = orangefs_fill_sb(sb,
@@ -581,7 +581,8 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 
 free_sb_and_op:
 	/* Will call orangefs_kill_sb with sb not in list. */
-	ORANGEFS_SB(sb)->no_list = 1;
+	if (ORANGEFS_SB(sb))
+		ORANGEFS_SB(sb)->no_list = 1;
 	/* ORANGEFS_VFS_OP_FS_UMOUNT is done by orangefs_kill_sb. */
 	deactivate_locked_super(sb);
 free_op:
-- 
2.30.2


