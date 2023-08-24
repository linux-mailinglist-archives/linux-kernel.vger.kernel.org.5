Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E067868DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjHXHok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240436AbjHXHob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:44:31 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D6510D0;
        Thu, 24 Aug 2023 00:44:27 -0700 (PDT)
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4RWZpt1Tz2zQ66;
        Thu, 24 Aug 2023 15:44:22 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4RWZpT5yCMzBRHKp;
        Thu, 24 Aug 2023 15:44:01 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RWZpM0vg4z8XrRD;
        Thu, 24 Aug 2023 15:43:55 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
        by mse-fl2.zte.com.cn with SMTP id 37O7hoQm047164;
        Thu, 24 Aug 2023 15:43:50 +0800 (+08)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 24 Aug 2023 15:43:52 +0800 (CST)
Date:   Thu, 24 Aug 2023 15:43:52 +0800 (CST)
X-Zmail-TransId: 2b0564e70a3801d-0dc13
X-Mailer: Zmail v1.0
Message-ID: <202308241543526473806@zte.com.cn>
Mime-Version: 1.0
From:   <cheng.lin130@zte.com.cn>
To:     <djwong@kernel.org>
Cc:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiang.yong5@zte.com.cn>, <wang.liang82@zte.com.cn>,
        <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSB4ZnM6IGludHJvZHVjZSBwcm90ZWN0aW9uIGZvciBkcm9wIG5saW5r?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 37O7hoQm047164
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64E70A55.000/4RWZpt1Tz2zQ66
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cheng Lin <cheng.lin130@zte.com.cn>
An dir nlinks overflow which down form 0 to 0xffffffff, cause the
directory to become unusable until the next xfs_repair run.

Introduce protection for drop nlink to reduce the impact of this.
And produce a warning for directory nlink error during remove.

Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
---
 fs/xfs/xfs_inode.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 9e62cc5..536dbe4 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -919,6 +919,15 @@ STATIC int xfs_iunlink_remove(struct xfs_trans *tp, struct xfs_perag *pag,
 	xfs_trans_t *tp,
 	xfs_inode_t *ip)
 {
+	xfs_mount_t     *mp;
+
+	if (VFS_I(ip)->i_nlink == 0) {
+		mp = ip->i_mount;
+		xfs_warn(mp, "%s: Deleting inode %llu with no links.",
+			 __func__, ip->i_ino);
+		return 0;
+	}
+
 	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);

 	drop_nlink(VFS_I(ip));
@@ -2442,7 +2451,12 @@ STATIC int xfs_iunlink_remove(struct xfs_trans *tp, struct xfs_perag *pag,
 	 */
 	if (is_dir) {
 		ASSERT(VFS_I(ip)->i_nlink >= 2);
-		if (VFS_I(ip)->i_nlink != 2) {
+		if (VFS_I(ip)->i_nlink < 2) {
+			xfs_warn(ip->i_mount,
+			"%s: Remove dir (inode %llu) with invalid links.",
+				 __func__, ip->i_ino);
+		}
+		if (VFS_I(ip)->i_nlink > 2) {
 			error = -ENOTEMPTY;
 			goto out_trans_cancel;
 		}
-- 
1.8.3.1
