Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E111D7E4500
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344255AbjKGQAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344488AbjKGP7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:59:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D06372AB;
        Tue,  7 Nov 2023 07:51:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EABC433C8;
        Tue,  7 Nov 2023 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372319;
        bh=t6zKZE/kBk3hmQKGYxyrL0952982TQmXhu06qwheKg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1GQxOjG4Vcvlnlzhq3AUPe9AjwmblQNoLjFK/S0vgCZV94uWr9vta2W2VHx5aK+i
         LynkN/pMtdOA6L3/ee3kLS1tNcti26klWG05y3O8jREs/pYFLkAMF8dld55qJPpru7
         la8NMm//lNGQUN7XjnS+A+kmFIHUuSu5hqhVTy5VB9Vej4l3EjrXrRMYJJUidy6qLT
         tjhHcgNaoojOda2iuwsffPOP0NRgiHP72KPR07XjCNuakiU7MtLwXfiF/rarYeWrGU
         5l+Ya62QWW7yMRb07IhYAlJ2RDf3RoXr90+0o18j/GycOdl9L25aOxISYUAf8gHet+
         ibF7uS99MguSQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juntong Deng <juntong.deng@outlook.com>,
        syzbot+debee9ab7ae2b34b0307@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        yogi.kernel@gmail.com, code@siddh.me, liushixin2@huawei.com,
        andrew.kanner@gmail.com, wonguk.lee1023@gmail.com,
        ghandatmanas@gmail.com, jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 06/22] fs/jfs: Add check for negative db_l2nbperpage
Date:   Tue,  7 Nov 2023 10:51:15 -0500
Message-ID: <20231107155146.3767610-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155146.3767610-1-sashal@kernel.org>
References: <20231107155146.3767610-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
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
index da4f9c3b714fe..a700950429c5f 100644
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

