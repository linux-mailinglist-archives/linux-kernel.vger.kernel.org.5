Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F5D7ABD9C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 05:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjIWDfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 23:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjIWDfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 23:35:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A42A9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 20:34:59 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RsvmH6jzlztSZt;
        Sat, 23 Sep 2023 11:30:39 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 23 Sep
 2023 11:34:56 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <roland.ruckerbauer@robart.cc>,
        <david@sigma-star.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH] ubifs: ubifs_link: Fix wrong name len calculating when UBIFS is encrypted
Date:   Sat, 23 Sep 2023 11:28:59 +0800
Message-ID: <20230923032859.3857274-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The length of dentry name is calculated after the raw name is encrypted,
except for ubifs_link(), which could make the size of dir underflow.
Here is a reproducer:

 touch $TMP/file
 mkdir $TMP/dir
 stat $TMP/dir
 for i in $(seq 1 8)
 do
   ln $TMP/file $TMP/dir/$i
   unlink $TMP/dir/$i
 done
 stat $TMP/dir

The size of dir will be underflow(-96).

Fix it by calculating dentry name's length after the name is encrypted.

Fixes: f4f61d2cc6d8 ("ubifs: Implement encrypted filenames")
Reported-by: Roland Ruckerbauer <roland.ruckerbauer@robart.cc>
Link: https://lore.kernel.org/linux-mtd/1638777819.2925845.1695222544742.JavaMail.zimbra@robart.cc/T/#u
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/dir.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 2f48c58d47cd..5dc1ac4d826d 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -724,7 +724,7 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 	struct inode *inode = d_inode(old_dentry);
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_inode *dir_ui = ubifs_inode(dir);
-	int err, sz_change = CALC_DENT_SIZE(dentry->d_name.len);
+	int err, sz_change;
 	struct ubifs_budget_req req = { .new_dent = 1, .dirtied_ino = 2,
 				.dirtied_ino_d = ALIGN(ui->data_len, 8) };
 	struct fscrypt_name nm;
@@ -748,6 +748,8 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 	if (err)
 		return err;
 
+	sz_change = CALC_DENT_SIZE(fname_len(&nm));
+
 	err = dbg_check_synced_i_size(c, inode);
 	if (err)
 		goto out_fname;
-- 
2.39.2

