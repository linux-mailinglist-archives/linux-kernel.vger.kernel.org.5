Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4067FA2D7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjK0Ocs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjK0Ob0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:31:26 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F53D41;
        Mon, 27 Nov 2023 06:31:32 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cfaaa79766so21655055ad.3;
        Mon, 27 Nov 2023 06:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095492; x=1701700292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzhEI8PX9uWduVePnYqK/AxUKd745WWyGgZ0XvSFp+U=;
        b=ji9j8nAxQqzvOX147sKXHx8lju59AiZvFm2DRBZy5RZt+0E3kSqwVWewBIRsgq8ZMT
         kiTG+8c7oKmYUlCsjSgLp3wuAgmCwW0XYnrR/oH/XDE6IkKhtBB9HiE+KEn8jAyqBa8M
         4I4uYsLhWln4bLTz7GSXZhWJ1oAmAwBNv5Pcl5rdL/NVGVZfaYYCOQlCrjeC2AwfYxWG
         mopkjg0D/30Rs+9TLz76fa4ny+3tta/NPKSS6uZv+yUTlzszvD68M2Tlg/JgKheBfj8c
         enEt0gGRUfLMQnHwqDonU2W2337qnpng2obHbzej3vZ/h9vTcUMzQODk8lBSJ3W/Sz5T
         vD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095492; x=1701700292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzhEI8PX9uWduVePnYqK/AxUKd745WWyGgZ0XvSFp+U=;
        b=RQjQcbVayqGyAjrHsdM5phnE5j+cs4g6rdkJn7sfoqZ+Oxp1Kc4ATBRQlfpj/Vf4zi
         vK00Q5TekXL9F2qTEzNcFDngvYOoDVZmkMlkJnXCG/ge6fTEc6OZVkMUa+6OFzVAB13Y
         yYE1HGHPkdyo58gPWRStpoj0MLEfkbbt+ZBnQubvTMmppQCeWaGxDX2tRCD45F+2Ez27
         FDi976WAdo4P+Q1ub4yjgNeqER7iHQGhLnq9uZsxoBZgFJy1LlNXKTiyxhM26MnBCDDq
         bZbAWK1US8duVNX1+E3T5g97WgE4AwR3rknBg1nhkAdqinE4w+1/pM1uhZ/Mrakz9M1s
         HrlA==
X-Gm-Message-State: AOJu0YxVZ1SqzNolxGkToyrEttziZaeq2YM1U5FN3tbC8NVCeTEe0N06
        jAskTaDxA2iTfaYV+F0hgMU=
X-Google-Smtp-Source: AGHT+IFSnoQkHprY5znYQP1Yyq2eAnrGNVx2gV7UFL5mKqSq8bKNzLTdIL+Y3iv/zkWHLVYX8l1KgQ==
X-Received: by 2002:a17:902:ced0:b0:1cc:ae1a:b0b8 with SMTP id d16-20020a170902ced000b001ccae1ab0b8mr15658483plg.44.1701095492166;
        Mon, 27 Nov 2023 06:31:32 -0800 (PST)
Received: from carrot.. (i60-34-119-11.s42.a014.ap.plala.or.jp. [60.34.119.11])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf51972586sm8302784pld.292.2023.11.27.06.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:31:31 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] nilfs2: Convert nilfs_page_bug() to nilfs_folio_bug()
Date:   Mon, 27 Nov 2023 23:30:36 +0900
Message-Id: <20231127143036.2425-18-konishi.ryusuke@gmail.com>
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

All callers have a folio now, so convert it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/btnode.c |  4 ++--
 fs/nilfs2/page.c   | 25 +++++++++++++------------
 fs/nilfs2/page.h   |  6 +++---
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 1204dd06ead8..0131d83b912d 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -190,7 +190,7 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 retry:
 		/* BUG_ON(oldkey != obh->b_folio->index); */
 		if (unlikely(oldkey != ofolio->index))
