Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E445A7E45DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbjKGQVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjKGQUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:20:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342DA3871;
        Tue,  7 Nov 2023 07:54:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1AFC433C7;
        Tue,  7 Nov 2023 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372478;
        bh=4v2lyw6dOxfUWPonfHOfC2fDdN0hErqoQypA2vOYI4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYmWg5ya1hCLSGbbhv5yXxW+b40K4pYBzbFO3pU+tPcqi6Ef/NpJwyUn+l0J1fr3u
         Lccb+bsviEBKJHeaGiSuExq3X1vOI+r4TTZpF41s6aFRgXgWq51MZCdnQwaILaW0LM
         9sLBe/Hh5zsGp9j7LldAdqQQpKt995Gn8njtrZYfsU4yZip5+WANT9+UC3pLvCnRmR
         8Nsz1+erA2j3p+UZ2o+sG9wUDyWv+U7QQnhVmvjP0WeWx6RkdyANqBnWyLnaK8uU15
         I0kkAuiv5DuRM3s7lIY0UWIwmZKugwmbJZRSTjIWMcLF2Yj07FP2+lX2+gtlLi6+67
         hkejM46yaEykA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juntong Deng <juntong.deng@outlook.com>,
        syzbot+debee9ab7ae2b34b0307@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        ghandatmanas@gmail.com, andrew.kanner@gmail.com, code@siddh.me,
        yogi.kernel@gmail.com, wonguk.lee1023@gmail.com,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 03/11] fs/jfs: Add check for negative db_l2nbperpage
Date:   Tue,  7 Nov 2023 10:54:11 -0500
Message-ID: <20231107155430.3768779-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155430.3768779-1-sashal@kernel.org>
References: <20231107155430.3768779-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.297
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
index b20fffc8b4c13..5e20d7270d5f2 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -193,7 +193,8 @@ int dbMount(struct inode *ipbmap)
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

