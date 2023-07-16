Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB5D7550B2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 20:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjGPStY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 14:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGPStV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 14:49:21 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFA31B7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 11:49:18 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id L6nlqoZFfmJSQL6nmqovE2; Sun, 16 Jul 2023 20:49:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689533346;
        bh=dRGXf+8+arzdqmH6oSLRzr2Fhx/BMcRgYEg7UM8rSZs=;
        h=From:To:Cc:Subject:Date;
        b=GD1eJW8vGIAYcERLMhvYqucDWu3L7whDYw+L779/LUftZDaKx7xCMEPxf+2rjlS1d
         qfKh5VF7YJYytQIZG50ePkaXq1MDVoA7lcNHHZuHvUU0iJGjkbsnDlyMBn2aKTocIL
         aYmrV/Kaa6NtIxF8uMvwwOAzy+YxYLEn6S1Hzi/QzGBCqlEYOkuka0BGm1gvCCLF6L
         l0lGdK+5TzTWmzdZDM8SB+ORlQhf6dMnuwf+FN/u/dF2kNFUkxWnJfgSCY/O2gLko0
         xTzJ3r7arfPb6etGCxm3PkrxO9DD7zSmRQGan4cNDTM/8lC8A+bcL2OKnPDFJuGvbx
         aerJgaNL7UH3A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Jul 2023 20:49:06 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ocfs2-devel@lists.linux.dev
Subject: [PATCH 1/2] ocfs2: Use flexible array in 'struct ocfs2_recovery_map'
Date:   Sun, 16 Jul 2023 20:48:56 +0200
Message-Id: <c645911ffd2720fce5e344c17de642518cd0db52.1689533270.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn 'rm_entries' in 'struct ocfs2_recovery_map' into a flexible array.

The advantages are:
   - save the size of a pointer when the new undo structure is allocated
   - avoid some always ugly pointer arithmetic to get the address of
    'rm_entries'
   - avoid an indirection when the array is accessed

While at it, use struct_size() to compute the size of the new undo
structure.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/ocfs2/journal.c | 5 +----
 fs/ocfs2/journal.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 25d8072ccfce..2f7e70109020 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -178,16 +178,13 @@ int ocfs2_recovery_init(struct ocfs2_super *osb)
 	osb->recovery_thread_task = NULL;
 	init_waitqueue_head(&osb->recovery_event);
 
-	rm = kzalloc(sizeof(struct ocfs2_recovery_map) +
-		     osb->max_slots * sizeof(unsigned int),
+	rm = kzalloc(struct_size(rm, rm_entries, osb->max_slots),
 		     GFP_KERNEL);
 	if (!rm) {
 		mlog_errno(-ENOMEM);
 		return -ENOMEM;
 	}
 
-	rm->rm_entries = (unsigned int *)((char *)rm +
-					  sizeof(struct ocfs2_recovery_map));
 	osb->recovery_map = rm;
 
 	return 0;
diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
index 41c382f68529..41c9fe7e62f9 100644
--- a/fs/ocfs2/journal.h
+++ b/fs/ocfs2/journal.h
@@ -29,7 +29,7 @@ struct ocfs2_dinode;
 
 struct ocfs2_recovery_map {
 	unsigned int rm_used;
-	unsigned int *rm_entries;
+	unsigned int rm_entries[];
 };
 
 
-- 
2.34.1

