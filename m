Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FE8804B00
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344593AbjLEHRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbjLEHRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:17:47 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02C2120;
        Mon,  4 Dec 2023 23:17:51 -0800 (PST)
X-UUID: 72c259b530ca412d990ed16bea96c82a-20231205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:37ff4f08-ae8f-4c00-be1f-4934fa865b46,IP:20,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-INFO: VERSION:1.1.33,REQID:37ff4f08-ae8f-4c00-be1f-4934fa865b46,IP:20,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:5
X-CID-META: VersionHash:364b77b,CLOUDID:cf802996-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:231205151737ZPV80MR5,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 72c259b530ca412d990ed16bea96c82a-20231205
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 554557348; Tue, 05 Dec 2023 15:17:36 +0800
From:   Hao Ge <gehao@kylinos.cn>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gehao618@163.com, Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] fs/namei: Don't update atime when some errors occur in get_link
Date:   Tue,  5 Dec 2023 15:17:33 +0800
Message-Id: <20231205071733.334474-1-gehao@kylinos.cn>
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

Perhaps we have some errors occur(like security),then we don't update
atime,because we didn't actually access it

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 fs/namei.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..033d36d5c1c5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1779,15 +1779,6 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 			unlikely(link->mnt->mnt_flags & MNT_NOSYMFOLLOW))
 		return ERR_PTR(-ELOOP);
 
-	if (!(nd->flags & LOOKUP_RCU)) {
-		touch_atime(&last->link);
-		cond_resched();
-	} else if (atime_needs_update(&last->link, inode)) {
-		if (!try_to_unlazy(nd))
-			return ERR_PTR(-ECHILD);
-		touch_atime(&last->link);
-	}
-
 	error = security_inode_follow_link(link->dentry, inode,
 					   nd->flags & LOOKUP_RCU);
 	if (unlikely(error))
@@ -1810,6 +1801,16 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 		if (IS_ERR(res))
 			return res;
 	}
+
+	if (!(nd->flags & LOOKUP_RCU)) {
+		touch_atime(&last->link);
+		cond_resched();
+	} else if (atime_needs_update(&last->link, inode)) {
+		if (!try_to_unlazy(nd))
+			return ERR_PTR(-ECHILD);
+		touch_atime(&last->link);
+	}
+
 	if (*res == '/') {
 		error = nd_jump_root(nd);
 		if (unlikely(error))
-- 
2.25.1

