Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6326B79A5BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjIKIN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjIKINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:13:23 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A91CCD;
        Mon, 11 Sep 2023 01:13:15 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Rkfbn6Pltz6G448;
        Mon, 11 Sep 2023 16:13:09 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
        by mse-fl1.zte.com.cn with SMTP id 38B8Cs59016612;
        Mon, 11 Sep 2023 16:12:54 +0800 (+08)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp05[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 11 Sep 2023 16:12:56 +0800 (CST)
Date:   Mon, 11 Sep 2023 16:12:56 +0800 (CST)
X-Zmail-TransId: 2b0764fecc08516-35b35
X-Mailer: Zmail v1.0
Message-ID: <202309111612569712762@zte.com.cn>
Mime-Version: 1.0
From:   <cheng.lin130@zte.com.cn>
To:     <david@fromorbit.com>, <djwong@kernel.org>
Cc:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiang.yong5@zte.com.cn>, <wang.liang82@zte.com.cn>,
        <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyXSB4ZnM6IGludHJvZHVjZSBwcm90ZWN0aW9uIGZvciBkcm9wIG5saW5r?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 38B8Cs59016612
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64FECC15.001/4Rkfbn6Pltz6G448
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cheng Lin <cheng.lin130@zte.com.cn>

When abnormal drop_nlink are detected on the inode,
shutdown filesystem, to avoid corruption propagation.

Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
---
 fs/xfs/xfs_fsops.c | 3 +++
 fs/xfs/xfs_inode.c | 9 +++++++++
 fs/xfs/xfs_mount.h | 1 +
 3 files changed, 13 insertions(+)

diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 7cb75cb6b..6fc1cfe83 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -543,6 +543,9 @@ xfs_do_force_shutdown(
 	} else if (flags & SHUTDOWN_CORRUPT_ONDISK) {
 		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
 		why = "Corruption of on-disk metadata";
+	} else if (flags & SHUTDOWN_CORRRUPT_ABN) {
+		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
+		why = "Corruption of Abnormal conditions";
 	} else if (flags & SHUTDOWN_DEVICE_REMOVED) {
 		tag = XFS_PTAG_SHUTDOWN_IOERROR;
 		why = "Block device removal";
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 9e62cc500..2d41f2461 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -919,6 +919,15 @@ xfs_droplink(
 	xfs_trans_t *tp,
 	xfs_inode_t *ip)
 {
+
+	if (VFS_I(ip)->i_nlink == 0) {
+		xfs_alert(ip->i_mount,
+			  "%s: Deleting inode %llu with no links.",
+			  __func__, ip->i_ino);
+		xfs_force_shutdown(ip->i_mount, SHUTDOWN_CORRRUPT_ABN);
+		return -EFSCORRUPTED;
+	}
+
 	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);

 	drop_nlink(VFS_I(ip));
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e2866e7fa..dbf36b048 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -459,6 +459,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, uint32_t flags, char *fname,
 #define SHUTDOWN_CORRUPT_INCORE	(1u << 3) /* corrupt in-memory structures */
 #define SHUTDOWN_CORRUPT_ONDISK	(1u << 4)  /* corrupt metadata on device */
 #define SHUTDOWN_DEVICE_REMOVED	(1u << 5) /* device removed underneath us */
+#define SHUTDOWN_CORRRUPT_ABN	(1u << 6) /* shutdown from abnormal conditions */

 #define XFS_SHUTDOWN_STRINGS \
 	{ SHUTDOWN_META_IO_ERROR,	"metadata_io" }, \
-- 
2.18.1
