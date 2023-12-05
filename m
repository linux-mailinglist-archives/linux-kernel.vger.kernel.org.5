Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A705804A8A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344460AbjLEGqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344314AbjLEGp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:45:59 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841D4FA;
        Mon,  4 Dec 2023 22:46:02 -0800 (PST)
X-UUID: 4c47d4fd5f5041c8903432bd1658bbbf-20231205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:00b6a15c-1b73-4337-85fa-11824a6e7ffd,IP:10,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-5
X-CID-INFO: VERSION:1.1.33,REQID:00b6a15c-1b73-4337-85fa-11824a6e7ffd,IP:10,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:94142996-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:231205144549Q1BJF2JL,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 4c47d4fd5f5041c8903432bd1658bbbf-20231205
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 82101613; Tue, 05 Dec 2023 14:45:47 +0800
From:   Hao Ge <gehao@kylinos.cn>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gehao618@163.com, Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] fs/inode: Make relatime_need_update return bool
Date:   Tue,  5 Dec 2023 14:45:45 +0800
Message-Id: <20231205064545.332322-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

relatime_need_update should return bool to consistent with the function
__atime_needs_update that is caller

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 fs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index f238d987dec9..c0b50cdf7154 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1836,37 +1836,37 @@ EXPORT_SYMBOL(bmap);
  * earlier than or equal to either the ctime or mtime,
  * or if at least a day has passed since the last atime update.
  */
-static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
+static bool relatime_need_update(struct vfsmount *mnt, struct inode *inode,
 			     struct timespec64 now)
 {
 	struct timespec64 atime, mtime, ctime;
 
 	if (!(mnt->mnt_flags & MNT_RELATIME))
-		return 1;
+		return true;
 	/*
 	 * Is mtime younger than or equal to atime? If yes, update atime:
 	 */
 	atime = inode_get_atime(inode);
 	mtime = inode_get_mtime(inode);
 	if (timespec64_compare(&mtime, &atime) >= 0)
-		return 1;
+		return true;
 	/*
 	 * Is ctime younger than or equal to atime? If yes, update atime:
 	 */
 	ctime = inode_get_ctime(inode);
 	if (timespec64_compare(&ctime, &atime) >= 0)
-		return 1;
+		return true;
 
 	/*
 	 * Is the previous atime value older than a day? If yes,
 	 * update atime:
 	 */
 	if ((long)(now.tv_sec - atime.tv_sec) >= 24*60*60)
-		return 1;
+		return true;
 	/*
 	 * Good, we can skip the atime update:
 	 */
-	return 0;
+	return false;
 }
 
 /**
-- 
2.25.1

