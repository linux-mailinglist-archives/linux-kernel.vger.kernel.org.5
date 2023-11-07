Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D157C7E4537
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344294AbjKGQDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344412AbjKGQCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:02:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0B58A7B;
        Tue,  7 Nov 2023 07:53:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BA7C433CA;
        Tue,  7 Nov 2023 15:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372431;
        bh=NXxXPolJmapWp1eXXJkHfm9HoO6mkhpdoOL9Dgs2I3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWOqEWxXyIVe23oZwSg6/m5OuGHblnFJI1otDmSJJeBn0Oevu7XjhrY/PL/MjWymI
         Al+Iqe/szRjuLUBGGbxJNxlRRMMXj00tfgePVuCBm3w+19ANZXVrsNTdfLmRdg5hw6
         0vJy3W2sVB3F65fhnyNPcqkKZj75kgnoAVMGnGiQXuSKbD84wSoAgs/R8feZltlJnQ
         uAJKB8e5DwjJphu8w/cQuQY1KfK4dUxkUVb7Vjoa7KAS9lGLwj7bc+T/MEeckiYT82
         qpBp4XOrqxsz3/aCO4+lwWTHtA/RROnQMNGyrXi8qDxV44FwG52S8I4uu3pX2kEPUh
         2XO5UP1p631Kw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juntong Deng <juntong.deng@outlook.com>,
        syzbot+debee9ab7ae2b34b0307@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        code@siddh.me, wonguk.lee1023@gmail.com, yogi.kernel@gmail.com,
        andrew.kanner@gmail.com, ghandatmanas@gmail.com,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 03/12] fs/jfs: Add check for negative db_l2nbperpage
Date:   Tue,  7 Nov 2023 10:53:21 -0500
Message-ID: <20231107155343.3768464-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155343.3768464-1-sashal@kernel.org>
References: <20231107155343.3768464-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
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
index a785c747a8cbb..495a1c6e5fd46 100644
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

