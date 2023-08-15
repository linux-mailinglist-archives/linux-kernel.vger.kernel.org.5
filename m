Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C573B77CABB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjHOJt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbjHOJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:49:24 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2611E3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:49:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VprTE8H_1692092956;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0VprTE8H_1692092956)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 17:49:19 +0800
From:   Ferry Meng <mengferry@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH 2/3] erofs: add necessary kmem_cache_create flags for erofs inode cache
Date:   Tue, 15 Aug 2023 17:48:48 +0800
Message-Id: <20230815094849.53249-2-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230815094849.53249-1-mengferry@linux.alibaba.com>
References: <20230815094849.53249-1-mengferry@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve memory access efficiency and enable statistics functionality,
add SLAB_MEM_SPREAD and SLAB_ACCOUNT flag during erofs_icachep's allocation
time.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index ae5caf605ffc..82f41d09f8d8 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -937,9 +937,9 @@ static int __init erofs_module_init(void)
 	erofs_check_ondisk_layout_definitions();
 
 	erofs_inode_cachep = kmem_cache_create("erofs_inode",
-					       sizeof(struct erofs_inode), 0,
-					       SLAB_RECLAIM_ACCOUNT,
-					       erofs_inode_init_once);
+					    sizeof(struct erofs_inode), 0,
+					    SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT,
+					    erofs_inode_init_once);
 	if (!erofs_inode_cachep)
 		return -ENOMEM;
 
-- 
2.19.1.6.gb485710b

