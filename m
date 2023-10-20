Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0407D1428
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377916AbjJTQhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjJTQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:37:00 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BA4D63
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:36:57 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-351250be257so3707665ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697819817; x=1698424617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t9hC4nL6redQSBoYQJzaTuLfHsbZDhIMKmoiNfdDp30=;
        b=fC/1kg6wXsaUJbb2Fnj9NUerspWAGaLseuimoLq9142tYvfSFB6wm5q6oLwslyFjxL
         /C7h2PEBxxZVb3SrmVEuj0R/5qzoeLqgdAZYBC5jhOvdsAup/K0e0pPX9tGH4uQO3QgL
         DwDMt3J9HHP1DzmFM8vGl+2dUA8iS73bSJnjjzLJt8DRv+/31V4746JdVWe3CJ7jfcwT
         7dBixpxhVM8FvyN6PlhpsDXMtjl3BvaqVGgPayrxNAif3vqfTyb6S6wwEI+u1zkKdXt5
         ptQ4+xdm+vQOj05AdgIyjcpaRwIDEosBJQBBBpw8YFDxp1FJE7Aln5Q00cI7g/dB/2aU
         WuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697819817; x=1698424617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9hC4nL6redQSBoYQJzaTuLfHsbZDhIMKmoiNfdDp30=;
        b=tfbcnyP3QTYcHz8zpCXBfLysYGTTyQNcQo2GiugjIY1dlpU8m+9b+BfEMnGL091tKP
         CMQ1VAjkv/il2/uYsa+xHcMGRhlaeb+AlpAU8d9pcuwjj6/Kx++7bypO5FmprdU5lf7f
         7WFOtuxNpxhndO6YK7KJXKdxh5IckSXaKDM1zOF/7+sHK0celFCksOzLnOcMX5YNCWuK
         Ai3qDVqEAJ4sjdGwMD8RkZvkbDtOubWj3go7yUVk5kxXZaP/saKDCALQFLSnTI6kw7aA
         PsehUoENVgGGJZ3x6FSmdYpcIem2BFg8mvBWMo4OHa6nu5oy5aFIsHaK+zGAgxGITJuM
         oZXg==
X-Gm-Message-State: AOJu0Yz75PyANYz8oUP3AtQzCjCJkeQuO9KnJHry6I5s6zbZ/mAAzuLL
        tifLf82gkHxYza/2kAjMSu9B4udY9CI=
X-Google-Smtp-Source: AGHT+IErBYRk5RSu27/tu6H4mXHVqWs0dQWv7AHNX55KFrbnnB+ii+yjDutyMqVXdXx8OcYYdac6Bg==
X-Received: by 2002:a05:6e02:1544:b0:345:787a:cb1c with SMTP id j4-20020a056e02154400b00345787acb1cmr3151137ilu.6.1697819816765;
        Fri, 20 Oct 2023 09:36:56 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:b74d:59d2:dbfd:c8dd])
        by smtp.gmail.com with ESMTPSA id f15-20020a63f10f000000b005af7ee01ab4sm1699571pgi.6.2023.10.20.09.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 09:36:56 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: finish previous checkpoints before returning from remount
Date:   Fri, 20 Oct 2023 09:36:45 -0700
Message-ID: <20231020163645.2852056-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Flush remaining checkpoint requests at the end of remount, since a new
checkpoint would be triggered while remount and we need to take care of
it before returning from remount, in order to avoid the below race
condition.

  - Thread                          - checkpoint thread
  do_remount()
   down_write(&sb->s_umount);
   f2fs_remount()
    f2fs_disable_checkpoint(sbi) -> add checkpoints to the list
                                    block_operations()
                                     down_read_trylock(&sb->s_umount) = 0
   up_write(&sb->s_umount);
                                     f2fs_quota_sync()
                                      dquot_writeback_dquots()
                                       WARN_ON_ONCE(!rwsem_is_locked(&sb->s_umount));

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/super.c | 59 +++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a8c8232852bb..d6edf7df6abd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2286,9 +2286,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	unsigned long old_sb_flags;
 	int err;
 	bool need_restart_gc = false, need_stop_gc = false;
