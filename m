Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F89E7AB77D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjIVRcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjIVRcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:32:02 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F360394
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:31:23 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id jjzlq1mvsWkeLjjzuquw1D; Fri, 22 Sep 2023 19:31:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695403882;
        bh=V2TWwOebnSbbI2cNxOy+6tSiLTe5TgHaacu+uy4XtWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TX6zHgc928K0ZEdheeOI3LHvylT2Zk+3802M3kwf7zwKf6/tNyJV2hrS0t2QDL6zm
         y17PxnNEsUNJtz3rB4eIs7+J97GsfmCA5+4lBwF2d1XL7JZbnoVE985mg3NYAV3t+/
         9fGYZmwB3YwvOiUCg5Kb92t+mxWukCCCsdjVOYTFaGW2kf1SREFy6d3ijUqqWHXqrO
         fkdgUd3NCgOn25vktljueaiheiiN3VPmdctVP4ZnkyEo1uD/d3ouUbWfKkKBEoi/iK
         7V/JJcmQnD/sTem8fmoMZoRPACWoB/qCD1N2bdsXQ3rj76jI5VJh3Hczk85olXLvOa
         1mAMhDtGfhbdg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 22 Sep 2023 19:31:22 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        gfs2@lists.linux.dev
Subject: [PATCH 3/3] fs: dlm: Remove some useless memset()
Date:   Fri, 22 Sep 2023 19:31:10 +0200
Message-Id: <e2ce90b1297db6c336b7234e744759510c6ed96e.1695403360.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695403360.git.christophe.jaillet@wanadoo.fr>
References: <cover.1695403360.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to clear the buffer used to build the file name.

snprintf() already guarantees that it is NULL terminated and such a
(useless) precaution was not done for the first string (i.e
ls_debug_rsb_dentry)

So, save a few LoC.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/dlm/debug_fs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index c93359ceaae6..42f332f46359 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -986,7 +986,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 
 	/* format 2 */
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_locks", ls->ls_name);
 
 	ls->ls_debug_locks_dentry = debugfs_create_file(name,
@@ -997,7 +996,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 
 	/* format 3 */
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_all", ls->ls_name);
 
 	ls->ls_debug_all_dentry = debugfs_create_file(name,
@@ -1008,7 +1006,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 
 	/* format 4 */
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_toss", ls->ls_name);
 
 	ls->ls_debug_toss_dentry = debugfs_create_file(name,
@@ -1017,7 +1014,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 						       ls,
 						       &format4_fops);
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_waiters", ls->ls_name);
 
 	ls->ls_debug_waiters_dentry = debugfs_create_file(name,
@@ -1028,7 +1024,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 
 	/* format 5 */
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_queued_asts", ls->ls_name);
 
 	ls->ls_debug_queued_asts_dentry = debugfs_create_file(name,
-- 
2.34.1

