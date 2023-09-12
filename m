Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CBD79D11B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjILMap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjILMaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:30:21 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086161735
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:30:09 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RlN9s0W98zMl9J;
        Tue, 12 Sep 2023 20:26:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm500011.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 20:30:07 +0800
From:   Li Lingfeng <lilingfeng3@huawei.com>
To:     <dm-devel@redhat.com>
CC:     <agk@redhat.com>, <snitzer@kernel.org>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <lilingfeng3@huawei.com>
Subject: [PATCH] dm: remove dm_set_md_type()
Date:   Tue, 12 Sep 2023 20:26:05 +0800
Message-ID: <20230912122605.3487911-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ba30585936b0 ("dm: move setting md->type into dm_setup_md_queue")
has removed the only reference to dm_set_md_type(), so remove
dm_set_md_type() now.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 drivers/md/dm.c | 6 ------
 drivers/md/dm.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f0f118ab20fa..6b9d04ca09d0 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2316,12 +2316,6 @@ void dm_unlock_md_type(struct mapped_device *md)
 	mutex_unlock(&md->type_lock);
 }
 
-void dm_set_md_type(struct mapped_device *md, enum dm_queue_mode type)
-{
-	BUG_ON(!mutex_is_locked(&md->type_lock));
-	md->type = type;
-}
-
 enum dm_queue_mode dm_get_md_type(struct mapped_device *md)
 {
 	return md->type;
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index f682295af91f..cc55ef3441be 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -76,7 +76,6 @@ bool dm_table_request_based(struct dm_table *t);
 
 void dm_lock_md_type(struct mapped_device *md);
 void dm_unlock_md_type(struct mapped_device *md);
-void dm_set_md_type(struct mapped_device *md, enum dm_queue_mode type);
 enum dm_queue_mode dm_get_md_type(struct mapped_device *md);
 struct target_type *dm_get_immutable_target_type(struct mapped_device *md);
 
-- 
2.31.1

