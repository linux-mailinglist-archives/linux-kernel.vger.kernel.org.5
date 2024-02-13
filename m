Return-Path: <linux-kernel+bounces-63329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB50852DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C4B1F26BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761762260B;
	Tue, 13 Feb 2024 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2TrOChC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0651225CE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819457; cv=none; b=LACSxVaSDqkOl+4B8p4K8FTM+o74qaNoOuT7HLZ/EF1dC4op2ObNBMvtt9fhUJF0cWz4VSNCPZIXnxS8D/p9U/I7C/2B6B4sDtDisO/IYoYKUnL526zES2ud0Td5tRfshPR25CgEMTJRA206WIcabdkehCbbTWLRnVg/2RjyaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819457; c=relaxed/simple;
	bh=SmIMSf7PRLHS1bKoo/5RP9uj4icwbgQjnEsI14pJqnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EUSw30B0Z7QiF7Dh6EIhpg1PZ8S0Jl/LM/U0yKxAW8o63YRgi6XLer/EEF9x/XEtz+lKl4jWK4n/7aKDjFwTMuxvsRGEnbhpgkqNPdD1XabeoGia02IjpUL8v/0jjUTP30hz9TC0F2GEFcRNyEQnmnpAa9rXE4tYTWblt1STNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2TrOChC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D56C433C7;
	Tue, 13 Feb 2024 10:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819457;
	bh=SmIMSf7PRLHS1bKoo/5RP9uj4icwbgQjnEsI14pJqnA=;
	h=From:To:Cc:Subject:Date:From;
	b=L2TrOChCRvMze16kk6fVZ/kj/Khuup7S7CcrYFegLwm5yHyYM3y5CiDvoDqNWoOOC
	 wY4hOZYkHZbmfHqGYb+DCtqUdysls2exfIZ7mrWdDQhr/x0BMBEoifbmbcyO10qOnM
	 WhGhGm2AYVkDdtzJKzyR428W2dgEidHKBGVl8ldqJZCgHdIttt5riZuJRfaXuSo9e/
	 RQXcmFi6An9gMxYKzZfkeswQ/X8fbMmvS3VEsgddnUc1PJA+d//SrU7F/NCbxxj6wE
	 x6SkUiX8HeIgDn3LIe3lrgb1zEQv+3EQ8IFmjbs1mDcmKxG45WMAElz2ZLvhACIc/Q
	 32QJNhOa4ojUQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Jan Kara <jack@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] quota: avoid printing an uninitialized blk number
Date: Tue, 13 Feb 2024 11:17:28 +0100
Message-Id: <20240213101733.461544-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The error path of find_tree_dqentry() now prints a variable that is
never initialized:

fs/quota/quota_tree.c:674:8: error: variable 'blk' is uninitialized when used here [-Werror,-Wuninitialized]
                            blk);
                            ^~~
include/linux/quotaops.h:34:41: note: expanded from macro 'quota_error'
        __quota_error((sb), __func__, fmt , ## args)
                                               ^~~~

Move the calculation of the block number slightly up to make it
show a sensible number.

Fixes: 223bfb57631b ("quota: Detect loops in quota tree")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/quota/quota_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
index afceef3ddfaa..05ae39f9b1ac 100644
--- a/fs/quota/quota_tree.c
+++ b/fs/quota/quota_tree.c
@@ -669,13 +669,13 @@ static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
 	if (!buf)
 		return -ENOMEM;
 	ret = read_blk(info, blks[depth], buf);
+	blk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
 	if (ret < 0) {
 		quota_error(dquot->dq_sb, "Can't read quota tree block %u",
 			    blks[depth]);
 		goto out_buf;
 	}
 	ret = 0;
-	blk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
 	if (!blk)	/* No reference? */
 		goto out_buf;
 	ret = do_check_range(dquot->dq_sb, "block", blk, QT_TREEOFF,
-- 
2.39.2


