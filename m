Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685ED7BCD05
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 09:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbjJHHYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 03:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJHHYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 03:24:52 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9B5F6B9;
        Sun,  8 Oct 2023 00:24:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 4F7A9604A87F9;
        Sun,  8 Oct 2023 15:24:35 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     ccaulfie@redhat.com, teigland@redhat.com
Cc:     Su Hui <suhui@nfschina.com>, gfs2@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] fs: dlm: silence truncated string warning
Date:   Sun,  8 Oct 2023 15:24:24 +0800
Message-Id: <20231008072423.556591-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using gcc and W=1 option, there are some warning like these:

fs/dlm/debug_fs.c: In function ‘dlm_create_debug_file’:
fs/dlm/debug_fs.c:1020:51: error: ‘snprintf’ output may be truncated before
the last format character [-Werror=format-truncation=]
 1020 |  snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls->ls_name);
      |                                                   ^
fs/dlm/debug_fs.c:1020:2: note: 'snprintf' output between 9 and 73 bytes
into a destination of size 72
 1020 |  snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls->ls_name);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/dlm/debug_fs.c:1031:43: error: '_queued_asts' directive output may be
truncated writing 12 bytes into a region of size between 8 and 72
[-Werror=format-truncation=]
 1031 |  snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts",
		  ls->ls_name);
      |                                           ^~~~~~~~~~~~

The length of 'ls->ls_name' is 'DLM_LOCKSPACE_LEN + 1'. So string
"%s_waiters" can up to 'DLM_LOCKSPACE_LEN + 9' and string
"%s_queued_asts" can up to 'DLM_LOCKSPACE_LEN + 13'.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 fs/dlm/debug_fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 5aabcb6f0f15..d0b34b9fbdaf 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -973,7 +973,7 @@ void dlm_delete_debug_comms_file(void *ctx)
 
 void dlm_create_debug_file(struct dlm_ls *ls)
 {
-	char name[DLM_LOCKSPACE_LEN + 8];
+	char name[DLM_LOCKSPACE_LEN + 13];
 
 	/* format 1 */
 
@@ -1017,7 +1017,7 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 						       &format4_fops);
 
 	memset(name, 0, sizeof(name));
-	snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls->ls_name);
+	snprintf(name, DLM_LOCKSPACE_LEN + 9, "%s_waiters", ls->ls_name);
 
 	ls->ls_debug_waiters_dentry = debugfs_create_file(name,
 							  0644,
@@ -1028,7 +1028,7 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 	/* format 5 */
 
 	memset(name, 0, sizeof(name));
-	snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts", ls->ls_name);
+	snprintf(name, DLM_LOCKSPACE_LEN + 13, "%s_queued_asts", ls->ls_name);
 
 	ls->ls_debug_queued_asts_dentry = debugfs_create_file(name,
 							      0644,
-- 
2.30.2

