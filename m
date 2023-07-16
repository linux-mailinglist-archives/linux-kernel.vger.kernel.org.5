Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7840B7550B1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 20:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjGPStW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGPStV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 14:49:21 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE5A1B5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 11:49:18 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id L6nlqoZFfmJSQL6nyqovEY; Sun, 16 Jul 2023 20:49:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689533355;
        bh=oXFfPn5WpEoNL6C6p4wE0Mawt3VwLpg29Dnt35c5y/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QwyYyRyRYJX9aBDwtDMwdqMBNfWwiY2IqxhldV2xxLfH3nywHnxtaUPSNYKA6SF6o
         fQ4LAe9FVV5xXc/LpybW0+mu0ZWAba9ublz9vHPmaQLiUNfLNVPJ/+4N3NdnxzrHGB
         MtkhexTxfkdM/9X4l/GzjKbLEo0ZNSyhYnxLmmT8+NsNuYKBfN9b3eLTr6fyYSmdRM
         SDdc26oqLsUcTNKg/agP1MLmzkHgLSdTs9jH4gcguRJNYfyQhLJ4an119CKvvWBVCC
         DwNIG8ZugG3uZdM355bmiruAr0Dw+zMPnnfpg+iG10pvu02bepEmZkA2NNtmpn/zi6
         6Hhu9p5Uw5Yow==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Jul 2023 20:49:15 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ocfs2-devel@lists.linux.dev
Subject: [PATCH 2/2] ocfs2: Use struct_size()
Date:   Sun, 16 Jul 2023 20:48:57 +0200
Message-Id: <9d99ea2090739f816d0dc0c4ebaa42b26fc48a9e.1689533270.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c645911ffd2720fce5e344c17de642518cd0db52.1689533270.git.christophe.jaillet@wanadoo.fr>
References: <c645911ffd2720fce5e344c17de642518cd0db52.1689533270.git.christophe.jaillet@wanadoo.fr>
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

Use struct_size() instead of hand-writing it, when allocating a structure
with a flex array.

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
It will also be helpful if the __counted_by() annotation is added with a
Coccinelle script such as:
   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=devel/counted_by&id=adc5b3cb48a049563dc673f348eab7b6beba8a9b
---
 fs/ocfs2/journal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 2f7e70109020..4e779efe2a4e 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -114,9 +114,9 @@ int ocfs2_compute_replay_slots(struct ocfs2_super *osb)
 	if (osb->replay_map)
 		return 0;
 
-	replay_map = kzalloc(sizeof(struct ocfs2_replay_map) +
-			     (osb->max_slots * sizeof(char)), GFP_KERNEL);
-
+	replay_map = kzalloc(struct_size(replay_map, rm_replay_slots,
+					 osb->max_slots),
+			     GFP_KERNEL);
 	if (!replay_map) {
 		mlog_errno(-ENOMEM);
 		return -ENOMEM;
-- 
2.34.1

