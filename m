Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08577FA2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbjK0Oc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjK0ObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:31:21 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08077191;
        Mon, 27 Nov 2023 06:31:17 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfa5840db3so23169205ad.2;
        Mon, 27 Nov 2023 06:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095476; x=1701700276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UePQJ8QOPzkPSmphS7Y8EH5bntY87+qPN2cJVMHHYV8=;
        b=Q1VImZ3Z0PfW3BSdro6+l02BZpM3g3Sj2yvSRbjUlBrQUjQ9eWSZgRvNjX0HSD/a8p
         /w8GM0QFzI0LMPWMng8NNwfX+VS46CgN484hrfZjDE7cxiwnfkJK0hZm5pLbIPqdI0LG
         AuU/O8vly+gUiGceNCrbKXSv/LEngfljXCjo9BTfgDubm9AT5YIbyYUnowjL6R+1666b
         aqvj4PLdnem2ESft+m2lQKCcLL3CLL3xyGCU/HFcVoB4Z7tQZmaWsX7U8zkIMpmtyfBy
         KUEDqZt9nb/9xtgdGeCttc0SlbsU2k4MTbIgN5Sru3LNWtqNffy3bp2zboPtWzenQCNd
         VwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095476; x=1701700276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UePQJ8QOPzkPSmphS7Y8EH5bntY87+qPN2cJVMHHYV8=;
        b=OghfEdhRUL7QCSBgoUSt6k/2eQ3MG3x5t9QIlqq/FHnIGss22I23HQnZsqbKir/y4r
         Nm0v/msonJKpIqBaezvuxlZ44Ml238Oev1Lfe/KFd7+7NNZceLiBusfT8el07t8dGGSY
         ldCjh7B7SEBlwWSegv8+gAfOuCpejE2pTRfMzbm8NjNmPy2iWGFJPvq1XLVe9084n6TF
         0G8j5o6+LGyPyw6L/0+xB2maW153RNv+oc9xFo2/X7UXqsf3zdbgA24ajsq/DhrbM2vw
         ipvAq4Y+XBIYyR83U03SJxr1tWbU4fJ9My0ds81rCPiaHZktpqddqB5qskJfT8ccIsFW
         h0ww==
X-Gm-Message-State: AOJu0YxgfBEtf238AM8ovYYkbMvVPMQWKBLGUqe3ucXhB4PB7M0yXYZL
        ivQts4A2uyXhsWrORweFXfv9tltHxKY=
X-Google-Smtp-Source: AGHT+IG1oBcIbGFxOiv8HFXh2KXYeqUMLpETj8DkwwqAzEdYp0e8p+/K4INzAIOXJXChKJ28IWBbAg==
X-Received: by 2002:a17:902:724a:b0:1cf:d2c3:2865 with SMTP id c10-20020a170902724a00b001cfd2c32865mr2634338pll.40.1701095476436;
        Mon, 27 Nov 2023 06:31:16 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf51972586sm8302784pld.292.2023.11.27.06.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:31:15 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] nilfs2: Convert nilfs_find_entry to use a folio
Date:   Mon, 27 Nov 2023 23:30:30 +0900
Message-Id: <20231127143036.2425-12-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
References: <20231127143036.2425-1-konishi.ryusuke@gmail.com>
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

Use the new folio APIs to remove calls to compound_head().

[ konishi.ryusuke: resolved a conflict due to style warning correction ]

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/dir.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index c7b046589877..a79726182867 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -339,7 +339,7 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 	unsigned int reclen = NILFS_DIR_REC_LEN(namelen);
 	unsigned long start, n;
 	unsigned long npages = dir_pages(dir);
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct nilfs_inode_info *ei = NILFS_I(dir);
 	struct nilfs_dir_entry *de;
 
@@ -354,7 +354,7 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 		start = 0;
 	n = start;
 	do {
-		char *kaddr = nilfs_get_page(dir, n, &page);
+		char *kaddr = nilfs_get_folio(dir, n, &folio);
 
 		if (!IS_ERR(kaddr)) {
 			de = (struct nilfs_dir_entry *)kaddr;
@@ -363,18 +363,18 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 				if (de->rec_len == 0) {
 					nilfs_error(dir->i_sb,
 						"zero-length directory entry");
-					unmap_and_put_page(page, kaddr);
+					folio_release_kmap(folio, kaddr);
 					goto out;
 				}
 				if (nilfs_match(namelen, name, de))
 					goto found;
 				de = nilfs_next_entry(de);
 			}
-			unmap_and_put_page(page, kaddr);
+			folio_release_kmap(folio, kaddr);
 		}
 		if (++n >= npages)
 			n = 0;
-		/* next page is past the blocks we've got */
+		/* next folio is past the blocks we've got */
 		if (unlikely(n > (dir->i_blocks >> (PAGE_SHIFT - 9)))) {
 			nilfs_error(dir->i_sb,
 			       "dir %lu size %lld exceeds block count %llu",
@@ -387,7 +387,7 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 	return NULL;
 
 found:
-	*res_page = page;
+	*res_page = &folio->page;
 	ei->i_dir_start_lookup = n;
 	return de;
 }
-- 
2.34.1

