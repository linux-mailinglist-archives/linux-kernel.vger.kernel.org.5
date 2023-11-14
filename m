Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EF07EABE4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjKNIqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjKNIps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:45:48 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B944C1AD;
        Tue, 14 Nov 2023 00:45:44 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5afabb23900so63206207b3.2;
        Tue, 14 Nov 2023 00:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951544; x=1700556344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfUrH6hwPhZlZJRuY17GMzM0HULluXlF2QevGochjOA=;
        b=BkxdwsQwRcYbShhOtRv0AxGFEAHK4dW7zEmWACZ75xWSPdHR4GEhACvQiK4MU9arNo
         JkJaXKRT8LhNhJEbonborEGDP0QFQi4FAXpDzmv+e5gCWdP4FfslfzA4aJy7PAfl74eW
         TedLMqKpIYvzavYi04EUZ4g+Huql3o/w+AUp1CRpr+xeZ+1ubUmVH9z3qNLVNeJsctXv
         T5EhTPVNjMinAZkZMOveG0q6wYZXXZw2ejvPuy4crk+MSlTDne3Et/3jo2H1GGm4IbiQ
         M3EstK1s+8sH56gV/f6nHa1xy3Bz2aqVuZLXNn1kYPdHSgqA7u2Iu/pgrCyBsYk5Bc7O
         lTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951544; x=1700556344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfUrH6hwPhZlZJRuY17GMzM0HULluXlF2QevGochjOA=;
        b=jFGiXXbFcLs4qpBRkXP5v/ME29g/Ts66fdB0w+a/JxIxWq45x34lYGTer78e++CjuV
         LG4eFEa7awNyU+z6N0IzeDpRpAd7SUSOpl1TvZDY9E2I42MMuXdo3ZZizhT2778PuK1n
         bESjENvumHx+WCUWQS1eHRUu+gAzEw4GPUAZ78G3n/XXhlnwkL2QoeXDdBZearp4WZNO
         jZS9JkvBlMmhZaCvzpycHx961/LE9miuo0k8q3vc7o+3mV3MpC2pd5LFH7neAVzZw8iO
         ED2x+JoKMb1kEC2RIISR0xJcM1v1LJRRoBnF6O788QMz+h1q0Q+SX3SyNLdzGt5C9UMr
         yF2A==
X-Gm-Message-State: AOJu0YxRhXzH7M8klpuvtqHuz7axpBh0ydCGMlHArlE7pKmSLhA4qOZI
        J94PgryMztji944QM9MHY4BQ9TeC834=
X-Google-Smtp-Source: AGHT+IFtmWAl2hZPAZcX1Xxc2BBoPSRS9y/tiodLVYJIosUNNSJX3IBdRRxJ/W0q9/0nTfh+J71e6w==
X-Received: by 2002:a81:528d:0:b0:59f:b0d9:5df2 with SMTP id g135-20020a81528d000000b0059fb0d95df2mr9635510ywb.0.1699951543778;
        Tue, 14 Nov 2023 00:45:43 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:43 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/20] nilfs2: Convert nilfs_writepage() to use a folio
Date:   Tue, 14 Nov 2023 17:44:22 +0900
Message-Id: <20231114084436.2755-7-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114084436.2755-1-konishi.ryusuke@gmail.com>
References: <20231114084436.2755-1-konishi.ryusuke@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Convert the incoming page to a folio.  Replaces three calls to
compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index f861f3a0bf5c..c7ec56358a79 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -175,7 +175,8 @@ static int nilfs_writepages(struct address_space *mapping,
 
 static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
 {
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio->mapping->host;
 	int err;
 
 	if (sb_rdonly(inode->i_sb)) {
@@ -186,12 +187,12 @@ static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
 		 * So, here we simply discard this dirty page.
 		 */
 		nilfs_clear_dirty_page(page, false);
-		unlock_page(page);
+		folio_unlock(folio);
 		return -EROFS;
 	}
 
-	redirty_page_for_writepage(wbc, page);
-	unlock_page(page);
+	folio_redirty_for_writepage(wbc, folio);
+	folio_unlock(folio);
 
 	if (wbc->sync_mode == WB_SYNC_ALL) {
 		err = nilfs_construct_segment(inode->i_sb);
-- 
2.34.1

