Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969997C8D80
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjJMTJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMTJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:09:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7455083
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:09:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-278f0f565e2so1871106a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697224190; x=1697828990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lH/Hy4rJiGCIiWFGI1a/4z8j85DxIfwAOnT8uAXZzdc=;
        b=EPF3CvWf42pVgm7Z0pHkKkz8jaiiC4aPiy43nKK3lgRrRhYqghLXY9t6JXbEN/fJ0B
         eWCJELwQeEyD4JJ72FiBvTknOESasCDotkcgdj4rDCKQ30SyT3ilWXk5LwK45ZbJPw7j
         AT4LfMqRZ9esr//BGYF16RjGfrma8GmItjUO//JlTKLvVc8Q5KB7xr2M34GGKxdW63Mg
         XdY6qAHeijUfzET+Cg0cBA1dHLi6+0Ss9+rRyQYR4UAMY+sJsd7Zom5GrtxkKuH5Q3L5
         Cq1tXH25rdLgyp7Hxatn/gsdV3e0YIzMXaTsFccz71/j2dqn6J82oscoCPYTuEtdG2D+
         YqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697224190; x=1697828990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lH/Hy4rJiGCIiWFGI1a/4z8j85DxIfwAOnT8uAXZzdc=;
        b=MJapRk/NmJUNkaGioIuBwjaJwr08dNLfOlRd0eqtRYDqjAo9ybQH/4r1mdTbdpIpNx
         cwp+oGXJVx9kK7S6sQePdB2E9yE/ClyRnRlvKPG37/qzr/zVLvgxdkFEJh827rpQCPIH
         nRsByIuB5XDV+yiC84hJxBrH2zXJuK11rWQQ28xLPES/CzRpdFmpvf8LwKWppdqnbAe6
         dEaZnQ2m4UFlA+264FbYkC+YyKsK+7B8nZSKtU3pOtq65jKtMPKR4QxIR8u8FiyZiRyO
         Bz2AGntABHfL0jIMMFnMpEb2ikfFwAKOtv7DDjARHTCvYeZKaJHO0lRwgdk4evZatW+k
         9qBw==
X-Gm-Message-State: AOJu0Yx2yn1E1b0ekhEs4GxISayYwUfUNs/2xMRveZrrtT8YH8O1kPIW
        t5yVZeuMtZN/MMowDtdaOKE=
X-Google-Smtp-Source: AGHT+IEEI26nBkMkXPMgbG61rWJgb9AFJNiyI/9Dr7jtkl/qtVvZq20jmy702hapHj+/2+We819P/Q==
X-Received: by 2002:a17:90b:51c9:b0:27d:3f43:d9c0 with SMTP id sf9-20020a17090b51c900b0027d3f43d9c0mr1997360pjb.24.1697224189429;
        Fri, 13 Oct 2023 12:09:49 -0700 (PDT)
Received: from Osmten.. ([103.84.150.77])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a1a1c00b00267b38f5e13sm503089pjk.2.2023.10.13.12.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:09:47 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        syzbot+abb7222a58e4ebc930ad@syzkaller.appspotmail.com
Subject: [PATCH] UBSAN: array-index-out-of-bounds in udf_process_sequence
Date:   Sat, 14 Oct 2023 00:09:29 +0500
Message-Id: <20231013190929.17246-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported the following issue:

UBSAN: array-index-out-of-bounds in fs/udf/super.c:1365:9
index 4 is out of range for type '__le32[4]' (aka 'unsigned int[4]')
CPU: 0 PID: 6060 Comm: syz-executor319 Not tainted 6.5.0-rc6-syzkaller-00253-g9e6c269de404 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 udf_load_sparable_map fs/udf/super.c:1365 [inline]
 udf_load_logicalvol fs/udf/super.c:1457 [inline]
 udf_process_sequence+0x300d/0x4e70 fs/udf/super.c:1773
 udf_load_sequence fs/udf/super.c:1820 [inline]
 udf_check_anchor_block+0x2a6/0x550 fs/udf/super.c:1855
 udf_scan_anchors fs/udf/super.c:1888 [inline]
 udf_load_vrs+0x5ca/0x1100 fs/udf/super.c:1969
 udf_fill_super+0x95d/0x23a0 fs/udf/super.c:2147
 mount_bdev+0x276/0x3b0 fs/super.c:1391
 legacy_get_tree+0xef/0x190 fs/fs_context.c:611
 vfs_get_tree+0x8c/0x270 fs/super.c:1519
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f363cae1c8a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 3e 07 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe6eac67a8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f363cae1c8a
RDX: 0000000020000100 RSI: 0000000020000340 RDI: 00007ffe6eac6800
RBP: 00007ffe6eac6840 R08: 00007ffe6eac6840 R09: 0000000000000c35
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000020000340
R13: 0000000020000100 R14: 0000000000000c3b R15: 0000000020020500
 </TASK>

The issue is caused when the value of i becomes equal or more than 4 which is
the size of array. In the code the condition checks the value of
spm->numSparingTables. syzbot was able to make spm->numSparingTables
value 4 which is cauing this error. The patch adds one more condition
to check the value of i should be less than 4.

Reported-and-tested-by: syzbot+abb7222a58e4ebc930ad@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=abb7222a58e4ebc930ad
Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 fs/udf/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 928a04d9d9e0..8c8731c3f8d9 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1361,7 +1361,7 @@ static int udf_load_sparable_map(struct super_block *sb,
 		return -EIO;
 	}
 
-	for (i = 0; i < spm->numSparingTables; i++) {
+	for (i = 0; i < spm->numSparingTables && i < 4; i++) {
 		loc = le32_to_cpu(spm->locSparingTable[i]);
 		bh = udf_read_tagged(sb, loc, loc, &ident);
 		if (!bh)
-- 
2.34.1

