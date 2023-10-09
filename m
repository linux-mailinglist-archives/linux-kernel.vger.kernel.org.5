Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CC37BD592
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345525AbjJIIqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345511AbjJIIqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:46:14 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542AC97;
        Mon,  9 Oct 2023 01:46:11 -0700 (PDT)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S3t0r6Pm7z4xPYj;
        Mon,  9 Oct 2023 16:46:04 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4S3t0p1x7Tz4xVc6;
        Mon,  9 Oct 2023 16:46:02 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 3998jsF3007730;
        Mon, 9 Oct 2023 16:45:54 +0800 (+08)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 9 Oct 2023 16:45:57 +0800 (CST)
Date:   Mon, 9 Oct 2023 16:45:57 +0800 (CST)
X-Zmail-TransId: 2b046523bdc5410-b5a72
X-Mailer: Zmail v1.0
Message-ID: <202310091645572092816@zte.com.cn>
Mime-Version: 1.0
From:   <cheng.lin130@zte.com.cn>
To:     <david@fromorbit.com>, <djwong@kernel.org>
Cc:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiang.yong5@zte.com.cn>, <wang.liang82@zte.com.cn>,
        <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY1XSB4ZnM6IGludHJvZHVjZSBwcm90ZWN0aW9uIGZvciBkcm9wIG5saW5r?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3998jsF3007730
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6523BDCC.002/4S3t0r6Pm7z4xPYj
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
return error, to avoid corruption propagation.

Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
---
 fs/xfs/xfs_inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 9e62cc500..752e6aeba 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -919,6 +919,14 @@ xfs_droplink(
 	xfs_trans_t *tp,
 	xfs_inode_t *ip)
 {
+
+	if (VFS_I(ip)->i_nlink == 0) {
+		xfs_alert(ip->i_mount,
+			  "%s: Attempt to drop inode (%llu) with nlink zero.",
+			  __func__, ip->i_ino);
+		return -EFSCORRUPTED;
+	}
+
 	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);

 	drop_nlink(VFS_I(ip));
-- 
2.18.1
