Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F7E801740
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjLAXCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAXCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:02:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFBA103
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:02:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93566C433C8;
        Fri,  1 Dec 2023 23:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701471778;
        bh=62w1oB1pHopShKh9tMtaRg6KHPHhkdny8MubdbV91fQ=;
        h=From:To:Cc:Subject:Date:From;
        b=c2HCOXrnwzG/PgSp+pZZQxjdPmCpwKk49Hqhbo/Ro12tzYvu/nAGK4SXLEUorI70u
         EiN9jVDo+4/2wJ7rrCB1fCsletjR+fW18IqsR+Sq+JlEF82jXTj+jCSiLQ1NcgoC25
         HhXUARvjWEglu0kJZIsOY4ZVJGAa/k+6xp8Xwo1QB3aRagRBuy14GgtD8nkhbd/SHn
         3QHNk/2AnuZAWzlnocjletodpcc3MpV+GcQKLwh/lkU4nZGKXfnzAXBc+b0oM0w+Sl
         8HDJHqePbA88m+S6IYBuGXoGTxbd2G7XAZ9v4y7XX07kbTinTdOqB487uU0DwbbOnZ
         BjE8UUeYynNlg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: allow checkpoint=disable for zoned block device
Date:   Fri,  1 Dec 2023 15:02:56 -0800
Message-ID: <20231201230257.238513-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's allow checkpoint=disable back for zoned block device. It's very risky
as the feature relies on fsck or runtime recovery which matches the write
pointers again if the device rebooted while disabling the checkpoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 033af907c3b1..617340e9ea7f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1422,11 +1422,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		}
 	}
 
-	if (test_opt(sbi, DISABLE_CHECKPOINT) && f2fs_lfs_mode(sbi)) {
-		f2fs_err(sbi, "LFS is not compatible with checkpoint=disable");
-		return -EINVAL;
-	}
-
 	if (test_opt(sbi, ATGC) && f2fs_lfs_mode(sbi)) {
 		f2fs_err(sbi, "LFS is not compatible with ATGC");
 		return -EINVAL;
-- 
2.43.0.rc2.451.g8631bc7472-goog

