Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AE0804D00
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjLEI7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLEI7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:59:46 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFF8C9;
        Tue,  5 Dec 2023 00:59:52 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cfabcbda7bso27899985ad.0;
        Tue, 05 Dec 2023 00:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701766792; x=1702371592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3+mFRpZBneT3Lzm/oQTHjAQSUO9ZeAPYRer7xUZcck=;
        b=Qw7pvuXAS1exWzA8Cxc7MufbVVYp7orJOTgUMlU5OqSBNpiKy9w67l7R6B38pO1ZbU
         1vjtJptDCEgdF5sCSacPSdL9qavKiti0lsIGJ8PPNzmo1EJ/SyRvRkrXTCCtiPC9ESLL
         TKQEQhx9iWDWyl0c2emWoHzO3bcVi87wlfn64rcLwZKYfCAPcJhm3iBUlXTpes7cUFvz
         kDs3cuBzOh77iyUlznOWsxPmhP/36kOkY18b5HES/YHJf+BuyZzcn4QAVkn3GQ7xdPNR
         MlF8oB7vrbr69/BnRejT+zOpgDL9wuwWWYv30OCfFtjYmsUxPEIXDcJL2hjVFgK6JAld
         gVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701766792; x=1702371592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3+mFRpZBneT3Lzm/oQTHjAQSUO9ZeAPYRer7xUZcck=;
        b=dnHi1R7G44upwGhxEJS7FrHsXzJLa3VkpxB3PZ6yngbNZywSJCjs3x6LjjDAUMziYw
         QJdaqXbkWDGBGyWqe382C/Ra0m4f6KA7k37Y11mgnJebqMG0f7k6553eGL7s4TI10e/i
         jyqckXOxdts4eVIgl/uU/9Xzt+5dYfLfzW/QwS0UWplTz0UYZmkRzyqsa/FiqyNZ98mK
         CicefwRDm+VMitMR6WalJ4pFCJB+643nQTMMgrNhmHwFjEzXNxnB3lC4xyaqmvwpHqrM
         kUL56KNkzNVLb2SfxbcwvdAQUQzxkmt84y40pD5tdwiQQ93Xd3UTZC0wluwNIRIW0oDt
         +vxg==
X-Gm-Message-State: AOJu0YxVVfLNaYSJ4bg1S8AJnw1v5+2DFPr2LudGgHnGEK4Tq7p6ekvZ
        boG2/Dghchaqw0eI2kcjk6A=
X-Google-Smtp-Source: AGHT+IHYkm4fqLTnSn4A2JsFqtLCcQ6IxeEEk76DwRdCLsqbR5/tk+X1/ZLWF5Z6bvbqwOiMFvkd1A==
X-Received: by 2002:a17:90b:4a4b:b0:286:8abc:e66 with SMTP id lb11-20020a17090b4a4b00b002868abc0e66mr984275pjb.42.1701766791613;
        Tue, 05 Dec 2023 00:59:51 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001d060d6cde0sm7068783plb.162.2023.12.05.00.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:59:51 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+14e9f834f6ddecece094@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()
Date:   Tue,  5 Dec 2023 17:59:47 +0900
Message-Id: <20231205085947.4431-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000002052a505e9ec7d41@google.com>
References: <0000000000002052a505e9ec7d41@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If nilfs2 reads a disk image with corrupted segment usage metadata,
and its segment usage information is marked as an error for the segment
at the write location, nilfs_sufile_set_segment_usage() can trigger
WARN_ONs during log writing.

Segments newly allocated for writing with nilfs_sufile_alloc() will not
have this error flag set, but this unexpected situation will occur if
the segment indexed by either nilfs->ns_segnum or nilfs->ns_nextnum
(active segment) was marked in error.

Fix this issue by inserting a sanity check to treat it as a file system
corruption.

Since error returns are not allowed during the execution phase where
nilfs_sufile_set_segment_usage() is used, this inserts the sanity check
into nilfs_sufile_mark_dirty() which pre-reads the buffer containing the
segment usage record to be updated and sets it up in a dirty state for
writing.

In addition, nilfs_sufile_set_segment_usage() is also called when
canceling log writing and undoing segment usage update, so in order to
avoid issuing the same kernel warning in that case, in case of
cancellation, avoid checking the error flag in
nilfs_sufile_set_segment_usage().

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+14e9f834f6ddecece094@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=14e9f834f6ddecece094
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
---
Andrew, please apply this patch.  This resolves one unexpected kernel
WARNING issue reported by syzbot.

Thanks,
Ryusuke Konishi

fs/nilfs2/sufile.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 2c6078a6b8ec..58ca7c936393 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -501,15 +501,38 @@ int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
 
 	down_write(&NILFS_MDT(sufile)->mi_sem);
 	ret = nilfs_sufile_get_segment_usage_block(sufile, segnum, 0, &bh);
-	if (!ret) {
-		mark_buffer_dirty(bh);
-		nilfs_mdt_mark_dirty(sufile);
-		kaddr = kmap_atomic(bh->b_page);
-		su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
+	if (ret)
+		goto out_sem;
+
+	kaddr = kmap_atomic(bh->b_page);
+	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
+	if (unlikely(nilfs_segment_usage_error(su))) {
+		struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
+
+		kunmap_atomic(kaddr);
+		brelse(bh);
+		if (nilfs_segment_is_active(nilfs, segnum)) {
+			nilfs_error(sufile->i_sb,
+				    "active segment %llu is erroneous",
+				    (unsigned long long)segnum);
+		} else {
+			/*
+			 * Segments marked erroneous are never allocated by
+			 * nilfs_sufile_alloc(); only active segments, ie,
+			 * the segments indexed by ns_segnum or ns_nextnum,
+			 * can be erroneous here.
+			 */
+			WARN_ON_ONCE(1);
+		}
+		ret = -EIO;
+	} else {
 		nilfs_segment_usage_set_dirty(su);
 		kunmap_atomic(kaddr);
+		mark_buffer_dirty(bh);
+		nilfs_mdt_mark_dirty(sufile);
 		brelse(bh);
 	}
+out_sem:
 	up_write(&NILFS_MDT(sufile)->mi_sem);
 	return ret;
 }
@@ -536,9 +559,14 @@ int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
 
 	kaddr = kmap_atomic(bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
-	WARN_ON(nilfs_segment_usage_error(su));
-	if (modtime)
+	if (modtime) {
+		/*
+		 * Check segusage error and set su_lastmod only when updating
+		 * this entry with a valid timestamp, not for cancellation.
+		 */
+		WARN_ON_ONCE(nilfs_segment_usage_error(su));
 		su->su_lastmod = cpu_to_le64(modtime);
+	}
 	su->su_nblocks = cpu_to_le32(nblocks);
 	kunmap_atomic(kaddr);
 
-- 
2.34.1

