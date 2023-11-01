Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3707DE73E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343947AbjKAVKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjKAVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:10:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01278BD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:10:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DD5C433C8;
        Wed,  1 Nov 2023 21:10:02 +0000 (UTC)
Date:   Wed, 1 Nov 2023 17:10:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>,
        Colin Ian King <colin.i.king@gmail.com>
Subject: [GIT PULL] tracing tools: Updates for v6.7
Message-ID: <20231101171001.165c13f0@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing tools changes for 6.7:

RTLA:
  - On rtla/utils.c, initialize the 'found' variable to avoid garbage
    when a mount point is not found.

Verification:
  - Remove duplicated imports on dot2k python script


Please pull the latest trace-tools-v6.7 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tools-v6.7

Tag SHA1: 59e04010c596e539f1450bb03e2acfbaf8dd5f81
Head SHA1: 696444a544ecd6d62c1edc89516b376cefb28929


Alessandro Carminati (Red Hat) (1):
      verification/dot2k: Delete duplicate imports

Colin Ian King (1):
      rtla: Fix uninitialized variable found

----
 tools/tracing/rtla/src/utils.c | 2 +-
 tools/verification/dot2/dot2k  | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)
---------------------------
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 623a38908ed5..c769d7b3842c 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -538,7 +538,7 @@ static const int find_mount(const char *fs, char *mp, int sizeof_mp)
 {
 	char mount_point[MAX_PATH];
 	char type[100];
-	int found;
+	int found = 0;
 	FILE *fp;
 
 	fp = fopen("/proc/mounts", "r");
diff --git a/tools/verification/dot2/dot2k b/tools/verification/dot2/dot2k
index 9dcd38abe20a..d4d7e52d549e 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/dot2/dot2k
@@ -15,8 +15,6 @@ if __name__ == '__main__':
     import os
     import platform
     import sys
-    import sys
-    import argparse
 
     parser = argparse.ArgumentParser(description='transform .dot file into kernel rv monitor')
     parser.add_argument('-d', "--dot", dest="dot_file", required=True)