-	bool need_restart_ckpt = false, need_stop_ckpt = false;
 	bool need_restart_flush = false, need_stop_flush = false;
 	bool need_restart_discard = false, need_stop_discard = false;
+	bool need_enable_checkpoint = false, need_disable_checkpoint = false;
 	bool no_read_extent_cache = !test_opt(sbi, READ_EXTENT_CACHE);
 	bool no_age_extent_cache = !test_opt(sbi, AGE_EXTENT_CACHE);
 	bool enable_checkpoint = !test_opt(sbi, DISABLE_CHECKPOINT);
@@ -2452,24 +2452,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		clear_sbi_flag(sbi, SBI_IS_CLOSE);
 	}
 
-	if ((*flags & SB_RDONLY) || test_opt(sbi, DISABLE_CHECKPOINT) ||
-			!test_opt(sbi, MERGE_CHECKPOINT)) {
-		f2fs_stop_ckpt_thread(sbi);
-		need_restart_ckpt = true;
-	} else {
-		/* Flush if the prevous checkpoint, if exists. */
-		f2fs_flush_ckpt_thread(sbi);
-
-		err = f2fs_start_ckpt_thread(sbi);
-		if (err) {
-			f2fs_err(sbi,
-			    "Failed to start F2FS issue_checkpoint_thread (%d)",
-			    err);
-			goto restore_gc;
-		}
-		need_stop_ckpt = true;
-	}
-
 	/*
 	 * We stop issue flush thread if FS is mounted as RO
 	 * or if flush_merge is not passed in mount option.
@@ -2481,7 +2463,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	} else {
 		err = f2fs_create_flush_cmd_control(sbi);
 		if (err)
-			goto restore_ckpt;
+			goto restore_gc;
 		need_stop_flush = true;
 	}
 
@@ -2503,8 +2485,31 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			err = f2fs_disable_checkpoint(sbi);
 			if (err)
 				goto restore_discard;
+			need_enable_checkpoint = true;
 		} else {
 			f2fs_enable_checkpoint(sbi);
+			need_disable_checkpoint = true;
+		}
+	}
+
+	/*
+	 * Place this routine at the end, since a new checkpoint would be
+	 * triggered while remount and we need to take care of it before
+	 * returning from remount.
+	 */
+	if ((*flags & SB_RDONLY) || test_opt(sbi, DISABLE_CHECKPOINT) ||
+			!test_opt(sbi, MERGE_CHECKPOINT)) {
+		f2fs_stop_ckpt_thread(sbi);
+	} else {
+		/* Flush if the prevous checkpoint, if exists. */
+		f2fs_flush_ckpt_thread(sbi);
+
+		err = f2fs_start_ckpt_thread(sbi);
+		if (err) {
+			f2fs_err(sbi,
+			    "Failed to start F2FS issue_checkpoint_thread (%d)",
+			    err);
+			goto restore_checkpoint;
 		}
 	}
 
@@ -2522,6 +2527,13 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	adjust_unusable_cap_perc(sbi);
 	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 	return 0;
+restore_checkpoint:
+	if (need_enable_checkpoint) {
+		f2fs_enable_checkpoint(sbi);
+	} else if (need_disable_checkpoint) {
+		if (f2fs_disable_checkpoint(sbi))
+			f2fs_warn(sbi, "checkpoint has not been disabled");
+	}
 restore_discard:
 	if (need_restart_discard) {
 		if (f2fs_start_discard_thread(sbi))
@@ -2537,13 +2549,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		clear_opt(sbi, FLUSH_MERGE);
 		f2fs_destroy_flush_cmd_control(sbi, false);
 	}
-restore_ckpt:
-	if (need_restart_ckpt) {
-		if (f2fs_start_ckpt_thread(sbi))
-			f2fs_warn(sbi, "background ckpt thread has stopped");
-	} else if (need_stop_ckpt) {
-		f2fs_stop_ckpt_thread(sbi);
-	}
 restore_gc:
 	if (need_restart_gc) {
 		if (f2fs_start_gc_thread(sbi))
-- 
2.42.0.283.g2d96d420d3-goog

