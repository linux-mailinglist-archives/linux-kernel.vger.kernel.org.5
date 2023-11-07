Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E94F7E445C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343601AbjKGPwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjKGPvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:51:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D737B1BCB;
        Tue,  7 Nov 2023 07:49:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CC9C433C8;
        Tue,  7 Nov 2023 15:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372150;
        bh=kJ1iYd71qVfxG+aUINxMo8Q76j6fyrwxu9oi9O62fxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=haqaVXitkXlIBTzKpOBmRMSuSJf6O62qOsbvMVCpXV70k75yB/vwlgXLPm7ou/S8k
         mIJ7XIYJw38Xo294+gfNNhgpkEzbuwODJQncxVyHZuycx6ZAQq5N/SXwvVbVlLvnLt
         NEj+XYj73McErJOAVgGiONAsc1fv3b+KFYFdlZo/VABsl4siv8KXd/lP6WfmKPY0Nx
         aTL9QrPGKfq39aqPolgzttvRqBixIcF0hKXbdY9ms6RiRpk0NtlSVXqQmzo/RErXy7
         xzHsbnIx32ieLXzfAtVOrLVBmWIWxUdU7ryl5ZTWFv0dRiPUthgzytb1VIOy2QFKkA
         fJDInfc4XhWuA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juntong Deng <juntong.deng@outlook.com>,
        syzbot+debee9ab7ae2b34b0307@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        andrew.kanner@gmail.com, yogi.kernel@gmail.com,
        liushixin2@huawei.com, code@siddh.me, ghandatmanas@gmail.com,
        wonguk.lee1023@gmail.com, jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.5 10/34] fs/jfs: Add check for negative db_l2nbperpage
Date:   Tue,  7 Nov 2023 10:47:50 -0500
Message-ID: <20231107154846.3766119-10-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154846.3766119-1-sashal@kernel.org>
References: <20231107154846.3766119-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
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
index 88afd108c2dd2..3a1842348112d 100644
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

