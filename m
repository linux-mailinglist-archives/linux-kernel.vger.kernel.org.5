Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09F78081D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358998AbjHRJSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359029AbjHRJRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:17:44 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DB73AAC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:17:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vq1y0ap_1692350254;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0Vq1y0ap_1692350254)
          by smtp.aliyun-inc.com;
          Fri, 18 Aug 2023 17:17:37 +0800
From:   Ferry Meng <mengferry@linux.alibaba.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH] ntfs: fix potential uninitialized symbol err
Date:   Fri, 18 Aug 2023 17:17:15 +0800
Message-Id: <20230818091715.104037-1-mengferry@linux.alibaba.com>
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

fs/ntfs3/attrib.c:1503 attr_wof_frame_info() error: uninitialized symbol
'err'.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index a9d82bbb4729..f027c35c7f5f 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1372,7 +1372,7 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 	u8 bytes_per_off;
 	char *addr;
 	struct page *page;
-	int i, err;
+	int i, err = 0;
 	__le32 *off32;
 	__le64 *off64;
 
-- 
2.19.1.6.gb485710b

