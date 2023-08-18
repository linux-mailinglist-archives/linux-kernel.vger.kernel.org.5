Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C5C780814
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358975AbjHRJOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359024AbjHRJOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:14:39 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF6A30E6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:14:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vq1xfH1_1692350071;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0Vq1xfH1_1692350071)
          by smtp.aliyun-inc.com;
          Fri, 18 Aug 2023 17:14:35 +0800
From:   Ferry Meng <mengferry@linux.alibaba.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH] freevxfs: fix potential double brelse
Date:   Fri, 18 Aug 2023 17:14:23 +0800
Message-Id: <20230818091423.97536-1-mengferry@linux.alibaba.com>
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

fs/freevxfs/vxfs_bmap.c:170 vxfs_bmap_indir() warn: passing freed memory
'bp'

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

diff --git a/fs/freevxfs/vxfs_bmap.c b/fs/freevxfs/vxfs_bmap.c
index de2a5bccb930..e2e143f182e1 100644
--- a/fs/freevxfs/vxfs_bmap.c
+++ b/fs/freevxfs/vxfs_bmap.c
@@ -126,6 +126,7 @@ vxfs_bmap_indir(struct inode *ip, long indir, int size, long block)
 
 		if (block < off) {
 			brelse(bp);
+			bp = NULL;
 			continue;
 		}
 
@@ -162,6 +163,7 @@ vxfs_bmap_indir(struct inode *ip, long indir, int size, long block)
 			BUG();
 		}
 		brelse(bp);
+		bp = NULL;
 	}
 
 fail:
-- 
2.19.1.6.gb485710b

