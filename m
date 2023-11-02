Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A891C7DE9F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 02:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348017AbjKBBXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 21:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjKBBXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 21:23:04 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA26D83
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 18:23:00 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3A21MIDF005064;
        Thu, 2 Nov 2023 09:22:18 +0800 (+08)
        (envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SLQwJ48L0z2LC54f;
        Thu,  2 Nov 2023 09:17:36 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 2 Nov 2023 09:22:16 +0800
From:   Zhiguo Niu <zhiguo.niu@unisoc.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <zhiguo.niu@unisoc.com>
Subject: [PATCH] f2fs: fix thread name cannot be fully displayed
Date:   Thu, 2 Nov 2023 09:20:42 +0800
Message-ID: <1698888042-17199-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.73.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 3A21MIDF005064
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the length of task'name in task_struct can not exceed
16 characters, f2fs some thread'name cannot be fully displayed,
including important device number information.
If there are more than one partition using the f2fs file system,
it is very inconvenient to match partitions and their threads.

The following examples show that 4 partitions all use f2fs file system
PID: 400    TASK: ffffff80f120c9c0  CPU: 2   COMMAND: "f2fs_discard-25"
PID: 392    TASK: ffffff80f6b75880  CPU: 3   COMMAND: "f2fs_discard-25"
PID: 400    TASK: ffffff80f120c9c0  CPU: 2   COMMAND: "f2fs_discard-25"
PID: 392    TASK: ffffff80f6b75880  CPU: 3   COMMAND: "f2fs_discard-25"
PID: 510    TASK: ffffff80dd62c9c0  CPU: 0   COMMAND: "f2fs_ckpt-254:4"
PID: 255    TASK: ffffff80f2268000  CPU: 3   COMMAND: "f2fs_ckpt-259:4"
PID: 398    TASK: ffffff80f120ac40  CPU: 2   COMMAND: "f2fs_ckpt-259:4"
PID: 390    TASK: ffffff80f6b76740  CPU: 3   COMMAND: "f2fs_ckpt-259:4"
PID: 511    TASK: ffffff80dd629d80  CPU: 3   COMMAND: "f2fs_flush-254:"
PID: 399    TASK: ffffff80f120bb00  CPU: 2   COMMAND: "f2fs_flush-259:"
PID: 391    TASK: ffffff80f6b70000  CPU: 3   COMMAND: "f2fs_flush-259:"
PID: 256    TASK: ffffff80f226d880  CPU: 6   COMMAND: "f2fs_flush-259:"

We can use the name format such as f2fs_gc-xxx, as saw in device:
PID: 260    TASK: ffffff80f8c2e740  CPU: 3   COMMAND: "f2fs_gc-259:44"
PID: 420    TASK: ffffff80f6505880  CPU: 2   COMMAND: "f2fs_gc-259:41"
PID: 393    TASK: ffffff80f6b72c40  CPU: 1   COMMAND: "f2fs_gc-259:40
PID: 513    TASK: ffffff80dd62e740  CPU: 1   COMMAND: "f2fs_gc-254:40"

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/checkpoint.c | 2 +-
 fs/f2fs/segment.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b0597a5..f6a5424 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1893,7 +1893,7 @@ int f2fs_start_ckpt_thread(struct f2fs_sb_info *sbi)
 		return 0;
 
 	cprc->f2fs_issue_ckpt = kthread_run(issue_checkpoint_thread, sbi,
-			"f2fs_ckpt-%u:%u", MAJOR(dev), MINOR(dev));
+			"f2fs_cp-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(cprc->f2fs_issue_ckpt)) {
 		int err = PTR_ERR(cprc->f2fs_issue_ckpt);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d05b416..b290713 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -677,7 +677,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
 
 init_thread:
 	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
-				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
+				"f2fs_fh-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(fcc->f2fs_issue_flush)) {
 		int err = PTR_ERR(fcc->f2fs_issue_flush);
 
@@ -2248,7 +2248,7 @@ int f2fs_start_discard_thread(struct f2fs_sb_info *sbi)
 		return 0;
 
 	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
-				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
+				"f2fs_dc-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(dcc->f2fs_issue_discard)) {
 		err = PTR_ERR(dcc->f2fs_issue_discard);
 		dcc->f2fs_issue_discard = NULL;
-- 
1.9.1

