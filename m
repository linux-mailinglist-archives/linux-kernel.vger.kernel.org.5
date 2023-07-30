Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CDF7685FF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 16:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjG3O0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 10:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjG3O0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 10:26:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E636199
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 07:26:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0BE660BA4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 14:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2771CC433CB;
        Sun, 30 Jul 2023 14:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690727160;
        bh=bFoKB/RBY0k016vlqdS3IXGsfWxj2zFbV5ucQ5U5Jko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvlXf1CA7g/XmjfjJdtJ6c5ETDOLD/8Qj13TesgGPngkufKf1IU5Gm7iTd279MJN1
         AjNS5xyN4szVN3sey0hDrrJQBfGDrOtE4O5Y6VI9u4L725UyHOQGm40Zwstr5quhMa
         XTHggwb/BYyTRd+PzDMsEmNgFE4zQ9iyertfROQPmcPZbLGqXnBmElLKbQGGUsvdk6
         3lgqwOOHXTfwnc1JgxhcqQihPRW9bEVkkujSsO9tHtZp7bmOO0UAINy3BhdgiFkGre
         OltpB1i+2DVBtrJ1Q1Ev/iALlprSlHPZPkY2Xg/YhVrAAcpwZ41eT7f302LH4mhmbp
         V5GBZnn2JMhjw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] Revert "f2fs: do not issue small discard commands during checkpoint"
Date:   Sun, 30 Jul 2023 22:25:52 +0800
Message-Id: <20230730142552.3918623-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230730142552.3918623-1-chao@kernel.org>
References: <20230730142552.3918623-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we have two mechanisms to cache & submit small discards:

a) set max small discard number in /sys/fs/f2fs/vdb/max_small_discards,
and checkpoint will cache small discard candidates w/ configured maximum
number.

b) call FITRIM ioctl, also, checkpoint in f2fs_trim_fs() will cache small
discard candidates w/ configured discard granularity, but w/o limitation
of number. FSTRIM interface is asynchronized, so it won't submit discard
directly.

Finally, discard thread will submit them in background periodically.

However, after commit 9ac00e7cef10 ("f2fs: do not issue small discard
commands during checkpoint"), the mechanism a) is broken, since no matter
how we configure the sysfs entry /sys/fs/f2fs/vdb/max_small_discards,
checkpoint will not cache small discard candidates any more.

echo 0 > /sys/fs/f2fs/vdb/max_small_discards
xfs_io -f /mnt/f2fs/file -c "pwrite 0 2m" -c "fsync"
xfs_io /mnt/f2fs/file -c "fpunch 0 4k"
sync
cat /proc/fs/f2fs/vdb/discard_plist_info |head -2

echo 100 > /sys/fs/f2fs/vdb/max_small_discards
rm /mnt/f2fs/file
xfs_io -f /mnt/f2fs/file -c "pwrite 0 2m" -c "fsync"
xfs_io /mnt/f2fs/file -c "fpunch 0 4k"
sync
cat /proc/fs/f2fs/vdb/discard_plist_info |head -2

Before the patch:
Discard pend list(Show diacrd_cmd count on each entry, .:not exist):
  0         .       .       .       .       .       .       .       .
Discard pend list(Show diacrd_cmd count on each entry, .:not exist):
  0         3       1       .       .       .       .       .       .

After the patch:
Discard pend list(Show diacrd_cmd count on each entry, .:not exist):
  0         .       .       .       .       .       .       .       .
Discard pend list(Show diacrd_cmd count on each entry, .:not exist):
  0         .       .       .       .       .       .       .       .

This patch reverts commit 9ac00e7cef10 ("f2fs: do not issue small discard
commands during checkpoint") in order to fix this issue.

Fixes: 9ac00e7cef10 ("f2fs: do not issue small discard commands during checkpoint")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6e5d1039ca76..1f0a25011687 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2195,7 +2195,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 			len = next_pos - cur_pos;
 
 			if (f2fs_sb_has_blkzoned(sbi) ||
-					!force || len < cpc->trim_minlen)
+			    (force && len < cpc->trim_minlen))
 				goto skip;
 
 			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
-- 
2.40.1

