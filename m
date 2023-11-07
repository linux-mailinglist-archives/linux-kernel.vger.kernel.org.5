Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6778B7E45BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344408AbjKGQRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbjKGQRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:17:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA0226AD;
        Tue,  7 Nov 2023 07:52:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFD7C433C8;
        Tue,  7 Nov 2023 15:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372379;
        bh=S2Pxy3eWEuhMbE5OllKwcG5yExbHwd7NQd2weNzpLDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pi/cBM+Qp7LTfu3E+7wLXhEwbJxoLvUoHMSeOzft5sVqp6Xh3ndKgECA17IhUJaNx
         W0BRSgawgjkpUkmFeIdDxemDmeC73JEIthipqlow2tem82AHYDNuD3Z7Twx2aIDy+L
         KNC6UTCp2L4ZOIOTi9gAgUXH0xkH8OSoydl2uqck/zZUpF80u8bDz8Zqvc5bI0fzib
         VXoljN1t0JbR+oRVeXFLbLiNgjVWYwnAvUK8nAr29yBBh8CjrEGl3unoGoH/rss8n6
         OQDkrhn4W9iAS4wrVEMpOB6mVDjn7SSDjduEk5rNtVBC+NOS25eccHeKprukZgtDVa
         yol0ndbrZf/rA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juntong Deng <juntong.deng@outlook.com>,
        syzbot+debee9ab7ae2b34b0307@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        wonguk.lee1023@gmail.com, liushixin2@huawei.com,
        andrew.kanner@gmail.com, yogi.kernel@gmail.com,
        ghandatmanas@gmail.com, code@siddh.me,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 04/16] fs/jfs: Add check for negative db_l2nbperpage
Date:   Tue,  7 Nov 2023 10:52:23 -0500
Message-ID: <20231107155249.3768098-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155249.3768098-1-sashal@kernel.org>
References: <20231107155249.3768098-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juntong Deng <juntong.deng@outlook.com>

[ Upstream commit 525b861a008143048535011f3816d407940f4bfa ]

l2nbperpage is log2(number of blks per page), and the minimum legal
value should be 0, not negative.

In the case of l2nbperpage being negative, an error will occur
when subsequently used as shift exponent.

Syzbot reported this bug:

UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:799:12
shift exponent -16777216 is negative

Reported-by: syzbot+debee9ab7ae2b34b0307@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=debee9ab7ae2b34b0307
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a9c078fc2302a..06dda2c7a6e24 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -180,7 +180,8 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
 
 	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
-	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE) {
+	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE ||
+		bmp->db_l2nbperpage < 0) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
-- 
2.42.0

