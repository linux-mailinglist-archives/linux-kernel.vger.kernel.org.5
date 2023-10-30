Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BFB7DC126
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjJ3UYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjJ3UYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:24:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7616DAB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:24:41 -0700 (PDT)
Received: from shreeya.shreeya (unknown [IPv6:2405:201:0:21ea:b346:60fd:ff70:bb1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D70C06607393;
        Mon, 30 Oct 2023 20:24:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698697480;
        bh=xHjjpWNrK+9sCsdLHaP5uOtD1MVhITgGMsNsB8PH8oE=;
        h=From:To:Cc:Subject:Date:From;
        b=EM/FpojG55w+GvA082yamXzZOyMMbEa8S81I6+U9trLh7eN5Hh9jDSIey9sFqQVex
         fdN+doqZ+++VXUR3dW/QbJVP26OTbsvSB4mhZibin514kExl3IgQi4KsTY8sx4z5wJ
         0Z/pXgiSwlONGBIdrS0cLLvh/IhMeoNR5qJ8QfM2BeZ+GoDuJcYqbrdQPXMgZvpU6G
         Aw12bKt5J/ci4tkIgLzfB6zdtwaj/eg9O8egC4ApxkR2s9EOcWOM5DuUO/1yQ35Kip
         N2GzlFeoWLpjLZW7hI3MSfasNJhSEvx2Cf24fQByEP2Nl0SKmNdUOH3+1GbapDxJGF
         WOZZFLODZAFxQ==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        groeck@google.com, zsm@google.com,
        Shreeya Patel <shreeya.patel@collabora.com>,
        syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com
Subject: [PATCH] fs: udf: super.c: Fix a use-after-free issue in udf_finalize_lvid
Date:   Tue, 31 Oct 2023 01:54:18 +0530
Message-Id: <20231030202418.847494-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some error handling cases in udf_sb_lvidiu() and redefine
the descCRCLength in order to avoid use-after-free issue in
udf_finalize_lvid.

Following use-after-free issue was reported by syzbot :-

https://syzkaller.appspot.com/bug?extid=46073c22edd7f242c028

BUG: KASAN: use-after-free in crc_itu_t+0x97/0xc8 lib/crc-itu-t.c:60
Read of size 1 at addr ffff88816fba0000 by task syz-executor.0/32133

Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
print_address_description mm/kasan/report.c:284 [inline]
print_report+0x13c/0x462 mm/kasan/report.c:395
kasan_report+0xa9/0xd5 mm/kasan/report.c:495
crc_itu_t+0x97/0xc8 lib/crc-itu-t.c:60
udf_finalize_lvid+0x111/0x23b fs/udf/super.c:2022
udf_sync_fs+0xba/0x123 fs/udf/super.c:2378
sync_filesystem+0xe8/0x216 fs/sync.c:56
generic_shutdown_super+0x6b/0x334 fs/super.c:474
kill_block_super+0x79/0xd6 fs/super.c:1459
deactivate_locked_super+0xa0/0x101 fs/super.c:332
cleanup_mnt+0x2de/0x361 fs/namespace.c:1192
task_work_run+0x22b/0x2d4 kernel/task_work.c:179
resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
exit_to_user_mode_loop+0xc4/0xd3 kernel/entry/common.c:171
exit_to_user_mode_prepare+0xb4/0x115 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
syscall_exit_to_user_mode+0xae/0x278 kernel/entry/common.c:297
do_syscall_64+0x5d/0x93 arch/x86/entry/common.c:99
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7e8195fb6e17

Fixes: ebbd5e99f60a ("udf: factor out LVID finalization for reuse")
Reported-by: syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 fs/udf/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 928a04d9d9e0..ca8f10eaa748 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -114,6 +114,10 @@ struct logicalVolIntegrityDescImpUse *udf_sb_lvidiu(struct super_block *sb)
 	partnum = le32_to_cpu(lvid->numOfPartitions);
 	/* The offset is to skip freeSpaceTable and sizeTable arrays */
 	offset = partnum * 2 * sizeof(uint32_t);
+	if (sb->s_blocksize < sizeof(*lvid) || (sb->s_blocksize - sizeof(*lvid)) <
+	    (offset + sizeof(struct logicalVolIntegrityDescImpUse)))
+		return NULL;
+
 	return (struct logicalVolIntegrityDescImpUse *)
 					(((uint8_t *)(lvid + 1)) + offset);
 }
@@ -2337,6 +2341,8 @@ static int udf_sync_fs(struct super_block *sb, int wait)
 		struct logicalVolIntegrityDesc *lvid;
 
 		lvid = (struct logicalVolIntegrityDesc *)bh->b_data;
+		if ((le16_to_cpu(lvid->descTag.descCRCLength) + sizeof(struct tag)) > sb->s_blocksize)
+			lvid->descTag.descCRCLength = cpu_to_le16(sb->s_blocksize - sizeof(struct tag));
 		udf_finalize_lvid(lvid);
 
 		/*
-- 
2.39.2