-			NILFS_PAGE_BUG(&ofolio->page,
+			NILFS_FOLIO_BUG(ofolio,
 				       "invalid oldkey %lld (newkey=%lld)",
 				       (unsigned long long)oldkey,
 				       (unsigned long long)newkey);
@@ -246,7 +246,7 @@ void nilfs_btnode_commit_change_key(struct address_space *btnc,
 	if (nbh == NULL) {	/* blocksize == pagesize */
 		ofolio = obh->b_folio;
 		if (unlikely(oldkey != ofolio->index))
-			NILFS_PAGE_BUG(&ofolio->page,
+			NILFS_FOLIO_BUG(ofolio,
 				       "invalid oldkey %lld (newkey=%lld)",
 				       (unsigned long long)oldkey,
 				       (unsigned long long)newkey);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 94e11bcee05b..5c2eba1987bd 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -150,29 +150,30 @@ bool nilfs_folio_buffers_clean(struct folio *folio)
 	return true;
 }
 
-void nilfs_page_bug(struct page *page)
+void nilfs_folio_bug(struct folio *folio)
 {
+	struct buffer_head *bh, *head;
 	struct address_space *m;
 	unsigned long ino;
 
-	if (unlikely(!page)) {
-		printk(KERN_CRIT "NILFS_PAGE_BUG(NULL)\n");
+	if (unlikely(!folio)) {
+		printk(KERN_CRIT "NILFS_FOLIO_BUG(NULL)\n");
 		return;
 	}
 
-	m = page->mapping;
+	m = folio->mapping;
 	ino = m ? m->host->i_ino : 0;
 
-	printk(KERN_CRIT "NILFS_PAGE_BUG(%p): cnt=%d index#=%llu flags=0x%lx "
+	printk(KERN_CRIT "NILFS_FOLIO_BUG(%p): cnt=%d index#=%llu flags=0x%lx "
 	       "mapping=%p ino=%lu\n",
-	       page, page_ref_count(page),
-	       (unsigned long long)page->index, page->flags, m, ino);
+	       folio, folio_ref_count(folio),
+	       (unsigned long long)folio->index, folio->flags, m, ino);
 
-	if (page_has_buffers(page)) {
-		struct buffer_head *bh, *head;
+	head = folio_buffers(folio);
+	if (head) {
 		int i = 0;
 
-		bh = head = page_buffers(page);
+		bh = head;
 		do {
 			printk(KERN_CRIT
 			       " BH[%d] %p: cnt=%d block#=%llu state=0x%lx\n",
@@ -258,7 +259,7 @@ int nilfs_copy_dirty_pages(struct address_space *dmap,
 
 		folio_lock(folio);
 		if (unlikely(!folio_test_dirty(folio)))
-			NILFS_PAGE_BUG(&folio->page, "inconsistent dirty state");
+			NILFS_FOLIO_BUG(folio, "inconsistent dirty state");
 
 		dfolio = filemap_grab_folio(dmap, folio->index);
 		if (unlikely(IS_ERR(dfolio))) {
@@ -268,7 +269,7 @@ int nilfs_copy_dirty_pages(struct address_space *dmap,
 			break;
 		}
 		if (unlikely(!folio_buffers(folio)))
-			NILFS_PAGE_BUG(&folio->page,
+			NILFS_FOLIO_BUG(folio,
 				       "found empty page in dat page cache");
 
 		nilfs_copy_folio(dfolio, folio, true);
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index 968b311d265b..7e1a2c455a10 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -37,7 +37,7 @@ struct buffer_head *nilfs_grab_buffer(struct inode *, struct address_space *,
 void nilfs_forget_buffer(struct buffer_head *);
 void nilfs_copy_buffer(struct buffer_head *, struct buffer_head *);
 bool nilfs_folio_buffers_clean(struct folio *);
-void nilfs_page_bug(struct page *);
+void nilfs_folio_bug(struct folio *);
 
 int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
@@ -49,7 +49,7 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 					    sector_t start_blk,
 					    sector_t *blkoff);
 
-#define NILFS_PAGE_BUG(page, m, a...) \
-	do { nilfs_page_bug(page); BUG(); } while (0)
+#define NILFS_FOLIO_BUG(folio, m, a...) \
+	do { nilfs_folio_bug(folio); BUG(); } while (0)
 
 #endif /* _NILFS_PAGE_H */
-- 
2.34.1

