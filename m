Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAFC7AB77C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjIVRcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjIVRcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:32:02 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC7FB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:31:22 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id jjzlq1mvsWkeLjjztquw11; Fri, 22 Sep 2023 19:31:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695403881;
        bh=6Mdh92zSNjb03Q7lpVvrUXLMKkbkfsGWVKmrcZV58LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AZd/C7jzdQa8ngS7YatO0pIUnC9sf4kMD7wM3+F9BD1uFMFkcWVNsYh0f1LIt9D4Z
         joUYrPlswQyOQV56ZVyVwIERfHNwU4fUfhCWHUl1I4/edi36ISh9wFUgkJ0GtrLyBp
         3FDS/eM5ItGXeXr8HMPwL62+CNLbog2c6azapzDX0SmDSl8PX+M7BGGN65X+IKEP5o
         gVQXSRuscfpeSnZBt0m7/rXpUGJpnqcwNF/bmlY0sbfTPWvOWj7+UFT5J57uyOUUcP
         I29cFGtpQWeE+fED1ZTviktVnCGi/ibU1bM3OU9NSl7dzla5FS0LcPWLh7ntXpA+4t
         hzxGrCDr3kPzw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 22 Sep 2023 19:31:21 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Alexander Aring <aahringo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        gfs2@lists.linux.dev
Subject: [PATCH 2/3] fs: dlm: Fix the size of a buffer in dlm_create_debug_file()
Date:   Fri, 22 Sep 2023 19:31:09 +0200
Message-Id: <6083c5d6e7e4eb567bf6f5cbb5bdf6b0286cee45.1695403360.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695403360.git.christophe.jaillet@wanadoo.fr>
References: <cover.1695403360.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8 is not the maximum size of the suffix used when creating debugfs files.

Let the compiler compute the correct size, and only give a hint about the
longest possible string that is used.

When building with W=1, this fixes the following warnings:

  fs/dlm/debug_fs.c: In function ‘dlm_create_debug_file’:
  fs/dlm/debug_fs.c:1020:58: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
   1020 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls->ls_name);
        |                                                          ^
  fs/dlm/debug_fs.c:1020:9: note: ‘snprintf’ output between 9 and 73 bytes into a destination of size 72
   1020 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls->ls_name);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  fs/dlm/debug_fs.c:1031:50: error: ‘_queued_asts’ directive output may be truncated writing 12 bytes into a region of size between 8 and 72 [-Werror=format-truncation=]
   1031 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts", ls->ls_name);
        |                                                  ^~~~~~~~~~~~
  fs/dlm/debug_fs.c:1031:9: note: ‘snprintf’ output between 13 and 77 bytes into a destination of size 72
   1031 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts", ls->ls_name);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 541adb0d4d10b ("fs: dlm: debugfs for queued callbacks")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/dlm/debug_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index e9726c6cbdf2..c93359ceaae6 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -973,7 +973,8 @@ void dlm_delete_debug_comms_file(void *ctx)
 
 void dlm_create_debug_file(struct dlm_ls *ls)
 {
-	char name[DLM_LOCKSPACE_LEN + 8];
+	/* Reserve enough space for the longest file name */
+	char name[DLM_LOCKSPACE_LEN + sizeof("_queued_asts")];
 
 	/* format 1 */
 
-- 
2.34.1

