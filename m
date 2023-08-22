Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9617F783E91
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjHVLFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjHVLFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:05:38 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7B81BE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:05:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VqMKLwI_1692702330;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqMKLwI_1692702330)
          by smtp.aliyun-inc.com;
          Tue, 22 Aug 2023 19:05:31 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
Subject: [PATCH] erofs: release ztailpacking pclusters properly
Date:   Tue, 22 Aug 2023 19:05:30 +0800
Message-Id: <20230822110530.96831-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

Currently ztailpacking pclusters are chained with FOLLOWED_NOINPLACE and
not recorded into the managed_pslots XArray.

After commit 7674a42f35ea ("erofs: use struct lockref to replace
handcrafted approach"), ztailpacking pclusters won't be freed with
erofs_workgroup_put() anymore, which will cause the following issue:

BUG erofs_pcluster-1 (Tainted: G           OE     ): Objects remaining in erofs_pcluster-1 on __kmem_cache_shutdown()

Use z_erofs_free_pcluster() directly to free ztailpacking pclusters.

Fixes: 7674a42f35ea ("erofs: use struct lockref to replace handcrafted approach")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/zdata.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index de4f12152b62..5419405cafb3 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1410,7 +1410,10 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		owned = READ_ONCE(be.pcl->next);
 
 		z_erofs_decompress_pcluster(&be, io->eio ? -EIO : 0);
-		erofs_workgroup_put(&be.pcl->obj);
+		if (z_erofs_is_inline_pcluster(be.pcl))
+			z_erofs_free_pcluster(be.pcl);
+		else
+			erofs_workgroup_put(&be.pcl->obj);
 	}
 }
 
-- 
2.19.1.6.gb485710b

