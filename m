Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7607E4553
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbjKGQEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344541AbjKGQEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:04:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D5F448B;
        Tue,  7 Nov 2023 07:55:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EC3C433C8;
        Tue,  7 Nov 2023 15:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372517;
        bh=KvtWCvAGFHyQPEJ2pkrCkk3wYO5o/6slB/36anAWT30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FLG++ZysS3j+9dtZGkncwE5VDy+TR6tDY1/ORD7kwDG/zQdoMeZmnNBLLOaMard3Q
         5Sr+cSq0o9gWqtxh4LmVmBF4ItTNm60Majsl0wSwqqNQouRQeMZ0aTToq2k3Hi1j1C
         AK6XLeFNmRgQ+wjYcgdz4Dwn8epd0cEW08hb3qk7LUAs9+ZdPL3yCx9LFBFiYUNg10
         tGkyMbvOFy1D3u/2DRQuFCW3CcuOOaC12wbx/pZrWaHGyh2ATWyj30+zQ6YrTV4Zrc
         F5MkOVRSznuanbAOJaJjcLoaZSwP2O2NH9QROBTgu4PZgK5yRVkUM8NCdIbX8v3GdN
         1Q90w8jMKQd+w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juntong Deng <juntong.deng@outlook.com>,
        syzbot+debee9ab7ae2b34b0307@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        ghandatmanas@gmail.com, wonguk.lee1023@gmail.com,
        liushixin2@huawei.com, andrew.kanner@gmail.com, code@siddh.me,
        yogi.kernel@gmail.com, jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.14 3/9] fs/jfs: Add check for negative db_l2nbperpage
Date:   Tue,  7 Nov 2023 10:54:53 -0500
Message-ID: <20231107155509.3769038-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155509.3769038-1-sashal@kernel.org>
References: <20231107155509.3769038-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.328
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
index 95e8f031c3f11..070638718be32 100644
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

