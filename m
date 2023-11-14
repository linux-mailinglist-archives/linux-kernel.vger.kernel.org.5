Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53A47EAAC2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjKNHHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjKNHHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:07:10 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C22D194
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:07:07 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VwOdhoI_1699945624;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VwOdhoI_1699945624)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 15:07:05 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
Subject: [PATCH] erofs: fix NULL dereference of dif->bdev_handle in fscache mode
Date:   Tue, 14 Nov 2023 15:07:04 +0800
Message-Id: <20231114070704.23398-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid NULL dereference of dif->bdev_handle, as dif->bdev_handle is NULL
in fscache mode.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 RIP: 0010:erofs_map_dev+0xbd/0x1c0
 Call Trace:
  <TASK>
  erofs_fscache_data_read_slice+0xa7/0x340
  erofs_fscache_data_read+0x11/0x30
  erofs_fscache_readahead+0xd9/0x100
  read_pages+0x47/0x1f0
  page_cache_ra_order+0x1e5/0x270
  filemap_get_pages+0xf2/0x5f0
  filemap_read+0xb8/0x2e0
  vfs_read+0x18d/0x2b0
  ksys_read+0x53/0xd0
  do_syscall_64+0x42/0xf0
  entry_SYSCALL_64_after_hwframe+0x6e/0x76

Reported-by: Yiqun Leng <yqleng@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7245
Fixes: 49845720080d ("erofs: Convert to use bdev_open_by_path()")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 029c761670bf..c98aeda8abb2 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -220,7 +220,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return 0;
 		}
-		map->m_bdev = dif->bdev_handle->bdev;
+		map->m_bdev = dif->bdev_handle ? dif->bdev_handle->bdev : NULL;
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
 		map->m_fscache = dif->fscache;
@@ -238,7 +238,8 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
-				map->m_bdev = dif->bdev_handle->bdev;
+				map->m_bdev = dif->bdev_handle ?
+					      dif->bdev_handle->bdev : NULL;
 				map->m_daxdev = dif->dax_dev;
 				map->m_dax_part_off = dif->dax_part_off;
 				map->m_fscache = dif->fscache;
-- 
2.19.1.6.gb485710b

