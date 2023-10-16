Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0C27CB72A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjJPXtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjJPXtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:49:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2292092
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:49:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5A4C433C8;
        Mon, 16 Oct 2023 23:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697500189;
        bh=ECcUrZRXKH1RGkNt+ZfqdBaP7v9kjaK8IQAhOGMboxU=;
        h=From:To:Cc:Subject:Date:From;
        b=JnkkJzN8aGirKUq5BDpIZSLbzMPHB8QZwfVNWJQpEjGbCfUBWUGKvjgAK3zz3krmm
         29cZmHNz0RE4ormDoAPD2Ka2A4b3A+AHxhyJnK/iZwT6ej/7tTz1TC0xBv3/Z04/OX
         KBsuAAit69ALEcmK3W4Q1MlzqpkBUAlngCmNu7ydTmdJ+9ABhXnYT4YJQMVUwSWRbs
         kUddGaGB3F6WbCCzhmCkRNRg5dlnQOWeTMW+95g6FaEORBj5IHLwV4NMDsVIO0cW0W
         +TRQdikZ5YxESdA7DXMhc33Xbr2mAHuPhMPtLi2ppamMifJFanNacoBvlMlgv+4Aa0
         2wklKTMweIGbg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "wuqiang . matt" <wuqiang.matt@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org
Subject: [PATCH] fprobe: Fix to ensure the number of active retprobes is not zero
Date:   Tue, 17 Oct 2023 08:49:45 +0900
Message-Id: <169750018550.186853.11198884812017796410.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

The number of active retprobes can be zero but it is not acceptable,
so return EINVAL error if detected.

Reported-by: wuqiang.matt <wuqiang.matt@bytedance.com>
Closes: https://lore.kernel.org/all/20231016222103.cb9f426edc60220eabd8aa6a@kernel.org/
Fixes: 5b0ab78998e3 ("fprobe: Add exit_handler support")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 3b21f4063258..881f90f0cbcf 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -189,7 +189,7 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 {
 	int i, size;
 
-	if (num < 0)
+	if (num <= 0)
 		return -EINVAL;
 
 	if (!fp->exit_handler) {
@@ -202,8 +202,8 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 		size = fp->nr_maxactive;
 	else
 		size = num * num_possible_cpus() * 2;
-	if (size < 0)
-		return -E2BIG;
+	if (size <= 0)
+		return -EINVAL;
 
 	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler);
 	if (!fp->rethook)

