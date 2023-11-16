Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5187EDB85
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjKPG0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjKPG0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:26:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89F2127
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:26:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E298C433CA;
        Thu, 16 Nov 2023 06:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700115966;
        bh=4ui5+7aVz7Gqv0sQoth9MwnoQqqjL6flt9PtV4MBJnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHDeTQZSCIyaqUr9vYjCrR938zf9P6Ll63wLDGPERCA0VvpwEVjIIG0g0icc4cZLO
         TTnT/WcHrP2GHjvkhHL+gPcvgoyuuVypIAHkfs4Sj5R1afufTAaJ1rxCgIfAH9oOBq
         PJCzQdFVSDGtt9mHy59T4+sLSw1pa+CAqjwXze80vBsBJ1pwUjaO5BEDxp3Cje+UXk
         wYHj0HcvrNTY7iPM8CbPqNQTu59+WLXrvsVoyqmFMnVNVBGKdcS86byQg1img9iYd0
         NZmqmjR9LhTa/lcfhJ3NbXUgZPUkuKPOsDIqhRC9Le8sCPORXc+2MGRMOlyGJOVedu
         Lkc9Lbou9tu7A==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs: fix to check return value of f2fs_reserve_new_block()
Date:   Thu, 16 Nov 2023 14:25:56 +0800
Message-Id: <20231116062556.2451839-3-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231116062556.2451839-1-chao@kernel.org>
References: <20231116062556.2451839-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's check return value of f2fs_reserve_new_block() in do_recover_data()
rather than letting it fails silently.

Also refactoring check condition on return value of f2fs_reserve_new_block()
as below:
- trigger f2fs_bug_on() only for ENOSPC case;
- use do-while statement to avoid redundant codes;

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/recovery.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b56d0f1078a7..16415c770b45 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -712,7 +712,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		 */
 		if (dest == NEW_ADDR) {
 			f2fs_truncate_data_blocks_range(&dn, 1);
-			f2fs_reserve_new_block(&dn);
+			do {
+				err = f2fs_reserve_new_block(&dn);
+				if (err == -ENOSPC) {
+					f2fs_bug_on(sbi, 1);
+					break;
+				}
+			} while (err &&
+				IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
+			if (err)
+				goto err;
 			continue;
 		}
 
@@ -720,12 +729,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
-				err = f2fs_reserve_new_block(&dn);
-				while (err &&
-				       IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION))
+				do {
 					err = f2fs_reserve_new_block(&dn);
-				/* We should not get -ENOSPC */
-				f2fs_bug_on(sbi, err);
+					if (err == -ENOSPC) {
+						f2fs_bug_on(sbi, 1);
+						break;
+					}
+				} while (err &&
+					IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
 				if (err)
 					goto err;
 			}
-- 
2.40.1

