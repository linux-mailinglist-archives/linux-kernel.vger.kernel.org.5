Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91E17C5B92
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjJKSrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjJKSre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:47:34 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A194
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:47:32 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 46e09a7af769-6c4bf619b57so109849a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697050052; x=1697654852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uddVzm1ujX2AcdtbMSJ/3piIdX6QtZRUzkSKVd/RcdI=;
        b=dzpgHGgJnfyrHzvAhwe9//GoWvhkmSEq3fQXSpqtTGicZ3zjB/yYje4UUmX4/sbl/k
         75PlN6wS/ru0sRN+pYaM2o56VpQmqaa/Tv3gNJnhGwneQ/krIdBBeJS8gwU9MJY0o+sK
         flyafVjSkXkiGGL4FswCIXkhoUeCp97YXbPk/xMHQFjYoYDeBs3X/gpfTxF7ifJt5kEq
         nrnn+kAEBrIQPtIWPuy72gGOZPUm9cXqeBwKHM0pGalhg5fVqsQ86Uk+bxg/SGMzQDs1
         N4xN8q0iU4znSvyqBZJAX2VBTU1i6PXbSvqjnmGDPIYGaDdxcSVInbUZ0xzlyympLvRr
         5nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050052; x=1697654852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uddVzm1ujX2AcdtbMSJ/3piIdX6QtZRUzkSKVd/RcdI=;
        b=c1frayUThT6iBDrMfV5atFhlpN2A0H4yxR0NTFSEfwWTz10XYnQFpfTaDyHTRZaaCq
         Vvgh0sEtEp5BBn03o2ePMAflbE/kokXTdVH23vuXxfRD9Cv2+hT5cXgVBINt2zjmPPts
         fEiAuT1kiFbns93c4sGxvRy7w9GzVRyd2EizezUqeRF85Xqgzt0fnXFSwoNqTrLagMjk
         ayCLsNqlyQBfYHYPPViq5Zxb7pp/PBlSyNwyuOxfQTHm3OVEOw/WPhqI4CAxW8pKYmzC
         ti9amqW5SxQowJ2eS9Kabm33RIh3kgqC5/rxjs/B3J2tgMTY0mriUPfwolrXelIIyYdn
         bhLA==
X-Gm-Message-State: AOJu0YxBzbJv0GIVp70bSHMioLXJ/74+rWJs7zdnSlo+/mABuMlgxSca
        Mm2S4c9uuK/390h4V3nBKEU=
X-Google-Smtp-Source: AGHT+IGedEIn5LqQ/lJhP/MbmS7A+KtQf7mY1T5hMEaAvNqidbngkhcIvBwLCTKFkO3XTLovh1x+bA==
X-Received: by 2002:a9d:7490:0:b0:6be:fd1c:c228 with SMTP id t16-20020a9d7490000000b006befd1cc228mr20834448otk.1.1697050051950;
        Wed, 11 Oct 2023 11:47:31 -0700 (PDT)
Received: from Osmten.. ([103.84.150.77])
        by smtp.gmail.com with ESMTPSA id d7-20020aa78147000000b0068c1ac1784csm10366171pfn.59.2023.10.11.11.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:47:31 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>,
        syzbot+39ba34a099ac2e9bd3cb@syzkaller.appspotmail.com
Subject: [PATCH] FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree
Date:   Wed, 11 Oct 2023 23:46:37 +0500
Message-Id: <20231011184637.20587-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported the following issue:

UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:2867:6
index 196694 is out of range for type 's8[1365]' (aka 'signed char[1365]')
CPU: 1 PID: 109 Comm: jfsCommit Not tainted 6.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 dbAdjTree+0x474/0x4f0 fs/jfs/jfs_dmap.c:2867
 dbJoin+0x210/0x2d0 fs/jfs/jfs_dmap.c:2834
 dbFreeBits+0x4eb/0xda0 fs/jfs/jfs_dmap.c:2331
 dbFreeDmap fs/jfs/jfs_dmap.c:2080 [inline]
 dbFree+0x343/0x650 fs/jfs/jfs_dmap.c:402
 txFreeMap+0x798/0xd50 fs/jfs/jfs_txnmgr.c:2534
 txUpdateMap+0x342/0x9e0
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x47a/0xb70 fs/jfs/jfs_txnmgr.c:2732
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
================================================================================
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 1 PID: 109 Comm: jfsCommit Not tainted 6.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 panic+0x30f/0x770 kernel/panic.c:340
 check_panic_on_warn+0x82/0xa0 kernel/panic.c:236
 ubsan_epilogue lib/ubsan.c:223 [inline]
 __ubsan_handle_out_of_bounds+0x13c/0x150 lib/ubsan.c:348
 dbAdjTree+0x474/0x4f0 fs/jfs/jfs_dmap.c:2867
 dbJoin+0x210/0x2d0 fs/jfs/jfs_dmap.c:2834
 dbFreeBits+0x4eb/0xda0 fs/jfs/jfs_dmap.c:2331
 dbFreeDmap fs/jfs/jfs_dmap.c:2080 [inline]
 dbFree+0x343/0x650 fs/jfs/jfs_dmap.c:402
 txFreeMap+0x798/0xd50 fs/jfs/jfs_txnmgr.c:2534
 txUpdateMap+0x342/0x9e0
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x47a/0xb70 fs/jfs/jfs_txnmgr.c:2732
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..

The issue is caused when the value of lp becomes greater than
CTLTREESIZE which is the max size of stree. Adding a simple check
solves this issue. I was not sure about error return as a function
does not return. If there is something needed in that regard please
do point out.

The patch is tested via syzbot.

Reported-by: syzbot+39ba34a099ac2e9bd3cb@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=39ba34a099ac2e9bd3cb
Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 fs/jfs/jfs_dmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a3eb1e826947..decb3be66a86 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2854,6 +2854,9 @@ static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
 	/* is the current value the same as the old value ?  if so,
 	 * there is nothing to do.
 	 */
+	if (lp >= CTLTREESIZE)
+		return;
+
 	if (tp->dmt_stree[lp] == newval)
 		return;
 
-- 
2.34.1

