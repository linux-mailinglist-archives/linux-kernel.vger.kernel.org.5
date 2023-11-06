Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6767E299D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjKFQWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjKFQWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:22:06 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D270AF4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:22:03 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc7077d34aso34046615ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 08:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699287723; x=1699892523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ontWk/Gfd+1ClRU8S1ecUeiyyEe4B3WZZGqOu2axT60=;
        b=JiSQwWSZ19QI3dTdtPD1I9xWqi8X5Xc7CRZz9sGacAZJs3q/Y7+A8QhU6QWHRhX7tR
         t85unewtM1TAtYugcC2OPbkApk5QAwciXBje8cEcuFeNMmrIGQbg2UFXTk9x+whI9HYH
         3R1MIzLmbGkuCvB5kZiPA3w9MYgnVsCd4kiWvrqt9SULksGgLPPFucV2JRAmebMMrS7v
         7j5THOLInXNfjixiX68CXBYjL/fP1H19DLJr+SXSy1liWpsT4uKDkVvjmX/Lv2QOWAPc
         mzE6RxjpFdlhl2/4hdDs1oV5nd5ZVE44Vkdw1d2nt5EaAEsaFMO7QLfpTneX4K5oyo2o
         AdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287723; x=1699892523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ontWk/Gfd+1ClRU8S1ecUeiyyEe4B3WZZGqOu2axT60=;
        b=Glb9tD6v4TmzjwIYGGCmzhM5NSL38GIHDE51TevMzMfXGB1ITlaPuLUNeVnaei2MKd
         2PWRfKOhYJqe3RkawXIDofXQVS2/j4J4UgyjLRkjxGWYkoXFb2sDerIGTQV3WIo+WPlM
         vmis1SIrEnXeuUu+8KZh2nmKvx/S0117C5L8NwkkutLBLwzMDIFhwD1FpDLacZxMyime
         /+cV3uuyCZ/XMo2xrvuYE2rSNoWJFs5cYPCMjAcsRp2Dk5UefLgHV6ZachwD/WnCxBBp
         zNDl4ezAzl5ZuiwHVp2lIDqRjDsxkRplFKpS4HdZTcfrffuyzWZsiYCjoTfftNpSOPSq
         uj+A==
X-Gm-Message-State: AOJu0YznK0ZayMInQ8nNyt7c0c3fnzWaN/opEKaPtvfU7oiTE9PNVHj8
        zN/vR95h8gGrP/FAiUXKd7jYCjXyHtkaAg==
X-Google-Smtp-Source: AGHT+IESzrSFUSyy0nslnFEdRDcQsp+VE2Zn8I6F9irauWD4JiMqW6c80oP/+sub9u1BIUjhtEM1Fw==
X-Received: by 2002:a17:903:11c4:b0:1cc:6e8f:c14d with SMTP id q4-20020a17090311c400b001cc6e8fc14dmr17700554plh.50.1699287722885;
        Mon, 06 Nov 2023 08:22:02 -0800 (PST)
Received: from Osmten.. ([103.84.150.76])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b001c61df93afdsm6135598plh.59.2023.11.06.08.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 08:22:02 -0800 (PST)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     rpeterso@redhat.com, agruenba@redhat.com
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>,
        syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotmail.com
Subject: [PATCH] fs:gfs2:rgrp.c: Fix kernel NULL pointer dereference
Date:   Mon,  6 Nov 2023 21:21:29 +0500
Message-Id: <20231106162129.10556-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported the following issue:

i_length = 1
ri_data0 = 19
ri_data = 2060
ri_bitbytes = 514
start=0 len=514 offset=128
gfs2: fsid=syz:syz.s:  R: n:18 f:00 b:0/0 i:0 q:0 r:0 e:0
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010e23f000
[0000000000000004] pgd=080000010b804003, p4d=080000010b804003, pud=080000010a4e8003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3072 Comm: syz-executor147 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : gfs2_rgrp_dump+0xa0/0x138 fs/gfs2/rgrp.c:2313
lr : gfs2_rgrp_dump+0x90/0x138
sp : ffff80000fb93780
x29: ffff80000fb937a0 x28: ffff0000cb82a000 x27: ffff0000cb82a000
x26: ffff0000ca4de000 x25: 0000000000000808 x24: 000000000000080c
x23: 000000000001c103 x22: ffff0000ca4de000 x21: 0000000000000000
x20: ffff80000fb937e0 x19: ffff0000ca4de080 x18: 00000000000000c0
x17: ffff80000dda8198 x16: ffff80000dbe6158 x15: ffff0000c6800000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c6800000
x11: ff808000092a5154 x10: 0000000000000000 x9 : ffff8000092a5154
x8 : 0000000000000000 x7 : ffff80000c091ebc x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbecd0 x1 : ffff80000cc9c685 x0 : 0000000000000000
Call trace:
 gfs2_rgrp_dump+0xa0/0x138 fs/gfs2/rgrp.c:2312
 gfs2_consist_rgrpd_i+0x78/0xe4 fs/gfs2/util.c:480
 read_rindex_entry fs/gfs2/rgrp.c:931 [inline]
 gfs2_ri_update+0x398/0x7e4 fs/gfs2/rgrp.c:1001
 gfs2_rindex_update+0x1b0/0x21c fs/gfs2/rgrp.c:1051
 init_inodes+0x11c/0x184 fs/gfs2/ops_fstype.c:917
 gfs2_fill_super+0x630/0x874 fs/gfs2/ops_fstype.c:1247
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1324
 gfs2_get_tree+0x30/0xc0 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x890 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: f94036c8 f001cfa1 911a1421 aa1503e0 (2940a909)
---[ end trace 0000000000000000 ]---

The issue is caused during prinitng debug information when
accessing the pointer rgd->rd_rgl. So adding condition to
check the pointer is not NULL fixes the bug.

The patch is tested via syzbot.

Reported-and-tested-by: syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=da0fc229cc1ff4bb2e6d
Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 fs/gfs2/rgrp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 9308190895c8..307b952a41f8 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -2306,7 +2306,7 @@ void gfs2_rgrp_dump(struct seq_file *seq, struct gfs2_rgrpd *rgd,
 		       (unsigned long long)rgd->rd_addr, rgd->rd_flags,
 		       rgd->rd_free, rgd->rd_free_clone, rgd->rd_dinodes,
 		       rgd->rd_requested, rgd->rd_reserved, rgd->rd_extfail_pt);
-	if (rgd->rd_sbd->sd_args.ar_rgrplvb) {
+	if (rgd->rd_sbd->sd_args.ar_rgrplvb && rgd->rd_rgl) {
 		struct gfs2_rgrp_lvb *rgl = rgd->rd_rgl;
 
 		gfs2_print_dbg(seq, "%s  L: f:%02x b:%u i:%u\n", fs_id_buf,
-- 
2.34.1

