Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0C9780820
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359005AbjHRJTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359061AbjHRJTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:19:03 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44AF358D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:19:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vq1xhCX_1692350334;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0Vq1xhCX_1692350334)
          by smtp.aliyun-inc.com;
          Fri, 18 Aug 2023 17:18:58 +0800
From:   Ferry Meng <mengferry@linux.alibaba.com>
To:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH] ubifs: fix missing error code err
Date:   Fri, 18 Aug 2023 17:18:48 +0800
Message-Id: <20230818091848.108186-1-mengferry@linux.alibaba.com>
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

Fix smatch warning:

fs/ubifs/journal.c:1610 ubifs_jnl_truncate() warn: missing error code
'err'

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index dc52ac0f4a34..ab837b73d4b9 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1607,6 +1607,7 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 				ubifs_err(c, "bad data node (block %u, inode %lu)",
 					  blk, inode->i_ino);
 				ubifs_dump_node(c, dn, dn_size);
+				err = -EUCLEAN;
 				goto out_free;
 			}
 
-- 
2.19.1.6.gb485710b

