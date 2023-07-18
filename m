Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619B47576B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjGRIgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjGRIgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:36:14 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0DEE55;
        Tue, 18 Jul 2023 01:36:10 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 36I8ZMII040720;
        Tue, 18 Jul 2023 16:35:22 +0800 (+08)
        (envelope-from Yunlong.Xing@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4R4sgP0vzwz2MhGBT;
        Tue, 18 Jul 2023 16:34:09 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 18 Jul 2023 16:35:20 +0800
From:   Yunlong Xing <yunlong.xing@unisoc.com>
To:     <miklos@szeredi.hu>, <amir73il@gmail.com>
CC:     <linux-unionfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <sashal@kernel.org>, <yunlongxing23@gmail.com>,
        <zhiguo.niu@unisoc.com>, <hongyu.jin@unisoc.com>
Subject: [PATCH] ovl: fix mount fail because the upper doesn't have space
Date:   Tue, 18 Jul 2023 16:34:37 +0800
Message-ID: <1689669277-15291-1-git-send-email-yunlong.xing@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.73.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 36I8ZMII040720
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current ovlfs mount flow:

ovl_fill_super
 |_ovl_get_workdir
    |_ovl_make_workdir
       |_ovl_check_rename_whiteout

In ovl_check_rename_whiteout(), a new file is attempted to create.But if
the upper doesn't have space to do this, it will return error -ENOSPC,
causing the mount fail. It means that if the upper is full, the overlayfs
cannot be mounted.It is not reasonable, so this patch will omit this error
 and continue mount flow.

Fixes: cad218ab3320 ("ovl: check if upper fs supports RENAME_WHITEOUT")
Signed-off-by: Yunlong Xing <yunlong.xing@unisoc.com>
---
 fs/overlayfs/super.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5b069f1a1e44..2cf41e978cff 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -744,9 +744,12 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 
 	/* Check if upper/work fs supports RENAME_WHITEOUT */
 	err = ovl_check_rename_whiteout(ofs);
-	if (err < 0)
-		goto out;
-
+	if (err < 0) {
+		if (err == -ENOSPC)
+			pr_warn("upper fs check RENAME_WHITEOUT fail due to no space.\n");
+		else
+			goto out;
+	}
 	rename_whiteout = err;
 	if (!rename_whiteout)
 		pr_warn("upper fs does not support RENAME_WHITEOUT.\n");
-- 
2.25.1

