Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9410A7DC00D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjJ3SoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjJ3SoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:44:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86706C6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:44:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438AFC433C7;
        Mon, 30 Oct 2023 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698691449;
        bh=+7zhfHPyLzZwQQCV6hLW1IUskEnhha0OZ7HOdtRJlEw=;
        h=From:To:Cc:Subject:Date:From;
        b=qUX3M2Y62hDjwRfvptl4QHx+7+qPiybQHnaVZOd5ExmgUX4KKkGH7WyP3jQ3JTQ82
         WiDn4k+cFjcIXM8x734Vlqy0IuOFTcLgtGIvqNMo/FR83vtYUOgPGGGFsnbaNHXW/a
         zyOUmq7x/J5TGMinlhXlD8F342QUmqy8hnpRjS5Ju0IH1pSVMbV3BSYXUKU9vVcsNv
         VviRBumEr0oVMe/wWnmMqG3iUzSM0Aj2RFRStlWA9LHV9KhCu4WP+K2JqVMQCbPqWE
         MW8PZwStO9Taxho1wDRMxWyEUk28R1FCUiV1paHku5mMPSpMQztIjqILc/HCqbR9gI
         dfzBlj5v8WCuw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alessandro Carminati <alessandro.carminati@gmail.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [GIT PULL] tracing/tools: Updates for 6.7
Date:   Mon, 30 Oct 2023 19:44:00 +0100
Message-ID: <20231030184400.22645-1-bristot@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven,

Tracing tools changes for 6.7:

RTLA:
  - On rtla/utils.c, initialize the 'found' variable to avoid garbage
    when a mount point is not found.

Verification:
  - Remove duplicated imports on dot2k python script


Please pull the latest tracing-tools-v6.7 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git
tracing-tools-v6.7

Tag SHA1: eadb7e76bc7ce4174d4905a29a4a07cd835508fe
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
