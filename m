Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A607590B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjGSIzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGSIzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:55:14 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2B41723;
        Wed, 19 Jul 2023 01:55:06 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 36J8sfkj002172;
        Wed, 19 Jul 2023 16:54:41 +0800 (+08)
        (envelope-from Yunlong.Xing@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4R5V3935qrz2K1r9W;
        Wed, 19 Jul 2023 16:53:25 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 19 Jul 2023 16:54:38 +0800
From:   Yunlong Xing <yunlong.xing@unisoc.com>
To:     <miklos@szeredi.hu>, <amir73il@gmail.com>
CC:     <linux-unionfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhiguo.niu@unisoc.com>, <hongyu.jin@unisoc.com>,
        <yunlongxing23@gmail.com>
Subject: [PATCH V2] ovl: fix mount fail because the upper doesn't have space
Date:   Wed, 19 Jul 2023 16:54:34 +0800
Message-ID: <20230719085434.154834-1-yunlong.xing@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.5.32.15]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 36J8sfkj002172
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Cc: stable@vger.kernel.org
Signed-off-by: Yunlong Xing <yunlong.xing@unisoc.com>
---
changes of v2: Following Amir's suggestion, assuming it is not supported
if the check fails because the upper does't have space
---
 fs/overlayfs/super.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5b069f1a1e44..2b33c56fe4d7 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -744,12 +744,13 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 
 	/* Check if upper/work fs supports RENAME_WHITEOUT */
 	err = ovl_check_rename_whiteout(ofs);
-	if (err < 0)
+	if (err < 0 && err != -ENOSPC)
 		goto out;
 
-	rename_whiteout = err;
+	rename_whiteout = err > 0;
 	if (!rename_whiteout)
-		pr_warn("upper fs does not support RENAME_WHITEOUT.\n");
+		pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n,
+			err");
 
 	/*
 	 * Check if upper/work fs supports (trusted|user).overlay.* xattr
-- 
2.25.1

